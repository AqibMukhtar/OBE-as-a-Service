CREATE DEFINER=`root`@`localhost` PROCEDURE `addStudents`(program_id tinyint, batch_id smallint, section_name char(2), student_id mediumint)
BEGIN
	declare section_verification boolean default sectionIdVerify(program_id, batch_id, section_name);
    declare student_verification boolean;
	declare section_id smallint;
    declare batch_year tinyint default batchYear(batch_id);
    declare record_exists boolean default isSectionStudentCourseRecordExisting(student_id);
    set section_id = (select sectionId from section where programId = program_id AND batchId = batch_id AND sectionName = section_name);
    set student_verification = studentIdVerify(student_id, program_id, section_id);
    if !section_verification then
		SELECT "This section does not exist" AS "Message", FALSE AS "Success";
	elseif !student_verification then
		SELECT "This student does not exist" AS "Message", FALSE AS "Success";
	elseif batch_year != 1 then
		SELECT "you can only add students of current batch" AS "Message", FALSE AS "Success";
	elseif record_exists then
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
END









CREATE DEFINER=`root`@`localhost` PROCEDURE `addTeachers`(program_id tinyint, batch_id smallint, section_name char(2), teacher_id mediumint, course_id smallint)
BEGIN
declare section_verification boolean default sectionIdVerify(program_id, batch_id, section_name);
declare teacher_verification boolean default teacherIdVerify(teacher_id, program_id);
declare batch_year tinyint default batchYear(batch_id);
declare section_id smallint;
declare record_exists boolean;
declare is_completed boolean;
set section_id = (select sectionId from section where programId = program_id AND batchId = batch_id AND sectionName = section_name);
set record_exists = isSectionteacherCourseRecordExisting(section_id, teacher_id, course_id);
set is_completed = (select isCompleted from sectionteachercoursejunction where sectionId = section_id and courseId = course_id);
if batch_year < 0 or batch_year > 4 then
    SELECT "you can only assign teachers to batches currently studying in University" AS "Message", FALSE AS "Success";
elseif !teacher_verification then
	SELECT "This teacher does not exist" AS "Message", FALSE AS "Success";
elseif record_exists then
	SELECT "This record already exists" AS "Message", FALSE AS "Success";
elseif is_completed then
	select "You cannot update this record" as "message", false as "Success";
elseif !section_verification then
	select "This section doesnot exist" as "message", false as "Success";
else
	UPDATE sectionteachercoursejunction SET teacherId = teacher_id WHERE sectionId = section_id AND courseId = course_id;
	select "successfully updated record" as "message", true as "Success";
end if;
END









CREATE DEFINER=`root`@`localhost` PROCEDURE `addBacklogerStudent`(from_program_id tinyint, to_program_id tinyint, from_batch_id smallint, to_batch_id smallint, from_section_name char(2), to_section_name char(2), backloger_student_id mediumint, course_code char(8), course_name varchar(60), is_practical tinyint)
BEGIN
	declare from_section_verification boolean default sectionIdVerify(from_program_id, from_batch_id, from_section_name);
    declare to_section_verification boolean default sectionIdVerify(to_program_id, to_batch_id, to_section_name);
    declare course_verification boolean;
    declare student_verification boolean;
	declare from_section_id smallint;
    declare to_section_id smallint;
    declare to_batch_year tinyint default batchYear(to_batch_id);
    declare record_exists boolean;
    declare course_id smallint;
    set course_id = (select courseId from course where courseCode = course_code and courseName = course_name and isPractical = is_practical);
    set course_verification = courseIdVerify(course_id , to_program_id, to_batch_id);
    set from_section_id = (select sectionId from section where programId = from_program_id AND batchId = from_batch_id AND sectionName = from_section_name);
    set to_section_id = (select sectionId from section where programId = to_program_id AND batchId = to_batch_id AND sectionName = to_section_name);
    set student_verification = studentIdVerify(backloger_student_id, from_program_id, from_section_id);
    set record_exists = isSectionStudentCourseRecordExistingBackloger(to_section_id, backloger_student_id, course_id);
    if !to_section_verification or !from_section_verification then
		SELECT "This section does not exist" AS "Message", FALSE AS "Success";
	elseif !student_verification then
		SELECT "This student does not exist" AS "Message", FALSE AS "Success";
	elseif to_batch_year > 4 or to_batch_year < 1 then
		SELECT "you can only add students to current batch" AS "Message", FALSE AS "Success";
	elseif record_exists then
		SELECT "Record of this student already exist" AS "Message", FALSE AS "Success";
	elseif !course_verification then
		select "this course doesnot exist" AS "Message", FALSE AS "Success";
    else
		INSERT INTO `obe-as-a-service`.`sectionstudentcoursejunction`
		(`sectionId`, `studentId`, `courseId`) VALUES
		(to_section_id, backloger_student_id, course_id);
		SELECT "Student successfully added" AS "Message", TRUE AS "SUCCESS";
    end if;
END









CREATE DEFINER=`root`@`localhost` PROCEDURE `addCodStudent`(from_program_id tinyint, to_program_id tinyint, from_batch_id smallint, to_batch_id smallint, from_section_name char(2), to_section_name char(2), cod_student_id mediumint)
BEGIN
	declare from_section_verification boolean default sectionIdVerify(from_program_id, from_batch_id, from_section_name);
    declare to_section_verification boolean default sectionIdVerify(to_program_id, to_batch_id, to_section_name);
	declare to_batch_year tinyint default batchYear(to_batch_id);
    declare from_batch_year tinyint default batchYear(from_batch_id);
    declare student_verification boolean;
	declare from_section_id smallint;
    declare to_section_id smallint;
    declare record_exists boolean;
    set from_section_id = (select sectionId from section where programId = from_program_id AND batchId = from_batch_id AND sectionName = from_section_name);
    set to_section_id = (select sectionId from section where programId = to_program_id AND batchId = to_batch_id AND sectionName = to_section_name);
    set student_verification = studentIdVerify(cod_student_id, from_program_id, from_section_id);
	set record_exists = isSectionStudentCourseRecordExistingCod(cod_student_id, to_section_id);
    if !to_section_verification or !from_section_verification then
		SELECT "This section does not exist" AS "Message", FALSE AS "Success";
	elseif !student_verification then
		SELECT "This student does not exist" AS "Message", FALSE AS "Success";
	elseif to_batch_year !=2 then
		SELECT "you can only add COD students to 2nd year" AS "Message", FALSE AS "Success";
    elseif from_batch_year !=2 then
		SELECT "you can only add COD students of 2nd year" AS "Message", FALSE AS "Success";    
	elseif record_exists then
		SELECT "Record of this student already exist" AS "Message", FALSE AS "Success";
	else
		Create Table temp(courseid smallint not null, sectionid smallint, studentid mediumint, primary key (courseid) );
		insert into temp(courseid)
		select courseId from programcoursejunction where programId = to_program_id AND batchId = to_batch_id;
		UPDATE temp SET studentid = cod_student_id where courseid != 0;
		UPDATE temp SET sectionid = to_section_id where courseid != 0;
		INSERT INTO sectionstudentcoursejunction (sectionId, studentId, courseId)
		SELECT sectionId, studentId, courseid from temp;
		SELECT "Student successfully added" AS "Message", TRUE AS "SUCCESS";
		drop table temp;
    end if;
END









CREATE DEFINER=`root`@`localhost` PROCEDURE `addCodEquivalentCourse`(from_program_id tinyint, to_program_id tinyint, from_batch_id smallint, to_batch_id smallint, from_section_name char(2), to_section_name char(2), cod_student_id mediumint, from_course_code char(8), to_course_code char(8), from_course_name varchar(60), to_course_name varchar(60), from_is_practical tinyint, to_is_practical tinyint)
BEGIN
	declare from_section_verification boolean default sectionIdVerify(from_program_id, from_batch_id, from_section_name);
    declare to_section_verification boolean default sectionIdVerify(to_program_id, to_batch_id, to_section_name);
    declare from_course_verification boolean;
    declare to_course_verification boolean;
    declare student_verification boolean;
	declare from_section_id smallint;
    declare to_section_id smallint;
    declare to_batch_year tinyint default batchYear(to_batch_id);
    declare from_course_id smallint;
    declare to_course_id smallint;
    declare course_completion_verification boolean;
    declare from_record_existing boolean;
    declare to_record_existing boolean;
    set from_course_id = (select courseId from course where courseCode = from_course_code and courseName = from_course_name and isPractical = from_is_practical);
    set to_course_id = (select courseId from course where courseCode = to_course_code and courseName = to_course_name and isPractical = to_is_practical);
    set from_course_verification = courseIdVerify(from_course_id , from_program_id, from_batch_id);
    set to_course_verification = courseIdVerify(to_course_id , to_program_id, to_batch_id);
    set from_section_id = (select sectionId from section where programId = from_program_id AND batchId = from_batch_id AND sectionName = from_section_name);
    set to_section_id = (select sectionId from section where programId = to_program_id AND batchId = to_batch_id AND sectionName = to_section_name);
    set student_verification = studentIdVerify(cod_student_id, from_program_id, from_section_id);
    set course_completion_verification = isCourseCompleted(from_section_id, cod_student_id, from_course_id);
    set from_record_existing = isSectionStudentCourseRecordExistingBackloger(from_section_id, cod_student_id, from_course_id);
    set to_record_existing = isSectionStudentCourseRecordExistingBackloger(to_section_id, cod_student_id, to_course_id);
    if !to_section_verification or !from_section_verification then
		SELECT "This section does not exist" AS "Message", FALSE AS "Success";
	elseif !course_completion_verification then
		SELECT "This course is not completed" AS "Message", FALSE AS "Success";
	elseif !student_verification then
		SELECT "This student does not exist" AS "Message", FALSE AS "Success";
	elseif to_batch_year > 4 or to_batch_year < 1 then
		SELECT "you can only add students to current batch" AS "Message", FALSE AS "Success";
	elseif !from_course_verification or !to_course_verification then
		select "this course doesnot exist" AS "Message", FALSE AS "Success";
	elseif !from_record_existing or !to_record_existing then
		select "this record doesnot exist" AS "Message", FALSE AS "Success";
    else
		UPDATE sectionstudentcoursejunction SET isCompleted = 1 WHERE sectionId = to_section_id AND courseId = to_course_id AND studentId = cod_student_id;
		select "successfully updated record" as "message", true as "Success";
    end if;
END