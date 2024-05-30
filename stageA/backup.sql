prompt PL/SQL Developer Export Tables for user C##AVISHAI@XE
prompt Created by avish on Thursday, May 30, 2024
set feedback off
set define off

prompt Creating BUS...
create table BUS
(
  busid        INTEGER not null,
  model        VARCHAR2(100) not null,
  capacity     INTEGER not null,
  purchasedate DATE not null
)
;
alter table BUS
  add primary key (BUSID);

prompt Creating SCHEDULE...
create table SCHEDULE
(
  scheduleid         INTEGER not null,
  frequency          INTEGER not null,
  firstdeparturetime VARCHAR2(8) not null,
  lastdeparturetime  VARCHAR2(8) not null
)
;
alter table SCHEDULE
  add primary key (SCHEDULEID);
alter table SCHEDULE
  add constraint CHK_FIRSTDEPARTURETIME
  check (REGEXP_LIKE(FirstDepartureTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));
alter table SCHEDULE
  add constraint CHK_LASTDEPARTURETIME
  check (REGEXP_LIKE(LastDepartureTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));

prompt Creating STATION...
create table STATION
(
  stationid      INTEGER not null,
  stationname    VARCHAR2(100) not null,
  stationaddress VARCHAR2(255) not null
)
;
alter table STATION
  add primary key (STATIONID);

prompt Creating LINE...
create table LINE
(
  lineid           INTEGER not null,
  linename         VARCHAR2(100) not null,
  scheduleid       INTEGER not null,
  startofstationid INTEGER not null,
  endofstationid   INTEGER not null
)
;
alter table LINE
  add primary key (LINEID);
alter table LINE
  add foreign key (SCHEDULEID)
  references SCHEDULE (SCHEDULEID);
alter table LINE
  add foreign key (STARTOFSTATIONID)
  references STATION (STATIONID);
alter table LINE
  add foreign key (ENDOFSTATIONID)
  references STATION (STATIONID);

prompt Creating BUSRIDE...
create table BUSRIDE
(
  busid      INTEGER not null,
  lineid     INTEGER not null,
  scheduleid INTEGER not null
)
;
alter table BUSRIDE
  add primary key (BUSID, LINEID, SCHEDULEID);
alter table BUSRIDE
  add foreign key (BUSID)
  references BUS (BUSID);
alter table BUSRIDE
  add foreign key (LINEID)
  references LINE (LINEID);
alter table BUSRIDE
  add foreign key (SCHEDULEID)
  references SCHEDULE (SCHEDULEID);

prompt Creating DRIVER...
create table DRIVER
(
  driverid      INTEGER not null,
  fullname      VARCHAR2(100) not null,
  licensenumber VARCHAR2(14) not null,
  hiredate      DATE not null
)
;
alter table DRIVER
  add primary key (DRIVERID);

prompt Creating TAXI...
create table TAXI
(
  taxiid      INTEGER not null,
  workingzone VARCHAR2(100) not null,
  starttime   VARCHAR2(8) not null,
  finishtime  VARCHAR2(8) not null
)
;
alter table TAXI
  add primary key (TAXIID);
alter table TAXI
  add constraint CHK_FINISHTIME
  check (REGEXP_LIKE(FinishTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));
alter table TAXI
  add constraint CHK_STARTTIME
  check (REGEXP_LIKE(StartTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));

prompt Creating DRIVESINTAXI...
create table DRIVESINTAXI
(
  driverid INTEGER not null,
  taxiid   INTEGER not null
)
;
alter table DRIVESINTAXI
  add primary key (DRIVERID, TAXIID);
alter table DRIVESINTAXI
  add foreign key (DRIVERID)
  references DRIVER (DRIVERID);
alter table DRIVESINTAXI
  add foreign key (TAXIID)
  references TAXI (TAXIID);

prompt Disabling triggers for BUS...
alter table BUS disable all triggers;
prompt Disabling triggers for SCHEDULE...
alter table SCHEDULE disable all triggers;
prompt Disabling triggers for STATION...
alter table STATION disable all triggers;
prompt Disabling triggers for LINE...
alter table LINE disable all triggers;
prompt Disabling triggers for BUSRIDE...
alter table BUSRIDE disable all triggers;
prompt Disabling triggers for DRIVER...
alter table DRIVER disable all triggers;
prompt Disabling triggers for TAXI...
alter table TAXI disable all triggers;
prompt Disabling triggers for DRIVESINTAXI...
alter table DRIVESINTAXI disable all triggers;
prompt Loading BUS...
insert into BUS (busid, model, capacity, purchasedate)
values (1, 'Protege', 60, to_date('10-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (2, 'Boxster', 19, to_date('07-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (3, '4Runner', 42, to_date('03-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (4, 'Suburban 2500', 28, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (5, 'Mazda3', 56, to_date('30-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (6, 'Suburban 2500', 35, to_date('21-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (7, 'Accent', 27, to_date('23-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (8, 'F150', 31, to_date('27-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (9, 'I', 35, to_date('16-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (10, 'XLR', 48, to_date('04-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (11, '7 Series', 20, to_date('28-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (12, 'GL-Class', 55, to_date('12-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (13, 'Elantra', 46, to_date('26-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (14, 'F250', 21, to_date('19-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (15, 'F350', 39, to_date('19-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (16, 'Rally Wagon 1500', 29, to_date('07-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (17, 'Camaro', 27, to_date('07-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (18, 'G35', 40, to_date('03-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (19, 'GT500', 59, to_date('21-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (20, 'Express 1500', 30, to_date('17-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (21, 'SVX', 29, to_date('21-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (22, 'Continental Flying Spur', 39, to_date('22-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (23, 'RX-7', 10, to_date('30-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (24, 'Quest', 21, to_date('19-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (25, 'Chariot', 25, to_date('20-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (26, 'ES', 24, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (27, 'Concorde', 38, to_date('21-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (28, 'Tacoma', 57, to_date('07-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (29, 'RX', 58, to_date('09-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (30, 'C-Class', 36, to_date('12-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (31, 'RAV4', 31, to_date('20-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (32, '928', 11, to_date('12-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (33, 'Q', 40, to_date('02-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (34, 'G', 36, to_date('18-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (35, 'Mighty Max Macro', 54, to_date('18-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (36, 'Regal', 54, to_date('05-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (37, 'Stratus', 57, to_date('17-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (38, 'Mazda5', 40, to_date('17-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (39, 'Park Avenue', 51, to_date('06-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (40, 'Suburban 2500', 47, to_date('04-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (41, 'Swift', 40, to_date('03-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (42, 'V8 Vantage S', 57, to_date('10-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (43, 'Ram Van 2500', 18, to_date('31-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (44, 'ES', 50, to_date('02-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (45, '300D', 37, to_date('19-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (46, 'SX4', 14, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (47, 'STS', 28, to_date('23-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (48, 'Impala', 60, to_date('16-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (49, 'Cabriolet', 19, to_date('13-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (50, 'Civic', 24, to_date('28-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (51, 'Grand Marquis', 58, to_date('09-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (52, 'Windstar', 36, to_date('26-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (53, 'Seville', 56, to_date('08-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (54, 'Lanos', 55, to_date('17-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (55, 'Eclipse', 47, to_date('05-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (56, 'F-Series', 35, to_date('05-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (57, 'A3', 45, to_date('15-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (58, '200SX', 33, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (59, 'Tempo', 23, to_date('06-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (60, 'Grand Voyager', 28, to_date('25-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (61, 'G37', 59, to_date('06-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (62, 'Sportage', 40, to_date('24-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (63, 'DTS', 26, to_date('04-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (64, 'Astro', 13, to_date('10-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (65, '9-3', 17, to_date('01-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (66, 'Diamante', 33, to_date('21-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (67, 'Sonata', 54, to_date('22-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (68, 'Bonneville', 57, to_date('29-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (69, 'tC', 43, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (70, 'XL-7', 17, to_date('21-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (71, 'M', 43, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (72, 'Odyssey', 46, to_date('16-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (73, 'Explorer', 42, to_date('07-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (74, 'CR-V', 51, to_date('08-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (75, 'GX', 42, to_date('26-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (76, 'H3', 37, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (77, 'Savana 3500', 35, to_date('27-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (78, 'Festiva', 60, to_date('04-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (79, 'Rendezvous', 55, to_date('18-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (80, 'Tribeca', 45, to_date('22-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (81, 'Mustang', 19, to_date('07-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (82, 'S70', 56, to_date('12-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (83, 'Montana SV6', 49, to_date('19-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (84, 'Millenia', 15, to_date('25-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (85, 'Esprit', 53, to_date('19-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (86, 'X-Type', 30, to_date('23-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (87, 'Grand Marquis', 39, to_date('07-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (88, 'Town Car', 48, to_date('09-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (89, 'Uplander', 20, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (90, 'Beetle', 39, to_date('04-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (91, 'Sequoia', 51, to_date('31-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (92, 'Tucson', 18, to_date('06-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (93, 'Sebring', 50, to_date('05-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (94, 'Corolla', 39, to_date('15-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (95, '626', 40, to_date('19-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (96, 'E-Series', 10, to_date('12-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (97, 'Crown Victoria', 45, to_date('29-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (98, 'XT', 54, to_date('31-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (99, 'LTD', 54, to_date('16-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (100, 'B-Series', 50, to_date('22-05-2024', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into BUS (busid, model, capacity, purchasedate)
values (101, 'X6 M', 36, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (102, 'Forenza', 59, to_date('23-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (103, 'Tempo', 45, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (104, 'Pilot', 36, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (105, 'Esperante', 39, to_date('23-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (106, 'Prius', 25, to_date('28-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (107, 'Tracer', 46, to_date('19-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (108, 'Tracer', 57, to_date('09-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (109, 'Legacy', 53, to_date('26-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (110, 'HHR', 28, to_date('11-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (111, 'Prizm', 24, to_date('18-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (112, 'Villager', 16, to_date('11-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (113, 'New Yorker', 45, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (114, 'Marauder', 38, to_date('24-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (115, '430', 57, to_date('07-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (116, 'Escape', 35, to_date('14-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (117, 'Firebird', 25, to_date('05-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (118, 'Precis', 29, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (119, '3000GT', 40, to_date('27-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (120, '626', 19, to_date('17-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (121, 'Pajero', 31, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (122, 'Miata MX-5', 16, to_date('29-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (123, 'Stealth', 43, to_date('22-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (124, 'NSX', 19, to_date('02-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (125, 'Suburban 2500', 51, to_date('20-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (126, 'Grand Cherokee', 26, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (127, '9-5', 29, to_date('24-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (128, 'GX', 58, to_date('13-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (129, 'Frontier', 38, to_date('09-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (130, 'Accord', 31, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (131, 'Miata MX-5', 44, to_date('20-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (132, 'Silverado 2500', 49, to_date('06-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (133, 'Escalade', 38, to_date('25-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (134, 'GT500', 28, to_date('20-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (135, 'Sentra', 12, to_date('29-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (136, 'S-Class', 41, to_date('25-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (137, 'Discovery', 24, to_date('20-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (138, 'Excel', 17, to_date('03-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (139, 'Sonata', 17, to_date('11-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (140, '57', 60, to_date('01-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (141, 'Wrangler', 48, to_date('30-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (142, 'Murciélago LP640', 49, to_date('26-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (143, 'Thunderbird', 29, to_date('11-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (144, 'Miata MX-5', 35, to_date('09-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (145, 'LeSabre', 23, to_date('08-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (146, 'RAV4', 32, to_date('30-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (147, 'Civic', 53, to_date('17-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (148, 'Jetta', 18, to_date('24-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (149, 'Focus', 31, to_date('26-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (150, 'Vandura 1500', 35, to_date('11-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (151, 'Dakota Club', 41, to_date('28-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (152, '928', 22, to_date('03-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (153, 'Quest', 24, to_date('15-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (154, 'XC90', 32, to_date('13-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (155, 'GTI', 47, to_date('25-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (156, 'TT', 60, to_date('14-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (157, 'Ram Van 3500', 56, to_date('14-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (158, 'Golf III', 22, to_date('21-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (159, 'Ram Wagon B350', 19, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (160, 'Viper', 47, to_date('15-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (161, '3500', 41, to_date('14-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (162, 'FCX Clarity', 21, to_date('12-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (163, 'Truck', 17, to_date('01-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (164, 'Tracker', 22, to_date('15-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (165, 'SLS AMG', 22, to_date('05-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (166, 'XC60', 24, to_date('14-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (167, 'Element', 16, to_date('17-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (168, 'XC70', 10, to_date('21-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (169, 'Lancer', 22, to_date('27-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (170, 'Bronco', 38, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (171, 'Eclipse', 18, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (172, 'Expedition', 12, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (173, 'MX-6', 49, to_date('04-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (174, 'Grand Marquis', 45, to_date('02-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (175, '4Runner', 57, to_date('01-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (176, 'Corvette', 22, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (177, '9000', 41, to_date('10-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (178, 'W126', 49, to_date('12-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (179, 'SC', 10, to_date('22-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (180, 'Diamante', 30, to_date('23-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (181, 'Fusion', 40, to_date('18-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (182, 'Fit', 29, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (183, 'Azure', 44, to_date('17-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (184, 'Impala SS', 42, to_date('28-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (185, 'Allante', 26, to_date('28-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (186, 'ES', 42, to_date('27-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (187, 'Highlander', 34, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (188, 'Countryman', 50, to_date('27-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (189, 'Cavalier', 11, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (190, 'Z8', 53, to_date('25-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (191, 'Stratus', 11, to_date('01-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (192, 'S-Type', 35, to_date('27-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (193, 'Silverado 2500', 11, to_date('24-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (194, 'Imperial', 22, to_date('18-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (195, 'Integra', 34, to_date('08-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (196, 'NV1500', 60, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (197, 'Ram 1500', 44, to_date('02-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (198, 'Astro', 17, to_date('14-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (199, 'L-Series', 57, to_date('04-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (200, 'Grand Prix Turbo', 43, to_date('18-12-2021', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into BUS (busid, model, capacity, purchasedate)
values (201, 'Forester', 10, to_date('06-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (202, 'Millenia', 27, to_date('26-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (203, 'Dynasty', 58, to_date('17-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (204, 'Tahoe', 27, to_date('05-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (205, 'SLK-Class', 35, to_date('05-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (206, 'DeVille', 29, to_date('06-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (207, 'Town Car', 27, to_date('04-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (208, 'Tredia', 21, to_date('18-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (209, 'X5', 41, to_date('15-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (210, 'CC', 37, to_date('22-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (211, 'Express 3500', 22, to_date('03-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (212, 'G37', 55, to_date('21-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (213, 'Amanti', 55, to_date('05-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (214, 'New Beetle', 15, to_date('25-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (215, 'Villager', 26, to_date('23-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (216, 'Spirit', 34, to_date('09-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (217, 'Explorer', 56, to_date('12-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (218, 'Landaulet', 55, to_date('15-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (219, 'Relay', 27, to_date('31-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (220, 'S40', 15, to_date('23-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (221, 'LeSabre', 60, to_date('06-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (222, 'Land Cruiser', 59, to_date('13-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (223, '57', 53, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (224, 'Quantum', 34, to_date('20-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (225, 'V8 Vantage', 55, to_date('12-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (226, '90', 45, to_date('08-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (227, 'Mustang', 59, to_date('07-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (228, 'LeSabre', 39, to_date('25-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (229, 'Insight', 52, to_date('03-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (230, 'Century', 51, to_date('17-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (231, 'MKT', 47, to_date('01-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (232, 'Murciélago', 40, to_date('01-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (233, 'Explorer Sport Trac', 12, to_date('03-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (234, 'Tacoma', 39, to_date('14-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (235, 'Endeavor', 19, to_date('15-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (236, 'ES', 23, to_date('25-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (237, 'Altima', 32, to_date('07-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (238, 'F-Series', 36, to_date('07-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (239, 'Thunderbird', 45, to_date('04-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (240, 'Journey', 52, to_date('09-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (241, 'Exige', 29, to_date('02-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (242, '5 Series', 27, to_date('12-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (243, 'Sierra 1500', 40, to_date('09-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (244, 'Astro', 47, to_date('26-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (245, 'Vandura G3500', 20, to_date('05-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (246, 'Colt Vista', 29, to_date('13-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (247, 'Continental', 20, to_date('03-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (248, 'Park Avenue', 13, to_date('28-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (249, 'Suburban 1500', 57, to_date('01-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (250, 'Sportage', 29, to_date('13-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (251, 'Civic', 42, to_date('06-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (252, 'Eurovan', 13, to_date('17-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (253, 'Cavalier', 48, to_date('22-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (254, 'MKS', 33, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (255, 'XG350', 26, to_date('06-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (256, 'New Beetle', 43, to_date('05-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (257, 'F250', 31, to_date('23-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (258, 'Venture', 43, to_date('07-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (259, 'E-Class', 43, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (260, 'Jetta', 44, to_date('14-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (261, 'Cavalier', 39, to_date('28-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (262, 'S-Type', 41, to_date('31-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (263, 'Cayman', 46, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (264, 'B-Series Plus', 60, to_date('13-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (265, 'Sierra 3500', 43, to_date('27-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (266, 'Cooper', 17, to_date('12-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (267, 'ES', 47, to_date('06-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (268, 'Accent', 37, to_date('21-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (269, 'Sonoma Club Coupe', 17, to_date('04-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (270, 'S4', 53, to_date('31-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (271, 'SLK-Class', 37, to_date('15-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (272, 'RAV4', 30, to_date('07-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (273, 'Probe', 59, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (274, 'Altima', 23, to_date('19-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (275, 'Passat', 46, to_date('16-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (276, 'Escort', 39, to_date('25-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (277, 'Space', 40, to_date('04-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (278, 'Ion', 34, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (279, 'Escort', 23, to_date('26-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (280, 'Quest', 22, to_date('31-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (281, 'Corvette', 16, to_date('18-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (282, 'Ranger', 34, to_date('09-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (283, 'Wrangler', 31, to_date('14-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (284, 'Ram', 40, to_date('21-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (285, 'Freestar', 26, to_date('24-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (286, 'xA', 20, to_date('09-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (287, '650', 42, to_date('03-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (288, 'Ram 3500', 15, to_date('20-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (289, 'Laser', 30, to_date('29-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (290, 'Dakota', 55, to_date('14-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (291, '2500', 30, to_date('26-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (292, 'Accord', 28, to_date('16-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (293, 'E250', 25, to_date('01-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (294, 'Neon', 21, to_date('20-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (295, 'Tiguan', 35, to_date('14-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (296, '924 S', 22, to_date('05-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (297, 'Continental', 15, to_date('01-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (298, 'Caliber', 51, to_date('07-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (299, 'Town Car', 21, to_date('07-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (300, 'Cougar', 24, to_date('26-02-2022', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into BUS (busid, model, capacity, purchasedate)
values (301, 'Cabriolet', 33, to_date('13-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (302, 'Avalon', 47, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (303, 'D350', 28, to_date('31-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (304, 'Bravada', 21, to_date('11-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (305, 'tC', 37, to_date('10-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (306, 'Contour', 45, to_date('24-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (307, 'C70', 52, to_date('18-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (308, 'Probe', 35, to_date('26-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (309, 'FR-S', 17, to_date('29-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (310, 'GTO', 13, to_date('27-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (311, 'Town & Country', 55, to_date('07-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (312, 'GTI', 30, to_date('27-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (313, 'F430', 58, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (314, 'RL', 19, to_date('23-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (315, 'Monte Carlo', 19, to_date('25-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (316, 'MKZ', 28, to_date('23-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (317, 'Explorer', 39, to_date('30-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (318, '968', 44, to_date('13-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (319, 'Vision', 40, to_date('23-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (320, 'Spectra', 45, to_date('16-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (321, 'H2 SUT', 39, to_date('12-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (322, '626', 13, to_date('05-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (323, 'Yukon', 58, to_date('29-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (324, 'Sedona', 21, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (325, 'Taurus', 26, to_date('18-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (326, 'Outlander Sport', 51, to_date('09-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (327, 'Grand Vitara', 56, to_date('28-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (328, 'Prowler', 32, to_date('11-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (329, 'Cavalier', 31, to_date('22-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (330, 'Caravan', 13, to_date('24-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (331, 'VUE', 31, to_date('25-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (332, 'Pajero', 32, to_date('11-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (333, 'Passat', 33, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (334, 'Grand Cherokee', 38, to_date('06-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (335, 'Ram 50', 34, to_date('30-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (336, 'X5', 37, to_date('28-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (337, 'Frontier', 44, to_date('24-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (338, 'XJ Series', 21, to_date('16-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (339, 'IS', 10, to_date('11-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (340, 'Avalanche 1500', 24, to_date('27-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (341, 'Altima', 32, to_date('26-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (342, 'Sierra 1500', 47, to_date('25-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (343, 'Caliber', 44, to_date('14-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (344, 'L-Series', 42, to_date('23-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (345, '940', 25, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (346, 'X5 M', 13, to_date('03-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (347, 'Murano', 30, to_date('31-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (348, 'Tacoma Xtra', 20, to_date('25-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (349, 'QX', 15, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (350, 'Loyale', 18, to_date('29-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (351, 'Camaro', 30, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (352, 'Park Avenue', 58, to_date('15-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (353, 'Touareg 2', 15, to_date('01-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (354, 'Mazda6', 46, to_date('04-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (355, '370Z', 31, to_date('25-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (356, 'Bonneville', 26, to_date('15-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (357, 'Ram 3500', 34, to_date('01-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (358, 'Escort', 24, to_date('11-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (359, 'Arnage', 19, to_date('03-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (360, 'SJ', 20, to_date('07-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (361, 'Ranger', 37, to_date('09-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (362, 'Cutlass', 57, to_date('13-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (363, 'Intrigue', 46, to_date('20-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (364, 'Lanos', 51, to_date('31-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (365, 'RL', 39, to_date('06-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (366, 'CL-Class', 32, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (367, 'Colorado', 34, to_date('15-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (368, 'B-Series', 10, to_date('19-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (369, 'GX', 25, to_date('22-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (370, 'Venza', 12, to_date('16-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (371, 'Range Rover', 23, to_date('12-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (372, 'CC', 17, to_date('19-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (373, '929', 21, to_date('28-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (374, 'Panamera', 52, to_date('26-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (375, 'SJ', 59, to_date('18-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (376, 'Traverse', 35, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (377, 'Seville', 35, to_date('25-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (378, 'CX-9', 47, to_date('28-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (379, 'Aerio', 53, to_date('17-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (380, 'F450', 60, to_date('21-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (381, 'Colorado', 32, to_date('27-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (382, 'GT', 11, to_date('07-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (383, 'B-Series', 28, to_date('28-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (384, 'G-Series 3500', 47, to_date('22-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (385, '400SEL', 39, to_date('24-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (386, 'CL-Class', 44, to_date('30-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (387, 'Skylark', 51, to_date('05-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (388, 'S-Class', 43, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (389, 'Mustang', 22, to_date('22-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (390, 'Fox', 56, to_date('08-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (391, 'Cavalier', 21, to_date('29-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (392, 'B-Series', 59, to_date('09-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (393, 'Firebird', 60, to_date('06-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (394, 'Camry', 14, to_date('16-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (395, 'Transit Connect', 58, to_date('04-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (396, 'Fiesta', 44, to_date('09-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (397, 'RL', 59, to_date('02-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (398, 'Escalade ESV', 31, to_date('07-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (399, 'Corolla', 47, to_date('27-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, model, capacity, purchasedate)
values (400, 'Mirage', 21, to_date('23-07-2022', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading SCHEDULE...
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (1, 367, '11:18:47', '0:03:28');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (2, 33, '15:26:30', '17:29:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (3, 172, '19:19:39', '10:15:25');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (4, 660, '1:00:20', '11:12:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (5, 504, '1:04:19', '19:33:06');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (6, 424, '14:14:35', '7:52:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (7, 347, '4:51:35', '0:08:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (8, 334, '13:50:29', '9:18:13');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (9, 529, '7:09:42', '4:32:02');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (10, 666, '20:17:07', '21:26:17');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (11, 483, '3:19:07', '0:42:53');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (12, 157, '0:05:23', '22:41:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (13, 309, '16:34:28', '3:59:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (14, 526, '3:11:52', '6:12:03');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (15, 214, '0:37:34', '3:53:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (16, 455, '1:21:14', '10:25:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (17, 682, '2:16:42', '18:18:30');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (18, 174, '1:49:11', '17:16:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (19, 450, '23:29:09', '1:38:00');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (20, 521, '0:01:29', '16:20:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (21, 559, '14:01:31', '5:16:28');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (22, 169, '18:14:59', '8:31:32');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (23, 491, '19:34:50', '19:13:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (24, 203, '6:49:36', '9:03:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (25, 121, '12:40:59', '16:51:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (26, 166, '12:58:14', '19:39:25');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (27, 105, '1:14:04', '16:24:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (28, 355, '7:53:47', '5:22:43');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (29, 477, '6:48:58', '19:12:22');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (30, 84, '15:49:49', '21:35:32');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (31, 470, '10:44:49', '17:16:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (32, 212, '1:56:48', '21:29:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (33, 463, '4:17:37', '13:46:52');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (34, 522, '19:25:03', '1:56:35');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (35, 602, '9:09:27', '19:35:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (36, 454, '16:51:30', '15:12:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (37, 450, '22:41:33', '19:43:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (38, 322, '8:17:11', '9:05:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (39, 633, '10:54:32', '11:41:24');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (40, 540, '10:43:30', '20:37:08');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (41, 185, '15:49:15', '6:03:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (42, 591, '18:50:17', '11:56:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (43, 34, '11:42:53', '8:25:49');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (44, 85, '11:10:37', '11:01:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (45, 707, '1:32:18', '3:52:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (46, 69, '1:22:15', '17:49:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (47, 518, '18:07:21', '10:02:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (48, 81, '3:42:02', '20:29:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (49, 311, '13:23:32', '10:45:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (50, 618, '1:31:04', '4:05:31');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (51, 613, '6:27:41', '1:02:35');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (52, 653, '5:17:19', '2:22:13');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (53, 390, '10:55:16', '5:18:53');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (54, 622, '16:35:26', '20:14:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (55, 555, '14:29:27', '23:28:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (56, 37, '13:32:41', '6:07:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (57, 318, '15:00:55', '12:36:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (58, 457, '7:44:36', '5:15:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (59, 600, '21:46:25', '21:10:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (60, 714, '6:39:06', '20:33:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (61, 329, '18:59:25', '11:06:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (62, 352, '3:55:07', '22:20:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (63, 24, '19:05:57', '23:46:02');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (64, 76, '12:48:29', '22:50:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (65, 457, '8:56:25', '17:25:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (66, 375, '13:13:22', '14:33:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (67, 572, '14:39:54', '12:15:08');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (68, 344, '20:39:24', '8:48:17');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (69, 46, '13:53:20', '19:36:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (70, 11, '19:19:03', '6:01:13');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (71, 651, '15:50:27', '15:55:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (72, 601, '9:45:40', '11:22:22');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (73, 661, '6:56:56', '4:05:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (74, 689, '3:38:45', '18:45:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (75, 479, '18:39:05', '10:33:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (76, 375, '12:32:38', '10:54:24');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (77, 548, '9:24:17', '18:07:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (78, 305, '15:01:08', '15:41:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (79, 194, '13:02:40', '6:10:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (80, 580, '9:59:23', '22:06:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (81, 472, '18:49:30', '18:11:36');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (82, 301, '20:03:46', '14:31:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (83, 461, '1:33:15', '19:57:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (84, 121, '0:11:55', '8:36:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (85, 274, '23:41:10', '7:16:53');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (86, 111, '21:24:46', '12:40:36');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (87, 705, '20:58:15', '11:32:14');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (88, 268, '6:21:27', '19:45:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (89, 214, '3:06:54', '23:03:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (90, 221, '13:04:05', '16:19:51');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (91, 53, '7:17:08', '5:05:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (92, 389, '0:16:58', '2:56:52');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (93, 312, '8:34:14', '6:30:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (94, 77, '14:15:43', '18:39:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (95, 233, '10:02:10', '12:15:33');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (96, 407, '5:41:49', '7:43:31');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (97, 371, '2:18:08', '1:25:51');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (98, 453, '9:44:45', '9:31:24');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (99, 569, '4:39:32', '1:26:59');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (100, 365, '3:53:31', '8:31:21');
commit;
prompt 100 records committed...
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (101, 452, '10:01:10', '19:42:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (102, 714, '4:11:49', '14:47:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (103, 652, '18:37:06', '13:22:21');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (104, 180, '20:37:54', '14:33:53');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (105, 553, '14:50:17', '7:07:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (106, 26, '8:52:25', '3:47:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (107, 108, '6:03:30', '4:18:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (108, 616, '2:20:38', '22:14:21');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (109, 240, '8:07:10', '9:56:07');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (110, 635, '8:10:18', '22:32:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (111, 461, '2:36:20', '23:48:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (112, 465, '11:40:15', '16:17:19');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (113, 217, '7:52:14', '13:36:33');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (114, 87, '3:46:47', '1:26:13');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (115, 80, '6:27:17', '7:37:08');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (116, 334, '13:18:14', '0:03:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (117, 125, '8:51:01', '3:11:00');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (118, 473, '7:16:37', '13:48:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (119, 502, '8:49:51', '18:27:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (120, 423, '21:59:03', '7:12:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (121, 651, '7:53:15', '15:49:13');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (122, 332, '8:06:09', '16:19:35');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (123, 206, '16:46:22', '18:20:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (124, 404, '20:50:27', '12:43:33');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (125, 196, '10:32:02', '16:13:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (126, 568, '11:04:06', '21:35:02');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (127, 648, '13:31:08', '22:10:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (128, 35, '4:30:01', '3:46:03');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (129, 328, '6:32:47', '15:24:51');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (130, 393, '22:11:25', '13:47:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (131, 201, '10:33:18', '4:18:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (132, 427, '2:23:03', '23:16:59');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (133, 156, '9:24:13', '4:19:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (134, 436, '12:52:28', '12:43:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (135, 45, '18:52:49', '20:45:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (136, 94, '12:53:33', '0:00:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (137, 483, '20:13:46', '23:32:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (138, 506, '9:25:47', '19:05:28');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (139, 307, '11:42:23', '17:44:13');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (140, 109, '3:03:32', '10:39:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (141, 512, '8:36:12', '11:54:06');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (142, 93, '0:27:55', '16:55:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (143, 493, '2:13:36', '22:01:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (144, 327, '6:34:17', '5:45:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (145, 667, '2:24:16', '5:57:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (146, 434, '14:29:54', '2:37:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (147, 77, '7:44:19', '16:18:00');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (148, 96, '6:17:41', '22:34:35');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (149, 270, '7:42:04', '16:18:59');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (150, 59, '0:38:12', '20:09:25');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (151, 351, '10:27:40', '1:55:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (152, 456, '3:00:55', '19:14:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (153, 670, '6:28:27', '14:23:17');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (154, 465, '3:21:42', '5:07:08');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (155, 193, '0:03:41', '23:57:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (156, 692, '20:18:57', '3:48:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (157, 121, '15:52:22', '10:41:30');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (158, 491, '17:21:25', '1:40:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (159, 581, '23:29:46', '14:42:36');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (160, 554, '4:29:38', '11:25:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (161, 360, '19:53:47', '10:38:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (162, 325, '5:09:04', '4:47:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (163, 710, '3:51:37', '20:58:59');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (164, 365, '0:41:44', '16:34:02');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (165, 61, '1:20:09', '7:45:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (166, 660, '17:42:22', '23:37:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (167, 690, '15:17:55', '21:14:32');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (168, 355, '5:34:10', '8:53:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (169, 302, '23:49:02', '16:55:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (170, 197, '13:50:39', '23:55:21');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (171, 498, '7:16:20', '9:19:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (172, 107, '2:16:07', '5:04:31');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (173, 253, '8:39:12', '10:32:49');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (174, 289, '12:31:54', '6:06:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (175, 336, '2:32:43', '20:32:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (176, 14, '22:52:09', '3:35:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (177, 273, '7:17:50', '11:04:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (178, 51, '3:51:25', '16:39:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (179, 424, '9:41:08', '0:52:33');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (180, 432, '10:08:26', '11:36:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (181, 236, '23:26:53', '12:28:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (182, 239, '19:22:42', '3:41:14');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (183, 685, '16:16:20', '0:14:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (184, 33, '16:44:46', '5:02:27');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (185, 82, '11:17:26', '9:07:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (186, 454, '3:45:33', '13:06:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (187, 549, '5:10:36', '3:07:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (188, 135, '8:27:54', '1:56:00');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (189, 285, '18:57:06', '17:11:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (190, 58, '18:49:30', '14:51:14');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (191, 597, '12:35:22', '4:44:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (192, 346, '16:43:22', '0:57:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (193, 501, '22:38:52', '2:46:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (194, 645, '14:19:55', '5:12:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (195, 125, '15:24:53', '10:26:21');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (196, 632, '7:14:02', '5:58:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (197, 143, '16:14:11', '3:10:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (198, 190, '14:59:53', '2:04:43');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (199, 698, '23:16:46', '7:23:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (200, 480, '12:29:36', '0:41:05');
commit;
prompt 200 records committed...
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (201, 602, '3:56:51', '5:43:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (202, 88, '15:05:36', '17:36:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (203, 339, '7:40:09', '23:39:59');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (204, 151, '23:53:49', '16:42:17');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (205, 473, '14:17:28', '16:45:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (206, 146, '6:26:54', '23:50:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (207, 134, '7:56:48', '5:40:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (208, 222, '23:36:47', '11:13:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (209, 83, '8:52:31', '1:20:53');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (210, 495, '6:00:21', '12:54:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (211, 650, '17:32:44', '16:27:21');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (212, 166, '17:41:15', '20:10:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (213, 564, '17:57:11', '13:24:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (214, 527, '23:14:58', '8:54:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (215, 705, '22:16:17', '19:22:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (216, 53, '0:42:17', '8:56:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (217, 643, '6:55:44', '7:33:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (218, 345, '9:09:55', '10:23:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (219, 353, '17:55:12', '23:45:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (220, 231, '8:24:04', '11:41:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (221, 665, '7:51:35', '16:15:25');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (222, 491, '21:02:26', '10:09:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (223, 516, '13:55:00', '3:51:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (224, 40, '23:45:35', '4:14:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (225, 262, '16:39:16', '20:24:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (226, 399, '0:26:53', '14:18:45');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (227, 539, '18:26:58', '14:06:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (228, 445, '2:03:11', '7:59:17');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (229, 225, '13:39:48', '14:58:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (230, 490, '6:20:27', '6:22:02');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (231, 22, '13:58:32', '8:06:33');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (232, 367, '10:37:42', '2:16:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (233, 595, '5:40:39', '21:17:30');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (234, 505, '23:15:58', '16:22:22');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (235, 106, '3:53:11', '5:12:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (236, 379, '20:03:18', '19:08:35');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (237, 73, '9:34:10', '17:30:57');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (238, 277, '1:48:01', '11:05:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (239, 263, '21:02:48', '13:15:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (240, 580, '1:31:44', '6:19:03');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (241, 57, '14:40:49', '15:39:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (242, 542, '17:47:59', '0:51:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (243, 341, '14:20:36', '2:22:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (244, 636, '20:50:42', '16:54:19');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (245, 479, '15:51:56', '6:13:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (246, 570, '3:45:39', '16:18:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (247, 499, '5:06:56', '9:43:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (248, 434, '6:33:30', '11:59:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (249, 702, '9:07:31', '19:40:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (250, 280, '6:55:45', '19:26:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (251, 512, '5:36:13', '21:59:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (252, 312, '0:31:49', '18:36:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (253, 141, '13:46:54', '23:34:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (254, 656, '13:48:39', '0:09:28');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (255, 476, '20:42:53', '15:54:24');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (256, 583, '1:41:47', '12:54:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (257, 177, '6:42:19', '10:31:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (258, 33, '21:59:51', '20:14:24');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (259, 607, '20:02:27', '6:40:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (260, 553, '16:16:46', '15:46:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (261, 472, '23:48:08', '18:44:07');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (262, 615, '6:25:31', '3:54:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (263, 216, '22:55:23', '15:41:22');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (264, 259, '16:57:55', '16:48:32');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (265, 261, '0:00:44', '3:30:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (266, 590, '11:36:29', '17:08:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (267, 227, '18:50:57', '17:35:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (268, 614, '7:33:31', '10:55:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (269, 261, '12:24:32', '6:48:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (270, 464, '8:57:29', '6:31:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (271, 434, '12:43:39', '10:09:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (272, 60, '22:35:10', '1:52:30');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (273, 403, '6:18:06', '5:31:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (274, 458, '20:30:14', '0:16:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (275, 94, '13:36:21', '5:08:07');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (276, 149, '1:13:27', '6:21:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (277, 568, '12:38:41', '16:44:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (278, 227, '20:45:38', '10:42:08');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (279, 514, '8:53:04', '8:35:02');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (280, 337, '20:03:54', '15:01:03');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (281, 474, '23:08:27', '3:36:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (282, 656, '15:24:27', '7:47:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (283, 406, '14:24:07', '1:16:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (284, 123, '13:39:26', '10:20:08');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (285, 356, '18:20:04', '18:05:14');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (286, 94, '22:32:18', '19:45:32');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (287, 348, '14:55:32', '11:53:25');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (288, 558, '12:04:03', '20:45:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (289, 75, '3:37:46', '12:32:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (290, 193, '20:05:44', '13:51:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (291, 342, '23:03:33', '0:17:36');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (292, 374, '1:40:44', '14:01:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (293, 328, '17:13:58', '12:17:51');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (294, 263, '4:29:43', '21:40:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (295, 667, '17:39:32', '0:57:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (296, 413, '22:26:45', '10:54:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (297, 434, '19:21:07', '22:11:30');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (298, 628, '20:07:37', '1:57:17');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (299, 579, '8:56:01', '10:24:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (300, 695, '9:30:53', '4:49:53');
commit;
prompt 300 records committed...
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (301, 601, '11:56:46', '1:32:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (302, 565, '18:55:44', '4:13:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (303, 607, '1:01:41', '10:05:09');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (304, 602, '17:10:16', '19:29:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (305, 469, '2:21:43', '13:49:21');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (306, 384, '22:23:55', '20:47:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (307, 705, '21:39:10', '16:26:31');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (308, 41, '19:15:19', '13:29:26');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (309, 49, '2:48:32', '17:26:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (310, 202, '4:02:21', '10:13:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (311, 458, '21:58:30', '15:10:36');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (312, 621, '13:25:25', '23:47:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (313, 564, '8:02:43', '0:40:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (314, 38, '23:09:23', '23:06:18');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (315, 649, '19:49:56', '17:29:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (316, 264, '17:36:38', '19:52:35');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (317, 495, '9:17:04', '20:45:46');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (318, 111, '10:11:49', '17:27:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (319, 236, '7:16:47', '14:37:50');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (320, 396, '4:14:58', '14:34:22');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (321, 119, '5:58:15', '1:28:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (322, 554, '20:56:56', '20:40:00');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (323, 385, '18:13:03', '17:41:32');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (324, 71, '13:01:03', '20:31:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (325, 710, '3:36:06', '6:08:58');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (326, 152, '23:55:30', '15:46:29');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (327, 164, '3:50:28', '17:23:16');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (328, 30, '4:46:03', '0:41:14');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (329, 684, '18:08:27', '4:43:44');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (330, 408, '23:03:55', '21:47:43');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (331, 68, '10:33:15', '23:08:33');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (332, 348, '10:30:05', '23:25:27');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (333, 532, '11:55:20', '22:29:19');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (334, 173, '23:53:31', '12:04:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (335, 102, '17:33:05', '0:15:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (336, 87, '11:59:59', '18:27:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (337, 52, '18:47:01', '17:01:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (338, 642, '10:04:17', '17:35:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (339, 464, '13:50:16', '23:32:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (340, 526, '23:19:12', '21:32:49');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (341, 299, '21:35:48', '4:57:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (342, 226, '22:14:28', '16:43:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (343, 673, '5:14:11', '10:00:14');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (344, 430, '18:37:23', '18:48:34');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (345, 419, '15:49:19', '8:12:49');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (346, 655, '15:37:43', '0:14:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (347, 295, '20:42:24', '23:04:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (348, 256, '13:00:48', '3:07:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (349, 682, '21:35:41', '20:50:01');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (350, 545, '0:36:03', '10:52:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (351, 369, '15:25:34', '7:04:39');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (352, 54, '14:35:37', '22:15:51');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (353, 553, '14:17:11', '21:53:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (354, 23, '8:13:59', '1:22:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (355, 594, '17:20:27', '1:18:59');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (356, 187, '1:05:29', '16:37:25');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (357, 343, '6:28:03', '0:49:54');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (358, 542, '8:10:06', '2:10:52');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (359, 155, '0:16:13', '20:37:12');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (360, 136, '6:33:34', '1:14:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (361, 333, '10:12:48', '22:36:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (362, 329, '16:17:32', '16:24:04');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (363, 292, '21:45:17', '20:56:10');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (364, 488, '15:35:03', '17:58:53');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (365, 75, '21:00:13', '17:57:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (366, 525, '18:18:27', '16:51:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (367, 677, '3:57:52', '2:52:42');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (368, 525, '5:12:43', '11:43:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (369, 196, '8:34:00', '6:53:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (370, 569, '2:09:59', '20:13:52');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (371, 565, '12:36:46', '4:39:40');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (372, 296, '5:57:18', '23:06:15');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (373, 623, '23:05:46', '13:05:22');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (374, 429, '23:20:40', '20:58:00');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (375, 464, '8:00:04', '4:55:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (376, 42, '5:36:58', '11:18:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (377, 385, '14:50:42', '6:28:56');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (378, 328, '21:03:03', '18:35:37');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (379, 169, '20:35:48', '5:30:28');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (380, 281, '5:58:24', '15:06:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (381, 366, '16:02:29', '2:25:31');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (382, 430, '2:29:19', '2:36:44');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (383, 444, '16:20:43', '19:30:06');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (384, 311, '12:06:35', '2:48:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (385, 578, '11:13:39', '1:12:48');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (386, 699, '16:23:47', '9:46:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (387, 241, '4:46:20', '10:16:11');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (388, 228, '3:53:36', '17:27:30');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (389, 154, '4:44:06', '21:22:55');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (390, 33, '11:49:29', '6:45:47');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (391, 490, '10:58:06', '6:46:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (392, 263, '12:14:41', '16:15:31');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (393, 65, '11:39:25', '16:24:23');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (394, 464, '22:13:07', '4:40:41');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (395, 14, '14:53:32', '19:22:38');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (396, 272, '5:05:34', '14:34:05');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (397, 241, '8:34:49', '1:11:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (398, 14, '2:46:20', '10:23:20');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (399, 276, '7:02:12', '21:00:19');
insert into SCHEDULE (scheduleid, frequency, firstdeparturetime, lastdeparturetime)
values (400, 345, '10:34:33', '18:46:21');
commit;
prompt 400 records loaded
prompt Loading STATION...
insert into STATION (stationid, stationname, stationaddress)
values (1, 'Dayton', '89 Granby Road');
insert into STATION (stationid, stationname, stationaddress)
values (2, 'Anderson', '3155 Northport Way');
insert into STATION (stationid, stationname, stationaddress)
values (3, 'Warner', '575 Hoepker Court');
insert into STATION (stationid, stationname, stationaddress)
values (4, 'Atwood', '81368 Mccormick Point');
insert into STATION (stationid, stationname, stationaddress)
values (5, 'Cascade', '91 Pine View Center');
insert into STATION (stationid, stationname, stationaddress)
values (6, 'Vernon', '764 Lotheville Point');
insert into STATION (stationid, stationname, stationaddress)
values (7, 'Farmco', '21184 East Point');
insert into STATION (stationid, stationname, stationaddress)
values (8, 'Loftsgordon', '6606 Walton Point');
insert into STATION (stationid, stationname, stationaddress)
values (9, 'Calypso', '9 Bluejay Drive');
insert into STATION (stationid, stationname, stationaddress)
values (10, 'Bluejay', '89 Artisan Pass');
insert into STATION (stationid, stationname, stationaddress)
values (11, 'Mockingbird', '02 Del Sol Court');
insert into STATION (stationid, stationname, stationaddress)
values (12, 'Eggendart', '42140 New Castle Lane');
insert into STATION (stationid, stationname, stationaddress)
values (13, 'Dexter', '21744 Park Meadow Junction');
insert into STATION (stationid, stationname, stationaddress)
values (14, 'Transport', '583 New Castle Place');
insert into STATION (stationid, stationname, stationaddress)
values (15, 'Comanche', '4716 Delladonna Way');
insert into STATION (stationid, stationname, stationaddress)
values (16, 'Starling', '5869 Green Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (17, 'Dottie', '1173 Paget Drive');
insert into STATION (stationid, stationname, stationaddress)
values (18, 'Corscot', '5625 Reindahl Drive');
insert into STATION (stationid, stationname, stationaddress)
values (19, 'Nova', '4 Hermina Street');
insert into STATION (stationid, stationname, stationaddress)
values (20, 'Truax', '16935 Rigney Park');
insert into STATION (stationid, stationname, stationaddress)
values (21, 'Havey', '1656 Manitowish Way');
insert into STATION (stationid, stationname, stationaddress)
values (22, 'Sachtjen', '38100 Everett Pass');
insert into STATION (stationid, stationname, stationaddress)
values (23, 'Fairfield', '11 Anzinger Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (24, 'Sullivan', '995 New Castle Way');
insert into STATION (stationid, stationname, stationaddress)
values (25, 'Wayridge', '0 7th Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (26, 'Ridge Oak', '6 Linden Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (27, 'Independence', '52473 New Castle Trail');
insert into STATION (stationid, stationname, stationaddress)
values (28, 'Elka', '17129 Chinook Point');
insert into STATION (stationid, stationname, stationaddress)
values (29, 'Swallow', '3 Esker Pass');
insert into STATION (stationid, stationname, stationaddress)
values (30, 'Melvin', '6 Derek Place');
insert into STATION (stationid, stationname, stationaddress)
values (31, 'Trailsway', '7527 Everett Alley');
insert into STATION (stationid, stationname, stationaddress)
values (32, 'Prairieview', '27310 Killdeer Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (33, 'Oxford', '7399 Oakridge Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (34, 'Mitchell', '2994 Daystar Court');
insert into STATION (stationid, stationname, stationaddress)
values (35, '7th', '62604 Tony Road');
insert into STATION (stationid, stationname, stationaddress)
values (36, 'Division', '51 Melody Hill');
insert into STATION (stationid, stationname, stationaddress)
values (37, 'Bartillon', '85426 Messerschmidt Place');
insert into STATION (stationid, stationname, stationaddress)
values (38, 'Raven', '1 West Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (39, 'Amoth', '607 Coleman Point');
insert into STATION (stationid, stationname, stationaddress)
values (40, 'Melvin', '2194 Shopko Alley');
insert into STATION (stationid, stationname, stationaddress)
values (41, 'Lunder', '8 Gerald Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (42, 'Fairview', '7936 Northport Center');
insert into STATION (stationid, stationname, stationaddress)
values (43, 'Graceland', '46767 Delaware Center');
insert into STATION (stationid, stationname, stationaddress)
values (44, 'Calypso', '6 Oak Valley Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (45, 'Declaration', '439 Rigney Junction');
insert into STATION (stationid, stationname, stationaddress)
values (46, 'Nova', '993 Quincy Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (47, 'Sullivan', '62648 Farmco Street');
insert into STATION (stationid, stationname, stationaddress)
values (48, 'Vahlen', '810 Lotheville Street');
insert into STATION (stationid, stationname, stationaddress)
values (49, 'Logan', '14 Mifflin Trail');
insert into STATION (stationid, stationname, stationaddress)
values (50, 'Rieder', '45 Bashford Drive');
insert into STATION (stationid, stationname, stationaddress)
values (51, 'Browning', '3 Hoard Point');
insert into STATION (stationid, stationname, stationaddress)
values (52, 'Westport', '02822 Forest Run Way');
insert into STATION (stationid, stationname, stationaddress)
values (53, 'Di Loreto', '02828 Bunting Park');
insert into STATION (stationid, stationname, stationaddress)
values (54, 'Haas', '118 Prairie Rose Park');
insert into STATION (stationid, stationname, stationaddress)
values (55, 'Warner', '43990 Rockefeller Street');
insert into STATION (stationid, stationname, stationaddress)
values (56, 'Knutson', '0 1st Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (57, 'Gina', '03504 Hooker Alley');
insert into STATION (stationid, stationname, stationaddress)
values (58, 'David', '64 Maple Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (59, 'Maryland', '6073 Forest Dale Court');
insert into STATION (stationid, stationname, stationaddress)
values (60, 'Jackson', '146 Shasta Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (61, 'Montana', '0 Farragut Point');
insert into STATION (stationid, stationname, stationaddress)
values (62, 'Columbus', '23550 Dorton Alley');
insert into STATION (stationid, stationname, stationaddress)
values (63, 'Anniversary', '772 Lotheville Hill');
insert into STATION (stationid, stationname, stationaddress)
values (64, 'Straubel', '1584 Park Meadow Alley');
insert into STATION (stationid, stationname, stationaddress)
values (65, 'Warner', '99768 Schlimgen Alley');
insert into STATION (stationid, stationname, stationaddress)
values (66, 'Delladonna', '1402 Elmside Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (67, 'Hazelcrest', '76933 Elka Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (68, 'Harbort', '37565 Westridge Hill');
insert into STATION (stationid, stationname, stationaddress)
values (69, 'Elmside', '511 Lakewood Gardens Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (70, 'Forest', '37393 Coolidge Lane');
insert into STATION (stationid, stationname, stationaddress)
values (71, 'Dwight', '4 Mitchell Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (72, 'Randy', '352 Waubesa Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (73, 'Meadow Ridge', '5346 Dayton Lane');
insert into STATION (stationid, stationname, stationaddress)
values (74, 'Dayton', '7369 Garrison Alley');
insert into STATION (stationid, stationname, stationaddress)
values (75, 'Clarendon', '5760 Johnson Center');
insert into STATION (stationid, stationname, stationaddress)
values (76, 'Hoffman', '82887 Fallview Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (77, 'Crownhardt', '7927 Mendota Alley');
insert into STATION (stationid, stationname, stationaddress)
values (78, 'Gina', '765 Lerdahl Road');
insert into STATION (stationid, stationname, stationaddress)
values (79, 'Toban', '77316 Hayes Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (80, 'American Ash', '15 Westport Point');
insert into STATION (stationid, stationname, stationaddress)
values (81, 'Heath', '1716 2nd Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (82, 'Dovetail', '26 Stang Pass');
insert into STATION (stationid, stationname, stationaddress)
values (83, 'Crest Line', '4 Village Green Lane');
insert into STATION (stationid, stationname, stationaddress)
values (84, 'Eggendart', '37048 Stoughton Park');
insert into STATION (stationid, stationname, stationaddress)
values (85, 'Clemons', '08274 Holmberg Pass');
insert into STATION (stationid, stationname, stationaddress)
values (86, 'Loomis', '28 Westport Trail');
insert into STATION (stationid, stationname, stationaddress)
values (87, 'Vermont', '86064 Holmberg Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (88, 'Algoma', '8 Hintze Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (89, 'Anderson', '5611 Ridgeview Trail');
insert into STATION (stationid, stationname, stationaddress)
values (90, 'Buena Vista', '2 Nova Junction');
insert into STATION (stationid, stationname, stationaddress)
values (91, 'Briar Crest', '62 Saint Paul Park');
insert into STATION (stationid, stationname, stationaddress)
values (92, 'Texas', '8 Derek Park');
insert into STATION (stationid, stationname, stationaddress)
values (93, 'Sachtjen', '214 Sunnyside Street');
insert into STATION (stationid, stationname, stationaddress)
values (94, 'Packers', '62 Service Drive');
insert into STATION (stationid, stationname, stationaddress)
values (95, 'Melrose', '313 Holmberg Street');
insert into STATION (stationid, stationname, stationaddress)
values (96, 'Menomonie', '3639 Vahlen Alley');
insert into STATION (stationid, stationname, stationaddress)
values (97, 'Schlimgen', '55 Emmet Place');
insert into STATION (stationid, stationname, stationaddress)
values (98, 'Logan', '5264 Carey Circle');
insert into STATION (stationid, stationname, stationaddress)
values (99, 'Rieder', '5983 Forest Run Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (100, 'Oakridge', '615 Scofield Lane');
commit;
prompt 100 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (101, 'Moulton', '3773 Annamark Alley');
insert into STATION (stationid, stationname, stationaddress)
values (102, 'Marquette', '741 Hovde Center');
insert into STATION (stationid, stationname, stationaddress)
values (103, 'Kedzie', '72 Dorton Junction');
insert into STATION (stationid, stationname, stationaddress)
values (104, 'Redwing', '443 Oriole Park');
insert into STATION (stationid, stationname, stationaddress)
values (105, 'Darwin', '43285 Golden Leaf Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (106, 'Ronald Regan', '592 Bunting Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (107, 'Hovde', '4096 Steensland Street');
insert into STATION (stationid, stationname, stationaddress)
values (108, 'Forest', '64853 Meadow Vale Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (109, 'Walton', '95 Calypso Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (110, 'Village', '4 Rutledge Drive');
insert into STATION (stationid, stationname, stationaddress)
values (111, 'Dapin', '74968 Artisan Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (112, 'Cambridge', '371 Killdeer Trail');
insert into STATION (stationid, stationname, stationaddress)
values (113, 'Westport', '8089 Hanson Way');
insert into STATION (stationid, stationname, stationaddress)
values (114, 'Delaware', '0794 Bayside Pass');
insert into STATION (stationid, stationname, stationaddress)
values (115, 'Brentwood', '69 Harbort Lane');
insert into STATION (stationid, stationname, stationaddress)
values (116, 'Kinsman', '27069 Stang Park');
insert into STATION (stationid, stationname, stationaddress)
values (117, 'Esch', '1 Brickson Park Way');
insert into STATION (stationid, stationname, stationaddress)
values (118, 'Haas', '34622 Blaine Road');
insert into STATION (stationid, stationname, stationaddress)
values (119, 'Utah', '92675 Longview Park');
insert into STATION (stationid, stationname, stationaddress)
values (120, 'Colorado', '6070 Briar Crest Junction');
insert into STATION (stationid, stationname, stationaddress)
values (121, 'Coolidge', '939 Havey Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (122, 'Parkside', '4283 Schurz Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (123, 'Harper', '6509 Maryland Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (124, 'Talisman', '589 Nelson Street');
insert into STATION (stationid, stationname, stationaddress)
values (125, 'Hanson', '29 Derek Junction');
insert into STATION (stationid, stationname, stationaddress)
values (126, 'Kenwood', '2309 Daystar Circle');
insert into STATION (stationid, stationname, stationaddress)
values (127, 'Algoma', '4400 Crowley Park');
insert into STATION (stationid, stationname, stationaddress)
values (128, 'Farmco', '41 Golf Course Trail');
insert into STATION (stationid, stationname, stationaddress)
values (129, 'Susan', '07 Esker Park');
insert into STATION (stationid, stationname, stationaddress)
values (130, 'Hooker', '08280 Schmedeman Street');
insert into STATION (stationid, stationname, stationaddress)
values (131, 'Autumn Leaf', '86836 Hudson Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (132, 'Daystar', '472 Cambridge Court');
insert into STATION (stationid, stationname, stationaddress)
values (133, 'Hermina', '08 Carioca Court');
insert into STATION (stationid, stationname, stationaddress)
values (134, 'Donald', '2 Luster Point');
insert into STATION (stationid, stationname, stationaddress)
values (135, 'Namekagon', '32607 Tennyson Lane');
insert into STATION (stationid, stationname, stationaddress)
values (136, 'Lillian', '3026 Farragut Place');
insert into STATION (stationid, stationname, stationaddress)
values (137, 'Northport', '665 Lillian Circle');
insert into STATION (stationid, stationname, stationaddress)
values (138, 'Burning Wood', '898 Spohn Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (139, 'Sullivan', '0 Waubesa Hill');
insert into STATION (stationid, stationname, stationaddress)
values (140, 'Daystar', '89 New Castle Place');
insert into STATION (stationid, stationname, stationaddress)
values (141, 'Fordem', '73 Sachtjen Junction');
insert into STATION (stationid, stationname, stationaddress)
values (142, 'Sundown', '544 Declaration Way');
insert into STATION (stationid, stationname, stationaddress)
values (143, 'Tomscot', '63 Karstens Pass');
insert into STATION (stationid, stationname, stationaddress)
values (144, 'Tony', '68396 Meadow Ridge Pass');
insert into STATION (stationid, stationname, stationaddress)
values (145, 'Ilene', '894 Sheridan Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (146, 'Muir', '9181 Esker Hill');
insert into STATION (stationid, stationname, stationaddress)
values (147, 'Carioca', '16183 Havey Drive');
insert into STATION (stationid, stationname, stationaddress)
values (148, 'Granby', '403 Corscot Street');
insert into STATION (stationid, stationname, stationaddress)
values (149, 'Tennessee', '68 Pleasure Point');
insert into STATION (stationid, stationname, stationaddress)
values (150, 'Memorial', '0077 Mendota Hill');
insert into STATION (stationid, stationname, stationaddress)
values (151, 'Arapahoe', '2517 Buena Vista Junction');
insert into STATION (stationid, stationname, stationaddress)
values (152, 'Northland', '3330 Truax Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (153, 'Hallows', '09952 Utah Center');
insert into STATION (stationid, stationname, stationaddress)
values (154, 'Village', '2 Del Mar Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (155, 'Union', '0 Weeping Birch Court');
insert into STATION (stationid, stationname, stationaddress)
values (156, 'Pierstorff', '200 Michigan Court');
insert into STATION (stationid, stationname, stationaddress)
values (157, 'Crescent Oaks', '19 Marcy Road');
insert into STATION (stationid, stationname, stationaddress)
values (158, 'Pawling', '820 Straubel Circle');
insert into STATION (stationid, stationname, stationaddress)
values (159, 'Coolidge', '213 Nobel Way');
insert into STATION (stationid, stationname, stationaddress)
values (160, 'Westerfield', '18545 Ruskin Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (161, 'Havey', '32622 Del Mar Way');
insert into STATION (stationid, stationname, stationaddress)
values (162, 'Dorton', '8930 Arkansas Junction');
insert into STATION (stationid, stationname, stationaddress)
values (163, 'Helena', '775 Myrtle Road');
insert into STATION (stationid, stationname, stationaddress)
values (164, 'Bultman', '1973 Meadow Valley Park');
insert into STATION (stationid, stationname, stationaddress)
values (165, 'Barnett', '12 Mitchell Trail');
insert into STATION (stationid, stationname, stationaddress)
values (166, 'Hagan', '4 Maywood Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (167, 'Columbus', '24 Fairfield Center');
insert into STATION (stationid, stationname, stationaddress)
values (168, 'Del Sol', '95707 Cordelia Pass');
insert into STATION (stationid, stationname, stationaddress)
values (169, 'Northview', '70 Stephen Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (170, 'Michigan', '631 Pine View Hill');
insert into STATION (stationid, stationname, stationaddress)
values (171, 'South', '66 Del Mar Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (172, 'Westend', '86996 Longview Alley');
insert into STATION (stationid, stationname, stationaddress)
values (173, 'Holmberg', '6567 Londonderry Place');
insert into STATION (stationid, stationname, stationaddress)
values (174, 'Barby', '7 Sheridan Trail');
insert into STATION (stationid, stationname, stationaddress)
values (175, 'Oneill', '58595 Marcy Way');
insert into STATION (stationid, stationname, stationaddress)
values (176, 'Lighthouse Bay', '67884 Michigan Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (177, 'Meadow Valley', '61 Corscot Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (178, 'Gateway', '99 Debs Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (179, 'Becker', '7654 Donald Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (180, 'Macpherson', '9 Clove Point');
insert into STATION (stationid, stationname, stationaddress)
values (181, 'North', '02867 Merrick Lane');
insert into STATION (stationid, stationname, stationaddress)
values (182, 'Aberg', '21 Bunting Way');
insert into STATION (stationid, stationname, stationaddress)
values (183, 'Shelley', '6038 Eggendart Circle');
insert into STATION (stationid, stationname, stationaddress)
values (184, 'Independence', '3235 Homewood Hill');
insert into STATION (stationid, stationname, stationaddress)
values (185, 'Moulton', '13 Melody Lane');
insert into STATION (stationid, stationname, stationaddress)
values (186, 'Holmberg', '975 Mitchell Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (187, 'Oak', '7774 Larry Pass');
insert into STATION (stationid, stationname, stationaddress)
values (188, 'Butternut', '3 Melby Trail');
insert into STATION (stationid, stationname, stationaddress)
values (189, '7th', '50 Huxley Road');
insert into STATION (stationid, stationname, stationaddress)
values (190, 'Blackbird', '2 Fallview Drive');
insert into STATION (stationid, stationname, stationaddress)
values (191, '4th', '66297 Loftsgordon Circle');
insert into STATION (stationid, stationname, stationaddress)
values (192, 'Dayton', '91708 Melby Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (193, 'Meadow Ridge', '914 Boyd Park');
insert into STATION (stationid, stationname, stationaddress)
values (194, 'Veith', '39507 Sheridan Place');
insert into STATION (stationid, stationname, stationaddress)
values (195, 'Prairieview', '61864 Derek Trail');
insert into STATION (stationid, stationname, stationaddress)
values (196, '5th', '867 Browning Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (197, 'Pankratz', '1877 Artisan Lane');
insert into STATION (stationid, stationname, stationaddress)
values (198, 'Mallory', '605 Nevada Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (199, 'Menomonie', '9712 Burrows Court');
insert into STATION (stationid, stationname, stationaddress)
values (200, 'Thierer', '35298 Beilfuss Trail');
commit;
prompt 200 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (201, 'Spenser', '2 Hoepker Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (202, 'Prentice', '4 Becker Road');
insert into STATION (stationid, stationname, stationaddress)
values (203, 'Sunfield', '40 Dakota Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (204, 'Heath', '74355 Corry Drive');
insert into STATION (stationid, stationname, stationaddress)
values (205, 'Raven', '3 Commercial Center');
insert into STATION (stationid, stationname, stationaddress)
values (206, 'Del Mar', '75 Jenifer Street');
insert into STATION (stationid, stationname, stationaddress)
values (207, 'Riverside', '554 Dwight Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (208, 'Sunnyside', '91 Mallory Circle');
insert into STATION (stationid, stationname, stationaddress)
values (209, 'Westport', '70804 Basil Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (210, 'Gina', '4836 Washington Hill');
insert into STATION (stationid, stationname, stationaddress)
values (211, 'Farwell', '842 Fordem Point');
insert into STATION (stationid, stationname, stationaddress)
values (212, 'Randy', '090 Eagan Street');
insert into STATION (stationid, stationname, stationaddress)
values (213, 'Dahle', '6828 Pennsylvania Hill');
insert into STATION (stationid, stationname, stationaddress)
values (214, 'Saint Paul', '216 Prairie Rose Pass');
insert into STATION (stationid, stationname, stationaddress)
values (215, 'Sutteridge', '9778 Ridgeway Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (216, '4th', '25320 Graedel Road');
insert into STATION (stationid, stationname, stationaddress)
values (217, 'Commercial', '8 Memorial Junction');
insert into STATION (stationid, stationname, stationaddress)
values (218, 'Nevada', '49 Tennessee Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (219, 'Village Green', '42656 Starling Center');
insert into STATION (stationid, stationname, stationaddress)
values (220, 'Sutteridge', '764 Myrtle Alley');
insert into STATION (stationid, stationname, stationaddress)
values (221, 'Rowland', '65631 Mcguire Place');
insert into STATION (stationid, stationname, stationaddress)
values (222, 'Northland', '1 Scoville Circle');
insert into STATION (stationid, stationname, stationaddress)
values (223, 'Gerald', '099 Harper Way');
insert into STATION (stationid, stationname, stationaddress)
values (224, '4th', '01 Glacier Hill Hill');
insert into STATION (stationid, stationname, stationaddress)
values (225, '3rd', '468 Golf Drive');
insert into STATION (stationid, stationname, stationaddress)
values (226, 'Waubesa', '773 Fallview Pass');
insert into STATION (stationid, stationname, stationaddress)
values (227, 'Anhalt', '731 Oxford Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (228, 'Mosinee', '18 Lunder Lane');
insert into STATION (stationid, stationname, stationaddress)
values (229, 'Sutherland', '55 Mcguire Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (230, 'Ruskin', '6019 Basil Trail');
insert into STATION (stationid, stationname, stationaddress)
values (231, 'Warrior', '1 Sunnyside Place');
insert into STATION (stationid, stationname, stationaddress)
values (232, 'Gerald', '4 Reinke Circle');
insert into STATION (stationid, stationname, stationaddress)
values (233, 'Miller', '003 Lerdahl Road');
insert into STATION (stationid, stationname, stationaddress)
values (234, 'Oak', '47058 Hansons Pass');
insert into STATION (stationid, stationname, stationaddress)
values (235, 'Hayes', '37 Anzinger Hill');
insert into STATION (stationid, stationname, stationaddress)
values (236, 'Green Ridge', '77 Cherokee Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (237, 'Main', '497 Longview Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (238, 'Buhler', '5 Veith Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (239, 'Delaware', '83595 Sunbrook Point');
insert into STATION (stationid, stationname, stationaddress)
values (240, 'Manitowish', '26425 2nd Way');
insert into STATION (stationid, stationname, stationaddress)
values (241, 'Gulseth', '3 Forest Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (242, 'Fordem', '800 Messerschmidt Trail');
insert into STATION (stationid, stationname, stationaddress)
values (243, 'Kedzie', '4249 Trailsway Way');
insert into STATION (stationid, stationname, stationaddress)
values (244, 'Esch', '74503 Marquette Point');
insert into STATION (stationid, stationname, stationaddress)
values (245, 'Dixon', '22 Colorado Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (246, 'Lerdahl', '911 Loftsgordon Circle');
insert into STATION (stationid, stationname, stationaddress)
values (247, 'Utah', '81 8th Lane');
insert into STATION (stationid, stationname, stationaddress)
values (248, 'Fairview', '5237 Arrowood Place');
insert into STATION (stationid, stationname, stationaddress)
values (249, 'Bobwhite', '512 Wayridge Drive');
insert into STATION (stationid, stationname, stationaddress)
values (250, 'North', '10 American Ash Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (251, 'Clyde Gallagher', '6971 Dayton Lane');
insert into STATION (stationid, stationname, stationaddress)
values (252, 'Ramsey', '221 Sutteridge Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (253, 'Muir', '709 South Street');
insert into STATION (stationid, stationname, stationaddress)
values (254, 'Hooker', '69 Bunker Hill Trail');
insert into STATION (stationid, stationname, stationaddress)
values (255, 'Thierer', '6446 Westport Junction');
insert into STATION (stationid, stationname, stationaddress)
values (256, 'Fair Oaks', '60201 Buell Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (257, 'Pierstorff', '5 Schmedeman Street');
insert into STATION (stationid, stationname, stationaddress)
values (258, 'Lakewood', '1 Warner Street');
insert into STATION (stationid, stationname, stationaddress)
values (259, 'Macpherson', '02 Farragut Point');
insert into STATION (stationid, stationname, stationaddress)
values (260, 'Clyde Gallagher', '4 Amoth Point');
insert into STATION (stationid, stationname, stationaddress)
values (261, 'Moulton', '5 4th Park');
insert into STATION (stationid, stationname, stationaddress)
values (262, 'Esch', '52964 Burning Wood Pass');
insert into STATION (stationid, stationname, stationaddress)
values (263, 'Golf Course', '111 Lerdahl Hill');
insert into STATION (stationid, stationname, stationaddress)
values (264, 'Lerdahl', '10466 Valley Edge Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (265, 'Saint Paul', '878 8th Park');
insert into STATION (stationid, stationname, stationaddress)
values (266, 'Monica', '239 Petterle Lane');
insert into STATION (stationid, stationname, stationaddress)
values (267, 'School', '7817 Loomis Junction');
insert into STATION (stationid, stationname, stationaddress)
values (268, 'Carpenter', '85 Birchwood Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (269, 'Messerschmidt', '27 Canary Street');
insert into STATION (stationid, stationname, stationaddress)
values (270, 'South', '096 Burning Wood Way');
insert into STATION (stationid, stationname, stationaddress)
values (271, 'Haas', '5 Division Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (272, 'Memorial', '0 Homewood Center');
insert into STATION (stationid, stationname, stationaddress)
values (273, 'La Follette', '10 Petterle Way');
insert into STATION (stationid, stationname, stationaddress)
values (274, 'Sachtjen', '5513 Northwestern Trail');
insert into STATION (stationid, stationname, stationaddress)
values (275, 'Banding', '7492 Pierstorff Hill');
insert into STATION (stationid, stationname, stationaddress)
values (276, 'La Follette', '6 Golf Course Drive');
insert into STATION (stationid, stationname, stationaddress)
values (277, 'Paget', '778 Atwood Drive');
insert into STATION (stationid, stationname, stationaddress)
values (278, '6th', '63 Grim Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (279, 'Sunnyside', '3 Calypso Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (280, 'Esch', '327 Lukken Park');
insert into STATION (stationid, stationname, stationaddress)
values (281, 'Gina', '4 Starling Hill');
insert into STATION (stationid, stationname, stationaddress)
values (282, 'Annamark', '42620 Warbler Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (283, 'Hanson', '120 Melvin Center');
insert into STATION (stationid, stationname, stationaddress)
values (284, 'Mayer', '8 Dapin Drive');
insert into STATION (stationid, stationname, stationaddress)
values (285, 'Brickson Park', '52 Beilfuss Hill');
insert into STATION (stationid, stationname, stationaddress)
values (286, 'Elmside', '6 Sauthoff Lane');
insert into STATION (stationid, stationname, stationaddress)
values (287, 'Pierstorff', '4503 Quincy Way');
insert into STATION (stationid, stationname, stationaddress)
values (288, 'Crest Line', '77537 Prentice Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (289, 'Arrowood', '756 Mesta Center');
insert into STATION (stationid, stationname, stationaddress)
values (290, 'Dorton', '636 Canary Point');
insert into STATION (stationid, stationname, stationaddress)
values (291, 'Sloan', '56 Northview Junction');
insert into STATION (stationid, stationname, stationaddress)
values (292, '1st', '9 Randy Road');
insert into STATION (stationid, stationname, stationaddress)
values (293, 'Havey', '345 Reinke Road');
insert into STATION (stationid, stationname, stationaddress)
values (294, 'Mallard', '59 Almo Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (295, 'Leroy', '5367 Magdeline Avenue');
insert into STATION (stationid, stationname, stationaddress)
values (296, 'Hanson', '1276 Shasta Center');
insert into STATION (stationid, stationname, stationaddress)
values (297, 'Marquette', '2 Surrey Trail');
insert into STATION (stationid, stationname, stationaddress)
values (298, 'Briar Crest', '651 Leroy Trail');
insert into STATION (stationid, stationname, stationaddress)
values (299, 'Northridge', '5 Stang Circle');
insert into STATION (stationid, stationname, stationaddress)
values (300, 'Ramsey', '4954 Debra Avenue');
commit;
prompt 300 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (301, 'Artisan', '97980 Golden Leaf Trail');
insert into STATION (stationid, stationname, stationaddress)
values (302, 'Arrowood', '498 Dryden Park');
insert into STATION (stationid, stationname, stationaddress)
values (303, 'Meadow Vale', '564 Nova Lane');
insert into STATION (stationid, stationname, stationaddress)
values (304, 'Dryden', '76614 Caliangt Point');
insert into STATION (stationid, stationname, stationaddress)
values (305, 'Shopko', '842 Old Shore Center');
insert into STATION (stationid, stationname, stationaddress)
values (306, 'New Castle', '0 Kennedy Trail');
insert into STATION (stationid, stationname, stationaddress)
values (307, 'Moland', '58938 Farwell Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (308, 'Carberry', '09 Summer Ridge Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (309, 'Haas', '51 Hauk Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (310, 'Warner', '6 Fremont Point');
insert into STATION (stationid, stationname, stationaddress)
values (311, 'Paget', '197 West Pass');
insert into STATION (stationid, stationname, stationaddress)
values (312, 'Mallard', '0584 Buhler Pass');
insert into STATION (stationid, stationname, stationaddress)
values (313, 'John Wall', '2 Erie Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (314, 'Green Ridge', '00287 Walton Junction');
insert into STATION (stationid, stationname, stationaddress)
values (315, 'Harper', '7231 Del Sol Pass');
insert into STATION (stationid, stationname, stationaddress)
values (316, 'Russell', '089 Calypso Place');
insert into STATION (stationid, stationname, stationaddress)
values (317, 'Ludington', '8 Fremont Drive');
insert into STATION (stationid, stationname, stationaddress)
values (318, 'Linden', '6 Mayfield Way');
insert into STATION (stationid, stationname, stationaddress)
values (319, 'Del Sol', '3223 Dawn Junction');
insert into STATION (stationid, stationname, stationaddress)
values (320, 'Loomis', '63 Forest Dale Center');
insert into STATION (stationid, stationname, stationaddress)
values (321, 'Mariners Cove', '93 Coleman Court');
insert into STATION (stationid, stationname, stationaddress)
values (322, 'Southridge', '54 Golden Leaf Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (323, 'Summer Ridge', '44799 Commercial Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (324, 'Warner', '7 Anthes Point');
insert into STATION (stationid, stationname, stationaddress)
values (325, 'Shasta', '51 Welch Circle');
insert into STATION (stationid, stationname, stationaddress)
values (326, 'Artisan', '7 Stephen Center');
insert into STATION (stationid, stationname, stationaddress)
values (327, 'Oakridge', '1556 Thackeray Place');
insert into STATION (stationid, stationname, stationaddress)
values (328, 'Pennsylvania', '207 Pleasure Junction');
insert into STATION (stationid, stationname, stationaddress)
values (329, 'Mandrake', '9 Westerfield Way');
insert into STATION (stationid, stationname, stationaddress)
values (330, 'David', '278 Fallview Lane');
insert into STATION (stationid, stationname, stationaddress)
values (331, 'Lukken', '84 Fairview Alley');
insert into STATION (stationid, stationname, stationaddress)
values (332, 'Hansons', '0 Mariners Cove Road');
insert into STATION (stationid, stationname, stationaddress)
values (333, 'Fuller', '7 Leroy Pass');
insert into STATION (stationid, stationname, stationaddress)
values (334, 'Meadow Ridge', '080 Westridge Circle');
insert into STATION (stationid, stationname, stationaddress)
values (335, 'Armistice', '8082 Summerview Pass');
insert into STATION (stationid, stationname, stationaddress)
values (336, 'Express', '92 Sunbrook Road');
insert into STATION (stationid, stationname, stationaddress)
values (337, 'Beilfuss', '893 Logan Circle');
insert into STATION (stationid, stationname, stationaddress)
values (338, 'Corry', '156 Waxwing Drive');
insert into STATION (stationid, stationname, stationaddress)
values (339, 'Onsgard', '1 Susan Center');
insert into STATION (stationid, stationname, stationaddress)
values (340, 'Carey', '111 Sachtjen Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (341, 'Village Green', '68 Anderson Place');
insert into STATION (stationid, stationname, stationaddress)
values (342, 'Carey', '56844 Union Road');
insert into STATION (stationid, stationname, stationaddress)
values (343, 'Raven', '6 Hermina Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (344, 'Anhalt', '88858 Lakeland Court');
insert into STATION (stationid, stationname, stationaddress)
values (345, 'Fuller', '3125 Lyons Street');
insert into STATION (stationid, stationname, stationaddress)
values (346, 'Monica', '6 Melby Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (347, 'Summit', '21 Hanson Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (348, 'American', '2916 Westridge Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (349, 'Fallview', '9 South Way');
insert into STATION (stationid, stationname, stationaddress)
values (350, 'Charing Cross', '651 Iowa Way');
insert into STATION (stationid, stationname, stationaddress)
values (351, 'Thierer', '502 Londonderry Point');
insert into STATION (stationid, stationname, stationaddress)
values (352, 'Grasskamp', '7 Cottonwood Trail');
insert into STATION (stationid, stationname, stationaddress)
values (353, 'Manley', '220 Buena Vista Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (354, 'Declaration', '34467 Thackeray Trail');
insert into STATION (stationid, stationname, stationaddress)
values (355, 'High Crossing', '760 Oxford Point');
insert into STATION (stationid, stationname, stationaddress)
values (356, 'Buena Vista', '78079 Columbus Trail');
insert into STATION (stationid, stationname, stationaddress)
values (357, 'Heffernan', '5710 Morningstar Lane');
insert into STATION (stationid, stationname, stationaddress)
values (358, 'Montana', '3372 Schmedeman Way');
insert into STATION (stationid, stationname, stationaddress)
values (359, 'Randy', '8 Buena Vista Place');
insert into STATION (stationid, stationname, stationaddress)
values (360, 'Express', '07979 Luster Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (361, 'Lakewood', '949 Bunting Street');
insert into STATION (stationid, stationname, stationaddress)
values (362, 'Bonner', '2 Anthes Point');
insert into STATION (stationid, stationname, stationaddress)
values (363, 'Leroy', '65625 Tomscot Lane');
insert into STATION (stationid, stationname, stationaddress)
values (364, 'Lerdahl', '443 Washington Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (365, 'Talisman', '4769 Fremont Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (366, 'Pond', '72380 Crownhardt Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (367, 'Texas', '00865 Monterey Trail');
insert into STATION (stationid, stationname, stationaddress)
values (368, 'Meadow Valley', '5 Knutson Crossing');
insert into STATION (stationid, stationname, stationaddress)
values (369, 'Northland', '1 Anniversary Pass');
insert into STATION (stationid, stationname, stationaddress)
values (370, 'Parkside', '612 Kim Trail');
insert into STATION (stationid, stationname, stationaddress)
values (371, 'Calypso', '76489 Meadow Ridge Court');
insert into STATION (stationid, stationname, stationaddress)
values (372, 'Florence', '79 Forest Run Center');
insert into STATION (stationid, stationname, stationaddress)
values (373, 'Londonderry', '923 Mallard Court');
insert into STATION (stationid, stationname, stationaddress)
values (374, 'Pennsylvania', '0924 Bartillon Road');
insert into STATION (stationid, stationname, stationaddress)
values (375, 'Manufacturers', '432 Hanson Circle');
insert into STATION (stationid, stationname, stationaddress)
values (376, 'Maywood', '22 Gateway Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (377, 'Del Sol', '45142 Shoshone Circle');
insert into STATION (stationid, stationname, stationaddress)
values (378, 'Texas', '66 Maywood Center');
insert into STATION (stationid, stationname, stationaddress)
values (379, 'Crowley', '92 Anniversary Trail');
insert into STATION (stationid, stationname, stationaddress)
values (380, 'Stephen', '5392 Hagan Road');
insert into STATION (stationid, stationname, stationaddress)
values (381, 'Pankratz', '02830 Florence Trail');
insert into STATION (stationid, stationname, stationaddress)
values (382, 'Russell', '00427 Manitowish Street');
insert into STATION (stationid, stationname, stationaddress)
values (383, 'Anniversary', '5 Di Loreto Lane');
insert into STATION (stationid, stationname, stationaddress)
values (384, 'Green', '20941 Coolidge Plaza');
insert into STATION (stationid, stationname, stationaddress)
values (385, 'Forest Run', '1080 Prairie Rose Alley');
insert into STATION (stationid, stationname, stationaddress)
values (386, 'Spaight', '12 Eagan Junction');
insert into STATION (stationid, stationname, stationaddress)
values (387, 'Dexter', '3 East Circle');
insert into STATION (stationid, stationname, stationaddress)
values (388, 'Hansons', '04094 Brentwood Alley');
insert into STATION (stationid, stationname, stationaddress)
values (389, 'Arkansas', '980 Springs Road');
insert into STATION (stationid, stationname, stationaddress)
values (390, 'Armistice', '003 8th Lane');
insert into STATION (stationid, stationname, stationaddress)
values (391, 'Waxwing', '7 Florence Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (392, 'Independence', '8229 Mockingbird Terrace');
insert into STATION (stationid, stationname, stationaddress)
values (393, 'Mcguire', '233 Milwaukee Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (394, 'Sugar', '77 Prairieview Point');
insert into STATION (stationid, stationname, stationaddress)
values (395, 'Rusk', '304 Namekagon Parkway');
insert into STATION (stationid, stationname, stationaddress)
values (396, 'North', '803 Mallard Drive');
insert into STATION (stationid, stationname, stationaddress)
values (397, 'Jenna', '11449 Bultman Hill');
insert into STATION (stationid, stationname, stationaddress)
values (398, 'Lawn', '19 Granby Circle');
insert into STATION (stationid, stationname, stationaddress)
values (399, 'Troy', '0102 Arkansas Hill');
insert into STATION (stationid, stationname, stationaddress)
values (400, 'Talmadge', '273 6th Pass');
commit;
prompt 400 records loaded
prompt Loading LINE...
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (1, '554', 289, 399, 241);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (2, '71', 328, 334, 214);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (3, '814', 172, 224, 361);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (4, '467', 226, 295, 345);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (5, '10', 111, 229, 226);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (6, '754', 264, 388, 365);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (7, '109', 256, 285, 124);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (8, '186', 111, 186, 86);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (9, '623', 43, 65, 265);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (10, '779', 339, 340, 95);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (11, '844', 25, 331, 36);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (12, '270', 283, 60, 135);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (13, '533', 241, 394, 96);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (14, '496', 172, 130, 126);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (15, '38', 171, 233, 17);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (16, '520', 133, 128, 203);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (17, '708', 234, 74, 278);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (18, '368', 109, 379, 215);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (19, '831', 127, 322, 302);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (20, '926', 6, 381, 290);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (21, '717', 299, 341, 39);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (22, '580', 345, 367, 168);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (23, '511', 327, 250, 96);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (24, '911', 58, 84, 171);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (25, '858', 25, 267, 49);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (26, '47', 29, 139, 191);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (27, '660', 185, 196, 288);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (28, '545', 45, 167, 394);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (29, '960', 235, 71, 183);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (30, '477', 335, 98, 94);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (31, '259', 394, 348, 125);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (32, '628', 182, 321, 386);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (33, '352', 259, 225, 248);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (34, '119', 164, 399, 1);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (35, '370', 123, 277, 330);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (36, '426', 78, 79, 176);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (37, '762', 126, 320, 228);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (38, '952', 7, 249, 207);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (39, '441', 243, 163, 63);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (40, '160', 383, 311, 186);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (41, '734', 90, 25, 299);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (42, '574', 160, 376, 294);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (43, '201', 331, 11, 257);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (44, '610', 62, 325, 234);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (45, '115', 288, 39, 366);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (46, '813', 221, 397, 38);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (47, '674', 231, 332, 227);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (48, '63', 256, 163, 379);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (49, '587', 99, 12, 132);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (50, '377', 84, 357, 169);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (51, '397', 149, 93, 49);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (52, '821', 239, 52, 317);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (53, '870', 173, 127, 251);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (54, '325', 117, 282, 367);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (55, '549', 247, 365, 79);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (56, '563', 51, 189, 101);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (57, '304', 327, 143, 180);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (58, '395', 209, 123, 34);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (59, '567', 130, 166, 206);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (60, '614', 214, 271, 366);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (61, '629', 164, 353, 27);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (62, '764', 355, 37, 110);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (63, '832', 186, 123, 29);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (64, '146', 28, 227, 152);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (65, '661', 242, 399, 326);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (66, '545', 62, 304, 377);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (67, '741', 210, 201, 118);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (68, '88', 170, 264, 54);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (69, '921', 252, 143, 332);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (70, '432', 79, 253, 97);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (71, '174', 391, 168, 165);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (72, '507', 132, 367, 155);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (73, '42', 4, 171, 155);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (74, '893', 38, 21, 292);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (75, '951', 316, 184, 289);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (76, '55', 117, 303, 78);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (77, '604', 337, 180, 340);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (78, '531', 27, 66, 325);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (79, '259', 262, 334, 238);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (80, '958', 223, 297, 364);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (81, '406', 338, 332, 193);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (82, '442', 210, 71, 154);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (83, '571', 189, 365, 125);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (84, '882', 178, 92, 16);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (85, '862', 285, 390, 20);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (86, '279', 30, 211, 100);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (87, '683', 118, 332, 273);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (88, '426', 143, 54, 51);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (89, '866', 315, 15, 320);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (90, '249', 109, 368, 12);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (91, '933', 86, 250, 279);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (92, '58', 155, 136, 398);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (93, '146', 266, 13, 311);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (94, '464', 174, 200, 167);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (95, '138', 365, 120, 382);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (96, '652', 45, 9, 13);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (97, '59', 370, 105, 372);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (98, '512', 88, 353, 21);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (99, '269', 52, 184, 332);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (100, '97', 305, 81, 335);
commit;
prompt 100 records committed...
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (101, '486', 44, 370, 242);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (102, '989', 144, 70, 81);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (103, '37', 47, 180, 372);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (104, '652', 187, 258, 35);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (105, '36', 287, 361, 214);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (106, '6', 208, 287, 184);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (107, '622', 181, 49, 285);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (108, '904', 252, 17, 154);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (109, '567', 289, 14, 309);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (110, '103', 162, 17, 9);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (111, '38', 135, 394, 394);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (112, '674', 244, 156, 33);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (113, '233', 80, 316, 34);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (114, '401', 377, 344, 183);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (115, '810', 384, 274, 146);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (116, '96', 384, 395, 118);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (117, '20', 263, 286, 389);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (118, '157', 264, 323, 241);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (119, '565', 393, 26, 308);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (120, '78', 14, 56, 276);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (121, '228', 49, 137, 48);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (122, '184', 176, 242, 94);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (123, '735', 157, 325, 84);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (124, '907', 147, 151, 233);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (125, '710', 398, 286, 136);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (126, '123', 272, 298, 327);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (127, '741', 152, 330, 244);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (128, '167', 187, 26, 138);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (129, '989', 359, 29, 172);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (130, '969', 43, 1, 152);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (131, '866', 75, 155, 383);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (132, '595', 97, 391, 301);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (133, '201', 36, 299, 382);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (134, '780', 307, 73, 165);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (135, '484', 105, 358, 237);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (136, '920', 335, 264, 295);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (137, '361', 348, 174, 397);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (138, '770', 98, 373, 9);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (139, '697', 287, 166, 92);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (140, '751', 307, 200, 368);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (141, '341', 47, 290, 293);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (142, '649', 27, 24, 199);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (143, '333', 240, 198, 58);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (144, '44', 197, 352, 238);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (145, '441', 298, 286, 239);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (146, '633', 12, 261, 97);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (147, '788', 115, 259, 75);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (148, '622', 340, 13, 95);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (149, '681', 299, 399, 277);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (150, '118', 242, 112, 121);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (151, '406', 264, 113, 47);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (152, '406', 340, 161, 345);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (153, '318', 338, 25, 69);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (154, '56', 120, 326, 106);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (155, '151', 335, 358, 112);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (156, '972', 266, 282, 19);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (157, '887', 286, 43, 160);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (158, '285', 339, 263, 33);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (159, '297', 237, 269, 358);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (160, '923', 192, 296, 166);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (161, '274', 205, 238, 233);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (162, '529', 313, 64, 393);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (163, '415', 63, 242, 375);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (164, '772', 381, 46, 380);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (165, '340', 293, 46, 148);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (166, '751', 114, 110, 114);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (167, '766', 245, 197, 90);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (168, '257', 264, 85, 95);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (169, '123', 109, 61, 250);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (170, '268', 247, 226, 53);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (171, '927', 248, 310, 79);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (172, '566', 208, 111, 184);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (173, '967', 294, 191, 112);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (174, '720', 246, 123, 346);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (175, '225', 23, 200, 83);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (176, '8', 68, 39, 216);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (177, '806', 305, 24, 292);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (178, '108', 241, 360, 221);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (179, '369', 107, 246, 46);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (180, '596', 238, 89, 104);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (181, '377', 93, 239, 161);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (182, '513', 294, 210, 266);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (183, '140', 49, 118, 103);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (184, '408', 109, 307, 271);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (185, '324', 136, 50, 122);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (186, '277', 338, 161, 180);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (187, '824', 231, 298, 297);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (188, '436', 80, 266, 65);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (189, '707', 253, 155, 262);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (190, '718', 248, 184, 63);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (191, '570', 224, 52, 240);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (192, '422', 47, 179, 41);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (193, '675', 72, 275, 54);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (194, '518', 24, 315, 316);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (195, '62', 309, 270, 380);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (196, '373', 115, 204, 32);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (197, '149', 146, 310, 201);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (198, '173', 86, 186, 306);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (199, '213', 362, 161, 139);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (200, '372', 185, 124, 304);
commit;
prompt 200 records committed...
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (201, '984', 316, 316, 179);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (202, '326', 56, 106, 117);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (203, '354', 50, 239, 314);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (204, '365', 120, 69, 77);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (205, '895', 264, 243, 335);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (206, '171', 220, 99, 268);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (207, '135', 291, 293, 205);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (208, '366', 185, 34, 263);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (209, '918', 281, 175, 337);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (210, '550', 173, 217, 99);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (211, '259', 322, 290, 167);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (212, '523', 193, 370, 233);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (213, '643', 390, 400, 110);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (214, '959', 20, 222, 132);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (215, '493', 75, 190, 335);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (216, '778', 56, 252, 366);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (217, '68', 13, 223, 239);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (218, '230', 62, 218, 141);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (219, '940', 291, 49, 206);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (220, '812', 309, 187, 234);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (221, '732', 117, 99, 176);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (222, '491', 145, 79, 298);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (223, '882', 149, 98, 63);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (224, '650', 92, 293, 248);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (225, '48', 331, 376, 68);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (226, '182', 244, 136, 83);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (227, '395', 214, 23, 356);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (228, '896', 62, 138, 120);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (229, '124', 145, 316, 263);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (230, '324', 399, 195, 30);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (231, '909', 129, 177, 291);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (232, '145', 18, 103, 146);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (233, '772', 400, 5, 94);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (234, '997', 378, 316, 51);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (235, '855', 55, 366, 184);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (236, '656', 51, 16, 127);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (237, '420', 223, 63, 164);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (238, '951', 68, 302, 253);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (239, '454', 359, 169, 157);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (240, '463', 217, 231, 285);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (241, '957', 250, 109, 194);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (242, '913', 238, 191, 271);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (243, '740', 103, 232, 291);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (244, '997', 128, 191, 272);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (245, '454', 352, 31, 85);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (246, '940', 125, 305, 240);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (247, '629', 191, 84, 177);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (248, '752', 38, 39, 209);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (249, '548', 199, 38, 192);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (250, '39', 384, 374, 18);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (251, '569', 11, 400, 49);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (252, '579', 362, 364, 234);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (253, '719', 399, 361, 353);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (254, '437', 41, 247, 81);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (255, '911', 31, 122, 79);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (256, '43', 184, 243, 157);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (257, '70', 114, 17, 369);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (258, '722', 208, 30, 12);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (259, '571', 384, 286, 347);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (260, '110', 228, 271, 325);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (261, '510', 240, 146, 164);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (262, '335', 66, 227, 203);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (263, '337', 222, 128, 10);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (264, '496', 191, 130, 106);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (265, '180', 142, 274, 59);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (266, '458', 378, 184, 144);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (267, '423', 80, 265, 193);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (268, '783', 356, 53, 243);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (269, '284', 153, 283, 16);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (270, '23', 125, 318, 186);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (271, '236', 380, 108, 122);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (272, '271', 115, 74, 103);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (273, '216', 76, 248, 125);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (274, '167', 261, 232, 184);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (275, '430', 326, 392, 356);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (276, '207', 112, 296, 44);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (277, '781', 220, 281, 329);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (278, '532', 160, 162, 125);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (279, '5', 18, 365, 365);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (280, '950', 263, 277, 317);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (281, '157', 285, 149, 115);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (282, '874', 85, 336, 201);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (283, '788', 32, 343, 284);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (284, '691', 330, 368, 343);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (285, '48', 292, 199, 129);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (286, '986', 227, 191, 376);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (287, '8', 392, 391, 55);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (288, '233', 130, 329, 326);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (289, '924', 260, 367, 208);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (290, '644', 129, 233, 9);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (291, '58', 287, 74, 190);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (292, '444', 58, 282, 222);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (293, '764', 217, 186, 298);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (294, '441', 113, 186, 232);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (295, '759', 309, 118, 188);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (296, '315', 310, 297, 267);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (297, '661', 23, 33, 58);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (298, '418', 214, 352, 27);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (299, '908', 52, 61, 328);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (300, '331', 191, 245, 373);
commit;
prompt 300 records committed...
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (301, '499', 174, 188, 112);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (302, '399', 60, 336, 298);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (303, '81', 83, 89, 121);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (304, '585', 68, 215, 317);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (305, '54', 384, 296, 143);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (306, '43', 209, 25, 210);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (307, '737', 284, 379, 198);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (308, '193', 66, 177, 248);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (309, '811', 188, 10, 322);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (310, '225', 369, 152, 120);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (311, '946', 63, 95, 155);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (312, '327', 382, 386, 199);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (313, '824', 364, 134, 86);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (314, '177', 84, 346, 153);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (315, '634', 180, 48, 49);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (316, '749', 318, 215, 360);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (317, '455', 120, 21, 100);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (318, '739', 93, 264, 105);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (319, '495', 153, 364, 142);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (320, '965', 316, 372, 193);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (321, '389', 318, 373, 332);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (322, '912', 392, 348, 320);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (323, '119', 279, 246, 378);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (324, '413', 197, 390, 243);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (325, '356', 188, 60, 368);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (326, '115', 292, 5, 263);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (327, '182', 242, 117, 107);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (328, '98', 72, 221, 293);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (329, '174', 88, 356, 380);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (330, '594', 86, 188, 36);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (331, '695', 82, 359, 370);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (332, '591', 396, 25, 152);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (333, '562', 232, 129, 76);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (334, '846', 228, 214, 210);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (335, '15', 53, 281, 256);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (336, '447', 184, 351, 291);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (337, '107', 290, 352, 79);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (338, '471', 77, 104, 306);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (339, '68', 321, 144, 328);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (340, '831', 149, 6, 54);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (341, '30', 168, 161, 314);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (342, '939', 376, 93, 110);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (343, '90', 163, 257, 149);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (344, '427', 320, 75, 399);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (345, '223', 349, 208, 329);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (346, '815', 99, 372, 154);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (347, '759', 284, 5, 118);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (348, '449', 90, 399, 314);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (349, '7', 45, 54, 22);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (350, '579', 195, 245, 151);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (351, '715', 307, 325, 377);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (352, '981', 76, 244, 269);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (353, '728', 384, 73, 357);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (354, '693', 74, 87, 121);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (355, '742', 268, 382, 92);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (356, '321', 85, 272, 68);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (357, '370', 202, 110, 180);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (358, '144', 54, 223, 125);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (359, '517', 174, 49, 330);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (360, '420', 159, 145, 199);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (361, '443', 281, 116, 393);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (362, '250', 137, 165, 121);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (363, '519', 145, 352, 95);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (364, '145', 342, 145, 247);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (365, '684', 379, 215, 375);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (366, '505', 165, 95, 305);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (367, '898', 371, 353, 45);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (368, '781', 370, 45, 363);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (369, '90', 306, 282, 368);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (370, '203', 46, 140, 205);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (371, '597', 229, 56, 192);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (372, '824', 2, 203, 268);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (373, '14', 295, 350, 347);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (374, '789', 334, 160, 282);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (375, '417', 44, 119, 1);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (376, '212', 173, 222, 115);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (377, '545', 154, 114, 226);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (378, '874', 86, 214, 380);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (379, '130', 196, 396, 62);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (380, '564', 235, 34, 101);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (381, '845', 78, 144, 246);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (382, '495', 109, 381, 348);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (383, '728', 150, 98, 123);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (384, '481', 152, 218, 366);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (385, '705', 212, 107, 54);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (386, '537', 368, 371, 154);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (387, '677', 24, 304, 245);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (388, '368', 287, 55, 221);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (389, '691', 152, 84, 127);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (390, '66', 326, 71, 23);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (391, '981', 310, 189, 74);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (392, '616', 200, 174, 68);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (393, '848', 170, 31, 127);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (394, '408', 48, 152, 56);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (395, '715', 17, 339, 353);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (396, '318', 22, 315, 199);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (397, '746', 393, 390, 302);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (398, '852', 288, 209, 44);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (399, '791', 106, 111, 360);
insert into LINE (lineid, linename, scheduleid, startofstationid, endofstationid)
values (400, '147', 254, 340, 234);
commit;
prompt 400 records loaded
prompt Loading BUSRIDE...
insert into BUSRIDE (busid, lineid, scheduleid)
values (363, 197, 247);
insert into BUSRIDE (busid, lineid, scheduleid)
values (136, 219, 98);
insert into BUSRIDE (busid, lineid, scheduleid)
values (213, 352, 393);
insert into BUSRIDE (busid, lineid, scheduleid)
values (251, 125, 97);
insert into BUSRIDE (busid, lineid, scheduleid)
values (326, 115, 16);
insert into BUSRIDE (busid, lineid, scheduleid)
values (352, 66, 334);
insert into BUSRIDE (busid, lineid, scheduleid)
values (272, 352, 243);
insert into BUSRIDE (busid, lineid, scheduleid)
values (225, 130, 266);
insert into BUSRIDE (busid, lineid, scheduleid)
values (334, 220, 183);
insert into BUSRIDE (busid, lineid, scheduleid)
values (303, 270, 346);
insert into BUSRIDE (busid, lineid, scheduleid)
values (241, 173, 230);
insert into BUSRIDE (busid, lineid, scheduleid)
values (301, 379, 120);
insert into BUSRIDE (busid, lineid, scheduleid)
values (261, 393, 328);
insert into BUSRIDE (busid, lineid, scheduleid)
values (42, 371, 321);
insert into BUSRIDE (busid, lineid, scheduleid)
values (45, 121, 142);
insert into BUSRIDE (busid, lineid, scheduleid)
values (61, 12, 79);
insert into BUSRIDE (busid, lineid, scheduleid)
values (290, 21, 296);
insert into BUSRIDE (busid, lineid, scheduleid)
values (282, 252, 144);
insert into BUSRIDE (busid, lineid, scheduleid)
values (332, 2, 390);
insert into BUSRIDE (busid, lineid, scheduleid)
values (121, 257, 271);
insert into BUSRIDE (busid, lineid, scheduleid)
values (315, 177, 342);
insert into BUSRIDE (busid, lineid, scheduleid)
values (32, 124, 20);
insert into BUSRIDE (busid, lineid, scheduleid)
values (379, 7, 230);
insert into BUSRIDE (busid, lineid, scheduleid)
values (394, 138, 16);
insert into BUSRIDE (busid, lineid, scheduleid)
values (3, 226, 175);
insert into BUSRIDE (busid, lineid, scheduleid)
values (341, 289, 25);
insert into BUSRIDE (busid, lineid, scheduleid)
values (303, 275, 224);
insert into BUSRIDE (busid, lineid, scheduleid)
values (306, 383, 266);
insert into BUSRIDE (busid, lineid, scheduleid)
values (20, 307, 185);
insert into BUSRIDE (busid, lineid, scheduleid)
values (172, 327, 364);
insert into BUSRIDE (busid, lineid, scheduleid)
values (348, 253, 57);
insert into BUSRIDE (busid, lineid, scheduleid)
values (223, 194, 12);
insert into BUSRIDE (busid, lineid, scheduleid)
values (273, 42, 239);
insert into BUSRIDE (busid, lineid, scheduleid)
values (107, 230, 170);
insert into BUSRIDE (busid, lineid, scheduleid)
values (130, 257, 156);
insert into BUSRIDE (busid, lineid, scheduleid)
values (251, 83, 150);
insert into BUSRIDE (busid, lineid, scheduleid)
values (286, 347, 326);
insert into BUSRIDE (busid, lineid, scheduleid)
values (79, 123, 20);
insert into BUSRIDE (busid, lineid, scheduleid)
values (28, 130, 28);
insert into BUSRIDE (busid, lineid, scheduleid)
values (270, 27, 26);
insert into BUSRIDE (busid, lineid, scheduleid)
values (138, 74, 228);
insert into BUSRIDE (busid, lineid, scheduleid)
values (258, 90, 212);
insert into BUSRIDE (busid, lineid, scheduleid)
values (188, 21, 362);
insert into BUSRIDE (busid, lineid, scheduleid)
values (338, 357, 362);
insert into BUSRIDE (busid, lineid, scheduleid)
values (119, 168, 298);
insert into BUSRIDE (busid, lineid, scheduleid)
values (281, 152, 161);
insert into BUSRIDE (busid, lineid, scheduleid)
values (343, 373, 5);
insert into BUSRIDE (busid, lineid, scheduleid)
values (344, 27, 365);
insert into BUSRIDE (busid, lineid, scheduleid)
values (98, 73, 333);
insert into BUSRIDE (busid, lineid, scheduleid)
values (132, 116, 374);
insert into BUSRIDE (busid, lineid, scheduleid)
values (107, 343, 276);
insert into BUSRIDE (busid, lineid, scheduleid)
values (257, 276, 127);
insert into BUSRIDE (busid, lineid, scheduleid)
values (166, 55, 22);
insert into BUSRIDE (busid, lineid, scheduleid)
values (96, 329, 158);
insert into BUSRIDE (busid, lineid, scheduleid)
values (339, 346, 315);
insert into BUSRIDE (busid, lineid, scheduleid)
values (19, 139, 332);
insert into BUSRIDE (busid, lineid, scheduleid)
values (171, 1, 138);
insert into BUSRIDE (busid, lineid, scheduleid)
values (67, 78, 318);
insert into BUSRIDE (busid, lineid, scheduleid)
values (257, 135, 119);
insert into BUSRIDE (busid, lineid, scheduleid)
values (255, 6, 161);
insert into BUSRIDE (busid, lineid, scheduleid)
values (275, 138, 175);
insert into BUSRIDE (busid, lineid, scheduleid)
values (236, 48, 200);
insert into BUSRIDE (busid, lineid, scheduleid)
values (276, 330, 395);
insert into BUSRIDE (busid, lineid, scheduleid)
values (242, 299, 8);
insert into BUSRIDE (busid, lineid, scheduleid)
values (372, 33, 194);
insert into BUSRIDE (busid, lineid, scheduleid)
values (62, 189, 134);
insert into BUSRIDE (busid, lineid, scheduleid)
values (261, 189, 49);
insert into BUSRIDE (busid, lineid, scheduleid)
values (100, 54, 118);
insert into BUSRIDE (busid, lineid, scheduleid)
values (291, 348, 371);
insert into BUSRIDE (busid, lineid, scheduleid)
values (125, 10, 40);
insert into BUSRIDE (busid, lineid, scheduleid)
values (161, 136, 258);
insert into BUSRIDE (busid, lineid, scheduleid)
values (264, 290, 346);
insert into BUSRIDE (busid, lineid, scheduleid)
values (17, 269, 219);
insert into BUSRIDE (busid, lineid, scheduleid)
values (371, 39, 244);
insert into BUSRIDE (busid, lineid, scheduleid)
values (129, 56, 144);
insert into BUSRIDE (busid, lineid, scheduleid)
values (179, 341, 347);
insert into BUSRIDE (busid, lineid, scheduleid)
values (69, 105, 373);
insert into BUSRIDE (busid, lineid, scheduleid)
values (359, 77, 266);
insert into BUSRIDE (busid, lineid, scheduleid)
values (85, 45, 385);
insert into BUSRIDE (busid, lineid, scheduleid)
values (299, 234, 2);
insert into BUSRIDE (busid, lineid, scheduleid)
values (251, 183, 318);
insert into BUSRIDE (busid, lineid, scheduleid)
values (10, 370, 235);
insert into BUSRIDE (busid, lineid, scheduleid)
values (17, 48, 4);
insert into BUSRIDE (busid, lineid, scheduleid)
values (316, 301, 384);
insert into BUSRIDE (busid, lineid, scheduleid)
values (321, 116, 329);
insert into BUSRIDE (busid, lineid, scheduleid)
values (272, 352, 89);
insert into BUSRIDE (busid, lineid, scheduleid)
values (2, 67, 42);
insert into BUSRIDE (busid, lineid, scheduleid)
values (305, 95, 82);
insert into BUSRIDE (busid, lineid, scheduleid)
values (203, 189, 31);
insert into BUSRIDE (busid, lineid, scheduleid)
values (398, 61, 213);
insert into BUSRIDE (busid, lineid, scheduleid)
values (214, 361, 380);
insert into BUSRIDE (busid, lineid, scheduleid)
values (317, 3, 164);
insert into BUSRIDE (busid, lineid, scheduleid)
values (275, 315, 27);
insert into BUSRIDE (busid, lineid, scheduleid)
values (247, 283, 70);
insert into BUSRIDE (busid, lineid, scheduleid)
values (125, 335, 16);
insert into BUSRIDE (busid, lineid, scheduleid)
values (92, 221, 20);
insert into BUSRIDE (busid, lineid, scheduleid)
values (363, 139, 7);
insert into BUSRIDE (busid, lineid, scheduleid)
values (121, 346, 290);
insert into BUSRIDE (busid, lineid, scheduleid)
values (151, 128, 31);
insert into BUSRIDE (busid, lineid, scheduleid)
values (239, 298, 358);
commit;
prompt 100 records committed...
insert into BUSRIDE (busid, lineid, scheduleid)
values (172, 316, 388);
insert into BUSRIDE (busid, lineid, scheduleid)
values (333, 191, 160);
insert into BUSRIDE (busid, lineid, scheduleid)
values (349, 212, 191);
insert into BUSRIDE (busid, lineid, scheduleid)
values (351, 98, 180);
insert into BUSRIDE (busid, lineid, scheduleid)
values (388, 343, 301);
insert into BUSRIDE (busid, lineid, scheduleid)
values (19, 259, 187);
insert into BUSRIDE (busid, lineid, scheduleid)
values (35, 393, 197);
insert into BUSRIDE (busid, lineid, scheduleid)
values (387, 392, 238);
insert into BUSRIDE (busid, lineid, scheduleid)
values (180, 395, 370);
insert into BUSRIDE (busid, lineid, scheduleid)
values (1, 23, 271);
insert into BUSRIDE (busid, lineid, scheduleid)
values (299, 136, 330);
insert into BUSRIDE (busid, lineid, scheduleid)
values (215, 138, 377);
insert into BUSRIDE (busid, lineid, scheduleid)
values (132, 310, 96);
insert into BUSRIDE (busid, lineid, scheduleid)
values (200, 94, 167);
insert into BUSRIDE (busid, lineid, scheduleid)
values (313, 213, 308);
insert into BUSRIDE (busid, lineid, scheduleid)
values (229, 44, 266);
insert into BUSRIDE (busid, lineid, scheduleid)
values (137, 198, 105);
insert into BUSRIDE (busid, lineid, scheduleid)
values (218, 133, 171);
insert into BUSRIDE (busid, lineid, scheduleid)
values (400, 179, 98);
insert into BUSRIDE (busid, lineid, scheduleid)
values (138, 90, 333);
insert into BUSRIDE (busid, lineid, scheduleid)
values (294, 17, 52);
insert into BUSRIDE (busid, lineid, scheduleid)
values (178, 103, 96);
insert into BUSRIDE (busid, lineid, scheduleid)
values (152, 284, 109);
insert into BUSRIDE (busid, lineid, scheduleid)
values (245, 389, 204);
insert into BUSRIDE (busid, lineid, scheduleid)
values (116, 374, 261);
insert into BUSRIDE (busid, lineid, scheduleid)
values (247, 86, 302);
insert into BUSRIDE (busid, lineid, scheduleid)
values (377, 133, 298);
insert into BUSRIDE (busid, lineid, scheduleid)
values (104, 73, 50);
insert into BUSRIDE (busid, lineid, scheduleid)
values (305, 110, 77);
insert into BUSRIDE (busid, lineid, scheduleid)
values (135, 8, 217);
insert into BUSRIDE (busid, lineid, scheduleid)
values (153, 89, 218);
insert into BUSRIDE (busid, lineid, scheduleid)
values (293, 183, 356);
insert into BUSRIDE (busid, lineid, scheduleid)
values (214, 329, 24);
insert into BUSRIDE (busid, lineid, scheduleid)
values (376, 285, 326);
insert into BUSRIDE (busid, lineid, scheduleid)
values (379, 331, 143);
insert into BUSRIDE (busid, lineid, scheduleid)
values (359, 239, 112);
insert into BUSRIDE (busid, lineid, scheduleid)
values (225, 217, 126);
insert into BUSRIDE (busid, lineid, scheduleid)
values (112, 143, 65);
insert into BUSRIDE (busid, lineid, scheduleid)
values (87, 179, 302);
insert into BUSRIDE (busid, lineid, scheduleid)
values (106, 281, 330);
insert into BUSRIDE (busid, lineid, scheduleid)
values (377, 113, 109);
insert into BUSRIDE (busid, lineid, scheduleid)
values (165, 24, 194);
insert into BUSRIDE (busid, lineid, scheduleid)
values (323, 378, 144);
insert into BUSRIDE (busid, lineid, scheduleid)
values (265, 254, 308);
insert into BUSRIDE (busid, lineid, scheduleid)
values (277, 195, 23);
insert into BUSRIDE (busid, lineid, scheduleid)
values (320, 221, 293);
insert into BUSRIDE (busid, lineid, scheduleid)
values (49, 368, 82);
insert into BUSRIDE (busid, lineid, scheduleid)
values (311, 327, 124);
insert into BUSRIDE (busid, lineid, scheduleid)
values (229, 20, 399);
insert into BUSRIDE (busid, lineid, scheduleid)
values (222, 371, 141);
insert into BUSRIDE (busid, lineid, scheduleid)
values (270, 218, 227);
insert into BUSRIDE (busid, lineid, scheduleid)
values (86, 213, 187);
insert into BUSRIDE (busid, lineid, scheduleid)
values (397, 298, 308);
insert into BUSRIDE (busid, lineid, scheduleid)
values (181, 129, 234);
insert into BUSRIDE (busid, lineid, scheduleid)
values (251, 263, 361);
insert into BUSRIDE (busid, lineid, scheduleid)
values (373, 86, 342);
insert into BUSRIDE (busid, lineid, scheduleid)
values (150, 328, 200);
insert into BUSRIDE (busid, lineid, scheduleid)
values (309, 270, 3);
insert into BUSRIDE (busid, lineid, scheduleid)
values (221, 321, 272);
insert into BUSRIDE (busid, lineid, scheduleid)
values (93, 171, 332);
insert into BUSRIDE (busid, lineid, scheduleid)
values (215, 277, 112);
insert into BUSRIDE (busid, lineid, scheduleid)
values (86, 336, 379);
insert into BUSRIDE (busid, lineid, scheduleid)
values (227, 115, 79);
insert into BUSRIDE (busid, lineid, scheduleid)
values (265, 183, 332);
insert into BUSRIDE (busid, lineid, scheduleid)
values (361, 349, 327);
insert into BUSRIDE (busid, lineid, scheduleid)
values (160, 267, 267);
insert into BUSRIDE (busid, lineid, scheduleid)
values (139, 197, 286);
insert into BUSRIDE (busid, lineid, scheduleid)
values (197, 306, 358);
insert into BUSRIDE (busid, lineid, scheduleid)
values (259, 192, 53);
insert into BUSRIDE (busid, lineid, scheduleid)
values (289, 342, 186);
insert into BUSRIDE (busid, lineid, scheduleid)
values (269, 389, 192);
insert into BUSRIDE (busid, lineid, scheduleid)
values (261, 281, 249);
insert into BUSRIDE (busid, lineid, scheduleid)
values (40, 15, 218);
insert into BUSRIDE (busid, lineid, scheduleid)
values (237, 269, 33);
insert into BUSRIDE (busid, lineid, scheduleid)
values (198, 32, 189);
insert into BUSRIDE (busid, lineid, scheduleid)
values (104, 102, 43);
insert into BUSRIDE (busid, lineid, scheduleid)
values (382, 159, 157);
insert into BUSRIDE (busid, lineid, scheduleid)
values (118, 343, 14);
insert into BUSRIDE (busid, lineid, scheduleid)
values (288, 71, 375);
insert into BUSRIDE (busid, lineid, scheduleid)
values (57, 277, 242);
insert into BUSRIDE (busid, lineid, scheduleid)
values (67, 384, 65);
insert into BUSRIDE (busid, lineid, scheduleid)
values (6, 119, 317);
insert into BUSRIDE (busid, lineid, scheduleid)
values (57, 257, 28);
insert into BUSRIDE (busid, lineid, scheduleid)
values (399, 161, 375);
insert into BUSRIDE (busid, lineid, scheduleid)
values (220, 225, 9);
insert into BUSRIDE (busid, lineid, scheduleid)
values (313, 117, 374);
insert into BUSRIDE (busid, lineid, scheduleid)
values (101, 93, 150);
insert into BUSRIDE (busid, lineid, scheduleid)
values (18, 123, 369);
insert into BUSRIDE (busid, lineid, scheduleid)
values (188, 274, 375);
insert into BUSRIDE (busid, lineid, scheduleid)
values (135, 201, 263);
insert into BUSRIDE (busid, lineid, scheduleid)
values (353, 227, 228);
insert into BUSRIDE (busid, lineid, scheduleid)
values (153, 238, 129);
insert into BUSRIDE (busid, lineid, scheduleid)
values (65, 353, 324);
insert into BUSRIDE (busid, lineid, scheduleid)
values (88, 350, 117);
insert into BUSRIDE (busid, lineid, scheduleid)
values (337, 281, 43);
insert into BUSRIDE (busid, lineid, scheduleid)
values (142, 278, 35);
insert into BUSRIDE (busid, lineid, scheduleid)
values (209, 215, 157);
insert into BUSRIDE (busid, lineid, scheduleid)
values (220, 70, 291);
insert into BUSRIDE (busid, lineid, scheduleid)
values (27, 46, 248);
insert into BUSRIDE (busid, lineid, scheduleid)
values (255, 298, 366);
commit;
prompt 200 records committed...
insert into BUSRIDE (busid, lineid, scheduleid)
values (175, 150, 345);
insert into BUSRIDE (busid, lineid, scheduleid)
values (123, 366, 339);
insert into BUSRIDE (busid, lineid, scheduleid)
values (373, 232, 360);
insert into BUSRIDE (busid, lineid, scheduleid)
values (357, 376, 153);
insert into BUSRIDE (busid, lineid, scheduleid)
values (7, 137, 131);
insert into BUSRIDE (busid, lineid, scheduleid)
values (38, 305, 168);
insert into BUSRIDE (busid, lineid, scheduleid)
values (274, 293, 80);
insert into BUSRIDE (busid, lineid, scheduleid)
values (66, 207, 64);
insert into BUSRIDE (busid, lineid, scheduleid)
values (98, 307, 264);
insert into BUSRIDE (busid, lineid, scheduleid)
values (273, 305, 13);
insert into BUSRIDE (busid, lineid, scheduleid)
values (99, 115, 392);
insert into BUSRIDE (busid, lineid, scheduleid)
values (144, 126, 37);
insert into BUSRIDE (busid, lineid, scheduleid)
values (376, 372, 162);
insert into BUSRIDE (busid, lineid, scheduleid)
values (322, 386, 400);
insert into BUSRIDE (busid, lineid, scheduleid)
values (310, 95, 159);
insert into BUSRIDE (busid, lineid, scheduleid)
values (207, 37, 61);
insert into BUSRIDE (busid, lineid, scheduleid)
values (28, 169, 272);
insert into BUSRIDE (busid, lineid, scheduleid)
values (11, 105, 145);
insert into BUSRIDE (busid, lineid, scheduleid)
values (297, 197, 45);
insert into BUSRIDE (busid, lineid, scheduleid)
values (276, 35, 210);
insert into BUSRIDE (busid, lineid, scheduleid)
values (295, 389, 123);
insert into BUSRIDE (busid, lineid, scheduleid)
values (261, 204, 151);
insert into BUSRIDE (busid, lineid, scheduleid)
values (174, 310, 111);
insert into BUSRIDE (busid, lineid, scheduleid)
values (260, 202, 138);
insert into BUSRIDE (busid, lineid, scheduleid)
values (185, 231, 232);
insert into BUSRIDE (busid, lineid, scheduleid)
values (386, 123, 57);
insert into BUSRIDE (busid, lineid, scheduleid)
values (54, 295, 292);
insert into BUSRIDE (busid, lineid, scheduleid)
values (291, 354, 345);
insert into BUSRIDE (busid, lineid, scheduleid)
values (213, 52, 176);
insert into BUSRIDE (busid, lineid, scheduleid)
values (125, 382, 90);
insert into BUSRIDE (busid, lineid, scheduleid)
values (148, 244, 314);
insert into BUSRIDE (busid, lineid, scheduleid)
values (203, 222, 15);
insert into BUSRIDE (busid, lineid, scheduleid)
values (217, 357, 373);
insert into BUSRIDE (busid, lineid, scheduleid)
values (315, 178, 194);
insert into BUSRIDE (busid, lineid, scheduleid)
values (397, 348, 52);
insert into BUSRIDE (busid, lineid, scheduleid)
values (84, 252, 331);
insert into BUSRIDE (busid, lineid, scheduleid)
values (171, 197, 87);
insert into BUSRIDE (busid, lineid, scheduleid)
values (218, 233, 160);
insert into BUSRIDE (busid, lineid, scheduleid)
values (6, 283, 292);
insert into BUSRIDE (busid, lineid, scheduleid)
values (368, 102, 280);
insert into BUSRIDE (busid, lineid, scheduleid)
values (230, 122, 216);
insert into BUSRIDE (busid, lineid, scheduleid)
values (396, 211, 257);
insert into BUSRIDE (busid, lineid, scheduleid)
values (155, 121, 296);
insert into BUSRIDE (busid, lineid, scheduleid)
values (30, 14, 54);
insert into BUSRIDE (busid, lineid, scheduleid)
values (341, 146, 358);
insert into BUSRIDE (busid, lineid, scheduleid)
values (153, 140, 271);
insert into BUSRIDE (busid, lineid, scheduleid)
values (87, 65, 331);
insert into BUSRIDE (busid, lineid, scheduleid)
values (322, 349, 38);
insert into BUSRIDE (busid, lineid, scheduleid)
values (242, 87, 122);
insert into BUSRIDE (busid, lineid, scheduleid)
values (244, 183, 257);
insert into BUSRIDE (busid, lineid, scheduleid)
values (38, 31, 173);
insert into BUSRIDE (busid, lineid, scheduleid)
values (26, 262, 317);
insert into BUSRIDE (busid, lineid, scheduleid)
values (392, 132, 387);
insert into BUSRIDE (busid, lineid, scheduleid)
values (52, 359, 320);
insert into BUSRIDE (busid, lineid, scheduleid)
values (193, 160, 322);
insert into BUSRIDE (busid, lineid, scheduleid)
values (270, 200, 85);
insert into BUSRIDE (busid, lineid, scheduleid)
values (59, 387, 261);
insert into BUSRIDE (busid, lineid, scheduleid)
values (156, 388, 103);
insert into BUSRIDE (busid, lineid, scheduleid)
values (156, 294, 367);
insert into BUSRIDE (busid, lineid, scheduleid)
values (260, 203, 76);
insert into BUSRIDE (busid, lineid, scheduleid)
values (85, 262, 54);
insert into BUSRIDE (busid, lineid, scheduleid)
values (73, 246, 336);
insert into BUSRIDE (busid, lineid, scheduleid)
values (309, 90, 222);
insert into BUSRIDE (busid, lineid, scheduleid)
values (195, 88, 14);
insert into BUSRIDE (busid, lineid, scheduleid)
values (384, 257, 214);
insert into BUSRIDE (busid, lineid, scheduleid)
values (301, 197, 100);
insert into BUSRIDE (busid, lineid, scheduleid)
values (146, 7, 73);
insert into BUSRIDE (busid, lineid, scheduleid)
values (109, 104, 2);
insert into BUSRIDE (busid, lineid, scheduleid)
values (283, 396, 334);
insert into BUSRIDE (busid, lineid, scheduleid)
values (258, 312, 352);
insert into BUSRIDE (busid, lineid, scheduleid)
values (354, 261, 153);
insert into BUSRIDE (busid, lineid, scheduleid)
values (309, 325, 36);
insert into BUSRIDE (busid, lineid, scheduleid)
values (343, 71, 393);
insert into BUSRIDE (busid, lineid, scheduleid)
values (228, 19, 390);
insert into BUSRIDE (busid, lineid, scheduleid)
values (337, 143, 3);
insert into BUSRIDE (busid, lineid, scheduleid)
values (353, 386, 371);
insert into BUSRIDE (busid, lineid, scheduleid)
values (399, 152, 125);
insert into BUSRIDE (busid, lineid, scheduleid)
values (313, 303, 393);
insert into BUSRIDE (busid, lineid, scheduleid)
values (150, 231, 113);
insert into BUSRIDE (busid, lineid, scheduleid)
values (36, 12, 331);
insert into BUSRIDE (busid, lineid, scheduleid)
values (238, 314, 88);
insert into BUSRIDE (busid, lineid, scheduleid)
values (311, 100, 103);
insert into BUSRIDE (busid, lineid, scheduleid)
values (334, 79, 214);
insert into BUSRIDE (busid, lineid, scheduleid)
values (326, 150, 77);
insert into BUSRIDE (busid, lineid, scheduleid)
values (258, 243, 116);
insert into BUSRIDE (busid, lineid, scheduleid)
values (107, 104, 202);
insert into BUSRIDE (busid, lineid, scheduleid)
values (24, 99, 118);
insert into BUSRIDE (busid, lineid, scheduleid)
values (322, 172, 329);
insert into BUSRIDE (busid, lineid, scheduleid)
values (328, 277, 143);
insert into BUSRIDE (busid, lineid, scheduleid)
values (306, 132, 242);
insert into BUSRIDE (busid, lineid, scheduleid)
values (227, 48, 362);
insert into BUSRIDE (busid, lineid, scheduleid)
values (380, 324, 369);
insert into BUSRIDE (busid, lineid, scheduleid)
values (391, 332, 68);
insert into BUSRIDE (busid, lineid, scheduleid)
values (94, 264, 282);
insert into BUSRIDE (busid, lineid, scheduleid)
values (28, 213, 371);
insert into BUSRIDE (busid, lineid, scheduleid)
values (64, 316, 304);
insert into BUSRIDE (busid, lineid, scheduleid)
values (32, 77, 251);
insert into BUSRIDE (busid, lineid, scheduleid)
values (244, 100, 290);
insert into BUSRIDE (busid, lineid, scheduleid)
values (29, 312, 382);
insert into BUSRIDE (busid, lineid, scheduleid)
values (82, 231, 117);
commit;
prompt 300 records committed...
insert into BUSRIDE (busid, lineid, scheduleid)
values (349, 212, 323);
insert into BUSRIDE (busid, lineid, scheduleid)
values (72, 157, 266);
insert into BUSRIDE (busid, lineid, scheduleid)
values (186, 12, 251);
insert into BUSRIDE (busid, lineid, scheduleid)
values (266, 22, 104);
insert into BUSRIDE (busid, lineid, scheduleid)
values (356, 399, 77);
insert into BUSRIDE (busid, lineid, scheduleid)
values (43, 346, 140);
insert into BUSRIDE (busid, lineid, scheduleid)
values (132, 266, 388);
insert into BUSRIDE (busid, lineid, scheduleid)
values (135, 394, 197);
insert into BUSRIDE (busid, lineid, scheduleid)
values (246, 314, 343);
insert into BUSRIDE (busid, lineid, scheduleid)
values (249, 154, 209);
insert into BUSRIDE (busid, lineid, scheduleid)
values (168, 389, 130);
insert into BUSRIDE (busid, lineid, scheduleid)
values (325, 348, 199);
insert into BUSRIDE (busid, lineid, scheduleid)
values (351, 367, 206);
insert into BUSRIDE (busid, lineid, scheduleid)
values (243, 60, 154);
insert into BUSRIDE (busid, lineid, scheduleid)
values (396, 261, 207);
insert into BUSRIDE (busid, lineid, scheduleid)
values (18, 355, 206);
insert into BUSRIDE (busid, lineid, scheduleid)
values (327, 343, 267);
insert into BUSRIDE (busid, lineid, scheduleid)
values (253, 229, 11);
insert into BUSRIDE (busid, lineid, scheduleid)
values (388, 379, 15);
insert into BUSRIDE (busid, lineid, scheduleid)
values (36, 268, 260);
insert into BUSRIDE (busid, lineid, scheduleid)
values (390, 339, 116);
insert into BUSRIDE (busid, lineid, scheduleid)
values (274, 198, 143);
insert into BUSRIDE (busid, lineid, scheduleid)
values (258, 156, 131);
insert into BUSRIDE (busid, lineid, scheduleid)
values (161, 321, 301);
insert into BUSRIDE (busid, lineid, scheduleid)
values (154, 27, 299);
insert into BUSRIDE (busid, lineid, scheduleid)
values (51, 193, 162);
insert into BUSRIDE (busid, lineid, scheduleid)
values (126, 173, 213);
insert into BUSRIDE (busid, lineid, scheduleid)
values (124, 130, 58);
insert into BUSRIDE (busid, lineid, scheduleid)
values (271, 25, 374);
insert into BUSRIDE (busid, lineid, scheduleid)
values (243, 20, 78);
insert into BUSRIDE (busid, lineid, scheduleid)
values (263, 195, 95);
insert into BUSRIDE (busid, lineid, scheduleid)
values (235, 240, 160);
insert into BUSRIDE (busid, lineid, scheduleid)
values (230, 8, 314);
insert into BUSRIDE (busid, lineid, scheduleid)
values (3, 339, 207);
insert into BUSRIDE (busid, lineid, scheduleid)
values (276, 54, 26);
insert into BUSRIDE (busid, lineid, scheduleid)
values (99, 142, 289);
insert into BUSRIDE (busid, lineid, scheduleid)
values (144, 335, 261);
insert into BUSRIDE (busid, lineid, scheduleid)
values (245, 63, 116);
insert into BUSRIDE (busid, lineid, scheduleid)
values (234, 205, 81);
insert into BUSRIDE (busid, lineid, scheduleid)
values (376, 297, 273);
insert into BUSRIDE (busid, lineid, scheduleid)
values (33, 42, 97);
insert into BUSRIDE (busid, lineid, scheduleid)
values (37, 126, 144);
insert into BUSRIDE (busid, lineid, scheduleid)
values (316, 63, 62);
insert into BUSRIDE (busid, lineid, scheduleid)
values (244, 284, 127);
insert into BUSRIDE (busid, lineid, scheduleid)
values (271, 145, 19);
insert into BUSRIDE (busid, lineid, scheduleid)
values (3, 325, 364);
insert into BUSRIDE (busid, lineid, scheduleid)
values (46, 325, 147);
insert into BUSRIDE (busid, lineid, scheduleid)
values (123, 35, 354);
insert into BUSRIDE (busid, lineid, scheduleid)
values (88, 134, 202);
insert into BUSRIDE (busid, lineid, scheduleid)
values (350, 86, 344);
insert into BUSRIDE (busid, lineid, scheduleid)
values (311, 385, 181);
insert into BUSRIDE (busid, lineid, scheduleid)
values (113, 40, 298);
insert into BUSRIDE (busid, lineid, scheduleid)
values (399, 390, 122);
insert into BUSRIDE (busid, lineid, scheduleid)
values (31, 85, 355);
insert into BUSRIDE (busid, lineid, scheduleid)
values (243, 51, 82);
insert into BUSRIDE (busid, lineid, scheduleid)
values (295, 107, 77);
insert into BUSRIDE (busid, lineid, scheduleid)
values (55, 196, 236);
insert into BUSRIDE (busid, lineid, scheduleid)
values (35, 145, 392);
insert into BUSRIDE (busid, lineid, scheduleid)
values (332, 63, 258);
insert into BUSRIDE (busid, lineid, scheduleid)
values (372, 360, 79);
insert into BUSRIDE (busid, lineid, scheduleid)
values (369, 290, 377);
insert into BUSRIDE (busid, lineid, scheduleid)
values (325, 146, 257);
insert into BUSRIDE (busid, lineid, scheduleid)
values (72, 22, 286);
insert into BUSRIDE (busid, lineid, scheduleid)
values (181, 245, 144);
insert into BUSRIDE (busid, lineid, scheduleid)
values (46, 227, 171);
insert into BUSRIDE (busid, lineid, scheduleid)
values (27, 384, 62);
insert into BUSRIDE (busid, lineid, scheduleid)
values (103, 39, 178);
insert into BUSRIDE (busid, lineid, scheduleid)
values (352, 244, 229);
insert into BUSRIDE (busid, lineid, scheduleid)
values (339, 90, 41);
insert into BUSRIDE (busid, lineid, scheduleid)
values (169, 298, 208);
insert into BUSRIDE (busid, lineid, scheduleid)
values (142, 109, 268);
insert into BUSRIDE (busid, lineid, scheduleid)
values (59, 258, 70);
insert into BUSRIDE (busid, lineid, scheduleid)
values (369, 221, 278);
insert into BUSRIDE (busid, lineid, scheduleid)
values (385, 213, 5);
insert into BUSRIDE (busid, lineid, scheduleid)
values (76, 112, 248);
insert into BUSRIDE (busid, lineid, scheduleid)
values (129, 355, 237);
insert into BUSRIDE (busid, lineid, scheduleid)
values (242, 327, 175);
insert into BUSRIDE (busid, lineid, scheduleid)
values (283, 11, 169);
insert into BUSRIDE (busid, lineid, scheduleid)
values (108, 250, 383);
insert into BUSRIDE (busid, lineid, scheduleid)
values (245, 56, 298);
insert into BUSRIDE (busid, lineid, scheduleid)
values (90, 200, 87);
insert into BUSRIDE (busid, lineid, scheduleid)
values (290, 379, 175);
insert into BUSRIDE (busid, lineid, scheduleid)
values (327, 231, 44);
insert into BUSRIDE (busid, lineid, scheduleid)
values (334, 50, 294);
insert into BUSRIDE (busid, lineid, scheduleid)
values (65, 32, 214);
insert into BUSRIDE (busid, lineid, scheduleid)
values (78, 351, 307);
insert into BUSRIDE (busid, lineid, scheduleid)
values (187, 396, 380);
insert into BUSRIDE (busid, lineid, scheduleid)
values (257, 299, 233);
insert into BUSRIDE (busid, lineid, scheduleid)
values (28, 367, 374);
insert into BUSRIDE (busid, lineid, scheduleid)
values (370, 191, 369);
insert into BUSRIDE (busid, lineid, scheduleid)
values (80, 106, 71);
insert into BUSRIDE (busid, lineid, scheduleid)
values (86, 243, 2);
insert into BUSRIDE (busid, lineid, scheduleid)
values (151, 243, 362);
insert into BUSRIDE (busid, lineid, scheduleid)
values (48, 323, 304);
insert into BUSRIDE (busid, lineid, scheduleid)
values (84, 387, 382);
insert into BUSRIDE (busid, lineid, scheduleid)
values (113, 63, 214);
insert into BUSRIDE (busid, lineid, scheduleid)
values (172, 193, 167);
insert into BUSRIDE (busid, lineid, scheduleid)
values (151, 377, 97);
insert into BUSRIDE (busid, lineid, scheduleid)
values (254, 346, 260);
insert into BUSRIDE (busid, lineid, scheduleid)
values (245, 91, 191);
commit;
prompt 400 records loaded
prompt Loading DRIVER...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (1, 'Travers McGrane', '3476-8840-8675', to_date('31-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (2, 'Antonin Fominov', '9517-1392-5878', to_date('18-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (3, 'Gracia Pamplin', '3170-9041-2787', to_date('27-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (4, 'Adele Brozsset', '3225-3617-6123', to_date('26-02-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (5, 'Cosette Swinnard', '0048-0764-5397', to_date('12-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (6, 'Hermon Ascraft', '4095-8246-9689', to_date('24-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (7, 'Glynnis Strase', '0709-3537-7335', to_date('13-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (8, 'Zsazsa Elkington', '8401-4035-3911', to_date('19-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (9, 'Noble Logie', '7810-2427-3690', to_date('09-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (10, 'Findley Ullett', '6662-6916-3131', to_date('23-11-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (11, 'Antoinette Smithies', '2278-6382-0233', to_date('25-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (12, 'Janna Leteurtre', '7802-8741-4144', to_date('18-01-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (13, 'Mack Degue', '1789-1390-9666', to_date('15-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (14, 'Colene Ivers', '1475-4460-4561', to_date('15-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (15, 'Boyce Klehyn', '5844-1319-7877', to_date('24-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (16, 'Jeffy Tomkiss', '3324-4416-6001', to_date('30-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (17, 'Goldina Ingleby', '2754-1605-8076', to_date('20-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (18, 'Mahmoud Scargill', '7599-0049-8120', to_date('14-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (19, 'Jana Offield', '5874-0787-0954', to_date('06-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (20, 'Rolland Laughlan', '4427-0231-9484', to_date('05-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (21, 'Donetta Wartonby', '6066-1880-6547', to_date('28-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (22, 'Maurise O''Dee', '8170-1374-1332', to_date('14-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (23, 'Luisa Tout', '6418-3300-4601', to_date('11-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (24, 'Sadye Souch', '6716-0774-2671', to_date('10-12-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (25, 'Ophelia Tappington', '6523-6988-8162', to_date('05-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (26, 'Tiff Grimshaw', '5494-8699-9634', to_date('21-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (27, 'Ivory Shyres', '7646-2715-2349', to_date('09-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (28, 'Mortimer Concannon', '0000-4829-3078', to_date('08-07-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (29, 'Garland MacDougall', '6365-8766-3641', to_date('06-07-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (30, 'Rex Wildbore', '9094-8145-1849', to_date('17-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (31, 'Currie Yerby', '8215-8808-3207', to_date('03-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (32, 'Cory Willshee', '9356-7518-9301', to_date('23-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (33, 'Julee Noot', '7824-7467-8820', to_date('10-01-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (34, 'Gawen Larking', '6405-4254-8187', to_date('28-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (35, 'Golda Madgwick', '2898-0306-3630', to_date('04-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (36, 'Clem Slaight', '1320-3052-9573', to_date('13-07-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (37, 'Estrella Cave', '4464-0872-6054', to_date('25-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (38, 'Russell Tingly', '5355-6003-6793', to_date('11-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (39, 'Tanney Groombridge', '9850-0666-1488', to_date('13-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (40, 'Amara Littlepage', '2200-0691-5696', to_date('15-08-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (41, 'Maurie Letcher', '4835-0439-0742', to_date('23-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (42, 'Dennison Atwell', '2001-3701-8707', to_date('06-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (43, 'Jeannie Frayling', '9044-1799-6150', to_date('07-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (44, 'Charmain Barreau', '9072-0017-9841', to_date('03-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (45, 'Raul Glowach', '0628-5679-1914', to_date('15-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (46, 'Cathrin Shugg', '2742-5808-0217', to_date('28-07-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (47, 'Valry Buffy', '2632-3157-9253', to_date('10-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (48, 'Blondy Grishenkov', '6625-6088-7986', to_date('04-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (49, 'Roxine Rominov', '5945-4541-8062', to_date('23-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (50, 'Martica Vankin', '7303-3522-1306', to_date('24-07-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (51, 'Bernie Clemens', '2117-2818-6126', to_date('07-07-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (52, 'Natal Bein', '2048-1420-9753', to_date('20-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (53, 'Dorris Tebbut', '4237-6613-2202', to_date('18-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (54, 'Gradeigh Hickinbottom', '1711-3960-9665', to_date('05-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (55, 'Nessa O''Canavan', '2073-2618-8530', to_date('16-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (56, 'Timmy Cassely', '8500-5410-4758', to_date('31-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (57, 'Drusy Risborough', '1086-9939-3026', to_date('24-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (58, 'Farr Inns', '7723-8906-6905', to_date('10-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (59, 'Arnuad Paradine', '2795-9146-5885', to_date('17-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (60, 'Sharyl Schoenrock', '6246-4757-1408', to_date('25-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (61, 'Cara Stile', '9246-5043-3370', to_date('29-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (62, 'Bevin Lafflina', '8572-0380-9112', to_date('20-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (63, 'Barde Lerwill', '5111-5318-5866', to_date('05-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (64, 'Hill Keller', '8393-3482-4955', to_date('09-07-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (65, 'Any Ellph', '8610-4775-2263', to_date('06-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (66, 'Kalvin Skitral', '4078-6629-0095', to_date('11-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (67, 'Robinia Di Pietro', '3718-0527-3486', to_date('18-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (68, 'Derril Cheson', '6670-2944-6326', to_date('09-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (69, 'Benny Southall', '1444-7306-0780', to_date('30-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (70, 'Meredith Petteford', '5504-7401-7496', to_date('07-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (71, 'Estell Roobottom', '8785-1575-4720', to_date('15-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (72, 'Dilly Decourt', '9785-0621-8479', to_date('20-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (73, 'Bebe Pardy', '7047-2878-9068', to_date('14-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (74, 'Scotti McPhelimy', '5943-1955-9803', to_date('03-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (75, 'Winne Sullens', '4652-2146-1216', to_date('11-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (76, 'Torr Shimon', '3825-2778-7334', to_date('02-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (77, 'Marlene Paszak', '8447-3868-5888', to_date('26-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (78, 'Berta Hathwood', '4927-0095-0824', to_date('03-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (79, 'Editha Farrent', '0651-0294-6461', to_date('29-01-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (80, 'Brade Margrie', '0591-0345-4098', to_date('16-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (81, 'Walt Baumaier', '9259-8908-3095', to_date('08-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (82, 'Briano Abate', '3112-4008-4128', to_date('17-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (83, 'Vidovik Raffeorty', '1849-1351-5515', to_date('29-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (84, 'Elliott Zylbermann', '5126-3555-7829', to_date('13-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (85, 'Randa Hurlin', '8649-4926-9135', to_date('10-07-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (86, 'Sashenka Sommerly', '5242-0113-1673', to_date('08-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (87, 'Dyana Rastall', '1915-7010-7742', to_date('07-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (88, 'Shurlock Glaister', '0639-2933-5341', to_date('29-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (89, 'Velvet Bricknell', '1221-1127-3341', to_date('17-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (90, 'Brynna Simons', '7572-6007-6251', to_date('12-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (91, 'Bunny Burth', '2680-5451-7067', to_date('27-02-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (92, 'Lavinia Biskupek', '1768-2314-0508', to_date('22-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (93, 'Mira Verheyden', '2233-9997-2795', to_date('10-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (94, 'Tamara Arkow', '3621-3256-0329', to_date('12-07-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (95, 'Teri Thornewell', '1050-3677-8509', to_date('08-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (96, 'Hamnet Goulstone', '8597-3788-3495', to_date('05-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (97, 'Cally Klaessen', '2286-8951-9567', to_date('05-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (98, 'Deane Crisp', '2048-0439-7881', to_date('11-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (99, 'Rosene Coppard', '6652-3257-0683', to_date('27-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (100, 'Dalt Wadmore', '3620-1447-0465', to_date('05-09-2021', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (101, 'Cesare Westman', '9366-3945-0470', to_date('14-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (102, 'Antonius Djakovic', '1058-0970-8930', to_date('09-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (103, 'Ricardo Stuckey', '7151-3698-4637', to_date('30-12-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (104, 'Bridie Golthorpp', '1784-1019-1398', to_date('04-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (105, 'Morse Skermer', '6328-0304-7696', to_date('08-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (106, 'Alberto Ghioni', '7354-1260-1486', to_date('02-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (107, 'Erina Stoade', '4354-6028-7219', to_date('13-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (108, 'Kaylyn Marchant', '0234-5079-2540', to_date('07-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (109, 'Alica Hawse', '3975-0294-7327', to_date('27-04-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (110, 'Pattie Patifield', '1734-3008-2407', to_date('11-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (111, 'Ezekiel Crew', '4328-7989-5333', to_date('20-02-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (112, 'Ede Sifleet', '7047-5352-6646', to_date('05-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (113, 'Stavro Beere', '8637-9010-5634', to_date('15-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (114, 'Celle Bassford', '5478-8860-7511', to_date('02-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (115, 'Delmar Wiburn', '7346-4903-1736', to_date('06-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (116, 'Simone Hanks', '4609-0727-1411', to_date('28-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (117, 'Huberto Verrico', '5092-5166-5761', to_date('05-01-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (118, 'Marten MacCall', '4985-2438-1083', to_date('12-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (119, 'Mathilda Leglise', '7151-1201-1999', to_date('26-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (120, 'Parry Rasor', '7697-4349-2090', to_date('25-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (121, 'Bent Worts', '9917-2412-4978', to_date('17-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (122, 'Wynnie Kingsbury', '8738-3425-4283', to_date('16-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (123, 'Daloris Sedger', '1272-8268-7249', to_date('25-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (124, 'Alistair Hanny', '9939-2518-7578', to_date('07-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (125, 'Etan Kezourec', '1918-1853-4685', to_date('17-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (126, 'Roxane Broomhead', '3921-1801-6859', to_date('30-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (127, 'Candida Thornley', '1846-2308-3864', to_date('09-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (128, 'Rhody Jorck', '4874-4397-9685', to_date('13-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (129, 'Clint Kitteridge', '7258-1037-5517', to_date('10-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (130, 'Agnese Lofty', '9165-7444-5830', to_date('25-07-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (131, 'Gusta Byron', '3491-7823-4005', to_date('05-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (132, 'Gordy Corbould', '9544-6068-9589', to_date('07-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (133, 'Ludwig Avrahamov', '1855-0688-6894', to_date('28-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (134, 'Glyn Martonfi', '1102-2034-7245', to_date('12-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (135, 'Garv McArley', '5784-2446-0968', to_date('02-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (136, 'Van Erwin', '9841-9199-9469', to_date('10-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (137, 'Zelma Insley', '8032-5750-7655', to_date('18-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (138, 'Jorey Bird', '7675-7950-2860', to_date('26-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (139, 'Antonina Gavin', '2000-8705-1960', to_date('27-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (140, 'Niko Helm', '8319-1125-6153', to_date('10-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (141, 'Waneta Zimmermanns', '1877-5129-6159', to_date('22-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (142, 'Valera Wickwar', '4358-4634-6779', to_date('18-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (143, 'Hillie Brownbridge', '5497-7084-4430', to_date('15-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (144, 'Helaine Huckett', '1384-2078-0136', to_date('02-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (145, 'Genny Tulloch', '4430-2799-0769', to_date('01-05-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (146, 'Gideon Doornbos', '6468-8530-0954', to_date('18-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (147, 'Carley Mawer', '2648-9611-1088', to_date('04-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (148, 'Mathe Calverd', '2509-8908-8887', to_date('18-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (149, 'Sauveur Greensitt', '8246-1833-3578', to_date('24-02-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (150, 'Lindie Hendren', '1397-6119-6463', to_date('26-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (151, 'Yves Snape', '3799-2707-2113', to_date('24-01-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (152, 'Cammy Blincko', '6920-9302-8905', to_date('12-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (153, 'Alanah Dagger', '4365-6134-5977', to_date('05-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (154, 'Chase Genders', '2072-0262-2993', to_date('07-02-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (155, 'Calli Brabban', '8240-4455-6058', to_date('20-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (156, 'Almeria Gornall', '2604-6552-4657', to_date('09-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (157, 'Waneta Boardman', '9056-8580-0880', to_date('26-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (158, 'Sheila Schoroder', '7349-8744-7852', to_date('05-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (159, 'Beatrix Khristyukhin', '1057-1211-7687', to_date('06-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (160, 'Courtnay Eles', '5904-1100-4217', to_date('25-03-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (161, 'Derry Villa', '6274-8104-9886', to_date('18-11-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (162, 'Lenna Skerm', '7631-7588-3321', to_date('25-03-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (163, 'Lisbeth Bendin', '3166-2348-2753', to_date('13-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (164, 'Vidovic Durden', '2451-0346-7414', to_date('20-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (165, 'Kareem Pearman', '4401-1042-0760', to_date('22-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (166, 'Phyllis Jinks', '9181-3225-5345', to_date('16-07-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (167, 'Shay Robinson', '4260-3411-0028', to_date('08-02-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (168, 'Ursa Schwieso', '5073-5473-0845', to_date('20-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (169, 'Ardeen Meth', '9735-7956-6694', to_date('04-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (170, 'Galven Netti', '7544-0650-4194', to_date('15-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (171, 'Darren Scarlin', '8343-7554-0826', to_date('26-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (172, 'Timi Fagan', '9407-3116-5844', to_date('14-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (173, 'Gusella Merrgen', '3257-1722-7417', to_date('28-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (174, 'Biddy Carnall', '1683-4621-9685', to_date('10-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (175, 'Maisie Olsen', '6913-0771-5989', to_date('05-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (176, 'Aldric Carette', '5749-0781-8062', to_date('04-09-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (177, 'Oren Marsy', '6698-5501-6450', to_date('09-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (178, 'Alejandra Gooddie', '0223-9491-2456', to_date('06-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (179, 'Cleopatra Belone', '4366-1860-1544', to_date('04-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (180, 'Wendall Giorgeschi', '2344-8209-1001', to_date('16-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (181, 'Flossi Stepto', '4625-9693-1031', to_date('15-05-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (182, 'Suzanna Yurygyn', '3996-5593-4528', to_date('08-08-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (183, 'Catie Novak', '6255-0167-3704', to_date('22-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (184, 'Morissa Brugger', '7428-2734-4433', to_date('04-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (185, 'Brion Brimblecombe', '2267-4424-6402', to_date('08-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (186, 'Cherianne Nehl', '9873-9372-0855', to_date('23-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (187, 'Lilias Rymour', '5777-8062-6697', to_date('16-01-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (188, 'Bambi Leftly', '6910-5379-7553', to_date('18-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (189, 'Nickolas Fer', '7385-2629-8980', to_date('26-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (190, 'Dulcia Shillington', '4652-6750-0864', to_date('23-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (191, 'Christye Fredson', '7141-1704-0653', to_date('20-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (192, 'Curt Upsale', '0857-8973-9330', to_date('30-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (193, 'Jorry McCrory', '0923-8855-7641', to_date('21-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (194, 'Alvy Rawlyns', '0775-6813-2224', to_date('07-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (195, 'Austen Carlsson', '6286-6650-1270', to_date('14-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (196, 'Michele Dicey', '7974-8720-1760', to_date('13-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (197, 'Waverly Joseph', '4338-5426-1563', to_date('23-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (198, 'Sheila Delatour', '5669-3433-8139', to_date('03-12-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (199, 'Farrah Bracknall', '0474-2332-3178', to_date('24-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (200, 'Robinia Blundon', '9984-0992-9395', to_date('28-02-2022', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (201, 'Lanita Maxsted', '0100-0905-6712', to_date('16-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (202, 'Joaquin Duckers', '3861-0428-3800', to_date('26-07-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (203, 'Phebe Trencher', '9512-0448-6726', to_date('15-03-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (204, 'Aurora Dohmann', '5716-5068-6000', to_date('11-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (205, 'Ethelind McGrah', '1359-3538-1970', to_date('19-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (206, 'Grata Topham', '6615-0456-5327', to_date('26-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (207, 'Zach Geaveny', '2870-0556-9190', to_date('29-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (208, 'Fredra Kennefick', '6731-7208-9835', to_date('09-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (209, 'Anders Skate', '7593-1183-0255', to_date('26-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (210, 'Rikki Wonter', '3252-7688-8094', to_date('12-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (211, 'Collete Prinnett', '8123-6995-0743', to_date('28-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (212, 'Frederich Anespie', '6057-3041-0358', to_date('08-05-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (213, 'Winny Burwood', '2467-6318-4487', to_date('17-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (214, 'Morna Coppenhall', '4643-3499-4333', to_date('06-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (215, 'Bryant Hardage', '2627-6997-2048', to_date('01-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (216, 'Nita Godly', '0137-3389-2335', to_date('27-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (217, 'Caril Upward', '6510-0696-6585', to_date('25-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (218, 'Raimund Give', '9883-3925-2801', to_date('16-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (219, 'Melisse MacKinnon', '3737-8450-9097', to_date('03-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (220, 'Shalna O''Mullaney', '5106-7206-5352', to_date('05-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (221, 'Fons Brough', '0321-6849-3021', to_date('18-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (222, 'Anabella Eusden', '8368-1278-3663', to_date('14-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (223, 'Shepard Spratt', '2945-4401-5638', to_date('13-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (224, 'Robena Fedorski', '2251-2831-9601', to_date('15-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (225, 'Ferdinanda Coundley', '7069-9999-5481', to_date('30-08-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (226, 'Rheba Davidde', '8108-1588-3805', to_date('15-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (227, 'Tess Perford', '1728-2665-3315', to_date('13-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (228, 'Ave Summersett', '6580-0921-1039', to_date('02-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (229, 'Ardath Mallatratt', '8648-9006-8935', to_date('29-01-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (230, 'Bartolemo Gallear', '5733-3790-9585', to_date('12-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (231, 'Gradey Darkin', '7117-7233-3503', to_date('20-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (232, 'Emelen Daveren', '3921-9221-6997', to_date('18-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (233, 'Rozella Bewick', '8220-9543-2725', to_date('06-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (234, 'Florentia Labbe', '3059-7514-9128', to_date('12-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (235, 'Dag Ginglell', '7235-5322-2014', to_date('24-02-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (236, 'Dotti Sterrie', '4096-7390-5254', to_date('24-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (237, 'Jillayne Loder', '9737-0493-8735', to_date('15-11-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (238, 'Juliette Mougel', '7618-9424-1529', to_date('08-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (239, 'Calypso Kuscha', '1389-2349-1264', to_date('19-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (240, 'Victoria Hassekl', '4836-4034-7130', to_date('05-03-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (241, 'Marilin Da Costa', '5718-3578-3553', to_date('03-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (242, 'Maynord Atty', '7650-3174-3382', to_date('28-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (243, 'Jonathan Capell', '5355-1682-4593', to_date('07-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (244, 'Barbe Farres', '3942-0148-2735', to_date('20-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (245, 'Sandor Foster', '6248-8912-5841', to_date('02-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (246, 'Carlyle Hornung', '9765-9639-7526', to_date('11-07-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (247, 'Alana Warrington', '6892-5955-1880', to_date('17-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (248, 'Lincoln Barroux', '6779-5870-7673', to_date('30-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (249, 'Mariya Zanettini', '9207-9445-9028', to_date('09-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (250, 'Adelina Rolph', '9215-3087-6528', to_date('11-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (251, 'Sebastian Gurrado', '7497-2564-4194', to_date('10-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (252, 'Melli Arnau', '1930-4340-7380', to_date('21-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (253, 'Sutherland Roggero', '8192-2371-1452', to_date('07-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (254, 'Rodger Wrangle', '2876-6523-3700', to_date('24-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (255, 'Stearn Cotterel', '0945-2844-3864', to_date('19-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (256, 'Zilvia Colgrave', '9715-4575-4363', to_date('17-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (257, 'Yardley Pursey', '7071-3079-0342', to_date('13-02-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (258, 'Dyna Dorton', '9511-0487-0315', to_date('21-07-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (259, 'Cornelia Downgate', '5826-8276-7139', to_date('16-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (260, 'Bryce Smitherman', '4843-3777-5302', to_date('31-07-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (261, 'Devi Knuckles', '4839-4365-7972', to_date('22-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (262, 'Camille Von Gladbach', '5865-6804-4989', to_date('14-01-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (263, 'Alfy Dax', '5036-6229-8176', to_date('13-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (264, 'Desdemona Durbin', '2097-2296-3772', to_date('02-06-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (265, 'Reggy Suter', '5903-0959-3987', to_date('06-09-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (266, 'Kent Swatten', '8810-9122-6706', to_date('30-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (267, 'Maxy Roullier', '0507-1194-5043', to_date('22-09-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (268, 'Nikolaos Onion', '4635-6592-0169', to_date('13-11-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (269, 'Jobye Brachell', '6618-6194-9941', to_date('25-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (270, 'Rosanne Vennings', '3366-1779-2142', to_date('24-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (271, 'Orson Dobell', '5547-8922-7063', to_date('07-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (272, 'Madeleine Abdey', '9684-4988-8867', to_date('28-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (273, 'Lothaire Thwaite', '4668-8370-2713', to_date('14-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (274, 'Delila Lightoller', '1750-5009-9559', to_date('01-12-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (275, 'Deb Goodbourn', '6423-4493-3314', to_date('23-02-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (276, 'Marcel Ladds', '8581-6732-6451', to_date('19-08-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (277, 'Niven Roddick', '0176-0091-0162', to_date('15-04-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (278, 'Cristabel Seligson', '3866-9170-3722', to_date('17-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (279, 'Judie Seagrove', '9319-2555-0236', to_date('22-03-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (280, 'Gaynor Hellings', '9779-6714-5566', to_date('20-01-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (281, 'Rhetta Osborn', '3020-0496-4270', to_date('19-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (282, 'Leupold Guildford', '2861-5985-2967', to_date('08-02-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (283, 'Sadie Alloisi', '8340-7356-5507', to_date('24-11-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (284, 'Teena Wenn', '3642-8196-1820', to_date('11-09-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (285, 'Dyan Marran', '6085-4138-7990', to_date('26-07-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (286, 'Lyndsie Batkin', '9126-5956-8776', to_date('07-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (287, 'Ilise Ducarne', '8836-0710-5243', to_date('27-02-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (288, 'Maye Bending', '5921-0440-7411', to_date('05-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (289, 'Claiborne Winman', '7869-3573-6346', to_date('21-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (290, 'Melitta Danshin', '0994-2294-7778', to_date('15-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (291, 'Vale Croysdale', '3753-9931-6899', to_date('14-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (292, 'Thain Guage', '4265-1565-7212', to_date('19-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (293, 'Chiarra Gilder', '5008-1210-0925', to_date('08-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (294, 'Jorie Jacobssen', '9939-5672-6382', to_date('15-06-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (295, 'Hadlee Falshaw', '4982-3515-0181', to_date('10-07-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (296, 'Powell Richie', '0877-1926-2142', to_date('17-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (297, 'Julita Skirrow', '5146-0244-9532', to_date('27-07-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (298, 'Sid Giovanitti', '5265-9668-3800', to_date('10-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (299, 'Agosto Tingle', '1035-2475-0380', to_date('31-01-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (300, 'Dexter Barniss', '9482-7914-0543', to_date('24-02-2020', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (301, 'Mikkel Lavalde', '8458-5132-8446', to_date('21-08-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (302, 'Dacie McLleese', '3089-2739-0940', to_date('09-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (303, 'Bessy Hew', '3215-3238-1151', to_date('03-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (304, 'Alyssa Laviss', '4237-5216-0995', to_date('14-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (305, 'Sibella Tregea', '3741-1038-0700', to_date('21-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (306, 'Ewell Erskine', '1546-3336-3651', to_date('25-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (307, 'Filberte Mc Caghan', '6414-9812-0390', to_date('04-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (308, 'Georgetta McGann', '6536-7560-4810', to_date('29-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (309, 'Loleta MacDowall', '6861-4979-1347', to_date('04-04-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (310, 'Rudie Saggs', '3555-4049-4621', to_date('27-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (311, 'Elladine Dilleston', '0216-6996-3493', to_date('02-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (312, 'Tanner Beedham', '2673-2632-5100', to_date('15-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (313, 'Eunice MacChaell', '9487-0145-0617', to_date('25-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (314, 'Jermayne Glen', '9477-6637-5008', to_date('18-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (315, 'Francene Winning', '9355-5001-6774', to_date('10-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (316, 'Rabi Vasyutkin', '0387-9539-6856', to_date('09-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (317, 'Nobe Pourvoieur', '7428-0294-7126', to_date('19-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (318, 'Carmelina Gibben', '3256-7660-7293', to_date('28-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (319, 'Glenden Litherborough', '4759-2767-3158', to_date('24-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (320, 'Kermit Sully', '8751-0483-1568', to_date('19-05-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (321, 'Woody Cornils', '2780-7831-5816', to_date('13-05-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (322, 'Mendie Toffetto', '3114-3702-7651', to_date('30-06-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (323, 'Lucretia Landsbury', '7793-2566-6372', to_date('28-01-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (324, 'Jerrold McGrill', '5034-1504-7054', to_date('14-07-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (325, 'Ragnar Herkess', '5186-6703-2910', to_date('16-08-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (326, 'Willow Trevenu', '3244-3424-5839', to_date('15-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (327, 'Lynda Peddar', '6075-2267-6689', to_date('19-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (328, 'Tonya Tawn', '5225-6835-9563', to_date('15-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (329, 'James Parsell', '4482-5497-3403', to_date('18-01-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (330, 'Eran Pallant', '7497-9069-6598', to_date('02-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (331, 'Beniamino Crowther', '9354-2949-9183', to_date('02-06-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (332, 'Cristie Assad', '0423-1061-8929', to_date('23-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (333, 'Doralynn Clarkin', '7198-9933-9482', to_date('01-10-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (334, 'Ellissa Thorlby', '3453-3080-0051', to_date('29-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (335, 'Robenia Emor', '7249-3613-9064', to_date('22-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (336, 'Farand Schneidau', '4683-6855-5634', to_date('19-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (337, 'Vevay Elsworth', '9526-5017-1729', to_date('09-06-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (338, 'Doyle Mundford', '5262-9279-6642', to_date('09-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (339, 'Christina Josovitz', '7443-7079-9053', to_date('31-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (340, 'Edik Lyddon', '6151-4739-7190', to_date('21-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (341, 'Padraic Kirtley', '0273-2966-9275', to_date('23-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (342, 'Maynard Giddy', '7216-8203-1119', to_date('19-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (343, 'Vincent Patillo', '9223-1479-6632', to_date('23-09-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (344, 'Sarge Lawley', '3785-8691-1767', to_date('12-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (345, 'Imojean Longley', '7178-7636-0508', to_date('20-05-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (346, 'Kevan Spacy', '2291-4851-5718', to_date('25-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (347, 'Fifine Leve', '7397-0823-4322', to_date('06-11-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (348, 'Nikkie Silverlock', '7904-7789-2756', to_date('13-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (349, 'Joelle Seagood', '9249-5613-9409', to_date('21-12-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (350, 'Dillie Cressor', '0843-5001-4950', to_date('22-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (351, 'Katherine Beardwell', '8804-8922-8217', to_date('16-01-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (352, 'Bevvy Zoppo', '1142-4347-6636', to_date('19-02-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (353, 'Katrinka Janks', '7998-8430-0108', to_date('18-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (354, 'Brita Fitzpatrick', '6650-8826-6164', to_date('18-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (355, 'Brandyn Sammons', '1488-8893-3005', to_date('01-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (356, 'Nancey Caddy', '5454-7276-0027', to_date('20-09-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (357, 'Lissi Eliot', '3868-8242-0961', to_date('27-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (358, 'Nealon Gladbeck', '4625-7287-3143', to_date('23-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (359, 'Isabella Thredder', '6705-3269-3042', to_date('30-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (360, 'Elwood Buntain', '3947-9305-0227', to_date('10-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (361, 'Geraldine Houlaghan', '6681-4121-8095', to_date('06-05-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (362, 'Haily Baden', '8207-5766-6342', to_date('02-10-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (363, 'Claresta Pikett', '7419-3022-4329', to_date('05-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (364, 'Immanuel Bickerstaff', '1997-5881-3515', to_date('02-10-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (365, 'Nefen Lefeuvre', '9075-5571-1949', to_date('22-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (366, 'Pen Thomazin', '7855-3539-1889', to_date('12-01-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (367, 'Selina Hardy-Piggin', '9610-4194-1989', to_date('04-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (368, 'Larissa Lahiff', '0077-7084-0380', to_date('01-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (369, 'Vassili Teanby', '9885-1566-8439', to_date('03-07-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (370, 'Noelani Dymock', '8016-1233-1875', to_date('16-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (371, 'Thacher Graeme', '9648-2589-4659', to_date('30-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (372, 'Alexandra Lackeye', '2931-6808-0161', to_date('06-04-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (373, 'Pansy Thebeaud', '7166-5971-1042', to_date('18-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (374, 'Kimmi Ottery', '4656-6474-0167', to_date('06-07-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (375, 'Dianemarie Brunker', '5116-0810-7633', to_date('10-04-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (376, 'Evangelina Allbon', '5636-1693-9499', to_date('06-11-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (377, 'Osborn Stuckford', '8485-0353-1184', to_date('23-03-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (378, 'Rowen Reubel', '6493-6557-1805', to_date('19-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (379, 'Camile Caistor', '9538-7148-9868', to_date('02-08-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (380, 'Fletcher Syms', '8754-5143-7024', to_date('23-02-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (381, 'Ricardo Gimert', '6149-0186-1503', to_date('29-12-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (382, 'Hobie Augar', '9547-1649-4269', to_date('11-04-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (383, 'Petronia Cuberley', '5926-4211-7517', to_date('18-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (384, 'Tuesday Alloway', '6778-5589-1719', to_date('23-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (385, 'Madella Reape', '9104-9311-0918', to_date('24-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (386, 'Hammad Wilsher', '3355-7219-8365', to_date('24-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (387, 'Leda Darkott', '8502-4284-3853', to_date('20-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (388, 'Vere Ferrero', '0844-8388-8171', to_date('21-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (389, 'Bevan Colnet', '5302-8804-7816', to_date('23-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (390, 'Selinda D''Antuoni', '7030-5811-2331', to_date('18-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (391, 'Troy Quidenham', '9690-0976-6488', to_date('28-02-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (392, 'Isahella Dryden', '8770-3708-9600', to_date('18-11-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (393, 'Amie Tuite', '4332-6149-7932', to_date('08-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (394, 'Ravi Abbets', '3805-7131-4953', to_date('12-05-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (395, 'Murdock Dachs', '0509-5373-7230', to_date('11-11-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (396, 'Evangeline Wallington', '5729-4639-0915', to_date('10-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (397, 'Marcille Nassy', '6791-0737-8909', to_date('17-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (398, 'Diahann Abdee', '4424-3229-2971', to_date('11-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (399, 'Asher Assante', '0934-7100-6853', to_date('23-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (400, 'Deloris Skentelbury', '4327-2118-3975', to_date('29-03-2022', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading TAXI...
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (1, 'Abay', '6:32:03', '20:14:31');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (2, 'Akune', '21:30:14', '23:27:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (3, 'Xinjiezhen', '5:55:16', '2:05:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (4, 'Yuty', '2:32:48', '12:00:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (5, 'Reggada', '2:15:57', '13:46:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (6, 'San Antonio del Monte', '19:56:52', '11:04:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (7, 'Povorino', '14:33:25', '3:05:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (8, 'Atalaia', '12:24:41', '9:14:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (9, 'Xingang', '5:53:25', '19:34:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (10, 'Ngujuran', '13:39:24', '13:11:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (11, 'Kaliprak', '6:57:17', '1:52:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (12, 'Libourne', '3:42:23', '13:43:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (13, 'Pará de Minas', '11:08:50', '2:36:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (14, 'Liuduzhai', '19:06:26', '4:46:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (15, 'Karabas', '7:12:49', '22:43:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (16, 'Demir Hisar', '20:58:55', '22:25:44');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (17, 'Banjarjo', '14:04:14', '5:47:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (18, 'Nancun', '13:38:44', '12:36:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (19, 'Tokonou', '23:19:25', '14:39:46');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (20, 'Leye', '21:03:20', '19:58:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (21, 'Lubenia', '17:28:28', '17:17:04');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (22, 'Ust’-Omchug', '11:42:57', '10:03:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (23, 'Szczurowa', '13:54:19', '8:06:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (24, 'Licheng', '3:42:27', '18:12:31');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (25, 'Padasono', '11:36:24', '16:34:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (26, 'Banjar Wates Tengah', '17:13:36', '12:53:21');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (27, 'Viljoenskroon', '6:20:44', '8:01:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (28, 'Przybyszówka', '19:16:26', '2:19:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (29, 'Cihurip Satu', '10:50:55', '2:49:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (30, 'Nālchiti', '22:37:27', '9:11:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (31, 'Pangawaren', '4:45:18', '11:19:07');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (32, 'Tanjung Palas', '8:00:18', '11:15:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (33, 'Sępólno Krajeńskie', '17:45:53', '17:31:58');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (34, 'Puerto Morazán', '2:52:09', '14:01:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (35, 'Santa Rosa', '8:42:22', '2:30:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (36, 'Kovářská', '16:52:52', '12:55:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (37, 'Porto-Novo', '15:10:46', '6:38:23');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (38, 'Prantaan', '21:15:08', '7:04:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (39, 'Xique Xique', '12:12:14', '12:44:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (40, 'Tumpang Satu', '4:22:35', '22:56:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (41, 'Douane', '19:03:11', '15:49:53');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (42, 'Częstochowa', '0:21:42', '13:13:58');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (43, 'Iḩsim', '21:49:18', '13:58:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (44, 'Yoichi', '3:47:08', '0:04:32');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (45, 'Jiaogong', '23:57:07', '11:08:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (46, 'Dargaz', '22:58:09', '5:07:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (47, 'Ekou', '4:00:49', '1:05:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (48, 'Jhingergācha', '4:46:44', '15:40:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (49, 'Tarhuna', '6:49:11', '18:12:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (50, 'Socabaya', '8:09:43', '21:30:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (51, 'Fengjiang', '20:57:13', '2:28:47');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (52, 'Nahariya', '20:17:26', '12:13:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (53, 'Cinyasag', '11:36:41', '14:29:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (54, 'Teykovo', '22:27:01', '14:53:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (55, 'Budapest', '5:41:43', '19:18:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (56, 'Fiais da Beira', '11:46:36', '5:55:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (57, 'Seseng', '5:39:25', '6:48:46');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (58, 'Luleå', '20:39:16', '11:43:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (59, 'Agana Heights Village', '9:01:14', '18:08:23');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (60, 'Konggar', '3:37:59', '13:21:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (61, 'Shahe', '16:33:16', '20:42:15');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (62, 'Pangguang', '14:56:11', '10:16:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (63, 'Herálec', '5:31:36', '5:12:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (64, 'Basel', '18:41:57', '19:00:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (65, 'Horní Libina', '0:51:10', '8:53:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (66, 'Norfolk', '7:52:23', '5:48:31');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (67, 'San Francisco', '4:51:18', '23:42:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (68, 'Jindong', '14:59:03', '14:18:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (69, 'Nybro', '13:33:22', '7:54:35');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (70, 'New Leyte', '0:38:57', '5:36:42');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (71, 'Hubei', '10:24:43', '13:58:15');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (72, 'Sumberagung', '14:38:46', '10:50:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (73, 'Middleton', '22:28:32', '9:27:15');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (74, 'Kafr Baţnā', '21:51:47', '22:27:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (75, 'Saripin', '13:14:51', '13:35:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (76, 'Provo', '23:27:03', '9:35:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (77, 'Agua Blanca', '23:18:39', '13:53:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (78, 'Rakvere', '12:51:33', '23:57:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (79, 'Nong Bun Nak', '3:05:00', '18:09:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (80, 'Salto', '17:36:58', '4:32:33');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (81, 'Llano de Piedra', '21:58:13', '6:33:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (82, 'Marataizes', '1:15:30', '10:28:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (83, 'Phatthana Nikhom', '22:49:45', '22:18:15');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (84, 'Volgodonsk', '13:58:44', '5:47:53');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (85, 'Feyẕābād', '22:43:20', '22:55:07');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (86, 'Farkaždin', '2:09:05', '19:00:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (87, 'Huangascar', '23:25:33', '6:44:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (88, 'Tanggeung Kolot', '2:52:17', '19:38:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (89, 'Tavira', '9:18:10', '20:48:42');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (90, 'Lokossa', '20:16:01', '17:45:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (91, 'Māwiyah', '19:52:31', '4:22:07');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (92, 'Krousón', '20:54:09', '23:52:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (93, 'Maloyaroslavets', '12:26:19', '0:54:19');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (94, 'Kakuda', '21:15:55', '6:45:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (95, 'Kamennyye Potoki', '9:29:04', '5:37:31');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (96, 'Pacobamba', '23:49:46', '2:40:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (97, 'Vitomarci', '22:21:03', '0:09:12');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (98, 'Ghormach', '22:44:48', '17:12:58');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (99, 'Saint-Tite', '23:39:50', '20:06:51');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (100, 'San Luis Ixcán', '17:41:33', '6:29:38');
commit;
prompt 100 records committed...
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (101, 'La Concordia', '6:55:39', '16:17:05');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (102, 'Vom', '5:55:36', '4:11:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (103, 'Tecka', '15:27:41', '8:16:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (104, 'Granada', '14:29:46', '11:50:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (105, 'Ohrid', '23:44:30', '6:30:04');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (106, 'Bearna', '0:52:55', '20:36:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (107, 'Ungheni', '3:36:28', '11:09:14');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (108, 'Araucária', '19:30:14', '19:28:19');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (109, 'Ciwidara', '2:40:43', '10:53:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (110, 'Baranowo', '18:49:42', '5:19:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (111, 'Punta Cana', '10:39:14', '8:20:14');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (112, 'Joroinen', '1:10:52', '21:03:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (113, 'Krajan', '13:36:13', '3:15:56');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (114, 'Persen', '21:52:42', '6:07:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (115, 'Puzi', '23:19:51', '21:31:55');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (116, 'Hekou', '19:15:23', '13:04:07');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (117, 'Cangkreng', '18:53:14', '6:02:44');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (118, 'Grigiškės', '17:14:52', '11:15:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (119, 'Gąsocin', '3:07:09', '4:22:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (120, 'Aston', '7:54:03', '1:45:26');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (121, 'Rozhdestveno', '3:15:21', '14:27:04');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (122, 'Jand', '8:31:54', '7:33:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (123, 'Chegutu', '21:45:23', '20:51:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (124, 'Holice', '4:08:27', '6:24:15');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (125, 'Chang Klang', '0:40:50', '10:28:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (126, 'Outokumpu', '16:42:20', '11:35:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (127, 'Pexiligais', '7:08:03', '21:59:01');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (128, 'Staré Hradiště', '7:15:36', '13:50:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (129, 'Xiaxi', '8:57:30', '17:17:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (130, 'Radamata', '18:05:00', '3:09:12');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (131, 'Grębków', '14:50:03', '9:36:23');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (132, 'Citeluk', '13:55:20', '12:15:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (133, 'Thika', '12:51:31', '9:00:58');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (134, 'Quimper', '2:56:20', '22:15:56');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (135, 'Zambrów', '16:07:45', '4:15:08');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (136, 'Stockholm', '2:57:50', '14:58:08');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (137, 'Al Ghandūrah', '19:14:19', '8:25:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (138, 'Västerås', '20:15:08', '4:45:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (139, 'Sambirata', '13:11:53', '2:44:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (140, 'Longba', '4:10:37', '20:54:07');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (141, 'Enskede', '6:39:14', '8:07:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (142, 'Serowe', '3:25:29', '14:25:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (143, 'Pontal', '15:56:44', '1:39:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (144, 'Pakel', '7:09:55', '3:43:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (145, 'Yambol', '21:19:38', '9:28:18');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (146, 'Al Jaghbūb', '1:49:24', '14:08:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (147, 'San Isidro', '21:54:28', '6:26:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (148, 'Znojmo', '4:47:55', '12:20:50');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (149, 'Liuyuan', '6:46:58', '12:23:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (150, 'Yabēlo', '13:56:16', '8:10:21');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (151, 'Arţās', '9:11:05', '8:31:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (152, 'Weishanzhuang', '5:03:10', '18:35:42');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (153, 'Paris 08', '16:25:52', '1:17:14');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (154, 'Biny Selo', '13:27:47', '5:15:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (155, 'Funabashi', '2:56:56', '5:00:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (156, 'Vilar', '1:12:07', '18:09:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (157, 'Andalan', '4:30:36', '8:25:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (158, 'Dagohoy', '2:42:46', '4:14:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (159, 'Alcoy', '7:36:00', '11:09:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (160, 'Pitomača', '3:14:38', '14:57:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (161, 'Doljo', '8:37:38', '3:30:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (162, 'Ciranca Satu', '16:09:52', '10:32:50');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (163, 'Los Angeles', '2:50:17', '18:22:58');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (164, 'Sydney', '13:46:55', '22:01:26');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (165, 'Mbaïki', '4:51:11', '8:40:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (166, 'Saltsjö-Boo', '9:59:35', '23:56:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (167, 'Janja', '20:23:05', '7:03:50');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (168, 'Maanĭt', '21:16:18', '4:05:21');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (169, 'Talitsa', '14:13:33', '23:16:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (170, 'Ifakara', '5:39:18', '14:31:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (171, 'Capinzal', '0:26:31', '2:52:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (172, 'Parajara', '14:12:20', '13:55:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (173, 'Örgön', '18:32:37', '4:12:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (174, 'Miami', '7:54:15', '22:23:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (175, 'Manacapuru', '13:54:36', '22:40:51');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (176, 'Suphan Buri', '3:37:00', '18:12:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (177, 'Walenrang', '16:12:08', '14:44:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (178, 'Baoyang', '11:51:40', '20:52:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (179, 'Deskáti', '3:10:23', '14:09:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (180, 'Huaniao', '20:57:32', '21:30:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (181, 'Yilan', '5:42:33', '0:27:44');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (182, 'Harjavalta', '2:15:40', '14:11:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (183, 'Djambala', '5:44:38', '3:01:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (184, 'Zhongba', '7:22:44', '4:17:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (185, 'Malusac', '10:33:40', '3:26:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (186, 'Telukpakedai', '19:36:04', '16:22:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (187, 'Gayle', '9:07:52', '18:55:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (188, 'Al ‘Azīzīyah', '10:59:34', '4:59:51');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (189, 'Maishi', '2:31:42', '19:53:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (190, 'Ban Talat Yai', '17:03:58', '11:23:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (191, 'Ploso', '6:09:42', '8:58:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (192, 'Šestajovice', '19:53:34', '11:48:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (193, 'Longwy', '13:00:44', '4:03:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (194, 'Kayanza', '14:33:50', '16:11:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (195, 'Pingtang', '22:16:45', '6:29:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (196, 'Maying', '2:29:26', '0:47:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (197, 'Safonovo', '9:02:39', '14:37:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (198, 'Baguim do Monte', '20:59:11', '12:23:14');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (199, 'Gambēla', '10:03:27', '19:30:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (200, 'Kayukembang', '12:30:41', '22:08:52');
commit;
prompt 200 records committed...
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (201, 'Tanout', '4:55:21', '2:34:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (202, 'Włosienica', '19:34:54', '14:59:05');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (203, 'Wuli', '13:37:08', '14:42:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (204, 'Bitin', '1:16:11', '15:15:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (205, 'Ambar', '3:11:32', '1:54:01');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (206, 'Tumpang', '16:38:35', '12:49:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (207, 'Erenhot', '14:37:12', '19:07:23');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (208, 'Kebonsari', '4:44:37', '15:39:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (209, 'Mamara', '19:12:39', '0:32:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (210, 'Beauvais', '14:00:12', '20:41:32');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (211, 'Karak City', '2:58:07', '6:45:19');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (212, 'Bachok', '10:25:02', '2:08:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (213, 'Brétigny-sur-Orge', '2:53:26', '13:54:47');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (214, 'Tiaong', '7:08:54', '13:56:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (215, 'Miðvágur', '12:27:01', '3:22:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (216, 'Qili', '14:36:37', '13:29:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (217, 'Union', '19:18:56', '4:33:53');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (218, 'Chaiwan', '17:10:05', '10:20:15');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (219, 'Qiankou', '4:59:20', '11:30:47');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (220, 'Trà Ôn', '20:09:49', '7:32:31');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (221, 'Villasis', '17:49:54', '16:15:33');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (222, 'Changning', '20:04:41', '16:50:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (223, 'Duoxiang', '14:04:30', '8:37:46');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (224, 'Kafr Nubl', '12:54:40', '14:26:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (225, 'Krajan Kerjo', '15:49:10', '14:55:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (226, 'Tarrafal', '9:05:41', '10:28:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (227, 'Qishn', '1:28:20', '7:52:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (228, 'Ban Mo', '4:50:57', '18:14:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (229, 'Mujur', '18:37:31', '8:32:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (230, 'Saḩab', '9:00:43', '20:55:08');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (231, 'Xin’an', '20:34:35', '8:57:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (232, 'Guanting', '16:20:56', '21:13:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (233, 'Crasto', '7:32:52', '5:38:53');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (234, 'Loma Bonita', '14:59:16', '21:17:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (235, 'Debe', '14:31:35', '16:46:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (236, 'Bolian', '6:59:09', '15:52:33');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (237, 'Neyvo-Rudyanka', '13:21:35', '18:40:12');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (238, 'Xiaotao', '23:38:40', '20:02:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (239, 'Shuangxi', '15:22:19', '5:07:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (240, 'Munsan', '2:19:11', '15:40:32');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (241, 'Shuqiao', '17:44:04', '22:51:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (242, 'Richmond', '5:13:21', '15:58:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (243, 'Ushi', '8:34:43', '20:43:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (244, 'Pyatigorskiy', '3:29:49', '10:33:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (245, 'Bojongnangka', '8:08:47', '18:03:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (246, 'Xinzhou', '17:15:19', '6:29:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (247, 'Ochobo', '14:01:13', '3:42:53');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (248, 'Lugovskoy', '4:04:06', '11:08:08');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (249, 'Caofang', '12:50:34', '23:41:50');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (250, 'Bahía Blanca', '14:47:19', '17:15:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (251, 'Santa Cristina Couto', '16:04:39', '13:59:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (252, 'Mao’er', '1:04:52', '8:28:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (253, 'Balaklava', '22:53:54', '18:33:14');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (254, 'Nîmes', '6:02:33', '5:55:31');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (255, 'Gandapura', '12:37:02', '16:37:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (256, 'Fuzihe', '3:44:37', '4:25:14');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (257, 'Itapira', '8:20:00', '21:23:33');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (258, 'Clamart', '11:56:01', '11:53:05');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (259, 'Beijiang', '10:32:48', '8:42:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (260, 'Candelaria', '22:33:25', '20:12:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (261, 'South Tangerang', '12:51:05', '20:32:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (262, 'Lo Prado', '6:45:06', '1:30:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (263, 'Redon', '5:00:34', '3:22:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (264, 'Zrenjanin', '2:16:01', '6:35:58');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (265, 'Quimper', '16:52:22', '3:54:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (266, 'Boston', '22:28:58', '13:36:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (267, 'Próchoma', '5:14:08', '16:05:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (268, 'Mibu', '8:04:06', '6:58:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (269, 'Leigongjian', '16:53:05', '14:22:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (270, 'Podgornoye', '8:23:58', '15:12:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (271, 'Dera Murād Jamāli', '10:04:56', '14:15:33');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (272, 'Envira', '5:09:08', '11:16:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (273, 'Peras Ruivas', '23:54:23', '15:28:11');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (274, 'Bretaña', '2:13:41', '0:34:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (275, 'Puncan', '19:01:40', '16:26:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (276, 'Calaba', '16:56:19', '15:10:26');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (277, 'La Roche-sur-Yon', '8:12:05', '6:29:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (278, 'Itatinga', '16:10:56', '9:44:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (279, 'Sukadana', '15:19:38', '21:48:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (280, 'Pekijing', '17:01:53', '12:50:01');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (281, 'Tanjungbahagia', '17:40:38', '0:21:48');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (282, 'Rakek', '20:26:07', '7:10:33');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (283, 'Yonghe', '10:04:37', '12:39:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (284, 'Basseterre', '3:38:46', '7:55:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (285, 'Airuk', '15:01:12', '9:03:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (286, 'Tucaní', '6:21:33', '2:12:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (287, 'Dubá', '22:33:47', '4:21:21');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (288, 'Moch', '1:47:17', '14:12:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (289, 'Cali', '17:32:43', '17:26:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (290, 'Rennes', '22:55:43', '12:33:07');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (291, 'Thị Trấn Quan Hóa', '12:27:22', '18:22:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (292, 'Yueshan', '9:08:32', '16:55:05');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (293, 'Patrocínio', '3:53:07', '9:23:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (294, 'Catia La Mar', '14:34:59', '13:02:23');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (295, 'Caramanta', '3:01:40', '14:51:17');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (296, 'Glasgow', '20:35:08', '15:46:35');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (297, 'Toutai', '7:57:39', '16:33:57');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (298, 'Panao', '10:45:06', '21:58:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (299, 'Novorossiysk', '5:48:42', '18:46:36');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (300, 'Payxambabazar', '7:19:23', '22:21:41');
commit;
prompt 300 records committed...
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (301, 'Yongning', '2:08:02', '4:44:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (302, 'Wan Yai', '10:37:07', '22:20:51');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (303, 'Huancapi', '0:40:46', '12:27:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (304, 'Verblyany', '11:59:06', '18:02:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (305, 'Jiuzhen', '23:16:08', '9:12:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (306, 'Kétou', '5:32:25', '13:08:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (307, 'Kalininskiy', '3:17:52', '19:33:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (308, 'Aleksandrovac', '18:26:30', '9:43:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (309, 'Turanj', '9:46:40', '10:31:47');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (310, 'Koudougou', '11:39:40', '14:53:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (311, 'Guinabsan', '19:26:48', '14:46:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (312, 'Avignon', '9:08:35', '0:55:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (313, 'Prínos', '22:49:06', '10:05:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (314, 'Jiangshan', '15:16:22', '3:19:19');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (315, 'RMI Capitol', '22:44:28', '18:37:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (316, 'Fūman', '7:23:52', '10:48:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (317, 'Toride', '12:52:16', '5:59:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (318, 'San Pa Tong', '16:11:47', '8:19:47');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (319, 'Burgaltay', '9:54:01', '5:21:11');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (320, 'El Aguacate', '12:12:55', '19:29:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (321, 'San Isidro', '12:30:43', '11:59:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (322, 'Panacan', '11:06:35', '21:56:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (323, 'Independencia', '13:12:45', '8:09:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (324, 'Vacha', '18:56:44', '7:18:01');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (325, 'Calle Blancos', '5:40:12', '17:55:40');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (326, 'Hekou', '12:06:15', '11:03:35');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (327, 'Patulul', '16:24:07', '1:50:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (328, 'Taiping', '12:33:46', '8:26:30');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (329, 'Pedro García', '23:39:47', '14:29:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (330, 'Buckland', '18:16:30', '22:35:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (331, 'Chengnan', '15:40:16', '16:18:56');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (332, 'Altavista', '6:38:47', '23:01:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (333, 'Tangerang', '15:26:23', '0:51:32');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (334, 'pamas', '17:21:54', '15:31:44');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (335, 'Fulong', '2:06:51', '20:33:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (336, 'Libertador General San Martín', '5:44:38', '23:25:02');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (337, 'Sanjian', '1:15:52', '15:21:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (338, 'Surkh Bilandī', '0:34:55', '8:54:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (339, 'Ticllos', '23:54:12', '23:53:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (340, 'Al Qurayn', '1:20:51', '0:25:03');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (341, 'Bamencheng', '16:18:09', '20:54:52');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (342, 'Sanzhou', '3:28:33', '16:37:29');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (343, 'Shixiang', '14:45:32', '10:01:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (344, 'Sollebrunn', '6:50:01', '0:53:09');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (345, 'Atlanta', '19:36:51', '0:22:45');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (346, 'Podwilk', '6:42:58', '4:10:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (347, 'Skore', '10:57:39', '12:53:35');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (348, 'Nong Yai', '23:32:25', '4:37:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (349, 'Tarnawatka', '16:13:45', '10:56:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (350, 'Łęknica', '23:22:23', '21:57:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (351, 'Labnig', '16:20:31', '8:52:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (352, 'Tolotangga', '19:09:05', '6:35:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (353, 'Ventersdorp', '3:13:21', '15:49:43');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (354, 'Suwaduk', '1:45:23', '12:38:26');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (355, 'Siliana', '16:00:06', '7:11:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (356, 'Szklarska Poręba', '1:08:47', '15:56:55');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (357, 'Ciénaga de Oro', '4:45:57', '11:59:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (358, 'Mymensingh', '11:15:36', '4:39:22');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (359, 'Panitian', '12:24:15', '15:28:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (360, 'Tarariras', '13:12:26', '1:57:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (361, '5 de Mayo', '21:36:25', '23:52:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (362, 'Bloomington', '4:45:35', '9:02:35');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (363, 'Komatsushimachō', '8:01:31', '10:24:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (364, 'Huacachi', '11:26:14', '14:04:34');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (365, 'Vilar do Monte', '10:15:20', '9:46:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (366, 'Nizhnyaya Tura', '7:56:00', '13:16:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (367, 'Jiuzhen', '4:58:28', '11:40:21');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (368, 'Algoz', '22:02:00', '23:08:21');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (369, 'Xinbao', '12:19:24', '2:59:41');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (370, 'Casillas', '18:35:11', '12:55:37');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (371, 'Nam Khun', '13:18:21', '23:31:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (372, 'San Jorge', '9:43:47', '10:26:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (373, 'Patrang', '2:23:26', '10:18:59');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (374, 'Qingshan', '4:38:32', '8:26:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (375, 'Natividade', '18:18:22', '18:24:11');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (376, 'Baiyang', '10:17:48', '21:59:39');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (377, 'Grębów', '6:48:55', '11:11:26');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (378, 'Lemery', '15:11:17', '4:16:44');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (379, 'Jubao', '11:05:44', '11:19:49');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (380, 'Pondokrejo Wetan', '0:20:22', '6:34:44');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (381, 'Gocoton', '8:48:32', '7:44:25');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (382, 'Ekibastuz', '20:37:08', '7:21:06');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (383, 'Toungo', '13:23:48', '2:32:46');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (384, 'Bianxiong', '4:44:06', '12:33:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (385, 'Río Blanco', '5:58:43', '4:20:16');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (386, 'Huangma', '20:40:26', '16:19:38');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (387, 'Tonghong', '9:28:09', '3:15:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (388, 'Králův Dvůr', '7:59:45', '8:00:00');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (389, 'Kalasin', '1:12:19', '16:24:54');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (390, 'Nova Varoš', '17:32:12', '15:51:24');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (391, 'El Lolo', '4:36:11', '9:56:28');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (392, 'Manlio Fabio Altamirano', '18:58:41', '10:00:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (393, 'La Rochelle', '5:38:26', '10:52:10');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (394, 'Saint Petersburg', '20:08:18', '12:55:56');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (395, 'Salvacion', '1:53:33', '11:01:18');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (396, 'Usquil', '15:37:00', '21:56:20');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (397, 'Huangtian', '0:21:14', '7:15:18');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (398, 'La Soledad', '13:23:57', '16:53:27');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (399, 'Maracha', '21:31:54', '5:00:13');
insert into TAXI (taxiid, workingzone, starttime, finishtime)
values (400, 'Erling', '8:34:50', '14:14:59');
commit;
prompt 400 records loaded
prompt Loading DRIVESINTAXI...
insert into DRIVESINTAXI (driverid, taxiid)
values (52, 221);
insert into DRIVESINTAXI (driverid, taxiid)
values (83, 36);
insert into DRIVESINTAXI (driverid, taxiid)
values (387, 161);
insert into DRIVESINTAXI (driverid, taxiid)
values (156, 293);
insert into DRIVESINTAXI (driverid, taxiid)
values (150, 348);
insert into DRIVESINTAXI (driverid, taxiid)
values (191, 316);
insert into DRIVESINTAXI (driverid, taxiid)
values (23, 385);
insert into DRIVESINTAXI (driverid, taxiid)
values (234, 361);
insert into DRIVESINTAXI (driverid, taxiid)
values (179, 235);
insert into DRIVESINTAXI (driverid, taxiid)
values (325, 81);
insert into DRIVESINTAXI (driverid, taxiid)
values (398, 299);
insert into DRIVESINTAXI (driverid, taxiid)
values (277, 268);
insert into DRIVESINTAXI (driverid, taxiid)
values (375, 30);
insert into DRIVESINTAXI (driverid, taxiid)
values (109, 292);
insert into DRIVESINTAXI (driverid, taxiid)
values (85, 16);
insert into DRIVESINTAXI (driverid, taxiid)
values (250, 24);
insert into DRIVESINTAXI (driverid, taxiid)
values (168, 191);
insert into DRIVESINTAXI (driverid, taxiid)
values (349, 334);
insert into DRIVESINTAXI (driverid, taxiid)
values (5, 99);
insert into DRIVESINTAXI (driverid, taxiid)
values (395, 369);
insert into DRIVESINTAXI (driverid, taxiid)
values (64, 75);
insert into DRIVESINTAXI (driverid, taxiid)
values (365, 285);
insert into DRIVESINTAXI (driverid, taxiid)
values (363, 263);
insert into DRIVESINTAXI (driverid, taxiid)
values (333, 254);
insert into DRIVESINTAXI (driverid, taxiid)
values (246, 147);
insert into DRIVESINTAXI (driverid, taxiid)
values (246, 208);
insert into DRIVESINTAXI (driverid, taxiid)
values (313, 97);
insert into DRIVESINTAXI (driverid, taxiid)
values (285, 145);
insert into DRIVESINTAXI (driverid, taxiid)
values (300, 219);
insert into DRIVESINTAXI (driverid, taxiid)
values (40, 67);
insert into DRIVESINTAXI (driverid, taxiid)
values (350, 213);
insert into DRIVESINTAXI (driverid, taxiid)
values (11, 355);
insert into DRIVESINTAXI (driverid, taxiid)
values (70, 112);
insert into DRIVESINTAXI (driverid, taxiid)
values (256, 273);
insert into DRIVESINTAXI (driverid, taxiid)
values (223, 223);
insert into DRIVESINTAXI (driverid, taxiid)
values (293, 397);
insert into DRIVESINTAXI (driverid, taxiid)
values (34, 339);
insert into DRIVESINTAXI (driverid, taxiid)
values (103, 53);
insert into DRIVESINTAXI (driverid, taxiid)
values (377, 335);
insert into DRIVESINTAXI (driverid, taxiid)
values (119, 170);
insert into DRIVESINTAXI (driverid, taxiid)
values (6, 21);
insert into DRIVESINTAXI (driverid, taxiid)
values (245, 37);
insert into DRIVESINTAXI (driverid, taxiid)
values (113, 178);
insert into DRIVESINTAXI (driverid, taxiid)
values (12, 156);
insert into DRIVESINTAXI (driverid, taxiid)
values (161, 22);
insert into DRIVESINTAXI (driverid, taxiid)
values (88, 283);
insert into DRIVESINTAXI (driverid, taxiid)
values (83, 52);
insert into DRIVESINTAXI (driverid, taxiid)
values (274, 259);
insert into DRIVESINTAXI (driverid, taxiid)
values (395, 110);
insert into DRIVESINTAXI (driverid, taxiid)
values (385, 116);
insert into DRIVESINTAXI (driverid, taxiid)
values (305, 204);
insert into DRIVESINTAXI (driverid, taxiid)
values (155, 55);
insert into DRIVESINTAXI (driverid, taxiid)
values (392, 144);
insert into DRIVESINTAXI (driverid, taxiid)
values (370, 195);
insert into DRIVESINTAXI (driverid, taxiid)
values (98, 122);
insert into DRIVESINTAXI (driverid, taxiid)
values (353, 74);
insert into DRIVESINTAXI (driverid, taxiid)
values (36, 88);
insert into DRIVESINTAXI (driverid, taxiid)
values (220, 10);
insert into DRIVESINTAXI (driverid, taxiid)
values (351, 265);
insert into DRIVESINTAXI (driverid, taxiid)
values (31, 106);
insert into DRIVESINTAXI (driverid, taxiid)
values (131, 44);
insert into DRIVESINTAXI (driverid, taxiid)
values (36, 397);
insert into DRIVESINTAXI (driverid, taxiid)
values (110, 208);
insert into DRIVESINTAXI (driverid, taxiid)
values (365, 131);
insert into DRIVESINTAXI (driverid, taxiid)
values (257, 317);
insert into DRIVESINTAXI (driverid, taxiid)
values (150, 281);
insert into DRIVESINTAXI (driverid, taxiid)
values (297, 18);
insert into DRIVESINTAXI (driverid, taxiid)
values (218, 275);
insert into DRIVESINTAXI (driverid, taxiid)
values (149, 299);
insert into DRIVESINTAXI (driverid, taxiid)
values (364, 45);
insert into DRIVESINTAXI (driverid, taxiid)
values (145, 54);
insert into DRIVESINTAXI (driverid, taxiid)
values (329, 188);
insert into DRIVESINTAXI (driverid, taxiid)
values (193, 183);
insert into DRIVESINTAXI (driverid, taxiid)
values (100, 324);
insert into DRIVESINTAXI (driverid, taxiid)
values (365, 389);
insert into DRIVESINTAXI (driverid, taxiid)
values (42, 255);
insert into DRIVESINTAXI (driverid, taxiid)
values (261, 299);
insert into DRIVESINTAXI (driverid, taxiid)
values (295, 218);
insert into DRIVESINTAXI (driverid, taxiid)
values (237, 262);
insert into DRIVESINTAXI (driverid, taxiid)
values (146, 219);
insert into DRIVESINTAXI (driverid, taxiid)
values (56, 73);
insert into DRIVESINTAXI (driverid, taxiid)
values (198, 144);
insert into DRIVESINTAXI (driverid, taxiid)
values (225, 350);
insert into DRIVESINTAXI (driverid, taxiid)
values (249, 44);
insert into DRIVESINTAXI (driverid, taxiid)
values (198, 220);
insert into DRIVESINTAXI (driverid, taxiid)
values (311, 92);
insert into DRIVESINTAXI (driverid, taxiid)
values (112, 266);
insert into DRIVESINTAXI (driverid, taxiid)
values (274, 190);
insert into DRIVESINTAXI (driverid, taxiid)
values (16, 149);
insert into DRIVESINTAXI (driverid, taxiid)
values (247, 131);
insert into DRIVESINTAXI (driverid, taxiid)
values (271, 88);
insert into DRIVESINTAXI (driverid, taxiid)
values (80, 119);
insert into DRIVESINTAXI (driverid, taxiid)
values (85, 204);
insert into DRIVESINTAXI (driverid, taxiid)
values (308, 315);
insert into DRIVESINTAXI (driverid, taxiid)
values (52, 304);
insert into DRIVESINTAXI (driverid, taxiid)
values (7, 230);
insert into DRIVESINTAXI (driverid, taxiid)
values (271, 324);
insert into DRIVESINTAXI (driverid, taxiid)
values (3, 36);
insert into DRIVESINTAXI (driverid, taxiid)
values (97, 188);
insert into DRIVESINTAXI (driverid, taxiid)
values (348, 9);
commit;
prompt 100 records committed...
insert into DRIVESINTAXI (driverid, taxiid)
values (113, 329);
insert into DRIVESINTAXI (driverid, taxiid)
values (272, 383);
insert into DRIVESINTAXI (driverid, taxiid)
values (179, 199);
insert into DRIVESINTAXI (driverid, taxiid)
values (145, 12);
insert into DRIVESINTAXI (driverid, taxiid)
values (324, 234);
insert into DRIVESINTAXI (driverid, taxiid)
values (251, 342);
insert into DRIVESINTAXI (driverid, taxiid)
values (168, 3);
insert into DRIVESINTAXI (driverid, taxiid)
values (109, 72);
insert into DRIVESINTAXI (driverid, taxiid)
values (218, 185);
insert into DRIVESINTAXI (driverid, taxiid)
values (152, 12);
insert into DRIVESINTAXI (driverid, taxiid)
values (123, 128);
insert into DRIVESINTAXI (driverid, taxiid)
values (71, 125);
insert into DRIVESINTAXI (driverid, taxiid)
values (261, 20);
insert into DRIVESINTAXI (driverid, taxiid)
values (274, 45);
insert into DRIVESINTAXI (driverid, taxiid)
values (302, 30);
insert into DRIVESINTAXI (driverid, taxiid)
values (144, 70);
insert into DRIVESINTAXI (driverid, taxiid)
values (151, 53);
insert into DRIVESINTAXI (driverid, taxiid)
values (136, 118);
insert into DRIVESINTAXI (driverid, taxiid)
values (304, 201);
insert into DRIVESINTAXI (driverid, taxiid)
values (28, 247);
insert into DRIVESINTAXI (driverid, taxiid)
values (19, 293);
insert into DRIVESINTAXI (driverid, taxiid)
values (136, 23);
insert into DRIVESINTAXI (driverid, taxiid)
values (137, 285);
insert into DRIVESINTAXI (driverid, taxiid)
values (26, 143);
insert into DRIVESINTAXI (driverid, taxiid)
values (356, 74);
insert into DRIVESINTAXI (driverid, taxiid)
values (130, 188);
insert into DRIVESINTAXI (driverid, taxiid)
values (1, 34);
insert into DRIVESINTAXI (driverid, taxiid)
values (191, 123);
insert into DRIVESINTAXI (driverid, taxiid)
values (268, 119);
insert into DRIVESINTAXI (driverid, taxiid)
values (149, 16);
insert into DRIVESINTAXI (driverid, taxiid)
values (11, 278);
insert into DRIVESINTAXI (driverid, taxiid)
values (399, 184);
insert into DRIVESINTAXI (driverid, taxiid)
values (47, 227);
insert into DRIVESINTAXI (driverid, taxiid)
values (26, 56);
insert into DRIVESINTAXI (driverid, taxiid)
values (230, 325);
insert into DRIVESINTAXI (driverid, taxiid)
values (144, 139);
insert into DRIVESINTAXI (driverid, taxiid)
values (82, 186);
insert into DRIVESINTAXI (driverid, taxiid)
values (356, 396);
insert into DRIVESINTAXI (driverid, taxiid)
values (237, 188);
insert into DRIVESINTAXI (driverid, taxiid)
values (56, 17);
insert into DRIVESINTAXI (driverid, taxiid)
values (78, 307);
insert into DRIVESINTAXI (driverid, taxiid)
values (381, 79);
insert into DRIVESINTAXI (driverid, taxiid)
values (217, 29);
insert into DRIVESINTAXI (driverid, taxiid)
values (352, 298);
insert into DRIVESINTAXI (driverid, taxiid)
values (215, 385);
insert into DRIVESINTAXI (driverid, taxiid)
values (399, 348);
insert into DRIVESINTAXI (driverid, taxiid)
values (376, 39);
insert into DRIVESINTAXI (driverid, taxiid)
values (206, 366);
insert into DRIVESINTAXI (driverid, taxiid)
values (221, 292);
insert into DRIVESINTAXI (driverid, taxiid)
values (294, 111);
insert into DRIVESINTAXI (driverid, taxiid)
values (277, 332);
insert into DRIVESINTAXI (driverid, taxiid)
values (42, 392);
insert into DRIVESINTAXI (driverid, taxiid)
values (376, 181);
insert into DRIVESINTAXI (driverid, taxiid)
values (198, 39);
insert into DRIVESINTAXI (driverid, taxiid)
values (112, 74);
insert into DRIVESINTAXI (driverid, taxiid)
values (358, 236);
insert into DRIVESINTAXI (driverid, taxiid)
values (41, 327);
insert into DRIVESINTAXI (driverid, taxiid)
values (74, 79);
insert into DRIVESINTAXI (driverid, taxiid)
values (284, 227);
insert into DRIVESINTAXI (driverid, taxiid)
values (271, 181);
insert into DRIVESINTAXI (driverid, taxiid)
values (106, 189);
insert into DRIVESINTAXI (driverid, taxiid)
values (224, 398);
insert into DRIVESINTAXI (driverid, taxiid)
values (129, 329);
insert into DRIVESINTAXI (driverid, taxiid)
values (189, 285);
insert into DRIVESINTAXI (driverid, taxiid)
values (171, 294);
insert into DRIVESINTAXI (driverid, taxiid)
values (324, 155);
insert into DRIVESINTAXI (driverid, taxiid)
values (150, 89);
insert into DRIVESINTAXI (driverid, taxiid)
values (206, 364);
insert into DRIVESINTAXI (driverid, taxiid)
values (47, 151);
insert into DRIVESINTAXI (driverid, taxiid)
values (178, 88);
insert into DRIVESINTAXI (driverid, taxiid)
values (185, 211);
insert into DRIVESINTAXI (driverid, taxiid)
values (223, 198);
insert into DRIVESINTAXI (driverid, taxiid)
values (385, 186);
insert into DRIVESINTAXI (driverid, taxiid)
values (208, 136);
insert into DRIVESINTAXI (driverid, taxiid)
values (296, 48);
insert into DRIVESINTAXI (driverid, taxiid)
values (195, 359);
insert into DRIVESINTAXI (driverid, taxiid)
values (26, 107);
insert into DRIVESINTAXI (driverid, taxiid)
values (58, 80);
insert into DRIVESINTAXI (driverid, taxiid)
values (385, 70);
insert into DRIVESINTAXI (driverid, taxiid)
values (103, 67);
insert into DRIVESINTAXI (driverid, taxiid)
values (78, 87);
insert into DRIVESINTAXI (driverid, taxiid)
values (131, 14);
insert into DRIVESINTAXI (driverid, taxiid)
values (132, 367);
insert into DRIVESINTAXI (driverid, taxiid)
values (47, 72);
insert into DRIVESINTAXI (driverid, taxiid)
values (321, 375);
insert into DRIVESINTAXI (driverid, taxiid)
values (44, 232);
insert into DRIVESINTAXI (driverid, taxiid)
values (60, 374);
insert into DRIVESINTAXI (driverid, taxiid)
values (70, 158);
insert into DRIVESINTAXI (driverid, taxiid)
values (333, 140);
insert into DRIVESINTAXI (driverid, taxiid)
values (13, 154);
insert into DRIVESINTAXI (driverid, taxiid)
values (127, 216);
insert into DRIVESINTAXI (driverid, taxiid)
values (103, 76);
insert into DRIVESINTAXI (driverid, taxiid)
values (142, 322);
insert into DRIVESINTAXI (driverid, taxiid)
values (364, 262);
insert into DRIVESINTAXI (driverid, taxiid)
values (239, 87);
insert into DRIVESINTAXI (driverid, taxiid)
values (35, 294);
insert into DRIVESINTAXI (driverid, taxiid)
values (4, 129);
insert into DRIVESINTAXI (driverid, taxiid)
values (363, 270);
insert into DRIVESINTAXI (driverid, taxiid)
values (289, 46);
insert into DRIVESINTAXI (driverid, taxiid)
values (311, 185);
commit;
prompt 200 records committed...
insert into DRIVESINTAXI (driverid, taxiid)
values (104, 341);
insert into DRIVESINTAXI (driverid, taxiid)
values (376, 320);
insert into DRIVESINTAXI (driverid, taxiid)
values (124, 242);
insert into DRIVESINTAXI (driverid, taxiid)
values (253, 26);
insert into DRIVESINTAXI (driverid, taxiid)
values (186, 250);
insert into DRIVESINTAXI (driverid, taxiid)
values (153, 396);
insert into DRIVESINTAXI (driverid, taxiid)
values (235, 364);
insert into DRIVESINTAXI (driverid, taxiid)
values (104, 30);
insert into DRIVESINTAXI (driverid, taxiid)
values (302, 223);
insert into DRIVESINTAXI (driverid, taxiid)
values (37, 369);
insert into DRIVESINTAXI (driverid, taxiid)
values (368, 315);
insert into DRIVESINTAXI (driverid, taxiid)
values (1, 6);
insert into DRIVESINTAXI (driverid, taxiid)
values (292, 287);
insert into DRIVESINTAXI (driverid, taxiid)
values (297, 264);
insert into DRIVESINTAXI (driverid, taxiid)
values (69, 110);
insert into DRIVESINTAXI (driverid, taxiid)
values (272, 33);
insert into DRIVESINTAXI (driverid, taxiid)
values (385, 338);
insert into DRIVESINTAXI (driverid, taxiid)
values (184, 355);
insert into DRIVESINTAXI (driverid, taxiid)
values (345, 202);
insert into DRIVESINTAXI (driverid, taxiid)
values (253, 168);
insert into DRIVESINTAXI (driverid, taxiid)
values (128, 386);
insert into DRIVESINTAXI (driverid, taxiid)
values (321, 279);
insert into DRIVESINTAXI (driverid, taxiid)
values (56, 230);
insert into DRIVESINTAXI (driverid, taxiid)
values (39, 379);
insert into DRIVESINTAXI (driverid, taxiid)
values (34, 5);
insert into DRIVESINTAXI (driverid, taxiid)
values (4, 384);
insert into DRIVESINTAXI (driverid, taxiid)
values (230, 193);
insert into DRIVESINTAXI (driverid, taxiid)
values (352, 297);
insert into DRIVESINTAXI (driverid, taxiid)
values (366, 231);
insert into DRIVESINTAXI (driverid, taxiid)
values (242, 92);
insert into DRIVESINTAXI (driverid, taxiid)
values (299, 52);
insert into DRIVESINTAXI (driverid, taxiid)
values (137, 398);
insert into DRIVESINTAXI (driverid, taxiid)
values (234, 267);
insert into DRIVESINTAXI (driverid, taxiid)
values (111, 96);
insert into DRIVESINTAXI (driverid, taxiid)
values (270, 148);
insert into DRIVESINTAXI (driverid, taxiid)
values (287, 208);
insert into DRIVESINTAXI (driverid, taxiid)
values (224, 222);
insert into DRIVESINTAXI (driverid, taxiid)
values (41, 376);
insert into DRIVESINTAXI (driverid, taxiid)
values (10, 59);
insert into DRIVESINTAXI (driverid, taxiid)
values (282, 333);
insert into DRIVESINTAXI (driverid, taxiid)
values (150, 270);
insert into DRIVESINTAXI (driverid, taxiid)
values (22, 43);
insert into DRIVESINTAXI (driverid, taxiid)
values (63, 269);
insert into DRIVESINTAXI (driverid, taxiid)
values (167, 318);
insert into DRIVESINTAXI (driverid, taxiid)
values (333, 242);
insert into DRIVESINTAXI (driverid, taxiid)
values (339, 204);
insert into DRIVESINTAXI (driverid, taxiid)
values (390, 268);
insert into DRIVESINTAXI (driverid, taxiid)
values (245, 321);
insert into DRIVESINTAXI (driverid, taxiid)
values (2, 32);
insert into DRIVESINTAXI (driverid, taxiid)
values (29, 260);
insert into DRIVESINTAXI (driverid, taxiid)
values (230, 278);
insert into DRIVESINTAXI (driverid, taxiid)
values (99, 224);
insert into DRIVESINTAXI (driverid, taxiid)
values (20, 39);
insert into DRIVESINTAXI (driverid, taxiid)
values (270, 18);
insert into DRIVESINTAXI (driverid, taxiid)
values (297, 201);
insert into DRIVESINTAXI (driverid, taxiid)
values (135, 162);
insert into DRIVESINTAXI (driverid, taxiid)
values (340, 25);
insert into DRIVESINTAXI (driverid, taxiid)
values (279, 41);
insert into DRIVESINTAXI (driverid, taxiid)
values (90, 192);
insert into DRIVESINTAXI (driverid, taxiid)
values (58, 77);
insert into DRIVESINTAXI (driverid, taxiid)
values (178, 1);
insert into DRIVESINTAXI (driverid, taxiid)
values (158, 210);
insert into DRIVESINTAXI (driverid, taxiid)
values (331, 62);
insert into DRIVESINTAXI (driverid, taxiid)
values (265, 299);
insert into DRIVESINTAXI (driverid, taxiid)
values (120, 343);
insert into DRIVESINTAXI (driverid, taxiid)
values (244, 118);
insert into DRIVESINTAXI (driverid, taxiid)
values (136, 298);
insert into DRIVESINTAXI (driverid, taxiid)
values (167, 353);
insert into DRIVESINTAXI (driverid, taxiid)
values (144, 326);
insert into DRIVESINTAXI (driverid, taxiid)
values (194, 91);
insert into DRIVESINTAXI (driverid, taxiid)
values (99, 313);
insert into DRIVESINTAXI (driverid, taxiid)
values (234, 390);
insert into DRIVESINTAXI (driverid, taxiid)
values (377, 284);
insert into DRIVESINTAXI (driverid, taxiid)
values (197, 29);
insert into DRIVESINTAXI (driverid, taxiid)
values (110, 324);
insert into DRIVESINTAXI (driverid, taxiid)
values (168, 37);
insert into DRIVESINTAXI (driverid, taxiid)
values (171, 201);
insert into DRIVESINTAXI (driverid, taxiid)
values (305, 73);
insert into DRIVESINTAXI (driverid, taxiid)
values (295, 46);
insert into DRIVESINTAXI (driverid, taxiid)
values (397, 284);
insert into DRIVESINTAXI (driverid, taxiid)
values (303, 319);
insert into DRIVESINTAXI (driverid, taxiid)
values (290, 300);
insert into DRIVESINTAXI (driverid, taxiid)
values (279, 219);
insert into DRIVESINTAXI (driverid, taxiid)
values (99, 387);
insert into DRIVESINTAXI (driverid, taxiid)
values (305, 176);
insert into DRIVESINTAXI (driverid, taxiid)
values (33, 238);
insert into DRIVESINTAXI (driverid, taxiid)
values (377, 159);
insert into DRIVESINTAXI (driverid, taxiid)
values (144, 197);
insert into DRIVESINTAXI (driverid, taxiid)
values (116, 68);
insert into DRIVESINTAXI (driverid, taxiid)
values (26, 213);
insert into DRIVESINTAXI (driverid, taxiid)
values (308, 127);
insert into DRIVESINTAXI (driverid, taxiid)
values (170, 318);
insert into DRIVESINTAXI (driverid, taxiid)
values (60, 138);
insert into DRIVESINTAXI (driverid, taxiid)
values (11, 115);
insert into DRIVESINTAXI (driverid, taxiid)
values (236, 134);
insert into DRIVESINTAXI (driverid, taxiid)
values (173, 85);
insert into DRIVESINTAXI (driverid, taxiid)
values (344, 281);
insert into DRIVESINTAXI (driverid, taxiid)
values (135, 389);
insert into DRIVESINTAXI (driverid, taxiid)
values (135, 360);
insert into DRIVESINTAXI (driverid, taxiid)
values (235, 172);
commit;
prompt 300 records committed...
insert into DRIVESINTAXI (driverid, taxiid)
values (92, 88);
insert into DRIVESINTAXI (driverid, taxiid)
values (236, 56);
insert into DRIVESINTAXI (driverid, taxiid)
values (276, 8);
insert into DRIVESINTAXI (driverid, taxiid)
values (364, 220);
insert into DRIVESINTAXI (driverid, taxiid)
values (292, 4);
insert into DRIVESINTAXI (driverid, taxiid)
values (49, 156);
insert into DRIVESINTAXI (driverid, taxiid)
values (47, 174);
insert into DRIVESINTAXI (driverid, taxiid)
values (70, 296);
insert into DRIVESINTAXI (driverid, taxiid)
values (275, 115);
insert into DRIVESINTAXI (driverid, taxiid)
values (343, 212);
insert into DRIVESINTAXI (driverid, taxiid)
values (287, 350);
insert into DRIVESINTAXI (driverid, taxiid)
values (56, 167);
insert into DRIVESINTAXI (driverid, taxiid)
values (120, 160);
insert into DRIVESINTAXI (driverid, taxiid)
values (177, 127);
insert into DRIVESINTAXI (driverid, taxiid)
values (356, 145);
insert into DRIVESINTAXI (driverid, taxiid)
values (46, 13);
insert into DRIVESINTAXI (driverid, taxiid)
values (177, 369);
insert into DRIVESINTAXI (driverid, taxiid)
values (284, 302);
insert into DRIVESINTAXI (driverid, taxiid)
values (321, 235);
insert into DRIVESINTAXI (driverid, taxiid)
values (322, 154);
insert into DRIVESINTAXI (driverid, taxiid)
values (121, 323);
insert into DRIVESINTAXI (driverid, taxiid)
values (180, 376);
insert into DRIVESINTAXI (driverid, taxiid)
values (273, 141);
insert into DRIVESINTAXI (driverid, taxiid)
values (204, 203);
insert into DRIVESINTAXI (driverid, taxiid)
values (330, 241);
insert into DRIVESINTAXI (driverid, taxiid)
values (197, 197);
insert into DRIVESINTAXI (driverid, taxiid)
values (365, 22);
insert into DRIVESINTAXI (driverid, taxiid)
values (241, 52);
insert into DRIVESINTAXI (driverid, taxiid)
values (389, 292);
insert into DRIVESINTAXI (driverid, taxiid)
values (45, 211);
insert into DRIVESINTAXI (driverid, taxiid)
values (381, 103);
insert into DRIVESINTAXI (driverid, taxiid)
values (133, 272);
insert into DRIVESINTAXI (driverid, taxiid)
values (312, 332);
insert into DRIVESINTAXI (driverid, taxiid)
values (289, 86);
insert into DRIVESINTAXI (driverid, taxiid)
values (19, 124);
insert into DRIVESINTAXI (driverid, taxiid)
values (377, 347);
insert into DRIVESINTAXI (driverid, taxiid)
values (101, 65);
insert into DRIVESINTAXI (driverid, taxiid)
values (363, 350);
insert into DRIVESINTAXI (driverid, taxiid)
values (312, 13);
insert into DRIVESINTAXI (driverid, taxiid)
values (40, 329);
insert into DRIVESINTAXI (driverid, taxiid)
values (17, 32);
insert into DRIVESINTAXI (driverid, taxiid)
values (302, 260);
insert into DRIVESINTAXI (driverid, taxiid)
values (167, 186);
insert into DRIVESINTAXI (driverid, taxiid)
values (253, 317);
insert into DRIVESINTAXI (driverid, taxiid)
values (387, 218);
insert into DRIVESINTAXI (driverid, taxiid)
values (200, 295);
insert into DRIVESINTAXI (driverid, taxiid)
values (25, 272);
insert into DRIVESINTAXI (driverid, taxiid)
values (230, 164);
insert into DRIVESINTAXI (driverid, taxiid)
values (131, 294);
insert into DRIVESINTAXI (driverid, taxiid)
values (195, 77);
insert into DRIVESINTAXI (driverid, taxiid)
values (256, 261);
insert into DRIVESINTAXI (driverid, taxiid)
values (222, 206);
insert into DRIVESINTAXI (driverid, taxiid)
values (11, 276);
insert into DRIVESINTAXI (driverid, taxiid)
values (175, 109);
insert into DRIVESINTAXI (driverid, taxiid)
values (273, 78);
insert into DRIVESINTAXI (driverid, taxiid)
values (178, 218);
insert into DRIVESINTAXI (driverid, taxiid)
values (210, 10);
insert into DRIVESINTAXI (driverid, taxiid)
values (16, 146);
insert into DRIVESINTAXI (driverid, taxiid)
values (370, 383);
insert into DRIVESINTAXI (driverid, taxiid)
values (148, 197);
insert into DRIVESINTAXI (driverid, taxiid)
values (236, 288);
insert into DRIVESINTAXI (driverid, taxiid)
values (334, 188);
insert into DRIVESINTAXI (driverid, taxiid)
values (287, 195);
insert into DRIVESINTAXI (driverid, taxiid)
values (3, 163);
insert into DRIVESINTAXI (driverid, taxiid)
values (349, 382);
insert into DRIVESINTAXI (driverid, taxiid)
values (176, 97);
insert into DRIVESINTAXI (driverid, taxiid)
values (103, 142);
insert into DRIVESINTAXI (driverid, taxiid)
values (77, 192);
insert into DRIVESINTAXI (driverid, taxiid)
values (111, 6);
insert into DRIVESINTAXI (driverid, taxiid)
values (24, 240);
insert into DRIVESINTAXI (driverid, taxiid)
values (245, 133);
insert into DRIVESINTAXI (driverid, taxiid)
values (346, 271);
insert into DRIVESINTAXI (driverid, taxiid)
values (65, 103);
insert into DRIVESINTAXI (driverid, taxiid)
values (129, 358);
insert into DRIVESINTAXI (driverid, taxiid)
values (235, 260);
insert into DRIVESINTAXI (driverid, taxiid)
values (115, 381);
insert into DRIVESINTAXI (driverid, taxiid)
values (136, 56);
insert into DRIVESINTAXI (driverid, taxiid)
values (170, 256);
insert into DRIVESINTAXI (driverid, taxiid)
values (148, 121);
insert into DRIVESINTAXI (driverid, taxiid)
values (245, 397);
insert into DRIVESINTAXI (driverid, taxiid)
values (363, 126);
insert into DRIVESINTAXI (driverid, taxiid)
values (240, 327);
insert into DRIVESINTAXI (driverid, taxiid)
values (8, 167);
insert into DRIVESINTAXI (driverid, taxiid)
values (298, 223);
insert into DRIVESINTAXI (driverid, taxiid)
values (344, 314);
insert into DRIVESINTAXI (driverid, taxiid)
values (349, 288);
insert into DRIVESINTAXI (driverid, taxiid)
values (298, 280);
insert into DRIVESINTAXI (driverid, taxiid)
values (207, 146);
insert into DRIVESINTAXI (driverid, taxiid)
values (219, 45);
insert into DRIVESINTAXI (driverid, taxiid)
values (64, 153);
insert into DRIVESINTAXI (driverid, taxiid)
values (1, 372);
insert into DRIVESINTAXI (driverid, taxiid)
values (73, 216);
insert into DRIVESINTAXI (driverid, taxiid)
values (370, 282);
insert into DRIVESINTAXI (driverid, taxiid)
values (263, 222);
insert into DRIVESINTAXI (driverid, taxiid)
values (169, 204);
insert into DRIVESINTAXI (driverid, taxiid)
values (85, 253);
insert into DRIVESINTAXI (driverid, taxiid)
values (249, 64);
insert into DRIVESINTAXI (driverid, taxiid)
values (222, 103);
insert into DRIVESINTAXI (driverid, taxiid)
values (204, 43);
insert into DRIVESINTAXI (driverid, taxiid)
values (169, 75);
commit;
prompt 400 records loaded
prompt Enabling triggers for BUS...
alter table BUS enable all triggers;
prompt Enabling triggers for SCHEDULE...
alter table SCHEDULE enable all triggers;
prompt Enabling triggers for STATION...
alter table STATION enable all triggers;
prompt Enabling triggers for LINE...
alter table LINE enable all triggers;
prompt Enabling triggers for BUSRIDE...
alter table BUSRIDE enable all triggers;
prompt Enabling triggers for DRIVER...
alter table DRIVER enable all triggers;
prompt Enabling triggers for TAXI...
alter table TAXI enable all triggers;
prompt Enabling triggers for DRIVESINTAXI...
alter table DRIVESINTAXI enable all triggers;

set feedback on
set define on
prompt Done
