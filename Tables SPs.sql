--------------------------------------------------------------Instructor-------------------------------------------------------------------------:
--Insert:
create proc new_instructor @id int,@name varchar(100),@gender varchar(1),@birth_date date,
@degree varchar(50),@phone varchar(11),@salary money,@password varchar(10),@course_id int,@branch_id int
as
  begin
   if not exists(select * from Instructor where ins_id=@id)
    begin
	 if @gender in ('M','F')
	  begin
	   if not exists(select * from Instructor where phone=@phone)
	    begin
		 declare @phone_length int=len(@phone)
		 if @phone_length=11
		  begin
		   if not exists(select * from Instructor where [password]=@password)
		    begin
			 declare @password_length int=len(@password)
			 if @password_length<=10
			  begin
			   if exists(select * from course where course_id=@course_id)
			    begin
				 if exists(select * from branches where branch_id=@branch_id)
				  begin
				   insert into instructor (ins_id,ins_name,gender,birth_date,degree,phone,salary,[password],course_id,branch_id)
				   values (@id, @name, @gender, @birth_date, @degree, @phone, @salary, @password, @course_id, @branch_id)
				  end
				 else
				  begin
				   select 'The branch ID is not existed'
				  end
				end
			   else
			    begin
				 select 'The course Id is not existed'
				end
			  end
			 else
			  begin
			   select 'The Password must contains at most 10 characters (letters,numbers and special characters)'
			  end
			end
		   else
		    begin
			 select 'The password is already existed'
			end
		  end
		 else
		  begin
		   select 'The phone number shoulb be consists of (11) numbers'
		  end
		end
	   else
	    begin
		 select'The Phone number is already existed'
		end
	  end
	 else
	  begin
	   select 'Gender should be (M) for males and (F) for females'
	  end
	end
   else
    begin
	 select 'The instructor ID is already existed'
	end
  end
						 
new_instructor 105,'Omar Hasheen','males','8/7/1991','master','01227888204',12000,'78up036d',1,1
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_instructor @id int,@name varchar(100),@gender varchar(1),@birth_date date,
@degree varchar(50),@phone varchar(11),@salary money,@password varchar(10),@course_id int,@branch_id int
as
  begin
   if exists(select * from Instructor where ins_id=@id)
    begin
	 if @gender in ('M','F')
	  begin
	   if not exists(select * from Instructor where phone=@phone)
	    begin
		 declare @phone_length int=len(@phone)
		 if @phone_length=11
		  begin
		   if not exists(select * from Instructor where [password]=@password)
		    begin
			 declare @password_length int=len(@password)
			 if @password_length<=10
			  begin
			   if exists(select * from course where course_id=@course_id)
			    begin
				 if exists(select * from branches where branch_id=@branch_id)
				  begin
				   update Instructor
	               set ins_name=@name, gender=@gender, birth_date=@birth_date, degree=@degree,phone=@phone,
	               salary=@salary, [password]=@password, course_id=@course_id, branch_id=@branch_id
	               where ins_id=@id
				  end
				 else
				  begin
				   select 'The branch ID is not existed'
				  end
				end
			   else
			    begin
				 select 'The course Id is not existed'
				end
			  end
			 else
			  begin
			   select 'The Password must contains at most 10 characters (letters,numbers and special characters)'
			  end
			end
		   else
		    begin
			 select 'The password is already existed'
			end
		  end
		 else
		  begin
		   select 'The phone number shoulb be consists of (11) numbers'
		  end
		end
	   else
	    begin
		 select'The Phone number is already existed'
		end
	  end
	 else
	  begin
	   select 'Gender should be (M) for males and (F) for females'
	  end
	end
   else
    begin
	 select 'The instructor ID is not existed'
	end
  end

update_instructor 105,'Omar Hasheen','M','8/7/1991','master','01227888236',12000,'78u7436d',1,1
-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_Instructor @id int
as
  begin
   if exists(select * from instructor where ins_id=@id)
    begin
	 if not exists(select * from branch_track where manager_id=@id)
	  begin
	   delete from instructor
	   where ins_id=@id
	  end
	 else
	  begin
	   select 'The Instructor ID can not be deleted because it belongs to a manager of some track'
	  end
	end
   else
    begin
	 select 'The Instructor ID is not existed'
	end
  end

delete_instructor 105
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_instructor @id int
as
  begin
    if exists (select ins_id from Instructor where ins_id=@id)
	 begin
	   select I.*, c.course_name, t.track_name, b.branch_name from Instructor I inner join Course C
	   on c.course_id = i.course_id inner join Track T
	   on t.track_id = c.track_id inner join Branches B
	   on b.branch_id = i.branch_id
	   where ins_id=@id
	 end
	else
	 begin
	   select 'This instructor ID is not existed'
	 end
  end

gets_instructor 101
-------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------Course-------------------------------------------------------------------------:
--Insert:
create proc new_course @id int,@name varchar(250),@hours int,@track_id int
as
  begin
   if not exists(select * from Course where course_id=@id)
    begin
	 if exists(select * from Track where track_id=@track_id)
	  begin
	   insert into Course
	   values(@id, @name, @hours, @track_id)
	  end
	 else
	  begin
	   select 'The Track ID is not existed'
	  end
	end
   else
    begin
	 select 'The Course ID is already existed'
	end
  end

new_course 55,'jadhiuailfhq;i',25,50

-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_course @id int,@name varchar(250),@hours int,@track_id int
as
  begin
   if exists(select * from Course where course_id=@id)
    begin
	 if exists(select * from Track where track_id=@track_id)
	  begin
	   update Course
	   set course_name=@name, @hours=@hours, track_id=@track_id
	   where course_id=@id
	  end
	 else
	  begin
	   select 'The Track ID is not existed'
	  end
	end
   else
    begin
	 select 'The Course ID is not existed'
	end
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_course @id int
as
  begin
   if exists(select * from Course where course_id=@id)
    begin
	 if not exists(select * from Instructor where course_id=@id) and not exists(select * from Student_Course where course_id=@id) and not exists(select * from Question where course_id=@id)
	  begin
	   delete from Course
	   where course_id=@id
	  end
	 else
	  begin
	   select 'The Course ID can not be deleted because it has childs in other tables'
	  end
	end
   else
    begin
	 select 'The Course ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_Course @id int
as
  begin
    if exists (select course_id from Course where course_id=@id)
	 begin
	   select c.*, t.track_name, b.branch_name from Course C inner join Track T
	   on t.track_id = c.track_id inner join Branch_Track BT
	   on t.track_id = bt.track_id inner join Branches B
	   on b.branch_id = bt.branch_id
	   where course_id=@id
	 end
	else
	 begin
	   select 'This Course ID is not existed'
	 end
  end

gets_course 6
-------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------Track-------------------------------------------------------------------------:
--Insert:
create proc new_track @id int, @name varchar(100)
as
  begin
   if not exists(select * from Track where track_id=@id)
    begin
	 insert into Track
	 values(@id,@name)
	end
   else
    begin
	 select 'The Track ID is already existed'
	end
  end

new_track 20,'cgasuchal'

-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_track @id int, @name varchar(100)
as
  begin
   if exists(select * from Track where track_id=@id)
    begin
	 update Track
	 set track_name=@name
	 where track_id=@id
	end
   else
    begin
	 select 'The Track ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_Track @id int
as
  begin
   if exists(select * from Track where track_id=@id)
    begin
	 if not exists(select * from Course where track_id=@id) and not exists(select * from student where track_id=@id) and not exists(select * from Branch_Track where track_id=@id)
	  begin
	   delete from Track
	   where track_id=@id
	  end
	 else
	  begin
	   select 'The Track ID can not be deleted because it has childs in other tables'
	  end
	end
   else
    begin
	 select 'The Track ID is not existed'
	end
  end

delete_track 4
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_Track @id int
as
  begin
   if exists(select * from Track where track_id=@id)
    begin
	 select * from Track where track_id=@id
	end
   else
    begin
	 select 'The Track Id is not existed'
	end
  end

gets_track 1
-------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------Student-------------------------------------------------------------------------:
--Insert:
create proc insert_student
@id int,
@name varchar(50) ,
@gender varchar(50),
@birth_date date,
@city varchar(50),
@edu_filed varchar(50),
@gradytion_year int,
@gradution_grade varchar(50),
@email varchar(50),
@phone varchar(50),
@password  varchar(50),
@intake int,
@track_id int,
@branch_id int

as
  begin
   if not exists(select * from student where st_id=@id)
    begin
	 if @gender in ('M','F')
	  begin
	   if not exists(select * from student where phone=@phone)
	    begin
		 declare @phone_length int=len(@phone)
		 if @phone_length=11
		  begin
		   if not exists(select * from student where password=@password)
		    begin
			 declare @password_length int=len(@password)
			 if @password_length<=10
			  begin
			   if exists(select * from Track where track_id=@track_id)
			    begin
				 if exists(select * from branches where branch_id=@branch_id)
				  begin
				    insert into student values(@id,@name,@gender,@birth_date,@city ,@edu_filed,@gradytion_year,@gradution_grade,@email,@phone,@password,@intake,@track_id,@branch_id)
                  end
				 else
				  begin
				   select 'The branch ID is not existed'
				  end
				end
			   else
			    begin
				 select 'The track Id is not existed'
				end
			  end
			 else
			  begin
			   select 'The Password must contains at most 10 characters (letters,numbers and special characters)'
			  end
			end
		   else
		    begin
			 select 'The password is already existed'
			end
		  end
		 else
		  begin
		   select 'The phone number shoulb be consists of (11) numbers'
		  end
		end
	   else
	    begin
		 select'The Phone number is already existed'
		end
	  end
	 else
	  begin
	   select 'Gender should be (M) for males and (F) for females'
	  end
	end
   else
    begin
	 select 'The Student ID is already existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_student
@id int,
@name varchar(50) ,
@gender varchar(50),
@birth_date date,
@city varchar(50),
@edu_filed varchar(50),
@gradytion_year int,
@gradution_grade varchar(50),
@email varchar(50),
@phone varchar(50),
@password  varchar(50),
@intake int,
@track_id int,
@branch_id int

as
  begin
   if exists(select * from student where st_id=@id)
    begin
	 if @gender in ('M','F')
	  begin
	   if not exists(select * from student where phone=@phone)
	    begin
		 declare @phone_length int=len(@phone)
		 if @phone_length=11
		  begin
		   if not exists(select * from student where [password]=@password)
		    begin
			 declare @password_length int=len(@password)
			 if @password_length<=10
			  begin
			   if exists(select * from Track where track_id=@track_id)
			    begin
				 if exists(select * from branches where branch_id=@branch_id)
				  begin
				   update student
				   set st_name=@name,gender=@gender,birth_date=@birth_date,city=@city,educational_field=@edu_filed,graduation_year=@gradytion_year,
                   graduation_grade=@gradution_grade,email=@email,phone=@phone,[password]=@password,intake=@intake,track_id=@track_id,branch_id=@branch_id
				   where st_id=@id
				  end
				 else
				  begin
				   select 'The branch ID is not existed'
				  end
				end
			   else
			    begin
				 select 'The Track Id is not existed'
				end
			  end
			 else
			  begin
			   select 'The Password must contains at most 10 characters (letters,numbers and special characters)'
			  end
			end
		   else
		    begin
			 select 'The password is already existed'
			end
		  end
		 else
		  begin
		   select 'The phone number shoulb be consists of (11) numbers'
		  end
		end
	   else
	    begin
		 select'The Phone number is already existed'
		end
	  end
	 else
	  begin
	   select 'Gender should be (M) for males and (F) for females'
	  end
	end
   else
    begin
	 select 'The Student ID is not existed'
	end
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_student @id int 
as
  begin
   if exists (select * from student where st_id = @id)
	 begin
	  if not exists(select * from Student_Course where st_id=@id) and not exists(select * from Exam_Student_Question where st_id=@id)
	   begin
	    delete from student
		where st_id=@id
	   end
	  else
	   begin
	    select 'The Student ID can not be deleted because it has childs in other tables'
	   end
	 end
   else
	  select 'The Student Id is not existed'
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_student @id int
as
  begin
   if not exists (select st_id from student where @id=st_id)
     select 'The Student ID is not existed'
   else  
	  select s.st_id,s.st_name,s.gender,s.age,s.city,s.educational_field,s.graduation_year,s.graduation_grade,s.email,s.phone,s.intake,branch_name,track_name
	  from student s,Branches b,Track t where s.branch_id=b.branch_id and s.track_id=t.track_id
	  and st_id=@id 
  end
gets_student 100 

 -------------------------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------Branchs-------------------------------------------------------------------------:
--Select:
create proc gets_branch @branch_id int
as
  begin
   if not exists (select * from Branches where @branch_id=branch_id)
     select 'The Branch ID is not existed'
   else 
    select * from Branches where branch_id=@branch_id
  end

gets_branch 1
 --------------------------------------------------------------------------------------------------------------------------------------------------
--Insert:
create proc insert_branches
@branch_id int,
@branch_name varchar(50),
@location varchar(250)
as
  begin
   if not exists(select * from Branches where branch_id=@branch_id)
    begin
	 insert into Branches values(@branch_id,@branch_name,@location)
	end
   else
    begin
	 select 'The Branch ID is already existed'
	end
  end
 --------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_branch
@branch_id int,
@branch_name varchar(50),
@location varchar(250)
as
  begin
   if not exists (select branch_id from Branches where branch_id=@branch_id)
    select 'The branch ID is not existed'
   else 
    update Branches
	set branch_name=@branch_name,[location]=@location
	where branch_id=@branch_id 
  end
 --------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:  
create proc delete_Branch @branch_id int 
as
  begin
   if exists(select * from Branches where branch_id=@branch_id)
    begin
	 if not exists(select * from Instructor where branch_id=@branch_id) and not exists(select * from student where branch_id=@branch_id) and not exists(select * from Branch_Track where branch_id=@branch_id)
	  begin
	   delete from Branches
	   where branch_id=@branch_id
	  end
	 else
	  begin
	   select 'The Student ID can not be deleted because it has childs in other tables'
	  end
	end
   else
    begin
	 select 'The Branch ID is not existed'
	end
  end
 -------------------------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------Branch_Track-------------------------------------------------------------------------:
--Select:
 create proc gets_branch_Track 
 @branch_id int
 as
  begin
    if not exists (select * from Branch_Track where @branch_id=branch_id)
     select 'The Branch ID is not existed'
    else
	 begin
      select bt.branch_id,b.branch_name,bt.track_id,t.track_name,bt.manager_id,i.ins_name as [Manager name] from Branch_Track BT inner join Branches B
	  on b.branch_id=bt.branch_id inner join Track T
	  on t.track_id=bt.track_id inner join Instructor I
	  on i.ins_id=bt.manager_id
	  where bt.branch_id=@branch_id
	 end
  end

gets_branch_track 1
 -------------------------------------------------------------------------------------------------------------------------------------------------
--Insert:
create proc insert_branch_Track 
@branch_id int,
@track_id int,
@manger_id int 
as
  begin
   if exists(select * from Branches where branch_id=@branch_id)
    begin
	 if exists(select * from Track where track_id=@track_id)
	  begin
	   if exists(select * from Instructor where ins_id=@manger_id)
	    begin
		 if not exists(select * from Branch_Track where branch_id=@branch_id and track_id=@track_id)
		  begin
		   insert into Branch_Track
		   values(@branch_id,@track_id,@manger_id)
		  end
		 else
		  begin
		   select 'This Record is alredy existed'
		  end
		end
	   else
	    begin
		 select 'The Manager ID is not existeds'
		end
	  end
	 else
	  begin
	   select 'The Track ID is not existed'
	  end
	end
   else
    begin
	 select 'The Branch ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
 --Update:
create proc update_branch_Track 
@branch_id int,
@track_id int,
@manger_id int
as
  begin
   if exists(select * from Branches where branch_id=@branch_id)
    begin
	 if exists(select * from Track where track_id=@track_id)
	  begin
	   if exists(select * from Instructor where ins_id=@manger_id)
	    begin
		 if exists(select * from Branch_Track where branch_id=@branch_id and track_id=@track_id)
		  begin
		   update Branch_Track
		   set manager_id=@manger_id
		   where branch_id=@branch_id and track_id=@track_id
		  end
		 else
		  begin
		   select 'This Record is not existed'
		  end
		end
	   else
	    begin
		 select 'The Manager ID is not existeds'
		end
	  end
	 else
	  begin
	   select 'The Track ID is not existed'
	  end
	end
   else
    begin
	 select 'The Branch ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_Branch_Track 
@branch_id int,
@track_id int
as
  begin
   if exists(select * from Branches where branch_id=@branch_id)
    begin
	 if exists(select * from Track where track_id=@track_id)
	  begin
	   if exists(select * from Branch_Track where branch_id=@branch_id and track_id=@track_id)
	    begin
		 delete from Branch_Track
		 where branch_id=@branch_id and track_id=@track_id
		end
	   else
	    begin
		 select 'This Record is not existed'
		end
	  end
	 else
	  begin
	   select 'The Track ID is not existed'
	  end
	end
   else
    begin
	 select 'The Branch ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------Freelancing-----------------------------------------------------------:
--Select:
create proc gets_freelancing  @st_id int 
as
  begin 
   if exists (select * from freelancing where  st_id =@st_id )
    begin 
	 select f.st_id,s.st_name ,f.freelancing_id , f.plat_form , f.job_descreption , f.jop_type, f.[date] , f.price 
	 from freelancing f , student s where s.st_id = f.st_id and f.st_id=@st_id  
   end       
  else
   begin
    select 'The student ID does not have freelancing job'
   end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Insert:
insert_freelancing 1,1003,'dhud','jsua','dud','8/7/2023',40
create procedure insert_freelancing  @st_id int ,
@freelancing_id int, 
@plat_form varchar (250),
@job_descrepation varchar(max),
@job_type varchar(50),
@date date , 
@price money
as
  begin
   if exists(select st_id from student where st_id = @st_id)
	begin
	 if not exists(select freelancing_id from Freelancing where freelancing_id = @freelancing_id)
	  begin
	   insert into Freelancing (st_id ,freelancing_id, plat_form,job_descreption, jop_type,[date],price)
	   values (@st_id,@freelancing_id ,@plat_form,@job_descrepation,@job_type,@date, @price)
	  end
	 else
	  begin
	   select 'the freelancing ID is already existed'
	  end
	end
   else
	begin
	 select 'The Student ID is not existed'
	end 
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create procedure update_freelancing @st_id int,
@freelancing_id int,
@plat_form varchar (250),
@job_descrepation varchar(max),
@job_type varchar(50),
@date date,
@price money
as
  begin
   if exists(select st_id from student where st_id = @st_id)
	begin
	 if exists(select freelancing_id from Freelancing where freelancing_id=@freelancing_id)
	  begin
	   if exists(select st_id,freelancing_id from Freelancing where st_id=@st_id and freelancing_id=@freelancing_id)
	    begin
		 update Freelancing 
		 set plat_form = @plat_form , job_descreption = @job_descrepation , jop_type = @job_type , [date]= @date, price= @price 
		 where st_id = @st_id and freelancing_id = @freelancing_id
		end
	   else
	    begin
		 select 'The Record is not existed'
		end
	  end
   else
	begin
	 select 'the freelancing ID is not existed'
	end
	end
	else
	begin
	 select 'The Student ID is not existed'
	end 
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create procedure delete_freelancing  @st_id int , @freelancing_id int 
as
  begin
   if exists(select st_id from student where st_id = @st_id)
	begin
	 if exists(select freelancing_id from Freelancing where freelancing_id=@freelancing_id)
	  begin
	   if exists(select st_id,freelancing_id from Freelancing where st_id=@st_id and freelancing_id=@freelancing_id)
	    begin
		 delete from Freelancing 
		 where st_id = @st_id and freelancing_id = @freelancing_id
		end
	   else
	    begin
		 select 'The Record is not existed'
		end
	  end
   else
	begin
	 select 'the freelancing ID is not existed'
	end
	end
	else
	begin
	 select 'The Student ID is not existed'
	end 
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------certifcate-----------------------------------------------------------------------:
--Select:
create proc gets_certificate @st_id int 
as
  begin 
   if exists(select * from [Certificate] where st_id=@st_id)
    begin 
	 select c.st_id,c.certificate_Id,c.certificate_name,c.certificated_by,c.specialization,c.[date],c.fees 
	 from [Certificate] C , student s where s.st_id = c.st_id and c.st_id=@st_id  
   end       
  else
   begin
    select 'The student ID does not have certificates'
   end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Insert:
create procedure insert_certificate @st_id int ,
@certificate_id int, 
@certificate_name varchar (250),
@specialization varchar(250),
@certificate_by varchar(250),
@date date , 
@fees money
as
  begin
   if exists(select st_id from student where st_id = @st_id)
	begin
	 if not exists(select * from [Certificate] where certificate_Id = @certificate_id)
	  begin
	   insert into [Certificate]
	   values (@st_id, @certificate_id, @certificate_name, @specialization, @certificate_by, @date, @fees)
	  end
	 else
	  begin
	   select 'the Certificate ID is already existed'
	  end
	end
   else
	begin
	 select 'The Student ID is not existed'
	end 
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create procedure update_certificate @st_id int,
@certificate_id int, 
@certificate_name varchar (250),
@specialization varchar(250),
@certificate_by varchar(250),
@date date , 
@fees money
as
  begin
   if exists(select st_id from student where st_id = @st_id)
	begin
	 if exists(select * from [Certificate] where certificate_Id=@certificate_id)
	  begin
	   if exists(select st_id,certificate_Id from [Certificate] where st_id=@st_id and certificate_Id=@certificate_id)
	    begin
		 update [Certificate] 
		 set certificate_name=@certificate_name, specialization=@specialization, certificated_by=@certificate_by, [date]=@date, fees=@fees 
		 where st_id = @st_id and certificate_Id=@certificate_id
		end
	   else
	    begin
		 select 'The Record is not existed'
		end
	  end
   else
	begin
	 select 'the certificate ID is not existed'
	end
	end
	else
	begin
	 select 'The Student ID is not existed'
	end 
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create procedure delete_certificate  @st_id int , @certificate_id int 
as
  begin
   if exists(select * from student where st_id = @st_id)
	begin
	 if exists(select * from [Certificate] where certificate_Id=@certificate_id)
	  begin
	   if exists(select st_id,certificate_Id from [Certificate] where st_id=@st_id and certificate_Id=@certificate_id)
	    begin
		 delete from [Certificate]
		 where st_id = @st_id and certificate_Id=@certificate_id
		end
	   else
	    begin
		 select 'The Record is not existed'
		end
	  end
   else
	begin
	 select 'the certificate ID is not existed'
	end
	end
	else
	begin
	 select 'The Student ID is not existed'
	end 
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Student_Course---------------------------------------------------------------:
--Select:
create procedure gets_Student_grades_in_Course @st_id int, @course_id int
as
  begin
   if exists(select * from student where st_id=@st_id)
    begin
	 if exists(select * from Course where course_id=@course_id)
	  begin
	   if exists(select * from Student_Course where st_id=@st_id and course_id=@course_id)
	    begin
		 select sc.st_id,s.st_name,sc.course_id,c.course_name,t.track_name,sc.assigments,sc.attendance,(sc.assigments+sc.attendance) as [Final grade] from Student_Course SC inner join student S
		 on s.st_id=sc.st_id inner join Course C
		 on c.course_id=sc.course_id inner join Track T
		 on t.track_id=c.track_id
		 where sc.st_id=@st_id and sc.course_id=@course_id
		end
	   else
	    begin
		 select 'The Student ID is not apllied for this course ID'
		end
	  end
	 else
	  begin
	   select 'The Course ID is not  existed'
	  end
	end
   else
    begin
	 select 'The Student ID is not existed'
	end
  end

gets_Student_grades_in_Course 1,1

-------------------------------------------------------------------------------------------------------------------------------------------------
--Insert:
create procedure insert_student_course @st_id int, @course_id int ,@attendance tinyint , @assigments tinyint, @evaluation tinyint
as
  begin
   if exists(select * from student where st_id=@st_id)
    begin
	 if exists(select * from Course where course_id=@course_id)
	  begin
	   if not exists(select * from Student_Course where st_id=@st_id and course_id=@course_id)
	    begin
		 insert into Student_Course
		 values(@st_id,@course_id,@attendance,@assigments,@evaluation)
		end
	   else
	    begin
		 select 'This Record is already existed'
		end
	  end
	 else
	  begin
	   select 'The Course ID is not existed'
	  end
	end
   else
    begin
	 select 'The Student ID is not existed'
	end
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create procedure update_student_course @st_id int, @course_id int ,@attendance tinyint , @assigments tinyint, @evaluation tinyint
as
  begin
   if exists(select * from student where st_id=@st_id)
    begin
	 if exists(select * from Course where course_id=@course_id)
	  begin
	   if exists(select * from Student_Course where st_id=@st_id and course_id=@course_id)
	    begin
		 update Student_Course
		 set attendance=@attendance, assigments=@assigments, evaluation=@evaluation
		 where st_id=@st_id and course_id=@course_id
		end
	   else
	    begin
		 select 'This Record is not existed'
		end
	  end
	 else
	  begin
	   select 'The Course ID is not existed'
	  end
	end
   else
    begin
	 select 'The Student ID is not existed'
	end
  end

-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create procedure delete_student_course @st_id int, @course_id int
as
  begin
   if exists(select * from student where st_id=@st_id)
    begin
	 if exists(select * from Course where course_id=@course_id)
	  begin
	   if exists(select * from Student_Course where st_id=@st_id and course_id=@course_id)
	    begin
		 delete from Student_Course
		 where st_id=@st_id and course_id=@course_id
		end
	   else
	    begin
		 select 'This Record is not existed'
		end
	  end
	 else
	  begin
	   select 'The Course ID is not existed'
	  end
	end
   else
    begin
	 select 'The Student ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------Question-------------------------------------------------------------------------:
--Insert:
create proc new_question @question_id int,@type varchar(80),
@qusetion varchar(max),@choice_A varchar(max),@choice_B varchar(max),@choice_C varchar(max),@model_answer varchar(1),@course_id int
as
  begin
   if not exists(select * from Question where question_id=@question_id)
    begin
	 if exists(select * from Course where course_id=@course_id)
	  begin
	   if @type in ('True/False','Multiple-Choice')
	    begin
		 if @model_answer in ('A','B','C')
		  begin
		   insert into Question
		   values(@question_id,@type,@qusetion,@choice_A,@choice_B,@choice_C,@model_answer,@course_id)
		  end
		 else
		  begin
		   select 'The model answer should be A,B or C'
		  end
		end
	   else
	    begin
		 select 'The question type should be True/False or Multiple-Choice'
		end
	  end
	 else
	  begin
	   select 'The Course ID is not existed'
	  end
	end
   else
    begin
     select 'The Question ID is already existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_question @question_id int,@type varchar(80),
@qusetion varchar(max),@choice_A varchar(max),@choice_B varchar(max),@choice_C varchar(max),@model_answer varchar(1),@course_id int
as
  begin
   if exists(select * from Question where question_id=@question_id)
    begin
	 if exists(select * from Course where course_id=@course_id)
	  begin
	   if @type in ('True/False','Multiple-Choice')
	    begin
		 if @model_answer in ('A','B','C')
		  begin
		   update Question
		   set [type]=@type, question=@qusetion, choice_A=@choice_A, choice_B=@choice_B, choice_C=@choice_C, model_answer=@model_answer, course_id=@course_id
		   where question_id=@question_id
		  end
		 else
		  begin
		   select 'The model answer should be A,B or C'
		  end
		end
	   else
	    begin
		 select 'The question type should be True/False or Multiple-Choice'
		end
	  end
	 else
	  begin
	   select 'The Course ID is not existed'
	  end
	end
   else
    begin
     select 'The Question ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_question @question_id int
as
  begin
   if exists(select * from Question where question_id=@question_id)
    begin
	 if not exists(select * from Exam_Student_Question where question_id=@question_id)
	  begin
	   delete from Question
	   where question_id=@question_id
	  end
	 else
	  begin
	   select 'The Qusetion ID can not be deleted because it has childs in (Exam_Student_Question) table'
	  end
	end
   else
    begin
	 select 'The Question ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_question @question_id int
as
  begin
   if exists(select * from Question where question_id=@question_id)
    begin
	 select q.*,c.course_name,t.track_name from Question Q inner join Course C
	 on c.course_id=q.course_id inner join Track T
	 on t.track_id=c.track_id
	 where q.question_id=@question_id
	end
   else
    begin
	 select 'The Question ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------Exam-------------------------------------------------------------------------:
--Insert:
create proc new_exam @exam_date date
as
  begin
   insert into Exam(exam_date)
   values(@exam_date);
   select * from Exam
   where exam_id=ident_current('Exam')
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_exam @exam_id int, @exam_date date
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 if not exists(select * from Exam_Student_Question where exam_id=@exam_id)
	  begin
	   update Exam
       set exam_date=@exam_date
       where exam_id=@exam_id
	  end
	 else
	  begin
	   select 'The Exam ID can not be deleted because it has childs in (Exam_Student_Question) table'
	  end
	end
   else
    begin
	 select 'The Exam ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete 
create proc delete_exam @exam_id int
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 if not exists(select * from Exam_Student_Question where exam_id=@exam_id)
	  begin
	   delete from Exam
	   where exam_id=@exam_id
	  end
	 else
	  begin
	   select 'The Exam ID can not be deleted because it has childs in (Exam_Student_Question) table'
	  end
	end
   else
    begin
	 select 'The Exam ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_exam @exam_id int
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 select * from Exam where exam_id=@exam_id
	end
   else
    begin
	 select 'The Exam ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Exam_Student_Question------------------------------------------------------------------:
--Insert:
create proc new_Exam_Student_Question @exam_id int, @st_id int, @question_id int, @answer varchar(1), @grade tinyint
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 if exists(select * from student where st_id=@st_id)
	  begin
	   if exists(select * from Question where question_id=@question_id)
	    begin
		 if not exists(select * from Exam_Student_Question where exam_id=@exam_id and question_id=@question_id)
		  begin
		   if @answer in ('A','B','C')
		    begin
			 if @grade in (0,1)
			  begin
			   insert into Exam_Student_Question
			   values(@exam_id,@st_id,@question_id,@answer,@grade)
			  end
			 else
			  begin
			   select 'The grade should be 0 or 1'
			  end
			end
		   else
		    begin
			 select 'The answer should be A,B or C'
			end
		  end
		 else
		  begin
		   select 'This Record is already existed'
		  end
		end
	   else
	    begin
		 select 'The Question ID is not existed'
		end
	  end
	 else
	  begin
	   select 'The Student ID is not existed'
	  end
	end
   else
    begin
	 select 'The Exam ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Update:
create proc update_Exam_Student_Question @exam_id int, @st_id int, @question_id int, @answer varchar(1), @grade tinyint
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 if exists(select * from student where st_id=@st_id)
	  begin
	   if exists(select * from Question where question_id=@question_id)
	    begin
		 if exists(select * from Exam_Student_Question where exam_id=@exam_id and question_id=@question_id and st_id=@st_id)
		  begin
		   if @answer in ('A','B','C')
		    begin
			 if @grade in (0,1)
			  begin
			   update Exam_Student_Question
			   set answer=@answer, grade=@grade
			   where exam_id=@exam_id and question_id=@question_id and st_id=@st_id
			  end
			 else
			  begin
			   select 'The grade should be 0 or 1'
			  end
			end
		   else
		    begin
			 select 'The answer should be A,B or C'
			end
		  end
		 else
		  begin
		   select 'This Record is not existed'
		  end
		end
	   else
	    begin
		 select 'The Question ID is not existed'
		end
	  end
	 else
	  begin
	   select 'The Student ID is not existed'
	  end
	end
   else
    begin
	 select 'The Exam ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Delete:
create proc delete_Exam_Student_Question @exam_id int, @st_id int, @question_id int
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 if exists(select * from student where st_id=@st_id)
	  begin
	   if exists(select * from Question where question_id=@question_id)
	    begin
		 if exists(select * from Exam_Student_Question where exam_id=@exam_id and question_id=@question_id and st_id=@st_id)
		  begin
		   delete from Exam_Student_Question
		   where exam_id=@exam_id and question_id=@question_id and st_id=@st_id
		  end
		 else
		  begin
		   select 'This Record is not existed'
		  end
		end
	   else
	    begin
		 select 'The Question ID is not existed'
		end
	  end
	 else
	  begin
	   select 'The Student ID is not existed'
	  end
	end
   else
    begin
	 select 'The Exam ID is not existed'
	end
  end
-------------------------------------------------------------------------------------------------------------------------------------------------
--Select:
create proc gets_Exam_Student_Question @exam_id int, @st_id int
as
  begin
   if exists(select * from Exam where exam_id=@exam_id)
    begin
	 if exists(select * from student where st_id=@st_id)
	  begin
	   if exists(select * from Exam_Student_Question where exam_id=@exam_id and st_id=@st_id)
	    begin
		 select * from Exam_Student_Question where exam_id=@exam_id and st_id=@st_id
		end
	   else
	    begin
		 select 'This Record is not existed'
		end
	  end
	 else
	  begin
	   select 'The Student ID is not existed'
	  end
	end
   else
    select 'The Exam ID is not existed'
  end
-----------------------------------------------------------------------------------------------------------------------------------------------------------

