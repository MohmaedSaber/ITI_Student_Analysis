--------------------------------------------------------INSTRUCTOR--------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_instuctor on instructor
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_instructor on instructor
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_instructor on instructor
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------COURSE----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_course on course
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_course on course
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_course on course
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------TRACK----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_track on track
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_track on track
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_track on track
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------BRANCHES----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_branch on branches
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_branch on branches
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_branch on branches
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------BRANCHE_TRACK----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_branch_track on branch_track
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_branch_track on branch_track
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_branch_track on branch_track
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------STUDENT----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_student on student
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_student on student
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_student on student
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------FREELANCING----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_freelancing on freelancing
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_freelancing on freelancing
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_freelancing on freelancing
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------CERTIFICATE----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_certificate on [certificate]
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_certificate on [certificate]
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_certificate on [certificate]
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------STUDENT_COURSE----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_student_course on student_course
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_student_course on student_course
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_student_course on student_course
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------QUESTION----------------------------------------------------------:
--AFTER INSERT:
create trigger after_insert_question on question
after insert
as
  select * from inserted

--AFTER DELETE:
create trigger after_delete_question on question
after delete
as
  select * from deleted

--AFTER UPDATE:
create trigger after_update_question on question
after update
as
  select * from deleted
  union all
  select * from inserted
---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------Exam_Student_Question----------------------------------------------------------:
--AFTER UPDATE:
create trigger after_update_Exam_Student_Question on Exam_Student_Question
after update
as
  if update (answer)
    select * from inserted