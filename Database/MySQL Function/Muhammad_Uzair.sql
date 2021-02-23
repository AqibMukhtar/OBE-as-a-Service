CREATE DEFINER=`root`@`localhost` FUNCTION `batchYear`(batch_id smallint) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
declare current_batch smallint;
declare batch_year tinyint;
set current_batch = (select batchId from batch where isCurrent = 1 order by batchId desc limit 1);
set batch_year = current_batch - batch_id + 1;
Return batch_year;
END









CREATE DEFINER=`root`@`localhost` FUNCTION `isSectionStudentCourseRecordExisting`(student_id mediumint) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	declare is_record_existing tinyint default (select count(sectionStudentcourseId) from sectionstudentcoursejunction where studentId = student_id);
	return is_record_existing;
END









CREATE DEFINER=`root`@`localhost` FUNCTION `sectionIdVerify`(program_id tinyint, batch_id smallint, section_name char(2)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
declare is_section_id_present boolean;
set is_section_id_present = (select count(sectionId) from section where programId = program_id AND batchId = batch_id AND sectionName = section_name );
RETURN is_section_id_present;
END









CREATE DEFINER=`root`@`localhost` FUNCTION `studentIdVerify`(student_id mediumint, program_id tinyint, section_id smallint) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
declare is_student_id_present boolean;
set is_student_id_present = (select count(studentId) from student where studentId = student_id and programId = program_id and sectionId = section_id );
RETURN is_student_id_present;
END