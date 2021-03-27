DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `generateCLOName`(program_course_id SMALLINT) RETURNS char(6) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
RETURN (SELECT CONCAT('CLO-', CONVERT(LPAD(COUNT(cloId)+1, 2, 0), CHAR)) 
FROM systemclo WHERE programCourseId = program_course_id AND isDeleted = 0);
END$$
DELIMITER ;




DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `generatePEOName`(program_id TINYINT) RETURNS char(6) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	RETURN (SELECT CONCAT('PEO-', CONVERT(LPAD(COUNT(peoId)+1, 2, 0), CHAR))
    FROM peo WHERE programId = program_id);
END$$
DELIMITER ;





DELIMITER $$
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
END$$
DELIMITER ;





DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getCLOId`(clo_name CHAR(6), program_course_id SMALLINT) RETURNS mediumint(9)
    DETERMINISTIC
BEGIN
RETURN (SELECT cloId FROM systemclo WHERE 
programCourseId = program_course_id AND cloName = clo_name AND isDeleted = 0);
END$$
DELIMITER ;





DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getCLOToDelete`(clo_delete_id MEDIUMINT) RETURNS mediumint(9)
    DETERMINISTIC
BEGIN
RETURN (SELECT cloToDelete FROM clodelete WHERE 
cloDeleteIdPotential = clo_delete_id);
END$$
DELIMITER ;





DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getCLOToEdit`(clo_edit_id MEDIUMINT) RETURNS mediumint(9)
    DETERMINISTIC
BEGIN
RETURN (SELECT cloToEdit FROM cloedit WHERE cloEditIdPotential = clo_edit_id);
END$$
DELIMITER ;





CREATE DEFINER=`root`@`localhost` FUNCTION `getCourseId`(course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT) RETURNS smallint(6)
    DETERMINISTIC
BEGIN
	RETURN (SELECT `course`.`courseId` FROM `obe-as-a-service`.`course` WHERE
    `course`.`courseCode` = course_code AND 
    `course`.`courseName` = course_name AND
    `course`.`isPractical` = is_practical);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `getPLOofCLO`(clo_id MEDIUMINT) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
RETURN (SELECT ploId FROM systemclo WHERE cloId = clo_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `getProgramCourseId`(program_id TINYINT, course_id SMALLINT, batch_id SMALLINT) RETURNS smallint(6)
    DETERMINISTIC
BEGIN
RETURN (SELECT programCourseId FROM programCourseJunction WHERE 
programId = program_id AND courseId = course_id AND batchId = batch_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `getTaxonomyLevelId`(taxonomy_level_name VARCHAR(30), taxonomy_domain VARCHAR(20)) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
RETURN (SELECT taxonomyLevelId FROM taxonomylevel WHERE 
		taxonomyLevelName = taxonomy_level_name AND taxonomyId = (
		SELECT taxonomyId FROM taxonomydomain WHERE taxonomyDomain = taxonomy_domain));
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOAdditionApproved`(clo_id_potential MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isApproved FROM pendingcloadd WHERE 
cloIdPotential = clo_id_potential);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isUniqueSystemCLO`(taxonomy_level_id TINYINT, program_course_id SMALLINT, 
clo_description VARCHAR(500) ) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloId) = 0 FROM systemclo WHERE
taxonomyLevelId = taxonomy_level_id AND programCourseId = program_course_id 
AND cloDescription = clo_description AND isDeleted = 0);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isUniqueRequestedCLO`(taxonomy_level_id TINYINT, plo_id TINYINT, program_course_id SMALLINT, 
clo_description VARCHAR(500) ) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(pca.cloIdPotential) = 0 FROM 
pendingcloadd pca JOIN cloadd ca ON pca.cloIdPotential = ca.cloIdPotential
WHERE 
taxonomyLevelId = taxonomy_level_id AND 
ploId = plo_id AND 
cloDescription = clo_description AND 
programCourseId = program_course_id AND
isPending = 1);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isUniquePEODescription`(program_id SMALLINT, peo_description VARCHAR(500)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN ( SELECT peo_description NOT IN (
SELECT peoDescription FROM peo WHERE programId = program_id));
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isUniqueDeleteRequest`(clo_to_delete MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloDeleteIdPotential) = 0 FROM clodelete WHERE cloToDelete = clo_to_delete);
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




CREATE DEFINER=`root`@`localhost` FUNCTION `isProgramPassingCriteriaDefined`(program_id TINYINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	RETURN
    (SELECT COUNT(programId) FROM programpassingcrteria WHERE programId = program_id);
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




CREATE DEFINER=`root`@`localhost` FUNCTION `isProgramCLOPassingCriteriaCommitRequired`(program_id SMALLINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	RETURN 
	(SELECT isCommitRequired FROM programpassingcrteria WHERE programId = program_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isPEOAdditionCommitRequired`(program_id TINYINT, peo_name CHAR(6)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	RETURN (SELECT isCommitRequired FROM peo
    WHERE programId = program_id AND peoName = peo_name);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isEffectiveBatchCorrect`(batch_effective SMALLINT) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	RETURN (SELECT batch_effective > batchId FROM batch
    WHERE isCurrent = 1 ORDER BY batchId DESC LIMIT 1);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isDeletedCLO`(clo_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isDeleted FROM systemclo WHERE cloId = clo_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOPotentialIdCorrect`(clo_id_potential MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloIdPotential) = 1 FROM cloadd WHERE
cloIdPotential = clo_id_potential);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOEditIdCorrect`(clo_edit_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloEditIdPotential) = 1 FROM cloedit WHERE 
cloEditIdPotential = clo_edit_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOEditComitted`(clo_edit_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isCommited FROM pendingcloedit WHERE 
cloEditIdPotential = clo_edit_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOEditApproved`(clo_edit_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isApproved FROM pendingcloedit WHERE 
cloEditIdPotential = clo_edit_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOEditApproveByOBE`(obe_id SMALLINT, clo_edit_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloEditApproveId) = 1 FROM cloeditapprove WHERE 
cloEditIdPotential = clo_edit_id AND obeId = obe_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLODeletePotentialIdCorrect`(clo_id_potential MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloDeleteIdPotential) = 1 FROM clodelete WHERE
cloDeleteIdPotential = clo_id_potential);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLODeleteComitted`(clo_delete_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isCommited FROM pendingclodelete WHERE 
cloDeleteIdPotential = clo_delete_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLODeleteApproved`(clo_delete_id MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isApproved FROM pendingclodelete WHERE 
cloDeleteIdPotential = clo_delete_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLODeleteApproveByObe`(clo_id_potential MEDIUMINT, obe_id SMALLINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloDeleteApproveId) = 1 FROM clodeleteapprove WHERE 
cloDeleteIdPotential = clo_id_potential AND obeId = obe_id);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOAdditionComitted`(clo_id_potential MEDIUMINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT isCommited FROM pendingcloadd WHERE cloIdPotential = clo_id_potential);
END




CREATE DEFINER=`root`@`localhost` FUNCTION `isCLOAdditionApprovedByOBE`(clo_id_potential MEDIUMINT, obe_id SMALLINT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(cloAddApproveId) = 1 FROM cloaddapprove WHERE 
cloIdPotential = clo_id_potential AND obeId = obe_id);
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `approvePEOAddition`(program_id SMALLINT, obe_id SMALLINT, peo_description VARCHAR(500), plo_id TINYINT)
BEGIN
	# Procedure to add new PEO to Program
    DECLARE mappedPEO CHAR(6) DEFAULT ploIsMappedTo(program_id, plo_id);
    DECLARE new_peo_name CHAR (6) DEFAULT generatePEOName(program_id);
	
    IF mappedPEO IS NOT NULL THEN
		SELECT CONCAT("PLO-", plo_id, " is already mapped to ", mappedPEO) AS "Message",
        FALSE AS "Success";
	ELSE 
		INSERT INTO `obe-as-a-service`.`peo`
        (`ploid`,`programId`,`approvedBy`,`peoName`,`peoDescription`)
		VALUES (plo_id, program_id, obe_id, new_peo_name, peo_description);

		SELECT CONCAT("New PEO added as ", new_peo_name, ". Contact Admin for commit") AS "Message",
        TRUE AS "Success";
	END IF;
END