CREATE DEFINER=`root`@`localhost` PROCEDURE `addStudents`(program_id tinyint, batch_id smallint, section_name char(2), student_id mediumint, is_backloger bool, backloger_course_id smallint)
BEGIN
	declare section_verification boolean default sectionIdVerify(program_id, batch_id, section_name);
    declare student_verification boolean default studentIdVerify(student_id);
    declare batch_year tinyint default batchYear(batch_id);
    declare section_id smallint;
    declare record_exists boolean default isSectionStudentCourseRecordExisting(student_id);
    set section_id = (select sectionId from section where programId = program_id AND batchId = batch_id AND sectionName = section_name);
    if !section_verification then
		SELECT "This section does not exist" AS "Message", FALSE AS "Success";
	elseif !student_verification then
		SELECT "This student does not exist" AS "Message", FALSE AS "Success";
	elseif batch_year = 0 || batch_year = 1 then
		SELECT "you can only add students in current batch or upcoming batch" AS "Message", FALSE AS "Success";
	else
		if is_backloger then
			INSERT INTO `obe-as-a-service`.`sectionstudentcoursejunction`
			(`sectionId`, `studentId`, `courseId`) VALUES
			(section_id, student_id, backloger_course_id);
			SELECT "Student successfully added" AS "Message", TRUE AS "SUCCESS";
		else
			if record_exists then
				SELECT "Record of this student already exist" AS "Message", FALSE AS "Success";
			else
				Create Table temp(courseid smallint not null, sectionid smallint, studentid mediumint, primary key (courseid) );
				insert into temp(courseid)
				select courseId from programcoursejunction where programId = program_id AND batchId = batch_id;
				UPDATE temp SET sectionid = section_id where courseid != 0;
				UPDATE temp SET studentid = student_id where courseid != 0;
				INSERT INTO sectionstudentcoursejunction (sectionId, studentId, courseId)
				SELECT sectionId, studentId, courseid from temp;
                SELECT "Student successfully added" AS "Message", TRUE AS "SUCCESS";
				drop table temp;
			end if;
		end if;
	end if;
END