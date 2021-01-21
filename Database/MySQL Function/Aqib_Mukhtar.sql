CREATE DEFINER=`root`@`localhost` FUNCTION `generateSectionName`(counter TINYINT) RETURNS char(1) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	IF counter = 1 THEN RETURN "A";
    ELSEIF counter = 2 THEN RETURN "B";
    ELSEIF counter = 3 THEN RETURN "C";
    ELSEIF counter = 4 THEN RETURN "D";
    ELSEIF counter = 5 THEN RETURN "E";
    ELSEIF counter = 6 THEN RETURN "F";
    ELSEIF counter = 7 THEN RETURN "G";
    ELSEIF counter = 8 THEN RETURN "H";
    ELSEIF counter = 9 THEN RETURN "I";
    ELSEIF counter = 10 THEN RETURN "J";
    ELSEIF counter = 11 THEN RETURN "K";
    ELSEIF counter = 12 THEN RETURN "L";
    ELSEIF counter = 13 THEN RETURN "M";
    ELSEIF counter = 14 THEN RETURN "N";
    ELSEIF counter = 15 THEN RETURN "O";
    ELSEIF counter = 16 THEN RETURN "P";
    ELSEIF counter = 17 THEN RETURN "Q";
    ELSEIF counter = 18 THEN RETURN "R";
    ELSEIF counter = 19 THEN RETURN "S";
    ELSEIF counter = 20 THEN RETURN "T";
    ELSEIF counter = 21 THEN RETURN "U";
    ELSEIF counter = 22 THEN RETURN "V";
    ELSEIF counter = 23 THEN RETURN "W";
    ELSEIF counter = 24 THEN RETURN "X";
    ELSEIF counter = 25 THEN RETURN "Y";
    ELSEIF counter = 26 THEN RETURN "Z";
    END IF;
END




CREATE DEFINER=`root`@`localhost` FUNCTION `getCourseId`(course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT) RETURNS smallint(6)
    DETERMINISTIC
BEGIN
	RETURN (SELECT `course`.`courseId` FROM `obe-as-a-service`.`course` WHERE
    `course`.`courseCode` = course_code AND 
    `course`.`courseName` = course_name AND
    `course`.`isPractical` = is_practical);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isEffectiveBatchCorrect`(batch_effective SMALLINT) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE result TINYINT DEFAULT NULL;
	SET result = (SELECT COUNT(batchId) FROM batch WHERE 
    batch_effective > (SELECT batchId FROM batch WHERE isCurrent = 1) AND
    batch_effective = batchId);
	RETURN result;
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isProgramHasCourse`(program_id TINYINT, batch_id SMALLINT,
course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE result TINYINT DEFAULT NULL;
    DECLARE course_in_program TINYINT DEFAULT NULL;
    
	SET result = getCourseId(course_code, course_name, is_practical);
    
    IF result IS NULL THEN
		RETURN 1; # Course doesnot exist
	ELSE
		SET course_in_program = (SELECT COUNT(programCourseId) 
        FROM programcoursejunction WHERE 
        programId = program_id AND courseId = result AND batchId = batch_id);
        
        IF course_in_program = 0 THEN
			RETURN 3; # Program and batch doesnot have course
		ELSE
			RETURN 2; # Program and batch already has course
		END IF;
	END IF;
END



CREATE DEFINER=`root`@`localhost` FUNCTION `isUniqueCourse`(course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE result TINYINT DEFAULT NULL;
	SET result = 
    (SELECT COUNT(*) FROM course WHERE 
    courseCode = course_code AND 
    courseName = course_name AND 
    isPractical = is_practical);
    
    IF result = 0 THEN 
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
    
END