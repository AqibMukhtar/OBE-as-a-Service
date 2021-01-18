CREATE DEFINER=`root`@`localhost` PROCEDURE `mapCourseToProgram`(program_id TINYINT, batch_effective SMALLINT, 
course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT)
BEGIN
	DECLARE program_has_course_result TINYINT DEFAULT isProgramHasCourse(program_id, course_code, course_name, is_practical);
	DECLARE course_id_result SMALLINT DEFAULT getCourseId(course_code, course_name, is_practical);
    DECLARE batch_correctness_result TINYINT DEFAULT isEffectiveBatchCorrect(batch_effective);
    
   IF batch_correctness_result != 1 THEN
		SELECT "You can only assign courses to upcomming batches"
        AS "Message", FALSE AS "Success";
   ELSEIF program_has_course_result = 1 THEN
		SELECT CONCAT
        ("Course Code: ", course_code, " Course Name: ", 
        course_name, " is_practical: ", is_practical, " doesnot exist in university")
        AS "Message", FALSE AS "Success";
	ELSEIF program_has_course_result = 2 THEN
		SELECT CONCAT
        ("Course Code: ", course_code, " Course Name: ", 
        course_name, " is_practical: ", is_practical, " is already in your program") 
        AS "Message", FALSE AS "Success";
	ELSEIF program_has_course_result = 3 THEN
		INSERT INTO `obe-as-a-service`.`programcoursejunction`
		(`programId`, `courseId`, `startBatch`) VALUES
		(program_id, course_id_result, batch_effective);
        SELECT "Course successfully added" AS "MEssage", TRUE AS "SUCCESS"; 
	END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSectionsOfProgram`(program_id TINYINT, required_batch SMALLINT, no_of_sections TINYINT)
BEGIN
	DECLARE batch_validity TINYINT DEFAULT NULL;
    DECLARE counter TINYINT DEFAULT 1;
    
    SET batch_validity = isEffectiveBatchCorrect(required_batch);
    
    IF batch_validity != 1 THEN
		SELECT "You can only assign courses to upcomming batches"
        AS "Message", FALSE AS "Success";
	ELSEIF no_of_sections <= 0 OR no_of_sections > 26 THEN
		SELECT "Numebr of sections must be atleast 1 and atmost 26"
        AS "Message", FALSE AS "Success";
	ELSE
		DELETE FROM `obe-as-a-service`.`section`
        WHERE programId = program_id AND batchId = required_batch;

		WHILE counter <= no_of_sections DO
			INSERT INTO `obe-as-a-service`.`section` 
            (`programId`, `batchId`, `sectionName`) VALUES
			(program_id, required_batch, generateSectionName(counter));
            SET counter = counter + 1;
        END WHILE;
    END IF;
END