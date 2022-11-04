### Задание 1.

> [описание]


**tables employee** 

| id int not null increment | varchar(50) not null | date       | money |
| ------------------------- | -------------------- | ---------- |------|
| n                         | ФИО                  | дата найма |оклад |


**tables position**

| id int not null increment | varchar(50) not null |
| ------------------------- | -------------------- |
| n                         | должность            |

**tables unit type**

| id int not null increment | varchar(50) not null |
| --------------------- | ------------------- |
| n                     | тип подразделения   |


**tables structural unit**

| id int not null increment | varchar(50) not null |
| --------------------- | ------------------- |
| n                     | структурное подразделение   |

**tables city**

| id int not null increment | varchar(50) not null |
| --------------------- | ------------------- |
| n                     | город   |


**tables project**

| id int not null increment | varchar(50) not null |
| --------------------- | ------------------- |
| n                     | проект  |


---

|emloyee_id int reference(tables employee)|position_id int reference(tables position)|unit_type_id int reference(tables unit type)|structural_id int reference(tables structural unit)|structural_id int reference(tables structural unit)|city_id int reference(tables city)|project_id int reference(tables projects)|
|--|--|--|--|--|--|--|
|n|n|n|n|n|n|n|
