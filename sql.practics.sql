use shield;
create table avengers(
  ar_id int PRIMARY key AUTO_INCREMENT,
  f_name varchar(30),
  l_name varchar(30),
  heroic_name varchar(30),
  city varchar(30));
  
    insert into avengers(f_name,l_name,heroic_name,city)
  VALUES('Roger','Steve','Captain America','NYC'),
        ('Tony','Stark','Iron Man','NYC'),
  ('Thor','Odinson','Thor','NYC'),
  ('Peter','Parker','Spider-Man','NYC'),
    ('Scott','Lang','Ant-Man','California'),
  ('Stephen','Strange','Dr.Strange','Florida');

select * from avengers;

create table avengers_enemy(
ae_id int primary key auto_increment,
enemy_name varchar(30),
ar_id int(30),
 FOREIGN KEY (ar_id) REFERENCES avengers(ar_id)
 on delete cascade
 );
 
 insert  into avengers_enemy(enemy_name,ar_id)
 VALUES('Armin Zola',1),
     ('Doctor octopus',4),
      ('Dormammu',6),
      ('Electro',4),
      ('Green Goblin',4),
      ('Red Skull',1),
      ('Obadiah Stane',2),
      ('Hela',3);
      
	create table weapon(
  wp_id int PRIMARY key AUTO_INCREMENT,
  weapon_name varchar(30),
  ar_id int,
  ae_id int,
  FOREIGN key(ar_id) REFERENCES avengers(ar_id),
  FOREIGN key(ae_id) REFERENCES avengers_enemy(ae_id)
  );

 insert into weapon(weapon_name,ar_id,ae_id)
  VALUES ('web',4,2),
                 ('pym particle',5,null),
                 ('magic',6,3),
                 ('shield',1,6),
              ('suit',2,7),
                ('milonir',3,8),
                ('vibranium Hand',null,null);
		
	select * from avengers;
	select* from avengers_enemy;
	select * from weapon;
 
 drop table weapon;
 drop table avengers_enemy;
 drop table avengers;

 
 delete from avengers_enemy where ar_id=6;
 
 
 select heroic_name,enemy_name from avengers a
 inner join avengers_enemy as ae
 on a.ar_id!=ae.ar_id;
 
 select * from avengers;
 table avengers_enemy;
 
 select heroic_name,enemy_name from avengers 
 natural join avengers_enemy ;
 
select heroic_name,enemy_name , weapon_name from avengers a
 inner join avengers_enemy as ae 
 on a.ar_id=ae.ar_id
  inner join weapon  as wp
 on ae.ar_id=wp.ar_id ;
 
 
SELECT avengers.ar_id, heroic_name,enemy_name from avengers 
LEFT JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;

SELECT avengers.ar_id,heroic_name,enemy_name from avengers 
right JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;
-- -------------left join-------

 SELECT avengers.ar_id, heroic_name,enemy_name from avengers 
LEFT JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;
 
  --  --------view-----------
  create view full_join as
  SELECT avengers.ar_id,heroic_name,enemy_name from avengers 
right JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id
union 
SELECT avengers.ar_id, heroic_name,enemy_name from avengers 
LEFT JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;

select * from full_join;

-- ---------union-----------------------------------------
SELECT avengers.ar_id,heroic_name,enemy_name from avengers 
right JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id
union 
SELECT avengers.ar_id, heroic_name,enemy_name from avengers 
LEFT JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;
-- ------------------union all -------------------
SELECT avengers.ar_id,heroic_name,enemy_name from avengers 
right JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id
union all
SELECT  null city,'nyc' avengers.ar_id, heroic_name,enemy_name from avengers 
LEFT JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;

select * from avengers;
select  * from avengers_enemy; 

-- --------nullif------------------
select nullif (city,'nyc') as city from avengers;
select ifnull (city,'nyc') as city from avengers;


-- -----subquary--------

select heroic_name from avengers where ar_id in (select ar_id from avengers_enemy where enemy_name in ( 'hela' ,'electro'));

select ar_id from avengers_enemy where enemy_name='hela';


-- -------self join -------------------------------------------

SELECT avengers.ar_id,heroic_name,enemy_name from avengers 
right JOIN avengers_enemy 
ON avengers.ar_id=avengers_enemy.ar_id;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);
INSERT INTO
    employees (
        employee_id,
        employee_name,
        manager_id
    )
VALUES (1, 'John Doe', 3),
    (2, 'Jane Smith', 1),
    (3, 'Alice Johnson', NULL),
    (4, 'Bob Brown', 2),
    (5, 'Emily White', 2);
    
    SELECT * from employees;
    
 SELECT e.employee_name as Employee,m.employee_name as Manager FROM employees as e
  INNER JOIN employees as m ON e.manager_id = m.employee_id;
  
  
use shield;

CREATE TABLE xx (
    id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(20),
    salary int
);
insert INTO
    xx (name, salary)
values ('a', 1),
    ('a', 2),
    ('a', 3),
    ('a', 4),
    ('b', 5),
    ('b', 6),
    ('b', 7),
    ('b', 8),
    ('c', 9),
    ('c', 10),
    ('c', 11),
    ('c', 12),
    ('d', 13),
    ('d', 14),
    ('d', 15),
    ('d', 16);
   
Select * from xx;

select name , salary from xx where salary > ALL (select salary from xx where salary IN (5,12,14,10));

select name , salary from xx where salary > any (select salary from xx where salary IN (5,12,14,10));

select name , salary from xx where salary < ALL (select salary from xx where salary IN (14,10));







   




