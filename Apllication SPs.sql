-- SP for Exam Generation:
alter proc Generate_Exam @st_id int, @course_name varchar(250)
as
  begin
   if exists(select * from student where st_id=@st_id)
    begin
	 if @course_name in (select c.course_name from student S inner join Track T
	           on t.track_id=s.track_id inner join Course C
			   on t.track_id=c.track_id
			   where st_id=@st_id)
	  begin
	   create table #Exam_temp (
	   question_id int,
	   question varchar(max),
	   choice_A varchar(max),
	   choice_B varchar(max),
	   choice_C varchar(max)
	   );
	   insert into #Exam_temp
	   select top(5) q.question_id,q.question,q.choice_A,q.choice_B,q.choice_C from Question Q inner join Course C
	   on c.course_id=q.course_id
	   where c.course_name=@course_name and q.[type]='Multiple-Choice'
	   order by newid()

       insert into #Exam_temp
	   select top(5) q.question_id,q.question,q.choice_A,q.choice_B,q.choice_C from Question Q inner join Course C
	   on c.course_id=q.course_id
	   where c.course_name=@course_name and q.[type]='True/False '
	   order by newid()
	   ;
	   select * from #Exam_temp
	   
	   insert into Exam (exam_date) values(getdate())
	   
	   insert into Exam_Student_Question (exam_id,question_id)
	   select e.exam_id,et.question_id from Exam E, #Exam_temp ET
	   where e.exam_id=ident_current('Exam')

	   update Exam_Student_Question
	   set st_id=@st_id
	   where exam_id=ident_current('Exam')

	   select exam_id from Exam
	   where exam_id=ident_current('Exam')

	  end
	 else
	  begin
	   select 'The student ID does not applied for this Course'
	  end
	end
   else
    begin
	 select 'The student ID is not existed'
	end
  end

Generate_Exam 3,'working with data'

select * from Exam_Student_Question
where exam_id=2016
--select * from Exam
---------------------------------------------------------------------------------------------------------------------------------------------
-- SP for Exam Answers: 
alter proc Exam_Answers @exam_id int, @st_id int, @question_id int, @answer varchar(1)
as
  begin
   update Exam_Student_Question
   set answer=@answer
   where exam_id=@exam_id and st_id=@st_id and question_id=@question_id
  end

Exam_Answers 2017,3,18,'A'
---------------------------------------------------------------------------------------------------------------------------------------------
-- SP for Exam Correction:
alter proc Exam_Correction @exam_id int, @st_id int, @question_id int
as
  begin
   declare @model_answer varchar(1)=(select model_answer from Question where question_id=@question_id)
   declare @student_answer varchar(1)=(select answer from Exam_Student_Question where exam_id=@exam_id and st_id=@st_id and question_id=@question_id)
   if @model_answer=@student_answer
    begin
	 update Exam_Student_Question
	 set grade=1
	 where exam_id=@exam_id and st_id=@st_id and question_id=@question_id
	end
   else
	begin
	 update Exam_Student_Question
	 set grade=0
	 where exam_id=@exam_id and st_id=@st_id and question_id=@question_id  
	end;
   select count(question_id) as [Exam grdae], sum(grade) as [Student grade] from Exam_Student_Question
   where exam_id=@exam_id and st_id=@st_id
   group by exam_id,st_id
  end

Exam_Correction 2019,3,18

select e.*,q.model_answer from Exam_Student_Question E inner join Question Q
on q.question_id=e.question_id
where exam_id=2010
---------------------------------------------------------------------------------------------------------------------------------------------