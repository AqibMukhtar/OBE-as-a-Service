CREATE DEFINER=`root`@`localhost` PROCEDURE `addAssessmentToolFinalPractical`(
	  program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint 
)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calCloId mediumint;
      declare calSectionTeacherCourseId int;
      declare isRepeat smallint;
      
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name);  
           
             if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
	
			set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
			  
					if (!(calSectionTeacherCourseId is null)) then
					if(!(total_Marks<=0 or total_Marks is null)) then
			        set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                      if(calCloId !=0) then
                       if(isPracticalFinal(tool_Name)!=0) then
               
						  if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both')
						   OR (isTeacherValid(teacher_Id,section_Id,course_Name)='Practical')
							 then
                             
         set isRepeat=(select finalId from assignedtoolclofinal where 
                   toolId=calToolId AND cloId=calCloId AND sectionTeacherCourseId=calSectionTeacherCourseId);
				   if(isRepeat is null) then                   
		
							  insert into assignedtoolclofinal
							   values 
							 (default,
							 calToolId,
							 calCloId,
							 calSectionTeacherCourseId,
							 total_Marks);
							   select 'Record has been added successfully' AS 'Message', true as 'Success';
      
		else
		select 'You have already added this record' AS 'Message', false as 'Success';
		end if;
      
       else 
          select 'You can only add assessment tool for practical/ section you are teaching' 
          AS 'Message', false as 'Success';
       end if;
	   else 
			select 'Tool should be from Final Practical Tools' AS 'Message', false as 'Success';
	   end if;
          else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
           else
             SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
           else
                    SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
           else
              SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
          else
               SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
       else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END


















CREATE DEFINER=`root`@`localhost` PROCEDURE `addAssessmentToolSessionalPractical`(
	  program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint   
)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calCloId mediumint;
      declare calSectionTeacherCourseId int;
      declare isRepeat smallint;
  
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name);  
		  
           
             if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
		
			set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
			  
					if (!(calSectionTeacherCourseId is null)) then
					if(!(total_Marks<=0 or total_Marks is null)) then
			          set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                      if(calCloId !=0) then
                      if(isPracticalSessional(tool_Name)!=0) then
               
						if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both'
					    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Practical') then 
             set isRepeat=(select sessionalId from assignedtoolclosessional where 
               toolId=calToolId AND cloId=calCloId AND sectionTeacherCourseId=calSectionTeacherCourseId);
			if(isRepeat is null) then
					   insert into assignedtoolclosessional
					   values 
						 (default,
						 calToolId,
						 calCloId,
						 calSectionTeacherCourseId,
						 total_Marks);
						   select 'Record has been added successfully' AS 'Message', true as 'Success';
               else
                select 'You have already added this record' AS 'Message', false as 'Success';
                end if;
      
      
       else 
          select 'You can only add assessment tool for theory/ section you are teaching' 
          AS 'Message', false as 'Success';
       end if;
	   else 
			select 'Tool should be from Sessional Tools' AS 'Message', false as 'Success';
	   end if;
          else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
           else
             SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
           else
                    SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
           else
              SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
          else
               SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
       else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END















CREATE DEFINER=`root`@`localhost` PROCEDURE `addAssessmentToolFinalTheory`(
	  program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
	  declare calCloId mediumint;
      declare isRepeat smallint;
      
	   if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
                    if (!(total_Marks<=0 OR total_Marks is null)) then
                     set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                      if(isFinal(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Theory') then

                   set isRepeat=(select finalId from assignedtoolclofinal where 
                   toolId=calToolId AND cloId=calCloId AND sectionTeacherCourseId=calSectionTeacherCourseId);
				   if(isRepeat is null) then
                   insert into assignedtoolclofinal
					values 
					 (default,
					 calToolId,
					 calCloId,
					 calSectionTeacherCourseId,
					 total_Marks);
					   select 'Record has been added successfully' AS 'Message', true as 'Success';
    
    else 
     select 'You have already added this record' as 'Message', false as 'Success';
    end if;
	   else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
                else
               SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "Section Teacher Course Id not exist" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END


















CREATE DEFINER=`root`@`localhost` PROCEDURE `addAssessmentToolSessionalTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint)
BEGIN
      
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;
      declare isRepeat smallint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
                    if (!(total_Marks<=0 OR total_Marks is null)) then
                     set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                      if(isSessional(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Theory') then
			   
			set isRepeat=(select sessionalId from assignedtoolclosessional where 
               toolId=calToolId AND cloId=calCloId AND sectionTeacherCourseId=calSectionTeacherCourseId);
			if(isRepeat is null) then
				    insert into assignedtoolclosessional
					values 
					 (default,
					 calToolId,
					 calCloId,
					 calSectionTeacherCourseId,
					 total_Marks);
					   select 'Record has been added successfully' AS 'Message', true as 'Success';
				else
                select 'You have already added this record' AS 'Message', false as 'Success';
                end if;
	   else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
                else
               SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from theory" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END









CREATE DEFINER=`root`@`localhost` PROCEDURE `addFinalMarksObtainedPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN


      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;
      declare calFinalId int;
      declare calTotalMarks tinyint;
      declare calSectionStudentCourseId int;
      declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 
             set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    
                    if (!(calSectionTeacherCourseId is null)) then
                      set calCloId= isBatchCourseCloValidObtainedMarks
                     (program_Name,calCourseId,batch_Id,clo_Name,calToolId,calSectionTeacherCourseId);
                     if(calCloId !=0) then
                      if(isPracticalFinal(tool_Name)!=0) then
	      
            set calFinalId =(select finalId from assignedtoolclofinal where 
			sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId);
            set calTotalMarks=(select totalMarks from assignedtoolclofinal
            where finalId=calFinalId );
            
            if(marks_Obtained <= calTotalMarks AND marks_Obtained>=0) then 
             set calSectionStudentCourseId=(select sectionStudentCourseId from 
             sectionstudentcoursejunction where 
             sectionId=section_Id AND studentId=student_Id AND courseId=calCourseId);
			
            if(!(calSectionStudentCourseId is null)) then 
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Practical') then
            
            set shouldAdd=(select finalMarksObtainedId from finalmarksobtained 
			where finalId=calFinalId AND studentId=student_Id);			
  
           set isValidRequest=(select finalMarksObtainedId from finalmarksobtained 
             where finalId=calFinalId AND studentId=student_Id AND marksObtained=marks_Obtained);
             
             set shouldUpdateMarks=(select finalMarksObtainedId from finalmarksobtained 
             where finalId=calFinalId AND studentId=student_Id AND marksObtained!=marks_Obtained);
             
             if(shouldAdd is null) then 
				insert into finalmarksobtained
					values 
					 (default,
					 calFinalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update finalmarksobtained 
             set marksObtained=marks_Obtained
             where finalId=calFinalId AND studentId=student_Id;
              select 'Record has been updated successfully' AS 'Message', true as 'Success';
              
			elseif(isValidRequest is not null) then
			select 'You have already added marks of this student' AS 'Message', true as 'Success';
            end if;

	   else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
		else 
          select 'This student is not enrolled in this course / section' AS 'Message', false as 'Success';
       end if;
       else 
          select 'Obtained marks are greater than total marks' AS 'Message', false as 'Success';
       end if;
			else 
          select 'Tool should be from practical final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from practical" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;


END















CREATE DEFINER=`root`@`localhost` PROCEDURE `addFinalMarksObtainedTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN


      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;
      declare calFinalId int;
      declare calTotalMarks tinyint;
      declare calSectionStudentCourseId int;
	  declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;
      
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
                      set calCloId= isBatchCourseCloValidObtainedMarks
                     (program_Name,calCourseId,batch_Id,clo_Name,calToolId,calSectionTeacherCourseId);
                     if(calCloId !=0) then
                      if(isFinal(tool_Name)!=0) then
	       set calFinalId =(select finalId from assignedtoolclofinal where 
			sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId);
            set calTotalMarks=(select totalMarks from assignedtoolclofinal
            where finalId=calFinalId );
            if(marks_Obtained <=calTotalMarks AND marks_Obtained>=0) then 
             set calSectionStudentCourseId=(select sectionStudentCourseId from 
             sectionstudentcoursejunction where 
             sectionId=section_Id AND studentId=student_Id AND courseId=calCourseId);
			 if(!(calSectionStudentCourseId is null)) then 
                   
                   if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Theory') then
            
            set shouldAdd=(select finalMarksObtainedId from finalmarksobtained 
			where finalId=calFinalId AND studentId=student_Id);
             
             set shouldUpdateMarks=(select finalMarksObtainedId from finalmarksobtained 
             where finalId=calFinalId AND studentId=student_Id AND marksObtained!=marks_Obtained);      

			set isValidRequest=(select finalMarksObtainedId from finalmarksobtained 
             where finalId=calFinalId AND studentId=student_Id AND marksObtained=marks_Obtained);
			
			if(shouldAdd is null) then 
				insert into finalmarksobtained
					values 
					 (default,
					 calFinalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update finalmarksobtained 
             set marksObtained=marks_Obtained
             where finalId=calFinalId AND studentId=student_Id;
              select 'Record has been updated successfully' AS 'Message', true as 'Success';
              
			elseif(isValidRequest is not null) then
			select 'You have already added marks of this student' AS 'Message', true as 'Success';
            end if;

       else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
		else 
          select 'This student is not enrolled in this course / section' AS 'Message', false as 'Success';
       end if;
       else 
          select 'Obtained marks are greater than total marks' AS 'Message', false as 'Success';
       end if;
			else 
          select 'Tool should be from final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from theory" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;


END



















CREATE DEFINER=`root`@`localhost` PROCEDURE `addSessionalMarksObtainedPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN

      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;
      declare calSessionalId int;
      declare calTotalMarks tinyint;
      declare calSectionStudentCourseId int;
	  declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
                      set calCloId= isBatchCourseCloValidObtainedMarks
                     (program_Name,calCourseId,batch_Id,clo_Name,calToolId,calSectionTeacherCourseId);
                     if(calCloId !=0) then
                      if(isPracticalSessional(tool_Name)!=0) then
	       set calSessionalId=(select sessionalId from assignedtoolclosessional where 
			sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId);
            set calTotalMarks=(select totalMarks from assignedtoolclosessional 
            where sessionalId=calSessionalId);
            if(marks_Obtained <= calTotalMarks AND marks_Obtained>=0) then 
             set calSectionStudentCourseId=(select sectionStudentCourseId from 
             sectionstudentcoursejunction where 
             sectionId=section_Id AND studentId=student_Id AND courseId=calCourseId);
			 if(!(calSectionStudentCourseId is null)) then 
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Practical') then
            
              set shouldAdd=(select sessionalMarksObtainedId from sessionalmarksobtained 
			where sessionalId=calSessionalId AND studentId=student_Id);
            
			set shouldUpdateMarks=(select sessionalMarksObtainedId from sessionalmarksobtained
             where sessionalId=calSessionalId AND studentId=student_Id AND marksObtained!=marks_Obtained);
            
           set isValidRequest=(select sessionalMarksObtainedId from sessionalmarksobtained 
             where sessionalId=calSessionalId AND studentId=student_Id AND marksObtained=marks_Obtained);
             
			if(shouldAdd is null) then 
				insert into sessionalmarksobtained
					values 
					 (default,
					 calSessionalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update sessionalmarksobtained 
             set marksObtained=marks_Obtained
             where sessionalId=calSessionalId AND studentId=student_Id;
              select 'Record has been updated successfully' AS 'Message', true as 'Success';
              
			elseif(isValidRequest is not null) then
			select 'You have already added marks of this student' AS 'Message', true as 'Success';
            
            end if;
    
	   else 
			select 'You are not teaching practical for this course' AS 'Message', false as 'Success';
	   end if;
		else 
          select 'This student is not enrolled in this course / section' AS 'Message', false as 'Success';
       end if;
       else 
          select 'Obtained marks are greater than total marks' AS 'Message', false as 'Success';
       end if;
			else 
          select 'Tool should be from practical sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from practical" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;


END














CREATE DEFINER=`root`@`localhost` PROCEDURE `addSessionalMarksObtainedTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN

      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;
      declare calSessionalId int;
      declare calTotalMarks tinyint;
      declare calSectionStudentCourseId int;
	  declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
	                 set calCloId= isBatchCourseCloValidObtainedMarks
                     (program_Name,calCourseId,batch_Id,clo_Name,calToolId,calSectionTeacherCourseId);
                     if(calCloId !=0) then
                      if(isSessional(tool_Name)!=0) then
	       set calSessionalId=(select sessionalId from assignedtoolclosessional where 
			sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId);
            
            set calTotalMarks=(select totalMarks from assignedtoolclosessional 
            where sessionalId=calSessionalId);
            if(marks_Obtained<=calTotalMarks AND marks_Obtained>=0) then 
             set calSectionStudentCourseId=(select sectionStudentCourseId from 
             sectionstudentcoursejunction where 
             sectionId=section_Id AND studentId=student_Id AND courseId=calCourseId);
			 if(!(calSectionStudentCourseId is null)) then 
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Theory') then

            set shouldAdd=(select sessionalMarksObtainedId from sessionalmarksobtained 
			where sessionalId=calSessionalId AND studentId=student_Id);
            
			set shouldUpdateMarks=(select sessionalMarksObtainedId from sessionalmarksobtained
             where sessionalId=calSessionalId AND studentId=student_Id AND marksObtained!=marks_Obtained);
            
            set isValidRequest=(select sessionalMarksObtainedId from sessionalmarksobtained 
             where sessionalId=calSessionalId AND studentId=student_Id AND marksObtained=marks_Obtained);
             
			if(shouldAdd is null) then 
				insert into sessionalmarksobtained
					values 
					 (default,
					 calSessionalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update sessionalmarksobtained 
             set marksObtained=marks_Obtained
             where sessionalId=calSessionalId AND studentId=student_Id;
              select 'Record has been updated successfully' AS 'Message', true as 'Success';
              
			elseif(isValidRequest is not null) then
			select 'You have already added marks of this student' AS 'Message', true as 'Success';
            end if;
    
	   else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
		else 
          select 'This student is not enrolled in this course / section' AS 'Message', false as 'Success';
       end if;
       else 
          select 'Obtained marks are greater than total marks' AS 'Message', false as 'Success';
       end if;
			else 
          select 'Tool should be from sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from theory" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END















CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAssessmentToolFinalPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
				set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                      if(isPracticalFinal(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Practical') then
                       if((select finalId from assignedtoolclofinal where 
                        sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId)!=0)
                        then 
					   delete from assignedtoolclofinal
					   where (
					   sectionTeacherCourseId=calSectionTeacherCourseId
					   ANd toolId=calToolId AND cloId=calCloId);
					   select 'Assessment tool of final deleted successfully' 
                       AS 'Message', true as 'Success';
	else 
      select 'Record does not exists' AS 'Message', false as 'Success';
	end if;
	 else 
			select 'You are not teaching practical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from final practical tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from practical" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END















CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAssessmentToolFinalTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
				set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                      if(isFinal(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Theory') then
                       if((select finalId from assignedtoolclofinal where 
                        sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId)!=0)
                        then 
					   delete from assignedtoolclofinal
					   where (
					   sectionTeacherCourseId=calSectionTeacherCourseId
					   ANd toolId=calToolId AND cloId=calCloId);
					   select 'Assessment tool of final deleted successfully' 
                       AS 'Message', true as 'Success';
	else 
      select 'Record does not exists' AS 'Message', false as 'Success';
	end if;
	 else 
			select 'You are not teaching theory for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from theory" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;

END













CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAssessmentToolSessionalPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
				set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                      if(isPracticalSessional(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Practical') then
                       if((select sessionalId from assignedtoolclosessional where 
                        sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId)!=0)
                        then 
					   delete from assignedtoolclosessional 
					   where (
					   sectionTeacherCourseId=calSectionTeacherCourseId
					   ANd toolId=calToolId AND cloId=calCloId);
					   select 'Assessment tool of sessional deleted successfully' 
                       AS 'Message', true as 'Success';
	else 
      select 'Record does not exists' AS 'Message', false as 'Success';
	end if;
	 else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from practical sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from practical" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;	

END

















CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAssessmentToolSessionalTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare calCourseId smallint;
      declare calToolId smallint;
      declare calSectionTeacherCourseId int;
      declare calCloId mediumint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		  set calToolId=(Select toolId from assessmenttools where toolName=tool_Name); 
           
		  if (!(calCourseId is null)) then
			   if (!(calToolId is null)) then
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			  where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));
                    if (!(calSectionTeacherCourseId is null)) then
				set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                      if(isSessional(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,section_Id,course_Name)='Theory') then
                       if((select sessionalId from assignedtoolclosessional where 
                        sectionTeacherCourseId=calSectionTeacherCourseId ANd toolId=calToolId AND cloId=calCloId)!=0)
                        then 
					   delete from assignedtoolclosessional 
					   where (
					   sectionTeacherCourseId=calSectionTeacherCourseId
					   ANd toolId=calToolId AND cloId=calCloId);
					   select 'Assessment tool of sessional deleted successfully' 
                       AS 'Message', true as 'Success';
	else 
      select 'Record does not exists' AS 'Message', false as 'Success';
	end if;
	 else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
               	else
					SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
					end if;
         else
               SELECT "Tool Name is incorrect" AS "Message", FALSE AS "Success";
			   end if;
         else
               SELECT "Course should be from theory" AS "Message", FALSE AS "Success";
			   end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;			 
END















CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAssessmentToolFinalPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
      declare calCourseId smallint;
	  declare calToolId smallint;
      declare matchToolId smallint;
      declare newCalToolId smallint;
      declare calCloId mediumint;
      declare newCalCloId smallint;
      declare calSectionTeacherCourseId int;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		 set calToolId=(Select toolId from assessmenttools where toolName=tool_Name);
		 set newCalToolId=(select toolId from assessmenttools where toolName=new_Tool_Name);
	
          if (!(calCourseId is null)) then
		      
              if (!(calToolId is null))then 
        
		         if (!(newCalToolId is null))then 
			
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			 where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));  
             
		      if (!(calSectionTeacherCourseId is null)) then 
						
                        
		          if (!(total_Marks<=0 OR total_Marks is null)) then
				set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                     set matchToolId=(select finalId from assignedtoolclofinal 
                         where toolId=calToolId AND sectionTeacherCourseId=calSectionTeacherCourseId
                         AND cloId=calCloId);
						 if(!(matchToolId is null)) then 
					set newCalCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,new_Clo_Name);
                     if(newCalCloId !=0) then	
	              	if(isPracticalFinal(tool_Name)!=0) then
                      if(isPracticalFinal(new_Tool_Name)!=0) then
					
                      if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,section_Id,course_Name)='Practical')
					  then 
					   update assignedtoolclofinal
					   set 
							toolId=newCalToolId,
							cloId=newCalCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=calSectionTeacherCourseId
								ANd 
							toolId=calToolId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
		          else 
                  select 'You can only update assessment tool for practical/ section you are teaching' 
                  AS 'Message', false as 'Success';
                  end if;
			   else 
			    select 'New Tool should be from Practical Final Tools' AS 'Message', false as 'Success';
	            end if;
			  else 
			  select 'Tool should be from Practical FinalTools' AS 'Message', false as 'Success';
	          end if;
               else
          select 'New CLO Name is not valid' AS 'Message', false as 'Success';
          end if;
			else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
         
			else
			SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
	
		 else
		 SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
		 end if;
	   else
	   SELECT "New Tool Name does not exist" AS "Message", FALSE AS "Success";
	   end if;
	  else
	  SELECT "Tool Name does not exist" AS "Message", FALSE AS "Success";
	  end if;
	 else
     SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
	 end if;
	else
	select 'Batch is not active' AS 'Message',false as 'Success';
	end if;
END











CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAssessmentToolFinalTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
	  declare calCourseId smallint;
	  declare calToolId smallint;
      declare matchToolId smallint;
      declare newCalToolId smallint;
      declare calCloId mediumint;
      declare newCalCloId mediumint;
      declare calSectionTeacherCourseId int;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		 set calToolId=(Select toolId from assessmenttools where toolName=tool_Name);
		 set newCalToolId=(select toolId from assessmenttools where toolName=new_Tool_Name);
	
          if (!(calCourseId is null)) then
		      
              if (!(calToolId is null))then 
        
		         if (!(newCalToolId is null))then 
			
			
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			 where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));  
             
		      if (!(calSectionTeacherCourseId is null)) then 
						 
		          if (!(total_Marks<=0 OR total_Marks is null)) then
			        set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                     if(calCloId !=0) then
                     set matchToolId=(select finalId from assignedtoolclofinal
                         where toolId=calToolId AND cloId=calCloId AND sectionTeacherCourseId=calSectionTeacherCourseId
                         AND cloId=calCloId);
                         if(!(matchToolId is null)) then
					set newCalCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,new_Clo_Name);
                     if(newCalCloId !=0) then
	              	if(isFinal(tool_Name)!=0) then
                      if(isFinal(new_Tool_Name)!=0) then
					
                      if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,section_Id,course_Name)='Theory')
					  then 
					   update assignedtoolclofinal
					   set 
							toolId=newCalToolId,
							cloId=newCalCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=calSectionTeacherCourseId
								ANd 
							toolId=calToolId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
		          else 
                  select 'You can only add assessment tool for theory/ section you are teaching' 
                  AS 'Message', false as 'Success';
                  end if;
			   else 
			    select 'New Tool should be from Final Tools' AS 'Message', false as 'Success';
	            end if;
			  else 
			  select 'Tool should be from Final Tools' AS 'Message', false as 'Success';
	          end if;
              else
              select 'New CLO not valid' AS 'Message', false as 'Success';
              end if;
               else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
			  else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
		 
		 else
		 SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
		 end if;
	   else
	   SELECT "New Tool Name does not exist" AS "Message", FALSE AS "Success";
	   end if;
	  else
	  SELECT "Tool Name does not exist" AS "Message", FALSE AS "Success";
	  end if;
	 else
     SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
	 end if;
	else
	select 'Batch is not active' AS 'Message',false as 'Success';
	end if;
END











CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAssessmentToolSessionalPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
      declare calCourseId smallint;
	  declare calToolId smallint;
      declare matchToolId smallint;
      declare newCalToolId smallint;
      declare calCloId mediumint;
      declare newCalCloId smallint;
      declare calSectionTeacherCourseId int;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set calCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
		 set calToolId=(Select toolId from assessmenttools where toolName=tool_Name);
		 set newCalToolId=(select toolId from assessmenttools where toolName=new_Tool_Name);

	
          if (!(calCourseId is null)) then
		      
              if (!(calToolId is null))then 
        
		         if (!(newCalToolId is null))then 
			
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			 where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));  
             
		      if (!(calSectionTeacherCourseId is null)) then 
			
		          if (!(total_Marks<=0 OR total_Marks is null)) then
			       set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                    if(calCloId !=0) then
						set matchToolId=(select sessionalId from assignedtoolclosessional 
                         where toolId=calToolId AND sectionTeacherCourseId=calSectionTeacherCourseId
                         AND cloId=calCloId);
                         if(!(matchToolId is null)) then 
                    set newCalCloId=isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,new_Clo_Name);
                     if(newCalCloId !=0) then
                     
	              	if(isPracticalSessional(tool_Name)!=0) then
                      if(isPracticalSessional(new_Tool_Name)!=0) then
					
                      if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,section_Id,course_Name)='Practical')
					  then 
					   update assignedtoolclosessional 
					   set 
							toolId=newCalToolId,
							cloId=newCalCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=calSectionTeacherCourseId
								ANd 
							toolId=calToolId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
		          else 
                  select 'You can only update assessment tool for practical/ section you are teaching' 
                  AS 'Message', false as 'Success';
                  end if;
			   else 
			    select 'New Tool should be from Practical Sessional Tools' AS 'Message', false as 'Success';
	            end if;
			  else 
			  select 'Tool should be from Practical Sessional Tools' AS 'Message', false as 'Success';
	          end if;
               else
              select 'New CLO not valid' AS 'Message', false as 'Success';
              end if;
                else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
             
				else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
		 else
		 SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
		 end if;
	   else
	   SELECT "New Tool Name does not exist" AS "Message", FALSE AS "Success";
	   end if;
	  else
	  SELECT "Tool Name does not exist" AS "Message", FALSE AS "Success";
	  end if;
	 else
     SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
	 end if;
	else
	select 'Batch is not active' AS 'Message',false as 'Success';
	end if;
END




















CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAssessmentToolSessionalTheory`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      section_Id smallint,
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
      
      declare calCourseId smallint;
	  declare calToolId smallint;
      declare matchToolId smallint;
      declare newCalToolId smallint;
      declare calCloId mediumint;
      declare newCalCloId smallint;
      declare calSectionTeacherCourseId int;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set calCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
		 set calToolId=(Select toolId from assessmenttools where toolName=tool_Name);
		 set newCalToolId=(select toolId from assessmenttools where toolName=new_Tool_Name);
	
          if (!(calCourseId is null)) then
		      
              if (!(calToolId is null))then 
        
		         if (!(newCalToolId is null))then 
			
			 set calSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
			 where (sectionId=section_Id AND teacherId=teacher_Id AND courseId=calCourseId));  
             
		      if (!(calSectionTeacherCourseId is null)) then 
		         
                 if (!(total_Marks<=0 OR total_Marks is null)) then
			      set calCloId= isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,clo_Name);
                   
                   if(calCloId !=0) then
                   set matchToolId=(select sessionalId from assignedtoolclosessional 
                         where toolId=calToolId AND sectionTeacherCourseId=calSectionTeacherCourseId
                         AND cloId=calCloId);
                        if(!(matchToolId is null)) then 
                   
	              	set newCalCloId=isBatchCourseValidForUpdate(program_Name,calCourseId,batch_Id,new_Clo_Name);
                     if(newCalCloId !=0) then
                    if(isSessional(tool_Name)!=0) then
                    
                     if(isSessional(new_Tool_Name)!=0) then 
					
                      if(isTeacherValid(teacher_Id,section_Id,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,section_Id,course_Name)='Theory')
					  then 
					   update assignedtoolclosessional 
					   set 
							toolId=newCalToolId,
							cloId=newCalCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=calSectionTeacherCourseId
								ANd 
							toolId=calToolId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
		          else 
                  select 'You can only add assessment tool for theory/ section you are teaching' 
                  AS 'Message', false as 'Success';
                  end if;
			   else 
			    select 'New Tool should be from Sessional Tools' AS 'Message', false as 'Success';
	            end if;
			  else 
			  select 'Tool should be from Sessional Tools' AS 'Message', false as 'Success';
	          end if;
              else 
              SELECT 'New CLO Name is not valid' AS 'MEssage', FALSE AS 'Success';
              end if;
              		  else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
				else
               SELECT "This course is not enrolled for this program/batch" AS "Message", FALSE AS "Success";
			   end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
		 else
		 SELECT "You are not teaching this course to this section" AS "Message", FALSE AS "Success";
		 end if;
	   else
	   SELECT "New Tool Name does not exist" AS "Message", FALSE AS "Success";
	   end if;
	  else
	  SELECT "Tool Name does not exist" AS "Message", FALSE AS "Success";
	  end if;
	 else
     SELECT "Course Name is incorrect" AS "Message", FALSE AS "Success";
	 end if;
	else
	select 'Batch is not active' AS 'Message',false as 'Success';
	end if;
END
















CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAssessmentCriteria`(
student_Id mediumint, course_Id smallint
)
BEGIN

declare sectionIdofLoggedStudent smallint;
declare sectionTeacherCourseIdofLoggedStudent int;

set sectionIdofLoggedStudent=(select sectionId from student where 
studentId IN (student_Id)); 

set sectionTeacherCourseIdofLoggedStudent=(select sectionTeacherCourseId from sectionteachercoursejunction
where sectionId IN(sectionIdofLoggedStudent) and courseId IN(course_Id));

select
toolName,
cloName,
totalMarks
from assignedtoolclosessional tcs
join assessmenttools t
	 using (toolId)
join systemclo c
   using (cloId)
join sectionteachercoursejunction stcj 
where stcj.sectionTeacherCourseId IN (sectionTeacherCourseIdofLoggedStudent) AND tcs.sectionTeacherCourseId= stcj.sectionTeacherCourseId

UNION

select
toolName,
cloName,
totalMarks
from assignedtoolclofinal tcf 
join assessmenttools t
	 using (toolId)
join systemclo c
   using (cloId)
join sectionteachercoursejunction stcj 
where stcj.sectionTeacherCourseId IN (sectionTeacherCourseIdofLoggedStudent) AND tcf.sectionTeacherCourseId= stcj.sectionTeacherCourseId;
END













CREATE DEFINER=`root`@`localhost` PROCEDURE `viewFinalPracticalReport`(
	program_Name varchar(50),
	batch_Id smallint,
	section_Name char(2),
	student_Id mediumint,
    course_Name varchar(60)
)
BEGIN

 declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
  
  set getSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
  where sectionId IN(getSectionId) and courseId IN(getCourseId));

select distinct p.programName, b.batchId, s.studentId,sec.sectionId,c.courseId,
c.courseName,a.toolName,sc.cloName,atcs.totalMarks,smo.marksObtained
from student s,sectionteachercoursejunction stcj,assignedtoolclofinal atcs,finalmarksobtained smo
join program p 
join batch b 
join section sec 
join course c
join assessmenttools a
join systemclo sc
join assignedtoolclofinal tcs
where
p.programId=s.programId AND 
b.batchId=s.batchId AND
sec.sectionId=s.sectionId AND
s.studentId IN (select studentId from student where sectionId=getSectionId
AND programId=getProgramId AND batchId=batch_Id AND studentId=student_Id)  AND
c.courseId IN (getCourseId) AND
c.courseId=stcj.courseId AND 
a.toolId=atcs.toolId AND 
sc.cloId=atcs.cloId AND 
stcj.sectionTeacherCourseId IN (getSectionTeacherCourseId)
AND atcs.sectionTeacherCourseId= stcj.sectionTeacherCourseId
AND tcs.finalId IN (select finalId from assignedtoolclofinal
where toolId=a.toolId AND cloId=sc.cloId AND sectionTeacherCourseId IN(getSectionTeacherCourseId))
AND smo.finalId=tcs.finalId
AND s.studentId=smo.studentId;



END


















CREATE DEFINER=`root`@`localhost` PROCEDURE `viewFinalTheoryReport`(
	program_Name varchar(50),
	batch_Id smallint,
	section_Name char(2),
	student_Id mediumint,
    course_Name varchar(60)
)
BEGIN

  declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
  
  set getSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
  where sectionId IN(getSectionId) and courseId IN(getCourseId));

select distinct p.programName, b.batchId, s.studentId,sec.sectionId,c.courseId,
c.courseName,a.toolName,sc.cloName,atcs.totalMarks,smo.marksObtained
from student s,sectionteachercoursejunction stcj,assignedtoolclofinal atcs,finalmarksobtained smo
join program p 
join batch b 
join section sec 
join course c
join assessmenttools a
join systemclo sc
join assignedtoolclofinal tcs
where
p.programId=s.programId AND 
b.batchId=s.batchId AND
sec.sectionId=s.sectionId AND
s.studentId IN (select studentId from student where sectionId=getSectionId
AND programId=getProgramId AND batchId=batch_Id AND studentId=student_Id)  AND
c.courseId IN (getCourseId) AND
c.courseId=stcj.courseId AND 
a.toolId=atcs.toolId AND 
sc.cloId=atcs.cloId AND 
stcj.sectionTeacherCourseId IN (getSectionTeacherCourseId)
AND atcs.sectionTeacherCourseId= stcj.sectionTeacherCourseId
AND tcs.finalId IN (select finalId from assignedtoolclofinal
where toolId=a.toolId AND cloId=sc.cloId AND sectionTeacherCourseId IN(getSectionTeacherCourseId))
AND smo.finalId=tcs.finalId
AND s.studentId=smo.studentId;


END
















CREATE DEFINER=`root`@`localhost` PROCEDURE `viewSessionalPracticalReport`(
	program_Name varchar(50),
	batch_Id smallint,
	section_Name char(2),
	student_Id mediumint,
    course_Name varchar(60)
)
BEGIN
  declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name and isPractical=1);
  
  set getSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
  where sectionId IN(getSectionId) and courseId IN(getCourseId));

select distinct p.programName, b.batchId, s.studentId,sec.sectionId,c.courseId,
c.courseName,a.toolName,sc.cloName,atcs.totalMarks,smo.marksObtained
from student s,sectionteachercoursejunction stcj,assignedtoolclosessional atcs,sessionalmarksobtained smo
join program p 
join batch b 
join section sec 
join course c
join assessmenttools a
join systemclo sc
join assignedtoolclosessional tcs
where
p.programId=s.programId AND 
b.batchId=s.batchId AND
sec.sectionId=s.sectionId AND
s.studentId IN (select studentId from student where sectionId=getSectionId
AND programId=getProgramId AND batchId=batch_Id AND studentId=student_Id)  AND
c.courseId IN (getCourseId) AND
c.courseId=stcj.courseId AND 
a.toolId=atcs.toolId AND 
sc.cloId=atcs.cloId AND 
stcj.sectionTeacherCourseId IN (getSectionTeacherCourseId)
AND atcs.sectionTeacherCourseId= stcj.sectionTeacherCourseId
AND tcs.sessionalId IN (select sessionalId from assignedtoolclosessional
where toolId=a.toolId AND cloId=sc.cloId AND sectionTeacherCourseId IN(getSectionTeacherCourseId))
AND smo.sessionalId=tcs.sessionalId
AND s.studentId=smo.studentId;
END















CREATE DEFINER=`root`@`localhost` PROCEDURE `viewSessionalTheoryReport`(
	program_Name varchar(50),
	batch_Id smallint,
	section_Name char(2),
	student_Id mediumint,
    course_Name varchar(60)
)
BEGIN

  declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name and isPractical=0);
  
  set getSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
  where sectionId IN(getSectionId) and courseId IN(getCourseId));

select distinct p.programName, b.batchId, s.studentId,sec.sectionId,c.courseId,
c.courseName,a.toolName,sc.cloName,atcs.totalMarks,smo.marksObtained
from student s,sectionteachercoursejunction stcj,assignedtoolclosessional atcs,sessionalmarksobtained smo
join program p 
join batch b 
join section sec 
join course c
join assessmenttools a
join systemclo sc
join assignedtoolclosessional tcs
where
p.programId=s.programId AND 
b.batchId=s.batchId AND
sec.sectionId=s.sectionId AND
s.studentId IN (select studentId from student where sectionId=getSectionId
AND programId=getProgramId AND batchId=batch_Id AND studentId=student_Id)  AND
c.courseId IN (getCourseId) AND
c.courseId=stcj.courseId AND 
a.toolId=atcs.toolId AND 
sc.cloId=atcs.cloId AND 
stcj.sectionTeacherCourseId IN (getSectionTeacherCourseId)
AND atcs.sectionTeacherCourseId= stcj.sectionTeacherCourseId
AND tcs.sessionalId IN (select sessionalId from assignedtoolclosessional
where toolId=a.toolId AND cloId=sc.cloId AND sectionTeacherCourseId IN(getSectionTeacherCourseId))
AND smo.sessionalId=tcs.sessionalId
AND s.studentId=smo.studentId;

END





