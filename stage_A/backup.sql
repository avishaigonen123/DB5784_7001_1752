prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by avish on Wednesday, May 22, 2024
set feedback off
set define off

prompt Creating BUS...
create table BUS
(
  busid        NUMBER(38) not null,
  model        VARCHAR2(100) not null,
  capacity     NUMBER(38) not null,
  purchasedate DATE not null
)
;
alter table BUS
  add constraint PK_BUS primary key (BUSID);

prompt Creating DRIVER...
create table DRIVER
(
  driverid      NUMBER(38) not null,
  fullname      VARCHAR2(100) not null,
  licensenumber VARCHAR2(50) not null,
  hiredate      DATE not null
)
;
alter table DRIVER
  add constraint PK_DRIVER primary key (DRIVERID);
alter table DRIVER
  add unique (LICENSENUMBER);

prompt Creating STATION...
create table STATION
(
  stationid      NUMBER(38) not null,
  stationname    VARCHAR2(100) not null,
  stationaddress VARCHAR2(255) not null
)
;
alter table STATION
  add constraint PK_STATION primary key (STATIONID);

prompt Creating ROUTE...
create table ROUTE
(
  routeid        NUMBER(38) not null,
  routename      VARCHAR2(100) not null,
  startstationid NUMBER(38) not null,
  endstationid   NUMBER(38) not null
)
;
alter table ROUTE
  add constraint PK_ROUTE primary key (ROUTEID);
alter table ROUTE
  add constraint FK_ROUTE foreign key (STARTSTATIONID)
  references STATION (STATIONID);
alter table ROUTE
  add constraint FK_ROUTE2 foreign key (ENDSTATIONID)
  references STATION (STATIONID);

prompt Creating SCHEDULE...
create table SCHEDULE
(
  scheduleid    NUMBER(38) not null,
  routeid       NUMBER(38) not null,
  departuretime TIMESTAMP(6) not null,
  arrivaltime   TIMESTAMP(6) not null
)
;
alter table SCHEDULE
  add constraint PK_SCHEDULE primary key (SCHEDULEID);
alter table SCHEDULE
  add constraint FK_SCHEDULE foreign key (ROUTEID)
  references ROUTE (ROUTEID) on delete cascade;

prompt Creating TRIP...
create table TRIP
(
  tripid   NUMBER(38) not null,
  busid    NUMBER(38) not null,
  driverid NUMBER(38) not null,
  tripdate DATE not null,
  routeid  NUMBER(38) not null
)
;
alter table TRIP
  add constraint PK_TRIP primary key (TRIPID);
alter table TRIP
  add constraint FK_TRIP foreign key (BUSID)
  references BUS (BUSID);
alter table TRIP
  add constraint FK_TRIP2 foreign key (DRIVERID)
  references DRIVER (DRIVERID);
alter table TRIP
  add constraint FK_TRIP3 foreign key (ROUTEID)
  references ROUTE (ROUTEID);

prompt Truncating TRIP...
truncate table TRIP;
prompt Truncating SCHEDULE...
truncate table SCHEDULE;
prompt Truncating ROUTE...
truncate table ROUTE;
prompt Truncating STATION...
truncate table STATION;
prompt Truncating DRIVER...
truncate table DRIVER;
prompt Truncating BUS...
truncate table BUS;
prompt Loading BUS...
insert into BUS (busid, model, capacity, purchasedate)
values (1, 'model5', 19, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (2, 'model6', 37, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (3, 'model7', 10, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (4, 'model10', 32, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (5, 'model2', 7, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (6, 'model10', 28, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (7, 'model5', 35, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (8, 'model5', 15, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (9, 'model2', 14, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (10, 'model7', 29, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (11, 'model3', 19, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (12, 'model9', 10, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (13, 'model4', 35, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (14, 'model10', 5, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (15, 'model4', 9, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (16, 'model4', 17, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (17, 'model3', 22, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (18, 'model2', 18, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (19, 'model7', 25, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (20, 'model3', 6, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (21, 'model3', 28, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (22, 'model7', 25, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (23, 'model9', 28, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (24, 'model7', 35, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (25, 'model3', 37, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (26, 'model6', 29, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (27, 'model3', 25, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (28, 'model2', 12, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (29, 'model4', 22, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (30, 'model7', 8, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (31, 'model10', 16, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (32, 'model8', 37, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (33, 'model2', 33, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (34, 'model5', 8, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (35, 'model4', 23, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (36, 'model8', 26, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (37, 'model7', 34, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (38, 'model9', 33, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (39, 'model6', 26, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (40, 'model1', 9, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (41, 'model8', 21, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (42, 'model4', 29, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (43, 'model1', 11, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (44, 'model6', 6, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (45, 'model2', 9, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (46, 'model2', 36, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (47, 'model7', 15, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (48, 'model6', 18, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (49, 'model2', 6, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (50, 'model3', 32, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (51, 'model8', 36, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (52, 'model7', 27, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (53, 'model1', 28, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (54, 'model1', 26, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (55, 'model9', 9, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (56, 'model4', 5, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (57, 'model3', 30, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (58, 'model1', 30, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (59, 'model8', 33, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (60, 'model6', 37, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (61, 'model3', 10, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (62, 'model1', 21, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (63, 'model6', 33, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (64, 'model10', 23, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (65, 'model10', 11, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (66, 'model2', 29, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (67, 'model1', 14, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (68, 'model7', 14, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (69, 'model1', 11, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (70, 'model7', 35, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (71, 'model6', 30, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (72, 'model9', 8, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (73, 'model1', 20, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (74, 'model1', 29, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (75, 'model1', 23, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (76, 'model8', 36, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (77, 'model5', 7, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (78, 'model8', 14, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (79, 'model6', 13, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (80, 'model5', 11, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (81, 'model8', 31, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (82, 'model8', 19, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (83, 'model2', 10, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (84, 'model5', 36, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (85, 'model1', 19, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (86, 'model9', 34, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (87, 'model9', 38, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (88, 'model2', 10, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (89, 'model1', 15, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (90, 'model9', 16, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (91, 'model3', 9, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (92, 'model3', 6, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (93, 'model7', 18, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (94, 'model4', 6, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (95, 'model8', 7, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (96, 'model10', 14, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (97, 'model10', 28, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (98, 'model8', 28, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (99, 'model9', 32, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (100, 'model3', 31, to_date('04-04-2024', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into BUS (busid, model, capacity, purchasedate)
values (101, 'model2', 29, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (102, 'model1', 9, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (103, 'model7', 30, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (104, 'model3', 12, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (105, 'model1', 7, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (106, 'model3', 33, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (107, 'model1', 34, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (108, 'model2', 24, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (109, 'model2', 32, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (110, 'model7', 32, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (111, 'model8', 20, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (112, 'model1', 16, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (113, 'model3', 20, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (114, 'model6', 12, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (115, 'model4', 29, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (116, 'model6', 36, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (117, 'model10', 19, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (118, 'model5', 13, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (119, 'model5', 36, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (120, 'model10', 7, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (121, 'model10', 21, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (122, 'model3', 34, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (123, 'model2', 7, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (124, 'model6', 23, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (125, 'model7', 14, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (126, 'model4', 20, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (127, 'model1', 34, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (128, 'model7', 27, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (129, 'model1', 11, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (130, 'model1', 22, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (131, 'model1', 7, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (132, 'model5', 31, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (133, 'model2', 14, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (134, 'model7', 26, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (135, 'model10', 35, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (136, 'model4', 21, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (137, 'model7', 22, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (138, 'model5', 12, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (139, 'model4', 22, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (140, 'model4', 34, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (141, 'model9', 38, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (142, 'model2', 27, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (143, 'model4', 26, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (144, 'model6', 31, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (145, 'model6', 28, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (146, 'model10', 26, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (147, 'model5', 20, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (148, 'model4', 18, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (149, 'model6', 14, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (150, 'model2', 20, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (151, 'model8', 12, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (152, 'model4', 20, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (153, 'model5', 16, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (154, 'model8', 28, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (155, 'model3', 11, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (156, 'model7', 29, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (157, 'model9', 21, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (158, 'model6', 28, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (159, 'model8', 16, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (160, 'model10', 26, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (161, 'model8', 22, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (162, 'model7', 7, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (163, 'model3', 18, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (164, 'model5', 26, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (165, 'model10', 32, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (166, 'model10', 14, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (167, 'model7', 8, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (168, 'model6', 28, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (169, 'model4', 18, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (170, 'model6', 37, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (171, 'model9', 30, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (172, 'model7', 34, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (173, 'model9', 32, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (174, 'model3', 10, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (175, 'model2', 28, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (176, 'model2', 37, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (177, 'model7', 37, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (178, 'model4', 24, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (179, 'model8', 31, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (180, 'model5', 29, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (181, 'model8', 28, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (182, 'model2', 38, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (183, 'model8', 38, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (184, 'model4', 32, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (185, 'model4', 18, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (186, 'model9', 13, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (187, 'model8', 6, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (188, 'model7', 35, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (189, 'model4', 16, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (190, 'model8', 37, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (191, 'model8', 30, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (192, 'model10', 23, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (193, 'model7', 13, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (194, 'model10', 34, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (195, 'model7', 25, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (196, 'model9', 14, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (197, 'model8', 13, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (198, 'model5', 26, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (199, 'model2', 6, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (200, 'model1', 26, to_date('04-04-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into BUS (busid, model, capacity, purchasedate)
values (201, 'model8', 22, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (202, 'model5', 13, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (203, 'model6', 31, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (204, 'model3', 28, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (205, 'model7', 8, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (206, 'model1', 36, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (207, 'model9', 30, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (208, 'model3', 26, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (209, 'model10', 21, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (210, 'model5', 24, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (211, 'model2', 18, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (212, 'model9', 36, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (213, 'model4', 17, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (214, 'model7', 7, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (215, 'model8', 34, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (216, 'model7', 24, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (217, 'model7', 17, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (218, 'model6', 35, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (219, 'model2', 7, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (220, 'model5', 24, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (221, 'model9', 26, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (222, 'model2', 31, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (223, 'model8', 24, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (224, 'model8', 8, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (225, 'model8', 32, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (226, 'model7', 35, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (227, 'model7', 37, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (228, 'model6', 15, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (229, 'model7', 26, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (230, 'model6', 6, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (231, 'model1', 38, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (232, 'model5', 35, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (233, 'model9', 8, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (234, 'model4', 12, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (235, 'model10', 34, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (236, 'model4', 29, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (237, 'model5', 12, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (238, 'model5', 32, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (239, 'model6', 11, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (240, 'model3', 36, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (241, 'model8', 18, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (242, 'model9', 24, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (243, 'model6', 26, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (244, 'model9', 27, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (245, 'model1', 12, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (246, 'model10', 30, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (247, 'model1', 17, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (248, 'model6', 6, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (249, 'model8', 19, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (250, 'model9', 8, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (251, 'model5', 28, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (252, 'model7', 18, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (253, 'model5', 32, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (254, 'model6', 34, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (255, 'model9', 20, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (256, 'model6', 18, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (257, 'model1', 21, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (258, 'model8', 25, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (259, 'model2', 10, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (260, 'model7', 37, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (261, 'model7', 8, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (262, 'model8', 29, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (263, 'model10', 5, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (264, 'model2', 5, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (265, 'model9', 29, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (266, 'model8', 8, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (267, 'model1', 8, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (268, 'model7', 17, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (269, 'model10', 10, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (270, 'model7', 38, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (271, 'model9', 21, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (272, 'model6', 19, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (273, 'model1', 24, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (274, 'model8', 8, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (275, 'model10', 8, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (276, 'model1', 13, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (277, 'model9', 8, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (278, 'model2', 30, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (279, 'model2', 25, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (280, 'model8', 21, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (281, 'model10', 38, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (282, 'model10', 15, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (283, 'model1', 14, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (284, 'model9', 9, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (285, 'model9', 33, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (286, 'model2', 14, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (287, 'model10', 15, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (288, 'model6', 37, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (289, 'model2', 16, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (290, 'model4', 5, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (291, 'model5', 19, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (292, 'model10', 7, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (293, 'model9', 34, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (294, 'model4', 22, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (295, 'model8', 34, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (296, 'model10', 17, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (297, 'model10', 9, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (298, 'model3', 7, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (299, 'model2', 25, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (300, 'model9', 13, to_date('07-04-2024', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into BUS (busid, model, capacity, purchasedate)
values (301, 'model2', 19, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (302, 'model3', 33, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (303, 'model5', 17, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (304, 'model9', 7, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (305, 'model8', 31, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (306, 'model4', 9, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (307, 'model10', 5, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (308, 'model6', 26, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (309, 'model7', 5, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (310, 'model3', 25, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (311, 'model7', 18, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (312, 'model8', 38, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (313, 'model4', 33, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (314, 'model5', 36, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (315, 'model6', 10, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (316, 'model5', 28, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (317, 'model3', 16, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (318, 'model6', 15, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (319, 'model5', 11, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (320, 'model2', 26, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (321, 'model7', 14, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (322, 'model7', 28, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (323, 'model1', 16, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (324, 'model2', 11, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (325, 'model5', 11, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (326, 'model8', 9, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (327, 'model4', 5, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (328, 'model4', 15, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (329, 'model2', 25, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (330, 'model7', 16, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (331, 'model8', 18, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (332, 'model6', 8, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (333, 'model10', 9, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (334, 'model4', 5, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (335, 'model2', 32, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (336, 'model7', 11, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (337, 'model5', 25, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (338, 'model1', 14, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (339, 'model1', 37, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (340, 'model5', 18, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (341, 'model3', 6, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (342, 'model4', 26, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (343, 'model5', 17, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (344, 'model5', 21, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (345, 'model10', 6, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (346, 'model10', 22, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (347, 'model2', 26, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (348, 'model7', 9, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (349, 'model4', 19, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (350, 'model8', 22, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (351, 'model7', 19, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (352, 'model9', 29, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (353, 'model8', 7, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (354, 'model5', 26, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (355, 'model3', 5, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (356, 'model5', 21, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (357, 'model6', 20, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (358, 'model1', 37, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (359, 'model9', 24, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (360, 'model3', 38, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (361, 'model4', 26, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (362, 'model10', 10, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (363, 'model2', 23, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (364, 'model2', 32, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (365, 'model6', 38, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (366, 'model7', 22, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (367, 'model8', 37, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (368, 'model9', 22, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (369, 'model5', 20, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (370, 'model5', 22, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (371, 'model10', 37, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (372, 'model6', 31, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (373, 'model6', 17, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (374, 'model5', 35, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (375, 'model5', 28, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (376, 'model5', 37, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (377, 'model1', 6, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (378, 'model4', 21, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (379, 'model5', 35, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (380, 'model4', 28, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (381, 'model4', 33, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (382, 'model5', 28, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (383, 'model2', 21, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (384, 'model2', 34, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (385, 'model4', 13, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (386, 'model3', 19, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (387, 'model2', 37, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (388, 'model5', 30, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (389, 'model5', 7, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (390, 'model6', 12, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (391, 'model7', 18, to_date('07-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (392, 'model4', 21, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (393, 'model7', 5, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (394, 'model5', 31, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (395, 'model7', 37, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (396, 'model7', 17, to_date('08-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (397, 'model6', 13, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (398, 'model10', 21, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (399, 'model7', 7, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (400, 'model1', 10, to_date('10-04-2024', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading DRIVER...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (1, 'Sinead Mandrell', '1', to_date('25-08-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (2, 'Marie Jamal', '2', to_date('14-09-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (3, 'Richard Logue', '3', to_date('14-04-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (4, 'Mili McLean', '4', to_date('07-10-2001', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (5, 'Laurence Cleese', '5', to_date('16-06-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (6, 'Jessica Douglas', '6', to_date('09-09-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (7, 'Mos Harry', '7', to_date('29-06-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (8, 'Russell Broadbent', '8', to_date('22-04-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (9, 'Gina McBride', '9', to_date('17-04-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (10, 'Nicholas Hayek', '10', to_date('02-07-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (11, 'Gena Carmen', '11', to_date('19-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (12, 'Jessica Numan', '12', to_date('12-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (13, 'Barbara Teng', '13', to_date('26-08-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (14, 'Kasey Valentin', '14', to_date('28-11-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (15, 'Jonatha Bonneville', '15', to_date('27-11-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (16, 'Kay Creek', '16', to_date('29-07-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (17, 'Collective DiFranco', '17', to_date('14-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (18, 'Caroline Burrows', '18', to_date('24-07-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (19, 'Suzi Chambers', '19', to_date('15-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (20, 'Alicia Hawthorne', '20', to_date('13-10-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (21, 'Chad McDonald', '21', to_date('06-05-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (22, 'Julianna Suvari', '22', to_date('07-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (23, 'Vince Berenger', '23', to_date('25-09-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (24, 'Natalie Sartain', '24', to_date('22-09-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (25, 'Oro Wells', '25', to_date('10-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (26, 'Jimmy Jones', '26', to_date('25-10-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (27, 'Edie Loggia', '27', to_date('25-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (28, 'Darius Watley', '28', to_date('04-07-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (29, 'Emm Salt', '29', to_date('21-11-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (30, 'Rowan Houston', '30', to_date('18-03-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (31, 'Percy Sandler', '31', to_date('07-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (32, 'Deborah Meyer', '32', to_date('14-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (33, 'Miki Wiedlin', '33', to_date('26-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (34, 'Dom Cetera', '34', to_date('17-08-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (35, 'Willie Orlando', '35', to_date('25-05-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (36, 'Cesar Holliday', '36', to_date('16-02-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (37, 'Caroline Rhymes', '37', to_date('07-03-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (38, 'Donna Dutton', '38', to_date('04-01-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (39, 'Geraldine Berry', '39', to_date('22-01-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (40, 'Giovanni Michaels', '40', to_date('05-06-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (41, 'Nik Rhames', '41', to_date('20-10-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (42, 'Emma Raye', '42', to_date('19-07-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (43, 'Amanda Landau', '43', to_date('25-09-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (44, 'Martin Logue', '44', to_date('26-07-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (45, 'Mena Kirkwood', '45', to_date('23-09-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (46, 'Jay McGoohan', '46', to_date('26-12-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (47, 'Meg Blair', '47', to_date('31-03-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (48, 'Nicholas Broza', '48', to_date('17-11-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (49, 'Stephanie Duschel', '49', to_date('19-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (50, 'Bernie Fierstein', '50', to_date('02-01-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (51, 'Jason Bacon', '51', to_date('29-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (52, 'Fiona Lee', '52', to_date('01-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (53, 'Terri McClinton', '53', to_date('18-02-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (54, 'Stellan Paltrow', '54', to_date('12-08-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (55, 'Hilton Shalhoub', '55', to_date('24-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (56, 'Carrie-Anne Richter', '56', to_date('19-01-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (57, 'Ellen Wakeling', '57', to_date('18-08-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (58, 'Nancy Katt', '58', to_date('31-10-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (59, 'Brothers Coleman', '59', to_date('05-09-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (60, 'Mae Stewart', '60', to_date('31-01-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (61, 'Julianna Ammons', '61', to_date('07-12-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (62, 'Delroy Berkoff', '62', to_date('07-07-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (63, 'Ozzy Sewell', '63', to_date('22-06-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (64, 'Gates Rooker', '64', to_date('06-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (65, 'Jeff McCoy', '65', to_date('23-01-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (66, 'Stanley Cross', '66', to_date('14-09-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (67, 'Milla Richards', '67', to_date('12-10-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (68, 'LeVar Grant', '68', to_date('15-01-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (69, 'Domingo Loveless', '69', to_date('17-10-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (70, 'Norm Forrest', '70', to_date('17-04-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (71, 'Rhea Burrows', '71', to_date('17-03-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (72, 'Edgar Basinger', '72', to_date('16-05-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (73, 'Faye Wiest', '73', to_date('23-03-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (74, 'Lucinda Blige', '74', to_date('28-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (75, 'Edwin Blanchett', '75', to_date('23-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (76, 'Harris Voight', '76', to_date('22-12-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (77, 'Suzi Bell', '77', to_date('14-02-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (78, 'Burt Finn', '78', to_date('13-04-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (79, 'Gin McCormack', '79', to_date('22-09-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (80, 'Jeroen Jamal', '80', to_date('02-05-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (81, 'Naomi Guinness', '81', to_date('10-03-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (82, 'Mili Broderick', '82', to_date('13-01-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (83, 'Lynette Leoni', '83', to_date('26-03-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (84, 'Rosario Sepulveda', '84', to_date('17-01-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (85, 'Vonda Quatro', '85', to_date('10-01-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (86, 'Sal Browne', '86', to_date('22-02-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (87, 'Lizzy Murray', '87', to_date('22-01-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (88, 'Vertical Carrere', '88', to_date('29-08-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (89, 'Goldie Sanders', '89', to_date('26-12-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (90, 'Vanessa Browne', '90', to_date('01-01-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (91, 'Shannon Osbourne', '91', to_date('29-06-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (92, 'Kazem MacNeil', '92', to_date('06-07-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (93, 'Jimmie Van Damme', '93', to_date('23-08-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (94, 'Karon Heslov', '94', to_date('07-05-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (95, 'Sal Burstyn', '95', to_date('20-01-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (96, 'Helen Walker', '96', to_date('29-03-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (97, 'Mark Cagle', '97', to_date('09-02-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (98, 'Noah Purefoy', '98', to_date('25-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (99, 'Sharon Paquin', '99', to_date('02-08-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (100, 'Sheryl Danger', '100', to_date('02-01-2022', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (101, 'Stanley Wells', '101', to_date('13-11-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (102, 'Meredith Lindley', '102', to_date('14-07-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (103, 'Kelly McBride', '103', to_date('16-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (104, 'Jill Speaks', '104', to_date('19-01-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (105, 'Kylie Wen', '105', to_date('06-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (106, 'Fisher Wahlberg', '106', to_date('12-09-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (107, 'Celia Tolkan', '107', to_date('09-04-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (108, 'Alice Napolitano', '108', to_date('01-09-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (109, 'Brooke O''Sullivan', '109', to_date('09-06-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (110, 'Tal Vaughn', '110', to_date('22-09-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (111, 'Timothy Torn', '111', to_date('29-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (112, 'Lennie Jones', '112', to_date('17-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (113, 'Melba Iglesias', '113', to_date('25-06-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (114, 'Colm Byrd', '114', to_date('28-07-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (115, 'Cheech Union', '115', to_date('02-03-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (116, 'Jeroen Page', '116', to_date('26-02-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (117, 'King Ruffalo', '117', to_date('22-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (118, 'Holly Holden', '118', to_date('18-06-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (119, 'Gin Collie', '119', to_date('04-04-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (120, 'Bette Madsen', '120', to_date('09-12-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (121, 'Edgar Olyphant', '121', to_date('03-02-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (122, 'Fiona Parsons', '122', to_date('22-04-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (123, 'Leon Sayer', '123', to_date('01-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (124, 'Ivan McClinton', '124', to_date('10-07-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (125, 'Vendetta Caine', '125', to_date('01-12-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (126, 'Jonny Lee Plowright', '126', to_date('03-10-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (127, 'Wesley Shalhoub', '127', to_date('01-07-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (128, 'Karen Sandler', '128', to_date('23-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (129, 'Hope Cagle', '129', to_date('04-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (130, 'Michael Greenwood', '130', to_date('03-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (131, 'King Reeve', '131', to_date('23-10-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (132, 'Freda Holly', '132', to_date('01-01-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (133, 'Alana Masur', '133', to_date('28-07-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (134, 'Remy Ryan', '134', to_date('12-12-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (135, 'Charlie Diehl', '135', to_date('04-01-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (136, 'Gin Guinness', '136', to_date('03-05-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (137, 'Brothers Sandler', '137', to_date('19-05-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (138, 'Frankie Trejo', '138', to_date('01-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (139, 'Buffy Young', '139', to_date('15-09-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (140, 'Oro Lithgow', '140', to_date('13-08-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (141, 'Bernard Walker', '141', to_date('09-11-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (142, 'Lynn Navarro', '142', to_date('20-06-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (143, 'Greg Margolyes', '143', to_date('12-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (144, 'Tracy Rhames', '144', to_date('02-10-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (145, 'Lila Coolidge', '145', to_date('14-05-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (146, 'Mickey Kurtz', '146', to_date('07-04-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (147, 'Olympia Benson', '147', to_date('16-09-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (148, 'Geggy Borden', '148', to_date('16-09-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (149, 'Rosanne Mathis', '149', to_date('10-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (150, 'Kenneth Neuwirth', '150', to_date('25-05-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (151, 'Maury Santana', '151', to_date('10-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (152, 'Vonda Mann', '152', to_date('04-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (153, 'Lizzy Atlas', '153', to_date('17-06-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (154, 'Vickie Lorenz', '154', to_date('09-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (155, 'Mark Ferrer', '155', to_date('18-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (156, 'Maureen Pastore', '156', to_date('29-04-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (157, 'Franz Reed', '157', to_date('30-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (158, 'Jay Lennox', '158', to_date('24-12-2001', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (159, 'Nikka Folds', '159', to_date('20-11-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (160, 'Shawn Hayek', '160', to_date('12-06-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (161, 'Nik Weir', '161', to_date('04-12-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (162, 'Etta DeVito', '162', to_date('07-01-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (163, 'Juan Ramis', '163', to_date('19-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (164, 'Juliana Bacharach', '164', to_date('21-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (165, 'Maureen Witherspoon', '165', to_date('01-09-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (166, 'Salma Rollins', '166', to_date('21-12-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (167, 'Jodie Masur', '167', to_date('26-05-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (168, 'Vivica Serbedzija', '168', to_date('30-01-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (169, 'Vince Steagall', '169', to_date('16-02-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (170, 'Nicky Mattea', '170', to_date('18-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (171, 'Armand England', '171', to_date('12-11-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (172, 'Jon Niven', '172', to_date('01-04-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (173, 'Campbell Bosco', '173', to_date('03-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (174, 'Johnette Shocked', '174', to_date('11-11-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (175, 'Elias Dolenz', '175', to_date('08-05-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (176, 'Lindsey Graham', '176', to_date('07-03-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (177, 'Annette Cazale', '177', to_date('18-10-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (178, 'Rachid Street', '178', to_date('20-06-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (179, 'Rutger Conley', '179', to_date('15-02-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (180, 'Winona Palmieri', '180', to_date('18-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (181, 'Cameron Adkins', '181', to_date('25-12-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (182, 'Chanté McCracken', '182', to_date('27-12-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (183, 'Lance McDowell', '183', to_date('27-07-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (184, 'Nicholas Matthau', '184', to_date('11-12-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (185, 'Catherine Pfeiffer', '185', to_date('08-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (186, 'Heath Zeta-Jones', '186', to_date('25-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (187, 'Sandra Shand', '187', to_date('22-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (188, 'Gabriel Posey', '188', to_date('01-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (189, 'Gilbert Madsen', '189', to_date('14-09-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (190, 'Brittany Michaels', '190', to_date('03-07-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (191, 'Dan Cattrall', '191', to_date('22-08-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (192, 'Pete Cronin', '192', to_date('08-08-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (193, 'Emily Skarsgard', '193', to_date('10-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (194, 'Tramaine Arjona', '194', to_date('29-06-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (195, 'Jill Stone', '195', to_date('24-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (196, 'Freda Rodriguez', '196', to_date('30-04-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (197, 'Rachael Tennison', '197', to_date('06-07-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (198, 'Judge Tinsley', '198', to_date('04-04-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (199, 'Gord Rankin', '199', to_date('05-11-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (200, 'Tim Fraser', '200', to_date('06-02-2004', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (201, 'George Tankard', '201', to_date('26-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (202, 'Rebeka Lineback', '202', to_date('08-02-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (203, 'Davy Osment', '203', to_date('11-10-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (204, 'Austin Creek', '204', to_date('25-06-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (205, 'Avril Spine', '205', to_date('03-10-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (206, 'Daryle Craig', '206', to_date('01-07-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (207, 'Tal Strong', '207', to_date('17-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (208, 'Keith Osborne', '208', to_date('03-09-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (209, 'Jarvis Page', '209', to_date('25-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (210, 'Tia Imbruglia', '210', to_date('05-04-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (211, 'Taye Wilkinson', '211', to_date('10-07-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (212, 'Dwight Rebhorn', '212', to_date('30-04-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (213, 'Mos Benet', '213', to_date('03-12-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (214, 'Chuck Sandler', '214', to_date('30-06-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (215, 'Emma Freeman', '215', to_date('15-06-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (216, 'Sylvester Torres', '216', to_date('20-04-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (217, 'Andrea Scorsese', '217', to_date('20-06-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (218, 'Daniel Huston', '218', to_date('29-07-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (219, 'Jimmy Ali', '219', to_date('25-04-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (220, 'Jesse Pepper', '220', to_date('10-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (221, 'Herbie Spall', '221', to_date('20-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (222, 'Mykelti Berkley', '222', to_date('07-01-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (223, 'Ethan Biel', '223', to_date('12-07-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (224, 'Julie Bell', '224', to_date('11-01-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (225, 'Luke Santana', '225', to_date('25-07-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (226, 'Maria Street', '226', to_date('12-08-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (227, 'Ann Singletary', '227', to_date('23-08-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (228, 'Andie Wopat', '228', to_date('13-12-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (229, 'Jason Borden', '229', to_date('17-01-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (230, 'Gaby Gyllenhaal', '230', to_date('04-09-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (231, 'Stewart Moody', '231', to_date('30-07-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (232, 'Holly Sweet', '232', to_date('04-03-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (233, 'Neve Unger', '233', to_date('13-09-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (234, 'Andrew Harary', '234', to_date('02-09-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (235, 'Donna Arden', '235', to_date('21-04-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (236, 'Chad Kirshner', '236', to_date('04-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (237, 'Dylan Morse', '237', to_date('02-08-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (238, 'Adina Orton', '238', to_date('06-03-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (239, 'Cheryl Martin', '239', to_date('19-06-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (240, 'Steven Klein', '240', to_date('19-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (241, 'Rosario Wolf', '241', to_date('26-07-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (242, 'Dorry Squier', '242', to_date('09-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (243, 'Diane Meniketti', '243', to_date('08-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (244, 'Eric Crudup', '244', to_date('26-02-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (245, 'Rob Scheider', '245', to_date('03-10-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (246, 'Jason McNarland', '246', to_date('29-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (247, 'Dom Kenoly', '247', to_date('28-03-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (248, 'Renee Romijn-Stamos', '248', to_date('04-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (249, 'Melanie Shelton', '249', to_date('05-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (250, 'Emma Curtis', '250', to_date('25-07-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (251, 'Ali Ingram', '251', to_date('09-07-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (252, 'Ron Reilly', '252', to_date('02-07-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (253, 'Fairuza Lyonne', '253', to_date('25-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (254, 'Robert Culkin', '254', to_date('04-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (255, 'Jeroen Biehn', '255', to_date('30-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (256, 'Kim Curtis', '256', to_date('10-11-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (257, 'Stevie Paul', '257', to_date('25-12-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (258, 'Alex Lauper', '258', to_date('16-01-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (259, 'Rachel Richter', '259', to_date('28-05-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (260, 'Daryle Page', '260', to_date('11-03-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (261, 'Molly Hayes', '261', to_date('28-10-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (262, 'Teri Carrington', '262', to_date('26-04-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (263, 'Donald Sartain', '263', to_date('03-03-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (264, 'Campbell Holeman', '264', to_date('20-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (265, 'Robbie Getty', '265', to_date('08-02-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (266, 'Claire Roberts', '266', to_date('15-07-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (267, 'Cornell Cash', '267', to_date('26-02-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (268, 'Cloris Wiedlin', '268', to_date('07-09-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (269, 'Lily Gandolfini', '269', to_date('24-03-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (270, 'Jimmy Keith', '270', to_date('30-11-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (271, 'Lionel Nash', '271', to_date('25-02-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (272, 'Temuera Winans', '272', to_date('03-06-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (273, 'Busta Bridges', '273', to_date('14-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (274, 'Leon Gatlin', '274', to_date('10-07-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (275, 'Ani Paul', '275', to_date('30-11-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (276, 'Lili Minogue', '276', to_date('15-12-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (277, 'Rhona Hartnett', '277', to_date('27-10-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (278, 'Nikki Briscoe', '278', to_date('02-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (279, 'Toni David', '279', to_date('03-09-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (280, 'Cheech Duke', '280', to_date('20-01-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (281, 'Luis Lynn', '281', to_date('11-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (282, 'Miranda Posey', '282', to_date('09-05-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (283, 'Kylie Niven', '283', to_date('19-09-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (284, 'Barbara Colon', '284', to_date('05-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (285, 'Jeroen Browne', '285', to_date('09-08-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (286, 'Linda Morton', '286', to_date('13-11-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (287, 'Ralph Flack', '287', to_date('30-06-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (288, 'Gerald Farina', '288', to_date('14-03-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (289, 'Cole Creek', '289', to_date('22-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (290, 'Lindsay Broza', '290', to_date('25-02-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (291, 'Adina Dempsey', '291', to_date('27-03-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (292, 'Rachel Kahn', '292', to_date('16-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (293, 'Lin Rifkin', '293', to_date('22-12-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (294, 'Richie Travolta', '294', to_date('29-06-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (295, 'Raul Malone', '295', to_date('13-07-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (296, 'Jeffrey Perry', '296', to_date('18-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (297, 'Mira Sossamon', '297', to_date('18-06-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (298, 'Bradley Gill', '298', to_date('20-08-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (299, 'Johnny Rourke', '299', to_date('19-11-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (300, 'Jose Eldard', '300', to_date('25-10-2008', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (301, 'Halle Khan', '301', to_date('01-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (302, 'Maxine Blackmore', '302', to_date('15-12-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (303, 'Geoffrey Mewes', '303', to_date('24-08-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (304, 'Stanley Ranger', '304', to_date('21-11-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (305, 'Trini Snow', '305', to_date('19-04-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (306, 'Gran McClinton', '306', to_date('30-09-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (307, 'Henry Elliott', '307', to_date('03-05-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (308, 'Teena Costa', '308', to_date('10-10-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (309, 'Vanessa Apple', '309', to_date('19-01-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (310, 'Randall Carlyle', '310', to_date('15-06-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (311, 'Adam Johansen', '311', to_date('05-11-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (312, 'Harris Goodman', '312', to_date('24-11-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (313, 'Rhona Bloch', '313', to_date('03-07-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (314, 'Mary Guilfoyle', '314', to_date('26-03-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (315, 'Hank Carnes', '315', to_date('22-05-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (316, 'Michael Hatchet', '316', to_date('08-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (317, 'Nikka Mattea', '317', to_date('15-04-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (318, 'Kieran Craddock', '318', to_date('07-09-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (319, 'Albert Clarkson', '319', to_date('29-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (320, 'Kevin Foxx', '320', to_date('13-02-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (321, 'Don Silverman', '321', to_date('03-06-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (322, 'Howie Head', '322', to_date('15-01-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (323, 'Anita Farina', '323', to_date('10-03-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (324, 'Tcheky Moffat', '324', to_date('10-04-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (325, 'Colin Crouse', '325', to_date('26-03-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (326, 'Jared Crouch', '326', to_date('23-09-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (327, 'Tia Suvari', '327', to_date('05-12-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (328, 'Edie Holiday', '328', to_date('04-02-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (329, 'Lloyd Kramer', '329', to_date('18-04-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (330, 'Tcheky Rispoli', '330', to_date('12-08-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (331, 'Suzi O''Sullivan', '331', to_date('19-11-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (332, 'Chanté Cartlidge', '332', to_date('06-11-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (333, 'Lea Chaykin', '333', to_date('03-03-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (334, 'Benjamin Davidtz', '334', to_date('03-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (335, 'Dylan Cruz', '335', to_date('31-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (336, 'Chi Pryce', '336', to_date('02-11-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (337, 'Owen Van Damme', '337', to_date('09-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (338, 'Stanley Shaye', '338', to_date('23-01-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (339, 'Drew Tarantino', '339', to_date('11-08-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (340, 'Jonatha Reubens', '340', to_date('20-02-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (341, 'Max Zeta-Jones', '341', to_date('22-12-2010', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (342, 'Faye Gaines', '342', to_date('22-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (343, 'Derrick Rhys-Davies', '343', to_date('06-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (344, 'Howie Vassar', '344', to_date('17-04-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (345, 'Holly Stoltz', '345', to_date('30-04-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (346, 'Maceo Maxwell', '346', to_date('20-03-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (347, 'Emma Frakes', '347', to_date('05-11-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (348, 'Sharon Weisberg', '348', to_date('13-01-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (349, 'Kate McFerrin', '349', to_date('03-06-2017', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (350, 'Miki Armatrading', '350', to_date('13-06-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (351, 'Lindsay Cross', '351', to_date('18-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (352, 'Oded Phillippe', '352', to_date('31-08-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (353, 'Max Warren', '353', to_date('16-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (354, 'Freda Moore', '354', to_date('08-07-2009', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (355, 'Art Hornsby', '355', to_date('04-03-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (356, 'Daryl Bergen', '356', to_date('28-02-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (357, 'Maria Ryan', '357', to_date('30-11-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (358, 'Derek Dillane', '358', to_date('10-10-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (359, 'Garland Katt', '359', to_date('17-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (360, 'Bobby Ceasar', '360', to_date('09-08-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (361, 'Betty Meyer', '361', to_date('22-03-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (362, 'Timothy Plummer', '362', to_date('03-11-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (363, 'Murray Kilmer', '363', to_date('26-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (364, 'Chanté Imperioli', '364', to_date('11-01-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (365, 'King Atkinson', '365', to_date('29-07-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (366, 'Paula Uggams', '366', to_date('28-12-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (367, 'Robby Goodall', '367', to_date('10-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (368, 'Colm Finney', '368', to_date('17-04-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (369, 'Mel Skaggs', '369', to_date('24-12-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (370, 'Anna Sedgwick', '370', to_date('22-02-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (371, 'Kim LaSalle', '371', to_date('21-01-2003', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (372, 'Nigel Schneider', '372', to_date('16-01-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (373, 'Clive Pitt', '373', to_date('17-09-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (374, 'Val Blackwell', '374', to_date('05-05-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (375, 'Liv Hughes', '375', to_date('17-06-2011', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (376, 'Phoebe Rickman', '376', to_date('21-05-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (377, 'Rufus Pollack', '377', to_date('06-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (378, 'Ed Rosas', '378', to_date('08-01-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (379, 'Jeffrey Mewes', '379', to_date('02-04-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (380, 'Ron McGriff', '380', to_date('17-05-2014', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (381, 'Parker Griffith', '381', to_date('24-08-2012', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (382, 'Jeffery Ledger', '382', to_date('09-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (383, 'Joseph Cummings', '383', to_date('24-11-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (384, 'Mos Dillon', '384', to_date('05-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (385, 'Merrill Pollak', '385', to_date('21-04-2007', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (386, 'Sammy Loggins', '386', to_date('11-02-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (387, 'Bryan McCann', '387', to_date('08-12-2006', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (388, 'Lena Goldberg', '388', to_date('03-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (389, 'Victor Perrineau', '389', to_date('11-12-2001', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (390, 'Madeline Bloch', '390', to_date('04-08-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (391, 'Norm Pearce', '391', to_date('29-07-2004', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (392, 'Wade Gary', '392', to_date('15-08-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (393, 'Wayman Torn', '393', to_date('14-12-2008', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (394, 'Mindy Streep', '394', to_date('27-05-2005', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (395, 'Javon Schreiber', '395', to_date('07-07-2015', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (396, 'Drew Damon', '396', to_date('30-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (397, 'David Graham', '397', to_date('29-12-2016', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (398, 'Benjamin Johansen', '398', to_date('22-07-2002', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (399, 'Beth Costner', '399', to_date('19-05-2013', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (400, 'Kasey Cusack', '400', to_date('02-04-2009', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading STATION...
insert into STATION (stationid, stationname, stationaddress)
values (1, 'Ridgeview', '5968 Chinook Circle');
insert into STATION (stationid, stationname, stationaddress)
values (2, 'Summerview', '2 Debra Way');
insert into STATION (stationid, stationname, stationaddress)
values (3, 'Kenwood', '113 Amoth Way');
insert into STATION (stationid, stationname, stationaddress)
values (4, 'Crownhardt', '7720 Debs Hill');
insert into STATION (stationid, stationname, stationaddress)
values (5, '6th', '31695 Northland Court');
insert into STATION (stationid, stationname, stationaddress)
values (6, 'Browning', '32353 Kropf Court');
insert into STATION (stationid, stationname, stationaddress)
values (7, 'Fairview', '337 Heffernan Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (8, 'Heffernan', '08 American Hill');
insert into STATION (stationid, stationname, stationaddress)
values (9, 'John Wall', '61100 Nevada Trail');
insert into STATION (stationid, stationname, stationaddress)
values (10, 'Di Loreto', '86498 Milwaukee Trail');
insert into STATION (stationid, stationname, stationaddress)
values (11, 'Northview', '54705 Lillian Lane');
insert into STATION (stationid, stationname, stationaddress)
values (12, 'Larry', '8 Granby Way');
insert into STATION (stationid, stationname, stationaddress)
values (13, 'Burrows', '1803 Westport Point');
insert into STATION (stationid, stationname, stationaddress)
values (14, 'Emmet', '0808 Chive Circle');
insert into STATION (stationid, stationname, stationaddress)
values (15, 'Mayfield', '308 Lotheville Trail');
insert into STATION (stationid, stationname, stationaddress)
values (16, '5th', '673 Shoshone Road');
insert into STATION (stationid, stationname, stationaddress)
values (17, 'Thompson', '77215 Gulseth Pass');
insert into STATION (stationid, stationname, stationaddress)
values (18, 'Union', '177 Tennyson Way');
insert into STATION (stationid, stationname, stationaddress)
values (19, 'Debs', '89482 Upham Drive');
insert into STATION (stationid, stationname, stationaddress)
values (20, 'Center', '12371 Tennessee Hill');
insert into STATION (stationid, stationname, stationaddress)
values (21, 'Di Loreto', '0661 Thackeray Way');
insert into STATION (stationid, stationname, stationaddress)
values (22, 'Cody', '29 Toban Trail');
insert into STATION (stationid, stationname, stationaddress)
values (23, 'Waywood', '1 2nd Center');
insert into STATION (stationid, stationname, stationaddress)
values (24, 'Longview', '18456 Gerald Hill');
insert into STATION (stationid, stationname, stationaddress)
values (25, 'Stone Corner', '38419 Logan Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (26, 'Cambridge', '269 Hoepker Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (27, 'School', '874 Starling Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (28, 'Bayside', '893 Crowley Junction');
insert into STATION (stationid, stationname, stationaddress)
values (29, 'Monument', '96062 Garrison Park');
insert into STATION (stationid, stationname, stationaddress)
values (30, '1st', '7218 Vernon Circle');
insert into STATION (stationid, stationname, stationaddress)
values (31, 'Nobel', '2480 Warrior Alley');
insert into STATION (stationid, stationname, stationaddress)
values (32, 'Fair Oaks', '8 Lawn Drive');
insert into STATION (stationid, stationname, stationaddress)
values (33, 'Columbus', '66599 Helena Way');
insert into STATION (stationid, stationname, stationaddress)
values (34, 'Thierer', '0601 Ramsey Lane');
insert into STATION (stationid, stationname, stationaddress)
values (35, 'Morrow', '901 Morning Park');
insert into STATION (stationid, stationname, stationaddress)
values (36, 'Dayton', '5 1st Center');
insert into STATION (stationid, stationname, stationaddress)
values (37, 'Basil', '7216 Claremont Circle');
insert into STATION (stationid, stationname, stationaddress)
values (38, 'Sage', '1017 Hintze Junction');
insert into STATION (stationid, stationname, stationaddress)
values (39, 'Westerfield', '69 Buena Vista Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (40, 'Center', '54 Westerfield Alley');
insert into STATION (stationid, stationname, stationaddress)
values (41, 'Mallory', '89779 Kenwood Junction');
insert into STATION (stationid, stationname, stationaddress)
values (42, 'Dawn', '60 Eastlawn Lane');
insert into STATION (stationid, stationname, stationaddress)
values (43, 'Spohn', '91 Hintze Place');
insert into STATION (stationid, stationname, stationaddress)
values (44, 'Pawling', '4 Hanson Park');
insert into STATION (stationid, stationname, stationaddress)
values (45, 'North', '73 Service Pass');
insert into STATION (stationid, stationname, stationaddress)
values (46, 'Stuart', '279 Sunfield Trail');
insert into STATION (stationid, stationname, stationaddress)
values (47, 'Pond', '4580 Sloan Park');
insert into STATION (stationid, stationname, stationaddress)
values (48, 'Melrose', '1 Bluestem Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (49, 'Tomscot', '508 Boyd Circle');
insert into STATION (stationid, stationname, stationaddress)
values (50, 'Northridge', '890 Schurz Place');
insert into STATION (stationid, stationname, stationaddress)
values (51, 'Moulton', '5 Caliangt Way');
insert into STATION (stationid, stationname, stationaddress)
values (52, 'Di Loreto', '14138 Hudson Trail');
insert into STATION (stationid, stationname, stationaddress)
values (53, 'Dryden', '9446 Walton Court');
insert into STATION (stationid, stationname, stationaddress)
values (54, 'Hovde', '0 Bartelt Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (55, 'Northport', '01900 Mosinee Junction');
insert into STATION (stationid, stationname, stationaddress)
values (56, 'Elka', '376 Eastwood Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (57, 'Kropf', '9209 North Center');
insert into STATION (stationid, stationname, stationaddress)
values (58, 'Dorton', '010 Shopko Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (59, 'Erie', '414 Comanche Hill');
insert into STATION (stationid, stationname, stationaddress)
values (60, 'Fremont', '03 Butternut Drive');
insert into STATION (stationid, stationname, stationaddress)
values (61, 'Calypso', '2 Nevada Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (62, 'Hoard', '07 Sutherland Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (63, 'Fordem', '0140 Harper Hill');
insert into STATION (stationid, stationname, stationaddress)
values (64, 'Kedzie', '88000 Dapin Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (65, 'Autumn Leaf', '92185 Coolidge Junction');
insert into STATION (stationid, stationname, stationaddress)
values (66, 'Pond', '9133 Clarendon Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (67, 'Washington', '21384 Glendale Place');
insert into STATION (stationid, stationname, stationaddress)
values (68, 'Oxford', '0 Merry Junction');
insert into STATION (stationid, stationname, stationaddress)
values (69, 'Knutson', '94 Loftsgordon Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (70, 'Golf Course', '5 Washington Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (71, 'Riverside', '99399 Lawn Alley');
insert into STATION (stationid, stationname, stationaddress)
values (72, 'Mosinee', '25545 Debs Place');
insert into STATION (stationid, stationname, stationaddress)
values (73, 'Coolidge', '0 Roxbury Place');
insert into STATION (stationid, stationname, stationaddress)
values (74, 'Northwestern', '9563 Cascade Drive');
insert into STATION (stationid, stationname, stationaddress)
values (75, 'Stoughton', '7434 Dovetail Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (76, 'Vidon', '33360 Doe Crossing Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (77, 'Scoville', '45 Loeprich Pass');
insert into STATION (stationid, stationname, stationaddress)
values (78, 'Montana', '37449 Sage Place');
insert into STATION (stationid, stationname, stationaddress)
values (79, 'Forest Run', '34 Mcguire Center');
insert into STATION (stationid, stationname, stationaddress)
values (80, 'Summer Ridge', '43721 Northland Place');
insert into STATION (stationid, stationname, stationaddress)
values (81, 'Dwight', '482 Express Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (82, 'Warbler', '83 Westerfield Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (83, 'Randy', '834 Hanover Street');
insert into STATION (stationid, stationname, stationaddress)
values (84, 'Sugar', '2 Anniversary Trail');
insert into STATION (stationid, stationname, stationaddress)
values (85, 'Buena Vista', '4820 Steensland Point');
insert into STATION (stationid, stationname, stationaddress)
values (86, 'Bartillon', '9793 Warner Circle');
insert into STATION (stationid, stationname, stationaddress)
values (87, 'Starling', '0 Donald Junction');
insert into STATION (stationid, stationname, stationaddress)
values (88, 'Corscot', '54155 Mariners Cove Circle');
insert into STATION (stationid, stationname, stationaddress)
values (89, 'Upham', '382 Barby Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (90, 'Bonner', '88192 Rigney Place');
insert into STATION (stationid, stationname, stationaddress)
values (91, 'Orin', '0 Prairie Rose Center');
insert into STATION (stationid, stationname, stationaddress)
values (92, 'Jenna', '593 Briar Crest Lane');
insert into STATION (stationid, stationname, stationaddress)
values (93, 'Evergreen', '109 Quincy Center');
insert into STATION (stationid, stationname, stationaddress)
values (94, 'Anniversary', '75238 Parkside Court');
insert into STATION (stationid, stationname, stationaddress)
values (95, 'Coleman', '84378 Chive Street');
insert into STATION (stationid, stationname, stationaddress)
values (96, 'Talmadge', '3632 Barnett Court');
insert into STATION (stationid, stationname, stationaddress)
values (97, 'Amoth', '04101 Atwood Point');
insert into STATION (stationid, stationname, stationaddress)
values (98, 'Holmberg', '06826 Commercial Circle');
insert into STATION (stationid, stationname, stationaddress)
values (99, 'Mosinee', '97408 Sunfield Point');
insert into STATION (stationid, stationname, stationaddress)
values (100, 'Gina', '329 Kedzie Center');
commit;
prompt 100 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (101, 'Melby', '64 Walton Hill');
insert into STATION (stationid, stationname, stationaddress)
values (102, 'Service', '24406 Moose Center');
insert into STATION (stationid, stationname, stationaddress)
values (103, 'Sachs', '3827 Mesta Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (104, 'Troy', '97669 Lakewood Gardens Street');
insert into STATION (stationid, stationname, stationaddress)
values (105, 'Twin Pines', '2 6th Place');
insert into STATION (stationid, stationname, stationaddress)
values (106, 'Arapahoe', '0 Becker Alley');
insert into STATION (stationid, stationname, stationaddress)
values (107, 'Parkside', '8280 8th Way');
insert into STATION (stationid, stationname, stationaddress)
values (108, 'Heath', '0 Armistice Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (109, 'Waxwing', '5505 Sachs Road');
insert into STATION (stationid, stationname, stationaddress)
values (110, 'Lakewood', '42597 Village Trail');
insert into STATION (stationid, stationname, stationaddress)
values (111, 'Atwood', '60158 Forest Dale Park');
insert into STATION (stationid, stationname, stationaddress)
values (112, 'Clove', '17 Johnson Junction');
insert into STATION (stationid, stationname, stationaddress)
values (113, 'Heffernan', '0216 Clemons Trail');
insert into STATION (stationid, stationname, stationaddress)
values (114, 'Tony', '54975 Surrey Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (115, 'Fair Oaks', '14054 Fuller Drive');
insert into STATION (stationid, stationname, stationaddress)
values (116, 'Hintze', '56 Elka Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (117, 'Dottie', '02 Brown Junction');
insert into STATION (stationid, stationname, stationaddress)
values (118, 'Division', '01874 Bay Way');
insert into STATION (stationid, stationname, stationaddress)
values (119, 'Quincy', '81931 Jackson Way');
insert into STATION (stationid, stationname, stationaddress)
values (120, 'Coleman', '20037 Calypso Alley');
insert into STATION (stationid, stationname, stationaddress)
values (121, 'Judy', '78 Kennedy Point');
insert into STATION (stationid, stationname, stationaddress)
values (122, 'Evergreen', '846 Kingsford Park');
insert into STATION (stationid, stationname, stationaddress)
values (123, 'High Crossing', '73645 North Lane');
insert into STATION (stationid, stationname, stationaddress)
values (124, '6th', '1 Delaware Hill');
insert into STATION (stationid, stationname, stationaddress)
values (125, 'Meadow Vale', '7 Hooker Circle');
insert into STATION (stationid, stationname, stationaddress)
values (126, 'Pierstorff', '926 John Wall Junction');
insert into STATION (stationid, stationname, stationaddress)
values (127, 'Swallow', '5650 Sunbrook Junction');
insert into STATION (stationid, stationname, stationaddress)
values (128, 'Blue Bill Park', '5764 Maple Way');
insert into STATION (stationid, stationname, stationaddress)
values (129, 'Paget', '51 Fieldstone Lane');
insert into STATION (stationid, stationname, stationaddress)
values (130, 'Stuart', '35430 Lotheville Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (131, 'Bobwhite', '1203 Village Drive');
insert into STATION (stationid, stationname, stationaddress)
values (132, 'Southridge', '5913 Hudson Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (133, 'Golf View', '47969 Helena Circle');
insert into STATION (stationid, stationname, stationaddress)
values (134, 'Kim', '16 Amoth Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (135, 'Saint Paul', '89 Evergreen Lane');
insert into STATION (stationid, stationname, stationaddress)
values (136, 'Esch', '47 Corry Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (137, 'Parkside', '61 Southridge Trail');
insert into STATION (stationid, stationname, stationaddress)
values (138, 'Colorado', '9 Red Cloud Road');
insert into STATION (stationid, stationname, stationaddress)
values (139, 'Merry', '967 Pleasure Street');
insert into STATION (stationid, stationname, stationaddress)
values (140, 'Gulseth', '01033 Spenser Way');
insert into STATION (stationid, stationname, stationaddress)
values (141, 'Bashford', '48085 Cordelia Point');
insert into STATION (stationid, stationname, stationaddress)
values (142, 'Vernon', '36 Carioca Alley');
insert into STATION (stationid, stationname, stationaddress)
values (143, 'Sunnyside', '68 Talmadge Court');
insert into STATION (stationid, stationname, stationaddress)
values (144, 'Hovde', '3033 Sheridan Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (145, 'Shelley', '4 Westridge Hill');
insert into STATION (stationid, stationname, stationaddress)
values (146, 'Randy', '4 Cherokee Court');
insert into STATION (stationid, stationname, stationaddress)
values (147, 'Kropf', '55985 Browning Court');
insert into STATION (stationid, stationname, stationaddress)
values (148, 'Crescent Oaks', '1 Walton Lane');
insert into STATION (stationid, stationname, stationaddress)
values (149, 'Dixon', '00 Dunning Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (150, 'Fair Oaks', '159 Katie Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (151, 'Knutson', '4 Old Gate Alley');
insert into STATION (stationid, stationname, stationaddress)
values (152, 'Crest Line', '0 Eggendart Drive');
insert into STATION (stationid, stationname, stationaddress)
values (153, 'Moland', '46 Hansons Circle');
insert into STATION (stationid, stationname, stationaddress)
values (154, 'Westerfield', '172 Hanover Alley');
insert into STATION (stationid, stationname, stationaddress)
values (155, 'Golf View', '2 Duke Junction');
insert into STATION (stationid, stationname, stationaddress)
values (156, 'Granby', '96267 Grim Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (157, 'Atwood', '0 Becker Place');
insert into STATION (stationid, stationname, stationaddress)
values (158, 'Colorado', '25 Orin Way');
insert into STATION (stationid, stationname, stationaddress)
values (159, '1st', '77 Hoffman Street');
insert into STATION (stationid, stationname, stationaddress)
values (160, 'Dorton', '7 Superior Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (161, 'Spaight', '5700 Roth Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (162, 'Crowley', '7 Buhler Hill');
insert into STATION (stationid, stationname, stationaddress)
values (163, 'Express', '793 Crownhardt Way');
insert into STATION (stationid, stationname, stationaddress)
values (164, 'Longview', '1 Schurz Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (165, 'Sloan', '5745 Moulton Court');
insert into STATION (stationid, stationname, stationaddress)
values (166, 'Gerald', '6 Briar Crest Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (167, 'Forest Dale', '5 Nevada Trail');
insert into STATION (stationid, stationname, stationaddress)
values (168, 'Westerfield', '5 Warbler Park');
insert into STATION (stationid, stationname, stationaddress)
values (169, 'Katie', '22 Brickson Park Park');
insert into STATION (stationid, stationname, stationaddress)
values (170, 'Utah', '61 Calypso Pass');
insert into STATION (stationid, stationname, stationaddress)
values (171, 'Cardinal', '30 American Ash Pass');
insert into STATION (stationid, stationname, stationaddress)
values (172, 'Hanover', '123 Grayhawk Place');
insert into STATION (stationid, stationname, stationaddress)
values (173, 'Troy', '81 Trailsway Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (174, 'Canary', '462 Mariners Cove Pass');
insert into STATION (stationid, stationname, stationaddress)
values (175, 'Hudson', '2195 Thierer Point');
insert into STATION (stationid, stationname, stationaddress)
values (176, 'Aberg', '2 Westend Point');
insert into STATION (stationid, stationname, stationaddress)
values (177, 'Golf View', '1 Michigan Place');
insert into STATION (stationid, stationname, stationaddress)
values (178, 'Atwood', '82299 Carberry Point');
insert into STATION (stationid, stationname, stationaddress)
values (179, 'Morning', '10 Dapin Road');
insert into STATION (stationid, stationname, stationaddress)
values (180, 'Meadow Ridge', '392 North Way');
insert into STATION (stationid, stationname, stationaddress)
values (181, 'Holy Cross', '2 7th Road');
insert into STATION (stationid, stationname, stationaddress)
values (182, 'Rockefeller', '5 Michigan Center');
insert into STATION (stationid, stationname, stationaddress)
values (183, 'Pawling', '1678 Buena Vista Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (184, 'Nevada', '3 Charing Cross Way');
insert into STATION (stationid, stationname, stationaddress)
values (185, 'Old Shore', '479 Little Fleur Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (186, 'Clemons', '5072 Jay Center');
insert into STATION (stationid, stationname, stationaddress)
values (187, 'Moose', '390 Derek Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (188, 'Sutherland', '3549 Dakota Drive');
insert into STATION (stationid, stationname, stationaddress)
values (189, 'Arizona', '2099 Carpenter Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (190, 'Kensington', '54910 Ilene Lane');
insert into STATION (stationid, stationname, stationaddress)
values (191, 'Starling', '9 Eastlawn Center');
insert into STATION (stationid, stationname, stationaddress)
values (192, 'Fallview', '1272 Kinsman Junction');
insert into STATION (stationid, stationname, stationaddress)
values (193, 'Debra', '2 Thompson Lane');
insert into STATION (stationid, stationname, stationaddress)
values (194, 'Badeau', '0 Forest Alley');
insert into STATION (stationid, stationname, stationaddress)
values (195, 'Shoshone', '8 Prairieview Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (196, 'Sage', '3 Lakewood Pass');
insert into STATION (stationid, stationname, stationaddress)
values (197, 'Dixon', '211 Burrows Road');
insert into STATION (stationid, stationname, stationaddress)
values (198, 'Elka', '90 Hooker Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (199, 'Harbort', '771 Packers Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (200, 'Schlimgen', '1 Waxwing Street');
commit;
prompt 200 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (201, 'Harper', '982 Meadow Ridge Circle');
insert into STATION (stationid, stationname, stationaddress)
values (202, 'New Castle', '98522 Everett Road');
insert into STATION (stationid, stationname, stationaddress)
values (203, 'Main', '5037 Mosinee Alley');
insert into STATION (stationid, stationname, stationaddress)
values (204, 'Comanche', '48334 Welch Road');
insert into STATION (stationid, stationname, stationaddress)
values (205, 'Green Ridge', '4218 Marcy Lane');
insert into STATION (stationid, stationname, stationaddress)
values (206, 'Mariners Cove', '6359 Porter Place');
insert into STATION (stationid, stationname, stationaddress)
values (207, 'Hoard', '8528 Spohn Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (208, 'Dwight', '8 Forest Run Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (209, 'Park Meadow', '7262 Gulseth Point');
insert into STATION (stationid, stationname, stationaddress)
values (210, 'Bartelt', '224 Hudson Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (211, 'Magdeline', '6 Harbort Park');
insert into STATION (stationid, stationname, stationaddress)
values (212, 'Service', '9 Del Sol Point');
insert into STATION (stationid, stationname, stationaddress)
values (213, 'Hoepker', '9459 Lillian Center');
insert into STATION (stationid, stationname, stationaddress)
values (214, 'Tony', '23 Westerfield Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (215, 'Nancy', '87 Butternut Street');
insert into STATION (stationid, stationname, stationaddress)
values (216, 'Macpherson', '56947 Colorado Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (217, 'Redwing', '60 Upham Hill');
insert into STATION (stationid, stationname, stationaddress)
values (218, 'Harbort', '85265 Tony Road');
insert into STATION (stationid, stationname, stationaddress)
values (219, 'Comanche', '26294 Nancy Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (220, 'Forest Dale', '33601 Killdeer Trail');
insert into STATION (stationid, stationname, stationaddress)
values (221, '2nd', '51 Becker Way');
insert into STATION (stationid, stationname, stationaddress)
values (222, 'Summer Ridge', '9 Crownhardt Park');
insert into STATION (stationid, stationname, stationaddress)
values (223, 'Tony', '5834 Southridge Court');
insert into STATION (stationid, stationname, stationaddress)
values (224, 'Dexter', '1515 Monica Street');
insert into STATION (stationid, stationname, stationaddress)
values (225, 'Rieder', '3 Westerfield Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (226, 'Elmside', '5094 Fairfield Place');
insert into STATION (stationid, stationname, stationaddress)
values (227, 'Northwestern', '53163 Summer Ridge Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (228, 'Main', '0317 Continental Drive');
insert into STATION (stationid, stationname, stationaddress)
values (229, 'Straubel', '290 Nelson Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (230, 'Ridgeway', '02 Corscot Court');
insert into STATION (stationid, stationname, stationaddress)
values (231, 'Sheridan', '1418 Rockefeller Hill');
insert into STATION (stationid, stationname, stationaddress)
values (232, 'Bunting', '99 Florence Pass');
insert into STATION (stationid, stationname, stationaddress)
values (233, 'Thierer', '8276 Glacier Hill Court');
insert into STATION (stationid, stationname, stationaddress)
values (234, 'Comanche', '06 Hollow Ridge Pass');
insert into STATION (stationid, stationname, stationaddress)
values (235, 'Fordem', '0 Mcbride Junction');
insert into STATION (stationid, stationname, stationaddress)
values (236, 'Glendale', '7418 Menomonie Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (237, 'Nova', '8 Acker Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (238, 'Oak Valley', '0616 Mcbride Drive');
insert into STATION (stationid, stationname, stationaddress)
values (239, 'Comanche', '2 Northfield Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (240, 'Pine View', '26348 Summit Way');
insert into STATION (stationid, stationname, stationaddress)
values (241, 'Hermina', '7271 Derek Court');
insert into STATION (stationid, stationname, stationaddress)
values (242, 'Springview', '6 Loomis Street');
insert into STATION (stationid, stationname, stationaddress)
values (243, 'Westport', '5 Esker Way');
insert into STATION (stationid, stationname, stationaddress)
values (244, 'Pine View', '19 Clove Place');
insert into STATION (stationid, stationname, stationaddress)
values (245, 'Eastlawn', '81 Maywood Drive');
insert into STATION (stationid, stationname, stationaddress)
values (246, 'Briar Crest', '83313 Helena Drive');
insert into STATION (stationid, stationname, stationaddress)
values (247, 'Dryden', '30 Banding Center');
insert into STATION (stationid, stationname, stationaddress)
values (248, 'Grayhawk', '50858 Victoria Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (249, 'Grover', '021 Riverside Road');
insert into STATION (stationid, stationname, stationaddress)
values (250, 'Gerald', '2 Westport Circle');
insert into STATION (stationid, stationname, stationaddress)
values (251, 'Maple Wood', '390 Morning Lane');
insert into STATION (stationid, stationname, stationaddress)
values (252, 'New Castle', '4 Eggendart Lane');
insert into STATION (stationid, stationname, stationaddress)
values (253, 'Truax', '1764 Prentice Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (254, 'Tennessee', '5686 Haas Park');
insert into STATION (stationid, stationname, stationaddress)
values (255, 'Kenwood', '8345 Northland Circle');
insert into STATION (stationid, stationname, stationaddress)
values (256, 'Ridge Oak', '09051 American Ash Park');
insert into STATION (stationid, stationname, stationaddress)
values (257, 'Sherman', '948 Melrose Center');
insert into STATION (stationid, stationname, stationaddress)
values (258, 'Cascade', '284 Park Meadow Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (259, 'Bay', '45 Ilene Place');
insert into STATION (stationid, stationname, stationaddress)
values (260, 'Bartillon', '42 Little Fleur Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (261, 'Ryan', '4 Raven Street');
insert into STATION (stationid, stationname, stationaddress)
values (262, 'Artisan', '88 Huxley Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (263, 'Longview', '65238 Bowman Pass');
insert into STATION (stationid, stationname, stationaddress)
values (264, 'Main', '780 American Ash Place');
insert into STATION (stationid, stationname, stationaddress)
values (265, 'Badeau', '28653 Longview Park');
insert into STATION (stationid, stationname, stationaddress)
values (266, 'Valley Edge', '490 Kinsman Street');
insert into STATION (stationid, stationname, stationaddress)
values (267, 'Cardinal', '9 Gateway Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (268, 'Pennsylvania', '2218 Del Mar Lane');
insert into STATION (stationid, stationname, stationaddress)
values (269, 'Bay', '25 Dapin Center');
insert into STATION (stationid, stationname, stationaddress)
values (270, 'Canary', '7 Kensington Hill');
insert into STATION (stationid, stationname, stationaddress)
values (271, 'Moulton', '264 Northland Alley');
insert into STATION (stationid, stationname, stationaddress)
values (272, 'Melby', '5 Magdeline Center');
insert into STATION (stationid, stationname, stationaddress)
values (273, 'Montana', '071 Annamark Road');
insert into STATION (stationid, stationname, stationaddress)
values (274, 'Trailsway', '24446 Maple Trail');
insert into STATION (stationid, stationname, stationaddress)
values (275, 'Mendota', '51550 Vera Hill');
insert into STATION (stationid, stationname, stationaddress)
values (276, 'Riverside', '91 Petterle Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (277, 'Merchant', '512 Iowa Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (278, 'Doe Crossing', '7619 Marcy Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (279, 'Almo', '9 Graedel Pass');
insert into STATION (stationid, stationname, stationaddress)
values (280, 'Crescent Oaks', '49633 Mallard Lane');
insert into STATION (stationid, stationname, stationaddress)
values (281, 'Sauthoff', '260 Sage Street');
insert into STATION (stationid, stationname, stationaddress)
values (282, 'Loftsgordon', '280 Scott Way');
insert into STATION (stationid, stationname, stationaddress)
values (283, 'Del Sol', '0758 Harbort Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (284, 'Fuller', '76619 Longview Road');
insert into STATION (stationid, stationname, stationaddress)
values (285, 'Mosinee', '11 Johnson Road');
insert into STATION (stationid, stationname, stationaddress)
values (286, 'Nevada', '70 Mcbride Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (287, 'John Wall', '4 Hoepker Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (288, 'Springs', '3 Butternut Lane');
insert into STATION (stationid, stationname, stationaddress)
values (289, 'Anniversary', '641 Buell Lane');
insert into STATION (stationid, stationname, stationaddress)
values (290, 'Nelson', '74 Trailsway Road');
insert into STATION (stationid, stationname, stationaddress)
values (291, 'Continental', '404 Manley Park');
insert into STATION (stationid, stationname, stationaddress)
values (292, 'Heffernan', '0084 Cottonwood Pass');
insert into STATION (stationid, stationname, stationaddress)
values (293, 'Carberry', '84189 8th Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (294, 'Graceland', '07641 Hoffman Center');
insert into STATION (stationid, stationname, stationaddress)
values (295, 'Huxley', '40 Spenser Circle');
insert into STATION (stationid, stationname, stationaddress)
values (296, 'Goodland', '9 Truax Way');
insert into STATION (stationid, stationname, stationaddress)
values (297, 'Forest', '10869 Roth Street');
insert into STATION (stationid, stationname, stationaddress)
values (298, 'Truax', '0 Spaight Point');
insert into STATION (stationid, stationname, stationaddress)
values (299, 'South', '1 Union Court');
insert into STATION (stationid, stationname, stationaddress)
values (300, 'Mallory', '31536 Barby Lane');
commit;
prompt 300 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (301, 'Commercial', '72 Veith Junction');
insert into STATION (stationid, stationname, stationaddress)
values (302, 'Kensington', '234 Hollow Ridge Street');
insert into STATION (stationid, stationname, stationaddress)
values (303, 'Northfield', '0458 Erie Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (304, 'Burrows', '761 Dennis Road');
insert into STATION (stationid, stationname, stationaddress)
values (305, 'Longview', '68 Eggendart Junction');
insert into STATION (stationid, stationname, stationaddress)
values (306, 'Jenna', '3 Crownhardt Pass');
insert into STATION (stationid, stationname, stationaddress)
values (307, 'Fairview', '63911 Florence Street');
insert into STATION (stationid, stationname, stationaddress)
values (308, 'Stuart', '5 Pierstorff Drive');
insert into STATION (stationid, stationname, stationaddress)
values (309, '2nd', '23819 Pankratz Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (310, 'Petterle', '22661 Becker Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (311, 'Truax', '9196 Bashford Circle');
insert into STATION (stationid, stationname, stationaddress)
values (312, 'Mendota', '641 Grayhawk Lane');
insert into STATION (stationid, stationname, stationaddress)
values (313, 'Hanson', '3098 Gateway Circle');
insert into STATION (stationid, stationname, stationaddress)
values (314, 'Moulton', '5 Mifflin Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (315, 'Forest', '8 Rigney Pass');
insert into STATION (stationid, stationname, stationaddress)
values (316, 'Colorado', '27 Prairie Rose Trail');
insert into STATION (stationid, stationname, stationaddress)
values (317, 'Saint Paul', '17 Heath Hill');
insert into STATION (stationid, stationname, stationaddress)
values (318, 'Evergreen', '0 Westend Junction');
insert into STATION (stationid, stationname, stationaddress)
values (319, 'Nevada', '262 Sachs Pass');
insert into STATION (stationid, stationname, stationaddress)
values (320, 'Myrtle', '4456 Gulseth Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (321, 'Calypso', '885 Judy Street');
insert into STATION (stationid, stationname, stationaddress)
values (322, 'Emmet', '8 Pepper Wood Trail');
insert into STATION (stationid, stationname, stationaddress)
values (323, 'Pankratz', '503 Luster Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (324, 'Springview', '5685 Ramsey Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (325, 'Haas', '80728 Hanover Circle');
insert into STATION (stationid, stationname, stationaddress)
values (326, 'Maple', '1071 Hayes Park');
insert into STATION (stationid, stationname, stationaddress)
values (327, 'Trailsway', '259 Lakeland Junction');
insert into STATION (stationid, stationname, stationaddress)
values (328, 'Manley', '1497 Bobwhite Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (329, 'Nova', '9921 Walton Alley');
insert into STATION (stationid, stationname, stationaddress)
values (330, 'Mesta', '183 Bowman Junction');
insert into STATION (stationid, stationname, stationaddress)
values (331, 'Vera', '9 Debra Center');
insert into STATION (stationid, stationname, stationaddress)
values (332, 'Mallory', '34040 Oak Valley Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (333, 'Mockingbird', '18576 Lunder Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (334, 'Graceland', '1033 Ilene Street');
insert into STATION (stationid, stationname, stationaddress)
values (335, 'Carpenter', '25 Daystar Lane');
insert into STATION (stationid, stationname, stationaddress)
values (336, 'Prentice', '231 Colorado Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (337, 'Hoepker', '41 Green Ridge Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (338, 'Mcguire', '4708 Packers Court');
insert into STATION (stationid, stationname, stationaddress)
values (339, '4th', '47 Farmco Way');
insert into STATION (stationid, stationname, stationaddress)
values (340, 'Shopko', '59 Lawn Park');
insert into STATION (stationid, stationname, stationaddress)
values (341, 'Derek', '098 Boyd Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (342, 'Welch', '0 Lakewood Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (343, 'Moulton', '220 Golf Course Park');
insert into STATION (stationid, stationname, stationaddress)
values (344, 'Toban', '44855 Brickson Park Pass');
insert into STATION (stationid, stationname, stationaddress)
values (345, 'Iowa', '69348 Donald Pass');
insert into STATION (stationid, stationname, stationaddress)
values (346, 'Claremont', '06 Meadow Ridge Hill');
insert into STATION (stationid, stationname, stationaddress)
values (347, 'Village Green', '782 Nobel Junction');
insert into STATION (stationid, stationname, stationaddress)
values (348, 'Farmco', '09 Longview Alley');
insert into STATION (stationid, stationname, stationaddress)
values (349, 'Nova', '629 Garrison Hill');
insert into STATION (stationid, stationname, stationaddress)
values (350, 'John Wall', '219 Lerdahl Place');
insert into STATION (stationid, stationname, stationaddress)
values (351, '2nd', '765 Iowa Circle');
insert into STATION (stationid, stationname, stationaddress)
values (352, 'Lake View', '1 Butternut Point');
insert into STATION (stationid, stationname, stationaddress)
values (353, 'Truax', '8 Bunker Hill Trail');
insert into STATION (stationid, stationname, stationaddress)
values (354, 'Carey', '68597 Truax Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (355, 'Commercial', '5 Fisk Road');
insert into STATION (stationid, stationname, stationaddress)
values (356, 'Vidon', '6 Paget Point');
insert into STATION (stationid, stationname, stationaddress)
values (357, 'Alpine', '94 Talmadge Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (358, 'Vidon', '01 Maple Wood Pass');
insert into STATION (stationid, stationname, stationaddress)
values (359, 'Oxford', '20675 Crescent Oaks Point');
insert into STATION (stationid, stationname, stationaddress)
values (360, 'Mayfield', '98680 Stephen Center');
insert into STATION (stationid, stationname, stationaddress)
values (361, 'Oak Valley', '098 Fremont Center');
insert into STATION (stationid, stationname, stationaddress)
values (362, 'Everett', '32 Troy Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (363, 'Debra', '23 3rd Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (364, 'Loomis', '0 Birchwood Pass');
insert into STATION (stationid, stationname, stationaddress)
values (365, 'Cambridge', '4 Swallow Street');
insert into STATION (stationid, stationname, stationaddress)
values (366, 'Thierer', '84809 Mccormick Hill');
insert into STATION (stationid, stationname, stationaddress)
values (367, 'Dunning', '6434 Northland Center');
insert into STATION (stationid, stationname, stationaddress)
values (368, 'Golden Leaf', '012 Stephen Park');
insert into STATION (stationid, stationname, stationaddress)
values (369, 'Debs', '70628 Oxford Point');
insert into STATION (stationid, stationname, stationaddress)
values (370, 'Portage', '17 Waubesa Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (371, 'Nobel', '1096 Lighthouse Bay Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (372, 'Golden Leaf', '65 Westridge Alley');
insert into STATION (stationid, stationname, stationaddress)
values (373, 'Sauthoff', '3 Homewood Center');
insert into STATION (stationid, stationname, stationaddress)
values (374, 'Hallows', '4730 Barnett Center');
insert into STATION (stationid, stationname, stationaddress)
values (375, 'Mockingbird', '66 Hintze Hill');
insert into STATION (stationid, stationname, stationaddress)
values (376, 'Little Fleur', '09 Raven Trail');
insert into STATION (stationid, stationname, stationaddress)
values (377, 'Stuart', '21219 Delladonna Court');
insert into STATION (stationid, stationname, stationaddress)
values (378, 'Packers', '5 Longview Drive');
insert into STATION (stationid, stationname, stationaddress)
values (379, 'Morrow', '68722 Ohio Circle');
insert into STATION (stationid, stationname, stationaddress)
values (380, 'Fisk', '356 Scoville Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (381, 'West', '599 Nova Park');
insert into STATION (stationid, stationname, stationaddress)
values (382, 'Springview', '2297 Fieldstone Road');
insert into STATION (stationid, stationname, stationaddress)
values (383, 'Gulseth', '5 Macpherson Junction');
insert into STATION (stationid, stationname, stationaddress)
values (384, 'Division', '008 Ridgeview Hill');
insert into STATION (stationid, stationname, stationaddress)
values (385, 'Center', '105 Messerschmidt Place');
insert into STATION (stationid, stationname, stationaddress)
values (386, 'Merry', '4 Beilfuss Road');
insert into STATION (stationid, stationname, stationaddress)
values (387, 'Alpine', '80304 Sauthoff Alley');
insert into STATION (stationid, stationname, stationaddress)
values (388, 'Meadow Ridge', '399 Canary Trail');
insert into STATION (stationid, stationname, stationaddress)
values (389, 'Declaration', '69 Ilene Place');
insert into STATION (stationid, stationname, stationaddress)
values (390, 'Transport', '50648 Michigan Lane');
insert into STATION (stationid, stationname, stationaddress)
values (391, 'Farmco', '6 Hoffman Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (392, 'Banding', '4 Towne Trail');
insert into STATION (stationid, stationname, stationaddress)
values (393, 'Briar Crest', '175 Carey Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (394, 'Old Gate', '81644 Mcbride Circle');
insert into STATION (stationid, stationname, stationaddress)
values (395, 'Upham', '41166 Atwood Point');
insert into STATION (stationid, stationname, stationaddress)
values (396, 'Sundown', '56 Holy Cross Trail');
insert into STATION (stationid, stationname, stationaddress)
values (397, 'Ronald Regan', '53701 Blackbird Road');
insert into STATION (stationid, stationname, stationaddress)
values (398, 'Melby', '876 Maple Wood Place');
insert into STATION (stationid, stationname, stationaddress)
values (399, 'Schlimgen', '17006 Spenser Point');
insert into STATION (stationid, stationname, stationaddress)
values (400, 'Westerfield', '1 Atwood Road');
commit;
prompt 400 records loaded
prompt Loading ROUTE...
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (1, 'Chi976', 378, 39);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (2, 'Sam232', 397, 108);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (3, 'Suzanne896', 385, 103);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (4, 'Rich858', 153, 299);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (5, 'Curtis173', 34, 225);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (6, 'Yolanda6', 169, 301);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (7, 'Rod918', 32, 387);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (8, 'Millie825', 142, 396);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (9, 'Nickel270', 368, 298);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (10, 'Carlos841', 151, 95);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (11, 'Rhys863', 49, 56);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (12, 'Chely709', 151, 20);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (13, 'Jarvis353', 147, 245);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (14, 'Chubby16', 394, 10);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (15, 'Ossie12', 193, 253);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (16, 'Cliff163', 380, 249);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (17, 'Nickel382', 282, 13);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (18, 'Liv294', 321, 224);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (19, 'Connie991', 109, 371);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (20, 'Petula296', 341, 302);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (21, 'Mary Beth132', 120, 82);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (22, 'Joshua862', 199, 341);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (23, 'Mac707', 5, 224);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (24, 'Christian608', 327, 115);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (25, 'Dick128', 102, 45);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (26, 'Sheryl266', 214, 371);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (27, 'Janice287', 131, 225);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (28, 'Chuck927', 89, 112);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (29, 'Patty584', 52, 376);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (30, 'Robin353', 351, 100);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (31, 'Gord17', 249, 356);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (32, 'Cloris350', 311, 187);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (33, 'Marlon340', 241, 213);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (34, 'Malcolm202', 265, 69);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (35, 'Kenny276', 312, 350);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (36, 'Jill174', 88, 271);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (37, 'Tcheky799', 71, 325);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (38, 'Aidan67', 355, 147);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (39, 'Mary Beth474', 336, 260);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (40, 'Donald843', 392, 114);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (41, 'Gates865', 344, 93);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (42, 'Guy311', 43, 107);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (43, 'Dan995', 280, 237);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (44, 'Blair875', 361, 256);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (45, 'Judd881', 339, 82);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (46, 'Selma345', 44, 198);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (47, 'Pelvic125', 312, 304);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (48, 'Sally808', 361, 203);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (49, 'Ashton566', 89, 217);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (50, 'Mika566', 245, 128);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (51, 'Terri999', 294, 132);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (52, 'Alec132', 269, 201);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (53, 'Aida953', 249, 356);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (54, 'Cameron293', 380, 28);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (55, 'Peter532', 50, 12);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (56, 'Sissy231', 142, 215);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (57, 'Norm323', 381, 72);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (58, 'Vickie708', 302, 234);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (59, 'Rob359', 45, 234);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (60, 'Merrilee315', 97, 98);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (61, 'Denny149', 22, 16);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (62, 'Joseph786', 262, 263);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (63, 'Hector773', 56, 63);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (64, 'Olympia364', 185, 169);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (65, 'Isabella29', 161, 102);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (66, 'Nelly242', 377, 184);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (67, 'Nicholas660', 253, 304);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (68, 'Rowan59', 265, 191);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (69, 'Carl624', 313, 80);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (70, 'Lucy461', 116, 392);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (71, 'Blair441', 268, 293);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (72, 'Dean725', 278, 339);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (73, 'Jeffrey595', 397, 108);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (74, 'Don441', 162, 189);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (75, 'Chazz4', 272, 56);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (76, 'Sheena264', 125, 184);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (77, 'Rosco544', 209, 129);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (78, 'Bebe724', 299, 354);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (79, 'Adrien646', 54, 96);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (80, 'Mena96', 337, 57);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (81, 'Freddie947', 93, 46);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (82, 'Ty340', 80, 121);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (83, 'Irene8', 87, 359);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (84, 'Kenny95', 356, 35);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (85, 'Night93', 25, 297);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (86, 'Johnnie742', 302, 150);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (87, 'Willem13', 213, 20);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (88, 'Owen527', 8, 109);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (89, 'Philip25', 280, 30);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (90, 'Beverley743', 87, 305);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (91, 'Jamie804', 311, 43);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (92, 'Willie985', 174, 360);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (93, 'George471', 111, 76);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (94, 'Fats453', 346, 231);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (95, 'Lydia682', 177, 169);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (96, 'Millie331', 270, 338);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (97, 'Minnie786', 22, 327);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (98, 'Stanley218', 69, 324);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (99, 'Sally41', 194, 287);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (100, 'Vendetta630', 122, 32);
commit;
prompt 100 records committed...
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (101, 'Josh891', 45, 311);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (102, 'Amanda557', 184, 309);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (103, 'Beverley309', 9, 206);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (104, 'Bradley89', 234, 45);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (105, 'Coley204', 14, 165);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (106, 'Laurence99', 244, 216);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (107, 'Andrea883', 11, 233);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (108, 'Kirk993', 74, 175);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (109, 'Brian584', 238, 9);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (110, 'Benicio520', 297, 151);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (111, 'Hugo67', 1, 148);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (112, 'Brothers646', 340, 383);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (113, 'Marisa266', 181, 123);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (114, 'Debby484', 361, 76);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (115, 'Armin9', 271, 177);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (116, 'Elizabeth303', 40, 175);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (117, 'Helen797', 332, 325);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (118, 'Robbie576', 300, 379);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (119, 'Davy642', 278, 369);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (120, 'Donna113', 361, 368);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (121, 'Julio976', 83, 141);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (122, 'Adam240', 100, 56);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (123, 'Mindy615', 117, 370);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (124, 'Deborah53', 155, 73);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (125, 'Neve790', 2, 179);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (126, 'Laurie721', 141, 75);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (127, 'Tal237', 396, 398);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (128, 'Kristin867', 201, 66);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (129, 'Lea353', 108, 311);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (130, 'Tori998', 273, 361);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (131, 'Gil411', 118, 220);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (132, 'Sarah3', 289, 164);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (133, 'Matthew841', 149, 241);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (134, 'Loren720', 95, 370);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (135, 'Kenny572', 144, 123);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (136, 'Howard551', 293, 201);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (137, 'Nikki433', 275, 85);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (138, 'Andy152', 23, 58);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (139, 'Dionne624', 278, 292);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (140, 'Bobby179', 45, 201);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (141, 'Vickie243', 112, 141);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (142, 'Cevin102', 370, 60);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (143, 'Russell879', 338, 185);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (144, 'Phoebe73', 7, 155);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (145, 'Cameron265', 236, 269);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (146, 'Donald866', 23, 264);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (147, 'Doug995', 32, 306);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (148, 'Freddie872', 351, 194);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (149, 'Molly305', 56, 63);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (150, 'Humberto161', 308, 389);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (151, 'Geoff911', 30, 382);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (152, 'Vin606', 36, 364);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (153, 'Brent918', 75, 226);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (154, 'Junior67', 78, 157);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (155, 'Trick784', 243, 339);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (156, 'Hank637', 273, 7);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (157, 'Vincent349', 179, 347);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (158, 'Kathy958', 378, 265);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (159, 'Corey930', 99, 73);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (160, 'Salma590', 11, 323);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (161, 'Dan471', 303, 275);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (162, 'Maxine448', 325, 168);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (163, 'Lupe762', 11, 26);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (164, 'Lari297', 204, 161);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (165, 'Demi717', 311, 292);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (166, 'Lara319', 182, 247);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (167, 'Eric720', 58, 164);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (168, 'Michael730', 92, 181);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (169, 'Claude24', 268, 92);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (170, 'Judge468', 33, 386);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (171, 'Colm219', 260, 153);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (172, 'Lindsey940', 270, 235);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (173, 'Armand764', 314, 151);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (174, 'Laurie836', 55, 151);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (175, 'Danny577', 51, 326);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (176, 'Buffy996', 169, 342);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (177, 'Vern688', 144, 306);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (178, 'Roddy352', 398, 157);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (179, 'Jack959', 152, 268);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (180, 'Miki920', 327, 63);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (181, 'Devon860', 79, 332);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (182, 'Kurt866', 260, 251);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (183, 'Dermot312', 52, 183);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (184, 'Hope625', 266, 270);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (185, 'Nicole593', 140, 109);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (186, 'Gilbert89', 154, 81);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (187, 'Michelle303', 277, 272);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (188, 'Jimmie854', 364, 134);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (189, 'Richie391', 327, 203);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (190, 'Jeff531', 193, 76);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (191, 'Hal254', 268, 113);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (192, 'Carole118', 136, 84);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (193, 'Raul883', 94, 42);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (194, 'Petula436', 359, 16);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (195, 'Aida86', 255, 25);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (196, 'Anthony629', 100, 394);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (197, 'Terri762', 216, 85);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (198, 'Christina721', 381, 11);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (199, 'Ewan247', 335, 53);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (200, 'Helen242', 63, 156);
commit;
prompt 200 records committed...
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (201, 'Nils719', 276, 6);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (202, 'Ming-Na913', 9, 274);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (203, 'Ed660', 341, 139);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (204, 'Aidan393', 185, 248);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (205, 'Allan388', 130, 58);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (206, 'Linda89', 84, 99);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (207, 'Jack650', 123, 295);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (208, 'Nicholas32', 64, 318);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (209, 'Etta275', 188, 57);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (210, 'Moe809', 25, 28);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (211, 'Thin891', 218, 385);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (212, 'Geoff563', 202, 153);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (213, 'Olga704', 86, 354);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (214, 'Jon56', 90, 36);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (215, 'Rosario338', 130, 290);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (216, 'Ashton785', 286, 257);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (217, 'Johnny744', 162, 10);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (218, 'Frank174', 63, 101);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (219, 'Colm164', 201, 91);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (220, 'Julianne822', 262, 26);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (221, 'Rosco158', 132, 167);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (222, 'Marisa806', 319, 377);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (223, 'Gavin701', 288, 241);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (224, 'Tal66', 208, 317);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (225, 'Isaac332', 162, 231);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (226, 'Arturo829', 110, 176);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (227, 'Vin375', 38, 140);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (228, 'Horace114', 211, 36);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (229, 'Glenn216', 347, 43);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (230, 'Pablo292', 226, 135);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (231, 'Jeanne645', 359, 309);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (232, 'Busta705', 240, 298);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (233, 'Judge261', 184, 49);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (234, 'Gran356', 84, 393);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (235, 'Seth939', 105, 171);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (236, 'Ivan654', 25, 212);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (237, 'Kimberly357', 44, 284);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (238, 'Juan229', 392, 373);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (239, 'Glenn592', 338, 214);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (240, 'Ann797', 124, 254);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (241, 'Edward770', 252, 143);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (242, 'Marisa105', 233, 147);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (243, 'Colin785', 212, 179);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (244, 'Grace920', 208, 39);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (245, 'Ralph79', 162, 152);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (246, 'Judy99', 133, 216);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (247, 'Willie480', 48, 28);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (248, 'Judy704', 131, 98);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (249, 'Kurt113', 27, 151);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (250, 'Clarence190', 338, 87);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (251, 'Udo359', 1, 117);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (252, 'Kenny656', 201, 55);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (253, 'Nigel891', 76, 262);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (254, 'Gailard152', 293, 43);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (255, 'Vivica762', 344, 180);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (256, 'Nathan53', 264, 397);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (257, 'Dylan559', 393, 267);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (258, 'Gates494', 111, 122);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (259, 'Sophie622', 141, 293);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (260, 'Mae872', 372, 257);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (261, 'Claude323', 389, 186);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (262, 'Kenny400', 51, 289);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (263, 'Maggie405', 316, 257);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (264, 'Hal735', 260, 378);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (265, 'Maura392', 275, 44);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (266, 'George662', 393, 215);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (267, 'Herbie49', 336, 171);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (268, 'Robin842', 22, 99);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (269, 'Dabney915', 139, 53);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (270, 'Laurie622', 114, 247);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (271, 'Thin895', 81, 203);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (272, 'Millie909', 384, 321);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (273, 'Andre915', 222, 384);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (274, 'Isabella106', 360, 386);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (275, 'Lydia633', 121, 371);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (276, 'Rachael108', 182, 89);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (277, 'Amanda227', 391, 147);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (278, 'Scott364', 322, 64);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (279, 'Melba232', 389, 315);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (280, 'Curt1000', 234, 362);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (281, 'Anthony442', 17, 354);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (282, 'Nicky4', 315, 312);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (283, 'Gerald882', 60, 272);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (284, 'Laura476', 16, 192);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (285, 'Boyd834', 244, 109);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (286, 'Rosario935', 48, 343);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (287, 'Courtney930', 221, 50);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (288, 'Amanda695', 337, 96);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (289, 'Jose306', 273, 371);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (290, 'Geoff299', 97, 124);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (291, 'Cesar818', 150, 6);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (292, 'Nicky18', 18, 230);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (293, 'Andrew324', 28, 137);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (294, 'Rhys412', 190, 148);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (295, 'Nik21', 388, 18);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (296, 'Ming-Na950', 156, 170);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (297, 'Fisher854', 36, 211);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (298, 'Hal700', 272, 12);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (299, 'Denzel982', 219, 62);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (300, 'Delroy73', 12, 281);
commit;
prompt 300 records committed...
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (301, 'Nicolas303', 102, 184);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (302, 'April636', 384, 192);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (303, 'Alicia52', 336, 385);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (304, 'Boz986', 79, 292);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (305, 'Pamela450', 381, 205);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (306, 'Rosco681', 139, 219);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (307, 'Leo426', 326, 85);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (308, 'Lesley243', 356, 277);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (309, 'Charlton392', 59, 359);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (310, 'Saul215', 194, 51);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (311, 'Mira84', 139, 78);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (312, 'Nora288', 230, 24);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (313, 'Christine473', 18, 42);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (314, 'Molly482', 129, 247);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (315, 'Percy723', 362, 79);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (316, 'Mae397', 340, 11);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (317, 'Marty227', 321, 131);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (318, 'Horace522', 316, 151);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (319, 'Swoosie697', 102, 374);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (320, 'Jann610', 63, 383);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (321, 'Cyndi316', 84, 364);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (322, 'Sarah110', 203, 55);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (323, 'Charlize957', 49, 1);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (324, 'Nikki671', 181, 327);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (325, 'Lois462', 145, 318);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (326, 'Rowan695', 178, 181);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (327, 'Melba984', 362, 112);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (328, 'Lance967', 361, 245);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (329, 'Mia390', 149, 374);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (330, 'Demi336', 253, 55);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (331, 'Robbie729', 139, 164);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (332, 'Nancy464', 229, 329);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (333, 'Mos763', 15, 301);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (334, 'Earl638', 336, 280);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (335, 'Lee553', 89, 83);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (336, 'Sally643', 43, 339);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (337, 'Kieran120', 214, 227);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (338, 'Mekhi696', 105, 316);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (339, 'John158', 15, 41);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (340, 'Rene442', 168, 176);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (341, 'Rene814', 48, 15);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (342, 'Petula22', 82, 248);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (343, 'Warren530', 282, 235);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (344, 'Lily188', 154, 55);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (345, 'Andie948', 313, 235);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (346, 'Shelby493', 312, 166);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (347, 'Lizzy875', 94, 258);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (348, 'Norm537', 209, 282);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (349, 'Vendetta314', 391, 348);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (350, 'Frankie281', 235, 337);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (351, 'Wally556', 172, 75);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (352, 'Isabella414', 273, 232);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (353, 'Lou331', 110, 70);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (354, 'Mickey795', 162, 186);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (355, 'Forest29', 223, 198);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (356, 'Mickey947', 297, 120);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (357, 'John979', 27, 350);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (358, 'Tanya617', 348, 61);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (359, 'Fiona786', 21, 262);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (360, 'Kasey403', 112, 373);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (361, 'Ronny741', 99, 354);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (362, 'Natalie437', 73, 216);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (363, 'Julio284', 78, 1);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (364, 'Darius133', 108, 216);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (365, 'Red537', 362, 26);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (366, 'Jim996', 305, 183);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (367, 'Isaac892', 322, 216);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (368, 'Jeremy500', 309, 234);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (369, 'Latin666', 6, 270);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (370, 'Martha18', 391, 149);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (371, 'Nora820', 370, 161);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (372, 'Jimmy824', 248, 155);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (373, 'Lisa736', 43, 331);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (374, 'Rosanne151', 320, 328);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (375, 'John61', 202, 110);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (376, 'Elle315', 40, 225);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (377, 'Rhys610', 388, 357);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (378, 'Anne902', 200, 338);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (379, 'Denise331', 39, 332);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (380, 'Taylor14', 256, 178);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (381, 'Pamela337', 139, 384);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (382, 'Salma579', 138, 175);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (383, 'Gene998', 215, 73);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (384, 'Kathy726', 205, 215);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (385, 'Rene93', 237, 108);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (386, 'Kelli221', 110, 389);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (387, 'Ahmad28', 255, 121);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (388, 'Lena963', 201, 379);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (389, 'Geena117', 156, 257);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (390, 'Ernie544', 237, 259);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (391, 'Loreena919', 348, 191);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (392, 'Bill876', 241, 329);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (393, 'Veruca649', 170, 372);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (394, 'Kitty872', 263, 367);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (395, 'Nigel638', 23, 293);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (396, 'Rosanna196', 282, 313);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (397, 'Merrill868', 31, 178);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (398, 'Suzi76', 226, 373);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (399, 'Juliana560', 22, 109);
insert into ROUTE (routeid, routename, startstationid, endstationid)
values (400, 'Jackie172', 114, 148);
commit;
prompt 400 records loaded
prompt Loading SCHEDULE...
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (1, 2, to_timestamp('21-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (2, 3, to_timestamp('21-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (3, 4, to_timestamp('21-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (4, 5, to_timestamp('21-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (5, 6, to_timestamp('21-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (6, 7, to_timestamp('21-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (7, 8, to_timestamp('21-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (8, 9, to_timestamp('21-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (9, 10, to_timestamp('21-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (10, 11, to_timestamp('21-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (11, 12, to_timestamp('21-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (12, 13, to_timestamp('21-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (13, 14, to_timestamp('21-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('21-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (14, 15, to_timestamp('21-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (15, 16, to_timestamp('21-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (16, 17, to_timestamp('22-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (17, 18, to_timestamp('22-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (18, 19, to_timestamp('22-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (19, 20, to_timestamp('22-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (20, 1, to_timestamp('22-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (21, 2, to_timestamp('22-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (22, 3, to_timestamp('22-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (23, 4, to_timestamp('22-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (24, 5, to_timestamp('22-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (25, 6, to_timestamp('22-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (26, 7, to_timestamp('22-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (27, 8, to_timestamp('22-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (28, 9, to_timestamp('22-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (29, 10, to_timestamp('22-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (30, 11, to_timestamp('22-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (31, 12, to_timestamp('22-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (32, 13, to_timestamp('22-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (33, 14, to_timestamp('22-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (34, 15, to_timestamp('22-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (35, 16, to_timestamp('22-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (36, 17, to_timestamp('22-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (37, 18, to_timestamp('22-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('22-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (38, 19, to_timestamp('22-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (39, 20, to_timestamp('22-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (40, 1, to_timestamp('23-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (41, 2, to_timestamp('23-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (42, 3, to_timestamp('23-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (43, 4, to_timestamp('23-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (44, 5, to_timestamp('23-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (45, 6, to_timestamp('23-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (46, 7, to_timestamp('23-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (47, 8, to_timestamp('23-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (48, 9, to_timestamp('23-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (49, 10, to_timestamp('23-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (50, 11, to_timestamp('23-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (51, 12, to_timestamp('23-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (52, 13, to_timestamp('23-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (53, 14, to_timestamp('23-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (54, 15, to_timestamp('23-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (55, 16, to_timestamp('23-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (56, 17, to_timestamp('23-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (57, 18, to_timestamp('23-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (58, 19, to_timestamp('23-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (59, 20, to_timestamp('23-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (60, 1, to_timestamp('23-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (61, 2, to_timestamp('23-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('23-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (62, 3, to_timestamp('23-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (63, 4, to_timestamp('23-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (64, 5, to_timestamp('24-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (65, 6, to_timestamp('24-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (66, 7, to_timestamp('24-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (67, 8, to_timestamp('24-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (68, 9, to_timestamp('24-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (69, 10, to_timestamp('24-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (70, 11, to_timestamp('24-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (71, 12, to_timestamp('24-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (72, 13, to_timestamp('24-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (73, 14, to_timestamp('24-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (74, 15, to_timestamp('24-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (75, 16, to_timestamp('24-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (76, 17, to_timestamp('24-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (77, 18, to_timestamp('24-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (78, 19, to_timestamp('24-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (79, 20, to_timestamp('24-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (80, 1, to_timestamp('24-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (81, 2, to_timestamp('24-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (82, 3, to_timestamp('24-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (83, 4, to_timestamp('24-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (84, 5, to_timestamp('24-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (85, 6, to_timestamp('24-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('24-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (86, 7, to_timestamp('24-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (87, 8, to_timestamp('24-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (88, 9, to_timestamp('25-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (89, 10, to_timestamp('25-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (90, 11, to_timestamp('25-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (91, 12, to_timestamp('25-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (92, 13, to_timestamp('25-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (93, 14, to_timestamp('25-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (94, 15, to_timestamp('25-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (95, 16, to_timestamp('25-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (96, 17, to_timestamp('25-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (97, 18, to_timestamp('25-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (98, 19, to_timestamp('25-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (99, 20, to_timestamp('25-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (100, 1, to_timestamp('25-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 100 records committed...
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (101, 2, to_timestamp('25-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (102, 3, to_timestamp('25-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (103, 4, to_timestamp('25-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (104, 5, to_timestamp('25-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (105, 6, to_timestamp('25-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (106, 7, to_timestamp('25-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (107, 8, to_timestamp('25-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (108, 9, to_timestamp('25-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (109, 10, to_timestamp('25-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (110, 11, to_timestamp('25-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (111, 12, to_timestamp('25-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (112, 13, to_timestamp('26-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (113, 14, to_timestamp('26-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (114, 15, to_timestamp('26-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (115, 16, to_timestamp('26-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (116, 17, to_timestamp('26-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (117, 18, to_timestamp('26-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (118, 19, to_timestamp('26-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (119, 20, to_timestamp('26-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (120, 1, to_timestamp('26-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (121, 2, to_timestamp('26-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (122, 3, to_timestamp('26-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (123, 4, to_timestamp('26-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (124, 5, to_timestamp('26-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (125, 6, to_timestamp('26-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (126, 7, to_timestamp('26-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (127, 8, to_timestamp('26-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (128, 9, to_timestamp('26-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (129, 10, to_timestamp('26-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (130, 11, to_timestamp('26-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (131, 12, to_timestamp('26-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (132, 13, to_timestamp('26-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (133, 14, to_timestamp('26-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('26-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (134, 15, to_timestamp('26-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (135, 16, to_timestamp('26-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (136, 17, to_timestamp('27-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (137, 18, to_timestamp('27-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (138, 19, to_timestamp('27-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (139, 20, to_timestamp('27-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (140, 1, to_timestamp('27-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (141, 2, to_timestamp('27-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (142, 3, to_timestamp('27-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (143, 4, to_timestamp('27-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (144, 5, to_timestamp('27-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (145, 6, to_timestamp('27-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (146, 7, to_timestamp('27-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (147, 8, to_timestamp('27-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (148, 9, to_timestamp('27-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (149, 10, to_timestamp('27-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (150, 11, to_timestamp('27-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (151, 12, to_timestamp('27-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (152, 13, to_timestamp('27-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (153, 14, to_timestamp('27-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (154, 15, to_timestamp('27-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (155, 16, to_timestamp('27-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (156, 17, to_timestamp('27-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (157, 18, to_timestamp('27-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('27-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (158, 19, to_timestamp('27-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (159, 20, to_timestamp('27-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (160, 1, to_timestamp('28-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (161, 2, to_timestamp('28-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (162, 3, to_timestamp('28-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (163, 4, to_timestamp('28-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (164, 5, to_timestamp('28-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (165, 6, to_timestamp('28-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (166, 7, to_timestamp('28-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (167, 8, to_timestamp('28-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (168, 9, to_timestamp('28-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (169, 10, to_timestamp('28-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (170, 11, to_timestamp('28-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (171, 12, to_timestamp('28-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (172, 13, to_timestamp('28-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (173, 14, to_timestamp('28-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (174, 15, to_timestamp('28-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (175, 16, to_timestamp('28-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (176, 17, to_timestamp('28-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (177, 18, to_timestamp('28-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (178, 19, to_timestamp('28-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (179, 20, to_timestamp('28-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (180, 1, to_timestamp('28-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (181, 2, to_timestamp('28-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('28-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (182, 3, to_timestamp('28-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (183, 4, to_timestamp('28-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (184, 5, to_timestamp('29-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (185, 6, to_timestamp('29-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (186, 7, to_timestamp('29-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (187, 8, to_timestamp('29-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (188, 9, to_timestamp('29-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (189, 10, to_timestamp('29-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (190, 11, to_timestamp('29-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (191, 12, to_timestamp('29-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (192, 13, to_timestamp('29-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (193, 14, to_timestamp('29-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (194, 15, to_timestamp('29-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (195, 16, to_timestamp('29-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (196, 17, to_timestamp('29-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (197, 18, to_timestamp('29-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (198, 19, to_timestamp('29-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (199, 20, to_timestamp('29-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (200, 1, to_timestamp('29-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 200 records committed...
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (201, 2, to_timestamp('29-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (202, 3, to_timestamp('29-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (203, 4, to_timestamp('29-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (204, 5, to_timestamp('29-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (205, 6, to_timestamp('29-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('29-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (206, 7, to_timestamp('29-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (207, 8, to_timestamp('29-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (208, 9, to_timestamp('30-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (209, 10, to_timestamp('30-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (210, 11, to_timestamp('30-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (211, 12, to_timestamp('30-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (212, 13, to_timestamp('30-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (213, 14, to_timestamp('30-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (214, 15, to_timestamp('30-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (215, 16, to_timestamp('30-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (216, 17, to_timestamp('30-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (217, 18, to_timestamp('30-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (218, 19, to_timestamp('30-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (219, 20, to_timestamp('30-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (220, 1, to_timestamp('30-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (221, 2, to_timestamp('30-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (222, 3, to_timestamp('30-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (223, 4, to_timestamp('30-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (224, 5, to_timestamp('30-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (225, 6, to_timestamp('30-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (226, 7, to_timestamp('30-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (227, 8, to_timestamp('30-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (228, 9, to_timestamp('30-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (229, 10, to_timestamp('30-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (230, 11, to_timestamp('30-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (231, 12, to_timestamp('30-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (232, 13, to_timestamp('31-05-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (233, 14, to_timestamp('31-05-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (234, 15, to_timestamp('31-05-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (235, 16, to_timestamp('31-05-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (236, 17, to_timestamp('31-05-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (237, 18, to_timestamp('31-05-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (238, 19, to_timestamp('31-05-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (239, 20, to_timestamp('31-05-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (240, 1, to_timestamp('31-05-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (241, 2, to_timestamp('31-05-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (242, 3, to_timestamp('31-05-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (243, 4, to_timestamp('31-05-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (244, 5, to_timestamp('31-05-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (245, 6, to_timestamp('31-05-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (246, 7, to_timestamp('31-05-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (247, 8, to_timestamp('31-05-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (248, 9, to_timestamp('31-05-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (249, 10, to_timestamp('31-05-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (250, 11, to_timestamp('31-05-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (251, 12, to_timestamp('31-05-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (252, 13, to_timestamp('31-05-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (253, 14, to_timestamp('31-05-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('31-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (254, 15, to_timestamp('31-05-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (255, 16, to_timestamp('31-05-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (256, 17, to_timestamp('01-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (257, 18, to_timestamp('01-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (258, 19, to_timestamp('01-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (259, 20, to_timestamp('01-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (260, 1, to_timestamp('01-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (261, 2, to_timestamp('01-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (262, 3, to_timestamp('01-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (263, 4, to_timestamp('01-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (264, 5, to_timestamp('01-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (265, 6, to_timestamp('01-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (266, 7, to_timestamp('01-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (267, 8, to_timestamp('01-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (268, 9, to_timestamp('01-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (269, 10, to_timestamp('01-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (270, 11, to_timestamp('01-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (271, 12, to_timestamp('01-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (272, 13, to_timestamp('01-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (273, 14, to_timestamp('01-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (274, 15, to_timestamp('01-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (275, 16, to_timestamp('01-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (276, 17, to_timestamp('01-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (277, 18, to_timestamp('01-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('01-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (278, 19, to_timestamp('01-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (279, 20, to_timestamp('01-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (280, 1, to_timestamp('02-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (281, 2, to_timestamp('02-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (282, 3, to_timestamp('02-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (283, 4, to_timestamp('02-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (284, 5, to_timestamp('02-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (285, 6, to_timestamp('02-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (286, 7, to_timestamp('02-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (287, 8, to_timestamp('02-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (288, 9, to_timestamp('02-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (289, 10, to_timestamp('02-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (290, 11, to_timestamp('02-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (291, 12, to_timestamp('02-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (292, 13, to_timestamp('02-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (293, 14, to_timestamp('02-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (294, 15, to_timestamp('02-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (295, 16, to_timestamp('02-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (296, 17, to_timestamp('02-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (297, 18, to_timestamp('02-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (298, 19, to_timestamp('02-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (299, 20, to_timestamp('02-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (300, 1, to_timestamp('02-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 300 records committed...
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (301, 2, to_timestamp('02-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (302, 3, to_timestamp('02-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (303, 4, to_timestamp('02-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (304, 5, to_timestamp('03-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (305, 6, to_timestamp('03-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (306, 7, to_timestamp('03-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (307, 8, to_timestamp('03-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (308, 9, to_timestamp('03-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (309, 10, to_timestamp('03-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (310, 11, to_timestamp('03-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (311, 12, to_timestamp('03-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (312, 13, to_timestamp('03-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (313, 14, to_timestamp('03-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (314, 15, to_timestamp('03-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (315, 16, to_timestamp('03-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (316, 17, to_timestamp('03-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (317, 18, to_timestamp('03-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (318, 19, to_timestamp('03-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (319, 20, to_timestamp('03-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (320, 1, to_timestamp('03-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (321, 2, to_timestamp('03-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (322, 3, to_timestamp('03-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (323, 4, to_timestamp('03-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (324, 5, to_timestamp('03-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (325, 6, to_timestamp('03-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (326, 7, to_timestamp('03-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (327, 8, to_timestamp('03-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (328, 9, to_timestamp('04-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (329, 10, to_timestamp('04-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (330, 11, to_timestamp('04-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (331, 12, to_timestamp('04-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (332, 13, to_timestamp('04-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (333, 14, to_timestamp('04-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (334, 15, to_timestamp('04-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (335, 16, to_timestamp('04-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (336, 17, to_timestamp('04-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (337, 18, to_timestamp('04-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (338, 19, to_timestamp('04-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (339, 20, to_timestamp('04-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (340, 1, to_timestamp('04-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (341, 2, to_timestamp('04-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (342, 3, to_timestamp('04-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (343, 4, to_timestamp('04-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (344, 5, to_timestamp('04-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (345, 6, to_timestamp('04-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (346, 7, to_timestamp('04-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (347, 8, to_timestamp('04-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (348, 9, to_timestamp('04-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (349, 10, to_timestamp('04-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('04-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (350, 11, to_timestamp('04-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (351, 12, to_timestamp('04-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (352, 13, to_timestamp('05-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (353, 14, to_timestamp('05-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (354, 15, to_timestamp('05-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (355, 16, to_timestamp('05-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (356, 17, to_timestamp('05-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (357, 18, to_timestamp('05-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (358, 19, to_timestamp('05-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (359, 20, to_timestamp('05-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (360, 1, to_timestamp('05-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (361, 2, to_timestamp('05-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (362, 3, to_timestamp('05-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (363, 4, to_timestamp('05-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (364, 5, to_timestamp('05-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (365, 6, to_timestamp('05-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (366, 7, to_timestamp('05-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (367, 8, to_timestamp('05-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (368, 9, to_timestamp('05-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (369, 10, to_timestamp('05-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (370, 11, to_timestamp('05-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (371, 12, to_timestamp('05-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (372, 13, to_timestamp('05-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (373, 14, to_timestamp('05-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('05-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (374, 15, to_timestamp('05-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (375, 16, to_timestamp('05-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (376, 17, to_timestamp('06-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (377, 18, to_timestamp('06-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (378, 19, to_timestamp('06-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (379, 20, to_timestamp('06-06-2024 03:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (380, 1, to_timestamp('06-06-2024 04:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (381, 2, to_timestamp('06-06-2024 05:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (382, 3, to_timestamp('06-06-2024 06:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (383, 4, to_timestamp('06-06-2024 07:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (384, 5, to_timestamp('06-06-2024 08:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (385, 6, to_timestamp('06-06-2024 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (386, 7, to_timestamp('06-06-2024 10:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (387, 8, to_timestamp('06-06-2024 11:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (388, 9, to_timestamp('06-06-2024 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (389, 10, to_timestamp('06-06-2024 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (390, 11, to_timestamp('06-06-2024 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (391, 12, to_timestamp('06-06-2024 15:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (392, 13, to_timestamp('06-06-2024 16:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (393, 14, to_timestamp('06-06-2024 17:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (394, 15, to_timestamp('06-06-2024 18:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (395, 16, to_timestamp('06-06-2024 19:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (396, 17, to_timestamp('06-06-2024 20:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (397, 18, to_timestamp('06-06-2024 21:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('06-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (398, 19, to_timestamp('06-06-2024 22:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('07-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (399, 20, to_timestamp('06-06-2024 23:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('07-06-2024 01:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SCHEDULE (scheduleid, routeid, departuretime, arrivaltime)
values (400, 1, to_timestamp('07-06-2024 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('07-06-2024 02:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 400 records loaded
prompt Loading TRIP...
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (1, 1, 1, to_date('17-08-2022', 'dd-mm-yyyy'), 1);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (2, 2, 2, to_date('06-12-2019', 'dd-mm-yyyy'), 2);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (3, 3, 3, to_date('13-11-2003', 'dd-mm-yyyy'), 3);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (4, 4, 4, to_date('01-06-2010', 'dd-mm-yyyy'), 4);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (5, 5, 5, to_date('25-10-2013', 'dd-mm-yyyy'), 5);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (6, 6, 6, to_date('01-01-2013', 'dd-mm-yyyy'), 6);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (7, 7, 7, to_date('20-01-2020', 'dd-mm-yyyy'), 7);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (8, 8, 8, to_date('11-03-2023', 'dd-mm-yyyy'), 8);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (9, 9, 9, to_date('06-06-2017', 'dd-mm-yyyy'), 9);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (10, 10, 10, to_date('25-07-2010', 'dd-mm-yyyy'), 10);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (11, 11, 11, to_date('15-05-2011', 'dd-mm-yyyy'), 11);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (12, 12, 12, to_date('04-12-2021', 'dd-mm-yyyy'), 12);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (13, 13, 13, to_date('10-09-2014', 'dd-mm-yyyy'), 13);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (14, 14, 14, to_date('10-10-2012', 'dd-mm-yyyy'), 14);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (15, 15, 15, to_date('10-07-2003', 'dd-mm-yyyy'), 15);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (16, 16, 16, to_date('20-01-2012', 'dd-mm-yyyy'), 16);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (17, 17, 17, to_date('19-08-2005', 'dd-mm-yyyy'), 17);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (18, 18, 18, to_date('29-06-2010', 'dd-mm-yyyy'), 18);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (19, 19, 19, to_date('25-09-2008', 'dd-mm-yyyy'), 19);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (20, 20, 20, to_date('21-12-2008', 'dd-mm-yyyy'), 20);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (21, 21, 21, to_date('22-03-2009', 'dd-mm-yyyy'), 21);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (22, 22, 22, to_date('27-12-2022', 'dd-mm-yyyy'), 22);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (23, 23, 23, to_date('15-01-2004', 'dd-mm-yyyy'), 23);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (24, 24, 24, to_date('07-09-2021', 'dd-mm-yyyy'), 24);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (25, 25, 25, to_date('24-03-2002', 'dd-mm-yyyy'), 25);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (26, 26, 26, to_date('06-06-2005', 'dd-mm-yyyy'), 26);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (27, 27, 27, to_date('11-04-2006', 'dd-mm-yyyy'), 27);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (28, 28, 28, to_date('15-12-2013', 'dd-mm-yyyy'), 28);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (29, 29, 29, to_date('19-08-2009', 'dd-mm-yyyy'), 29);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (30, 30, 30, to_date('03-01-2008', 'dd-mm-yyyy'), 30);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (31, 31, 31, to_date('09-05-2019', 'dd-mm-yyyy'), 31);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (32, 32, 32, to_date('17-08-2018', 'dd-mm-yyyy'), 32);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (33, 33, 33, to_date('30-10-2014', 'dd-mm-yyyy'), 33);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (34, 34, 34, to_date('03-02-2006', 'dd-mm-yyyy'), 34);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (35, 35, 35, to_date('21-09-2008', 'dd-mm-yyyy'), 35);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (36, 36, 36, to_date('03-04-2014', 'dd-mm-yyyy'), 36);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (37, 37, 37, to_date('06-06-2023', 'dd-mm-yyyy'), 37);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (38, 38, 38, to_date('28-05-2014', 'dd-mm-yyyy'), 38);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (39, 39, 39, to_date('13-09-2019', 'dd-mm-yyyy'), 39);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (40, 40, 40, to_date('19-09-2014', 'dd-mm-yyyy'), 40);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (41, 41, 41, to_date('09-12-2003', 'dd-mm-yyyy'), 41);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (42, 42, 42, to_date('23-06-2003', 'dd-mm-yyyy'), 42);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (43, 43, 43, to_date('29-07-2011', 'dd-mm-yyyy'), 43);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (44, 44, 44, to_date('17-12-2013', 'dd-mm-yyyy'), 44);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (45, 45, 45, to_date('29-01-2006', 'dd-mm-yyyy'), 45);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (46, 46, 46, to_date('12-06-2022', 'dd-mm-yyyy'), 46);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (47, 47, 47, to_date('02-02-2019', 'dd-mm-yyyy'), 47);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (48, 48, 48, to_date('10-07-2005', 'dd-mm-yyyy'), 48);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (49, 49, 49, to_date('23-01-2015', 'dd-mm-yyyy'), 49);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (50, 50, 50, to_date('01-07-2013', 'dd-mm-yyyy'), 50);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (51, 51, 51, to_date('27-04-2004', 'dd-mm-yyyy'), 51);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (52, 52, 52, to_date('02-01-2016', 'dd-mm-yyyy'), 52);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (53, 53, 53, to_date('27-07-2007', 'dd-mm-yyyy'), 53);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (54, 54, 54, to_date('25-11-2018', 'dd-mm-yyyy'), 54);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (55, 55, 55, to_date('15-06-2021', 'dd-mm-yyyy'), 55);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (56, 56, 56, to_date('20-02-2009', 'dd-mm-yyyy'), 56);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (57, 57, 57, to_date('21-09-2020', 'dd-mm-yyyy'), 57);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (58, 58, 58, to_date('08-01-2013', 'dd-mm-yyyy'), 58);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (59, 59, 59, to_date('17-07-2002', 'dd-mm-yyyy'), 59);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (60, 60, 60, to_date('17-08-2006', 'dd-mm-yyyy'), 60);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (61, 61, 61, to_date('10-11-2006', 'dd-mm-yyyy'), 61);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (62, 62, 62, to_date('04-04-2005', 'dd-mm-yyyy'), 62);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (63, 63, 63, to_date('13-09-2017', 'dd-mm-yyyy'), 63);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (64, 64, 64, to_date('12-05-2007', 'dd-mm-yyyy'), 64);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (65, 65, 65, to_date('03-05-2022', 'dd-mm-yyyy'), 65);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (66, 66, 66, to_date('31-03-2009', 'dd-mm-yyyy'), 66);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (67, 67, 67, to_date('16-11-2020', 'dd-mm-yyyy'), 67);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (68, 68, 68, to_date('02-04-2018', 'dd-mm-yyyy'), 68);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (69, 69, 69, to_date('13-03-2006', 'dd-mm-yyyy'), 69);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (70, 70, 70, to_date('23-04-2007', 'dd-mm-yyyy'), 70);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (71, 71, 71, to_date('09-08-2011', 'dd-mm-yyyy'), 71);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (72, 72, 72, to_date('30-03-2009', 'dd-mm-yyyy'), 72);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (73, 73, 73, to_date('17-12-2015', 'dd-mm-yyyy'), 73);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (74, 74, 74, to_date('24-06-2022', 'dd-mm-yyyy'), 74);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (75, 75, 75, to_date('16-11-2008', 'dd-mm-yyyy'), 75);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (76, 76, 76, to_date('24-09-2006', 'dd-mm-yyyy'), 76);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (77, 77, 77, to_date('20-04-2011', 'dd-mm-yyyy'), 77);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (78, 78, 78, to_date('05-02-2020', 'dd-mm-yyyy'), 78);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (79, 79, 79, to_date('09-08-2008', 'dd-mm-yyyy'), 79);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (80, 80, 80, to_date('06-01-2017', 'dd-mm-yyyy'), 80);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (81, 81, 81, to_date('05-12-2019', 'dd-mm-yyyy'), 81);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (82, 82, 82, to_date('11-04-2004', 'dd-mm-yyyy'), 82);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (83, 83, 83, to_date('22-09-2013', 'dd-mm-yyyy'), 83);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (84, 84, 84, to_date('10-12-2004', 'dd-mm-yyyy'), 84);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (85, 85, 85, to_date('08-06-2007', 'dd-mm-yyyy'), 85);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (86, 86, 86, to_date('04-04-2020', 'dd-mm-yyyy'), 86);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (87, 87, 87, to_date('20-06-2011', 'dd-mm-yyyy'), 87);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (88, 88, 88, to_date('24-05-2004', 'dd-mm-yyyy'), 88);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (89, 89, 89, to_date('12-05-2010', 'dd-mm-yyyy'), 89);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (90, 90, 90, to_date('18-12-2020', 'dd-mm-yyyy'), 90);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (91, 91, 91, to_date('31-10-2019', 'dd-mm-yyyy'), 91);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (92, 92, 92, to_date('15-10-2002', 'dd-mm-yyyy'), 92);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (93, 93, 93, to_date('06-05-2019', 'dd-mm-yyyy'), 93);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (94, 94, 94, to_date('23-09-2001', 'dd-mm-yyyy'), 94);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (95, 95, 95, to_date('20-10-2022', 'dd-mm-yyyy'), 95);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (96, 96, 96, to_date('30-03-2017', 'dd-mm-yyyy'), 96);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (97, 97, 97, to_date('12-07-2006', 'dd-mm-yyyy'), 97);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (98, 98, 98, to_date('16-07-2020', 'dd-mm-yyyy'), 98);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (99, 99, 99, to_date('23-04-2015', 'dd-mm-yyyy'), 99);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (100, 100, 100, to_date('22-07-2015', 'dd-mm-yyyy'), 100);
commit;
prompt 100 records committed...
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (101, 101, 101, to_date('30-01-2013', 'dd-mm-yyyy'), 101);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (102, 102, 102, to_date('23-10-2012', 'dd-mm-yyyy'), 102);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (103, 103, 103, to_date('30-06-2010', 'dd-mm-yyyy'), 103);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (104, 104, 104, to_date('23-08-2022', 'dd-mm-yyyy'), 104);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (105, 105, 105, to_date('11-02-2020', 'dd-mm-yyyy'), 105);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (106, 106, 106, to_date('06-12-2018', 'dd-mm-yyyy'), 106);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (107, 107, 107, to_date('25-04-2021', 'dd-mm-yyyy'), 107);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (108, 108, 108, to_date('27-08-2010', 'dd-mm-yyyy'), 108);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (109, 109, 109, to_date('09-09-2013', 'dd-mm-yyyy'), 109);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (110, 110, 110, to_date('28-08-2018', 'dd-mm-yyyy'), 110);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (111, 111, 111, to_date('25-12-2011', 'dd-mm-yyyy'), 111);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (112, 112, 112, to_date('21-04-2012', 'dd-mm-yyyy'), 112);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (113, 113, 113, to_date('06-05-2022', 'dd-mm-yyyy'), 113);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (114, 114, 114, to_date('24-08-2023', 'dd-mm-yyyy'), 114);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (115, 115, 115, to_date('17-04-2018', 'dd-mm-yyyy'), 115);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (116, 116, 116, to_date('24-09-2022', 'dd-mm-yyyy'), 116);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (117, 117, 117, to_date('05-10-2020', 'dd-mm-yyyy'), 117);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (118, 118, 118, to_date('29-01-2007', 'dd-mm-yyyy'), 118);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (119, 119, 119, to_date('30-05-2003', 'dd-mm-yyyy'), 119);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (120, 120, 120, to_date('15-05-2008', 'dd-mm-yyyy'), 120);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (121, 121, 121, to_date('28-12-2016', 'dd-mm-yyyy'), 121);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (122, 122, 122, to_date('15-10-2002', 'dd-mm-yyyy'), 122);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (123, 123, 123, to_date('16-01-2011', 'dd-mm-yyyy'), 123);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (124, 124, 124, to_date('27-02-2017', 'dd-mm-yyyy'), 124);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (125, 125, 125, to_date('27-11-2007', 'dd-mm-yyyy'), 125);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (126, 126, 126, to_date('06-10-2007', 'dd-mm-yyyy'), 126);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (127, 127, 127, to_date('01-09-2017', 'dd-mm-yyyy'), 127);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (128, 128, 128, to_date('05-08-2015', 'dd-mm-yyyy'), 128);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (129, 129, 129, to_date('01-04-2021', 'dd-mm-yyyy'), 129);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (130, 130, 130, to_date('18-06-2009', 'dd-mm-yyyy'), 130);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (131, 131, 131, to_date('17-09-2012', 'dd-mm-yyyy'), 131);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (132, 132, 132, to_date('25-11-2007', 'dd-mm-yyyy'), 132);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (133, 133, 133, to_date('10-01-2006', 'dd-mm-yyyy'), 133);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (134, 134, 134, to_date('08-11-2002', 'dd-mm-yyyy'), 134);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (135, 135, 135, to_date('25-04-2005', 'dd-mm-yyyy'), 135);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (136, 136, 136, to_date('22-11-2007', 'dd-mm-yyyy'), 136);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (137, 137, 137, to_date('27-06-2020', 'dd-mm-yyyy'), 137);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (138, 138, 138, to_date('13-07-2021', 'dd-mm-yyyy'), 138);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (139, 139, 139, to_date('22-08-2013', 'dd-mm-yyyy'), 139);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (140, 140, 140, to_date('27-09-2011', 'dd-mm-yyyy'), 140);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (141, 141, 141, to_date('22-07-2006', 'dd-mm-yyyy'), 141);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (142, 142, 142, to_date('26-11-2014', 'dd-mm-yyyy'), 142);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (143, 143, 143, to_date('03-05-2010', 'dd-mm-yyyy'), 143);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (144, 144, 144, to_date('05-04-2015', 'dd-mm-yyyy'), 144);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (145, 145, 145, to_date('22-11-2006', 'dd-mm-yyyy'), 145);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (146, 146, 146, to_date('07-10-2002', 'dd-mm-yyyy'), 146);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (147, 147, 147, to_date('29-01-2023', 'dd-mm-yyyy'), 147);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (148, 148, 148, to_date('25-11-2014', 'dd-mm-yyyy'), 148);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (149, 149, 149, to_date('26-06-2014', 'dd-mm-yyyy'), 149);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (150, 150, 150, to_date('22-03-2020', 'dd-mm-yyyy'), 150);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (151, 151, 151, to_date('31-10-2022', 'dd-mm-yyyy'), 151);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (152, 152, 152, to_date('01-02-2003', 'dd-mm-yyyy'), 152);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (153, 153, 153, to_date('10-12-2013', 'dd-mm-yyyy'), 153);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (154, 154, 154, to_date('13-05-2009', 'dd-mm-yyyy'), 154);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (155, 155, 155, to_date('15-10-2007', 'dd-mm-yyyy'), 155);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (156, 156, 156, to_date('17-01-2018', 'dd-mm-yyyy'), 156);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (157, 157, 157, to_date('01-05-2009', 'dd-mm-yyyy'), 157);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (158, 158, 158, to_date('24-07-2017', 'dd-mm-yyyy'), 158);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (159, 159, 159, to_date('14-07-2014', 'dd-mm-yyyy'), 159);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (160, 160, 160, to_date('29-10-2005', 'dd-mm-yyyy'), 160);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (161, 161, 161, to_date('27-10-2014', 'dd-mm-yyyy'), 161);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (162, 162, 162, to_date('05-11-2011', 'dd-mm-yyyy'), 162);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (163, 163, 163, to_date('05-07-2013', 'dd-mm-yyyy'), 163);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (164, 164, 164, to_date('13-08-2005', 'dd-mm-yyyy'), 164);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (165, 165, 165, to_date('08-12-2011', 'dd-mm-yyyy'), 165);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (166, 166, 166, to_date('19-03-2010', 'dd-mm-yyyy'), 166);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (167, 167, 167, to_date('23-03-2003', 'dd-mm-yyyy'), 167);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (168, 168, 168, to_date('15-01-2009', 'dd-mm-yyyy'), 168);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (169, 169, 169, to_date('26-08-2014', 'dd-mm-yyyy'), 169);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (170, 170, 170, to_date('28-04-2004', 'dd-mm-yyyy'), 170);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (171, 171, 171, to_date('29-04-2007', 'dd-mm-yyyy'), 171);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (172, 172, 172, to_date('04-08-2015', 'dd-mm-yyyy'), 172);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (173, 173, 173, to_date('03-03-2015', 'dd-mm-yyyy'), 173);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (174, 174, 174, to_date('16-06-2011', 'dd-mm-yyyy'), 174);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (175, 175, 175, to_date('05-01-2014', 'dd-mm-yyyy'), 175);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (176, 176, 176, to_date('01-11-2019', 'dd-mm-yyyy'), 176);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (177, 177, 177, to_date('15-08-2006', 'dd-mm-yyyy'), 177);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (178, 178, 178, to_date('21-02-2005', 'dd-mm-yyyy'), 178);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (179, 179, 179, to_date('09-11-2012', 'dd-mm-yyyy'), 179);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (180, 180, 180, to_date('01-08-2023', 'dd-mm-yyyy'), 180);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (181, 181, 181, to_date('26-06-2020', 'dd-mm-yyyy'), 181);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (182, 182, 182, to_date('25-05-2007', 'dd-mm-yyyy'), 182);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (183, 183, 183, to_date('06-07-2003', 'dd-mm-yyyy'), 183);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (184, 184, 184, to_date('25-08-2017', 'dd-mm-yyyy'), 184);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (185, 185, 185, to_date('03-01-2012', 'dd-mm-yyyy'), 185);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (186, 186, 186, to_date('27-11-2014', 'dd-mm-yyyy'), 186);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (187, 187, 187, to_date('23-05-2010', 'dd-mm-yyyy'), 187);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (188, 188, 188, to_date('08-05-2015', 'dd-mm-yyyy'), 188);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (189, 189, 189, to_date('19-05-2004', 'dd-mm-yyyy'), 189);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (190, 190, 190, to_date('02-03-2009', 'dd-mm-yyyy'), 190);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (191, 191, 191, to_date('06-11-2010', 'dd-mm-yyyy'), 191);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (192, 192, 192, to_date('12-06-2005', 'dd-mm-yyyy'), 192);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (193, 193, 193, to_date('10-01-2006', 'dd-mm-yyyy'), 193);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (194, 194, 194, to_date('13-11-2019', 'dd-mm-yyyy'), 194);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (195, 195, 195, to_date('31-10-2019', 'dd-mm-yyyy'), 195);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (196, 196, 196, to_date('19-08-2005', 'dd-mm-yyyy'), 196);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (197, 197, 197, to_date('06-09-2012', 'dd-mm-yyyy'), 197);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (198, 198, 198, to_date('09-07-2018', 'dd-mm-yyyy'), 198);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (199, 199, 199, to_date('09-08-2007', 'dd-mm-yyyy'), 199);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (200, 200, 200, to_date('02-04-2007', 'dd-mm-yyyy'), 200);
commit;
prompt 200 records committed...
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (201, 201, 201, to_date('15-08-2015', 'dd-mm-yyyy'), 201);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (202, 202, 202, to_date('11-09-2018', 'dd-mm-yyyy'), 202);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (203, 203, 203, to_date('21-07-2014', 'dd-mm-yyyy'), 203);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (204, 204, 204, to_date('29-05-2003', 'dd-mm-yyyy'), 204);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (205, 205, 205, to_date('09-10-2008', 'dd-mm-yyyy'), 205);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (206, 206, 206, to_date('08-10-2016', 'dd-mm-yyyy'), 206);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (207, 207, 207, to_date('28-07-2018', 'dd-mm-yyyy'), 207);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (208, 208, 208, to_date('01-02-2012', 'dd-mm-yyyy'), 208);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (209, 209, 209, to_date('20-01-2015', 'dd-mm-yyyy'), 209);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (210, 210, 210, to_date('17-08-2006', 'dd-mm-yyyy'), 210);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (211, 211, 211, to_date('14-02-2018', 'dd-mm-yyyy'), 211);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (212, 212, 212, to_date('02-07-2011', 'dd-mm-yyyy'), 212);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (213, 213, 213, to_date('19-08-2003', 'dd-mm-yyyy'), 213);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (214, 214, 214, to_date('21-02-2021', 'dd-mm-yyyy'), 214);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (215, 215, 215, to_date('07-06-2007', 'dd-mm-yyyy'), 215);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (216, 216, 216, to_date('05-04-2018', 'dd-mm-yyyy'), 216);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (217, 217, 217, to_date('12-06-2015', 'dd-mm-yyyy'), 217);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (218, 218, 218, to_date('23-12-2004', 'dd-mm-yyyy'), 218);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (219, 219, 219, to_date('28-11-2009', 'dd-mm-yyyy'), 219);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (220, 220, 220, to_date('25-07-2016', 'dd-mm-yyyy'), 220);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (221, 221, 221, to_date('12-10-2005', 'dd-mm-yyyy'), 221);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (222, 222, 222, to_date('17-06-2010', 'dd-mm-yyyy'), 222);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (223, 223, 223, to_date('14-04-2011', 'dd-mm-yyyy'), 223);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (224, 224, 224, to_date('20-01-2002', 'dd-mm-yyyy'), 224);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (225, 225, 225, to_date('14-02-2018', 'dd-mm-yyyy'), 225);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (226, 226, 226, to_date('18-01-2004', 'dd-mm-yyyy'), 226);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (227, 227, 227, to_date('13-07-2013', 'dd-mm-yyyy'), 227);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (228, 228, 228, to_date('18-06-2013', 'dd-mm-yyyy'), 228);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (229, 229, 229, to_date('12-02-2011', 'dd-mm-yyyy'), 229);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (230, 230, 230, to_date('30-03-2006', 'dd-mm-yyyy'), 230);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (231, 231, 231, to_date('21-01-2018', 'dd-mm-yyyy'), 231);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (232, 232, 232, to_date('09-10-2008', 'dd-mm-yyyy'), 232);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (233, 233, 233, to_date('24-11-2007', 'dd-mm-yyyy'), 233);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (234, 234, 234, to_date('18-05-2017', 'dd-mm-yyyy'), 234);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (235, 235, 235, to_date('26-03-2016', 'dd-mm-yyyy'), 235);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (236, 236, 236, to_date('25-12-2019', 'dd-mm-yyyy'), 236);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (237, 237, 237, to_date('31-07-2010', 'dd-mm-yyyy'), 237);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (238, 238, 238, to_date('28-02-2023', 'dd-mm-yyyy'), 238);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (239, 239, 239, to_date('17-10-2004', 'dd-mm-yyyy'), 239);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (240, 240, 240, to_date('28-02-2014', 'dd-mm-yyyy'), 240);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (241, 241, 241, to_date('06-03-2008', 'dd-mm-yyyy'), 241);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (242, 242, 242, to_date('29-05-2005', 'dd-mm-yyyy'), 242);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (243, 243, 243, to_date('02-02-2005', 'dd-mm-yyyy'), 243);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (244, 244, 244, to_date('18-12-2015', 'dd-mm-yyyy'), 244);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (245, 245, 245, to_date('28-09-2015', 'dd-mm-yyyy'), 245);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (246, 246, 246, to_date('09-11-2020', 'dd-mm-yyyy'), 246);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (247, 247, 247, to_date('22-10-2004', 'dd-mm-yyyy'), 247);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (248, 248, 248, to_date('19-03-2018', 'dd-mm-yyyy'), 248);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (249, 249, 249, to_date('27-12-2021', 'dd-mm-yyyy'), 249);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (250, 250, 250, to_date('24-06-2020', 'dd-mm-yyyy'), 250);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (251, 251, 251, to_date('07-02-2010', 'dd-mm-yyyy'), 251);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (252, 252, 252, to_date('13-10-2004', 'dd-mm-yyyy'), 252);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (253, 253, 253, to_date('24-03-2014', 'dd-mm-yyyy'), 253);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (254, 254, 254, to_date('03-03-2011', 'dd-mm-yyyy'), 254);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (255, 255, 255, to_date('23-09-2005', 'dd-mm-yyyy'), 255);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (256, 256, 256, to_date('07-05-2019', 'dd-mm-yyyy'), 256);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (257, 257, 257, to_date('29-10-2012', 'dd-mm-yyyy'), 257);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (258, 258, 258, to_date('02-04-2023', 'dd-mm-yyyy'), 258);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (259, 259, 259, to_date('09-03-2022', 'dd-mm-yyyy'), 259);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (260, 260, 260, to_date('23-03-2021', 'dd-mm-yyyy'), 260);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (261, 261, 261, to_date('16-01-2009', 'dd-mm-yyyy'), 261);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (262, 262, 262, to_date('11-09-2012', 'dd-mm-yyyy'), 262);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (263, 263, 263, to_date('26-05-2008', 'dd-mm-yyyy'), 263);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (264, 264, 264, to_date('12-12-2022', 'dd-mm-yyyy'), 264);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (265, 265, 265, to_date('12-06-2013', 'dd-mm-yyyy'), 265);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (266, 266, 266, to_date('13-06-2008', 'dd-mm-yyyy'), 266);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (267, 267, 267, to_date('01-01-2006', 'dd-mm-yyyy'), 267);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (268, 268, 268, to_date('13-09-2019', 'dd-mm-yyyy'), 268);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (269, 269, 269, to_date('08-10-2009', 'dd-mm-yyyy'), 269);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (270, 270, 270, to_date('09-10-2006', 'dd-mm-yyyy'), 270);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (271, 271, 271, to_date('03-09-2004', 'dd-mm-yyyy'), 271);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (272, 272, 272, to_date('21-04-2018', 'dd-mm-yyyy'), 272);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (273, 273, 273, to_date('14-06-2010', 'dd-mm-yyyy'), 273);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (274, 274, 274, to_date('08-01-2022', 'dd-mm-yyyy'), 274);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (275, 275, 275, to_date('09-09-2007', 'dd-mm-yyyy'), 275);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (276, 276, 276, to_date('19-11-2016', 'dd-mm-yyyy'), 276);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (277, 277, 277, to_date('15-08-2019', 'dd-mm-yyyy'), 277);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (278, 278, 278, to_date('10-10-2004', 'dd-mm-yyyy'), 278);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (279, 279, 279, to_date('25-01-2006', 'dd-mm-yyyy'), 279);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (280, 280, 280, to_date('27-11-2011', 'dd-mm-yyyy'), 280);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (281, 281, 281, to_date('02-11-2022', 'dd-mm-yyyy'), 281);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (282, 282, 282, to_date('30-08-2003', 'dd-mm-yyyy'), 282);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (283, 283, 283, to_date('18-06-2005', 'dd-mm-yyyy'), 283);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (284, 284, 284, to_date('08-09-2004', 'dd-mm-yyyy'), 284);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (285, 285, 285, to_date('20-05-2018', 'dd-mm-yyyy'), 285);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (286, 286, 286, to_date('13-11-2006', 'dd-mm-yyyy'), 286);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (287, 287, 287, to_date('16-04-2013', 'dd-mm-yyyy'), 287);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (288, 288, 288, to_date('10-02-2007', 'dd-mm-yyyy'), 288);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (289, 289, 289, to_date('03-05-2022', 'dd-mm-yyyy'), 289);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (290, 290, 290, to_date('08-09-2004', 'dd-mm-yyyy'), 290);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (291, 291, 291, to_date('30-01-2009', 'dd-mm-yyyy'), 291);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (292, 292, 292, to_date('15-08-2007', 'dd-mm-yyyy'), 292);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (293, 293, 293, to_date('02-04-2007', 'dd-mm-yyyy'), 293);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (294, 294, 294, to_date('14-01-2006', 'dd-mm-yyyy'), 294);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (295, 295, 295, to_date('03-09-2014', 'dd-mm-yyyy'), 295);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (296, 296, 296, to_date('19-03-2018', 'dd-mm-yyyy'), 296);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (297, 297, 297, to_date('13-09-2003', 'dd-mm-yyyy'), 297);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (298, 298, 298, to_date('30-04-2011', 'dd-mm-yyyy'), 298);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (299, 299, 299, to_date('12-03-2012', 'dd-mm-yyyy'), 299);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (300, 300, 300, to_date('17-07-2020', 'dd-mm-yyyy'), 300);
commit;
prompt 300 records committed...
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (301, 301, 301, to_date('28-06-2005', 'dd-mm-yyyy'), 301);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (302, 302, 302, to_date('06-08-2015', 'dd-mm-yyyy'), 302);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (303, 303, 303, to_date('08-06-2013', 'dd-mm-yyyy'), 303);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (304, 304, 304, to_date('06-11-2008', 'dd-mm-yyyy'), 304);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (305, 305, 305, to_date('20-10-2006', 'dd-mm-yyyy'), 305);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (306, 306, 306, to_date('10-05-2011', 'dd-mm-yyyy'), 306);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (307, 307, 307, to_date('28-07-2017', 'dd-mm-yyyy'), 307);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (308, 308, 308, to_date('08-10-2002', 'dd-mm-yyyy'), 308);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (309, 309, 309, to_date('10-01-2021', 'dd-mm-yyyy'), 309);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (310, 310, 310, to_date('23-12-2009', 'dd-mm-yyyy'), 310);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (311, 311, 311, to_date('07-11-2017', 'dd-mm-yyyy'), 311);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (312, 312, 312, to_date('24-10-2018', 'dd-mm-yyyy'), 312);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (313, 313, 313, to_date('29-08-2002', 'dd-mm-yyyy'), 313);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (314, 314, 314, to_date('10-02-2018', 'dd-mm-yyyy'), 314);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (315, 315, 315, to_date('13-03-2003', 'dd-mm-yyyy'), 315);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (316, 316, 316, to_date('20-07-2016', 'dd-mm-yyyy'), 316);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (317, 317, 317, to_date('19-11-2016', 'dd-mm-yyyy'), 317);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (318, 318, 318, to_date('18-12-2020', 'dd-mm-yyyy'), 318);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (319, 319, 319, to_date('17-04-2016', 'dd-mm-yyyy'), 319);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (320, 320, 320, to_date('25-03-2017', 'dd-mm-yyyy'), 320);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (321, 321, 321, to_date('23-04-2017', 'dd-mm-yyyy'), 321);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (322, 322, 322, to_date('28-11-2007', 'dd-mm-yyyy'), 322);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (323, 323, 323, to_date('25-03-2005', 'dd-mm-yyyy'), 323);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (324, 324, 324, to_date('15-12-2003', 'dd-mm-yyyy'), 324);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (325, 325, 325, to_date('26-06-2005', 'dd-mm-yyyy'), 325);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (326, 326, 326, to_date('08-04-2015', 'dd-mm-yyyy'), 326);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (327, 327, 327, to_date('16-02-2003', 'dd-mm-yyyy'), 327);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (328, 328, 328, to_date('05-02-2010', 'dd-mm-yyyy'), 328);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (329, 329, 329, to_date('24-07-2009', 'dd-mm-yyyy'), 329);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (330, 330, 330, to_date('09-10-2012', 'dd-mm-yyyy'), 330);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (331, 331, 331, to_date('18-11-2009', 'dd-mm-yyyy'), 331);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (332, 332, 332, to_date('01-02-2016', 'dd-mm-yyyy'), 332);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (333, 333, 333, to_date('10-11-2006', 'dd-mm-yyyy'), 333);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (334, 334, 334, to_date('22-06-2015', 'dd-mm-yyyy'), 334);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (335, 335, 335, to_date('05-07-2011', 'dd-mm-yyyy'), 335);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (336, 336, 336, to_date('23-03-2006', 'dd-mm-yyyy'), 336);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (337, 337, 337, to_date('13-08-2008', 'dd-mm-yyyy'), 337);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (338, 338, 338, to_date('15-08-2016', 'dd-mm-yyyy'), 338);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (339, 339, 339, to_date('09-02-2006', 'dd-mm-yyyy'), 339);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (340, 340, 340, to_date('17-09-2014', 'dd-mm-yyyy'), 340);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (341, 341, 341, to_date('15-09-2002', 'dd-mm-yyyy'), 341);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (342, 342, 342, to_date('21-05-2002', 'dd-mm-yyyy'), 342);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (343, 343, 343, to_date('12-01-2021', 'dd-mm-yyyy'), 343);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (344, 344, 344, to_date('08-07-2017', 'dd-mm-yyyy'), 344);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (345, 345, 345, to_date('04-08-2005', 'dd-mm-yyyy'), 345);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (346, 346, 346, to_date('08-10-2006', 'dd-mm-yyyy'), 346);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (347, 347, 347, to_date('22-03-2023', 'dd-mm-yyyy'), 347);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (348, 348, 348, to_date('31-03-2016', 'dd-mm-yyyy'), 348);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (349, 349, 349, to_date('01-05-2018', 'dd-mm-yyyy'), 349);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (350, 350, 350, to_date('22-09-2016', 'dd-mm-yyyy'), 350);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (351, 351, 351, to_date('14-04-2004', 'dd-mm-yyyy'), 351);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (352, 352, 352, to_date('05-09-2005', 'dd-mm-yyyy'), 352);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (353, 353, 353, to_date('15-11-2016', 'dd-mm-yyyy'), 353);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (354, 354, 354, to_date('21-10-2004', 'dd-mm-yyyy'), 354);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (355, 355, 355, to_date('12-05-2021', 'dd-mm-yyyy'), 355);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (356, 356, 356, to_date('12-02-2006', 'dd-mm-yyyy'), 356);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (357, 357, 357, to_date('20-06-2002', 'dd-mm-yyyy'), 357);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (358, 358, 358, to_date('25-03-2020', 'dd-mm-yyyy'), 358);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (359, 359, 359, to_date('30-03-2002', 'dd-mm-yyyy'), 359);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (360, 360, 360, to_date('24-03-2017', 'dd-mm-yyyy'), 360);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (361, 361, 361, to_date('27-05-2011', 'dd-mm-yyyy'), 361);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (362, 362, 362, to_date('23-11-2010', 'dd-mm-yyyy'), 362);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (363, 363, 363, to_date('05-11-2008', 'dd-mm-yyyy'), 363);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (364, 364, 364, to_date('28-06-2019', 'dd-mm-yyyy'), 364);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (365, 365, 365, to_date('18-12-2010', 'dd-mm-yyyy'), 365);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (366, 366, 366, to_date('30-01-2022', 'dd-mm-yyyy'), 366);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (367, 367, 367, to_date('19-07-2008', 'dd-mm-yyyy'), 367);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (368, 368, 368, to_date('13-12-2022', 'dd-mm-yyyy'), 368);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (369, 369, 369, to_date('07-10-2009', 'dd-mm-yyyy'), 369);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (370, 370, 370, to_date('26-05-2015', 'dd-mm-yyyy'), 370);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (371, 371, 371, to_date('20-05-2012', 'dd-mm-yyyy'), 371);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (372, 372, 372, to_date('27-05-2014', 'dd-mm-yyyy'), 372);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (373, 373, 373, to_date('08-05-2012', 'dd-mm-yyyy'), 373);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (374, 374, 374, to_date('06-10-2008', 'dd-mm-yyyy'), 374);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (375, 375, 375, to_date('10-09-2014', 'dd-mm-yyyy'), 375);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (376, 376, 376, to_date('09-09-2011', 'dd-mm-yyyy'), 376);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (377, 377, 377, to_date('29-03-2003', 'dd-mm-yyyy'), 377);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (378, 378, 378, to_date('28-11-2011', 'dd-mm-yyyy'), 378);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (379, 379, 379, to_date('09-03-2010', 'dd-mm-yyyy'), 379);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (380, 380, 380, to_date('28-03-2021', 'dd-mm-yyyy'), 380);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (381, 381, 381, to_date('17-04-2019', 'dd-mm-yyyy'), 381);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (382, 382, 382, to_date('04-04-2007', 'dd-mm-yyyy'), 382);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (383, 383, 383, to_date('11-01-2018', 'dd-mm-yyyy'), 383);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (384, 384, 384, to_date('11-07-2008', 'dd-mm-yyyy'), 384);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (385, 385, 385, to_date('18-08-2022', 'dd-mm-yyyy'), 385);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (386, 386, 386, to_date('16-08-2011', 'dd-mm-yyyy'), 386);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (387, 387, 387, to_date('04-12-2003', 'dd-mm-yyyy'), 387);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (388, 388, 388, to_date('06-08-2018', 'dd-mm-yyyy'), 388);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (389, 389, 389, to_date('18-11-2017', 'dd-mm-yyyy'), 389);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (390, 390, 390, to_date('13-08-2017', 'dd-mm-yyyy'), 390);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (391, 391, 391, to_date('16-09-2014', 'dd-mm-yyyy'), 391);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (392, 392, 392, to_date('26-04-2017', 'dd-mm-yyyy'), 392);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (393, 393, 393, to_date('23-01-2005', 'dd-mm-yyyy'), 393);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (394, 394, 394, to_date('22-02-2015', 'dd-mm-yyyy'), 394);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (395, 395, 395, to_date('03-08-2009', 'dd-mm-yyyy'), 395);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (396, 396, 396, to_date('09-07-2019', 'dd-mm-yyyy'), 396);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (397, 397, 397, to_date('09-11-2002', 'dd-mm-yyyy'), 397);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (398, 398, 398, to_date('13-12-2012', 'dd-mm-yyyy'), 398);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (399, 399, 399, to_date('05-06-2021', 'dd-mm-yyyy'), 399);
insert into TRIP (tripid, busid, driverid, tripdate, routeid)
values (400, 400, 400, to_date('24-08-2019', 'dd-mm-yyyy'), 400);
commit;
prompt 400 records loaded

set feedback on
set define on
prompt Done
