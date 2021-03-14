CREATE DEFINER=`root`@`localhost` FUNCTION `isBatchCourseCloValidObtainedMarks`(
program_Name varchar(50), 
course_Id smallint,
batch_Id smallint,
clo_Name char(6),
tool_Id smallint,
section_Teacher_Course_Id int
) RETURNS int
    DETERMINISTIC
BEGIN

declare calProgramId tinyint;
declare calPrgramCourseId smallint;
declare calCloId mediumint;
declare getExistingCloId smallint;

set calProgramId=(select programId from program where programName=program_Name);
set calPrgramCourseId=(select programCourseId from programcoursejunction
where (programId=calProgramId AND courseId=course_Id AND batchId=batch_Id));

set getExistingCloId=(select cloId from assignedtoolclosessional where 
toolId=tool_Id AND sectionTeacherCourseId=section_Teacher_Course_Id);
set calCloId=(select cloId from systemclo 
where programCourseId=calPrgramCourseId AND cloName=clo_Name and isDeleted=0);
if(calCloId=getExistingCloId) then return calCloId;
else
return 0;
end if;
END














CREATE DEFINER=`root`@`localhost` FUNCTION `isBatchCourseValidForUpdate`(
program_Name varchar(50), 
course_Id smallint,
batch_Id smallint,
clo_Name char(6)
) RETURNS int
    DETERMINISTIC
BEGIN

declare calProgramId tinyint;
declare calPrgramCourseId smallint;
declare calCloId mediumint;

set calProgramId=(select programId from program where programName=program_Name);
set calPrgramCourseId=(select programCourseId from programcoursejunction
where (programId=calProgramId AND courseId=course_Id AND batchId=batch_Id));

set calCloId=(select cloId from systemclo 
where programCourseId=calPrgramCourseId AND cloName=clo_Name and isDeleted=0);
if(!(calCloId is null)) then return calCloId;
else
return 0;
end if;

END











CREATE DEFINER=`root`@`localhost` FUNCTION `isFinal`(tool_Name varchar(20)) RETURNS int
    DETERMINISTIC
BEGIN

declare isFinalToolName varchar(20);
set isFinalToolName=(select tool_Name from assessmenttools where toolName=tool_Name);

if(isFinalToolName='Final Q1') then return 1;
elseif(isFinalToolName='Final Q2') then return 1;
elseif(isFinalToolName='Final Q3') then return 1;
elseif(isFinalToolName='Final Q4') then return 1;
elseif(isFinalToolName='Final Q5') then return 1;
elseif(isFinalToolName='Final Q6') then return 1;
else return 0;
end if;
END










CREATE DEFINER=`root`@`localhost` FUNCTION `isPracticalFinal`(tool_Name varchar(20)) RETURNS int
    DETERMINISTIC
BEGIN
declare isPracticallToolName varchar(20);
set isPracticallToolName =(select tool_Name from assessmenttools 
where toolName=tool_Name);
if(isSessional(isPracticallToolName)) then return 1;
elseif(isPracticallToolName='Practical') then return 1;
elseif(isPracticallToolName='Lab-Manual') then return 0;
else return 0;
end if;
END








CREATE DEFINER=`root`@`localhost` FUNCTION `isPracticalSessional`(tool_Name varchar(20)) RETURNS int
    DETERMINISTIC
BEGIN
declare isPracticallToolName varchar(20);
set isPracticallToolName =(select tool_Name from assessmenttools where toolName=tool_Name);
if(isSessional(isPracticallToolName)) then return 1;
elseif(isPracticallToolName='Practical') then return 1;
elseif(isPracticallToolName='Lab-Manual') then return 1;
else return 0;
end if;
END









CREATE DEFINER=`root`@`localhost` FUNCTION `isSessional`(tool_Name varchar(20)) RETURNS int
    DETERMINISTIC
BEGIN

declare isSessionalToolName varchar(50);
set isSessionalToolName=(select tool_Name from assessmenttools 
where toolName=tool_Name);
if(isSessionalToolName='Assignment 01') then return 1;
elseif(isSessionalToolName='Assignment 02') then return 1;
elseif(isSessionalToolName='Assignment 03') then return 1;
elseif(isSessionalToolName='Assignment 04') then return 1;
elseif(isSessionalToolName='Assignment 05') then return 1;
elseif(isSessionalToolName='Assignment 06') then return 1;
elseif(isSessionalToolName='Quiz 01') then return 1;
elseif(isSessionalToolName='Quiz 02') then return 1;
elseif(isSessionalToolName='Quiz 03') then return 1;
elseif(isSessionalToolName='Quiz 04') then return 1;
elseif(isSessionalToolName='Quiz 05') then return 1;
elseif(isSessionalToolName='Quiz 06') then return 1;
elseif(isSessionalToolName='Test 01') then return 1;
elseif(isSessionalToolName='Test 02') then return 1;
elseif(isSessionalToolName='Test 03') then return 1;
elseif(isSessionalToolName='Test 04') then return 1;
elseif(isSessionalToolName='Test 05') then return 1;
elseif(isSessionalToolName='Test 06') then return 1;
elseif(isSessionalToolName='Presentation 01') then return 1;
elseif(isSessionalToolName='Presentation 02') then return 1;
elseif(isSessionalToolName='Presentation 03') then return 1;
elseif(isSessionalToolName='Presentation 04') then return 1;
elseif(isSessionalToolName='Presentation 05') then return 1;
elseif(isSessionalToolName='Presentation 06') then return 1;
elseif(isSessionalToolName='Project 01') then return 1;
elseif(isSessionalToolName='Project 02') then return 1;
elseif(isSessionalToolName='Project 03') then return 1;
else return 0;
end if;
END














CREATE DEFINER=`root`@`localhost` FUNCTION `isTeacherValid`(teacher_Id smallint,section_Id smallint,course_Name varchar(20)) RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

declare getPracticalCourseId  smallint;
declare getTheoryCourseId smallint;
declare getPracticalTeacherId smallint;
declare getTheoryTeacherId smallint;

set getPracticalCourseId=(select courseId from course 
where (courseName=course_Name and isPractical=1));

set getTheoryCourseId =(select courseId from course
where courseName=course_Name and isPractical=0);

set getPracticalTeacherId=(select teacherId from sectionTeacherCourseJunction
where courseId=getPracticalCourseId AND sectionId=section_Id);

set getTheoryTeacherId=(select teacherId from sectionTeacherCourseJunction
where courseId=getTheoryCourseId AND sectionId=section_Id);

if(teacher_Id=getPracticalTeacherId AND teacher_Id=getTheoryTeacherId) then return 'Both';
elseif(teacher_Id=getPracticalTeacherId) then return 'Practical';
elseif(teacher_Id=getTheoryTeacherId) then return 'Theory'; 
else return 'Invalid';
end if;
END