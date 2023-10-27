-- Instructor:
create table Instructor
(
ins_id int primary key,
ins_name varchar(50),
gender varchar(1),
birth_date date,
age as (year(getdate())-year(birth_date)),
city varchar(20),
degree varchar(20),
phone varchar(12),
salary money,
[password] varchar(8) unique,
course_id int,
branch_id int,
constraint c_gender check(gender in ('M','F'))
)
--------------------------------------------------------------------------------------------------
-- Course:
create table Course
(
course_id int primary key,
course_name varchar(50),
course_hours tinyint,
track_id int
)
---------------------------------------------------------------------------------------------------
-- Instructor & Course Relatioship:
alter table Instructor
add constraint instructor_course foreign key (course_id) references course(course_id)
---------------------------------------------------------------------------------------------------
-- Track:
create table Track
(
track_id int primary key,
track_name varchar(50),
)
---------------------------------------------------------------------------------------------------
-- Course & Track Relatioship:
alter table Course
add constraint course_track foreign key (track_id) references Track(track_id)
---------------------------------------------------------------------------------------------------
-- Branch:
create table Branchs
(
branch_id int primary key,
branch_name varchar(50),
[location] varchar(50),
)
---------------------------------------------------------------------------------------------------
-- Instructor & Branch Relationship:
alter table Instructor
add constraint instructor_branch foreign key (branch_id) references branch(branch_id)
---------------------------------------------------------------------------------------------------
-- Track_Branch:
create table Track_Branch
(
branch_id int,
track_id int,
manager_id int,
constraint composite_pk primary key (branch_id,track_id),
constraint track_branch1 foreign key (branch_id) references branchs(branch_id),
constraint track_branch2 foreign key (track_id) references track(track_id),
constraint track_branch_manager foreign key (manager_id) references instructor(ins_id),
)
---------------------------------------------------------------------------------------------------
-- Student:
create table Student 
(
st_id int primary key,
st_name varchar(50),
gender varchar(1),
birth_date date,
age as (year(getdate())-year(birth_date)),
city varchar(20),
educational_field varchar(20),
graduatin_year smallint,
graduation_grade varchar(10),
email varchar(100) unique,
phone varchar(12),
[password] varchar(8) unique,
intake smallint,
track_id int,
branch_id int,
constraint st_gender check(gender in ('M','F')),
constraint student_track foreign key (track_id) references track(track_id),
constraint student_branch foreign key (branch_id) references branchs(branch_id)
)
---------------------------------------------------------------------------------------------------
-- Freelancing:
create table Freelancing
(
st_id int,
free_id int,
[platform] varchar(30),
job_descreption varchar(250),
job_type varchar(10),
[date] date,
price money,
constraint compiste_pk2 primary key (st_id,free_id),
constraint student_freelancing foreign key (st_id) references student(st_id)
on delete cascade on update cascade
)
---------------------------------------------------------------------------------------------------
-- Certificate:
create table [Certificate] 
(
st_id int,
certi_id int,
certi_name varchar(100),
specialization varchar(50),
certificate_by varchar(50),
[date] date,
fees money,
constraint compiste_pk3 primary key (st_id,certi_id),
constraint student_crtificate foreign key (st_id) references student(st_id)
on delete cascade on update cascade
)
---------------------------------------------------------------------------------------------------
-- Student_Course:
create table Student_Course
(
st_id int,
course_id int,
attendance tinyint,
assigments tinyint,
evaluation tinyint,
constraint compiste_pk4 primary key (st_id,course_id),
constraint student_course1 foreign key (st_id) references student(st_id),
constraint student_course2 foreign key (course_id) references course(course_id),
constraint evaluation_rate check(evaluation in (1,2,3,4,5))
)
---------------------------------------------------------------------------------------------------
-- Question:
create table Question 
(
question_id int primary key,
[type] varchar(100),
question varchar(max),
choice_A varchar(max),
choice_B varchar(max),
choice_C varchar(max),
model_answer varchar(1),
course_id int,
constraint course_question foreign key (course_id) references course(course_id),
constraint que_type check([type] in('True/False','Multiple-Choice')),
constraint modelanswer check(model_answer in('A','B','C'))
)

---------------------------------------------------------------------------------------------------
-- Exam:
create table Exam
(
exam_id int primary key,
exam_date date
)
---------------------------------------------------------------------------------------------------
-- Exam_Student_Question:
create table Exam_Student_Question
(
exam_id int,
st_id int,
question_id int,
answer varchar(1),
constraint triple_composite_pk primary key(exam_id,st_id,question_id),
constraint foreign_exam foreign key (exam_id) references exam(exam_id),
constraint foreign_student foreign key (st_id) references student(st_id),
constraint foreign_question foreign key (question_id) references question(question_id),
constraint stu_answer check(answer in('A','B','C'))
)
---------------------------------------------------------------------------------------------------