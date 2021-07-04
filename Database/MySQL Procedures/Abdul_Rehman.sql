CREATE DEFINER=`root`@`localhost` PROCEDURE `addAssessmentToolFinalPractical`(
	  program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint 
)
BEGIN
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getCloId mediumint;
      declare getSectionTeacherCourseId int;
      declare isRepeat smallint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=1);
		  set getToolId=getToolId(tool_Name);  
           
             if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
	      
           set getSectionId=getSection(program_Name,batch_Id,section_Name);
		     if(getSectionId!=0) then 
    
			set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
			  
					if (!(getSectionTeacherCourseId is null)) then
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                       
					if(!(total_Marks<=0 or total_Marks is null)) then
			        set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                      if(getCloId !=0) then
                       if(isPracticalFinal(tool_Name)!=0) then
               
						  if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both')
						   OR (isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical')
							 then
                             
         set isRepeat=getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
				   
		 set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
                    
                    if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    end if;
                    
				set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null) then
                    set getFinalMarks=0;
                    set getFinalMarks=getFinalMarks+total_Marks;
                    else 
                    set getFinalMarks= getFinalMarks+total_Marks;
                    end if;
                    
				if(getFinalMarks<31) then
                   
                   if(isRepeat is null) then                   
		
							  insert into assignedtoolclofinal
							   values 
							 (default,
							 getToolId,
							 getCloId,
							 getSectionTeacherCourseId,
							 total_Marks,
                             default);
							   select 'Record has been added successfully' AS 'Message', true as 'Success';

                
                set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
			call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,20,30); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
      
		else
		select 'You have already added this record' AS 'Message', false as 'Success';
		end if;
      
       else
	select 'Total Final Makrs should not be greater than 30' AS 'Message', false AS 'Success';
	end if;
       else 
          select 'You can only add assessment tool for practical/ section you are teaching' 
          AS 'Message', false as 'Success';
       end if;
	   else 
			select 'Tool should be from Final Practical Tools' AS 'Message', false as 'Success';
	   end if;
          else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
           else
             SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
		   else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Secion not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint)
BEGIN

      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
	  declare getCloId mediumint;
      declare isRepeat smallint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	   if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=0);
		  set getToolId=getToolId(tool_Name); 
         
          set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
		
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                      set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                    if (!(total_Marks<=0 OR total_Marks is null)) then
                     set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isFinal(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory') then

                   set isRepeat=getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
				  
                   set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
                    
                    if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    end if;
                    
				   set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null) then
                    set getFinalMarks=0;
                    set getFinalMarks=getFinalMarks+total_Marks;
                    else 
                    set getFinalMarks= getFinalMarks+total_Marks;
                    end if;
                    
                    
                    if(getFinalMarks<61) then
                  
                  if(isRepeat is null) then
                   insert into assignedtoolclofinal
					values 
					 (default,
					 getToolId,
					 getCloId,
					 getSectionTeacherCourseId,
					 total_Marks,
                     default);
					   select 'Record has been added successfully' AS 'Message', true as 'Success';
                    
                
                set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
			    call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,40,60); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
    
    else 
     select 'You have already added this record' as 'Message', false as 'Success';
    end if;
     else
	select 'Total Final Makrs should not be greater than 60' AS 'Message', false AS 'Success';
	end if;
	   else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
                else
               SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
               
                else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
          select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint   
)
BEGIN
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getCloId mediumint;
      declare getSectionTeacherCourseId int;
      declare isRepeat smallint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
  
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=1);
		  set getToolId=getToolId(tool_Name);  
		  set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
           
             if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
		
			set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
			  
					if (!(getSectionTeacherCourseId is null)) then
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
                        if(isCourseCompleted=0) then
					if(!(total_Marks<=0 or total_Marks is null)) then
			          set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                      if(getCloId !=0) then
                      if(isPracticalSessional(tool_Name)!=0) then
               
						if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both'
					    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical') then 
             set isRepeat=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);
			
             set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
            
			if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    set getSessionalMarks=getSessionalMarks+total_Marks;
                    else 
                    set getSessionalMarks= getSessionalMarks+total_Marks;
                    end if;
                    
				set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
               
				if(getFinalMarks is null) then
                set getFinalMarks=0;
                end if;
                    
			if(getSessionalMarks<21) then
            
            
            if(isRepeat is null) then
					   insert into assignedtoolclosessional
					   values 
						 (default,
						 getToolId,
						 getCloId,
						 getSectionTeacherCourseId,
						 total_Marks,
                         default);
						   select 'Record has been added successfully' AS 'Message', true as 'Success';
                
                set getCountOfClo= getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
			     call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,20,30); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
            
               else
                select 'You have already added this record' AS 'Message', false as 'Success';
                end if;
      
       else
	select 'Total Sessional Makrs should not be greater than 20' AS 'Message', false AS 'Success';
	end if;
       else 
          select 'You can only add assessment tool for theory/ section you are teaching' 
          AS 'Message', false as 'Success';
       end if;
	   else 
			select 'Tool should be from Sessional Tools' AS 'Message', false as 'Success';
	   end if;
          else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
           else
             SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
			else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
          select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      total_Marks tinyint)
BEGIN
      
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare isRepeat smallint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=0);
		  set getToolId=getToolId(tool_Name); 
          set getSectionId=getSection(program_Name,batch_Id,section_Name);
		 
         if(getSectionId!=0) then 
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
               
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
              
                    if (!(getSectionTeacherCourseId is null)) then
                    
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
                       if(isCourseCompleted=0) then
                    if (!(total_Marks<=0 OR total_Marks is null)) then
                     set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isSessional(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory') then
                    
                    set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
                  
                    if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    set getSessionalMarks=getSessionalMarks+total_Marks;
                    else 
                    set getSessionalMarks= getSessionalMarks+total_Marks;
                    end if;
				    set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null)
                    then set getFinalMarks=0;
                    end if;
                    
                    if(getSessionalMarks<41) then
                    
			   
			set isRepeat=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);
			if(isRepeat is null) then
				    insert into assignedtoolclosessional
					values 
					 (default,
					 getToolId,
					 getCloId,
					 getSectionTeacherCourseId,
					 total_Marks,
                     default);
					   select 'Record has been added successfully' AS 'Message', true as 'Success';

                
                set getCountOfClo= getTotalCountOfClo(getSectionTeacherCourseId,getCloId);    
			
					call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,40,60); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);     
                       
				else
                select 'You have already added this record' AS 'Message', false as 'Success';
                end if;
	
        else
	  select 'Total Sessional Makrs should not be greater than 40' AS 'Message', false AS 'Success';
	   end if;
	   else 
			select 'You are not teaching pratical for this course' AS 'Message', false as 'Success';
	   end if;
			else 
          select 'Tool should be from sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
                else
               SELECT "Total marks should not be negative or null" AS "Message", FALSE AS "Success";
			   end if;
               else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
            select 'Section not exist' AS 'Message',false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN


      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getFinalId int;
      declare getTotalMarks tinyint;
      declare getSectionStudentCourseId int;
      declare getSectionId smallint;
      declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;
      declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=1);
		  set getToolId=getToolId(tool_Name); 
           
		set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
          
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
			 
             set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
           
                    if (!(getSectionTeacherCourseId is null)) then
                      set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                      set getCloId= isBatchCourseValidForUpdate
                     (program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isPracticalFinal(tool_Name)!=0) then
	      
            set getFinalId =getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
            if(getFinalId is not null) then
            
            set isToolConducted=isFinalToolConducted(getFinalId);
			
            if(isToolConducted=1) then
            
            set getTotalMarks=getFinalTotalMarks(getFinalId);
            
            if(marks_Obtained <= getTotalMarks AND marks_Obtained>=0) then 
             set getSectionStudentCourseId=getSectionStudentCourseId(getSectionId,student_Id,getCourseId);
             
            if(!(getSectionStudentCourseId is null)) then 
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical') then
            
            set shouldAdd=shouldAddFinalObtainedMarks(getFinalId,student_Id);
	
  
           set isValidRequest=isValidRequestForFinalObtainedMarks(getFinalId,student_Id,marks_Obtained);
             
             set shouldUpdateMarks=shouldUpdateFinalObtainedMarks(getFinalId,student_Id,marks_Obtained);
             
             if(shouldAdd is null) then 
				insert into finalmarksobtained
					values 
					 (default,
					 getFinalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update finalmarksobtained 
             set marksObtained=marks_Obtained
             where finalId=getFinalId AND studentId=student_Id;
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
        select 'Tool is not conducted, you cannot enter marks' AS 'Message', false as 'Success';
       end if;
        else 
              select 'Record does not exist' AS 'Message', false As 'Success';
              end if;
			else 
          select 'Tool should be from practical final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
		 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN


      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getFinalId int;
      declare getTotalMarks tinyint;
      declare getSectionStudentCourseId int;
      declare getSectionId smallint;
	  declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;
      declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;
      
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=0);
		  set getToolId=getToolId(tool_Name); 
          
          set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
          
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
               
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                      set getCloId= isBatchCourseValidForUpdate
                     (program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isFinal(tool_Name)!=0) then
	       
           set getFinalId =getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
		      if(getFinalId is not null) then
              
            set isToolConducted=isFinalToolConducted(getFinalId);
			
              if(isToolConducted=1) then
            
            set getTotalMarks=getFinalTotalMarks(getFinalId);
            
            if(marks_Obtained <=getTotalMarks AND marks_Obtained>=0) then 
             set getSectionStudentCourseId=getSectionStudentCourseId(getSectionId,student_Id,getCourseId);

			 if(!(getSectionStudentCourseId is null)) then 
                   
                   if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory') then
            
            set shouldAdd=shouldAddFinalObtainedMarks(getFinalId,student_Id);
             
             set shouldUpdateMarks=shouldUpdateFinalObtainedMarks(getFinalId,student_Id,marks_Obtained);

			set isValidRequest=isValidRequestForFinalObtainedMarks(getFinalId,student_Id,marks_Obtained);
       
			if(shouldAdd is null) then 
				insert into finalmarksobtained
					values 
					 (default,
					 getFinalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update finalmarksobtained 
             set marksObtained=marks_Obtained
             where finalId=getFinalId AND studentId=student_Id;
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
        select 'Tool is not conducted, you cannot enter marks' AS 'Message', false as 'Success';
       end if;
        else 
              select 'Record does not exist' AS 'Message', false As 'Success';
              end if;
			else 
          select 'Tool should be from final tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
		 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN

      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getSessionalId int;
      declare getTotalMarks tinyint;
      declare getSectionStudentCourseId int;
      declare getSectionId smallint;
	  declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;
      declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=1);
		  set getToolId=getToolId(tool_Name); 
           
          set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then  
           
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                    
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                      set getCloId= isBatchCourseValidForUpdate
                     (program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isPracticalSessional(tool_Name)!=0) then
	       set getSessionalId=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);
           if(getSessionalId is not null) then 
            
            set isToolConducted=isSessionalToolConducted(getSessionalId);
              if(isToolConducted=1) then
            
            set getTotalMarks=getSessionalTotalMarks(getSessionalId);
            
            if(marks_Obtained <= getTotalMarks AND marks_Obtained>=0) then 
             set getSectionStudentCourseId=getSectionStudentCourseId(getSectionId,student_Id,getCourseId);
	  		  if(!(getSectionStudentCourseId is null)) then 
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical') then
            
		set shouldAdd=shouldAddSessionalObtainedMarks(getSessionalId,student_Id);
            
	   set shouldUpdateMarks=shouldUpdateSessionalObtainedMarks(getSessionalId,student_Id,marks_Obtained);
            
	   set isValidRequest=isValidRequestForSessionalObtainedMarks(getSessionalId,student_Id,marks_Obtained);

             
			if(shouldAdd is null) then 
				insert into sessionalmarksobtained
					values 
					 (default,
					 getSessionalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update sessionalmarksobtained 
             set marksObtained=marks_Obtained
             where sessionalId=getSessionalId AND studentId=student_Id;
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
        select 'Tool is not conducted, you cannot enter marks' AS 'Message', false as 'Success';
       end if;
        else 
              select 'Record does not exist' AS 'Message', false As 'Success';
              end if;
			else 
          select 'Tool should be from practical sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
			 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6),
      student_Id mediumint,
      marks_Obtained decimal(5,2)
)
BEGIN

      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getSessionalId int;
      declare getTotalMarks tinyint;
      declare getSectionStudentCourseId int;
      declare getSectionId smallint;
	  declare isValidRequest int;
      declare shouldUpdateMarks int;
      declare shouldAdd int;
      declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=0);
		  set getToolId=getToolId(tool_Name); 
           
		set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
        
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                    
	                 set getCloId= isBatchCourseValidForUpdate
                     (program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isSessional(tool_Name)!=0) then
	       set getSessionalId=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);
            
            if(!(getSessionalId is null)) then
            
            set isToolConducted=isSessionalToolConducted(getSessionalId);
            if(isToolConducted=1) then
            
            set getTotalMarks=getSessionalTotalMarks(getSessionalId);
           
            if(marks_Obtained<=getTotalMarks AND marks_Obtained>=0) then 
             set getSectionStudentCourseId=getSectionStudentCourseId(getSectionId,student_Id,getCourseId);
			 if(!(getSectionStudentCourseId is null)) then 
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory') then

            set shouldAdd=shouldAddSessionalObtainedMarks(getSessionalId,student_Id);
            
			set shouldUpdateMarks=shouldUpdateSessionalObtainedMarks(getSessionalId,student_Id,marks_Obtained);
            
            set isValidRequest=isValidRequestForSessionalObtainedMarks(getSessionalId,student_Id,marks_Obtained);
  
             
			if(shouldAdd is null) then 
				insert into sessionalmarksobtained
					values 
					 (default,
					 getSessionalId,
                      student_Id,
					 marks_Obtained);
			select 'Record has been added successfully' AS 'Message', true as 'Success';
            
			elseif(shouldUpdateMarks is not null) then
             update sessionalmarksobtained 
             set marksObtained=marks_Obtained
             where sessionalId=getSessionalId AND studentId=student_Id;
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
        select 'Tool is not conducted, you cannot enter marks' AS 'Message', false as 'Success';
       end if;
       else
       select 'Tool does not exist for this CLO' AS 'Message',false as 'Success';
       end if;
			else 
          select 'Tool should be from sessional tools'AS 'Message', false as 'Success';
       end if;
         else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
		 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
        end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;
END






























CREATE DEFINER=`root`@`localhost` PROCEDURE `assignedCloMarksMetaData`(
getCountOfClo smallint,
getSectionTeacherCourseId int,
getCloId smallint
)
BEGIN
	update assignedmarksmetadata
	set 
		assessmentCountOfClo=getCountOfClo
		where 
		sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=getCloId;
END

















CREATE DEFINER=`root`@`localhost` PROCEDURE `assignedMarksMetaData`(
getSessionalMarks smallint,
getFinalMarks smallint,
getSectionTeacherCourseId int,
getRequiredSumOfSessionalMarks smallint,
getRequiredSumOfFinalMarks smallint
)
BEGIN
	update assignedmarksmetadata
	set 
		sumOfSessionalMarks=getSessionalMarks,
		sumOfFinalMarks=getFinalMarks,
        requiredSessionalMarks=getRequiredSumOfSessionalMarks,
        requiredFinalMarks=getRequiredSumOfFinalMarks
        
		where 
		sectionTeacherCourseId=getSectionTeacherCourseId;
END


















CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAssessmentToolFinalPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getTotalMarks smallint;
      declare getFinalId smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=1);
		  set getToolId=getToolId(tool_Name); 
           
          set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then  
           
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                     set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
				set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isPracticalFinal(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical') then
                      
                      
                set getFinalId=getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
						
                      if(!(getFinalId is null))
                        then 
                     
                    set getTotalMarks=getFinalTotalMarks(getFinalId);
                        
             set getSessionalMarks=(select sum(totalMarks) from assignedtoolclosessional
					where sectionTeacherCourseId=getSectionTeacherCourseId);
                  
                  if(getSessionalMarks is null) then
                     set getSessionalMarks=0;
                     end if;
                  
				set getFinalMarks=(select sum(totalMarks)-getTotalMarks from assignedtoolclofinal
					where sectionTeacherCourseId=getSectionTeacherCourseId);
				
                
                
                    if(getFinalMarks<31) then
			
					   delete from assignedtoolclofinal
					   where (
					   sectionTeacherCourseId=getSectionTeacherCourseId
					   ANd toolId=getToolId AND cloId=getCloId);
					   select 'Assessment tool of final deleted successfully' 
                       AS 'Message', true as 'Success';
                
                set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
					call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,20,30); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
	
     else
	select 'Total Final Makrs should not be greater than 30' AS 'Message', false AS 'Success';
	end if;
    
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
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
		 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getTotalMarks smallint;
      declare getFinalId smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=0);
		  set getToolId=getToolId(tool_Name); 
           
        set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then    
		
		  if (!(getCourseId is null)) then
          
			   if (!(getToolId is null)) then
               
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                    
                    set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
				set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isFinal(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory') then
                      
                    
                    set getFinalId=getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
                      
                      if(!(getFinalId is null))
                        then 
                     
                    set getTotalMarks=getFinalTotalMarks(getFinalId);
                    
                   set getSessionalMarks=(select sum(totalMarks) from assignedtoolclosessional
					where sectionTeacherCourseId=getSectionTeacherCourseId);
                    
                    if(getSessionalMarks is null) then
                     set getSessionalMarks=0;
                     end if;
                    
				    set getFinalMarks=(select sum(totalMarks)-getTotalMarks from assignedtoolclofinal
					where sectionTeacherCourseId=getSectionTeacherCourseId);   
			
                    if(getFinalMarks<61) then
			
					   delete from assignedtoolclofinal
					   where (
					   sectionTeacherCourseId=getSectionTeacherCourseId
					   ANd toolId=getToolId AND cloId=getCloId);
					   select 'Assessment tool of final deleted successfully' 
                       AS 'Message', true as 'Success';
                
                set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
					call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,40,60); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
	
      else
	select 'Total Final Makrs should not be greater than 60' AS 'Message', false AS 'Success';
	end if;
    
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
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
                else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
	  declare isCourseCompleted tinyint;
      declare getTotalMarks smallint;
      declare getSessionalId smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;

	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=1);
		  set getToolId=getToolId(tool_Name); 
           
          set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then  
           
		  if (!(getCourseId is null)) then
          
			   if (!(getToolId is null)) then
               
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
                    if (!(getSectionTeacherCourseId is null)) then
                    
                   set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                       
				set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isPracticalSessional(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical') then
                       
                   set getSessionalId=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);    
                      
                      if(!(getSessionalId is null))
                        then 
                       
                set getTotalMarks=getSessionalTotalMarks(getSessionalId);
                
					 set getSessionalMarks=(select sum(totalMarks)-getTotalMarks from assignedtoolclosessional
					where sectionTeacherCourseId=getSectionTeacherCourseId);
                    
				   set getFinalMarks=(select sum(totalMarks) from assignedtoolclofinal
					where sectionTeacherCourseId=getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null) then
                    set getFinalMarks=0;
                     end if;
                    
				 if(getSessionalMarks<21) then
                    
					   delete from assignedtoolclosessional 
					   where (
					   sectionTeacherCourseId=getSectionTeacherCourseId
					   ANd toolId=getToolId AND cloId=getCloId);
					   select 'Assessment tool of sessional deleted successfully' 
                       AS 'Message', true as 'Success';
		
                  set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
				    call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,20,30); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
   
    else
	select 'Total Sessional Makrs should not be greater than 20' AS 'Message', false AS 'Success';
	end if;
        
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
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
		 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name varchar(20),
	  clo_Name char(6)
)
BEGIN
      declare getCourseId smallint;
      declare getToolId smallint;
      declare getSectionTeacherCourseId int;
      declare getCloId mediumint;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare getTotalMarks smallint;
      declare getSessionalId smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	  if(select batchId from batch 
      where (batchId=batch_Id and isCurrent=1)) then
      
          set getCourseId=(select courseId from course where courseName=course_Name 
          and courseCode=course_Code and isPractical=0);
		  set getToolId=getToolId(tool_Name); 
           
           set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
           
		  if (!(getCourseId is null)) then
			   if (!(getToolId is null)) then
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
             
                    if (!(getSectionTeacherCourseId is null)) then
                      set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
				set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                      if(isSessional(tool_Name)!=0) then
               
                    if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' 
                    OR isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory') then
                      
                set getSessionalId=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);
		
                      if(!(getSessionalId is null))
                        then 
                     
				set getTotalMarks=getSessionalTotalMarks(getSessionalId);
             
				 
                 set getSessionalMarks=(select sum(totalMarks)-getTotalMarks from assignedtoolclosessional
					where sectionTeacherCourseId=getSectionTeacherCourseId);
                    
				set getFinalMarks=(select sum(totalMarks) from assignedtoolclofinal
					where sectionTeacherCourseId=getSectionTeacherCourseId);	
				if(getFinalMarks is null) then
                set getFinalMarks=0;
                end if;
				 
                 if(getSessionalMarks<41) then
                    
					   delete from assignedtoolclosessional 
					   where (
					   sectionTeacherCourseId=getSectionTeacherCourseId
					   ANd toolId=getToolId AND cloId=getCloId);
					   select 'Assessment tool of sessional deleted successfully' 
                       AS 'Message', true as 'Success';
                
                set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
				
					call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,40,60); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,getCloId);
   
   
   else
	select 'Total Sessional Makrs should not be greater than 40' AS 'Message', false AS 'Success';
	end if;
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
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
		 else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
        end if;
      else
			select 'Batch is not active' AS 'Message',false as 'Success';
       end if;			 
END























CREATE DEFINER=`root`@`localhost` PROCEDURE `setIsConductedValueForFinal`(
program_Name varchar(50),
batch_Id smallint,
section_Name char(2),
tool_Name varchar(20),
teacher_Id smallint,
course_Name varchar(20),
course_Code char(8),
is_Practical tinyint
)
BEGIN
  declare getSectionId smallint;
  declare getToolId tinyint;
  declare getCourseId smallint;
  declare getSectionTeacherCourseId int;


  set getSectionId=getSection(program_Name,batch_Id,section_Name);
  if(getSectionId is not null) then
   set getToolId=getToolId(tool_Name);
   if(getToolId is not null) then
     
    set getCourseId=(select courseId from course where 
    courseName=course_Name AND courseCode=course_Code AND isPractical=is_Practical);
   
      if(getCourseId is not null) then
       
       set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
 
       if(getSectionTeacherCourseId is not null) then
       
			  create temporary table temporaryfinaltable(finalId smallint);
			  insert into temporaryfinaltable(finalId)
			  select finalId from assignedtoolclofinal where
			  toolId=getToolId  AND sectionTeacherCourseId=getSectionTeacherCourseId;
  
			  update assignedtoolclofinal
			  set isConducted=1 where
			  finalId IN (select finalId from temporaryfinaltable);
			  drop temporary table temporaryfinaltable;
              
              select 'Record has been updated successfully' AS 'Message',false AS 'Success';
	
    else
    select 'You are not teaching this course to this section' AS 'Messgae',false as 'Success';
    end if;
    else
    select 'Invalid course' AS 'Messgae',false as 'Success';
    end if;

    else
    select 'Tool Name is incorrect' AS 'Messgae',false as 'Success';
    end if;
    else
    select 'Invalid section' AS 'Messgae',false as 'Success';
    end if;

END

























CREATE DEFINER=`root`@`localhost` PROCEDURE `setIsConductedValueForSessional`(
program_Name varchar(50),
batch_Id smallint,
section_Name char(2),
tool_Name varchar(20),
teacher_Id smallint,
course_Name varchar(20),
course_Code char(8),
is_Practical tinyint
)
BEGIN
  declare getSectionId smallint;
  declare getToolId tinyint;
  declare getCourseId smallint;
  declare getSectionTeacherCourseId int;

  

  set getSectionId=getSection(program_Name,batch_Id,section_Name);
  if(getSectionId is not null) then
   set getToolId=getToolId(tool_Name);
    if(getToolId is not null) then
     set getCourseId=(select courseId from course where 
	 courseName=course_Name AND courseCode=course_Code AND isPractical=is_Practical);
       if(getCourseId is not null) then
 
         set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);
    
            if(getSectionTeacherCourseId is not null) then
  
			  create temporary table temporarysessionaltable(sessionalId smallint);
			  insert into temporarysessionaltable(sessionalId)
			  select sessionalId from assignedtoolclosessional where
			  toolId=getToolId  AND sectionTeacherCourseId=getSectionTeacherCourseId;
  
				  update assignedtoolclosessional
				  set isConducted=1 where
				  sessionalId IN (select sessionalId from temporarysessionaltable);
				  
				  drop temporary table temporarysessionaltable;
			
            select 'Record has been updated successfully' AS 'Message',false AS 'Success';
	else
    select 'You are not teaching this course to this section' AS 'Messgae',false as 'Success';
    end if;
    else
    select 'Invalid course' AS 'Messgae',false as 'Success';
    end if;
    else
    select 'Tool Name is incorrect' AS 'Messgae',false as 'Success';
    end if;
    else
    select 'Invalid section' AS 'Messgae',false as 'Success';
    end if;

END



























CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAssessmentToolFinalPractical`(
      program_Name varchar(50),
      batch_Id smallint,
      teacher_Id smallint,
      course_Name varchar(20),
      course_Code char(8),
      section_Name char(2),
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
      declare getCourseId smallint;
	  declare getToolId smallint;
      declare newGetToolId smallint;
      declare getCloId mediumint;
      declare newGetCloId smallint;
      declare getSectionTeacherCourseId int;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare getPreviousCountOfClo smallint;
      declare getPreviousSessionalCountOfClo smallint;
      declare getPreviousFinalCountOfClo smallint;
	  declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;
      declare shouldUpdate smallint;
      declare getFinalId smallint;
      declare getTotalMarks smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set getCourseId=(select courseId from course where courseName=course_Name 
         and courseCode=course_Code and isPractical=1);
		 set getToolId=getToolId(tool_Name);
		 set newGetToolId=getToolId(new_Tool_Name);
	
        set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
    
          if (!(getCourseId is null)) then
		      
              if (!(getToolId is null))then 
        
		         if (!(newGetToolId is null))then 
			
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);  
             
		      if (!(getSectionTeacherCourseId is null)) then 
					
                    set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                        
		          if (!(total_Marks<=0 OR total_Marks is null)) then
				set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     if(getCloId !=0) then
                     
                     
                   set getFinalId=getFinalId(getToolId,getCloId,getSectionTeacherCourseId);

                        	 if(!(getFinalId is null)) then 
                        
					set getTotalMarks=getFinalTotalMarks(getFinalId);
                         
                         set isToolConducted=isFinalToolConducted(getFinalId);
						if(isToolConducted=0) then
                         
					set newGetCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,new_Clo_Name);
                     if(newGetCloId !=0) then	
	              	if(isPracticalFinal(tool_Name)!=0) then
                      if(isPracticalFinal(new_Tool_Name)!=0) then
					
                      if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical')
					  then 
					   
                  set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
                  
                   if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    end if;
                   
				set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null) then
                    set getFinalMarks=0;
                    set getFinalMarks=getFinalMarks+total_Marks;
                    else 
                    set getFinalMarks= getFinalMarks+total_Marks-getTotalMarks;
                    end if;
				
                if(getFinalMarks<31) then


                     set shouldUpdate=getFinalId(newGetToolId,newGetCloId,getSectionTeacherCourseId);

					   if(shouldUpdate is null OR shouldUpdate=getFinalId) then
                       update assignedtoolclofinal
					   set 
							toolId=newGetToolId,
							cloId=newGetCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=getSectionTeacherCourseId
								ANd 
							toolId=getToolId
                            AND cloId=getCloId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
                      
                   set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,newGetCloId);
                    
				   set getPreviousCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
                    
				 call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,20,30); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,newGetCloId);      
		
		
                    update assignedmarksmetadata
                      set 
                     sumOfSessionalMarks=getSessionalMarks,
                     sumOfFinalMarks=getFinalMarks,
                     assessmentCountOfClo=getPreviousCountOfClo
                     where 
                     sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=getCloId;
    
    
    else
	select 'Record already exist' AS 'Message', false AS 'Success';
	end if; 
    
    
     else
	select 'Total Final Makrs should not be greater than 30' AS 'Message', false AS 'Success';
	end if;
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
              select 'Tool has been conducted so can not update it' AS 'Message', false as 'Success';
              end if;
			else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
         
			else
			SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
	      else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
	  declare getCourseId smallint;
	  declare getToolId smallint;
      declare newGetToolId smallint;
      declare getCloId mediumint;
      declare newGetCloId mediumint;
      declare getSectionTeacherCourseId int;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare getPreviousCountOfClo smallint;
      declare getPreviousSessionalCountOfClo smallint;
      declare getPreviousFinalCountOfClo smallint;
	  declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;
      declare shouldUpdate smallint;
      declare getFinalId smallint;
      declare getTotalMarks smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set getCourseId=(select courseId from course where courseName=course_Name 
         and courseCode=course_Code and isPractical=0);
		 set getToolId=getToolId(tool_Name);
		 set newGetToolId=getToolId(new_Tool_Name);
	
         set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
    
          if (!(getCourseId is null)) then
		      
              if (!(getToolId is null))then 
        
		         if (!(newGetToolId is null))then 
			
			
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);  
             
		      if (!(getSectionTeacherCourseId is null)) then 
						
					set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                       
		          if (!(total_Marks<=0 OR total_Marks is null)) then
			        set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                     
                     if(getCloId !=0) then
                    
                    
                     set getFinalId=getFinalId(getToolId,getCloId,getSectionTeacherCourseId);
                        
                        if(!(getFinalId is null)) then
						
                        
					set getTotalMarks=getFinalTotalMarks(getFinalId);
                    
                    set isToolConducted=isFinalToolConducted(getFinalId);
						if(isToolConducted=0) then
                    
                    set newGetCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,new_Clo_Name);
                     if(newGetCloId !=0) then
	              	if(isFinal(tool_Name)!=0) then
                      if(isFinal(new_Tool_Name)!=0) then
					
                      if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory')
					  then 
					   
					set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
				
                    if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    end if;
                    
				set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null) then
                    set getFinalMarks=0;
                    set getFinalMarks=getFinalMarks+total_Marks;
                    else 
                    set getFinalMarks= getFinalMarks+total_Marks-getTotalMarks;
                    end if;
					
                    
                    if(getFinalMarks<61) then
                       
                       
					set shouldUpdate=getFinalId(newGetToolId,newGetCloId,getSectionTeacherCourseId);
                       
                       if(shouldUpdate is null OR shouldUpdate=getFinalId) then
                       update assignedtoolclofinal
					   set 
							toolId=newGetToolId,
							cloId=newGetCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=getSectionTeacherCourseId
								ANd 
							toolId=getToolId
                            AND cloId=getCloId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
                      
		
                    set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,newGetCloId);
                    
				   set getPreviousCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
        
                   call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,40,60); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,newGetCloId);
                    
                    
                    update assignedmarksmetadata
                      set 
                     sumOfSessionalMarks=getSessionalMarks,
                     sumOfFinalMarks=getFinalMarks,
                     assessmentCountOfClo=getPreviousCountOfClo
                     where 
                     sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=getCloId;
               
		else
	select 'Record already exist' AS 'Message', false AS 'Success';
	end if; 
     
      else
	select 'Total Final Makrs should not be greater than 60' AS 'Message', false AS 'Success';
	end if;
               
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
              select 'Tool has been conducted so can not update it' AS 'Message', false as 'Success';
              end if;
               else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
			  else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
		   else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
      declare getCourseId smallint;
	  declare getToolId smallint;
      declare newGetToolId smallint;
      declare getCloId mediumint;
      declare newGetCloId smallint;
      declare getSectionTeacherCourseId int;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare getPreviousCountOfClo smallint;
      declare getPreviousSessionalCountOfClo smallint;
      declare getPreviousFinalCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;
      declare shouldUpdate smallint;
      declare getSessionalId smallint;
      declare getTotalMarks smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set getCourseId=(select courseId from course where courseName=course_Name 
         and courseCode=course_Code and isPractical=1);
		 set getToolId=getToolId(tool_Name);
		 set newGetToolId=getToolId(new_Tool_Name);

	   set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
          
          if (!(getCourseId is null)) then
		      
              if (!(getToolId is null))then 
        
		         if (!(newGetToolId is null))then 
			
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);  
             
		      if (!(getSectionTeacherCourseId is null)) then 
			         set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                       
		          if (!(total_Marks<=0 OR total_Marks is null)) then
			       set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                    if(getCloId !=0) then
                    
                      set getSessionalId=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);

					   set getTotalMarks=getSessionalTotalMarks(getSessionalId);
                    
                         if(!(getSessionalId is null)) then 
                         
                          set isToolConducted=isSessionalToolConducted(getSessionalId);
						if(isToolConducted=0) then
                         
                    set newGetCloId=isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,new_Clo_Name);
                     if(newGetCloId !=0) then
                     
	              	if(isPracticalSessional(tool_Name)!=0) then
                      if(isPracticalSessional(new_Tool_Name)!=0) then
					
                      if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,getSectionId,course_Name)='Practical')
					  then 
					   
					set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
                    
                    if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    set getSessionalMarks=getSessionalMarks+total_Marks;
                    else 
                    set getSessionalMarks= getSessionalMarks+total_Marks-getTotalMarks;
                    end if;
                    
				    set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                      
					if(getFinalMarks is null) then
                    set getFinalMarks=0;
                    end if;
                       
				    if(getSessionalMarks<21) then
                       
                       set shouldUpdate=getSessionalId(newGetToolId,newGetCloId,getSectionTeacherCourseId);
                     
                     if(shouldUpdate is null OR shouldUpdate=getSessionalId) then
                     
                     update assignedtoolclosessional 
					   set 
							toolId=newGetToolId,
							cloId=newGetCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=getSectionTeacherCourseId
								ANd 
							toolId=getToolId
                            AND 
                            cloId=getCloId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
                   
                 set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,newGetCloId);
                    
				 set getPreviousCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
                    call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,20,30); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,newGetCloId);
                     
                     update assignedmarksmetadata
					 set 
                     assessmentCountOfClo=getPreviousCountOfClo
                     where 
                     sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=getCloId;  
	
    

		else
	select 'Record already exist' AS 'Message', false AS 'Success';
	end if; 
      	
        else
	         select 'Total Sessional Makrs should not be greater than 20' AS 'Message', false AS 'Success';
	       end if;
					
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
              select 'Tool has been conducted so can not update it' AS 'Message', false as 'Success';
              end if;
              
                else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
             
				else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if;
         else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
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
      course_Code char(8),
      section_Name char(2),
      tool_Name  varchar(20),
      new_Tool_Name varchar(20),
      clo_Name char(6),
      new_Clo_Name char(6),
      total_Marks tinyint
)
BEGIN
      
      declare getCourseId smallint;
	  declare getToolId smallint;
      declare newGetToolId smallint;
      declare getCloId mediumint;
      declare newGetCloId smallint;
      declare getSectionTeacherCourseId int;
      declare getSectionId smallint;
	  declare getSessionalMarks smallint;
      declare getFinalMarks smallint;
      declare getCountOfClo smallint;
      declare getPreviousCountOfClo smallint;
      declare getPreviousSessionalCountOfClo smallint;
      declare getPreviousFinalCountOfClo smallint;
      declare isCourseCompleted tinyint;
      declare isToolConducted tinyint;
      declare shouldUpdate smallint;
      declare getSessionalId smallint;
      declare getTotalMarks smallint;
      declare getSessionalCountOfClo smallint;
      declare getFinalCountOfClo smallint;
      
	 if(select batchId from batch 
	 where (batchId=batch_Id and isCurrent=1)) then
		 
         set getCourseId=(select courseId from course where courseName=course_Name 
         and courseCode=course_Code and isPractical=0);
		 
         set getToolId=getToolId(tool_Name);
		 set newGetToolId=getToolId(new_Tool_Name);
	  
      set getSectionId=getSection(program_Name,batch_Id,section_Name);
		  if(getSectionId!=0) then 
    
          if (!(getCourseId is null)) then
		      
              if (!(getToolId is null))then 
        
		         if (!(newGetToolId is null))then 
			
			 set getSectionTeacherCourseId=getSectionTeacherCourseId(getSectionId,teacher_Id,getCourseId);  
             
		      if (!(getSectionTeacherCourseId is null)) then 
		         
                  set  isCourseCompleted=isCourseCompleted(getSectionTeacherCourseId);
					   if(isCourseCompleted=0) then
                       
                 if (!(total_Marks<=0 OR total_Marks is null)) then
			      set getCloId= isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,clo_Name);
                   
                   if(getCloId !=0) then
			
                    set getSessionalId=getSessionalId(getToolId,getCloId,getSectionTeacherCourseId);

					set getTotalMarks=getSessionalTotalMarks(getSessionalId);
				
                        if(getSessionalId is not null) then
                           
						set isToolConducted=isSessionalToolConducted(getSessionalId);
						if(isToolConducted=0) then
                        
                   
	              	set newGetCloId=isBatchCourseValidForUpdate(program_Name,getCourseId,batch_Id,new_Clo_Name);
                     if(newGetCloId !=0) then
                    if(isSessional(tool_Name)!=0) then
                    
                     if(isSessional(new_Tool_Name)!=0) then 
					
                      if(isTeacherValid(teacher_Id,getSectionId,course_Name)='Both' OR
                          isTeacherValid(teacher_Id,getSectionId,course_Name)='Theory')
                     then
                     
                      set getSessionalMarks=getSumOfSessionalMarks(getSectionTeacherCourseId);
				
                    if(getSessionalMarks is null) then
                    set getSessionalMarks=0;
                    set getSessionalMarks=getSessionalMarks+total_Marks;
                    else 
                    set getSessionalMarks= getSessionalMarks+total_Marks-getTotalMarks;
                    end if;
                    
				set getFinalMarks=getSumOfFinalMarks(getSectionTeacherCourseId);
                    
                    if(getFinalMarks is null) then
                    set getFinalMarks=0;
                    end if;
                    
				if(getSessionalMarks<41) then
			
                    set shouldUpdate=getSessionalId(newGetToolId,newGetCloId,getSectionTeacherCourseId);
		
                       if(shouldUpdate is null OR shouldUpdate=getSessionalId) then
					   update assignedtoolclosessional 
					   set 
							toolId=newGetToolId,
							cloId=newGetCloId,
							totalMarks=total_Marks
					   where(
							sectionTeacherCourseId=getSectionTeacherCourseId
								ANd 
							toolId=getToolId
                            AND 
                              cloId=getCloId);
				      select 'Record has been upated successfully' AS 'Message', true as 'Success';
                      
                
                   set getCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,newGetCloId);
                    
				   set getPreviousCountOfClo=getTotalCountOfClo(getSectionTeacherCourseId,getCloId);
                    
                    call assignedMarksMetaData(getSessionalMarks,getFinalMarks,
                    getSectionTeacherCourseId,40,60); 
                    
                    call assignedCloMarksMetaData(getCountOfClo,getSectionTeacherCourseId,newGetCloId);
                     
                     update assignedmarksmetadata
					  set 
                     sumOfSessionalMarks=getSessionalMarks,
                     sumOfFinalMarks=getFinalMarks,
                     assessmentCountOfClo=getPreviousCountOfClo
                     where 
                     sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=getCloId;
                     
                     
    
    else
	select 'Record already exist' AS 'Message', false AS 'Success';
	end if; 
      
	else
	select 'Total Sessional Makrs should not be greater than 40' AS 'Message', false AS 'Success';
	end if;
                      
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
              select 'Tool has been conducted so can not update it' AS 'Message', false as 'Success';
              end if;
              		  else
		  SELECT "Tool name is not found so can not update it " AS "Message", FALSE AS "Success";
		  end if;
				else
               SELECT "CLO not exist for this program" AS "Message", FALSE AS "Success";
			   end if;
            else
            SELECT "Total marks can not be negative" AS "Message", FALSE AS "Success";
			end if; 
             else
               SELECT "Course is completed" AS "Message", FALSE AS "Success";
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
           select 'Section not exist' AS 'Message', false as 'Success';
        end if;
	else
	select 'Batch is not active' AS 'Message',false as 'Success';
	end if;
END
























CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAssignedMarksMetaData`(
getSessionalMarks smallint,
getFinalMarks smallint,
getCountOfClo smallint,
getSectionTeacherCourseId int,
newgetCloId smallint,
getRequiredSumOfSessionalMarks smallint,
getRequiredSumOfFinalMarks smallint
)
BEGIN

	update assignedmarksmetadata
	set 
		sumOfSessionalMarks=getSessionalMarks,
		sumOfFinalMarks=getFinalMarks,
		assessmentCountOfClo=getCountOfClo,
        requiredSessionalMarks=getRequiredSumOfSessionalMarks,
        requiredFinalMarks=getRequiredSumOfFinalMarks
        
		where 
		sectionTeacherCourseId=getSectionTeacherCourseId AND cloId=newgetCloId;
END























CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAssessmentCriteria`(
student_Id mediumint,
course_Name varchar(60),
course_Code char(8),
is_Practical tinyint
)
BEGIN

declare getSectionId smallint;
declare getSectionTeacherCourseId int;
declare getCourseId smallint;

set getCourseId=(select courseId from course where courseName=course_Name 
and courseCode=course_Code and isPractical=is_Practical);

set getSectionId=(select sectionId from student where 
studentId IN (student_Id)); 

set getSectionTeacherCourseId=(select sectionTeacherCourseId from sectionteachercoursejunction
where sectionId IN(getSectionId) and courseId IN(getCourseId));

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
where stcj.sectionTeacherCourseId IN (getSectionTeacherCourseId) AND tcs.sectionTeacherCourseId= stcj.sectionTeacherCourseId

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
where stcj.sectionTeacherCourseId IN (getSectionTeacherCourseId) AND tcf.sectionTeacherCourseId= stcj.sectionTeacherCourseId;
END




















CREATE DEFINER=`root`@`localhost` PROCEDURE `viewFinalPracticalReport`(
	program_Name varchar(50),
	batch_Id smallint,
	section_Name char(2),
	student_Id mediumint,
    course_Name varchar(60),
    course_Code char(8)
)
BEGIN

 declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name 
  and courseCode=course_Code and isPractical=1);
  
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
    course_Name varchar(60),
    course_Code char(8)
)
BEGIN

  declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name
  and courseCode=course_Code and isPractical=0);
  
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
    course_Name varchar(60),
    course_Code char(8)
)
BEGIN
  declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name
  and courseCode=course_Code and isPractical=1);
  
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
    course_Name varchar(60),
    course_Code char(8)
)
BEGIN

  declare getProgramId smallint;
  declare getSectionId smallint;
  declare getSectionTeacherCourseId smallint;
  declare getCourseId smallint;
  
  set getProgramId=(select programId from program where programName=program_Name);
  set getSectionId=(select sectionId from section where sectionName=section_Name 
  AND batchId=batch_Id AND programId=getProgramId);
  set getCourseId=(select courseId from course where courseName=course_Name 
  and courseCode=course_Code and isPractical=0);
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `addAdmin`(admin_email VARCHAR(50), 
admin_name VARCHAR(50), 
program_id TINYINT,
gender CHAR(6), 
admin_password VARCHAR(20))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT "Something went wrong" AS "Message", FALSE AS "Success";
    END;
    IF gender = 'Male' OR gender = 'Female' THEN
		START TRANSACTION;
		SET autocommit = 0;
		
        INSERT INTO `obe-as-a-service`.`admin`
		(`programId`, `adminEmail`, `adminName`, `adminGender`)
		VALUES
		(program_id, admin_email, admin_name, gender);
        
        INSERT INTO `obe-as-a-service`.`adminpassword`
		(`adminId`, `adminPassword`) VALUES
		(LAST_INSERT_ID(), generateSecurePassword(admin_password));
        
        SELECT "Admin has been added" AS "Message", TRUE AS "Success";
        
        COMMIT;
    ELSE
		SELECT "Incorrect information" AS "Message", FALSE AS "Success";
	END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `addTeacher`(teacher_email VARCHAR(50), 
teacher_name VARCHAR(50), 
program_id TINYINT, 
designation VARCHAR(30), 
gender CHAR(6), 
teacher_password VARCHAR(20))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT "Something went wrong" AS "Message", FALSE AS "Success";
    END;
    IF gender = 'Male' OR gender = 'Female' THEN
		START TRANSACTION;
		SET autocommit = 0;
		
        INSERT INTO `obe-as-a-service`.`teacher`
		(`teacherEmail`,`teacherName`,`programId`,`teacherDesignationId`,`teacherGender`)
		VALUES
		(teacher_email, teacher_name, program_id, designation, gender);
        
        INSERT INTO `obe-as-a-service`.`teacherpassword`
		(`teacherId`, `teacherPassword`)
		VALUES
		(LAST_INSERT_ID(), generateSecurePassword(teacher_password));
        
        SELECT "Teacher has been added" AS "Message", TRUE AS "Success";
        
        COMMIT;
    ELSE
		SELECT "Something went wrong" AS "Message", FALSE AS "Success";
	END IF;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `addOBECellMember`(email VARCHAR(50), obe_name VARCHAR(50), gender CHAR(6), program_id TINYINT,
obe_password VARCHAR(20))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT "Something went wrong" AS "Message", FALSE AS "Success";
    END;
    IF gender = 'Male' OR gender = 'Female' THEN
		START TRANSACTION;
		SET autocommit = 0;
		
        INSERT INTO `obe-as-a-service`.`obecell`
		(`programId`, `obeEmail`, `obeName`, `obeGender`)
		VALUES
		(program_id, email, obe_name, gender);
        
        INSERT INTO `obe-as-a-service`.`obepassword`
		(`obeId`, `obePassword`)
		VALUES
		(LAST_INSERT_ID(), generateSecurePassword(obe_password));
        
        SELECT "OBE Cell memeber has been added" AS "Message", TRUE AS "Success";
        
        COMMIT;
    ELSE
		SELECT "Something went wrong" AS "Message", FALSE AS "Success";
	END IF;
END