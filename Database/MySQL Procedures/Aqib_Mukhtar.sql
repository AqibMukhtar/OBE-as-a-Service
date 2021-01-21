CREATE DEFINER=`root`@`localhost` PROCEDURE `mapCourseToProgram`(program_id TINYINT, batch_effective SMALLINT, 
course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT)
BEGIN
	DECLARE program_has_course_result TINYINT DEFAULT isProgramHasCourse(program_id, batch_effective, course_code, course_name, is_practical);
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
        course_name, " is_practical: ", is_practical, " is already in your program and given batch") 
        AS "Message", FALSE AS "Success";
	ELSEIF program_has_course_result = 3 THEN
		INSERT INTO `obe-as-a-service`.`programcoursejunction`
		(`programId`, `courseId`, `batchId`) VALUES
		(program_id, course_id_result, batch_effective);
        
        call updateCourseMappingToSections(program_id, batch_effective,
        FALSE, TRUE, FALSE, LAST_INSERT_ID(), NULL);
        
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
        
        call updateCourseMappingToSections(program_id, required_batch, 
        TRUE, FALSE, FALSE, NULL, NULL);
        
        SELECT "Sections and Course assignment completed successfully" 
        AS "Message", TRUE AS "Success";
    END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCourseMappingToSections`(program_id TINYINT, batch_id SMALLINT, 
is_section_update BOOLEAN, is_course_mapped BOOLEAN, is_course_unmapped BOOLEAN,
program_course_id SMALLINT, course_id SMALLINT)
BEGIN
	IF is_section_update = TRUE THEN
		SET SQL_SAFE_UPDATES = 0;
		DELETE FROM sectionteachercoursejunction WHERE sectionId IN
		(SELECT sectionId FROM section WHERE programId = program_id 
        AND batchId = batch_id);
		SET SQL_SAFE_UPDATES = 1;
        
        INSERT INTO sectionteachercoursejunction (sectionId, courseId)
		SELECT sectionId, courseId FROM section s JOIN programcoursejunction c WHERE 
		s.programId = program_id AND s.batchId = batch_id AND
        c.programId = program_id AND c.batchId = batch_id;
    
    ELSEIF is_course_mapped = TRUE THEN
		
        INSERT INTO sectionteachercoursejunction (sectionId, courseId)
		SELECT sectionId, courseId FROM section s JOIN programcoursejunction c WHERE 
		s.programId = program_id AND programCourseId = program_course_id;
	
    ELSEIF is_course_unmapped = TRUE THEN
		
        DELETE FROM `obe-as-a-service`.`sectionteachercoursejunction`
		WHERE `sectionteachercoursejunction`.`sectionId` IN 
        (SELECT sectionId FROM section WHERE programId = program_id 
        AND batchId = batch_id) AND 
        `sectionteachercoursejunction`.`courseId` = course_id;
	
    END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `unmapCourseToProgram`(program_id TINYINT, batch_id SMALLINT, 
course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT)
BEGIN
	DECLARE program_has_course_result TINYINT DEFAULT isProgramHasCourse(program_id, batch_id, course_code, course_name, is_practical);
	DECLARE batch_correctness_result TINYINT DEFAULT isEffectiveBatchCorrect(batch_id);
    DECLARE course_id_result SMALLINT DEFAULT getCourseId(course_code, course_name, is_practical);
    
    IF batch_correctness_result != 1 THEN
		SELECT "You can only assign courses to upcomming batches"
        AS "Message", FALSE AS "Success";
	ELSEIF program_has_course_result = 1 THEN
		SELECT CONCAT
        ("Course Code: ", course_code, " Course Name: ", 
        course_name, " is_practical: ", is_practical, " doesnot exist in university")
        AS "Message", FALSE AS "Success";
	ELSEIF program_has_course_result = 3 THEN
		SELECT CONCAT
        ("Course Code: ", course_code, " Course Name: ", 
        course_name, " is_practical: ", is_practical, " doesnot exist for your program and given batch") 
        AS "Message", FALSE AS "Success";
	ELSEIF program_has_course_result = 2 THEN
		DELETE FROM `obe-as-a-service`.`programcoursejunction`
		WHERE `programcoursejunction`.`programId` = program_id AND 
        `programcoursejunction`.`batchId` = batch_id AND 
        `programcoursejunction`.`courseId` = course_id_result;
        
        CALL updateCourseMappingToSections(program_id, batch_id, FALSE, FALSE, TRUE, NULL, course_id_result);
        SELECT "Course successfully removed" AS "Message", TRUE AS "Success";
	END IF;
END