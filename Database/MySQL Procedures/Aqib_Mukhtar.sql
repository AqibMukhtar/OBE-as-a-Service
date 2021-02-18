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




CREATE DEFINER=`root`@`localhost` PROCEDURE `addCLOApproveByObe`(clo_id_potential MEDIUMINT, obe_id SMALLINT)
BEGIN
	DECLARE is_clo_id_potential_correct BOOLEAN DEFAULT
    isCLOPotentialIdCorrect(clo_id_potential);
    
    DECLARE is_clo_approved BOOLEAN DEFAULT
    isCLOAdditionApprovedByOBE(clo_id_potential, obe_id);
    
    IF is_clo_id_potential_correct = FALSE THEN
		SELECT "Given requested CLO doesnot exist" AS "Message", FALSE AS "Success";
	ELSEIF is_clo_approved = TRUE THEN
		SELECT "You have already approved this suggested CLO" AS "Message", FALSE AS "Success";
	ELSE
		INSERT INTO `obe-as-a-service`.`cloaddapprove` (`cloIdPotential`,`obeId`)
		VALUES (clo_id_potential, obe_id);
        
        UPDATE `obe-as-a-service`.`pendingcloadd` SET `isApproved` = 1
		WHERE `cloIdPotential` = clo_id_potential;
        
        SELECT "New CLO is approved. Waiting for commit by Admin" AS "Message",
        TRUE AS "Success";
    END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `addCLOCommitByAdmin`(clo_id_potential MEDIUMINT, admin_id SMALLINT)
BEGIN
	DECLARE is_clo_potential_id_correct BOOLEAN DEFAULT
    isCLOPotentialIdCorrect(clo_id_potential);
    
	DECLARE is_clo_addition_approved BOOLEAN DEFAULT
    isCLOAdditionApproved(clo_id_potential);
    
    DECLARE is_clo_add_comitted BOOLEAN DEFAULT
    isCLOAdditionComitted(clo_id_potential);
    
    IF is_clo_potential_id_correct = FALSE THEN
		SELECT "Given requested CLO doesnot exist" AS "Message", FALSE AS "Success";
	ELSEIF is_clo_addition_approved = FALSE THEN
		SELECT "The given CLO must be approved by atleast one OBE Cell member to get comitted" AS "Message", FALSE AS "Success";
	ELSEIF is_clo_add_comitted = TRUE THEN
		SELECT "The CLO is already commited into the system" AS "Message", FALSE AS "Success";
    ELSE
		UPDATE `obe-as-a-service`.`pendingcloadd` SET 
        `isPending` = 0, `isCommited` = 1 WHERE 
        `cloIdPotential` = clo_id_potential;
        
        INSERT INTO `obe-as-a-service`.`systemclo`
		(`cloId`, `taxonomyLevelId`, `ploId`, `programCourseId`, `cloName`, `cloDescription`)
		SELECT c.cloIdPotential, taxonomyLevelId, ploId, programCourseId, generateCLOName(programCourseId),
        cloDescription FROM pendingcloadd p JOIN cloadd c 
        ON p.cloIdPotential = c.cloIdPotential AND c.cloIdPotential = clo_id_potential;
        
        INSERT INTO `obe-as-a-service`.`cloaddcommit`
		(`cloIdPotential`, `adminId`) VALUES (clo_id_potential, admin_id);
        
        SELECT "CLO has been comitted into the system" AS "Message",
        TRUE AS "Success";

	END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `addCLORequestByObeCell`(program_id TINYINT, obe_id SMALLINT,
course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT, batch_id SMALLINT,
taxonomy_domain VARCHAR(20), taxonomy_level_name VARCHAR(30), plo_id TINYINT,
clo_description VARCHAR(500), additional_notes VARCHAR(1000))
BEGIN
	DECLARE course_id SMALLINT DEFAULT
    getCourseId(course_code, course_name, is_practical);
    
    DECLARE is_batch_id_correct SMALLINT DEFAULT
    isEffectiveBatchCorrect(batch_id);
    
    DECLARE taxonomy_level_id TINYINT DEFAULT 
    getTaxonomyLevelId(taxonomy_level_name, taxonomy_domain);
    
    DECLARE program_course_id SMALLINT DEFAULT
    getProgramCourseId(program_id, course_id, batch_id);
    
    DECLARE is_unique_system_clo BOOLEAN DEFAULT
    isUniqueSystemCLO(taxonomy_level_id, plo_id, program_course_id, clo_description);
    
    DECLARE is_unique_pending_clo BOOLEAN DEFAULT
    isUniqueRequestedCLO(taxonomy_level_id, plo_id, program_course_id, clo_description);
    
    IF course_id IS NULL THEN
		SELECT "Course doesnot exist" AS "MEssage", FALSE AS "Success";
	ELSEIF is_batch_id_correct = FALSE THEN
		SELECT "You can only assign new CLO to upcomming batches" AS "MEssage", FALSE AS "Success";
    ELSEIF taxonomy_level_id IS NULL THEN
		SELECT CONCAT("Taxonomy domain: ", taxonomy_domain, " and level: ", taxonomy_level_name, " mistach") AS "MEssage", FALSE AS "Success";
    ELSEIF program_course_id IS NULL THEN 
		SELECT "This course is not part of your program" AS "MEssage", FALSE AS "Success";
    ELSEIF is_unique_system_clo = FALSE THEN
		SELECT "The CLO which you are trying to add, already exist for given batch and course" AS "MEssage", FALSE AS "Success";
	ELSEIF is_unique_pending_clo = FALSE THEN
		SELECT "The CLO which you are trying to add, is already requested" AS "MEssage", FALSE AS "Success";
    ELSE
		INSERT INTO `obe-as-a-service`.`cloadd`
        (`obecellIdSuggestor`, `programCourseId`) VALUES 
        (obe_id, program_course_id);
        
        INSERT INTO `obe-as-a-service`.`pendingcloadd`
		(`cloIdPotential`, `taxonomyLevelId`, `ploId`,`cloDescription`,
		`additionalNotes`, `isPending`, `isApproved`, `isCommited`) VALUES
		(LAST_INSERT_ID(), taxonomy_level_id, plo_id, clo_description,
		additional_notes, 1, 0, 0);
        
        call addCLOApproveByObe(LAST_INSERT_ID(), obe_id);
	END IF;

END




CREATE DEFINER=`root`@`localhost` PROCEDURE `addCLORequestByTeacher`(program_id TINYINT, teacher_id SMALLINT,
course_code CHAR(8), course_name VARCHAR(60), is_practical TINYINT, batch_id SMALLINT,
taxonomy_domain VARCHAR(20), taxonomy_level_name VARCHAR(30), plo_id TINYINT,
clo_description VARCHAR(500), additional_notes VARCHAR(1000))
BEGIN
	DECLARE course_id SMALLINT DEFAULT
    getCourseId(course_code, course_name, is_practical);
    
    DECLARE is_batch_id_correct SMALLINT DEFAULT
    isEffectiveBatchCorrect(batch_id);
    
    DECLARE taxonomy_level_id TINYINT DEFAULT 
    getTaxonomyLevelId(taxonomy_level_name, taxonomy_domain);
    
    DECLARE program_course_id SMALLINT DEFAULT
    getProgramCourseId(program_id, course_id, batch_id);
    
    DECLARE is_unique_system_clo BOOLEAN DEFAULT
    isUniqueSystemCLO(taxonomy_level_id, plo_id, program_course_id, clo_description);
    
    DECLARE is_unique_pending_clo BOOLEAN DEFAULT
    isUniqueRequestedCLO(taxonomy_level_id, plo_id, program_course_id, clo_description);
    
    IF course_id IS NULL THEN
		SELECT "Course doesnot exist" AS "MEssage", FALSE AS "Success";
	ELSEIF is_batch_id_correct = FALSE THEN
		SELECT "You can only assign new CLO to upcomming batches" AS "MEssage", FALSE AS "Success";
    ELSEIF taxonomy_level_id IS NULL THEN
		SELECT CONCAT("Taxonomy domain: ", taxonomy_domain, " and level: ", taxonomy_level_name, " mistach") AS "MEssage", FALSE AS "Success";
    ELSEIF program_course_id IS NULL THEN 
		SELECT "This course is not part of your program" AS "MEssage", FALSE AS "Success";
    ELSEIF is_unique_system_clo = FALSE THEN
		SELECT "The CLO which you are trying to add, already exist for given batch and course" AS "MEssage", FALSE AS "Success";
	ELSEIF is_unique_pending_clo = FALSE THEN
		SELECT "The CLO which you are trying to add, is already requested" AS "MEssage", FALSE AS "Success";
    ELSE
		INSERT INTO `obe-as-a-service`.`cloadd`
        (`teacherIdSuggestor`, `programCourseId`) VALUES 
        (teacher_id, program_course_id);
        
        INSERT INTO `obe-as-a-service`.`pendingcloadd`
		(`cloIdPotential`, `taxonomyLevelId`, `ploId`,`cloDescription`,
		`additionalNotes`, `isPending`, `isApproved`, `isCommited`) VALUES
		(LAST_INSERT_ID(), taxonomy_level_id, plo_id, clo_description,
		additional_notes, 1, 0, 0);
        
        SELECT "You request to add new CLO is now pending" AS "Message", TRUE AS "Success";

	END IF;

END




CREATE DEFINER=`root`@`localhost` PROCEDURE `approvePEOAddition`(program_id SMALLINT, obe_id SMALLINT, peo_description VARCHAR(500), plo_id TINYINT)
BEGIN
	# Procedure to add new PEO to Program
	DECLARE is_unique_peo_description BOOLEAN DEFAULT 
    isUniquePEODescription(program_id, peo_description);
    
    DECLARE new_peo_name CHAR(6) DEFAULT generatePEOName(program_id);
    
    IF is_unique_peo_description = FALSE THEN
		SELECT "PEO Description already exists for your program" AS "Message",
        FALSE AS "Success";
	ELSE 
		INSERT INTO `obe-as-a-service`.`peo`
        (`ploid`,`programId`,`approvedBy`,`peoName`,`peoDescription`)
		VALUES (plo_id, program_id, obe_id, new_peo_name, peo_description);

		SELECT CONCAT("New PEO added as ", new_peo_name, ". Contact Admin for commit") AS "Message",
        TRUE AS "Success";
	END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `approveProgramCLOPassingCriteria`(program_id TINYINT, passing_criteria_id TINYINT, obe_id SMALLINT)
BEGIN
	DECLARE is_passing_criteria_defined BOOLEAN DEFAULT
    isProgramPassingCriteriaDefined(program_id);
    IF is_passing_criteria_defined = TRUE THEN
		UPDATE `obe-as-a-service`.`programpassingcrteria` SET
		`passingCriteriaId` = passing_criteria_id, `approvedBy` = obe_id,
		`commitedBy` = NULL, `isCommitRequired` = 1, `isDeleteRequired` = 0
		WHERE `programId` = program_id;
        
        SELECT "Passing Criteria has been updated. Contact Admin to commit changes"
        AS "Message", TRUE AS "Success";
    ELSE
		INSERT INTO `obe-as-a-service`.`programpassingcrteria`
		(`programId`, `passingCriteriaId`, `approvedBy`, 
        `commitedBy`, `isCommitRequired`, `isDeleteRequired`)
		VALUES
		(program_id, passing_criteria_id, obe_id, NULL, 1, 0);

		SELECT "Passing Criteria has been updated. Contact Admin to commit changes"
        AS "Message", TRUE AS "Success";
    END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `commitPEOAddition`(program_id TINYINT, admin_id SMALLINT, peo_name CHAR(6))
BEGIN
	DECLARE peo_addition_commit_required BOOLEAN DEFAULT
    isPEOAdditionCommitRequired(program_id, peo_name);
    
    IF peo_addition_commit_required IS NULL THEN
		SELECT CONCAT(peo_name, " doesnot exist") AS "Messsage", FALSE AS "Success";
    ELSEIF peo_addition_commit_required = FALSE THEN
		SELECT CONCAT(peo_name, " is already commited") AS "Messsage", FALSE AS "Success";
    ELSE
		UPDATE `obe-as-a-service`.`peo` SET `committedBy` = admin_id,
		`isCommitRequired` = 0 WHERE 
        `programId` = program_id AND `peoName` = peo_name;
        SELECT CONCAT(peo_name, " commited") AS "Messsage", TRUE AS "Success";

    END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `commitProgramCLOPassingCriteria`(program_id SMALLINT, admin_id SMALLINT)
BEGIN
	DECLARE is_passing_criteria_defined BOOLEAN DEFAULT
    isProgramPassingCriteriaDefined(program_id);
    
    DECLARE is_commit_required BOOLEAN DEFAULT
    isProgramCLOPassingCriteriaCommitRequired(program_id);
    
    DECLARE passing_criteria VARCHAR(20) DEFAULT(
    SELECT passingCriteriaName FROM PassingCriteria WHERE passingCriteriaId = 
    (SELECT passingCriteriaId FROM programpassingcrteria WHERE programId = program_id));
    
    IF is_passing_criteria_defined = FALSE THEN
		SELECT "No passing criteria update by OBE Cell" AS "Message", FALSE AS "Success";
	ELSEIF is_commit_required = FALSE THEN
		SELECT "No commit required" AS "Message", FALSE AS "Success";
	ELSE
		UPDATE `obe-as-a-service`.`programpassingcrteria`SET
		`commitedBy` = admin_id, `isCommitRequired` = 0
        WHERE `programId` = program_id;
        
        SELECT CONCAT("CLO Passing Criteria commited as ", passing_criteria) 
        AS "Message", FALSE AS "Success";
	END IF;

END