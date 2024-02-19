create database frogdata_2 charset=utf8;
use frogdata_2;

CREATE TABLE Student (
    SId VARCHAR(10),
    Sname VARCHAR(10),
    Sage DATETIME,
    Ssex VARCHAR(10)
);

CREATE TABLE Teacher (
    TId VARCHAR(10),
    Tname VARCHAR(10)
);

#科目表 
CREATE TABLE Course (
    CId VARCHAR(10),
    TId VARCHAR(10),
    Cname NVARCHAR(10)
);

#成绩表
create table SC(
SId varchar(10),
CId varchar(10),
score decimal(18,1)
);

#插入数据语句 
#学生表 
insert into Student values('01', '赵雷', '1990-01-01', '男');
insert into Student values('02', '钱电', '1990-12-21', '男');
insert into Student values('03', '孙风', '1990-05-20', '男');
insert into Student values('04', '李云', '1990-08-06', '男');
insert into Student values('05', '周梅', '1991-12-01', '女');
insert into Student values('06', '吴兰', '1992-03-01', '女');
insert into Student values('07', '郑竹', '1989-07-01', '女');
insert into Student values('09', '张三', '2017-12-20', '女');



insert into Course values('01', '02','语文');
insert into Course values('02', '01', '数学');
insert into Course values('03', '03','英语');


insert into Teacher values('01', '张三');
insert into Teacher values('02', '李四');
insert into Teacher values('03','王五');

insert into SC values('01','01',80);
insert into SC values('01','02',90);
insert into SC values('01','03',99);
insert into SC values('02','01',70);
insert into SC values('02','02',60);
insert into SC values('02','03',80);
insert into SC values('03','01',80);
insert into SC values('03','02',80);
insert into SC values('03','03',80);
insert into SC values('04','01',50);
insert into SC values('04','02',30);
insert into SC values('04','03',20);
insert into SC values('05','01',76);
insert into SC values('05','02',87);
insert into SC values('06','01',31);
insert into SC values('06','03',34);
insert into SC values('07','02',89);
insert into SC values('07','03',98);

select *
from Student a
inner join SC b 
on a.sid=b.sid
inner join SC c
on a.sid=c.sid and b.cid='01' and c.cid='02'
where b.score > c.score;

 select *
 from (select * from SC where cid='01') a
 left join SC b
 on a.sid = b.sid and b.cid='02';
 
 
 
 select *
 from SC
 where sid not in (select sid from SC where cid='01') and cid='02'
 
 
 
select b.*
from (select sid from SC group by sid) a
left join Student b
on a.sid=b.sid
;


select a.*, b.ct,b.sum_score
from student a
left join (select count(cid) as ct, sum(score) as sum_score, sid from SC group by sid) b 
on a.sid=b.sid;

select sid from SC group by sid;
select * 
from Student
where sid in (select sid from SC group by sid);



select count(tid)
from teacher
where Tname like '李%';

select c.*, Tname
from course c
join(
select Tid, Tname
from teacher
where Tname='张三') t
on c.Tid=t.tid
; 

select SC.*, Tname
from SC 
join(select c.*, Tname
from course c
join(
select Tid, Tname
from teacher
where Tname='张三') t
on c.Tid=t.tid)  as new
on SC.cid= new.cid;


select s.*,Tname from Student s
inner join (select SC.*, Tname
from SC 
join(select c.*, Tname
from course c
join(
select Tid, Tname
from teacher
where Tname='张三') t
on c.Tid=t.tid)  as new
on SC.cid= new.cid) as new_1
on s.sid=new_1.sid;