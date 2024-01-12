--A) 1. a. select all students of a certain course
select *
from students
where course_id = 150;
--      b. senior and junior students
select *
from students
order by birthdate asc
limit 1;

select *
from students
order by birthdate desc
limit 1;
--   2. c. update information about a student
update students
set last_name = 'Turabayev'
where last_name = 'Turabay';
--      d. apply changes to multiple students
update students
set course_id = 150
where course_id = 101;


--B) 1. create tables students, teachers, courses
create table students
(
    student_id int,
    first_name varchar(50),
    last_name  varchar(50),
    birthdate  int,
    course_id  int,
    primary key (student_id),
    foreign key (course_id) references courses (course_id)
);

create table teachers
(
    teacher_id int,
    first_name varchar(50),
    last_name  varchar(50),
    department varchar(50),
    course_id  int,
    primary key (teacher_id),
    foreign key (course_id) references courses (course_id)
);

create table courses
(
    course_id   int,
    course_name varchar(100),
    primary key (course_id)
);

create table grades
(
    student_id int,
    course_id  int,
    grade      decimal(5, 2),
    foreign key (student_id) references students (student_id),
    foreign key (course_id) references courses (course_id)
);

insert into courses (course_id, course_name)
values (101, 'Linear algebra');
insert into courses (course_id, course_name)
values (102, 'Statistics');
insert into courses (course_id, course_name)
values (150, 'Discrete math');

insert into grades (student_id, course_id, grade)
values (1, 101, 2);
insert into grades (student_id, course_id, grade)
values (1, 102, 4);
insert into grades (student_id, course_id, grade)
values (2, 102, 5);
insert into grades (student_id, course_id, grade)
values (2, 150, 2);
insert into grades (student_id, course_id, grade)
values (3, 101, 5);
insert into grades (student_id, course_id, grade)
values (3, 102, 3);
insert into grades (student_id, course_id, grade)
values (3, 150, 3);
insert into grades(student_id, course_id, grade)
values (4, 102, 5);
insert into grades (student_id, course_id, grade)
values (4, 101, 3);
insert into grades (student_id, course_id, grade)
values (5, 102, 5);
insert into grades (student_id, course_id, grade)
values (5, 101, 5);

insert into students (student_id, first_name, last_name, birthdate, course_id)
values (1, 'Berdigaly', 'Turabek', '1995-01-10', 101);
insert into students (student_id, first_name, last_name, birthdate, course_id)
values (2, 'Nurbike', 'Jalayr', '1997-05-15', 102);
insert into students (student_id, first_name, last_name, birthdate, course_id)
values (3, 'Berdibek', 'Malik', '1996-03-20', 101);
insert into students(student_id, first_name, last_name, birthdate, course_id)
values (4, 'Aisaule', 'Zholdasbek', '1995-09-28', 101);
insert into students(student_id, first_name, last_name, birthdate, course_id)
values (5, 'Zhaniya', 'Makhambetova', '1997-08-24', 102);


insert into teachers(teacher_id, first_name, last_name, department, course_id)
values (1, 'Amanzhol', 'Imanbekov', 'Linear algebra', 150);
insert into teachers(teacher_id, first_name, last_name, department, course_id)
values (2, 'Botagoz', 'Dzhankieva', 'Discrete math', 102);


--B
select s.first_name, c.course_name, t.first_name
from students s
         join courses c on s.course_id = c.course_id
         join teachers t on c.course_id = t.course_id;


--C 1. a.
select count(student_id), course_id
from students
group by course_id;
--     b.
select avg(age(birthdate))
from students
group by course_id;
--  2. c.
select student_id, last_name, first_name
from students
where (select avg(grade) from grades where grades.student_id = students.student_id) <
      (select grade from grades where grades.student_id = students.student_id);
--     d.
select student_id, last_name, first_name
from students
where student_id in (select student_id from grades where grade > 3);



--D 1.
create view combination as
select s.student_id,
       s.first_name,
       s.last_name,
       c.course_id,
       c.course_name,
       g.grade
from students s
         join grades g on s.student_id = g.student_id
         join courses c on g.course_id = c.course_id;

--   2.
select course_id,
       course_name,
       avg(grade) as average_grade
from combination
group by course_id, course_name;

