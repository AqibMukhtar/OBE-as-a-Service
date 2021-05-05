CREATE DEFINER=`root`@`localhost` FUNCTION `getFinalId`(
getToolId smallint,
getCloId mediumint,
getSectionTeacherCourseId int
) RETURNS smallint
    DETERMINISTIC
BEGIN

declare get_Final_Id smallint;

set  get_Final_Id=(select finalId from assignedtoolclofinal
                     where toolId=getToolId AND cloId=getCloId AND 
                     sectionTeacherCourseId=getSectionTeacherCourseId);

RETURN get_Final_Id;
END











CREATE DEFINER=`root`@`localhost` FUNCTION `getFinalTotalMarks`(
getFinalId int
) RETURNS smallint
    DETERMINISTIC
BEGIN
declare total_Marks smallint;

set total_Marks=(select totalMarks from assignedtoolclofinal
            where finalId=getFinalId);
RETURN total_Marks;
END













CREATE DEFINER=`root`@`localhost` FUNCTION `getSection`(
program_Name varchar(50),
batch_Id smallint,
section_Name char(2)
) RETURNS int
    DETERMINISTIC
BEGIN

declare getProgramId tinyint;
declare getSectionId smallint;

set getProgramId=(select programId from program where programName=program_Name);
set getSectionId=(select sectionId from section where 
 programId=getProgramId AND batchId=batch_Id AND sectionName=section_Name);
 
 if(getSectionId is not null) then return getSectionId;
 else return 0;
 end if;
END











CREATE DEFINER=`root`@`localhost` FUNCTION `getSectionStudentCourseId`(
section_Id smallint,
student_Id mediumint,
getCourseId smallint
) RETURNS int
    DETERMINISTIC
BEGIN

declare get_Section_Student_Course_Id int;

	set get_Section_Student_Course_Id=(select sectionStudentCourseId from 
             sectionstudentcoursejunction where 
             sectionId=section_Id AND studentId=student_Id AND courseId=getCourseId);

RETURN get_Section_Student_Course_Id;
END














CREATE DEFINER=`root`@`localhost` FUNCTION `getSectionTeacherCourseId`(
section_Id smallint,
teacher_Id smallint,
getCourseId mediumint
) RETURNS int
    DETERMINISTIC
BEGIN

declare get_Section_Teacher_Course_Id int;
set get_Section_Teacher_Course_Id=(select sectionTeacherCourseId from sectionteachercoursejunction
			 where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=getCourseId));

RETURN get_Section_Teacher_Course_Id;
END















CREATE DEFINER=`root`@`localhost` FUNCTION `getSessionalId`(
getToolId smallint,
getCloId mediumint,
getSectionTeacherCourseId int
) RETURNS smallint
    DETERMINISTIC
BEGIN

declare get_Sessional_Id smallint;

set  get_Sessional_Id=(select sessionalId from assignedtoolclosessional
                     where toolId=getToolId AND cloId=getCloId AND 
                     sectionTeacherCourseId=getSectionTeacherCourseId);

RETURN get_Sessional_Id;

END













CREATE DEFINER=`root`@`localhost` FUNCTION `getSessionalTotalMarks`(
getSessionalId smallint
) RETURNS smallint
    DETERMINISTIC
BEGIN

declare total_Marks smallint;
set total_Marks=(select totalMarks from assignedtoolclosessional
            where sessionalId=getSessionalId);

RETURN total_Marks;
END















CREATE DEFINER=`root`@`localhost` FUNCTION `getSumOfFinalMarks`(
getSectionTeacherCourseId int
) RETURNS smallint
    DETERMINISTIC
BEGIN
declare sumOfFinalMarks smallint;

set sumOfFinalMarks=(select sum(totalMarks) from assignedtoolclofinal
					where sectionTeacherCourseId=getSectionTeacherCourseId);
RETURN sumOfFinalMarks;
END
















CREATE DEFINER=`root`@`localhost` FUNCTION `getSumOfSessionalMarks`(
getSectionTeacherCourseId int
) RETURNS smallint
    DETERMINISTIC
BEGIN

declare sumOfSessionalMarks smallint;
set  sumOfSessionalMarks=(select sum(totalMarks) from assignedtoolclosessional
					where sectionTeacherCourseId=getSectionTeacherCourseId);
RETURN sumOfSessionalMarks;
END













CREATE DEFINER=`root`@`localhost` FUNCTION `getToolId`(
tool_Name varchar(20)
) RETURNS smallint
    DETERMINISTIC
BEGIN
declare getToolId smallint;
set getToolId=(Select toolId from assessmenttools where toolName=tool_Name);
RETURN getToolId;
END












CREATE DEFINER=`root`@`localhost` FUNCTION `getTotalCountOfClo`(
getSectionTeacherCourseId int,
newGetCloId mediumint
) RETURNS smallint
    DETERMINISTIC
BEGIN

declare getFinalCountOfClo smallint;
declare getSessionalCountOfClo smallint;
declare getCountOfClo smallint;

                    set getFinalCountOfClo=(select count(*) from assignedtoolclofinal
					where sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=newGetCloId);
                    
				   set getSessionalCountOfClo=(select count(*) from assignedtoolclosessional
                   where sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=newGetCloId);
                
                   set getCountOfClo= getFinalCountOfClo + getSessionalCountOfClo;

RETURN getCountOfClo;
END

















CREATE DEFINER=`root`@`localhost` FUNCTION `isBatchCourseValidForUpdate`(
program_Name varchar(50), 
course_Id smallint,
batch_Id smallint,
clo_Name char(6)
) RETURNS int
    DETERMINISTIC
BEGIN

declare getProgramId tinyint;
declare getPrgramCourseId smallint;
declare getCloId mediumint;

set getProgramId=(select programId from program where programName=program_Name);
set getPrgramCourseId=(select programCourseId from programcoursejunction
where (programId=getProgramId AND courseId=course_Id AND batchId=batch_Id));
set getCloId=(select cloId from systemclo 
where programCourseId=getPrgramCourseId AND cloName=clo_Name and isDeleted=0);

if(!(getCloId is null)) then return getCloId;
else
return 0;
end if;

END












CREATE DEFINER=`root`@`localhost` FUNCTION `isCourseCompleted`(
getSectionTeacherCourseId int
) RETURNS tinyint
    DETERMINISTIC
BEGIN

declare is_Course_Completed tinyint;
set is_Course_Completed=(select isCompleted from sectionteachercoursejunction where
                           sectionTeacherCourseId=getSectionTeacherCourseId);
RETURN is_Course_Completed;
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










CREATE DEFINER=`root`@`localhost` FUNCTION `isFinalToolConducted`(
getFinalId smallint
) RETURNS tinyint
    DETERMINISTIC
BEGIN
declare is_Final_Tool_Conducted tinyint;

 set is_Final_Tool_Conducted=(select isConducted from assignedtoolclofinal
                             where finalId=getFinalId);
RETURN is_Final_Tool_Conducted;
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

















CREATE DEFINER=`root`@`localhost` FUNCTION `isSessionalToolConducted`(
getSessionalId smallint
) RETURNS tinyint
    DETERMINISTIC
BEGIN
declare is_Sessional_Tool_Conducted tinyint;

 set is_Sessional_Tool_Conducted=(select isConducted from assignedtoolclosessional
                             where sessionalId=getSessionalId);
RETURN is_Sessional_Tool_Conducted;
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


















CREATE DEFINER=`root`@`localhost` FUNCTION `isValidRequestForFinalObtainedMarks`(
getFinalId int,
student_Id mediumint,
marks_Obtained decimal(5,2)
) RETURNS int
    DETERMINISTIC
BEGIN

declare isValidRequest int;
set isValidRequest=(select finalMarksObtainedId from finalmarksobtained 
             where finalId=getFinalId AND studentId=student_Id AND marksObtained=marks_Obtained);
RETURN isValidRequest;

END











CREATE DEFINER=`root`@`localhost` FUNCTION `isValidRequestForSessionalObtainedMarks`(
getSessionalId int,
student_Id mediumint,
marks_Obtained decimal(5,2)
) RETURNS int
    DETERMINISTIC
BEGIN


declare isValidRequest int;
set isValidRequest=(select sessionalMarksObtainedId from sessionalmarksobtained 
             where sessionalId=getSessionalId AND studentId=student_Id AND marksObtained=marks_Obtained);
RETURN isValidRequest;
END










CREATE DEFINER=`root`@`localhost` FUNCTION `shouldAddFinalObtainedMarks`(
getFinalId int,
student_Id mediumint
) RETURNS int
    DETERMINISTIC
BEGIN

declare shouldAdd int;
set shouldAdd=(select finalMarksObtainedId from finalmarksobtained 
			where finalId=getFinalId AND studentId=student_Id);

RETURN shouldAdd;
END













CREATE DEFINER=`root`@`localhost` FUNCTION `shouldAddSessionalObtainedMarks`(
getSessionalId int,
student_Id mediumint
) RETURNS int
    DETERMINISTIC
BEGIN

declare shouldAdd int;
set shouldAdd=(select sessionalMarksObtainedId from sessionalmarksobtained 
			where sessionalId=getSessionalId AND studentId=student_Id);

RETURN shouldAdd;
END

















CREATE DEFINER=`root`@`localhost` FUNCTION `shouldUpdateFinalObtainedMarks`(
getFinalId int,
student_Id mediumint,
marks_Obtained decimal(5,2)
) RETURNS int
    DETERMINISTIC
BEGIN

declare shouldUpdateMarks int;
set shouldUpdateMarks=(select finalMarksObtainedId from finalmarksobtained 
             where finalId=getFinalId AND studentId=student_Id AND marksObtained!=marks_Obtained);

RETURN shouldUpdateMarks;
END













CREATE DEFINER=`root`@`localhost` FUNCTION `shouldUpdateSessionalObtainedMarks`(
getSessionalId int,
student_Id mediumint,
marks_Obtained decimal(5,2)
) RETURNS int
    DETERMINISTIC
BEGIN

declare shouldUpdateMarks int;
set shouldUpdateMarks=(select sessionalMarksObtainedId from sessionalmarksobtained
             where sessionalId=getSessionalId AND studentId=student_Id AND marksObtained!=marks_Obtained);

RETURN shouldUpdateMarks;

END








