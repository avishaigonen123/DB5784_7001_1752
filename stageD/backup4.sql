prompt PL/SQL Developer Export Tables for user C##AVISHAI@XE
prompt Created by avish on Tuesday, July 9, 2024
set feedback off
set define off

prompt Creating TICKET...
create table TICKET
(
  ticket_id    NUMBER(38) not null,
  ticket_type  VARCHAR2(255) default 'Regular' not null,
  ticket_price FLOAT not null
)
;
alter table TICKET
  add primary key (TICKET_ID);
alter table TICKET
  add constraint CHK_TICKET_PRICE_POSITIVE
  check (Ticket_price > 0);

prompt Creating BAGGAGE...
create table BAGGAGE
(
  baggage_id     NUMBER(38) not null,
  baggage_type   VARCHAR2(255) not null,
  baggage_weight FLOAT not null,
  ticket_id      NUMBER(38) not null
)
;
alter table BAGGAGE
  add primary key (BAGGAGE_ID);
alter table BAGGAGE
  add foreign key (TICKET_ID)
  references TICKET (TICKET_ID);
alter table BAGGAGE
  add constraint CHECK_BAGGAGE_WEIGHT
  check (Baggage_weight >= 0);

prompt Creating PASSENGER...
create table PASSENGER
(
  passenger_id    NUMBER(38) not null,
  passenger_name  VARCHAR2(255) not null,
  passenger_phone VARCHAR2(15) not null,
  passenger_email VARCHAR2(255) not null
)
;
alter table PASSENGER
  add primary key (PASSENGER_ID);

prompt Creating TICKETSELLER...
create table TICKETSELLER
(
  seller_id      NUMBER(38) not null,
  seller_name    VARCHAR2(255) not null,
  seller_contact VARCHAR2(255) not null
)
;
alter table TICKETSELLER
  add primary key (SELLER_ID);
alter table TICKETSELLER
  add constraint CHECK_SELLER_CONTACT
  check (LENGTH(Seller_contact) <= 20);

prompt Creating BOOKING...
create table BOOKING
(
  booking_id   NUMBER(38) default '-1' not null,
  journey_id   NUMBER(38) not null,
  booking_date DATE not null,
  passenger_id NUMBER(38) not null,
  seller_id    NUMBER(38) not null,
  ticket_id    NUMBER(38) not null
)
;
alter table BOOKING
  add primary key (BOOKING_ID);
alter table BOOKING
  add constraint UC_BOOKING_JOURNEYID unique (JOURNEY_ID);
alter table BOOKING
  add foreign key (PASSENGER_ID)
  references PASSENGER (PASSENGER_ID);
alter table BOOKING
  add foreign key (SELLER_ID)
  references TICKETSELLER (SELLER_ID);
alter table BOOKING
  add foreign key (TICKET_ID)
  references TICKET (TICKET_ID);
alter table BOOKING
  add constraint CHK_ID_POSITIVE
  check (Booking_id > 0);

prompt Creating BUS...
create table BUS
(
  busid        INTEGER not null,
  licenseplate VARCHAR2(100) not null,
  model        VARCHAR2(100) not null,
  capacity     INTEGER not null,
  purchasedate DATE not null
)
;
alter table BUS
  add primary key (BUSID);

prompt Creating DRIVER...
create table DRIVER
(
  driverid      INTEGER not null,
  fullname      VARCHAR2(100) default 'Dekel Vaknin' not null,
  licensenumber VARCHAR2(14) not null,
  hiredate      DATE not null
)
;
alter table DRIVER
  add primary key (DRIVERID);

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
  driverid   INTEGER not null,
  starttime  VARCHAR2(8) not null,
  finishtime VARCHAR2(8) not null,
  ticketid   NUMBER(38)
)
;
alter table BUSRIDE
  add primary key (BUSID, LINEID, DRIVERID);
alter table BUSRIDE
  add constraint FK_TICKETID foreign key (TICKETID)
  references TICKET (TICKET_ID);
alter table BUSRIDE
  add foreign key (BUSID)
  references BUS (BUSID);
alter table BUSRIDE
  add foreign key (LINEID)
  references LINE (LINEID);
alter table BUSRIDE
  add foreign key (DRIVERID)
  references DRIVER (DRIVERID);
alter table BUSRIDE
  add constraint CHK_FINISHTIME1
  check (REGEXP_LIKE(FinishTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));
alter table BUSRIDE
  add constraint CHK_STARTTIME1
  check (REGEXP_LIKE(StartTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));

prompt Creating TAXI...
create table TAXI
(
  taxiid       INTEGER not null,
  licenseplate VARCHAR2(100) not null,
  model        VARCHAR2(100) not null,
  capacity     INTEGER not null,
  purchasedate DATE not null
)
;
alter table TAXI
  add primary key (TAXIID);

prompt Creating DRIVESINTAXI...
create table DRIVESINTAXI
(
  driverid    INTEGER not null,
  taxiid      INTEGER not null,
  starttime   VARCHAR2(8) not null,
  finishtime  VARCHAR2(8) not null,
  workingzone VARCHAR2(100) not null
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
alter table DRIVESINTAXI
  add constraint CHK_FINISHTIME2
  check (REGEXP_LIKE(FinishTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));
alter table DRIVESINTAXI
  add constraint CHK_STARTTIME2
  check (REGEXP_LIKE(StartTime, '^\d{1,2}:\d{1,2}:\d{1,2}$'));

prompt Creating PAYMENT_REPORT...
create table PAYMENT_REPORT
(
  payment_id   NUMBER(38) not null,
  payment_date DATE not null,
  booking_id   NUMBER(38) not null
)
;
alter table PAYMENT_REPORT
  add primary key (PAYMENT_ID);
alter table PAYMENT_REPORT
  add foreign key (BOOKING_ID)
  references BOOKING (BOOKING_ID);
alter table PAYMENT_REPORT
  add constraint CHK_P_POSITIVE
  check (Payment_id > 0);

prompt Disabling triggers for TICKET...
alter table TICKET disable all triggers;
prompt Disabling triggers for BAGGAGE...
alter table BAGGAGE disable all triggers;
prompt Disabling triggers for PASSENGER...
alter table PASSENGER disable all triggers;
prompt Disabling triggers for TICKETSELLER...
alter table TICKETSELLER disable all triggers;
prompt Disabling triggers for BOOKING...
alter table BOOKING disable all triggers;
prompt Disabling triggers for BUS...
alter table BUS disable all triggers;
prompt Disabling triggers for DRIVER...
alter table DRIVER disable all triggers;
prompt Disabling triggers for SCHEDULE...
alter table SCHEDULE disable all triggers;
prompt Disabling triggers for STATION...
alter table STATION disable all triggers;
prompt Disabling triggers for LINE...
alter table LINE disable all triggers;
prompt Disabling triggers for BUSRIDE...
alter table BUSRIDE disable all triggers;
prompt Disabling triggers for TAXI...
alter table TAXI disable all triggers;
prompt Disabling triggers for DRIVESINTAXI...
alter table DRIVESINTAXI disable all triggers;
prompt Disabling triggers for PAYMENT_REPORT...
alter table PAYMENT_REPORT disable all triggers;
prompt Loading TICKET...
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359768, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (248697, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (279796, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (267055, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (302711, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (362218, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (320413, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (288052, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (304607, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (301396, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (377698, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (266880, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (317898, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (262517, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (290628, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (318228, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (353284, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (355220, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (341909, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (253634, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (348727, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (208308, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (280748, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (252438, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (378711, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (225649, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (354193, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (280838, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (367909, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (362585, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (205586, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (233295, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (226597, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (320865, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (286275, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (347981, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (232664, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (357550, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (214126, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (355503, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (202546, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (240857, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (339979, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (237614, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (220954, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (203421, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (290598, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (200137, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (236715, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (380933, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (274241, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (361814, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (249583, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (211623, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (342428, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (328298, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (200361, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (269579, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (258996, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (388023, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (244178, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (312333, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (205059, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (224137, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (234262, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (290713, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (315937, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (204263, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (331052, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (286423, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (323658, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (287258, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (329005, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (330304, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (246151, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (373729, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (280924, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (341768, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (261679, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (274497, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (297159, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (287362, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (234640, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (368749, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (294531, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (323926, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (356322, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (271073, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (327313, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359321, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (231694, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (284124, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (280109, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (221198, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (250849, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (201113, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (219997, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (341774, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (201163, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (329850, 'special', 15);
commit;
prompt 100 records committed...
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (282744, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (254067, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (383794, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (347562, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (345475, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (222599, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (285589, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (383198, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (355607, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (358995, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (355023, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (221448, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (333412, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (360459, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (318220, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (360186, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (253053, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (206616, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (248698, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (340551, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (244416, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (297661, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (201894, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (266414, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (275611, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (324295, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (353090, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (267411, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (233459, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (387418, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (204805, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (307284, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (226832, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (333053, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (227283, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (316747, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (225168, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (345455, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (223134, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (297586, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (282022, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (378885, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (344750, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (282225, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (360991, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (236016, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (290567, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (270464, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (348848, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (248439, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (233794, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (312614, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (318244, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (282232, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (244674, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (385754, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (389815, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (349074, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (334886, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (327311, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (351026, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (260861, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (260182, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (327703, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (376626, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (373297, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (354851, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (251245, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (253014, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (381422, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (349099, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (282054, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (256411, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (207566, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (387947, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (309155, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (232131, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (229674, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (347733, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (309834, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (235481, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (243817, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (239240, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (277084, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (335506, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (200579, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (256601, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (381067, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (275336, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (212311, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (276188, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (295791, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (285166, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (351081, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (240835, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (259651, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (382058, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (225184, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (293579, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (265664, 'special', 15);
commit;
prompt 200 records committed...
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (217895, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (339261, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (255356, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (264231, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (283508, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (264672, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (335660, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (205785, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (386915, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (356241, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (347873, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (318149, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (301174, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (308940, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (258498, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (350947, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (304802, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (245624, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (387007, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (366935, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (335224, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (384407, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (380512, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (387567, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (323236, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (321758, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (315006, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (237657, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (333939, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (344944, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (292365, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (221484, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (327117, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (204870, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (269838, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (270157, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (347525, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (327952, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (386254, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (377628, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (293063, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (233082, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (386651, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (250149, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (356294, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (367307, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (214552, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (321559, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (242282, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (321292, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (278613, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (254205, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (253223, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (303183, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (327842, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (212885, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (347818, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (256940, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (287133, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (366610, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (360889, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (368758, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (372315, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (200561, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (246170, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (292646, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (321442, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (218086, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (202775, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (363782, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (286548, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (300049, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (213289, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (325716, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (277566, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (246410, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (278958, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (265028, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (227660, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (282365, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (214952, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (324534, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (326661, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (308883, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (386163, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (373619, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (366837, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (334999, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (251504, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (291820, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (312727, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (206690, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (372197, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (239221, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (364232, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (214701, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (286981, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (334772, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (349703, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (221131, 'regular', 10);
commit;
prompt 300 records committed...
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (284760, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (351124, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (233243, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (312159, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (332607, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (272070, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (337928, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (331725, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (294631, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (326187, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (314173, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (258532, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (304661, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (297770, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (299980, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (206191, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (203216, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (243663, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (357246, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (203874, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (226730, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (232061, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (205893, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (342305, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (244497, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (376900, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (375014, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359769, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359770, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359771, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359772, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359773, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359774, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359775, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359776, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359777, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359778, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359779, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359780, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359781, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359782, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359783, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359784, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359785, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359786, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359787, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359788, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359789, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359790, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359791, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359792, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359793, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359794, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359795, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359796, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359797, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359798, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359799, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359800, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359801, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359802, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359803, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359804, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359805, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359806, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359807, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359808, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359809, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359810, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359811, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359812, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359813, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359814, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359815, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359816, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359817, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359818, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359819, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359820, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359821, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359822, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359823, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359824, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359825, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359826, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359827, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359828, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359829, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359830, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359831, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359832, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359833, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359834, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359835, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359836, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359837, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359838, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359839, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359840, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359841, 'regular', 10);
commit;
prompt 400 records committed...
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359842, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359843, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359844, 'handicapped', 5);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359845, 'special', 15);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359846, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (359847, 'regular', 10);
insert into TICKET (ticket_id, ticket_type, ticket_price)
values (3232116, '9', 1.5);
commit;
prompt 407 records loaded
prompt Loading BAGGAGE...
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9576, 'Bag', 5, 381422);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2664, 'Heavy', 10, 312614);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9897, 'Special', 2, 377698);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4476, 'Special', 6, 282365);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8060, 'Bag', 9, 299980);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7929, 'Special', 6, 327313);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5542, 'Special', 8, 308883);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9244, 'Suitcase', 9, 221131);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8582, 'Bag', 3, 225649);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5065, 'Suitcase', 6, 270157);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7523, 'Bag', 3, 256411);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1495, 'Bag', 0, 236016);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3322, 'Suitcase', 7, 297770);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5855, 'Bag', 2, 328298);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2961, 'Bag', 7, 331052);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3247, 'Bag', 4, 324534);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8667, 'Suitcase', 2, 235481);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7940, 'Special', 1, 232061);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9952, 'Bag', 0, 320865);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9559, 'Bag', 5, 224137);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5464, 'Suitcase', 4, 284124);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3095, 'Suitcase', 7, 362585);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9648, 'Bag', 6, 355023);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3721, 'Bag', 0, 320413);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8218, 'Special', 2, 206191);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1423, 'Bag', 1, 326187);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6449, 'Suitcase', 3, 312159);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8446, 'Suitcase', 4, 387418);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8273, 'Special', 3, 256940);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1541, 'Special', 9, 290567);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7192, 'Heavy', 10, 321758);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2047, 'Bag', 6, 200561);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7002, 'Special', 3, 234262);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5762, 'Bag', 6, 364232);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9333, 'Special', 0, 234262);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5639, 'Special', 3, 233295);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3992, 'Special', 9, 308883);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8291, 'Special', 3, 233243);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7137, 'Special', 6, 327117);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8311, 'Suitcase', 7, 333053);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3237, 'Suitcase', 5, 205785);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1403, 'Heavy', 10, 225168);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6871, 'Suitcase', 5, 357550);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9325, 'Bag', 9, 214126);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1318, 'Special', 7, 225168);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8642, 'Heavy', 10, 282232);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5980, 'Suitcase', 6, 326661);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6298, 'Bag', 2, 303183);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2596, 'Suitcase', 2, 388023);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9997, 'Bag', 0, 345475);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8287, 'Suitcase', 0, 334772);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1391, 'Special', 2, 262517);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7399, 'Special', 6, 282365);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2096, 'Bag', 0, 250849);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3171, 'Suitcase', 1, 205785);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7500, 'Special', 9, 283508);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9206, 'Bag', 6, 271073);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4396, 'Special', 2, 327117);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7759, 'Bag', 1, 292646);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9433, 'Suitcase', 0, 329005);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9837, 'Suitcase', 9, 320865);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2361, 'Special', 5, 308883);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1111, 'Bag', 7, 253014);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6110, 'Bag', 0, 360991);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7642, 'Bag', 6, 202775);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7660, 'Special', 4, 294631);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2413, 'Suitcase', 7, 354193);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7743, 'Bag', 6, 278613);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3686, 'Bag', 5, 265664);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1344, 'Suitcase', 6, 326187);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5158, 'Suitcase', 8, 320413);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6025, 'Bag', 6, 244674);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7938, 'Suitcase', 9, 329850);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3046, 'Suitcase', 8, 308940);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1334, 'Special', 5, 232061);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7320, 'Bag', 0, 335506);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9456, 'Bag', 1, 355023);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5157, 'Special', 0, 309155);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5619, 'Special', 3, 335224);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2845, 'Special', 8, 327952);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9578, 'Special', 7, 384407);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6020, 'Heavy', 10, 347525);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7558, 'Heavy', 10, 372315);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1865, 'Special', 8, 368749);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1106, 'Bag', 3, 242282);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7115, 'Heavy', 10, 349703);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4757, 'Bag', 4, 320413);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1874, 'Special', 3, 205893);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1499, 'Bag', 1, 282022);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1247, 'Suitcase', 2, 345475);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9071, 'Special', 3, 278958);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3785, 'Bag', 0, 234640);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5053, 'Special', 0, 386163);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5736, 'Bag', 0, 339261);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7787, 'Suitcase', 1, 339261);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9118, 'Special', 5, 368758);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7094, 'Special', 9, 239240);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5598, 'Bag', 0, 326661);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5816, 'Special', 1, 223134);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8186, 'Special', 9, 293063);
commit;
prompt 100 records committed...
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1163, 'Special', 3, 258996);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4740, 'Special', 3, 348848);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4877, 'Heavy', 10, 262517);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4285, 'Suitcase', 7, 244674);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3205, 'Special', 3, 212311);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5143, 'Special', 7, 290628);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9689, 'Special', 4, 386163);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1878, 'Special', 5, 318149);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3757, 'Bag', 5, 292365);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4052, 'Suitcase', 5, 260182);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7150, 'Bag', 7, 366837);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3788, 'Special', 3, 354193);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1131, 'Bag', 7, 282054);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9160, 'Special', 4, 321442);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8536, 'Bag', 9, 207566);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8378, 'Heavy', 10, 237657);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7609, 'Suitcase', 9, 342305);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8799, 'Bag', 3, 354193);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1678, 'Heavy', 10, 293063);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6744, 'Suitcase', 7, 282232);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1622, 'Special', 7, 294631);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5127, 'Special', 4, 387418);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2159, 'Special', 9, 253223);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6901, 'Suitcase', 1, 253053);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5946, 'Suitcase', 3, 280838);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2312, 'Bag', 4, 292646);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5492, 'Heavy', 10, 280924);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3970, 'Heavy', 10, 274497);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3881, 'Heavy', 10, 372197);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3725, 'Suitcase', 0, 231694);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2313, 'Bag', 8, 203216);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4367, 'Special', 2, 386163);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8448, 'Special', 6, 335506);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9125, 'Bag', 7, 277084);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2569, 'Bag', 9, 267055);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4988, 'Bag', 4, 327842);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5565, 'Bag', 8, 304661);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2841, 'Special', 0, 204263);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5705, 'Special', 2, 381422);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8401, 'Heavy', 10, 261679);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5247, 'Heavy', 10, 251245);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4972, 'Bag', 3, 233794);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6847, 'Bag', 1, 269838);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2024, 'Special', 1, 204263);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2783, 'Heavy', 10, 329005);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5563, 'Heavy', 10, 315937);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2995, 'Heavy', 10, 300049);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9328, 'Suitcase', 4, 341768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2930, 'Suitcase', 6, 207566);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6797, 'Bag', 3, 334772);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8210, 'Special', 5, 288052);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6006, 'Suitcase', 3, 282225);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8099, 'Bag', 2, 201163);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2181, 'Suitcase', 5, 235481);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5797, 'Suitcase', 0, 355607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7178, 'Special', 2, 307284);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6538, 'Suitcase', 0, 233082);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9740, 'Special', 8, 381067);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8499, 'Bag', 8, 293579);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1565, 'Suitcase', 9, 290598);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5528, 'Suitcase', 9, 222599);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6191, 'Suitcase', 8, 368758);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2684, 'Special', 2, 266880);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1561, 'Suitcase', 9, 321292);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5147, 'Special', 5, 353090);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3508, 'Heavy', 10, 269579);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1034, 'Bag', 5, 359802);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4539, 'Bag', 0, 351124);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9291, 'Special', 6, 242282);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8158, 'Bag', 2, 335224);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6283, 'Special', 2, 204263);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7948, 'Special', 2, 321559);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7569, 'Bag', 7, 347733);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9983, 'Special', 5, 344750);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8454, 'Bag', 5, 244674);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4055, 'Suitcase', 5, 294531);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8379, 'Suitcase', 1, 253014);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9710, 'Bag', 4, 236016);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2112, 'Heavy', 10, 250149);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8095, 'Special', 9, 324295);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9757, 'Bag', 8, 253014);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2623, 'Bag', 7, 202546);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1560, 'Special', 4, 356322);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1451, 'Suitcase', 5, 375014);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5561, 'Special', 9, 333053);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2758, 'Heavy', 10, 356322);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2015, 'Suitcase', 9, 368749);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9854, 'Suitcase', 6, 202775);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9666, 'Special', 0, 362218);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4082, 'Special', 2, 232061);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3801, 'Special', 5, 326661);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1556, 'Suitcase', 5, 355023);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8144, 'Heavy', 10, 353284);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4685, 'Heavy', 10, 205785);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9538, 'Bag', 8, 226597);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1530, 'Suitcase', 4, 321292);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1455, 'Heavy', 10, 353284);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3966, 'Suitcase', 0, 303183);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7651, 'Suitcase', 1, 243663);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1637, 'Bag', 8, 222599);
commit;
prompt 200 records committed...
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8821, 'Bag', 6, 378711);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1925, 'Special', 0, 227283);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5884, 'Special', 4, 297586);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2487, 'Suitcase', 4, 366837);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3832, 'Bag', 2, 231694);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6972, 'Suitcase', 7, 274497);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3471, 'Bag', 0, 202546);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3755, 'Special', 4, 248698);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2452, 'Bag', 3, 355503);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2132, 'Bag', 3, 280838);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8124, 'Special', 3, 387947);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8327, 'Special', 9, 302711);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8194, 'Bag', 0, 280109);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4305, 'Bag', 2, 383794);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7204, 'Bag', 6, 256411);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1413, 'Bag', 1, 212311);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2816, 'Suitcase', 7, 345475);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6812, 'Suitcase', 0, 212885);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9916, 'Special', 3, 285589);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1739, 'Bag', 3, 294531);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6516, 'Special', 0, 259651);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3578, 'Bag', 0, 303183);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8491, 'Special', 7, 282022);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4731, 'Heavy', 10, 318149);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3107, 'Bag', 8, 261679);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4323, 'Bag', 5, 332607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2376, 'Bag', 7, 277084);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6699, 'Heavy', 10, 387007);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9217, 'Bag', 8, 353284);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4749, 'Special', 8, 205059);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4425, 'Special', 9, 259651);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2031, 'Special', 0, 373297);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8468, 'Suitcase', 3, 318244);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1725, 'Special', 2, 327952);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2077, 'Bag', 1, 253014);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7379, 'Special', 7, 277084);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2667, 'Bag', 2, 389815);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8481, 'Special', 9, 291820);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8555, 'Bag', 8, 383794);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4841, 'Bag', 2, 248698);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8997, 'Special', 8, 351081);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6784, 'Suitcase', 4, 202546);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6042, 'Bag', 0, 357246);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2155, 'Bag', 6, 282054);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3193, 'Suitcase', 4, 233082);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7139, 'Special', 0, 314173);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5880, 'Bag', 3, 201894);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2886, 'Suitcase', 8, 387567);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6745, 'Suitcase', 5, 280924);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9966, 'Bag', 4, 227660);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9748, 'Suitcase', 8, 274497);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3610, 'Suitcase', 6, 225168);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3072, 'Suitcase', 8, 333939);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2792, 'Suitcase', 8, 274497);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6854, 'Special', 2, 362585);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9102, 'Suitcase', 3, 204263);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6717, 'Suitcase', 2, 362218);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2440, 'Suitcase', 3, 387418);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7124, 'Bag', 0, 200137);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2526, 'Bag', 6, 360186);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6534, 'Suitcase', 7, 287362);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7213, 'Suitcase', 5, 353090);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2383, 'Bag', 2, 201113);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5622, 'Heavy', 10, 272070);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7871, 'Special', 7, 285166);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3082, 'Bag', 5, 362218);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8554, 'Special', 6, 302711);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3890, 'Suitcase', 4, 270157);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2762, 'Heavy', 10, 250849);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5876, 'Special', 5, 254205);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8829, 'Special', 3, 222599);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3116, 'Suitcase', 0, 293579);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4467, 'Suitcase', 9, 377628);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4873, 'Bag', 7, 333939);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8893, 'Heavy', 10, 342428);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1896, 'Suitcase', 3, 233082);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2959, 'Bag', 2, 229674);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5002, 'Special', 5, 317898);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5130, 'Bag', 4, 355023);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6317, 'Bag', 5, 367307);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8875, 'Bag', 7, 383198);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3373, 'Special', 2, 256601);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5925, 'Special', 8, 265664);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8025, 'Special', 1, 256411);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3343, 'Suitcase', 0, 335660);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4170, 'Special', 2, 321442);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7405, 'Suitcase', 7, 333412);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7290, 'Bag', 6, 292365);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1288, 'Heavy', 10, 248698);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9795, 'Heavy', 10, 354851);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (6585, 'Heavy', 10, 246151);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1190, 'Bag', 5, 265664);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3613, 'Suitcase', 1, 270157);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9051, 'Special', 0, 347733);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7556, 'Bag', 1, 287258);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7804, 'Bag', 9, 244178);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3393, 'Suitcase', 6, 236715);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9671, 'Bag', 7, 244674);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9392, 'Special', 0, 326187);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1057, 'Special', 7, 294531);
commit;
prompt 300 records committed...
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2817, 'Bag', 7, 386915);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (4733, 'Special', 0, 201113);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3584, 'Suitcase', 2, 286981);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1579, 'Special', 6, 253223);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7640, 'Suitcase', 5, 344944);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1184, 'Heavy', 10, 355220);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3291, 'Bag', 4, 361814);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2305, 'Special', 9, 265664);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (9938, 'Special', 8, 280838);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (2815, 'Special', 1, 219997);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8333, 'Bag', 1, 258532);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (8647, 'Suitcase', 7, 222599);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7130, 'Special', 0, 383794);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7962, 'Bag', 5, 205586);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (3787, 'Suitcase', 5, 384407);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (5597, 'Heavy', 10, 353284);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (7265, 'Special', 1, 237657);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1000, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1001, 'Bag', 2, 359769);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1002, 'Special', 3, 359770);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1003, 'Special', 4, 359771);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1004, 'Suitcase', 5, 359772);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1005, 'Bag', 6, 359773);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1006, 'Special', 7, 359774);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1007, 'Special', 8, 359775);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1008, 'Bag', 9, 359776);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1009, 'Heavy', 10, 359777);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1010, 'Special', 1, 359778);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1011, 'Suitcase', 2, 359779);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1012, 'Bag', 3, 359780);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1013, 'Bag', 4, 359781);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1014, 'Special', 5, 359782);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1015, 'Special', 6, 359783);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1016, 'Suitcase', 7, 359784);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1017, 'Suitcase', 8, 359785);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1018, 'Suitcase', 9, 359786);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1019, 'Heavy', 10, 359787);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1020, 'Suitcase', 1, 359788);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1021, 'Suitcase', 2, 359789);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1022, 'Special', 3, 359790);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1023, 'Special', 4, 359791);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1024, 'Suitcase', 5, 359792);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1025, 'Suitcase', 6, 359793);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1026, 'Special', 7, 359794);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1027, 'Suitcase', 8, 359795);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1028, 'Bag', 9, 359796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1029, 'Heavy', 10, 359797);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1030, 'Suitcase', 1, 359798);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1031, 'Bag', 2, 359799);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1032, 'Bag', 3, 359800);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1033, 'Suitcase', 4, 359801);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1035, 'Special', 6, 359803);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1036, 'Suitcase', 7, 359804);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1037, 'Special', 8, 359805);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1038, 'Bag', 9, 359806);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1039, 'Heavy', 10, 359807);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1040, 'Suitcase', 1, 359808);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1041, 'Bag', 2, 359809);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1042, 'Special', 3, 359810);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1043, 'Suitcase', 4, 359811);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1044, 'Suitcase', 5, 359812);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1045, 'Special', 6, 359813);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1046, 'Suitcase', 7, 359814);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1047, 'Suitcase', 8, 359815);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1048, 'Bag', 9, 359816);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (1049, 'Heavy', 10, 359817);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (280056, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (248327, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (253134, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (220647, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (202851, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (245417, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (238224, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (270777, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (227060, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (262216, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (258358, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (249389, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (227150, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (283755, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (267447, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (221831, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (200812, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (234093, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (250568, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (239473, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (231609, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (245506, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (275859, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244086, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (213343, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (202855, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (218886, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (242216, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (204439, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (277966, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (207025, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (209560, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (242316, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (203999, 'Special', 1, 359768);
commit;
prompt 400 records committed...
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (253831, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (265341, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (247760, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (259833, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (253415, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (216681, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (289303, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (274430, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244823, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (272979, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (217594, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (251215, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (226404, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (230281, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (289780, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (272455, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (218198, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (233995, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (265511, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (241345, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (273614, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (234648, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (216540, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (269031, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (263689, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (214859, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (240351, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (267325, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (241361, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (269162, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (237873, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (276485, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (207269, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (207757, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (246179, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (285879, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (216637, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (203399, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (275358, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (250863, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (216140, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (268267, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (235391, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (289655, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (240784, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (270834, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (223030, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (250208, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (250783, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (222749, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (268666, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (267086, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (238426, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (205713, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (263208, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (238341, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244961, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (208348, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244960, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (202384, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (287465, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (233074, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (236492, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (264865, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (285720, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (222986, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (219049, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244937, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (239254, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (246525, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (262956, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (219111, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (202449, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (288304, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (270403, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (234526, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (241395, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (287372, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (204090, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (260585, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (284029, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (267667, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (237042, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (228104, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (263300, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (234229, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (251976, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (248693, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (246542, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (212579, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (240685, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (204126, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (204849, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (288091, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (253408, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (235720, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (232451, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (285366, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (258206, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (243706, 'Special', 1, 279796);
commit;
prompt 500 records committed...
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (226083, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (257609, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (270339, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (286607, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (284371, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (256005, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (211635, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (260611, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (207194, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (279090, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (219875, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (208947, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (255073, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (222131, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (238159, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (271265, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (289682, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (254859, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (247110, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (264564, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (275660, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (234720, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (252654, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (251999, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (258035, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (250173, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (230356, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (287670, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (280902, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (223254, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (225935, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (229844, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (227071, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (256436, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (289769, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (238169, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (239953, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244506, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (268765, 'Special', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (205543, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (245427, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (206443, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (228242, 'Special', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (269993, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (283718, 'Bag', 1, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (257289, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (243803, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (246544, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (211269, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (220023, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (283204, 'Bag', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (229101, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (212626, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (227444, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (268239, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (202321, 'Bag', 5, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (232299, 'Special', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244036, 'Special', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (226609, 'Special', 5, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (283487, 'Bag', 1, 359768);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (216645, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (217848, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (263798, 'Special', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (244382, 'Bag', 1, 279796);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (265744, 'Bag', 5, 304607);
insert into BAGGAGE (baggage_id, baggage_type, baggage_weight, ticket_id)
values (-1, 'Carry-On', 10.5, 377698);
commit;
prompt 566 records loaded
prompt Loading PASSENGER...
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1573871528, 'Reid', '557345006', 'rob.reid@hewlettpackard.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4139544263, 'Keith', '558099995', 'a.keith@wci.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (379982361, 'Orlando', '559214529', 'rorlando@lms.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (334694516, 'Loggia', '584251872', 'marty.loggia@epamsystems.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (342850352, 'Krumholtz', '589935367', 'cole.k@cocacola.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (211756555, 'Tippe', '555473606', 'chris.t@envisiontelephony.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (277761157, 'Rossellini', '578787084', 'dermot.rossellini@enterprise.dk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (254655746, 'Zellweger', '520718698', 'nik.zellweger@thinktanksystems.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (259520122, 'McAnally', '569091203', 't.mcanally@appriss.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (351897231, 'Mattea', '513644346', 'bob@swi.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (296014467, 'Davis', '567218634', 'merillee.davis@mathis.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (270448006, 'Moraz', '515607433', 'wendy.moraz@mls.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (318636111, 'Loveless', '521648727', 'helen@progressivedesigns.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (317148159, 'Edmunds', '517677942', 'b.edmunds@pragmatechsoftware.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (223177804, 'Andrews', '575879623', 'guy.andrews@ait.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (301472986, 'Remar', '505963090', 'dar.remar@accuship.no');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (373968030, 'Scaggs', '526775086', 'derrick.scaggs@anworthmortgage.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000000, 'Costar', '481-351-1933', 'scostar0@mozilla.org');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000001, 'Gaylard', '904-284-8802', 'ogaylard1@biglobe.ne.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000002, 'Cowdray', '628-281-7094', 'ccowdray2@usnews.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000003, 'Blayney', '195-917-7571', 'eblayney3@mediafire.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000004, 'Cruxton', '874-537-4250', 'lcruxton4@wix.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000005, 'Venable', '611-674-0949', 'dvenable5@soundcloud.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000006, 'Trimmell', '927-618-7899', 'dtrimmell6@devhub.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000007, 'Broschke', '342-502-1817', 'pbroschke7@pen.io');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000008, 'Heyfield', '678-371-5531', 'kheyfield8@pcworld.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000009, 'Ritch', '682-183-8935', 'eritch9@naver.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000010, 'Hebard', '205-237-0029', 'mhebarda@discuz.net');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000011, 'Sydney', '421-764-1941', 'msydneyb@berkeley.edu');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000012, 'Venditto', '415-120-3226', 'lvendittoc@ucoz.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000013, 'Quittonden', '444-919-5544', 'fquittondend@typepad.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000014, 'Fencott', '369-225-0281', 'lfencotte@amazon.co.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000015, 'Blest', '486-937-0092', 'sblestf@joomla.org');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000016, 'Grishunin', '402-242-2773', 'cgrishuning@craigslist.org');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000017, 'Janny', '840-185-5242', 'gjannyh@ihg.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000018, 'Lochhead', '467-157-7540', 'elochheadi@zdnet.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000019, 'Pruvost', '716-760-6788', 'vpruvostj@wiley.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000020, 'Lorenzetti', '762-564-4985', 'dlorenzettik@howstuffworks.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000021, 'Row', '558-726-7098', 'arowl@blogger.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000022, 'Estick', '274-606-6944', 'mestickm@shareasale.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000023, 'Thornthwaite', '303-294-1034', 'sthornthwaiten@sourceforge.net');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000024, 'Tomasutti', '801-453-8598', 'itomasuttio@twitter.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000025, 'Chaves', '713-947-7594', 'schavesp@ox.ac.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000026, 'Abisetti', '704-545-4885', 'labisettiq@huffingtonpost.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000027, 'Lowrey', '742-536-4216', 'dlowreyr@flavors.me');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000028, 'Berrigan', '140-578-2443', 'lberrigans@reverbnation.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000029, 'Toplin', '153-496-2501', 'btoplint@xing.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000030, 'Andreoletti', '645-539-7546', 'mandreolettiu@pcworld.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000031, 'Marshallsay', '151-413-3197', 'cmarshallsayv@mail.ru');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000032, 'Grandisson', '986-331-4905', 'fgrandissonw@t-online.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000033, 'Magarrell', '274-809-9615', 'lmagarrellx@youku.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000034, 'Ablitt', '563-229-8139', 'bablitty@homestead.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000035, 'Agglio', '649-685-0684', 'tagglioz@wordpress.org');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000036, 'Littley', '680-712-2836', 'rlittley10@squarespace.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000037, 'Pikhno', '395-858-3271', 'opikhno11@rambler.ru');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000038, 'Balmer', '311-168-8736', 'tbalmer12@trellian.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000039, 'Cottem', '641-721-4034', 'tcottem13@eventbrite.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000040, 'Kearton', '539-960-1436', 'akearton14@ft.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000041, 'Vyvyan', '356-105-4743', 'svyvyan15@sohu.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000042, 'Wearing', '952-310-5726', 'twearing16@ted.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000043, 'Gitsham', '977-325-5567', 'cgitsham17@ebay.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000044, 'O'' Concannon', '177-704-4914', 'foconcannon18@4shared.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000045, 'Dmytryk', '764-551-7185', 'kdmytryk19@opera.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000046, 'De Paoli', '346-726-6160', 'mdepaoli1a@berkeley.edu');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000047, 'Reid', '254-898-7281', 'jreid1b@example.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000048, 'Cutchie', '817-501-1318', 'bcutchie1c@360.cn');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000049, 'Powney', '934-194-0062', 'lpowney1d@blogger.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000050, 'Keatley', '189-647-3917', 'akeatley1e@mysql.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000051, 'Kennicott', '934-927-4305', 'kkennicott1f@yolasite.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000052, 'Canario', '424-626-5683', 'ecanario1g@squarespace.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000053, 'Boice', '713-110-8257', 'jboice1h@wp.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000054, 'Jamot', '668-688-0092', 'ejamot1i@sphinn.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000055, 'Tonry', '632-987-7968', 'stonry1j@shutterfly.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000056, 'Leyban', '960-404-4327', 'dleyban1k@is.gd');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000057, 'MacCoughan', '434-637-2735', 'mmaccoughan1l@feedburner.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000058, 'Hyams', '546-883-1969', 'zhyams1m@furl.net');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000059, 'Kemwal', '906-645-8318', 'mkemwal1n@java.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000060, 'Momford', '176-470-6445', 'tmomford1o@eepurl.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000061, 'Mangam', '819-800-2043', 'dmangam1p@hexun.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000062, 'Moughtin', '330-601-3819', 'mmoughtin1q@smh.com.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000063, 'Cruden', '624-784-9558', 'scruden1r@usgs.gov');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000064, 'Francie', '793-570-1533', 'afrancie1s@moonfruit.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000065, 'Astlet', '205-816-1806', 'tastlet1t@w3.org');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000066, 'Risborough', '397-719-8320', 'krisborough1u@dailymail.co.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000067, 'Archbutt', '549-415-9827', 'aarchbutt1v@hc360.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000068, 'Kilbee', '103-656-9975', 'hkilbee1w@live.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (300000069, 'Safell', '873-251-1243', 'jsafell1x@engadget.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3903371002, 'Hawke', '553468940', 'warren.hawke@wendysinternational.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1879700281, 'Travolta', '550718451', 'radneyt@nestle.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2441850588, 'Belle', '556767741', 'julia.belle@actechnologies.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2864541163, 'Coltrane', '556351496', 'isaac.coltrane@hardwoodwholesalers.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4056867800, 'Wood', '559078365', 'carlos.wood@mds.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (186866407, 'Red', '555002758', 'joer@atlanticnet.my');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (746479019, 'Dean', '551543335', 'balthazar.d@execuscribe.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3143480143, 'Farrell', '553678268', 'dfarrell@americanmegacom.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2747677398, 'Scheider', '557244873', 'tea@fab.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (872969459, 'Colman', '554585838', 'scolman@ciwservices.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2655330264, 'Curfman', '552050873', 'clint.curfman@printtech.in');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2389134866, 'MacNeil', '558779517', 'boz.macneil@voicelog.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1720691470, 'Koyana', '555582782', 'geoffreyk@ass.com');
commit;
prompt 100 records committed...
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2908034953, 'Myles', '553474590', 'percy.myles@ris.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3554560914, 'Street', '555650264', 'holly.street@ibfh.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1241083848, 'Scaggs', '555672018', 'cameron.scaggs@bps.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1383563457, 'Hunt', '550813213', 'ani.hunt@waltdisney.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (917662982, 'Nielsen', '553793671', 'ritan@hondamotor.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4279766685, 'DiCaprio', '553335619', 'thomas@marathonheater.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4070415692, 'Gore', '550421591', 'hex.gore@cascadebancorp.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (43741307, 'Schreiber', '553766307', 'vschreiber@sfgo.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1099185040, 'Cole', '550639753', 'bette.c@paisley.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3035600398, 'Gilliam', '554095927', 'jgilliam@tilsonlandscape.nz');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3997273524, 'Jackman', '550490640', 'elvis@canterburypark.is');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2163649097, 'Weiss', '550310858', 'e.weiss@aoe.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3266985349, 'Polley', '551596226', 'nikki.polley@ssci.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1490835305, 'Todd', '551241998', 'chad.todd@zaiqtechnologies.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2637819983, 'Farrell', '555143263', 'chadf@gna.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1948950048, 'Singh', '551637209', 'lins@comglobalsystems.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2515842397, 'Davis', '552233839', 'matthew.davis@royalgold.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3954106081, 'Simpson', '551805928', 'millie.simpson@trainersoft.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4284641519, 'Saxon', '559079147', 'kay.saxon@tilsonlandscape.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1447266928, 'Bradford', '558917826', 'lena.bradford@flavorx.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4292899919, 'King', '553987042', 'scarlett.king@mercantilebank.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3182428857, 'Pastore', '551252740', 'neneh.pastore@ssi.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1691007647, 'Evett', '554204108', 'barry.e@pscinfogroup.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (940595999, 'Byrne', '550561555', 'rosanne.b@cws.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2845853303, 'Azaria', '551700072', 'mazaria@gdatechnologies.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2165764715, 'Kinney', '554940716', 'firstk@deutschetelekom.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3571026378, 'Tyson', '558532728', 'temuerat@ach.pl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2127673954, 'Harmon', '557213928', 'lukeh@telecheminternational.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2141673170, 'Swank', '555057730', 'gino.swank@mag.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (675810060, 'Loeb', '555546435', 'carol.loeb@consultants.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4131434005, 'Evanswood', '557023518', 'sevanswood@democracydata.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (14814539, 'Ferry', '557471080', 'adina.ferry@hotmail.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2118179539, 'Bedelia', '552417123', 'a.bedelia@processplus.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (28268369, 'Mollard', '555766264', 'fmollard@viacell.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1174302048, 'Parish', '551208416', 'arturo.parish@visionarysystems.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3135876155, 'Mahoney', '557596617', 'lou.mahoney@safehomesecurity.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (554260379, 'Colin Young', '552009971', 'jessica.colinyoung@jollyenterprises.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3689513631, 'Paltrow', '556742881', 'remy.paltrow@nestle.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3408806016, 'Stanton', '556887495', 'alice.stanton@savela.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1715075258, 'Walker', '552308669', 'jayw@refinery.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (116474885, 'MacPherson', '551580516', 'tony.macpherson@gha.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3202065817, 'Lange', '552754894', 'lenny.lange@nexxtworks.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1220471043, 'Bullock', '555933522', 'dbullock@fam.mx');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1749509824, 'Tucker', '554419885', 'vince.tucker@cynergydata.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (225961850, 'Dorff', '558102429', 'w.dorff@msdw.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1296197165, 'Costello', '553558611', 'albert.costello@kiamotors.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2111217503, 'Tomlin', '555962027', 'jake.tomlin@blueoceansoftware.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2340213410, 'Cartlidge', '551295597', 'alice.cartlidge@callhenry.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4264224831, 'Trevino', '559100762', 'trini.t@signalperfection.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (191393017, 'Maxwell', '555599734', 'pam.maxwell@nlx.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3091734977, 'Schwimmer', '553964723', 'ruth.schwimmer@spectrum.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2400502670, 'Bugnon', '555118315', 'jeff.bugnon@americanvanguard.dk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3867040414, 'Bradford', '557570632', 'geena.bradford@extremepizza.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4032224694, 'Shelton', '558166872', 'charlie@ultimus.ar');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2854517838, 'Aniston', '558111619', 'praga@sprint.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (929206898, 'Freeman', '554922538', 'jeanclaude.freeman@johnson.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4274484785, 'Kahn', '557021480', 'stewartk@infopros.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1944228016, 'Leachman', '550329029', 'tea.leachman@pearllawgroup.in');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (209999444, 'Jane', '553196700', 'ben.jane@mastercardinternational.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2171326129, 'King', '551707125', 'kellyk@kroger.il');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1700335718, 'Gracie', '557312370', 'vgracie@scriptsave.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1747014656, 'Cotton', '555548260', 'emerson.cotton@teamstudio.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3105782945, 'McConaughey', '554015534', 'colem@owm.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2218215705, 'Osment', '554308155', 'jeano@at.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (683986443, 'Cronin', '558590874', 'louise.c@walmartstores.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (880915287, 'Matheson', '556859584', 'bmatheson@marsinc.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (16630229, 'Prinze', '553531590', 'pprinze@ntas.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (175901514, 'Tucci', '554545321', 'rachid.tucci@mds.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3000391211, 'Hartnett', '556539062', 'warren.hartnett@meritagetechnologies.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2585543413, 'Statham', '551692883', 'vstatham@studiobproductions.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2761848852, 'Waite', '557223300', 'juan.waite@isd.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (791072108, 'Whitley', '558352870', 'gina.whitley@heritagemicrofilm.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (750332103, 'Apple', '556796285', 'vanessa.apple@vfs.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2132466374, 'Cash', '557551165', 'dom.cash@bigyanksports.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2563622969, 'Gallant', '550326199', 'chris.gallant@gagwear.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1162078782, 'Summer', '550381662', 'gerald.summer@pinnaclestaffing.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1790631476, 'Hawkins', '555969165', 'gran@wyeth.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2499086167, 'Huston', '552399138', 'bhuston@prosum.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3838034560, 'Palmieri', '552995178', 'ty.palmieri@jma.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2659036125, 'Aiken', '553468147', 'b.aiken@fab.dk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3633182606, 'Sarandon', '553262311', 'edgar.sarandon@coldstonecreamery.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1721112606, 'Quaid', '558529669', 'charlize.quaid@naturescure.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4108380694, 'Berry', '551472788', 'jet.berry@mls.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1515581915, 'Heche', '551918416', 'mingna.heche@tmaresources.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (118976950, 'Shatner', '554590392', 'dshatner@insurmark.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3030217035, 'Rundgren', '550614851', 'nicholasr@ppr.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3488016959, 'Cummings', '550303355', 'kevin.cummings@americanvanguard.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1747392301, 'Conners', '552640349', 'andrew.conners@axis.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3224426277, 'Sharp', '554035211', 'emilio.sharp@marsinc.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2000809820, 'Hewett', '555629103', 'beverley.hewett@aquickdelivery.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (443234907, 'Goodall', '555110836', 'cornell.goodall@granitesystems.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3189841920, 'Houston', '552235320', 'hhouston@carboceramics.dk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (937385985, 'Snipes', '553669339', 'nicole.snipes@tlsservicebureau.no');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1142950160, 'Walken', '557548792', 'nelly.w@contract.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1781354773, 'Patton', '550672800', 'randy.patton@epiqsystems.cz');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3907058574, 'McIntyre', '558997584', 'albertina.mcintyre@kis.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (509672752, 'Tippe', '558758099', 'c.tippe@kitba.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1393501725, 'Steiger', '551899477', 'timothy.steiger@kimberlyclark.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2260158743, 'Napolitano', '554532058', 'dick.napolitano@ppr.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3082585767, 'Craddock', '551298680', 'scraddock@grayhawksystems.fi');
commit;
prompt 200 records committed...
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1877959785, 'Fierstein', '553409403', 'anita.fierstein@spectrum.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1660146012, 'Heche', '558931636', 'tyrone.heche@fab.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3979804712, 'Speaks', '554180173', 'solomon.speaks@mai.il');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (582588412, 'Malkovich', '551768749', 'rolando.malkovich@bigyanksports.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3173876124, 'Osborne', '550847438', 'gwyneth.osborne@amerisourcefunding.se');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (620223331, 'Hatfield', '559042498', 'c.hatfield@hfn.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2418851966, 'Stanley', '558418839', 'jimmie@ris.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3481561594, 'Hewett', '558786967', 'd.hewett@cimalabs.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (220372518, 'Frost', '557596274', 'gfrost@iss.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4157143176, 'Weir', '557442522', 'mike.weir@cardinalcartridge.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2779816091, 'Zellweger', '556384095', 'lucinda@tama.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1201267855, 'LaSalle', '552173940', 'vince.lasalle@innovateecommerce.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2703360325, 'Torn', '550500628', 'pam.torn@smartronix.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (234257385, 'Arkenstone', '551454150', 'emily@carteretmortgage.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2029500891, 'Kelly', '556777469', 'martha.k@jollyenterprises.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (221412715, 'Randal', '559165180', 'lrandal@johnson.nz');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2929262243, 'Lillard', '550328651', 'roger.lillard@usdairyproducers.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (708880321, 'Candy', '555585736', 'ashton.c@nha.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1295334620, 'Hagar', '551265189', 'nancih@kmart.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2420932006, 'Garza', '558496587', 'annette.garza@httprint.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2721361582, 'Steenburgen', '555920768', 'davis@dataprise.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (238313927, 'Latifah', '553032116', 'vern.l@terrafirma.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2649231766, 'Rydell', '555845232', 'cevin.rydell@myricom.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2073397479, 'Bassett', '555074999', 'davy.bassett@datawarehouse.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1629072520, 'Warden', '556990101', 'freddy@operationaltechnologies.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2373393757, 'McFerrin', '558259732', 'murraym@surmodics.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1155533144, 'Rhys-Davies', '550375201', 'wally.rhysdavies@shufflemaster.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2333424436, 'Cazale', '557604279', 'miko.cazale@unitedasset.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1848932145, 'Wen', '551025356', 'whoopi.wen@jcpenney.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3292746234, 'Stamp', '556151056', 'cstamp@gateway.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3068711309, 'Tomlin', '555438301', 'miranda@visainternational.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3517253153, 'Wincott', '550905816', 'hope.w@sunstream.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3611290723, 'Stoltz', '553399412', 'pattis@medamicus.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2944875005, 'Aaron', '554512493', 'emily.aaron@north.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (823918207, 'Palin', '550246102', 'trace.palin@ads.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1888219726, 'Iglesias', '553258903', 'anita.iglesias@marlabs.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (901432435, 'Amos', '554378703', 'anthony.amos@procurementcentre.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3461336247, 'Torino', '556323807', 'a.torino@ivci.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (667710806, 'Strathairn', '554880656', 'scott.strathairn@pscinfogroup.fi');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1860377559, 'Vince', '553048038', 'cliff.vince@pharmacia.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1279348624, 'Palminteri', '553970931', 'naomi.palminteri@ssci.za');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3457912328, 'Flemyng', '552895423', 'marisa.flemyng@als.il');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1030882184, 'McGoohan', '552987190', 'grace.mcgoohan@bestever.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2189110660, 'Kidman', '558846726', 'rowan.k@spas.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3030370212, 'Bale', '552917613', 'williamb@lms.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (145406197, 'Blanchett', '551904678', 's.blanchett@hospitalsolutions.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3032558076, 'Osborne', '556842385', 'ed.osborne@meridiangold.gr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4097297588, 'Fehr', '554511165', 'lucinda.fehr@mindworks.at');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (670841603, 'Blanchett', '558379419', 'ryan.blanchett@usenergyservices.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3092043234, 'Kinney', '558785892', 'laurence.kinney@eagleone.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2517659001, 'Arkin', '553422028', 'lionel.arkin@scooterstore.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (524583443, 'Dunst', '558033414', 'collind@oss.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4209255256, 'Oakenfold', '558135132', 'k.oakenfold@generalelectric.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3303430975, 'Warden', '550727269', 'mary@jlphor.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4134052510, 'McCann', '556369197', 'dianne@cns.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1148855233, 'Akins', '551625464', 'ricky.akins@intel.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2195239809, 'Moraz', '553504976', 'armin@ivci.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3238496450, 'Bates', '557178835', 'chaka.b@bowman.mx');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (490180534, 'Harmon', '557869077', 'albertina.harmon@taycorfinancial.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (900040387, 'Fraser', '553163040', 'laura.fraser@kellogg.pl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (449644944, 'Stone', '553313923', 'sam.stone@httprint.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3533811218, 'Candy', '554179266', 'dar.candy@monarchcasino.no');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1218862098, 'Vassar', '556242372', 'michelle.v@qas.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1150216031, 'Orlando', '552173215', 'horace.orlando@tripwire.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2623671494, 'Weir', '556662646', 'o.weir@servicesource.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1082024660, 'Taylor', '553213469', 'giancarlo.taylor@techbooks.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3212917977, 'Johansson', '559139125', 'rhea.johansson@kellogg.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3704443836, 'Walken', '557078814', 'cheryl.walken@bioreference.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4136582605, 'Head', '557825745', 'm.head@avr.at');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (428074911, 'Grant', '552211308', 'mikog@mission.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3994028077, 'Sayer', '554631809', 'natacha@progressivemedical.be');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (381605407, 'Cube', '558508908', 'gavin.c@perfectorder.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2261379361, 'Nielsen', '554835947', 'nataschan@ams.jp');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2998668774, 'Webb', '556902692', 'paula@heartlab.dk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1715394225, 'Pride', '558435510', 'bo.pride@jollyenterprises.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3992596192, 'Darren', '556203993', 'debra@emt.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (762098278, 'Holbrook', '556855577', 'javon.holbrook@team.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4263432723, 'Berry', '552720216', 'miki.berry@gsat.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2387702559, 'Imbruglia', '555067481', 'colmi@dbprofessionals.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1294033638, 'Jessee', '557290183', 'sheryl.jessee@lifelinesystems.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4289386642, 'Womack', '553130297', 'celia.womack@axis.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3170169411, 'Leary', '554191558', 'christina.leary@navigatorsystems.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2589336619, 'Strathairn', '551016998', 'kathleen@vspan.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (408119777, 'Emmett', '558266931', 'antonio.e@jollyenterprises.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2745029688, 'Davidtz', '558631373', 'derek.davidtz@angieslist.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3999013901, 'Deejay', '554823645', 'zooey.deejay@totalentertainment.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (395745494, 'May', '551244430', 'kim.may@fmi.in');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3384845406, 'Visnjic', '557401856', 'victor.visnjic@evinco.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1571758849, 'Norton', '556968547', 'ramseyn@nexxtworks.ie');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2201884681, 'Turner', '557946152', 'amanda.turner@codykramerimports.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2930896282, 'Tomei', '557614125', 'w.tomei@jcpenney.za');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3244876693, 'Galecki', '555035983', 'terrence.galecki@dps.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2801048856, 'Rizzo', '555867036', 'bonnie.r@evergreenresources.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1711596415, 'Rhys-Davies', '551127421', 'keith.r@kitba.pt');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3357212618, 'Gordon', '557571543', 'natalie.g@keith.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3500429192, 'Chaykin', '556794634', 'famke@newviewgifts.pe');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2177147130, 'Jamal', '551383067', 'denise.j@freedommedical.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1310860904, 'Khan', '556786046', 'chet@sfgo.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2546024439, 'Cole', '551521255', 'jude@hospitalsolutions.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2695624626, 'Llewelyn', '550276297', 'arnold.llewelyn@profitline.br');
commit;
prompt 300 records committed...
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (723619990, 'Spall', '555228246', 't.spall@morganresearch.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1153830371, 'Brown', '557187046', 'gbrown@proclarity.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3893286587, 'Leigh', '552732442', 'hugh.leigh@conquest.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (82937339, 'Bancroft', '557519940', 'france.bancroft@nhhc.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1017840928, 'Hiatt', '551303050', 'albertina.hiatt@authoria.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4271323511, 'Chao', '550666104', 'mac.chao@restaurantpartners.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (505370118, 'Zappacosta', '551574008', 'marley.zappacosta@cyberthink.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3872777923, 'Myers', '550720808', 'jesse.myers@vivendiuniversal.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1625454938, 'Griggs', '554947680', 'jena.griggs@sds.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2457452168, 'Duschel', '553076819', 'tia.duschel@kingston.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2267746773, 'Paul', '558494060', 'walter.paul@innovativelighting.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3806033862, 'Whitmore', '552850367', 'pam.whitmore@diamondgroup.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (400764289, 'Furtado', '550987689', 'ice.furtado@comnetinternational.se');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3545515586, 'Sandoval', '550418661', 'jakes@coldstonecreamery.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3834351364, 'Arkenstone', '557234555', 'carrieanne.arkenstone@aventis.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1013696666, 'Olin', '555483812', 'al.o@prahs.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3388722296, 'MacPherson', '558254037', 'elizabeth@telesynthesis.se');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (196310980, 'Rucker', '558401861', 'carlene.rucker@trinityhomecare.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3025067115, 'Donovan', '552405979', 'adam.donovan@serentec.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4823046, 'Skerritt', '556774079', 'robbie.skerritt@tastefullysimple.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (657469100, 'McLean', '554233866', 'stevie.mclean@mavericktechnologies.mx');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3513889593, 'McGowan', '555178508', 'jeanluc.mcgowan@businessplus.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (562736699, 'Conlee', '551359890', 'demi.conlee@abatix.tw');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (276551217, 'English', '555545670', 'richie.english@democracydata.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4170852646, 'Kirkwood', '550899571', 'mkirkwood@marketfirst.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (238671426, 'Davidson', '553969718', 's.davidson@newhorizons.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2310616106, 'Myles', '556194613', 'neve.myles@totalentertainment.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4044514624, 'Idle', '551754833', 'liam.idle@alohanysystems.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (397181319, 'Reilly', '557617815', 'cornellr@cardinalcartridge.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (982716585, 'Gandolfini', '552090148', 'sigourney@generalelectric.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1556219250, 'Rudd', '551075362', 'gilberto.rudd@nhhc.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3584288395, 'Pepper', '552743598', 'miles.pepper@mai.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1998832504, 'de Lancie', '554636915', 'm.delancie@ezecastlesoftware.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2611671527, 'Finney', '551139154', 'brooke.finney@younginnovations.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1928912117, 'Nicholson', '550215975', 'rhona.nicholson@palmbeachtan.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3940023093, 'Tinsley', '555402554', 'samantha.tinsley@hcoa.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2369112239, 'Begley', '558043728', 'armin.begley@newmedia.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (81557478, 'Todd', '552739276', 'jaket@spotfireholdings.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (142186532, 'Ratzenberger', '555419963', 'nick@printingforlesscom.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3196158797, 'Theron', '553913840', 'cyndi@sm.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3970642656, 'Liu', '553309843', 'alana.liu@mwh.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2699849518, 'Roy Parnell', '551729242', 'pamr@max.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1272943148, 'Osmond', '553269048', 'julie.osmond@keymark.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2112001926, 'Shepard', '556387772', 'rob.shepard@interfacesoftware.at');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3071216489, 'Estevez', '555231607', 'george.estevez@primussoftware.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4173111480, 'Duvall', '556662399', 'jimmie.duvall@its.dk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4159326597, 'Sizemore', '550908099', 'stevie.sizemore@tps.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (944023186, 'Parm', '556160965', 'irene@fam.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (476547254, 'Parsons', '556520573', 'alicia@chipssolutions.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2932990645, 'Love', '551025483', 'brent@benecongroup.tr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (660929753, 'Guzman', '557695174', 'jody@otbd.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1112726679, 'Neill', '555141752', 'crystal@genextechnologies.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3924827205, 'Richter', '555571522', 'gino.richter@ataservices.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1967453781, 'Gracie', '558159120', 'victor@democracydata.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1642574897, 'Alston', '552352810', 'samantha.alston@telecheminternational.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (155663756, 'Place', '554167344', 'sarah@spinnakerexploration.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2494857483, 'Greene', '552987171', 'kylieg@team.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3463401023, 'Alda', '554330812', 'chubby.alda@monarchcasino.za');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1688709964, 'Hawthorne', '555317094', 'liev@doraldentalusa.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3781592932, 'Garr', '552537916', 'aprilg@asa.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2498253907, 'Mitra', '554894062', 'emilio@gbas.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (855321991, 'Presley', '550906669', 'andy.presley@dis.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1604649332, 'Garber', '556036902', 'tgarber@mre.il');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3321500208, 'Spacey', '551112111', 'davy.spacey@kimberlyclark.es');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (468108540, 'Stevenson', '556249536', 'pat.stevenson@investorstitle.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (425783601, 'David', '558608584', 'r.david@nrae.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1471488100, 'Garber', '550862730', 'hughg@venoco.pt');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1951815574, 'Henriksen', '556721942', 'uhenriksen@hotmail.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2277859555, 'Vega', '550798007', 'kyle.v@manhattanassociates.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3560536687, 'Hall', '554734336', 'judi.hall@staffforce.se');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3117624861, 'Hedaya', '556822685', 'candice.hedaya@vspan.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3904415813, 'Barkin', '558224969', 'paula.barkin@bioreference.br');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2753157145, 'Addy', '554872804', 'fisher@telecheminternational.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3883784645, 'Gertner', '554637551', 'bryan.gertner@genghisgrill.hk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3296988353, 'Mantegna', '556378409', 'd.mantegna@larkinenterprises.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1664409612, 'Diaz', '558258356', 'jeanne.diaz@kroger.ie');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4291952742, 'McElhone', '553692291', 'd.mcelhone@oriservices.ch');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1903082893, 'Wahlberg', '550900246', 'helen.wahlberg@accuship.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1114723475, 'O''Neal', '555315989', 'anna.oneal@fam.nl');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (752773406, 'Channing', '553694186', 'roddy.channing@meghasystems.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (841567993, 'McElhone', '552156017', 'davy@base.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1801185272, 'Lang', '556477865', 'franco.lang@talx.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2873700409, 'Cozier', '559147622', 'dcozier@mindworks.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (1313078341, 'Davison', '558043953', 'c.davison@genghisgrill.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2788966181, 'Springfield', '556365212', 'h.springfield@stiknowledge.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2485263056, 'Spears', '550543304', 'freddie.spears@capstone.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2171424292, 'Dorn', '553291481', 'n.dorn@greene.it');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3551736206, 'Polito', '556662503', 'wally.polito@gtp.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (622994605, 'Sevigny', '553477937', 'terry@summitenergy.uk');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (56045864, 'Greenwood', '557397107', 'derek@dynacqinternational.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (499848229, 'Sutherland', '555041411', 'harrison.sutherland@sourcegear.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2146024878, 'Jane', '552031373', 'yjane@montpelierplastics.au');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3613982088, 'Womack', '552326522', 'jwomack@prahs.se');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3996108394, 'Coverdale', '551342313', 'breckin.coverdale@gsat.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (717220180, 'Travers', '552157541', 'mac.travers@ubp.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3771158295, 'Macht', '558605617', 'giancarlom@kramontrealty.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2128813517, 'Dench', '552731825', 'richard.dench@morganresearch.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (681250929, 'Nicholas', '553572660', 'ramsey.nicholas@pscinfogroup.ca');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2256772699, 'Sylvian', '559079180', 'stephen.sylvian@biosite.de');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (4184162999, 'Dalton', '558302349', 'garry.dalton@talx.com');
commit;
prompt 400 records committed...
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (84919454, 'Hayek', '550965417', 'rhayek@diageo.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3937385977, 'Perlman', '551519733', 'aperlman@spenser.fr');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (3981901827, 'Torn', '556644732', 'ktorn@asapstaffing.com');
insert into PASSENGER (passenger_id, passenger_name, passenger_phone, passenger_email)
values (2467349848, 'Pleasence', '555282065', 'eddie.pleasence@pds.br');
commit;
prompt 404 records loaded
prompt Loading TICKETSELLER...
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (234413401, 'McDormand', '502995216');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (214945813, 'Raybon', '504217977');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (332113182, 'Viterelli', '517881279');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (207083715, 'Basinger', '9999999999');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (386178461, 'Moraz', '562206985');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (217056502, 'Blackmore', '534063610');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (281154307, 'Brody', '511433950');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (320345744, 'Badalucco', '504635700');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (325389215, 'Cazale', '583308100');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (210470680, 'Delta', '561836422');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (335673295, 'Eckhart', '572775384');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310266508, 'Atlas', '511892567');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (335012305, 'Berkeley', '507634336');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (272173133, 'Sewell', '506078218');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (355616367, 'Wiest', '588359326');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (363641567, 'Niven', '503288460');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (341750599, 'Ledger', '513311518');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (274810074, 'Tobolowsky', '518422580');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (227710098, 'Greenwood', '543103456');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (362506458, 'Carrere', '576060388');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (209218853, 'Lorenz', '583322531');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (374271549, 'O''Sullivan', '558846936');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (381386109, 'Holden', '566273793');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (380347031, 'Parm', '521885702');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (287359609, 'Palmieri', '587998168');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (277303119, 'Warden', '553903154');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (288367846, 'Williams', '589683539');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (316073442, 'Colon', '543613671');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (202318062, 'Coburn', '500838054');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (296490615, 'Sayer', '571207901');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (363888243, 'Griggs', '508362643');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (271851580, 'Hatosy', '520834931');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (378494685, 'Assante', '569067896');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (217461665, 'Llewelyn', '555974010');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (385006976, 'Furtado', '586354305');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (288385654, 'Hanks', '576320092');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (381994314, 'Maxwell', '562839311');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (220647788, 'Pony', '547864120');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (318996086, 'Gosdin', '522794688');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (378745713, 'Nicks', '587858717');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (382190490, 'Utada', '579478486');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (357450766, 'Faithfull', '518947833');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (382262708, 'Statham', '565932088');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (329333824, 'Doucette', '542529963');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (295623764, 'Lewis', '501689907');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (258157080, 'Mitchell', '526043625');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (237777658, 'Matthau', '525241792');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (304082692, 'Young', '502936096');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (343952758, 'Swinton', '541121435');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (226444135, 'Channing', '543226789');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (326478636, 'Chappelle', '564292914');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (295480431, 'Faithfull', '507430150');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (345176686, 'Bandy', '551196931');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (362822032, 'Cara', '532784627');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (205616776, 'Affleck', '569523402');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (313515270, 'Jovovich', '568868985');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (234848134, 'Ellis', '585622740');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (296854630, 'Head', '525400175');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (214515321, 'Quinlan', '582579532');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (211133927, 'Jackman', '508922969');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (371494810, 'Diehl', '521474230');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (255503675, 'Ferry', '502845676');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (295709145, 'Moffat', '576376078');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (372307406, 'Def', '557473577');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (227969024, 'McElhone', '548268675');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (252439705, 'Chung', '528967081');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (296933887, 'Coe', '577533448');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (356297958, 'Khan', '519130098');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (387943673, 'Marie', '566930700');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310663510, 'Warren', '517240812');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (236933452, 'Neville', '540348025');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (239220981, 'Capshaw', '551396760');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (274273432, 'Evett', '525056572');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (308281893, 'Bloch', '575684041');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (205554610, 'Avalon', '569951953');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (321495574, 'Baranski', '501521480');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (233439957, 'Palmer', '587383558');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (364781468, 'Flanery', '552399728');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (376097465, 'Swayze', '584818629');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (237277522, 'Stormare', '531557512');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (307799804, 'Crosby', '512870607');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (262644266, 'Hersh', '577537691');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (325390520, 'Badalucco', '511270153');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (259468455, 'Peet', '563669232');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (234853838, 'Tinsley', '512296629');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (246648879, 'Warden', '549952920');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (324559120, 'Broderick', '505142978');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (231394919, 'Dalton', '510213314');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (320256878, 'Klein', '572782577');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (270700908, 'Gibson', '589342427');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (280955985, 'Craven', '538268007');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (343751129, 'Macy', '575626551');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (218786324, 'Danger', '568143628');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (319536448, 'Branagh', '537141847');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (229222618, 'Jackman', '509921404');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (232899139, 'Sandler', '579651555');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (304988522, 'Charles', '526477679');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (300142382, 'Prowse', '571963061');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (236950311, 'Bancroft', '535902351');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (334120188, 'Visnjic', '513931615');
commit;
prompt 100 records committed...
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (292721604, 'Ruiz', '538896434');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (325237214, 'Caviezel', '527854086');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (297909520, 'Alexander', '550394009');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (350910955, 'Todd', '516505934');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (260313579, 'Clayton', '535805300');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (358656201, 'Zevon', '566162475');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (263316337, 'Wagner', '538263933');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (388918507, 'Ponty', '541236502');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (355554389, 'Burton', '539638382');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (329984528, 'Moody', '564283489');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (289104838, 'Gough', '577960194');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (280607651, 'Aiken', '561697874');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (252240713, 'Berkley', '585454790');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (353282291, 'Li', '557074279');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (234674022, 'Hopper', '527659443');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (274254467, 'Kretschmann', '551561079');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (237492254, 'Perez', '513302533');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (352245013, 'Green', '539215338');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (296078129, 'Coolidge', '559823195');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (228359755, 'Benoit', '586002921');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (346558251, 'De Almeida', '578756244');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (341643467, 'Conley', '569300466');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (264129045, 'McLachlan', '531818545');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (200076168, 'McNarland', '531171922');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (279332987, 'Fariq', '520534965');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (382386541, 'Adkins', '518936501');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (355379591, 'Yankovic', '522759611');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (233742748, 'Posener', '521242154');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (220299024, 'McBride', '506606288');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (225050898, 'Finney', '542634069');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (341456397, 'Orbit', '569225908');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (243120652, 'Wen', '565086216');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (261116928, 'Phillips', '562683048');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (224221194, 'Snow', '576770592');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (209711155, 'Stuermer', '535013939');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (358423787, 'Eastwood', '527098592');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (352580218, 'Womack', '509518858');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (213484577, 'Turner', '528406819');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (315658972, 'Hirsch', '532578236');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (256738120, 'O''Connor', '579200664');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (290154315, 'Cobbs', '567908726');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (298423242, 'Wopat', '587238122');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (365172580, 'Gatlin', '536318100');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (221923419, 'Humphrey', '533558597');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (234818209, 'Carnes', '562800982');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (352448787, 'Ellis', '576461799');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (221901164, 'Skaggs', '550366301');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (267591151, 'Hedaya', '538045388');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (228427626, 'Duncan', '540426802');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (367822102, 'Rossellini', '520841657');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (262882544, 'Cervine', '556035975');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (354252310, 'Vaughn', '508978282');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (250318415, 'Whitwam', '504853553');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (251702571, 'Purefoy', '582751099');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (382817463, 'Sinise', '566581976');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (219228918, 'Rollins', '558162844');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (319368928, 'Imbruglia', '512868214');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (364570311, 'Mazar', '519475977');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (214974740, 'Fishburne', '509432932');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (235422949, 'Weaver', '553774918');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (383240133, 'Roy Parnell', '588597127');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (345865205, 'Taylor', '547558474');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (334196039, 'Tate', '578550260');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (202536414, 'Flanery', '577111721');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (354012211, 'Bale', '571768324');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (279186496, 'Soda', '572463231');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (264968973, 'Bragg', '562070364');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (241836382, 'Forster', '549743338');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (316936386, 'Rains', '576022687');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (316896662, 'Chaplin', '524347004');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (375037348, 'Tankard', '542886314');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (223058663, 'Giannini', '568095849');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (226520741, 'Vincent', '506180186');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (251473344, 'Macht', '513213088');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (342517245, 'Bello', '532325209');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (279543919, 'Levert', '534997348');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (351668768, 'Banderas', '525867436');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (378453080, 'Hoffman', '529231743');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (231987717, 'Whitford', '579577495');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (265199943, 'Quaid', '580218107');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (359089400, 'Pollack', '519412843');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (293310565, 'Shaye', '516507902');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (382524856, 'Diddley', '582034494');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (234383859, 'McKean', '544536126');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (291697284, 'Patillo', '574415572');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (292117233, 'Farris', '501077381');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (348147944, 'Hudson', '574190379');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (273298003, 'Gallant', '514359327');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (286222029, 'Henstridge', '573894597');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (213322864, 'Basinger', '566412863');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (218646495, 'Foley', '585264857');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (338993209, 'Rush', '546435635');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (291745197, 'Osbourne', '519424073');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (295504003, 'Keener', '582220896');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (286256884, 'Popper', '528202799');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (239573283, 'Ford', '534682203');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (338383773, 'Salonga', '529161294');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (313422914, 'Caldwell', '514811152');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (201157338, 'Sledge', '515207082');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (316694395, 'White', '563665026');
commit;
prompt 200 records committed...
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (242838870, 'Summer', '557173475');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (332240843, 'Jane', '549819212');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (326250050, 'Kilmer', '577460875');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (208953132, 'Frakes', '585760195');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (345028424, 'Flanagan', '532969607');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (387229316, 'Cash', '550564102');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (259199134, 'Nicks', '589195632');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (342256992, 'Wheel', '531528043');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (357522613, 'Kirshner', '562643655');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (243823245, 'Mohr', '557821858');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (367193204, 'Moffat', '588761042');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (200771028, 'Graham', '545331433');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (297000767, 'Houston', '585535315');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (250359573, 'Garner', '549296350');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (257401303, 'Cherry', '541853174');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (209534435, 'Nicholson', '520729432');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (294448518, 'Spector', '522814613');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (353345218, 'Melvin', '579568621');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (313590950, 'Loggia', '504557084');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (237340794, 'McGriff', '562677631');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (308313920, 'Paquin', '536896582');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (282598062, 'Gooding', '553805996');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (316877033, 'Silverman', '546360118');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (315975743, 'Sheen', '516066348');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (242341315, 'Colin Young', '503092253');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (351104744, 'Vince', '531012202');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (236070328, 'El-Saher', '535792169');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (289405820, 'Thomas', '502627985');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (257301681, 'Darren', '517402244');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (271938993, 'Simpson', '585099757');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (340594367, 'Ricci', '543849143');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (284012229, 'Wolf', '560744758');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (353338208, 'Horizon', '506859160');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (282084259, 'Balk', '534565873');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (306439412, 'Teng', '572855871');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (328463277, 'Culkin', '565188084');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (247145869, 'Tomei', '541325086');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (360504390, 'Farrell', '504053125');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (263122301, 'Carlton', '500924728');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (349319230, 'Satriani', '546320847');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (235703717, 'Campbell', '588150391');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (215306111, 'Lunch', '513576136');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (317120894, 'Reilly', '524666208');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (295963344, 'Raye', '560793814');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (365778672, 'Bale', '543600125');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (292337047, 'Furay', '553695525');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (264751878, 'Tucci', '515307690');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (385952818, 'Latifah', '548267429');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (215919530, 'Kretschmann', '587454243');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (305063038, 'Steiger', '557420375');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (304960689, 'Webb', '505876673');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (369383417, 'Abraham', '541190265');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (315159983, 'Macht', '579687891');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (383068508, 'Caviezel', '512120463');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (379992281, 'McDonnell', '589604705');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (368361520, 'Archer', '537165348');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (380149339, 'De Almeida', '570638045');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (294023629, 'Connelly', '527229512');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (379411520, 'Solido', '512208262');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (385177335, 'Malone', '535935638');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (239929754, 'Sizemore', '558562705');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (221462028, 'Hanley', '516020695');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (260441923, 'Sherman', '523202845');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (370273040, 'Webb', '545519889');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (245078686, 'Stevenson', '530998935');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (358212799, 'McKellen', '522235670');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (325091518, 'Lizzy', '573906509');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (318599595, 'Ponce', '564530152');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (285435332, 'Chapman', '588825968');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (232830547, 'Driver', '584848373');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (232034549, 'Hector', '552289113');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (290455974, 'Harnes', '570202178');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (388129809, 'Paige', '524439644');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (253867252, 'Ronstadt', '586744822');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (308717810, 'Kahn', '577323514');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (300404573, 'Tyler', '564169946');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (215133805, 'Kapanka', '587944434');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (214329655, 'Aykroyd', '555600202');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (226660320, 'Witt', '577994966');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (255356533, 'Hingle', '570515595');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (337051483, 'Brody', '517769272');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (376165958, 'Pressly', '557734449');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (220415119, 'Chapman', '564624975');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (360420742, 'Avalon', '503125988');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (227369348, 'Balk', '504613493');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (352125561, 'Redgrave', '518227605');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (388161917, 'Colon', '502665850');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (368610255, 'Moriarty', '561887176');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (318883867, 'Santa Rosa', '580129074');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (359835609, 'Alston', '503076196');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (309399354, 'Sorvino', '521622221');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (277999888, 'Hagerty', '589747986');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (311525561, 'Jeffreys', '524245461');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (350438065, 'Garfunkel', '581671869');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (312705624, 'Janney', '504255737');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (377428731, 'Farris', '535184021');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (218298341, 'Diesel', '517543237');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (351631101, 'Domino', '580383536');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (264036200, 'Hatosy', '553729244');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (299341333, 'Morse', '587093284');
commit;
prompt 300 records committed...
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (233552819, 'Cotton', '537582848');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000000, 'Harroll', '406-630-9267');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000001, 'Aronin', '864-698-0298');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000002, 'Steart', '506-436-1165');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000003, 'Coombe', '375-674-7228');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000004, 'Pechard', '764-189-9195');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000005, 'Klaus', '243-280-8377');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000006, 'Shimuk', '543-105-5266');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000007, 'Gillease', '718-946-6544');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000008, 'Shovell', '412-230-7757');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000009, 'Eyckelberg', '864-574-6537');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000010, 'Ayrton', '546-996-6928');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000011, 'Merrett', '764-592-5544');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000012, 'Simenet', '647-972-1985');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000013, 'Caldayrou', '655-262-1684');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000014, 'Merrien', '441-196-2975');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000015, 'Withull', '486-438-5296');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000016, 'Cuming', '347-327-7630');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000017, 'Boyen', '575-652-9196');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000018, 'Humphries', '560-459-3050');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000019, 'Croote', '611-717-2067');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000020, 'Keir', '467-321-4580');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000021, 'Adger', '972-454-4639');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000022, 'Kuhlen', '836-864-4021');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000023, 'Matthewman', '771-621-5830');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000024, 'Linkleter', '961-437-7195');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000025, 'Healy', '146-814-6482');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000026, 'Fearick', '467-455-9626');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000027, 'Schindler', '800-886-5931');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000028, 'Masurel', '590-698-8996');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000029, 'Gouldeby', '992-311-0329');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000030, 'Humpatch', '128-334-0805');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000031, 'Thorold', '716-520-9281');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000032, 'Kobierski', '542-467-5556');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000033, 'Molder', '955-408-7114');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000034, 'Nelle', '163-508-0928');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000035, 'Lafuente', '678-505-7660');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000036, 'Withey', '950-138-5509');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000037, 'Birrane', '635-118-9645');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000038, 'Cadwell', '303-543-6179');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000039, 'Aguilar', '803-503-7682');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000040, 'Larkin', '576-855-3144');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000041, 'Houndsom', '254-193-8124');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000042, 'Laba', '324-585-7375');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000043, 'De la Harpe', '934-411-5610');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000044, 'Nowak', '789-597-0425');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000045, 'Van Castele', '203-340-6676');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000046, 'Luckin', '341-175-1947');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000047, 'Masi', '364-550-9120');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000048, 'Ludwell', '662-772-8615');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000049, 'Eyles', '975-557-2885');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000050, 'Banck', '159-449-2337');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000051, 'Bannon', '436-291-9494');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000052, 'Sidwell', '562-311-8258');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000053, 'Taree', '182-438-5587');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000054, 'Patroni', '391-732-2749');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000055, 'Leele', '495-181-4795');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000056, 'Shiliton', '562-294-1343');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000057, 'Flucks', '634-917-7526');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000058, 'Blackborn', '623-400-3758');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000059, 'Litster', '639-418-1472');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000060, 'Hatt', '214-145-3882');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000061, 'Sorrell', '212-283-6524');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000062, 'Gartsyde', '285-239-5952');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000063, 'Freebury', '196-558-7755');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000064, 'Hunnicutt', '820-172-4966');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000065, 'Sheavills', '187-612-0291');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000066, 'Feragh', '614-648-9214');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000067, 'Eager', '430-116-3100');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000068, 'Haggish', '213-479-0026');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000069, 'Armitage', '320-272-5537');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000070, 'Whorall', '574-797-0022');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000071, 'Grewer', '212-880-4357');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000072, 'Manston', '168-395-3533');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000073, 'Harnetty', '582-599-9058');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000074, 'Ringer', '199-226-9217');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000075, 'Exposito', '929-788-9735');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000076, 'Goulborn', '534-197-4045');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000077, 'Turfes', '815-661-7297');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000078, 'Maharry', '376-447-4690');
insert into TICKETSELLER (seller_id, seller_name, seller_contact)
values (310000079, 'Spirritt', '394-463-6734');
commit;
prompt 381 records loaded
prompt Loading BOOKING...
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1101, 1101, to_date('11-06-2023', 'dd-mm-yyyy'), 3554560914, 325237214, 256940);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1102, 1102, to_date('30-05-2023', 'dd-mm-yyyy'), 1241083848, 297909520, 258498);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1000, 1000, to_date('08-06-2023', 'dd-mm-yyyy'), 1573871528, 234413401, 200137);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1001, 1001, to_date('24-06-2023', 'dd-mm-yyyy'), 4139544263, 214945813, 200361);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1002, 1002, to_date('27-06-2023', 'dd-mm-yyyy'), 379982361, 332113182, 200561);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1003, 1003, to_date('06-06-2023', 'dd-mm-yyyy'), 334694516, 207083715, 200579);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1004, 1004, to_date('18-06-2023', 'dd-mm-yyyy'), 342850352, 386178461, 201113);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1005, 1005, to_date('08-06-2023', 'dd-mm-yyyy'), 211756555, 217056502, 201163);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1006, 1006, to_date('14-06-2023', 'dd-mm-yyyy'), 277761157, 281154307, 201894);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1007, 1007, to_date('13-06-2023', 'dd-mm-yyyy'), 254655746, 320345744, 202546);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1008, 1008, to_date('19-06-2023', 'dd-mm-yyyy'), 259520122, 325389215, 202775);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1009, 1009, to_date('04-06-2023', 'dd-mm-yyyy'), 351897231, 210470680, 203216);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1010, 1010, to_date('12-06-2023', 'dd-mm-yyyy'), 296014467, 335673295, 203421);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1011, 1011, to_date('29-06-2023', 'dd-mm-yyyy'), 270448006, 310266508, 203874);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1012, 1012, to_date('03-06-2023', 'dd-mm-yyyy'), 318636111, 335012305, 204263);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1013, 1013, to_date('04-06-2023', 'dd-mm-yyyy'), 317148159, 272173133, 204805);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1014, 1014, to_date('13-06-2023', 'dd-mm-yyyy'), 223177804, 355616367, 204870);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1015, 1015, to_date('11-06-2023', 'dd-mm-yyyy'), 301472986, 363641567, 205059);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1016, 1016, to_date('24-06-2023', 'dd-mm-yyyy'), 373968030, 341750599, 205586);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1017, 1017, to_date('16-06-2023', 'dd-mm-yyyy'), 300000000, 274810074, 205785);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1018, 1018, to_date('17-06-2023', 'dd-mm-yyyy'), 300000001, 227710098, 205893);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1019, 1019, to_date('20-06-2023', 'dd-mm-yyyy'), 300000002, 362506458, 206191);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1020, 1020, to_date('06-06-2023', 'dd-mm-yyyy'), 300000003, 209218853, 206616);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1021, 1021, to_date('15-06-2023', 'dd-mm-yyyy'), 300000004, 374271549, 206690);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1022, 1022, to_date('22-06-2023', 'dd-mm-yyyy'), 300000005, 381386109, 207566);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1023, 1023, to_date('31-05-2023', 'dd-mm-yyyy'), 300000006, 380347031, 208308);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1024, 1024, to_date('12-06-2023', 'dd-mm-yyyy'), 300000007, 287359609, 211623);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1025, 1025, to_date('11-06-2023', 'dd-mm-yyyy'), 300000008, 277303119, 212311);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1026, 1026, to_date('18-06-2023', 'dd-mm-yyyy'), 300000009, 288367846, 212885);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1027, 1027, to_date('08-06-2023', 'dd-mm-yyyy'), 300000010, 316073442, 213289);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1028, 1028, to_date('04-06-2023', 'dd-mm-yyyy'), 300000011, 202318062, 214126);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1029, 1029, to_date('02-06-2023', 'dd-mm-yyyy'), 300000012, 296490615, 214552);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1030, 1030, to_date('27-06-2023', 'dd-mm-yyyy'), 300000013, 363888243, 214701);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1031, 1031, to_date('27-06-2023', 'dd-mm-yyyy'), 300000014, 271851580, 214952);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1032, 1032, to_date('08-06-2023', 'dd-mm-yyyy'), 300000015, 378494685, 217895);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1033, 1033, to_date('06-06-2023', 'dd-mm-yyyy'), 300000016, 217461665, 218086);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1034, 1034, to_date('27-06-2023', 'dd-mm-yyyy'), 300000017, 385006976, 219997);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1035, 1035, to_date('24-06-2023', 'dd-mm-yyyy'), 300000018, 288385654, 220954);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1036, 1036, to_date('18-06-2023', 'dd-mm-yyyy'), 300000019, 381994314, 221131);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1037, 1037, to_date('04-06-2023', 'dd-mm-yyyy'), 300000020, 220647788, 221198);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1038, 1038, to_date('05-06-2023', 'dd-mm-yyyy'), 300000021, 318996086, 221448);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1039, 1039, to_date('19-06-2023', 'dd-mm-yyyy'), 300000022, 378745713, 221484);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1040, 1040, to_date('14-06-2023', 'dd-mm-yyyy'), 300000023, 382190490, 222599);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1041, 1041, to_date('08-06-2023', 'dd-mm-yyyy'), 300000024, 357450766, 223134);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1042, 1042, to_date('15-06-2023', 'dd-mm-yyyy'), 300000025, 382262708, 224137);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1043, 1043, to_date('31-05-2023', 'dd-mm-yyyy'), 300000026, 329333824, 225168);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1044, 1044, to_date('07-06-2023', 'dd-mm-yyyy'), 300000027, 295623764, 225184);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1045, 1045, to_date('22-06-2023', 'dd-mm-yyyy'), 300000028, 258157080, 225649);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1046, 1046, to_date('20-06-2023', 'dd-mm-yyyy'), 300000029, 237777658, 226597);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1047, 1047, to_date('23-06-2023', 'dd-mm-yyyy'), 300000030, 304082692, 226730);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1048, 1048, to_date('02-06-2023', 'dd-mm-yyyy'), 300000031, 343952758, 226832);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1049, 1049, to_date('16-06-2023', 'dd-mm-yyyy'), 300000032, 226444135, 227283);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1050, 1050, to_date('11-06-2023', 'dd-mm-yyyy'), 300000033, 326478636, 227660);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1051, 1051, to_date('16-06-2023', 'dd-mm-yyyy'), 300000034, 295480431, 229674);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1052, 1052, to_date('08-06-2023', 'dd-mm-yyyy'), 300000035, 345176686, 231694);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1053, 1053, to_date('19-06-2023', 'dd-mm-yyyy'), 300000036, 362822032, 232061);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1054, 1054, to_date('21-06-2023', 'dd-mm-yyyy'), 300000037, 205616776, 232131);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1055, 1055, to_date('05-06-2023', 'dd-mm-yyyy'), 300000038, 313515270, 232664);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1056, 1056, to_date('31-05-2023', 'dd-mm-yyyy'), 300000039, 234848134, 233082);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1057, 1057, to_date('07-06-2023', 'dd-mm-yyyy'), 300000040, 296854630, 233243);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1058, 1058, to_date('03-06-2023', 'dd-mm-yyyy'), 300000041, 214515321, 233295);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1059, 1059, to_date('04-06-2023', 'dd-mm-yyyy'), 300000042, 211133927, 233459);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1060, 1060, to_date('22-06-2023', 'dd-mm-yyyy'), 300000043, 371494810, 233794);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1061, 1061, to_date('10-06-2023', 'dd-mm-yyyy'), 300000044, 255503675, 234262);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1062, 1062, to_date('29-06-2023', 'dd-mm-yyyy'), 300000045, 295709145, 234640);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1063, 1063, to_date('26-06-2023', 'dd-mm-yyyy'), 300000046, 372307406, 235481);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1064, 1064, to_date('24-06-2023', 'dd-mm-yyyy'), 300000047, 227969024, 236016);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1065, 1065, to_date('10-06-2023', 'dd-mm-yyyy'), 300000048, 252439705, 236715);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1066, 1066, to_date('29-06-2023', 'dd-mm-yyyy'), 300000049, 296933887, 237614);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1067, 1067, to_date('08-06-2023', 'dd-mm-yyyy'), 300000050, 356297958, 237657);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1068, 1068, to_date('10-06-2023', 'dd-mm-yyyy'), 300000051, 387943673, 239221);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1069, 1069, to_date('18-06-2023', 'dd-mm-yyyy'), 300000052, 310663510, 239240);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1070, 1070, to_date('19-06-2023', 'dd-mm-yyyy'), 300000053, 236933452, 240835);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1071, 1071, to_date('14-06-2023', 'dd-mm-yyyy'), 300000054, 239220981, 240857);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1072, 1072, to_date('27-06-2023', 'dd-mm-yyyy'), 300000055, 274273432, 242282);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1073, 1073, to_date('21-06-2023', 'dd-mm-yyyy'), 300000056, 308281893, 243663);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1074, 1074, to_date('20-06-2023', 'dd-mm-yyyy'), 300000057, 205554610, 243817);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1075, 1075, to_date('23-06-2023', 'dd-mm-yyyy'), 300000058, 321495574, 244178);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1076, 1076, to_date('25-06-2023', 'dd-mm-yyyy'), 300000059, 233439957, 244416);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1077, 1077, to_date('18-06-2023', 'dd-mm-yyyy'), 300000060, 364781468, 244497);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1078, 1078, to_date('26-06-2023', 'dd-mm-yyyy'), 300000061, 376097465, 244674);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1079, 1079, to_date('24-06-2023', 'dd-mm-yyyy'), 300000062, 237277522, 245624);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1080, 1080, to_date('16-06-2023', 'dd-mm-yyyy'), 300000063, 307799804, 246151);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1081, 1081, to_date('24-06-2023', 'dd-mm-yyyy'), 300000064, 262644266, 246170);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1082, 1082, to_date('02-06-2023', 'dd-mm-yyyy'), 300000065, 325390520, 246410);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1083, 1083, to_date('05-06-2023', 'dd-mm-yyyy'), 300000066, 259468455, 248439);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1084, 1084, to_date('08-06-2023', 'dd-mm-yyyy'), 300000067, 234853838, 248697);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1085, 1085, to_date('01-06-2023', 'dd-mm-yyyy'), 300000068, 246648879, 248698);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1086, 1086, to_date('01-06-2023', 'dd-mm-yyyy'), 300000069, 324559120, 249583);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1087, 1087, to_date('04-06-2023', 'dd-mm-yyyy'), 3903371002, 231394919, 250149);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1088, 1088, to_date('29-06-2023', 'dd-mm-yyyy'), 1879700281, 320256878, 250849);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1089, 1089, to_date('24-06-2023', 'dd-mm-yyyy'), 2441850588, 270700908, 251245);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1090, 1090, to_date('23-06-2023', 'dd-mm-yyyy'), 2864541163, 280955985, 251504);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1091, 1091, to_date('13-06-2023', 'dd-mm-yyyy'), 4056867800, 343751129, 252438);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1092, 1092, to_date('10-06-2023', 'dd-mm-yyyy'), 186866407, 218786324, 253014);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1093, 1093, to_date('13-06-2023', 'dd-mm-yyyy'), 746479019, 319536448, 253053);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1094, 1094, to_date('08-06-2023', 'dd-mm-yyyy'), 3143480143, 229222618, 253223);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1095, 1095, to_date('09-06-2023', 'dd-mm-yyyy'), 2747677398, 232899139, 253634);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1096, 1096, to_date('08-06-2023', 'dd-mm-yyyy'), 872969459, 304988522, 254067);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1097, 1097, to_date('19-06-2023', 'dd-mm-yyyy'), 2655330264, 300142382, 254205);
commit;
prompt 100 records committed...
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1098, 1098, to_date('14-06-2023', 'dd-mm-yyyy'), 2389134866, 236950311, 255356);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1099, 1099, to_date('22-06-2023', 'dd-mm-yyyy'), 1720691470, 334120188, 256411);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1100, 1100, to_date('20-06-2023', 'dd-mm-yyyy'), 2908034953, 292721604, 256601);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1103, 1103, to_date('21-06-2023', 'dd-mm-yyyy'), 1383563457, 350910955, 258532);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1104, 1104, to_date('14-06-2023', 'dd-mm-yyyy'), 917662982, 260313579, 258996);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1105, 1105, to_date('20-06-2023', 'dd-mm-yyyy'), 4279766685, 358656201, 259651);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1106, 1106, to_date('10-06-2023', 'dd-mm-yyyy'), 4070415692, 263316337, 260182);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1107, 1107, to_date('25-06-2023', 'dd-mm-yyyy'), 43741307, 388918507, 260861);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1108, 1108, to_date('26-06-2023', 'dd-mm-yyyy'), 1099185040, 355554389, 261679);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1109, 1109, to_date('07-06-2023', 'dd-mm-yyyy'), 3035600398, 329984528, 262517);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1110, 1110, to_date('23-06-2023', 'dd-mm-yyyy'), 3997273524, 289104838, 264231);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1111, 1111, to_date('03-06-2023', 'dd-mm-yyyy'), 2163649097, 280607651, 264672);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1112, 1112, to_date('06-06-2023', 'dd-mm-yyyy'), 3266985349, 252240713, 265028);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1113, 1113, to_date('17-06-2023', 'dd-mm-yyyy'), 1490835305, 353282291, 265664);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1114, 1114, to_date('12-06-2023', 'dd-mm-yyyy'), 2637819983, 234674022, 266414);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1115, 1115, to_date('07-06-2023', 'dd-mm-yyyy'), 1948950048, 274254467, 266880);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1116, 1116, to_date('17-06-2023', 'dd-mm-yyyy'), 2515842397, 237492254, 267055);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1117, 1117, to_date('20-06-2023', 'dd-mm-yyyy'), 3954106081, 352245013, 267411);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1118, 1118, to_date('09-06-2023', 'dd-mm-yyyy'), 4284641519, 296078129, 269579);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1119, 1119, to_date('02-06-2023', 'dd-mm-yyyy'), 1447266928, 228359755, 269838);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1120, 1120, to_date('05-06-2023', 'dd-mm-yyyy'), 4292899919, 346558251, 270157);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1121, 1121, to_date('12-06-2023', 'dd-mm-yyyy'), 3182428857, 341643467, 270464);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1122, 1122, to_date('21-06-2023', 'dd-mm-yyyy'), 1691007647, 264129045, 271073);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1123, 1123, to_date('18-06-2023', 'dd-mm-yyyy'), 940595999, 200076168, 272070);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1124, 1124, to_date('11-06-2023', 'dd-mm-yyyy'), 2845853303, 279332987, 274241);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1125, 1125, to_date('04-06-2023', 'dd-mm-yyyy'), 2165764715, 382386541, 274497);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1126, 1126, to_date('30-05-2023', 'dd-mm-yyyy'), 3571026378, 355379591, 275336);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1127, 1127, to_date('28-06-2023', 'dd-mm-yyyy'), 2127673954, 233742748, 275611);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1128, 1128, to_date('03-06-2023', 'dd-mm-yyyy'), 2141673170, 220299024, 276188);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1129, 1129, to_date('19-06-2023', 'dd-mm-yyyy'), 675810060, 225050898, 277084);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1130, 1130, to_date('24-06-2023', 'dd-mm-yyyy'), 4131434005, 341456397, 277566);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1131, 1131, to_date('09-06-2023', 'dd-mm-yyyy'), 14814539, 243120652, 278613);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1132, 1132, to_date('26-06-2023', 'dd-mm-yyyy'), 2118179539, 261116928, 278958);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1133, 1133, to_date('12-06-2023', 'dd-mm-yyyy'), 28268369, 224221194, 279796);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1134, 1134, to_date('22-06-2023', 'dd-mm-yyyy'), 1174302048, 209711155, 280109);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1135, 1135, to_date('17-06-2023', 'dd-mm-yyyy'), 3135876155, 358423787, 280748);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1136, 1136, to_date('06-06-2023', 'dd-mm-yyyy'), 554260379, 352580218, 280838);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1137, 1137, to_date('18-06-2023', 'dd-mm-yyyy'), 3689513631, 213484577, 280924);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1138, 1138, to_date('15-06-2023', 'dd-mm-yyyy'), 3408806016, 315658972, 282022);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1139, 1139, to_date('31-05-2023', 'dd-mm-yyyy'), 1715075258, 256738120, 282054);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1140, 1140, to_date('27-06-2023', 'dd-mm-yyyy'), 116474885, 290154315, 282225);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1141, 1141, to_date('02-06-2023', 'dd-mm-yyyy'), 3202065817, 298423242, 282232);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1142, 1142, to_date('12-06-2023', 'dd-mm-yyyy'), 1220471043, 365172580, 282365);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1143, 1143, to_date('16-06-2023', 'dd-mm-yyyy'), 1749509824, 221923419, 282744);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1144, 1144, to_date('08-06-2023', 'dd-mm-yyyy'), 225961850, 234818209, 283508);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1145, 1145, to_date('06-06-2023', 'dd-mm-yyyy'), 1296197165, 352448787, 284124);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1146, 1146, to_date('08-06-2023', 'dd-mm-yyyy'), 2111217503, 221901164, 284760);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1147, 1147, to_date('10-06-2023', 'dd-mm-yyyy'), 2340213410, 267591151, 285166);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1148, 1148, to_date('13-06-2023', 'dd-mm-yyyy'), 4264224831, 228427626, 285589);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1149, 1149, to_date('12-06-2023', 'dd-mm-yyyy'), 191393017, 367822102, 286275);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1150, 1150, to_date('01-06-2023', 'dd-mm-yyyy'), 3091734977, 262882544, 286423);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1151, 1151, to_date('02-06-2023', 'dd-mm-yyyy'), 2400502670, 354252310, 286548);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1152, 1152, to_date('11-06-2023', 'dd-mm-yyyy'), 3867040414, 250318415, 286981);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1153, 1153, to_date('31-05-2023', 'dd-mm-yyyy'), 4032224694, 251702571, 287133);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1154, 1154, to_date('04-06-2023', 'dd-mm-yyyy'), 2854517838, 382817463, 287258);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1155, 1155, to_date('12-06-2023', 'dd-mm-yyyy'), 929206898, 219228918, 287362);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1156, 1156, to_date('15-06-2023', 'dd-mm-yyyy'), 4274484785, 319368928, 288052);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1157, 1157, to_date('08-06-2023', 'dd-mm-yyyy'), 1944228016, 364570311, 290567);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1158, 1158, to_date('29-06-2023', 'dd-mm-yyyy'), 209999444, 214974740, 290598);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1159, 1159, to_date('08-06-2023', 'dd-mm-yyyy'), 2171326129, 235422949, 290628);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1160, 1160, to_date('01-06-2023', 'dd-mm-yyyy'), 1700335718, 383240133, 290713);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1161, 1161, to_date('24-06-2023', 'dd-mm-yyyy'), 1747014656, 345865205, 291820);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1162, 1162, to_date('01-06-2023', 'dd-mm-yyyy'), 3105782945, 334196039, 292365);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1163, 1163, to_date('30-05-2023', 'dd-mm-yyyy'), 2218215705, 202536414, 292646);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1164, 1164, to_date('21-06-2023', 'dd-mm-yyyy'), 683986443, 354012211, 293063);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1165, 1165, to_date('19-06-2023', 'dd-mm-yyyy'), 880915287, 279186496, 293579);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1166, 1166, to_date('22-06-2023', 'dd-mm-yyyy'), 16630229, 264968973, 294531);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1167, 1167, to_date('04-06-2023', 'dd-mm-yyyy'), 175901514, 241836382, 294631);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1168, 1168, to_date('21-06-2023', 'dd-mm-yyyy'), 3000391211, 316936386, 295791);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1169, 1169, to_date('24-06-2023', 'dd-mm-yyyy'), 2585543413, 316896662, 297159);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1170, 1170, to_date('02-06-2023', 'dd-mm-yyyy'), 2761848852, 375037348, 297586);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1171, 1171, to_date('15-06-2023', 'dd-mm-yyyy'), 791072108, 223058663, 297661);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1172, 1172, to_date('27-06-2023', 'dd-mm-yyyy'), 750332103, 226520741, 297770);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1173, 1173, to_date('18-06-2023', 'dd-mm-yyyy'), 2132466374, 251473344, 299980);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1174, 1174, to_date('15-06-2023', 'dd-mm-yyyy'), 2563622969, 342517245, 300049);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1175, 1175, to_date('22-06-2023', 'dd-mm-yyyy'), 1162078782, 279543919, 301174);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1176, 1176, to_date('21-06-2023', 'dd-mm-yyyy'), 1790631476, 351668768, 301396);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1177, 1177, to_date('25-06-2023', 'dd-mm-yyyy'), 2499086167, 378453080, 302711);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1178, 1178, to_date('22-06-2023', 'dd-mm-yyyy'), 3838034560, 231987717, 303183);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1179, 1179, to_date('28-06-2023', 'dd-mm-yyyy'), 2659036125, 265199943, 304607);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1180, 1180, to_date('18-06-2023', 'dd-mm-yyyy'), 3633182606, 359089400, 304661);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1181, 1181, to_date('24-06-2023', 'dd-mm-yyyy'), 1721112606, 293310565, 304802);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1182, 1182, to_date('01-06-2023', 'dd-mm-yyyy'), 4108380694, 382524856, 307284);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1183, 1183, to_date('29-06-2023', 'dd-mm-yyyy'), 1515581915, 234383859, 308883);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1184, 1184, to_date('26-06-2023', 'dd-mm-yyyy'), 118976950, 291697284, 308940);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1185, 1185, to_date('10-06-2023', 'dd-mm-yyyy'), 3030217035, 292117233, 309155);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1186, 1186, to_date('30-05-2023', 'dd-mm-yyyy'), 3488016959, 348147944, 309834);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1187, 1187, to_date('13-06-2023', 'dd-mm-yyyy'), 1747392301, 273298003, 312159);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1188, 1188, to_date('27-06-2023', 'dd-mm-yyyy'), 3224426277, 286222029, 312333);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1189, 1189, to_date('21-06-2023', 'dd-mm-yyyy'), 2000809820, 213322864, 312614);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1190, 1190, to_date('04-06-2023', 'dd-mm-yyyy'), 443234907, 218646495, 312727);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1191, 1191, to_date('06-06-2023', 'dd-mm-yyyy'), 3189841920, 338993209, 314173);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1192, 1192, to_date('01-06-2023', 'dd-mm-yyyy'), 937385985, 291745197, 315006);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1193, 1193, to_date('23-06-2023', 'dd-mm-yyyy'), 1142950160, 295504003, 315937);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1194, 1194, to_date('08-06-2023', 'dd-mm-yyyy'), 1781354773, 286256884, 316747);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1195, 1195, to_date('09-06-2023', 'dd-mm-yyyy'), 3907058574, 239573283, 317898);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1196, 1196, to_date('21-06-2023', 'dd-mm-yyyy'), 509672752, 338383773, 318149);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1197, 1197, to_date('20-06-2023', 'dd-mm-yyyy'), 1393501725, 313422914, 318220);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1198, 1198, to_date('03-06-2023', 'dd-mm-yyyy'), 2260158743, 201157338, 318228);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1199, 1199, to_date('24-06-2023', 'dd-mm-yyyy'), 3082585767, 316694395, 318244);
commit;
prompt 200 records committed...
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1200, 1200, to_date('22-06-2023', 'dd-mm-yyyy'), 1877959785, 242838870, 320413);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1201, 1201, to_date('12-06-2023', 'dd-mm-yyyy'), 1660146012, 332240843, 320865);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1202, 1202, to_date('23-06-2023', 'dd-mm-yyyy'), 3979804712, 326250050, 321292);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1203, 1203, to_date('27-06-2023', 'dd-mm-yyyy'), 582588412, 208953132, 321442);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1204, 1204, to_date('14-06-2023', 'dd-mm-yyyy'), 3173876124, 345028424, 321559);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1205, 1205, to_date('03-06-2023', 'dd-mm-yyyy'), 620223331, 387229316, 321758);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1206, 1206, to_date('21-06-2023', 'dd-mm-yyyy'), 2418851966, 259199134, 323236);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1207, 1207, to_date('08-06-2023', 'dd-mm-yyyy'), 3481561594, 342256992, 323658);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1208, 1208, to_date('31-05-2023', 'dd-mm-yyyy'), 220372518, 357522613, 323926);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1209, 1209, to_date('25-06-2023', 'dd-mm-yyyy'), 4157143176, 243823245, 324295);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1210, 1210, to_date('30-05-2023', 'dd-mm-yyyy'), 2779816091, 367193204, 324534);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1211, 1211, to_date('02-06-2023', 'dd-mm-yyyy'), 1201267855, 200771028, 325716);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1212, 1212, to_date('17-06-2023', 'dd-mm-yyyy'), 2703360325, 297000767, 326187);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1213, 1213, to_date('30-05-2023', 'dd-mm-yyyy'), 234257385, 250359573, 326661);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1214, 1214, to_date('12-06-2023', 'dd-mm-yyyy'), 2029500891, 257401303, 327117);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1215, 1215, to_date('21-06-2023', 'dd-mm-yyyy'), 221412715, 209534435, 327311);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1216, 1216, to_date('04-06-2023', 'dd-mm-yyyy'), 2929262243, 294448518, 327313);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1217, 1217, to_date('16-06-2023', 'dd-mm-yyyy'), 708880321, 353345218, 327703);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1218, 1218, to_date('14-06-2023', 'dd-mm-yyyy'), 1295334620, 313590950, 327842);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1219, 1219, to_date('01-06-2023', 'dd-mm-yyyy'), 2420932006, 237340794, 327952);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1220, 1220, to_date('11-06-2023', 'dd-mm-yyyy'), 2721361582, 308313920, 328298);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1221, 1221, to_date('22-06-2023', 'dd-mm-yyyy'), 238313927, 282598062, 329005);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1222, 1222, to_date('25-06-2023', 'dd-mm-yyyy'), 2649231766, 316877033, 329850);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1223, 1223, to_date('03-06-2023', 'dd-mm-yyyy'), 2073397479, 315975743, 330304);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1224, 1224, to_date('25-06-2023', 'dd-mm-yyyy'), 1629072520, 242341315, 331052);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1225, 1225, to_date('05-06-2023', 'dd-mm-yyyy'), 2373393757, 351104744, 331725);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1226, 1226, to_date('19-06-2023', 'dd-mm-yyyy'), 1155533144, 236070328, 332607);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1227, 1227, to_date('25-06-2023', 'dd-mm-yyyy'), 2333424436, 289405820, 333053);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1228, 1228, to_date('22-06-2023', 'dd-mm-yyyy'), 1848932145, 257301681, 333412);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1229, 1229, to_date('11-06-2023', 'dd-mm-yyyy'), 3292746234, 271938993, 333939);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1230, 1230, to_date('23-06-2023', 'dd-mm-yyyy'), 3068711309, 340594367, 334772);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1231, 1231, to_date('13-06-2023', 'dd-mm-yyyy'), 3517253153, 284012229, 334886);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1232, 1232, to_date('07-06-2023', 'dd-mm-yyyy'), 3611290723, 353338208, 334999);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1233, 1233, to_date('08-06-2023', 'dd-mm-yyyy'), 2944875005, 282084259, 335224);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1234, 1234, to_date('31-05-2023', 'dd-mm-yyyy'), 823918207, 306439412, 335506);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1235, 1235, to_date('03-06-2023', 'dd-mm-yyyy'), 1888219726, 328463277, 335660);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1236, 1236, to_date('02-06-2023', 'dd-mm-yyyy'), 901432435, 247145869, 337928);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1237, 1237, to_date('12-06-2023', 'dd-mm-yyyy'), 3461336247, 360504390, 339261);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1238, 1238, to_date('16-06-2023', 'dd-mm-yyyy'), 667710806, 263122301, 339979);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1239, 1239, to_date('10-06-2023', 'dd-mm-yyyy'), 1860377559, 349319230, 340551);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1240, 1240, to_date('03-06-2023', 'dd-mm-yyyy'), 1279348624, 235703717, 341768);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1241, 1241, to_date('08-06-2023', 'dd-mm-yyyy'), 3457912328, 215306111, 341774);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1242, 1242, to_date('22-06-2023', 'dd-mm-yyyy'), 1030882184, 317120894, 341909);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1243, 1243, to_date('03-06-2023', 'dd-mm-yyyy'), 2189110660, 295963344, 342305);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1244, 1244, to_date('03-06-2023', 'dd-mm-yyyy'), 3030370212, 365778672, 342428);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1245, 1245, to_date('15-06-2023', 'dd-mm-yyyy'), 145406197, 292337047, 344750);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1246, 1246, to_date('23-06-2023', 'dd-mm-yyyy'), 3032558076, 264751878, 344944);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1247, 1247, to_date('23-06-2023', 'dd-mm-yyyy'), 4097297588, 385952818, 345455);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1248, 1248, to_date('27-06-2023', 'dd-mm-yyyy'), 670841603, 215919530, 345475);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1249, 1249, to_date('13-06-2023', 'dd-mm-yyyy'), 3092043234, 305063038, 347525);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1250, 1250, to_date('19-06-2023', 'dd-mm-yyyy'), 2517659001, 304960689, 347562);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1251, 1251, to_date('14-06-2023', 'dd-mm-yyyy'), 524583443, 369383417, 347733);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1252, 1252, to_date('30-05-2023', 'dd-mm-yyyy'), 4209255256, 315159983, 347818);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1253, 1253, to_date('02-06-2023', 'dd-mm-yyyy'), 3303430975, 383068508, 347873);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1254, 1254, to_date('02-06-2023', 'dd-mm-yyyy'), 4134052510, 379992281, 347981);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1255, 1255, to_date('27-06-2023', 'dd-mm-yyyy'), 1148855233, 368361520, 348727);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1256, 1256, to_date('31-05-2023', 'dd-mm-yyyy'), 2195239809, 380149339, 348848);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1257, 1257, to_date('23-06-2023', 'dd-mm-yyyy'), 3238496450, 294023629, 349074);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1258, 1258, to_date('26-06-2023', 'dd-mm-yyyy'), 490180534, 379411520, 349099);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1259, 1259, to_date('03-06-2023', 'dd-mm-yyyy'), 900040387, 385177335, 349703);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1260, 1260, to_date('25-06-2023', 'dd-mm-yyyy'), 449644944, 239929754, 350947);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1261, 1261, to_date('01-06-2023', 'dd-mm-yyyy'), 3533811218, 221462028, 351026);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1262, 1262, to_date('27-06-2023', 'dd-mm-yyyy'), 1218862098, 260441923, 351081);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1263, 1263, to_date('11-06-2023', 'dd-mm-yyyy'), 1150216031, 370273040, 351124);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1264, 1264, to_date('11-06-2023', 'dd-mm-yyyy'), 2623671494, 245078686, 353090);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1265, 1265, to_date('11-06-2023', 'dd-mm-yyyy'), 1082024660, 358212799, 353284);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1266, 1266, to_date('29-06-2023', 'dd-mm-yyyy'), 3212917977, 325091518, 354193);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1267, 1267, to_date('07-06-2023', 'dd-mm-yyyy'), 3704443836, 318599595, 354851);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1268, 1268, to_date('21-06-2023', 'dd-mm-yyyy'), 4136582605, 285435332, 355023);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1269, 1269, to_date('06-06-2023', 'dd-mm-yyyy'), 428074911, 232830547, 355220);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1270, 1270, to_date('09-06-2023', 'dd-mm-yyyy'), 3994028077, 232034549, 355503);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1271, 1271, to_date('24-06-2023', 'dd-mm-yyyy'), 381605407, 290455974, 355607);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1272, 1272, to_date('06-06-2023', 'dd-mm-yyyy'), 2261379361, 388129809, 356241);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1273, 1273, to_date('26-06-2023', 'dd-mm-yyyy'), 2998668774, 253867252, 356294);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1274, 1274, to_date('13-06-2023', 'dd-mm-yyyy'), 1715394225, 308717810, 356322);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1275, 1275, to_date('02-06-2023', 'dd-mm-yyyy'), 3992596192, 300404573, 357246);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1276, 1276, to_date('07-06-2023', 'dd-mm-yyyy'), 762098278, 215133805, 357550);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1277, 1277, to_date('05-06-2023', 'dd-mm-yyyy'), 4263432723, 214329655, 358995);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1278, 1278, to_date('10-06-2023', 'dd-mm-yyyy'), 2387702559, 226660320, 359321);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1279, 1279, to_date('07-06-2023', 'dd-mm-yyyy'), 1294033638, 255356533, 359768);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1280, 1280, to_date('18-06-2023', 'dd-mm-yyyy'), 4289386642, 337051483, 359769);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1281, 1281, to_date('18-06-2023', 'dd-mm-yyyy'), 3170169411, 376165958, 359770);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1282, 1282, to_date('11-06-2023', 'dd-mm-yyyy'), 2589336619, 220415119, 359771);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1283, 1283, to_date('11-06-2023', 'dd-mm-yyyy'), 408119777, 360420742, 359772);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1284, 1284, to_date('05-06-2023', 'dd-mm-yyyy'), 2745029688, 227369348, 359773);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1285, 1285, to_date('04-06-2023', 'dd-mm-yyyy'), 3999013901, 352125561, 359774);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1286, 1286, to_date('15-06-2023', 'dd-mm-yyyy'), 395745494, 388161917, 359775);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1287, 1287, to_date('07-06-2023', 'dd-mm-yyyy'), 3384845406, 368610255, 359776);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1288, 1288, to_date('20-06-2023', 'dd-mm-yyyy'), 1571758849, 318883867, 359777);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1289, 1289, to_date('17-06-2023', 'dd-mm-yyyy'), 2201884681, 359835609, 359778);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1290, 1290, to_date('03-06-2023', 'dd-mm-yyyy'), 2930896282, 309399354, 359779);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1291, 1291, to_date('21-06-2023', 'dd-mm-yyyy'), 3244876693, 277999888, 359780);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1292, 1292, to_date('01-06-2023', 'dd-mm-yyyy'), 2801048856, 311525561, 359781);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1293, 1293, to_date('05-06-2023', 'dd-mm-yyyy'), 1711596415, 350438065, 359782);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1294, 1294, to_date('16-06-2023', 'dd-mm-yyyy'), 3357212618, 312705624, 359783);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1295, 1295, to_date('27-06-2023', 'dd-mm-yyyy'), 3500429192, 377428731, 359784);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1296, 1296, to_date('07-06-2023', 'dd-mm-yyyy'), 2177147130, 218298341, 359785);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1297, 1297, to_date('03-06-2023', 'dd-mm-yyyy'), 1310860904, 351631101, 359786);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1298, 1298, to_date('09-06-2023', 'dd-mm-yyyy'), 2546024439, 264036200, 359787);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1299, 1299, to_date('01-06-2023', 'dd-mm-yyyy'), 2695624626, 299341333, 359788);
commit;
prompt 300 records committed...
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1300, 1300, to_date('21-06-2023', 'dd-mm-yyyy'), 723619990, 233552819, 359789);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1301, 1301, to_date('08-06-2023', 'dd-mm-yyyy'), 1153830371, 310000000, 359790);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1302, 1302, to_date('16-06-2023', 'dd-mm-yyyy'), 3893286587, 310000001, 359791);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1303, 1303, to_date('13-06-2023', 'dd-mm-yyyy'), 82937339, 310000002, 359792);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1304, 1304, to_date('06-06-2023', 'dd-mm-yyyy'), 1017840928, 310000003, 359793);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1305, 1305, to_date('30-05-2023', 'dd-mm-yyyy'), 4271323511, 310000004, 359794);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1306, 1306, to_date('10-06-2023', 'dd-mm-yyyy'), 505370118, 310000005, 359795);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1307, 1307, to_date('05-06-2023', 'dd-mm-yyyy'), 3872777923, 310000006, 359796);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1308, 1308, to_date('18-06-2023', 'dd-mm-yyyy'), 1625454938, 310000007, 359797);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1309, 1309, to_date('27-06-2023', 'dd-mm-yyyy'), 2457452168, 310000008, 359798);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1310, 1310, to_date('18-06-2023', 'dd-mm-yyyy'), 2267746773, 310000009, 359799);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1311, 1311, to_date('12-06-2023', 'dd-mm-yyyy'), 3806033862, 310000010, 359800);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1312, 1312, to_date('01-06-2023', 'dd-mm-yyyy'), 400764289, 310000011, 359801);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1313, 1313, to_date('29-06-2023', 'dd-mm-yyyy'), 3545515586, 310000012, 359802);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1314, 1314, to_date('27-06-2023', 'dd-mm-yyyy'), 3834351364, 310000013, 359803);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1315, 1315, to_date('26-06-2023', 'dd-mm-yyyy'), 1013696666, 310000014, 359804);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1316, 1316, to_date('19-06-2023', 'dd-mm-yyyy'), 3388722296, 310000015, 359805);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1317, 1317, to_date('08-06-2023', 'dd-mm-yyyy'), 196310980, 310000016, 359806);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1318, 1318, to_date('25-06-2023', 'dd-mm-yyyy'), 3025067115, 310000017, 359807);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1319, 1319, to_date('12-06-2023', 'dd-mm-yyyy'), 4823046, 310000018, 359808);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1320, 1320, to_date('16-06-2023', 'dd-mm-yyyy'), 657469100, 310000019, 359809);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1321, 1321, to_date('30-05-2023', 'dd-mm-yyyy'), 3513889593, 310000020, 359810);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1322, 1322, to_date('26-06-2023', 'dd-mm-yyyy'), 562736699, 310000021, 359811);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1323, 1323, to_date('17-06-2023', 'dd-mm-yyyy'), 276551217, 310000022, 359812);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1324, 1324, to_date('08-06-2023', 'dd-mm-yyyy'), 4170852646, 310000023, 359813);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1325, 1325, to_date('29-06-2023', 'dd-mm-yyyy'), 238671426, 310000024, 359814);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1326, 1326, to_date('17-06-2023', 'dd-mm-yyyy'), 2310616106, 310000025, 359815);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1327, 1327, to_date('07-06-2023', 'dd-mm-yyyy'), 4044514624, 310000026, 359816);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1328, 1328, to_date('22-06-2023', 'dd-mm-yyyy'), 397181319, 310000027, 359817);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1329, 1329, to_date('12-06-2023', 'dd-mm-yyyy'), 982716585, 310000028, 359818);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1330, 1330, to_date('22-06-2023', 'dd-mm-yyyy'), 1556219250, 310000029, 359819);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1331, 1331, to_date('28-06-2023', 'dd-mm-yyyy'), 3584288395, 310000030, 359820);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1332, 1332, to_date('08-06-2023', 'dd-mm-yyyy'), 1998832504, 310000031, 359821);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1333, 1333, to_date('22-06-2023', 'dd-mm-yyyy'), 2611671527, 310000032, 359822);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1334, 1334, to_date('02-06-2023', 'dd-mm-yyyy'), 1928912117, 310000033, 359823);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1335, 1335, to_date('02-06-2023', 'dd-mm-yyyy'), 3940023093, 310000034, 359824);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1336, 1336, to_date('09-06-2023', 'dd-mm-yyyy'), 2369112239, 310000035, 359825);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1337, 1337, to_date('28-06-2023', 'dd-mm-yyyy'), 81557478, 310000036, 359826);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1338, 1338, to_date('31-05-2023', 'dd-mm-yyyy'), 142186532, 310000037, 359827);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1339, 1339, to_date('06-06-2023', 'dd-mm-yyyy'), 3196158797, 310000038, 359828);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1340, 1340, to_date('05-06-2023', 'dd-mm-yyyy'), 3970642656, 310000039, 359829);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1341, 1341, to_date('15-06-2023', 'dd-mm-yyyy'), 2699849518, 310000040, 359830);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1342, 1342, to_date('30-05-2023', 'dd-mm-yyyy'), 1272943148, 310000041, 359831);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1343, 1343, to_date('15-06-2023', 'dd-mm-yyyy'), 2112001926, 310000042, 359832);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1344, 1344, to_date('04-06-2023', 'dd-mm-yyyy'), 3071216489, 310000043, 359833);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1345, 1345, to_date('21-06-2023', 'dd-mm-yyyy'), 4173111480, 310000044, 359834);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1346, 1346, to_date('26-06-2023', 'dd-mm-yyyy'), 4159326597, 310000045, 359835);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1347, 1347, to_date('09-06-2023', 'dd-mm-yyyy'), 944023186, 310000046, 359836);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1348, 1348, to_date('02-06-2023', 'dd-mm-yyyy'), 476547254, 310000047, 359837);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1349, 1349, to_date('31-05-2023', 'dd-mm-yyyy'), 2932990645, 310000048, 359838);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1350, 1350, to_date('19-06-2023', 'dd-mm-yyyy'), 660929753, 310000049, 359839);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1351, 1351, to_date('11-06-2023', 'dd-mm-yyyy'), 1112726679, 310000050, 359840);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1352, 1352, to_date('20-06-2023', 'dd-mm-yyyy'), 3924827205, 310000051, 359841);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1353, 1353, to_date('29-06-2023', 'dd-mm-yyyy'), 1967453781, 310000052, 359842);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1354, 1354, to_date('18-06-2023', 'dd-mm-yyyy'), 1642574897, 310000053, 359843);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1355, 1355, to_date('30-05-2023', 'dd-mm-yyyy'), 155663756, 310000054, 359844);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1356, 1356, to_date('12-06-2023', 'dd-mm-yyyy'), 2494857483, 310000055, 359845);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1357, 1357, to_date('09-06-2023', 'dd-mm-yyyy'), 3463401023, 310000056, 359846);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1358, 1358, to_date('29-06-2023', 'dd-mm-yyyy'), 1688709964, 310000057, 359847);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1359, 1359, to_date('20-06-2023', 'dd-mm-yyyy'), 3781592932, 310000058, 360186);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1360, 1360, to_date('31-05-2023', 'dd-mm-yyyy'), 2498253907, 310000059, 360459);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1361, 1361, to_date('21-06-2023', 'dd-mm-yyyy'), 855321991, 310000060, 360889);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1362, 1362, to_date('09-06-2023', 'dd-mm-yyyy'), 1604649332, 310000061, 360991);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1363, 1363, to_date('07-06-2023', 'dd-mm-yyyy'), 3321500208, 310000062, 361814);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1364, 1364, to_date('25-06-2023', 'dd-mm-yyyy'), 468108540, 310000063, 362218);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1365, 1365, to_date('11-06-2023', 'dd-mm-yyyy'), 425783601, 310000064, 362585);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1366, 1366, to_date('18-06-2023', 'dd-mm-yyyy'), 1471488100, 310000065, 363782);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1367, 1367, to_date('25-06-2023', 'dd-mm-yyyy'), 1951815574, 310000066, 364232);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1368, 1368, to_date('19-06-2023', 'dd-mm-yyyy'), 2277859555, 310000067, 366610);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1369, 1369, to_date('17-06-2023', 'dd-mm-yyyy'), 3560536687, 310000068, 366837);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1370, 1370, to_date('21-06-2023', 'dd-mm-yyyy'), 3117624861, 310000069, 366935);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1371, 1371, to_date('20-06-2023', 'dd-mm-yyyy'), 3904415813, 310000070, 367307);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1372, 1372, to_date('09-06-2023', 'dd-mm-yyyy'), 2753157145, 310000071, 367909);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1373, 1373, to_date('15-06-2023', 'dd-mm-yyyy'), 3883784645, 310000072, 368749);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1374, 1374, to_date('29-06-2023', 'dd-mm-yyyy'), 3296988353, 310000073, 368758);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1375, 1375, to_date('29-06-2023', 'dd-mm-yyyy'), 1664409612, 310000074, 372197);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1376, 1376, to_date('06-06-2023', 'dd-mm-yyyy'), 4291952742, 310000075, 372315);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1377, 1377, to_date('16-06-2023', 'dd-mm-yyyy'), 1903082893, 310000076, 373297);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1378, 1378, to_date('25-06-2023', 'dd-mm-yyyy'), 1114723475, 310000077, 373619);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1379, 1379, to_date('31-05-2023', 'dd-mm-yyyy'), 752773406, 310000078, 373729);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1380, 1380, to_date('06-06-2023', 'dd-mm-yyyy'), 841567993, 310000079, 375014);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1381, 1381, to_date('05-06-2023', 'dd-mm-yyyy'), 1801185272, 234413401, 376626);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1382, 1382, to_date('19-06-2023', 'dd-mm-yyyy'), 2873700409, 214945813, 376900);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1383, 1383, to_date('13-06-2023', 'dd-mm-yyyy'), 1313078341, 332113182, 377628);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1384, 1384, to_date('15-06-2023', 'dd-mm-yyyy'), 2788966181, 207083715, 377698);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1385, 1385, to_date('28-06-2023', 'dd-mm-yyyy'), 2485263056, 386178461, 378711);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1386, 1386, to_date('24-06-2023', 'dd-mm-yyyy'), 2171424292, 217056502, 378885);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1387, 1387, to_date('12-06-2023', 'dd-mm-yyyy'), 3551736206, 281154307, 380512);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1388, 1388, to_date('31-05-2023', 'dd-mm-yyyy'), 622994605, 320345744, 380933);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1389, 1389, to_date('27-06-2023', 'dd-mm-yyyy'), 56045864, 325389215, 381067);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1390, 1390, to_date('23-06-2023', 'dd-mm-yyyy'), 499848229, 210470680, 381422);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1391, 1391, to_date('31-05-2023', 'dd-mm-yyyy'), 2146024878, 335673295, 382058);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1392, 1392, to_date('11-06-2023', 'dd-mm-yyyy'), 3613982088, 310266508, 383198);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1393, 1393, to_date('02-06-2023', 'dd-mm-yyyy'), 3996108394, 335012305, 383794);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1394, 1394, to_date('12-06-2023', 'dd-mm-yyyy'), 717220180, 272173133, 384407);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1395, 1395, to_date('23-06-2023', 'dd-mm-yyyy'), 3771158295, 355616367, 385754);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1396, 1396, to_date('07-06-2023', 'dd-mm-yyyy'), 2128813517, 363641567, 386163);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1397, 1397, to_date('16-06-2023', 'dd-mm-yyyy'), 681250929, 341750599, 386254);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1398, 1398, to_date('20-06-2023', 'dd-mm-yyyy'), 2256772699, 274810074, 386651);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1399, 1399, to_date('19-06-2023', 'dd-mm-yyyy'), 4184162999, 227710098, 386915);
commit;
prompt 400 records committed...
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1400, 1400, to_date('14-06-2023', 'dd-mm-yyyy'), 84919454, 362506458, 387007);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1401, 1401, to_date('27-06-2023', 'dd-mm-yyyy'), 3937385977, 209218853, 387418);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1402, 1402, to_date('09-06-2023', 'dd-mm-yyyy'), 3981901827, 374271549, 387567);
insert into BOOKING (booking_id, journey_id, booking_date, passenger_id, seller_id, ticket_id)
values (1403, 1403, to_date('10-06-2023', 'dd-mm-yyyy'), 2467349848, 381386109, 387947);
commit;
prompt 404 records loaded
prompt Loading BUS...
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (1, '25-594-39', 'Quest', 36, to_date('17-08-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (2, '46-862-66', 'ES', 59, to_date('06-04-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (3, '58-756-53', 'Nitro', 47, to_date('26-09-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (4, '52-350-93', '929', 26, to_date('24-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (5, '17-475-49', 'Taurus', 24, to_date('27-10-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (6, '14-604-74', 'Murano', 22, to_date('29-02-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (7, '81-439-09', 'S10', 50, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (8, '26-908-79', 'F430', 39, to_date('11-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (9, '53-020-75', 'F-Series', 49, to_date('05-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (10, '24-114-03', 'GranTurismo', 47, to_date('26-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (11, '85-184-67', 'MX-5', 28, to_date('01-06-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (12, '68-224-64', 'Pathfinder', 46, to_date('16-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (13, '80-654-85', 'Cabriolet', 43, to_date('25-06-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (14, '76-039-28', 'Optima', 55, to_date('23-09-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (15, '97-283-20', 'Grand Am', 33, to_date('04-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (16, '52-756-67', 'Sidekick', 58, to_date('29-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (17, '01-306-20', 'H1', 28, to_date('10-03-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (18, '45-290-46', 'Aspen', 37, to_date('12-06-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (19, '11-070-06', 'Highlander', 30, to_date('16-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (20, '92-001-94', 'A8', 52, to_date('30-11-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (21, '92-472-24', 'Monte Carlo', 56, to_date('26-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (22, '84-872-60', 'Sparrow', 36, to_date('10-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (23, '35-887-62', 'Celica', 39, to_date('02-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (24, '73-786-11', 'Versa', 47, to_date('06-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (25, '48-574-33', 'C-Class', 31, to_date('22-09-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (26, '04-521-50', 'Exige', 45, to_date('31-01-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (27, '14-690-66', 'ES', 60, to_date('17-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (28, '10-875-33', 'B-Series', 41, to_date('17-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (29, '07-586-71', 'ES', 38, to_date('24-02-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (30, '08-050-18', 'Montana', 52, to_date('26-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (31, '06-229-97', 'Catera', 27, to_date('16-08-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (32, '94-648-14', 'Truck', 37, to_date('09-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (33, '19-340-13', 'Golf', 38, to_date('22-06-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (34, '28-372-69', 'Breeze', 25, to_date('18-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (35, '73-950-05', 'Corvette', 51, to_date('19-11-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (36, '43-601-87', 'Taurus', 25, to_date('25-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (37, '39-341-38', 'Sonoma', 48, to_date('25-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (38, '27-058-30', 'Sienna', 53, to_date('02-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (39, '88-885-15', '5000S', 38, to_date('14-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (40, '23-591-28', 'Leone', 56, to_date('04-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (41, '95-745-00', 'VUE', 27, to_date('30-06-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (42, '94-802-49', 'Cabriolet', 34, to_date('02-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (43, '96-266-48', 'Camaro', 47, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (44, '84-226-89', 'CL-Class', 40, to_date('02-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (45, '11-868-96', 'Galant', 25, to_date('09-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (46, '65-612-38', '9-5', 34, to_date('08-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (47, '79-107-13', 'Firebird', 50, to_date('23-02-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (48, '74-529-12', 'Regal', 28, to_date('03-06-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (49, '35-751-39', 'Escalade ESV', 53, to_date('19-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (50, '39-100-42', 'Thunderbird', 41, to_date('19-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (51, '59-173-37', 'Electra', 31, to_date('13-03-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (52, '82-645-96', 'Ascender', 30, to_date('22-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (53, '64-737-11', 'A4', 46, to_date('15-04-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (54, '43-902-99', '940', 31, to_date('29-11-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (55, '65-514-77', 'Range Rover', 46, to_date('07-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (56, '23-198-21', 'Avalon', 25, to_date('22-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (57, '05-899-01', 'Loyale', 38, to_date('23-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (58, '97-537-28', 'Grand Prix', 59, to_date('26-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (59, '48-297-02', 'Cavalier', 52, to_date('03-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (60, '14-186-32', 'Murano', 59, to_date('11-03-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (61, '48-726-29', 'Ram 1500', 41, to_date('23-09-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (62, '67-877-18', 'B-Series Plus', 38, to_date('13-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (63, '97-772-83', 'Landaulet', 58, to_date('08-12-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (64, '98-137-54', 'Tahoe', 44, to_date('21-12-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (65, '70-338-20', 'X5', 58, to_date('23-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (66, '47-597-13', 'S-Series', 29, to_date('12-04-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (67, '53-312-66', 'H2', 59, to_date('13-01-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (68, '24-939-61', 'Transit Connect', 60, to_date('25-10-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (69, '21-625-02', 'Starion', 31, to_date('07-09-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (70, '09-518-69', 'Phantom', 22, to_date('27-02-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (71, '68-845-97', '1500', 20, to_date('21-04-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (72, '90-142-89', 'Park Avenue', 51, to_date('15-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (73, '57-071-05', 'Elise', 48, to_date('07-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (74, '08-877-36', 'Eurovan', 37, to_date('03-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (75, '54-619-17', 'CTS-V', 33, to_date('29-12-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (76, '25-868-05', 'Impreza', 42, to_date('28-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (77, '38-897-40', 'DBS', 56, to_date('05-01-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (78, '48-088-66', 'Tercel', 31, to_date('30-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (79, '16-600-60', 'Grand Am', 20, to_date('20-07-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (80, '18-460-91', '300E', 51, to_date('22-09-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (81, '06-972-91', 'Tahoe', 40, to_date('19-04-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (82, '89-068-03', 'Bonneville', 53, to_date('05-06-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (83, '88-707-34', 'Express 1500', 52, to_date('28-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (84, '28-772-37', 'Marauder', 50, to_date('07-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (85, '51-823-68', 'MX-6', 49, to_date('10-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (86, '94-089-27', 'Rally Wagon G2500', 37, to_date('30-11-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (87, '76-008-65', 'Fiero', 55, to_date('28-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (88, '82-173-44', 'S6', 28, to_date('10-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (89, '88-720-60', 'C70', 31, to_date('31-01-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (90, '01-707-40', 'Park Avenue', 52, to_date('29-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (91, '32-447-07', 'LX', 40, to_date('01-03-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (92, '54-081-09', 'Mustang', 23, to_date('20-01-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (93, '86-777-44', 'Odyssey', 53, to_date('29-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (94, '22-440-90', 'Explorer', 24, to_date('23-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (95, '69-174-10', 'Yukon XL 1500', 34, to_date('26-06-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (96, '82-765-22', 'Skylark', 27, to_date('25-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (97, '35-922-33', 'Montero Sport', 24, to_date('19-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (98, '11-513-19', '350Z', 46, to_date('16-02-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (99, '25-909-13', 'IS', 57, to_date('06-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (100, '55-511-58', 'Ascender', 40, to_date('17-04-2022', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (101, '08-524-79', 'Topaz', 38, to_date('08-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (102, '76-761-56', 'XC60', 47, to_date('09-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (103, '12-070-21', 'RDX', 46, to_date('19-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (104, '10-092-59', 'Quest', 41, to_date('17-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (105, '05-694-81', 'F-Series', 28, to_date('16-02-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (106, '92-139-71', 'IS', 54, to_date('13-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (107, '34-588-94', 'Eldorado', 31, to_date('18-11-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (108, '95-493-19', '5000CS', 41, to_date('28-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (109, '80-184-07', 'Caravan', 54, to_date('31-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (110, '06-654-96', 'Highlander', 52, to_date('23-02-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (111, '18-776-74', 'Sunfire', 60, to_date('06-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (112, '72-196-44', 'PT Cruiser', 30, to_date('25-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (113, '52-082-06', 'Grand Caravan', 24, to_date('15-05-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (114, '53-662-07', 'Freelander', 45, to_date('26-05-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (115, '68-939-78', 'MPV', 26, to_date('03-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (116, '69-018-48', 'F-Series', 40, to_date('05-07-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (117, '58-855-47', 'Routan', 37, to_date('01-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (118, '91-586-44', 'Boxster', 52, to_date('11-03-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (119, '90-866-13', 'GS', 44, to_date('05-05-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (120, '78-627-36', 'Swift', 46, to_date('11-11-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (121, '48-826-60', 'Navigator L', 49, to_date('24-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (122, '81-150-78', 'R8', 57, to_date('22-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (123, '68-408-75', 'Durango', 55, to_date('02-07-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (124, '35-668-71', 'X5', 59, to_date('26-12-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (125, '62-441-04', 'B-Series', 31, to_date('20-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (126, '45-092-95', 'XC90', 53, to_date('04-04-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (127, '75-009-17', 'Storm', 48, to_date('03-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (128, '87-980-70', 'Ram Van 2500', 40, to_date('30-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (129, '28-110-37', 'Galant', 50, to_date('31-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (130, '27-977-99', 'X5', 32, to_date('02-01-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (131, '84-860-59', 'Dakota Club', 23, to_date('10-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (132, '89-692-19', 'I', 45, to_date('25-02-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (133, '19-487-48', '2CV', 29, to_date('16-06-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (134, '25-082-42', 'F-Series', 54, to_date('03-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (135, '93-972-53', '164', 44, to_date('10-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (136, '80-089-44', 'Edge', 46, to_date('09-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (137, '96-239-19', 'LS', 48, to_date('26-04-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (138, '34-331-44', 'Cooper Clubman', 28, to_date('03-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (139, '87-878-18', 'LR2', 46, to_date('29-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (140, '58-562-09', 'Savana 2500', 25, to_date('16-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (141, '95-917-28', 'Intrigue', 37, to_date('05-04-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (142, '53-781-68', 'Grand Marquis', 50, to_date('13-03-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (143, '38-790-09', '968', 46, to_date('12-09-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (144, '22-507-22', 'Starion', 45, to_date('08-05-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (145, '84-892-23', 'Sonoma', 48, to_date('15-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (146, '35-833-83', 'CTS', 24, to_date('19-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (147, '63-004-22', 'Ion', 45, to_date('13-12-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (148, '93-602-10', 'Grand Marquis', 56, to_date('27-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (149, '57-908-14', 'Altima', 42, to_date('07-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (150, '22-503-95', 'Aveo', 53, to_date('04-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (151, '45-077-17', 'Sierra 3500', 51, to_date('01-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (152, '40-124-02', 'Acadia', 58, to_date('27-03-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (153, '07-956-39', 'B-Series', 36, to_date('02-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (154, '55-307-96', 'A8', 36, to_date('27-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (155, '25-615-31', 'Grand Vitara', 57, to_date('22-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (156, '20-053-88', 'C70', 36, to_date('05-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (157, '83-509-28', 'E350', 21, to_date('14-10-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (158, '16-316-39', 'Dakota Club', 47, to_date('19-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (159, '31-701-95', 'F-Series', 42, to_date('07-02-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (160, '41-555-52', 'Sportvan G30', 26, to_date('16-08-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (161, '97-757-84', 'Camaro', 30, to_date('19-04-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (162, '67-685-48', 'Express', 57, to_date('28-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (163, '72-005-76', 'Parisienne', 23, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (164, '99-354-20', 'Navigator L', 47, to_date('11-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (165, '41-976-78', 'GTO', 47, to_date('05-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (166, '94-212-94', 'E350', 55, to_date('23-10-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (167, '12-285-72', 'Land Cruiser', 49, to_date('15-03-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (168, '40-837-71', '1500 Club Coupe', 43, to_date('08-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (169, '75-711-88', 'F150', 52, to_date('28-02-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (170, '44-949-56', 'Oasis', 47, to_date('03-01-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (171, '10-968-62', 'Grand Vitara', 44, to_date('11-05-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (172, '29-350-39', 'A6', 32, to_date('25-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (173, '08-311-44', 'Sportage', 42, to_date('21-08-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (174, '44-140-18', 'Silhouette', 55, to_date('01-04-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (175, '66-097-52', '968', 50, to_date('04-06-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (176, '16-059-50', 'TrailBlazer', 30, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (177, '03-729-92', 'Highlander', 42, to_date('21-02-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (178, '04-379-30', 'Sierra 1500', 45, to_date('16-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (179, '72-272-17', 'Accord', 28, to_date('14-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (180, '17-079-90', 'F450', 52, to_date('21-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (181, '15-145-20', '900', 54, to_date('20-09-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (182, '34-535-39', '300SE', 32, to_date('19-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (183, '12-137-39', 'S-Class', 22, to_date('28-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (184, '75-420-51', 'Brat', 37, to_date('20-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (185, '80-691-84', 'Sierra 3500', 58, to_date('21-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (186, '55-296-29', 'Stylus', 20, to_date('30-03-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (187, '88-768-53', '240', 59, to_date('01-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (188, '03-375-02', 'Corvette', 40, to_date('12-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (189, '43-487-96', '9-7X', 56, to_date('20-04-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (190, '85-021-45', '525', 36, to_date('04-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (191, '81-566-48', 'Verona', 43, to_date('19-05-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (192, '70-950-77', 'S-Class', 42, to_date('04-10-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (193, '42-315-41', 'Ram 3500', 41, to_date('19-02-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (194, '32-615-84', 'Bonneville', 33, to_date('29-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (195, '26-497-49', '1500 Club Coupe', 59, to_date('03-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (196, '88-595-98', 'Raider', 25, to_date('10-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (197, '74-856-45', 'Camry', 60, to_date('07-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (198, '72-239-31', 'Tacoma Xtra', 36, to_date('12-08-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (199, '68-602-30', '430 Scuderia', 51, to_date('28-06-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (200, '44-453-21', 'Landaulet', 43, to_date('02-03-2020', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (201, '87-430-26', 'Vibe', 59, to_date('10-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (202, '24-653-27', 'Mariner', 20, to_date('23-07-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (203, '54-866-66', 'CLK-Class', 49, to_date('20-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (204, '32-874-79', 'X-90', 60, to_date('02-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (205, '13-931-87', 'Grand Prix', 25, to_date('17-12-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (206, '53-947-25', 'Sequoia', 49, to_date('22-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (207, '58-889-57', 'Escalade', 27, to_date('01-03-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (208, '11-213-22', 'Express 3500', 42, to_date('28-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (209, '97-418-24', 'Jetta', 44, to_date('15-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (210, '67-254-45', 'E250', 34, to_date('21-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (211, '06-813-30', 'Elantra', 59, to_date('05-12-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (212, '65-605-92', 'Passat', 41, to_date('14-04-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (213, '57-755-53', 'Citation', 33, to_date('12-08-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (214, '55-684-82', 'Mazda6', 23, to_date('03-03-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (215, '11-969-47', 'Cougar', 24, to_date('09-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (216, '54-887-20', 'Mustang', 43, to_date('10-05-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (217, '16-747-68', 'Celica', 44, to_date('06-10-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (218, '43-544-60', 'Celica', 23, to_date('22-11-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (219, '84-857-61', 'Boxster', 22, to_date('02-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (220, '85-819-59', 'Sentra', 21, to_date('07-09-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (221, '97-462-20', 'E-Series', 29, to_date('05-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (222, '68-795-16', 'ES', 60, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (223, '98-416-37', 'Nubira', 38, to_date('18-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (224, '76-826-62', 'MKS', 60, to_date('30-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (225, '54-604-98', 'XJ Series', 28, to_date('13-11-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (226, '34-280-04', 'S-Class', 20, to_date('18-04-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (227, '38-243-20', 'F-Series', 31, to_date('02-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (228, '89-653-00', 'Hombre', 43, to_date('20-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (229, '73-400-55', 'Venture', 45, to_date('19-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (230, '98-257-54', 'CTS-V', 55, to_date('05-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (231, '61-223-96', 'Club Wagon', 49, to_date('01-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (232, '30-755-11', 'Xterra', 33, to_date('23-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (233, '87-496-56', 'Tacoma Xtra', 44, to_date('26-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (234, '91-874-44', 'Continental Super', 41, to_date('25-06-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (235, '78-069-11', 'Continental', 23, to_date('07-06-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (236, '11-190-71', '3500', 54, to_date('08-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (237, '27-926-89', 'Grand Caravan', 43, to_date('02-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (238, '41-789-93', '3500 Club Coupe', 43, to_date('21-08-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (239, '03-608-30', 'Caprice', 35, to_date('31-12-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (240, '34-500-04', 'S4', 39, to_date('01-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (241, '87-082-70', 'GTO', 23, to_date('01-08-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (242, '97-190-60', 'Edge', 37, to_date('04-10-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (243, '61-166-79', 'Explorer Sport', 28, to_date('09-06-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (244, '16-720-80', 'Cayman', 54, to_date('24-07-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (245, '13-708-30', 'I', 25, to_date('27-01-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (246, '06-558-17', 'Firefly', 50, to_date('25-12-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (247, '65-402-50', 'Grand Marquis', 60, to_date('17-07-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (248, '67-323-31', '7 Series', 29, to_date('05-12-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (249, '25-300-61', 'Silverado 1500', 21, to_date('20-12-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (250, '00-163-41', 'RX', 44, to_date('12-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (251, '48-958-29', 'MX-6', 38, to_date('07-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (252, '86-172-60', 'M', 29, to_date('05-01-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (253, '81-320-04', '240SX', 50, to_date('12-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (254, '83-215-34', 'Spectra', 43, to_date('22-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (255, '39-084-22', 'Sable', 41, to_date('18-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (256, '67-811-92', 'Aztek', 21, to_date('30-11-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (257, '98-506-02', 'Focus', 33, to_date('10-07-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (258, '22-110-36', 'TL', 56, to_date('04-08-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (259, '88-175-90', 'Challenger', 29, to_date('24-01-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (260, '93-989-21', 'Elan', 56, to_date('27-05-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (261, '82-354-80', 'Tredia', 55, to_date('08-01-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (262, '46-709-93', 'Arnage', 26, to_date('18-06-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (263, '29-487-96', 'Corvette', 22, to_date('01-11-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (264, '40-604-05', 'IS-F', 53, to_date('25-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (265, '59-961-54', '300ZX', 39, to_date('28-01-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (266, '72-305-94', 'Firefly', 48, to_date('24-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (267, '52-325-26', 'xB', 28, to_date('24-03-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (268, '36-340-53', 'Malibu', 22, to_date('12-05-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (269, '66-600-97', 'Sierra', 25, to_date('12-12-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (270, '71-491-94', 'Impreza', 57, to_date('31-08-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (271, '26-133-63', 'Regal', 50, to_date('26-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (272, '88-174-06', 'SRX', 30, to_date('29-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (273, '38-393-00', 'Discovery', 52, to_date('25-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (274, '44-325-66', 'Grand Prix', 33, to_date('20-09-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (275, '54-193-94', 'Express 2500', 37, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (276, '81-452-93', 'Ciera', 34, to_date('02-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (277, '88-125-28', 'Outback', 25, to_date('12-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (278, '91-763-71', 'Miata MX-5', 49, to_date('30-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (279, '89-742-71', 'CL-Class', 38, to_date('21-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (280, '27-550-10', 'Galant', 47, to_date('24-06-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (281, '90-036-91', 'Dakota Club', 30, to_date('28-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (282, '47-547-16', 'Celica', 36, to_date('27-10-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (283, '23-101-85', 'Endeavor', 47, to_date('28-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (284, '67-467-46', 'Aura', 54, to_date('13-10-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (285, '07-782-78', '911', 25, to_date('14-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (286, '15-501-20', '3500 Club Coupe', 46, to_date('22-03-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (287, '83-366-27', 'Savana 2500', 36, to_date('26-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (288, '95-189-64', 'Cougar', 23, to_date('24-10-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (289, '32-112-11', '928', 49, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (290, '50-021-62', 'Montana', 58, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (291, '97-569-18', 'Prius', 20, to_date('13-11-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (292, '62-927-60', 'Express 1500', 30, to_date('30-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (293, '55-475-74', 'A3', 30, to_date('18-10-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (294, '78-936-74', 'Econoline E150', 45, to_date('17-09-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (295, '08-412-22', '88', 59, to_date('28-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (296, '73-326-32', 'RX-7', 37, to_date('21-04-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (297, '20-727-21', 'Impreza', 43, to_date('15-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (298, '21-855-64', 'Excel', 35, to_date('12-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (299, '08-380-84', 'Quest', 36, to_date('13-12-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (300, '17-071-44', 'IS', 39, to_date('26-11-2021', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (301, '44-673-04', 'Intrepid', 37, to_date('15-04-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (302, '91-551-80', 'LS', 48, to_date('13-01-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (303, '16-078-79', 'Countryman', 56, to_date('22-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (304, '20-899-62', '1 Series', 33, to_date('09-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (305, '69-679-47', 'Escort', 25, to_date('12-01-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (306, '61-427-15', '9000', 20, to_date('01-02-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (307, '62-490-43', 'XR4Ti', 38, to_date('06-09-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (308, '84-429-12', 'Hemisfear', 42, to_date('05-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (309, '21-524-05', 'Ram Van 1500', 21, to_date('18-06-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (310, '68-626-72', 'Roadmaster', 43, to_date('09-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (311, '40-071-82', 'GT', 25, to_date('31-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (312, '66-853-95', 'Blazer', 53, to_date('13-10-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (313, '86-467-95', 'Liberty', 44, to_date('18-01-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (314, '31-678-77', 'Sienna', 34, to_date('20-08-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (315, '93-325-46', 'Caravan', 29, to_date('25-06-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (316, '19-332-03', 'Quest', 51, to_date('23-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (317, '78-249-36', 'V50', 47, to_date('13-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (318, '08-403-36', 'S-Type', 29, to_date('20-05-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (319, '19-675-06', 'EXP', 60, to_date('12-10-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (320, '50-877-81', 'XJ Series', 48, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (321, '98-596-17', 'F150', 29, to_date('19-12-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (322, '74-652-63', 'G35', 50, to_date('29-01-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (323, '38-355-76', 'Town & Country', 20, to_date('04-06-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (324, '78-976-44', 'TL', 36, to_date('04-03-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (325, '35-711-56', 'Grand Marquis', 30, to_date('11-01-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (326, '95-964-06', '1500', 57, to_date('20-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (327, '24-978-55', 'Forester', 38, to_date('01-08-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (328, '07-372-68', 'Parisienne', 27, to_date('15-04-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (329, '45-261-12', 'Bravada', 45, to_date('02-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (330, '56-601-50', 'A4', 38, to_date('22-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (331, '31-828-85', 'i-370', 20, to_date('04-08-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (332, '92-804-61', 'VUE', 20, to_date('18-05-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (333, '56-662-82', 'Crown Victoria', 34, to_date('19-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (334, '49-860-96', 'Highlander', 20, to_date('11-05-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (335, '00-712-12', '300', 59, to_date('28-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (336, '01-716-47', 'GTI', 50, to_date('17-02-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (337, '09-889-71', 'Avalanche', 39, to_date('15-07-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (338, '73-313-89', 'Countach', 47, to_date('02-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (339, '40-893-33', 'Voyager', 43, to_date('16-02-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (340, '10-894-55', 'V90', 20, to_date('25-08-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (341, '97-619-02', 'Freelander', 31, to_date('08-11-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (342, '02-033-62', 'Continental', 48, to_date('13-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (343, '05-656-65', 'Safari', 33, to_date('10-05-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (344, '75-883-97', 'F150', 27, to_date('16-01-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (345, '65-099-12', 'Protege', 27, to_date('27-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (346, '63-479-64', 'Tundra', 52, to_date('30-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (347, '58-910-99', 'Flex', 38, to_date('06-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (348, '88-845-71', 'Ranger', 34, to_date('17-08-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (349, '05-427-84', 'Grand Marquis', 20, to_date('06-07-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (350, '34-397-38', 'Countryman', 42, to_date('26-02-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (351, '37-409-84', 'Civic', 36, to_date('08-04-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (352, '96-702-09', 'Cavalier', 48, to_date('12-07-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (353, '90-252-88', 'Gran Sport', 44, to_date('29-04-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (354, '99-358-28', 'Z3', 42, to_date('29-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (355, '43-586-48', 'Ram Van 2500', 54, to_date('13-06-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (356, '73-641-55', 'Mentor', 21, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (357, '19-818-69', 'Sentra', 35, to_date('18-12-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (358, '59-703-16', 'Esprit', 28, to_date('22-01-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (359, '48-226-99', 'Freelander', 59, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (360, '84-440-01', 'Vitara', 38, to_date('26-07-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (361, '20-183-94', 'Safari', 28, to_date('10-02-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (362, '10-203-41', 'Th!nk', 48, to_date('20-01-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (363, '17-885-86', 'Miata MX-5', 25, to_date('24-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (364, '09-050-58', 'Firebird', 51, to_date('20-10-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (365, '80-776-70', 'Aries', 59, to_date('08-05-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (366, '75-516-46', 'Liberty', 35, to_date('17-09-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (367, '78-167-86', 'Corolla', 22, to_date('05-06-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (368, '89-119-81', 'Capri', 51, to_date('20-07-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (369, '72-942-28', 'Altima', 59, to_date('28-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (370, '43-511-31', 'XJ Series', 46, to_date('03-11-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (371, '59-615-12', 'Tempo', 25, to_date('18-01-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (372, '29-325-50', 'Explorer', 42, to_date('21-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (373, '38-619-02', 'M3', 21, to_date('22-11-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (374, '05-047-00', 'XK', 49, to_date('13-06-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (375, '13-400-12', 'Explorer Sport', 46, to_date('13-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (376, '75-346-47', 'A8', 56, to_date('30-09-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (377, '29-086-45', 'SX4', 58, to_date('30-05-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (378, '32-908-27', 'Dynasty', 22, to_date('20-03-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (379, '34-079-60', 'Taurus', 53, to_date('07-05-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (380, '28-252-76', 'Taurus', 38, to_date('22-10-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (381, '92-474-72', '7 Series', 31, to_date('19-11-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (382, '72-674-92', 'Express 1500', 44, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (383, '13-749-53', 'Prizm', 34, to_date('19-08-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (384, '37-729-73', '300M', 57, to_date('19-03-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (385, '74-529-34', 'Mustang', 41, to_date('08-07-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (386, '92-559-43', '350Z', 52, to_date('23-11-2023', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (387, '12-090-31', 'Town Car', 40, to_date('05-07-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (388, '32-886-07', 'Caravan', 50, to_date('27-03-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (389, '95-186-84', 'RX', 32, to_date('02-07-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (390, '76-680-73', 'Corsica', 49, to_date('12-08-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (391, '74-922-35', 'CTS', 44, to_date('29-09-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (392, '08-932-87', 'Silverado 1500', 21, to_date('22-06-2020', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (393, '60-251-45', 'RX-8', 53, to_date('02-03-2019', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (394, '11-762-21', 'V8 Vantage', 57, to_date('27-11-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (395, '19-971-89', 'Ram Van 2500', 57, to_date('09-07-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (396, '67-316-57', 'Highlander', 55, to_date('10-04-2022', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (397, '66-722-97', 'Swift', 42, to_date('29-09-2017', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (398, '59-009-60', 'Grand Caravan', 59, to_date('03-09-2018', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (399, '86-657-20', 'Lancer', 21, to_date('30-09-2021', 'dd-mm-yyyy'));
insert into BUS (busid, licenseplate, model, capacity, purchasedate)
values (400, '36-796-62', 'Impala', 55, to_date('24-10-2022', 'dd-mm-yyyy'));
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
values (83, 'Vidovik Raffeorty', '1849-1351-5515', to_date('29-10-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (84, 'Elliott Zylbermann', '5126-3555-7829', to_date('13-09-2018', 'dd-mm-yyyy'));
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
values (95, 'Teri Thornewell', '1050-3677-8509', to_date('08-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (96, 'Hamnet Goulstone', '8597-3788-3495', to_date('05-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (98, 'Deane Crisp', '2048-0439-7881', to_date('11-09-2018', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (99, 'Rosene Coppard', '6652-3257-0683', to_date('27-08-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (100, 'Dalt Wadmore', '3620-1447-0465', to_date('05-09-2021', 'dd-mm-yyyy'));
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
commit;
prompt 100 records committed...
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (108, 'Kaylyn Marchant', '0234-5079-2540', to_date('07-10-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (109, 'Alica Hawse', '3975-0294-7327', to_date('27-04-2022', 'dd-mm-yyyy'));
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
values (197, 'Waverly Joseph', '4338-5426-1563', to_date('23-09-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (198, 'Sheila Delatour', '5669-3433-8139', to_date('03-12-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (199, 'Farrah Bracknall', '0474-2332-3178', to_date('24-04-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (200, 'Robinia Blundon', '9984-0992-9395', to_date('28-02-2022', 'dd-mm-yyyy'));
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
commit;
prompt 200 records committed...
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
values (312, 'Tanner Beedham', '2673-2632-5100', to_date('15-10-2019', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
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
values (354, 'Brita Fitzpatrick', '6650-8826-6164', to_date('18-10-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (355, 'Brandyn Sammons', '1488-8893-3005', to_date('01-03-2023', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (356, 'Nancey Caddy', '5454-7276-0027', to_date('20-09-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (357, 'Lissi Eliot', '3868-8242-0961', to_date('27-12-2019', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (359, 'Isabella Thredder', '6705-3269-3042', to_date('30-04-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (360, 'Elwood Buntain', '3947-9305-0227', to_date('10-03-2023', 'dd-mm-yyyy'));
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
values (396, 'Evangeline Wallington', '5729-4639-0915', to_date('10-12-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (397, 'Marcille Nassy', '6791-0737-8909', to_date('17-09-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (398, 'Diahann Abdee', '4424-3229-2971', to_date('11-05-2021', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (399, 'Asher Assante', '0934-7100-6853', to_date('23-08-2020', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (400, 'Deloris Skentelbury', '4327-2118-3975', to_date('29-03-2022', 'dd-mm-yyyy'));
insert into DRIVER (driverid, fullname, licensenumber, hiredate)
values (450, 'Dekel Vaknin', '39-102-39', to_date('19-07-2020', 'dd-mm-yyyy'));
commit;
prompt 384 records loaded
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
values (1, 'Station Close', '31 Downey Ave');
insert into STATION (stationid, stationname, stationaddress)
values (2, 'Station Calle', '62 Hanks Drive');
insert into STATION (stationid, stationname, stationaddress)
values (3, 'Station Penn', '30 Spike Road');
insert into STATION (stationid, stationname, stationaddress)
values (4, 'Station May', '59 Barbara Road');
insert into STATION (stationid, stationname, stationaddress)
values (5, 'Station Wopat', '797 Mattea Street');
insert into STATION (stationid, stationname, stationaddress)
values (6, 'Station Gates', '35 Zwolle Street');
insert into STATION (stationid, stationname, stationaddress)
values (7, 'Station Patrick', '80 Diehl Street');
insert into STATION (stationid, stationname, stationaddress)
values (8, 'Station Dillon', '9 Chilton Street');
insert into STATION (stationid, stationname, stationaddress)
values (9, 'Station Cohn', '455 Oldenburg Street');
insert into STATION (stationid, stationname, stationaddress)
values (10, 'Station Spine', '51 Gertner Street');
insert into STATION (stationid, stationname, stationaddress)
values (11, 'Station Shawn', '34 Elle Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (12, 'Station Carnes', '85 Melba Drive');
insert into STATION (stationid, stationname, stationaddress)
values (13, 'Station Briscoe', '73rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (14, 'Station Johansen', '49 Diaz Road');
insert into STATION (stationid, stationname, stationaddress)
values (15, 'Station Wong', '7 Aurora');
insert into STATION (stationid, stationname, stationaddress)
values (16, 'Station Ryder', '66 Warren Street');
insert into STATION (stationid, stationname, stationaddress)
values (17, 'Station Mac', '70 O''Sullivan Ave');
insert into STATION (stationid, stationname, stationaddress)
values (18, 'Station Ellis', '72nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (19, 'Station Arthur', '2 Bad Oeynhausen Road');
insert into STATION (stationid, stationname, stationaddress)
values (20, 'Station Haynes', '75 Tracy');
insert into STATION (stationid, stationname, stationaddress)
values (21, 'Station Tillis', '23rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (22, 'Station Hornsby', '613 Koteas Road');
insert into STATION (stationid, stationname, stationaddress)
values (23, 'Station McKellen', '70 Tate Ave');
insert into STATION (stationid, stationname, stationaddress)
values (24, 'Station Gooding', '95 Tony Street');
insert into STATION (stationid, stationname, stationaddress)
values (25, 'Station Moffat', '538 Jared Road');
insert into STATION (stationid, stationname, stationaddress)
values (26, 'Station Slater', '43rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (27, 'Station Skerritt', '81st Street');
insert into STATION (stationid, stationname, stationaddress)
values (28, 'Station Kramer', '61st Street');
insert into STATION (stationid, stationname, stationaddress)
values (29, 'Station Nelligan', '67 Ben Street');
insert into STATION (stationid, stationname, stationaddress)
values (30, 'Station Goldwyn', '82 Marley Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (31, 'Station Hersh', '16 Burmester Street');
insert into STATION (stationid, stationname, stationaddress)
values (32, 'Station Patton', '54 Akron Drive');
insert into STATION (stationid, stationname, stationaddress)
values (33, 'Station Butler', '21st Street');
insert into STATION (stationid, stationname, stationaddress)
values (34, 'Station Tomlin', '92nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (35, 'Station Koyana', '6 Mariano Comense Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (36, 'Station McDiarmid', '429 Lemmon Street');
insert into STATION (stationid, stationname, stationaddress)
values (37, 'Station Humphrey', '98 Yogyakarta Ave');
insert into STATION (stationid, stationname, stationaddress)
values (38, 'Station Botti', '7 Goslar');
insert into STATION (stationid, stationname, stationaddress)
values (39, 'Station McNarland', '36 Spike Street');
insert into STATION (stationid, stationname, stationaddress)
values (40, 'Station Kretschmann', '747 Carlin Street');
insert into STATION (stationid, stationname, stationaddress)
values (41, 'Station Phillips', '30 Samrand Road');
insert into STATION (stationid, stationname, stationaddress)
values (42, 'Station Davidson', '86 Cedar Rapids Road');
insert into STATION (stationid, stationname, stationaddress)
values (43, 'Station Mac', '68 Liotta Street');
insert into STATION (stationid, stationname, stationaddress)
values (44, 'Station Sayer', '35 Gosdin Street');
insert into STATION (stationid, stationname, stationaddress)
values (45, 'Station Ruiz', '65 Baez Street');
insert into STATION (stationid, stationname, stationaddress)
values (46, 'Station Sample', '94 Carolyn Street');
insert into STATION (stationid, stationname, stationaddress)
values (47, 'Station Kelly', '920 Leinfelden-Echterdin Street');
insert into STATION (stationid, stationname, stationaddress)
values (48, 'Station Garcia', '78 Ebersberg Road');
insert into STATION (stationid, stationname, stationaddress)
values (49, 'Station Sevenfold', '641 New Delhi Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (50, 'Station Kristofferson', '169 Marlon Street');
insert into STATION (stationid, stationname, stationaddress)
values (51, 'Station Joli', '53rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (52, 'Station Berkeley', '37 Travers Drive');
insert into STATION (stationid, stationname, stationaddress)
values (53, 'Station Byrd', '18 LeVar Road');
insert into STATION (stationid, stationname, stationaddress)
values (54, 'Station Carlton', '82 Valencia Road');
insert into STATION (stationid, stationname, stationaddress)
values (55, 'Station McCain', '89 Scott Ave');
insert into STATION (stationid, stationname, stationaddress)
values (56, 'Station Peterson', '55 Hauser Road');
insert into STATION (stationid, stationname, stationaddress)
values (57, 'Station Pesci', '58 Reston Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (58, 'Station Gracie', '41 First Street');
insert into STATION (stationid, stationname, stationaddress)
values (59, 'Station Sheen', '16 Waite Drive');
insert into STATION (stationid, stationname, stationaddress)
values (60, 'Station McIntosh', '924 Kweller Street');
insert into STATION (stationid, stationname, stationaddress)
values (61, 'Station Wincott', '165 LaMond Street');
insert into STATION (stationid, stationname, stationaddress)
values (62, 'Station Wong', '16 Kungki Street');
insert into STATION (stationid, stationname, stationaddress)
values (63, 'Station Bradford', '61 Leimen Road');
insert into STATION (stationid, stationname, stationaddress)
values (64, 'Station Young', '252 Natalie Drive');
insert into STATION (stationid, stationname, stationaddress)
values (65, 'Station Burmester', '57 Griffith Drive');
insert into STATION (stationid, stationname, stationaddress)
values (66, 'Station Close', '68 Conners Road');
insert into STATION (stationid, stationname, stationaddress)
values (67, 'Station Linney', '74 Danes Ave');
insert into STATION (stationid, stationname, stationaddress)
values (68, 'Station Piven', '87 Danger Drive');
insert into STATION (stationid, stationname, stationaddress)
values (69, 'Station Watson', '2 Candy');
insert into STATION (stationid, stationname, stationaddress)
values (70, 'Station Gagnon', '75 Unger Street');
insert into STATION (stationid, stationname, stationaddress)
values (71, 'Station Stiles', '14 Jena Drive');
insert into STATION (stationid, stationname, stationaddress)
values (72, 'Station Cox', '61 Budapest Street');
insert into STATION (stationid, stationname, stationaddress)
values (73, 'Station Crimson', '73 Heston Street');
insert into STATION (stationid, stationname, stationaddress)
values (74, 'Station Hawke', '98 Biggs Drive');
insert into STATION (stationid, stationname, stationaddress)
values (75, 'Station Cetera', '37 Queen Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (76, 'Station Thorton', '70 Swoosie Road');
insert into STATION (stationid, stationname, stationaddress)
values (77, 'Station Cattrall', '99 Callow Road');
insert into STATION (stationid, stationname, stationaddress)
values (78, 'Station Sweet', '994 Northam Ave');
insert into STATION (stationid, stationname, stationaddress)
values (79, 'Station Duncan', '52 Loretta Road');
insert into STATION (stationid, stationname, stationaddress)
values (80, 'Station Rains', '25 Woods');
insert into STATION (stationid, stationname, stationaddress)
values (81, 'Station Gibson', '51st Street');
insert into STATION (stationid, stationname, stationaddress)
values (82, 'Station Austin', '63rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (83, 'Station De Almeida', '80 Mars Drive');
insert into STATION (stationid, stationname, stationaddress)
values (84, 'Station Roy Parnell', '63 Concordville');
insert into STATION (stationid, stationname, stationaddress)
values (85, 'Station Cagle', '85 Collie Drive');
insert into STATION (stationid, stationname, stationaddress)
values (86, 'Station Barry', '67 Itu Drive');
insert into STATION (stationid, stationname, stationaddress)
values (87, 'Station Idol', '462 Harnes Road');
insert into STATION (stationid, stationname, stationaddress)
values (88, 'Station Hall', '1000 Berkeley Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (89, 'Station Rockwell', '175 NeuchÃƒÂ¢tel Street');
insert into STATION (stationid, stationname, stationaddress)
values (90, 'Station Love', '46 Nagasaki Drive');
insert into STATION (stationid, stationname, stationaddress)
values (91, 'Station Stiles', '42 Benson Street');
insert into STATION (stationid, stationname, stationaddress)
values (92, 'Station Burrows', '86 Norm Street');
insert into STATION (stationid, stationname, stationaddress)
values (93, 'Station Coughlan', '73 Ricardo Road');
insert into STATION (stationid, stationname, stationaddress)
values (94, 'Station Sampson', '59 Alcobendas Street');
insert into STATION (stationid, stationname, stationaddress)
values (95, 'Station Robbins', '54 Utada Street');
insert into STATION (stationid, stationname, stationaddress)
values (96, 'Station Curry', '20 Gugino Road');
insert into STATION (stationid, stationname, stationaddress)
values (97, 'Station Elwes', '13rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (98, 'Station Cumming', '545 Julia Ave');
insert into STATION (stationid, stationname, stationaddress)
values (99, 'Station Forster', '37 Withers');
insert into STATION (stationid, stationname, stationaddress)
values (100, 'Station Carlton', '53rd Street');
commit;
prompt 100 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (101, 'Station Plowright', '72 Ponce Ave');
insert into STATION (stationid, stationname, stationaddress)
values (102, 'Station McFadden', '92 Steven Road');
insert into STATION (stationid, stationname, stationaddress)
values (103, 'Station Craven', '6 Bancroft Road');
insert into STATION (stationid, stationname, stationaddress)
values (104, 'Station Stevenson', '60 Wolf');
insert into STATION (stationid, stationname, stationaddress)
values (105, 'Station Diaz', '14 Capshaw Street');
insert into STATION (stationid, stationname, stationaddress)
values (106, 'Station Bragg', '62nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (107, 'Station Collie', '25 Cumming Street');
insert into STATION (stationid, stationname, stationaddress)
values (108, 'Station Rudd', '577 Maury Road');
insert into STATION (stationid, stationname, stationaddress)
values (109, 'Station Ward', '65 Coward Ave');
insert into STATION (stationid, stationname, stationaddress)
values (110, 'Station Thewlis', '60 Sirtis Street');
insert into STATION (stationid, stationname, stationaddress)
values (111, 'Station Gano', '40 Cornell Road');
insert into STATION (stationid, stationname, stationaddress)
values (112, 'Station Baldwin', '17 Sinise Street');
insert into STATION (stationid, stationname, stationaddress)
values (113, 'Station Serbedzija', '46 Oakland Road');
insert into STATION (stationid, stationname, stationaddress)
values (114, 'Station Frampton', '645 Staten Island Drive');
insert into STATION (stationid, stationname, stationaddress)
values (115, 'Station Cleese', '81st Street');
insert into STATION (stationid, stationname, stationaddress)
values (116, 'Station Downey', '833 Alexandria Ave');
insert into STATION (stationid, stationname, stationaddress)
values (117, 'Station Close', '4 Rascal Road');
insert into STATION (stationid, stationname, stationaddress)
values (118, 'Station McIntyre', '39 Allan');
insert into STATION (stationid, stationname, stationaddress)
values (119, 'Station Root', '6 Campbell Drive');
insert into STATION (stationid, stationname, stationaddress)
values (120, 'Station English', '859 Reubens Drive');
insert into STATION (stationid, stationname, stationaddress)
values (121, 'Station Shocked', '12nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (122, 'Station Ribisi', '16 Norton Drive');
insert into STATION (stationid, stationname, stationaddress)
values (123, 'Station D''Onofrio', '49 Cornell Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (124, 'Station Pressly', '91 Thorton Road');
insert into STATION (stationid, stationname, stationaddress)
values (125, 'Station Weisz', '9 Hatchet Drive');
insert into STATION (stationid, stationname, stationaddress)
values (126, 'Station Close', '53 Navarro Road');
insert into STATION (stationid, stationname, stationaddress)
values (127, 'Station Andrews', '76 Jane Drive');
insert into STATION (stationid, stationname, stationaddress)
values (128, 'Station Mitra', '743 Downie Road');
insert into STATION (stationid, stationname, stationaddress)
values (129, 'Station Cartlidge', '979 Forrest Road');
insert into STATION (stationid, stationname, stationaddress)
values (130, 'Station Abraham', '385 Jake');
insert into STATION (stationid, stationname, stationaddress)
values (131, 'Station Dalley', '64 Pam Ave');
insert into STATION (stationid, stationname, stationaddress)
values (132, 'Station Biehn', '60 Aykroyd Road');
insert into STATION (stationid, stationname, stationaddress)
values (133, 'Station Smurfit', '48 Olyphant');
insert into STATION (stationid, stationname, stationaddress)
values (134, 'Station Boorem', '850 Monk Street');
insert into STATION (stationid, stationname, stationaddress)
values (135, 'Station Humphrey', '30 Imperioli Street');
insert into STATION (stationid, stationname, stationaddress)
values (136, 'Station Wilkinson', '92 Reinhold');
insert into STATION (stationid, stationname, stationaddress)
values (137, 'Station Meniketti', '35 Buffalo Grove Street');
insert into STATION (stationid, stationname, stationaddress)
values (138, 'Station Mills', '15 Van Der Beek Road');
insert into STATION (stationid, stationname, stationaddress)
values (139, 'Station Arthur', '23 Irkutsk Street');
insert into STATION (stationid, stationname, stationaddress)
values (140, 'Station Dean', '91 Winona Road');
insert into STATION (stationid, stationname, stationaddress)
values (141, 'Station Lightfoot', '274 Lynskey Road');
insert into STATION (stationid, stationname, stationaddress)
values (142, 'Station Vaughan', '46 Ned Road');
insert into STATION (stationid, stationname, stationaddress)
values (143, 'Station Teng', '934 Harry Street');
insert into STATION (stationid, stationname, stationaddress)
values (144, 'Station McIntosh', '6 Warwick Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (145, 'Station Winans', '52nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (146, 'Station Cochran', '35 Padova Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (147, 'Station Cobbs', '36 Head Street');
insert into STATION (stationid, stationname, stationaddress)
values (148, 'Station Branagh', '11 Sona Street');
insert into STATION (stationid, stationname, stationaddress)
values (149, 'Station Bell', '19 Boston Road');
insert into STATION (stationid, stationname, stationaddress)
values (150, 'Station Hector', '42nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (151, 'Station Whitwam', '44 Utada Street');
insert into STATION (stationid, stationname, stationaddress)
values (152, 'Station Parsons', '21 Joanna Drive');
insert into STATION (stationid, stationname, stationaddress)
values (153, 'Station Roth', '59 Rosanna Road');
insert into STATION (stationid, stationname, stationaddress)
values (154, 'Station Whitford', '55 Bugnon Drive');
insert into STATION (stationid, stationname, stationaddress)
values (155, 'Station Parsons', '17 Liv Drive');
insert into STATION (stationid, stationname, stationaddress)
values (156, 'Station Pollak', '100 Venice Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (157, 'Station Hall', '83rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (158, 'Station Duschel', '75 O''Keefe Road');
insert into STATION (stationid, stationname, stationaddress)
values (159, 'Station Tisdale', '17 Narrows Street');
insert into STATION (stationid, stationname, stationaddress)
values (160, 'Station Hatfield', '82 Keeslar Drive');
insert into STATION (stationid, stationname, stationaddress)
values (161, 'Station Berkoff', '47 Gladys Road');
insert into STATION (stationid, stationname, stationaddress)
values (162, 'Station Ward', '79 Evett');
insert into STATION (stationid, stationname, stationaddress)
values (163, 'Station Stiers', '62 NeuchÃƒÂ¢tel Road');
insert into STATION (stationid, stationname, stationaddress)
values (164, 'Station Hughes', '23 Isaac Drive');
insert into STATION (stationid, stationname, stationaddress)
values (165, 'Station Lightfoot', '69 Garr Street');
insert into STATION (stationid, stationname, stationaddress)
values (166, 'Station Almond', '13rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (167, 'Station Bello', '40 Kloten Drive');
insert into STATION (stationid, stationname, stationaddress)
values (168, 'Station Cornell', '51 Lindsey Street');
insert into STATION (stationid, stationname, stationaddress)
values (169, 'Station Atkinson', '1 Liev Road');
insert into STATION (stationid, stationname, stationaddress)
values (170, 'Station Loveless', '38 Loretta Street');
insert into STATION (stationid, stationname, stationaddress)
values (171, 'Station Winter', '49 Minnie Ave');
insert into STATION (stationid, stationname, stationaddress)
values (172, 'Station Matarazzo', '67 Fraser Street');
insert into STATION (stationid, stationname, stationaddress)
values (173, 'Station Nunn', '46 Fredericia Drive');
insert into STATION (stationid, stationname, stationaddress)
values (174, 'Station Yorn', '92nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (175, 'Station Hutch', '728 Stampley Drive');
insert into STATION (stationid, stationname, stationaddress)
values (176, 'Station Allen', '18 Tlalpan Road');
insert into STATION (stationid, stationname, stationaddress)
values (177, 'Station Mirren', '941 University Street');
insert into STATION (stationid, stationname, stationaddress)
values (178, 'Station Cara', '2 Emmylou Street');
insert into STATION (stationid, stationname, stationaddress)
values (179, 'Station Byrd', '3 Spine Ave');
insert into STATION (stationid, stationname, stationaddress)
values (180, 'Station Clark', '94 Dukakis Street');
insert into STATION (stationid, stationname, stationaddress)
values (181, 'Station Yorn', '65 Lennix');
insert into STATION (stationid, stationname, stationaddress)
values (182, 'Station Mulroney', '21st Street');
insert into STATION (stationid, stationname, stationaddress)
values (183, 'Station McGregor', '731 DiCaprio Road');
insert into STATION (stationid, stationname, stationaddress)
values (184, 'Station Cetera', '15 Rodgers Road');
insert into STATION (stationid, stationname, stationaddress)
values (185, 'Station Uggams', '94 Flatts Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (186, 'Station Bryson', '41 Hamilton Ave');
insert into STATION (stationid, stationname, stationaddress)
values (187, 'Station Hart', '652 Stanley Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (188, 'Station Tomei', '249 Cuenca Street');
insert into STATION (stationid, stationname, stationaddress)
values (189, 'Station Travers', '35 Purefoy Drive');
insert into STATION (stationid, stationname, stationaddress)
values (190, 'Station Shand', '11 Kay Street');
insert into STATION (stationid, stationname, stationaddress)
values (191, 'Station Briscoe', '77 Ward Road');
insert into STATION (stationid, stationname, stationaddress)
values (192, 'Station Minogue', '104 King Road');
insert into STATION (stationid, stationname, stationaddress)
values (193, 'Station Diddley', '71 Lloyd Ave');
insert into STATION (stationid, stationname, stationaddress)
values (194, 'Station McKean', '34 Church Street');
insert into STATION (stationid, stationname, stationaddress)
values (195, 'Station Gayle', '610 Clinton Drive');
insert into STATION (stationid, stationname, stationaddress)
values (196, 'Station Burstyn', '22 Evanswood Street');
insert into STATION (stationid, stationname, stationaddress)
values (197, 'Station Kane', '373 Hidalgo Road');
insert into STATION (stationid, stationname, stationaddress)
values (198, 'Station Hingle', '67 Bolton Ave');
insert into STATION (stationid, stationname, stationaddress)
values (199, 'Station Secada', '50 Nash Drive');
insert into STATION (stationid, stationname, stationaddress)
values (200, 'Station Griggs', '83 Jeremy Street');
commit;
prompt 200 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (201, 'Station Gooding', '73 Lachey Street');
insert into STATION (stationid, stationname, stationaddress)
values (202, 'Station Meyer', '53rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (203, 'Station Dunn', '55 Diggs Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (204, 'Station Shaye', '18 Collins Road');
insert into STATION (stationid, stationname, stationaddress)
values (205, 'Station Mac', '13 Jackie Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (206, 'Station Kier', '62 Brooke Street');
insert into STATION (stationid, stationname, stationaddress)
values (207, 'Station Dysart', '60 Duschel Street');
insert into STATION (stationid, stationname, stationaddress)
values (208, 'Station Mahoney', '71 Colin Young Ave');
insert into STATION (stationid, stationname, stationaddress)
values (209, 'Station Vai', '94 Moffat Street');
insert into STATION (stationid, stationname, stationaddress)
values (210, 'Station Costa', '33 Harmon Road');
insert into STATION (stationid, stationname, stationaddress)
values (211, 'Station Moriarty', '89 Kuopio Drive');
insert into STATION (stationid, stationname, stationaddress)
values (212, 'Station Porter', '39 Xander Road');
insert into STATION (stationid, stationname, stationaddress)
values (213, 'Station Craddock', '98 Los Alamos Street');
insert into STATION (stationid, stationname, stationaddress)
values (214, 'Station Frampton', '41 Jack Drive');
insert into STATION (stationid, stationname, stationaddress)
values (215, 'Station Arkin', '4 Toni Ave');
insert into STATION (stationid, stationname, stationaddress)
values (216, 'Station Yorn', '20 Hirsch Street');
insert into STATION (stationid, stationname, stationaddress)
values (217, 'Station Driver', '552 Close Road');
insert into STATION (stationid, stationname, stationaddress)
values (218, 'Station Weston', '37 Pierce Street');
insert into STATION (stationid, stationname, stationaddress)
values (219, 'Station Furtado', '19 Sewell Road');
insert into STATION (stationid, stationname, stationaddress)
values (220, 'Station Robinson', '944 Glasgow Road');
insert into STATION (stationid, stationname, stationaddress)
values (221, 'Station Ponty', '91 Greene');
insert into STATION (stationid, stationname, stationaddress)
values (222, 'Station DeGraw', '60 Tanya Drive');
insert into STATION (stationid, stationname, stationaddress)
values (223, 'Station Jamal', '98 Minnie Street');
insert into STATION (stationid, stationname, stationaddress)
values (224, 'Station Carrack', '64 Crouse Street');
insert into STATION (stationid, stationname, stationaddress)
values (225, 'Station Dayne', '12 Valencia Street');
insert into STATION (stationid, stationname, stationaddress)
values (226, 'Station Seagal', '52 Milwaukee Street');
insert into STATION (stationid, stationname, stationaddress)
values (227, 'Station Cagle', '3 Fukuoka Drive');
insert into STATION (stationid, stationname, stationaddress)
values (228, 'Station Gill', '23rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (229, 'Station Quatro', '100 Hank Ave');
insert into STATION (stationid, stationname, stationaddress)
values (230, 'Station Steagall', '52nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (231, 'Station Wright', '33 Campana Road');
insert into STATION (stationid, stationname, stationaddress)
values (232, 'Station Rhys-Davies', '79 Osborne Ave');
insert into STATION (stationid, stationname, stationaddress)
values (233, 'Station Close', '51 McGregor');
insert into STATION (stationid, stationname, stationaddress)
values (234, 'Station Barrymore', '33 Hughes Street');
insert into STATION (stationid, stationname, stationaddress)
values (235, 'Station Johansen', '35 Haynes Street');
insert into STATION (stationid, stationname, stationaddress)
values (236, 'Station Jonze', '16 Mantova');
insert into STATION (stationid, stationname, stationaddress)
values (237, 'Station Jackson', '60 Kuraby Ave');
insert into STATION (stationid, stationname, stationaddress)
values (238, 'Station LuPone', '32 Quinones Road');
insert into STATION (stationid, stationname, stationaddress)
values (239, 'Station Faithfull', '225 Marley Street');
insert into STATION (stationid, stationname, stationaddress)
values (240, 'Station Branagh', '20 Pecs Road');
insert into STATION (stationid, stationname, stationaddress)
values (241, 'Station Rucker', '38 Woods Street');
insert into STATION (stationid, stationname, stationaddress)
values (242, 'Station Diggs', '24 El Paso Street');
insert into STATION (stationid, stationname, stationaddress)
values (243, 'Station Osment', '7 Reilly Street');
insert into STATION (stationid, stationname, stationaddress)
values (244, 'Station Weaving', '169 Santorso Drive');
insert into STATION (stationid, stationname, stationaddress)
values (245, 'Station Brandt', '22nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (246, 'Station Neill', '175 Horizon Road');
insert into STATION (stationid, stationname, stationaddress)
values (247, 'Station Romijn-Stamos', '87 Yaphet Drive');
insert into STATION (stationid, stationname, stationaddress)
values (248, 'Station Gallagher', '47 Kasey Road');
insert into STATION (stationid, stationname, stationaddress)
values (249, 'Station Bonneville', '28 Chapman Street');
insert into STATION (stationid, stationname, stationaddress)
values (250, 'Station Benson', '21st Street');
insert into STATION (stationid, stationname, stationaddress)
values (251, 'Station McDowall', '40 Horsham Drive');
insert into STATION (stationid, stationname, stationaddress)
values (252, 'Station Aniston', '16 Novara Road');
insert into STATION (stationid, stationname, stationaddress)
values (253, 'Station Orlando', '92nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (254, 'Station Mewes', '94 Omaha Drive');
insert into STATION (stationid, stationname, stationaddress)
values (255, 'Station Rodgers', '59 Marty Street');
insert into STATION (stationid, stationname, stationaddress)
values (256, 'Station Hatosy', '44 Giovanni Ave');
insert into STATION (stationid, stationname, stationaddress)
values (257, 'Station Skerritt', '34 Epps Road');
insert into STATION (stationid, stationname, stationaddress)
values (258, 'Station Reynolds', '53 Curtis Drive');
insert into STATION (stationid, stationname, stationaddress)
values (259, 'Station Roy Parnell', '31 Garland Drive');
insert into STATION (stationid, stationname, stationaddress)
values (260, 'Station Calle', '76 KÃƒÂ¸benhavn Street');
insert into STATION (stationid, stationname, stationaddress)
values (261, 'Station McCracken', '181 Kravitz Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (262, 'Station Todd', '61 Warren Drive');
insert into STATION (stationid, stationname, stationaddress)
values (263, 'Station Eckhart', '94 Coley Ave');
insert into STATION (stationid, stationname, stationaddress)
values (264, 'Station Humphrey', '68 Coppell Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (265, 'Station Rush', '100 Sheena Street');
insert into STATION (stationid, stationname, stationaddress)
values (266, 'Station Bugnon', '720 Apple Drive');
insert into STATION (stationid, stationname, stationaddress)
values (267, 'Station Palmieri', '12 Tottori Drive');
insert into STATION (stationid, stationname, stationaddress)
values (268, 'Station Valentin', '73 Rickman Road');
insert into STATION (stationid, stationname, stationaddress)
values (269, 'Station King', '4 Jolie Street');
insert into STATION (stationid, stationname, stationaddress)
values (270, 'Station Franks', '97 Thornton Street');
insert into STATION (stationid, stationname, stationaddress)
values (271, 'Station Hannah', '28 CeCe Drive');
insert into STATION (stationid, stationname, stationaddress)
values (272, 'Station Carrack', '14 Maury Street');
insert into STATION (stationid, stationname, stationaddress)
values (273, 'Station Irving', '58 Hawn Street');
insert into STATION (stationid, stationname, stationaddress)
values (274, 'Station Liotta', '37 Colin Road');
insert into STATION (stationid, stationname, stationaddress)
values (275, 'Station Hirsch', '33 MacIsaac Drive');
insert into STATION (stationid, stationname, stationaddress)
values (276, 'Station Charles', '646 Fraser Street');
insert into STATION (stationid, stationname, stationaddress)
values (277, 'Station Travers', '75 Curtis-Hall Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (278, 'Station Sutherland', '12 Olympia Drive');
insert into STATION (stationid, stationname, stationaddress)
values (279, 'Station Llewelyn', '83 Oshawa');
insert into STATION (stationid, stationname, stationaddress)
values (280, 'Station Mortensen', '35 Kennedy Ave');
insert into STATION (stationid, stationname, stationaddress)
values (281, 'Station Anderson', '75 Hersh Drive');
insert into STATION (stationid, stationname, stationaddress)
values (282, 'Station Danes', '81 Kiefer Road');
insert into STATION (stationid, stationname, stationaddress)
values (283, 'Station Willis', '40 Key Biscayne Drive');
insert into STATION (stationid, stationname, stationaddress)
values (284, 'Station Weaver', '52nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (285, 'Station Hong', '729 Davey');
insert into STATION (stationid, stationname, stationaddress)
values (286, 'Station Pollak', '77 Garcia Road');
insert into STATION (stationid, stationname, stationaddress)
values (287, 'Station O''Connor', '71 Austin Drive');
insert into STATION (stationid, stationname, stationaddress)
values (288, 'Station Cusack', '31st Street');
insert into STATION (stationid, stationname, stationaddress)
values (289, 'Station Noseworthy', '87 Jonze Drive');
insert into STATION (stationid, stationname, stationaddress)
values (290, 'Station Boone', '43rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (291, 'Station Trevino', '64 Dalmine');
insert into STATION (stationid, stationname, stationaddress)
values (292, 'Station Logue', '12nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (293, 'Station Carlisle', '97 Lawrence Road');
insert into STATION (stationid, stationname, stationaddress)
values (294, 'Station Davidtz', '291 Todd Street');
insert into STATION (stationid, stationname, stationaddress)
values (295, 'Station Cage', '22nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (296, 'Station Sanders', '80 Bonham Drive');
insert into STATION (stationid, stationname, stationaddress)
values (297, 'Station Gunton', '13 Clarkson Road');
insert into STATION (stationid, stationname, stationaddress)
values (298, 'Station Carlyle', '91 Guadalajara Road');
insert into STATION (stationid, stationname, stationaddress)
values (299, 'Station Cale', '89 Wendy Ave');
insert into STATION (stationid, stationname, stationaddress)
values (300, 'Station Eldard', '6 Moss Blvd');
commit;
prompt 300 records committed...
insert into STATION (stationid, stationname, stationaddress)
values (301, 'Station Hawkins', '57 Platt Ave');
insert into STATION (stationid, stationname, stationaddress)
values (302, 'Station Craig', '52nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (303, 'Station Chaykin', '569 Wen Road');
insert into STATION (stationid, stationname, stationaddress)
values (304, 'Station Zappacosta', '33 Cary Road');
insert into STATION (stationid, stationname, stationaddress)
values (305, 'Station McKennitt', '92 Bautzen Road');
insert into STATION (stationid, stationname, stationaddress)
values (306, 'Station Henriksen', '87 Schiff Road');
insert into STATION (stationid, stationname, stationaddress)
values (307, 'Station Curry', '17 Madonna Road');
insert into STATION (stationid, stationname, stationaddress)
values (308, 'Station Ness', '22nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (309, 'Station Lennox', '85 Morgan Road');
insert into STATION (stationid, stationname, stationaddress)
values (310, 'Station Bugnon', '83 Hilary Street');
insert into STATION (stationid, stationname, stationaddress)
values (311, 'Station Berkeley', '72 Kweller Road');
insert into STATION (stationid, stationname, stationaddress)
values (312, 'Station Emmett', '74 Feore Street');
insert into STATION (stationid, stationname, stationaddress)
values (313, 'Station Masur', '89 Maxine Street');
insert into STATION (stationid, stationname, stationaddress)
values (314, 'Station Elizabeth', '23 Rocklin Street');
insert into STATION (stationid, stationname, stationaddress)
values (315, 'Station Bergen', '100 Knight Street');
insert into STATION (stationid, stationname, stationaddress)
values (316, 'Station Bates', '60 Myers Road');
insert into STATION (stationid, stationname, stationaddress)
values (317, 'Station Finn', '94 Tisdale Street');
insert into STATION (stationid, stationname, stationaddress)
values (318, 'Station Ramis', '30 King Drive');
insert into STATION (stationid, stationname, stationaddress)
values (319, 'Station Stuermer', '55 Doncaster Street');
insert into STATION (stationid, stationname, stationaddress)
values (320, 'Station Bugnon', '23 Singletary Street');
insert into STATION (stationid, stationname, stationaddress)
values (321, 'Station Raitt', '853 Utada Drive');
insert into STATION (stationid, stationname, stationaddress)
values (322, 'Station Margulies', '57 Mohr Drive');
insert into STATION (stationid, stationname, stationaddress)
values (323, 'Station Forster', '92nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (324, 'Station Galecki', '55 Vonda Road');
insert into STATION (stationid, stationname, stationaddress)
values (325, 'Station Napolitano', '92nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (326, 'Station Briscoe', '17 Nelson Drive');
insert into STATION (stationid, stationname, stationaddress)
values (327, 'Station Gold', '8 Stuermer Street');
insert into STATION (stationid, stationname, stationaddress)
values (328, 'Station Alston', '41 Carrington Street');
insert into STATION (stationid, stationname, stationaddress)
values (329, 'Station Rippy', '11 Thompson Street');
insert into STATION (stationid, stationname, stationaddress)
values (330, 'Station Buscemi', '65 Salonga Street');
insert into STATION (stationid, stationname, stationaddress)
values (331, 'Station Chesnutt', '23rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (332, 'Station Ripley', '83 Kelli Road');
insert into STATION (stationid, stationname, stationaddress)
values (333, 'Station Bening', '42 Saxon Ave');
insert into STATION (stationid, stationname, stationaddress)
values (334, 'Station D''Onofrio', '6 Irati Street');
insert into STATION (stationid, stationname, stationaddress)
values (335, 'Station Knight', '32 Quatro Road');
insert into STATION (stationid, stationname, stationaddress)
values (336, 'Station Vannelli', '741 Ramirez Street');
insert into STATION (stationid, stationname, stationaddress)
values (337, 'Station Hingle', '24 Estevez Road');
insert into STATION (stationid, stationname, stationaddress)
values (338, 'Station Feliciano', '90 MacPherson Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (339, 'Station Jonze', '40 Rimini Street');
insert into STATION (stationid, stationname, stationaddress)
values (340, 'Station Sarsgaard', '325 Redding Road');
insert into STATION (stationid, stationname, stationaddress)
values (341, 'Station Badalucco', '16 Hounslow Street');
insert into STATION (stationid, stationname, stationaddress)
values (342, 'Station English', '26 Logue Street');
insert into STATION (stationid, stationname, stationaddress)
values (343, 'Station Barnett', '63 Braugher Drive');
insert into STATION (stationid, stationname, stationaddress)
values (344, 'Station Phillippe', '45 Morton Road');
insert into STATION (stationid, stationname, stationaddress)
values (345, 'Station Quaid', '52nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (346, 'Station Coe', '80 Stowe');
insert into STATION (stationid, stationname, stationaddress)
values (347, 'Station Collins', '71 Witt Street');
insert into STATION (stationid, stationname, stationaddress)
values (348, 'Station Travolta', '91 Dean Street');
insert into STATION (stationid, stationname, stationaddress)
values (349, 'Station Myles', '42nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (350, 'Station Lang', '26 Torino Street');
insert into STATION (stationid, stationname, stationaddress)
values (351, 'Station Logue', '853 Pasadena Drive');
insert into STATION (stationid, stationname, stationaddress)
values (352, 'Station Theron', '39 Rachael Road');
insert into STATION (stationid, stationname, stationaddress)
values (353, 'Station Harris', '52 Keeslar Drive');
insert into STATION (stationid, stationname, stationaddress)
values (354, 'Station Rhymes', '207 Gatlin Street');
insert into STATION (stationid, stationname, stationaddress)
values (355, 'Station Chapman', '31 Tucker Road');
insert into STATION (stationid, stationname, stationaddress)
values (356, 'Station Bassett', '7 Price Ave');
insert into STATION (stationid, stationname, stationaddress)
values (357, 'Station Lauper', '3 Palmieri Street');
insert into STATION (stationid, stationname, stationaddress)
values (358, 'Station Jones', '88 Uma Street');
insert into STATION (stationid, stationname, stationaddress)
values (359, 'Station Bentley', '19 Derringer Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (360, 'Station Danger', '21st Street');
insert into STATION (stationid, stationname, stationaddress)
values (361, 'Station Keaton', '26 Wilmington Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (362, 'Station Dunn', '109 Frost Street');
insert into STATION (stationid, stationname, stationaddress)
values (363, 'Station Plummer', '137 Groton');
insert into STATION (stationid, stationname, stationaddress)
values (364, 'Station Giraldo', '84 Rebecca Road');
insert into STATION (stationid, stationname, stationaddress)
values (365, 'Station Farrow', '96 McBride Street');
insert into STATION (stationid, stationname, stationaddress)
values (366, 'Station Coverdale', '55 Petach-Tikva Drive');
insert into STATION (stationid, stationname, stationaddress)
values (367, 'Station James', '91 Spears Road');
insert into STATION (stationid, stationname, stationaddress)
values (368, 'Station Bean', '93 Perry Road');
insert into STATION (stationid, stationname, stationaddress)
values (369, 'Station Badalucco', '201 Makeba Street');
insert into STATION (stationid, stationname, stationaddress)
values (370, 'Station Hawthorne', '808 McConaughey');
insert into STATION (stationid, stationname, stationaddress)
values (371, 'Station Chandler', '786 Broadbent Street');
insert into STATION (stationid, stationname, stationaddress)
values (372, 'Station Carrack', '40 Nordhausen Drive');
insert into STATION (stationid, stationname, stationaddress)
values (373, 'Station Faithfull', '10 Paula Drive');
insert into STATION (stationid, stationname, stationaddress)
values (374, 'Station Sampson', '22 Lucas Drive');
insert into STATION (stationid, stationname, stationaddress)
values (375, 'Station Hopkins', '37 Liquid Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (376, 'Station Driver', '13 McCracken Street');
insert into STATION (stationid, stationname, stationaddress)
values (377, 'Station Coburn', '52 Loveless Drive');
insert into STATION (stationid, stationname, stationaddress)
values (378, 'Station Union', '16 Kungens kurva Street');
insert into STATION (stationid, stationname, stationaddress)
values (379, 'Station Price', '52nd Street');
insert into STATION (stationid, stationname, stationaddress)
values (380, 'Station Baez', '13rd Street');
insert into STATION (stationid, stationname, stationaddress)
values (381, 'Station Cage', '68 Tia Street');
insert into STATION (stationid, stationname, stationaddress)
values (382, 'Station O''Donnell', '36 Lynne Street');
insert into STATION (stationid, stationname, stationaddress)
values (383, 'Station Rhys-Davies', '48 Bielefeld');
insert into STATION (stationid, stationname, stationaddress)
values (384, 'Station Parish', '95 Candice Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (385, 'Station Singh', '93 Mapo-gu Road');
insert into STATION (stationid, stationname, stationaddress)
values (386, 'Station Hershey', '66 Gladys');
insert into STATION (stationid, stationname, stationaddress)
values (387, 'Station Bush', '91 Candy');
insert into STATION (stationid, stationname, stationaddress)
values (388, 'Station Hawthorne', '89 Crouse Road');
insert into STATION (stationid, stationname, stationaddress)
values (389, 'Station Capshaw', '83 Kongserbg');
insert into STATION (stationid, stationname, stationaddress)
values (390, 'Station Feliciano', '73 Ft. Leavenworth Street');
insert into STATION (stationid, stationname, stationaddress)
values (391, 'Station Carnes', '7 Roanoke Road');
insert into STATION (stationid, stationname, stationaddress)
values (392, 'Station Mould', '58 Aidan Drive');
insert into STATION (stationid, stationname, stationaddress)
values (393, 'Station Wagner', '86 Charlize Street');
insert into STATION (stationid, stationname, stationaddress)
values (394, 'Station Beatty', '10 Kurt Road');
insert into STATION (stationid, stationname, stationaddress)
values (395, 'Station Pleasence', '33 Seattle Road');
insert into STATION (stationid, stationname, stationaddress)
values (396, 'Station Crowell', '778 Bollensen Street');
insert into STATION (stationid, stationname, stationaddress)
values (397, 'Station Avital', '100 Leigh Blvd');
insert into STATION (stationid, stationname, stationaddress)
values (398, 'Station Conley', '82 Ernie Ave');
insert into STATION (stationid, stationname, stationaddress)
values (399, 'Station Mathis', '39 Warszawa Road');
insert into STATION (stationid, stationname, stationaddress)
values (400, 'Station Schiff', '64 Jesse Drive');
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
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (183, 88, 49, '22:23:23', '14:54:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (351, 356, 143, '12:19:43', '9:07:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (381, 110, 164, '11:08:08', '17:21:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (128, 237, 349, '10:27:33', '14:44:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (245, 337, 90, '13:33:20', '9:39:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (159, 197, 351, '1:18:47', '5:47:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (102, 193, 375, '2:53:10', '1:44:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (15, 8, 16, '6:14:23', '2:51:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (314, 290, 170, '2:15:30', '12:04:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (166, 257, 299, '8:28:34', '10:10:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (149, 238, 265, '21:15:05', '12:30:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (144, 319, 325, '6:23:31', '5:15:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (26, 1, 290, '8:33:18', '15:47:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (287, 382, 325, '6:56:52', '16:12:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (9, 142, 3, '21:09:53', '3:58:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (313, 195, 124, '14:07:35', '19:26:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (366, 113, 249, '6:16:41', '16:08:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (34, 349, 140, '13:46:26', '11:40:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (269, 80, 327, '4:34:39', '17:40:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (327, 165, 78, '15:01:05', '10:17:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (318, 283, 81, '6:51:47', '7:03:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (298, 169, 73, '11:34:54', '19:44:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (42, 287, 136, '5:38:25', '11:15:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (121, 55, 346, '7:02:27', '10:45:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (5, 61, 73, '6:44:05', '12:42:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (400, 215, 43, '17:09:47', '10:53:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (324, 89, 163, '18:52:18', '7:57:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (78, 327, 15, '8:43:34', '20:13:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (369, 364, 229, '14:09:02', '21:22:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (277, 327, 72, '21:49:02', '14:19:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (254, 98, 183, '12:07:48', '0:57:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (397, 25, 188, '17:55:37', '5:54:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (42, 175, 270, '7:11:51', '1:21:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (299, 121, 239, '9:57:01', '8:40:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (169, 54, 220, '21:07:03', '14:04:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (284, 269, 64, '13:48:23', '19:26:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (224, 20, 152, '8:34:09', '21:54:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (379, 387, 263, '19:12:48', '10:57:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (375, 347, 159, '10:27:29', '3:46:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (158, 125, 175, '1:27:45', '6:56:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (185, 12, 6, '2:32:02', '2:32:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (356, 126, 16, '11:21:34', '11:50:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (354, 195, 281, '20:43:27', '12:57:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (346, 378, 264, '2:40:34', '11:03:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (378, 343, 222, '23:08:06', '7:12:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (189, 271, 106, '7:15:11', '1:07:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (30, 277, 321, '23:25:47', '13:22:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (305, 350, 162, '14:42:57', '6:22:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (367, 175, 365, '20:10:01', '17:35:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (61, 17, 282, '20:53:10', '17:31:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (181, 153, 217, '11:28:02', '18:36:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (75, 235, 182, '9:48:55', '6:03:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (347, 190, 190, '7:04:33', '2:39:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (378, 175, 70, '19:58:48', '14:29:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (323, 11, 102, '16:12:05', '14:05:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (210, 123, 334, '21:12:14', '1:10:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (333, 64, 304, '8:58:22', '23:18:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (293, 276, 169, '22:31:04', '12:12:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (381, 374, 45, '1:08:21', '1:51:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (250, 375, 203, '20:20:36', '17:50:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (141, 322, 250, '0:42:53', '12:59:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (179, 311, 139, '2:43:06', '16:58:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (194, 147, 141, '20:31:24', '0:30:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (4, 178, 102, '15:55:43', '13:01:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (133, 260, 135, '9:37:51', '23:49:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (30, 376, 268, '17:52:39', '11:18:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (146, 123, 238, '2:01:39', '15:01:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (256, 24, 30, '11:58:25', '8:47:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (186, 360, 264, '21:22:15', '19:00:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (290, 339, 342, '8:48:01', '20:59:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (267, 82, 230, '22:51:49', '5:44:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (137, 363, 299, '10:15:08', '21:22:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (326, 200, 148, '23:16:48', '14:37:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (246, 266, 162, '15:12:42', '14:25:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (255, 275, 389, '11:01:23', '7:25:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (232, 227, 238, '16:07:41', '6:30:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (226, 46, 42, '4:42:56', '1:29:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (135, 364, 169, '10:24:54', '18:29:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (123, 314, 36, '19:22:17', '16:26:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (218, 258, 15, '10:31:23', '1:57:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (221, 335, 149, '22:20:32', '17:35:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (192, 162, 179, '15:51:37', '2:41:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (257, 336, 260, '7:36:02', '1:20:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (53, 102, 302, '2:38:24', '0:23:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (73, 36, 120, '22:33:48', '23:20:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (273, 310, 14, '12:46:54', '7:25:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (310, 98, 44, '5:19:24', '11:05:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (28, 278, 281, '7:42:02', '7:16:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (230, 130, 393, '0:15:17', '1:38:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (312, 200, 291, '16:17:31', '11:28:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (122, 359, 317, '0:01:37', '8:36:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (289, 234, 64, '21:59:27', '20:55:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (182, 236, 63, '20:11:52', '12:56:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (157, 290, 90, '10:40:53', '17:08:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (182, 297, 216, '9:47:04', '21:55:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (33, 184, 209, '20:49:10', '19:49:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (239, 361, 84, '21:59:06', '12:29:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (73, 272, 32, '15:45:46', '19:47:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (264, 394, 35, '21:27:32', '22:33:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (225, 307, 179, '1:11:20', '8:20:24', null);
commit;
prompt 100 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (126, 128, 176, '2:17:55', '11:47:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (289, 184, 328, '23:05:38', '21:51:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (256, 43, 136, '11:04:04', '2:51:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (94, 143, 288, '7:38:19', '23:44:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (25, 379, 79, '10:21:09', '3:59:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (110, 69, 22, '20:38:56', '1:42:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (66, 354, 33, '4:44:52', '22:25:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (18, 94, 354, '10:17:24', '13:12:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (353, 176, 11, '22:45:58', '12:58:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (354, 309, 234, '20:29:15', '16:50:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (277, 369, 256, '10:29:19', '15:03:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (380, 264, 4, '2:32:10', '15:27:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (154, 68, 134, '5:07:21', '10:07:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (119, 30, 148, '13:47:45', '6:11:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (141, 396, 204, '12:54:56', '11:16:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (330, 391, 136, '7:04:45', '17:01:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (32, 235, 355, '15:16:32', '5:03:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (69, 83, 171, '3:17:26', '2:07:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (299, 355, 298, '0:48:46', '8:17:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (332, 365, 391, '5:00:09', '3:52:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (117, 393, 55, '9:00:24', '22:37:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (298, 300, 29, '22:41:05', '2:03:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 359, 100, '4:31:44', '16:28:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (156, 56, 5, '16:03:28', '13:28:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (285, 271, 90, '18:32:04', '9:16:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (390, 373, 20, '11:50:30', '12:32:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (92, 297, 242, '2:11:52', '5:27:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (190, 270, 106, '0:17:43', '0:14:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (381, 70, 229, '16:49:30', '2:19:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (380, 322, 183, '13:54:24', '4:23:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (265, 233, 75, '14:15:28', '0:48:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (84, 312, 363, '6:24:32', '19:01:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (328, 202, 180, '22:10:04', '0:49:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (82, 7, 344, '3:39:15', '17:23:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (313, 384, 146, '2:47:50', '23:32:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (315, 51, 20, '21:25:40', '20:51:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (3, 390, 309, '17:21:05', '18:57:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (168, 134, 346, '13:25:00', '9:18:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (353, 172, 336, '0:49:58', '21:51:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (320, 263, 150, '6:14:22', '23:12:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (91, 104, 89, '0:50:57', '23:23:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (211, 4, 179, '0:14:59', '16:35:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (79, 326, 222, '4:43:42', '10:31:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (369, 370, 270, '3:05:12', '12:20:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (273, 110, 147, '8:33:04', '14:04:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (319, 96, 303, '19:17:00', '15:09:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (310, 127, 380, '10:17:01', '15:10:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (354, 204, 29, '0:45:20', '7:41:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (247, 190, 333, '16:41:33', '9:16:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (47, 312, 10, '14:28:31', '1:54:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (308, 239, 263, '17:07:30', '9:21:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (261, 52, 107, '23:23:44', '21:48:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (247, 227, 305, '5:46:53', '21:40:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (385, 260, 139, '11:05:21', '14:27:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (220, 174, 173, '21:10:51', '21:20:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (5, 348, 120, '5:08:17', '19:58:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (33, 144, 83, '16:21:00', '13:33:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (338, 145, 45, '18:09:04', '19:49:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (181, 397, 16, '5:13:10', '19:33:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (187, 223, 386, '19:34:11', '23:16:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (23, 145, 131, '6:08:25', '1:14:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (272, 23, 112, '15:02:21', '11:17:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (294, 12, 1, '20:49:38', '23:52:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (400, 214, 27, '18:54:40', '21:05:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (395, 32, 390, '23:04:56', '16:38:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (157, 70, 399, '6:14:09', '3:29:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (24, 197, 295, '21:20:42', '13:40:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (241, 183, 77, '7:12:31', '9:33:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (284, 142, 374, '23:39:47', '8:03:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (351, 203, 127, '11:34:49', '17:13:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (162, 187, 131, '21:47:18', '11:15:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (7, 204, 241, '3:35:52', '2:29:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (33, 203, 354, '22:40:41', '20:31:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (28, 137, 22, '21:49:44', '14:48:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (94, 287, 131, '1:44:12', '21:58:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (123, 270, 332, '5:57:31', '6:10:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (313, 334, 277, '19:23:49', '14:58:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (39, 30, 340, '2:12:43', '19:37:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (188, 241, 357, '8:45:22', '11:51:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (12, 163, 128, '8:53:46', '1:37:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (385, 365, 179, '9:52:21', '8:12:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (218, 348, 268, '6:02:43', '15:21:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (1, 197, 283, '23:03:18', '23:31:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (114, 275, 103, '0:53:50', '4:00:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (168, 400, 321, '7:05:22', '23:46:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (124, 380, 320, '2:07:50', '14:54:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (117, 61, 117, '23:03:21', '23:30:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (269, 134, 234, '9:07:43', '10:21:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (69, 167, 33, '9:11:08', '17:03:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (355, 395, 382, '4:17:08', '4:04:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (216, 50, 218, '20:41:52', '8:39:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (202, 346, 199, '10:55:35', '19:16:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (11, 13, 114, '5:20:27', '12:57:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (171, 231, 347, '3:06:24', '12:31:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (99, 217, 168, '15:01:12', '12:53:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (146, 303, 33, '15:34:54', '10:41:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (30, 69, 243, '18:06:31', '8:47:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (215, 287, 351, '11:15:47', '7:29:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (218, 370, 49, '22:25:16', '12:27:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (4, 186, 158, '10:00:08', '13:22:59', null);
commit;
prompt 200 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (67, 388, 307, '7:03:36', '9:35:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (3, 3, 36, '1:54:10', '8:48:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (136, 29, 225, '23:14:00', '17:56:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (234, 138, 182, '2:15:05', '16:24:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (294, 309, 59, '16:13:48', '11:12:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (21, 297, 56, '4:05:51', '20:40:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (176, 152, 352, '17:16:44', '15:39:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (112, 93, 18, '5:29:56', '20:23:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (251, 361, 14, '5:12:20', '6:31:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (221, 144, 367, '15:36:14', '21:59:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (60, 316, 268, '19:16:02', '13:15:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 70, 375, '23:09:58', '8:30:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (243, 315, 127, '17:53:57', '2:59:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (166, 22, 277, '15:02:22', '7:11:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (8, 94, 124, '19:01:38', '17:02:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (379, 316, 372, '7:13:26', '17:22:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (259, 128, 109, '14:54:13', '9:39:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (146, 255, 388, '23:11:42', '15:06:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (190, 113, 299, '3:24:58', '11:08:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (392, 5, 12, '12:20:50', '15:07:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (188, 47, 114, '16:09:39', '18:41:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (8, 303, 386, '5:50:19', '10:28:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (306, 346, 1, '7:15:52', '14:42:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (50, 326, 117, '7:13:31', '21:08:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (40, 399, 398, '9:24:17', '11:35:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (185, 369, 384, '6:14:52', '11:16:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (245, 251, 294, '5:03:20', '19:10:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (393, 49, 249, '19:24:08', '21:38:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (358, 175, 352, '17:17:42', '21:51:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (160, 370, 15, '10:59:54', '5:07:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (161, 183, 205, '3:11:46', '11:40:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (193, 68, 34, '16:03:04', '16:15:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (220, 186, 399, '19:40:35', '13:50:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (204, 285, 166, '9:14:41', '5:34:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (40, 94, 283, '21:12:49', '13:42:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (262, 84, 139, '19:01:56', '0:09:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (174, 226, 229, '3:37:23', '10:13:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (374, 239, 294, '0:03:11', '5:00:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (355, 381, 344, '2:25:40', '18:56:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 84, 276, '5:47:23', '1:44:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (357, 299, 156, '7:35:18', '20:25:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (129, 356, 164, '15:31:05', '2:09:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (172, 277, 297, '15:23:46', '9:38:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (262, 364, 379, '15:04:56', '3:15:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (205, 219, 284, '11:28:04', '16:23:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (314, 214, 51, '7:08:19', '4:08:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (204, 387, 295, '4:39:15', '16:02:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (54, 147, 111, '4:56:28', '20:46:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (126, 244, 337, '20:10:07', '20:18:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (278, 7, 342, '19:11:19', '1:25:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (166, 57, 24, '17:26:50', '4:23:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (206, 252, 336, '16:50:37', '0:09:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (20, 254, 219, '21:35:28', '23:22:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (350, 45, 163, '0:03:32', '22:16:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (49, 138, 388, '20:56:06', '19:04:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (109, 326, 266, '3:55:23', '12:14:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (144, 19, 213, '11:30:04', '18:25:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (349, 201, 246, '4:43:18', '3:27:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (237, 21, 107, '15:49:43', '23:39:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (274, 358, 38, '1:33:44', '19:52:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (156, 226, 349, '0:45:54', '8:55:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (9, 189, 14, '17:29:21', '4:09:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (19, 281, 44, '3:17:14', '7:22:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (257, 132, 56, '1:43:29', '1:32:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (343, 281, 29, '7:53:37', '16:22:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (74, 214, 289, '11:54:56', '20:52:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (202, 106, 253, '21:07:32', '2:04:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (358, 358, 225, '17:16:54', '19:54:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (259, 314, 204, '8:40:29', '18:20:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (181, 184, 36, '4:05:14', '8:14:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (317, 82, 91, '14:38:31', '2:58:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (101, 277, 214, '6:13:41', '13:39:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (48, 133, 263, '20:16:46', '14:12:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (199, 362, 144, '23:49:25', '6:20:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (106, 176, 221, '0:33:21', '6:01:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 338, 104, '8:03:08', '13:31:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (321, 154, 153, '0:25:23', '22:19:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (252, 80, 295, '9:32:20', '0:39:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (180, 165, 366, '23:22:56', '10:27:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (178, 282, 279, '0:59:54', '21:40:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (353, 45, 72, '11:01:09', '11:14:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (344, 382, 349, '17:05:12', '5:02:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (48, 88, 160, '12:41:56', '13:59:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (200, 29, 126, '4:09:20', '16:07:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (319, 35, 225, '2:24:31', '8:52:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (136, 191, 182, '2:02:33', '12:55:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (398, 109, 73, '2:57:23', '21:20:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (115, 313, 338, '18:14:46', '16:34:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (204, 337, 170, '2:15:07', '16:30:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (288, 108, 191, '19:13:14', '5:11:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (222, 208, 364, '7:11:03', '8:19:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (168, 3, 11, '17:17:10', '19:37:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (63, 96, 293, '3:38:11', '8:18:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (174, 386, 90, '1:27:13', '19:21:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (319, 345, 229, '17:15:17', '11:08:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (261, 52, 55, '9:02:17', '3:41:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (208, 384, 260, '11:11:49', '7:22:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (19, 14, 57, '2:50:49', '1:32:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (287, 317, 211, '12:20:06', '3:29:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (79, 206, 138, '20:56:31', '19:48:41', null);
commit;
prompt 300 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (242, 84, 129, '10:44:08', '17:40:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (134, 45, 194, '12:50:15', '15:16:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (310, 324, 20, '20:15:09', '6:52:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (317, 140, 78, '23:02:10', '12:53:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (77, 226, 18, '9:48:42', '17:36:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (167, 234, 36, '23:19:52', '20:42:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (250, 89, 315, '5:15:25', '23:06:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (279, 146, 107, '4:04:42', '21:33:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (138, 364, 332, '19:09:55', '17:45:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (129, 54, 67, '10:18:54', '8:54:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (284, 270, 179, '10:32:50', '16:47:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (100, 26, 359, '10:47:52', '13:17:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (366, 242, 216, '10:57:38', '18:45:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (117, 265, 379, '20:04:01', '8:22:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (25, 322, 323, '15:52:34', '17:43:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (72, 64, 389, '4:27:00', '23:26:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (389, 223, 10, '23:42:22', '14:29:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (239, 79, 346, '17:05:19', '19:26:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (385, 270, 352, '4:38:14', '19:24:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (271, 271, 255, '7:24:46', '18:02:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (365, 370, 43, '15:18:14', '5:01:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (212, 333, 189, '4:40:43', '15:11:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 87, 10, '18:09:21', '17:18:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (94, 238, 9, '9:20:51', '23:01:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (269, 152, 43, '20:00:50', '5:00:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (236, 146, 304, '0:13:35', '6:17:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (66, 222, 161, '21:48:03', '19:22:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (60, 347, 124, '20:42:10', '3:56:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (66, 15, 334, '17:50:04', '22:27:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (294, 163, 397, '9:21:50', '10:45:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (200, 275, 191, '16:01:09', '11:47:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (1, 292, 104, '8:06:48', '22:37:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (94, 37, 159, '17:51:36', '5:21:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (249, 338, 376, '21:57:33', '15:32:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (213, 106, 63, '19:52:25', '14:59:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (85, 169, 75, '14:36:13', '16:54:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (263, 330, 59, '15:13:54', '0:51:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (159, 109, 263, '15:58:25', '2:33:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (268, 117, 100, '11:47:15', '14:13:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (214, 79, 222, '18:44:05', '21:53:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (322, 3, 367, '6:38:26', '1:40:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (131, 58, 7, '22:26:29', '8:19:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (134, 199, 12, '14:40:48', '16:41:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (108, 309, 279, '1:30:22', '21:01:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (42, 231, 27, '16:26:26', '19:52:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (53, 259, 291, '8:19:18', '8:03:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (45, 221, 135, '21:47:42', '18:34:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (243, 219, 248, '0:11:17', '14:37:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (241, 1, 255, '4:49:55', '10:17:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (391, 332, 150, '12:49:03', '15:25:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (393, 356, 204, '2:56:53', '8:19:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (189, 170, 275, '17:57:38', '5:58:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (210, 196, 316, '3:20:10', '9:17:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (369, 191, 242, '10:20:19', '5:36:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (15, 221, 322, '9:20:56', '17:28:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (132, 127, 161, '7:15:23', '14:29:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (34, 174, 272, '14:32:05', '3:02:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (301, 341, 339, '0:45:39', '1:37:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (178, 137, 130, '18:12:31', '10:33:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (266, 301, 247, '19:13:13', '16:32:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (192, 342, 267, '20:17:04', '14:16:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (135, 35, 354, '15:51:55', '2:43:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (353, 95, 295, '20:47:19', '10:18:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (112, 380, 376, '9:21:51', '21:31:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (54, 44, 346, '9:58:43', '16:08:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (92, 237, 131, '8:17:08', '21:13:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (56, 128, 223, '21:15:38', '7:39:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (76, 281, 163, '4:25:38', '7:40:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (236, 334, 65, '12:40:55', '1:06:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (310, 278, 150, '18:17:12', '9:40:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (149, 15, 235, '2:41:20', '17:06:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (88, 151, 351, '0:19:46', '6:43:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (172, 4, 269, '7:42:55', '1:42:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (394, 30, 316, '5:08:43', '8:26:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (210, 102, 347, '0:11:44', '0:10:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (137, 8, 70, '8:20:36', '21:44:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (111, 140, 383, '18:02:46', '2:29:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (380, 85, 250, '11:38:08', '6:51:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (165, 265, 294, '7:22:00', '9:30:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (218, 24, 205, '13:32:44', '14:17:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (265, 318, 128, '11:19:40', '22:36:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (199, 351, 215, '23:06:40', '23:55:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 382, 179, '8:25:07', '3:15:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (99, 238, 189, '13:00:14', '9:56:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (388, 377, 320, '18:01:28', '3:22:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (13, 213, 399, '11:31:33', '23:05:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (251, 54, 22, '5:57:49', '15:22:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (68, 79, 387, '1:49:18', '10:49:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (226, 99, 10, '2:38:39', '22:50:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (89, 198, 394, '17:38:49', '8:46:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (63, 164, 164, '23:50:54', '1:54:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (262, 58, 231, '14:55:31', '16:25:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (106, 284, 161, '2:09:32', '15:44:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (265, 309, 211, '16:13:01', '23:54:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (8, 356, 392, '4:49:32', '0:05:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (105, 129, 67, '6:35:18', '20:58:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (114, 360, 193, '16:52:22', '1:00:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (222, 375, 276, '3:31:49', '23:32:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (278, 129, 109, '17:34:57', '0:59:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (204, 393, 176, '0:39:32', '14:11:13', null);
commit;
prompt 400 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (228, 285, 177, '22:02:37', '14:30:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (264, 184, 201, '11:44:56', '14:01:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (159, 24, 198, '21:53:38', '3:20:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (234, 149, 57, '9:49:10', '12:25:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (360, 138, 180, '1:41:37', '23:19:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (338, 311, 280, '12:50:17', '22:19:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (352, 315, 3, '0:15:56', '9:25:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (225, 76, 89, '21:43:39', '7:12:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (273, 113, 354, '12:24:41', '6:54:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (344, 299, 221, '5:40:36', '4:48:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (255, 146, 7, '5:32:36', '8:24:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (50, 367, 320, '6:38:43', '4:17:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (143, 356, 286, '4:27:08', '3:34:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (336, 272, 75, '22:52:39', '6:01:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (291, 13, 212, '1:33:21', '8:33:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (361, 183, 33, '5:30:34', '18:05:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (346, 384, 12, '5:45:46', '19:36:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (34, 23, 87, '16:47:10', '7:42:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (73, 64, 218, '11:30:22', '7:58:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (191, 264, 220, '18:48:05', '22:15:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (292, 175, 224, '18:26:02', '19:23:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (395, 6, 183, '0:21:21', '16:48:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (6, 137, 378, '19:08:35', '1:45:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (191, 138, 314, '5:53:07', '9:00:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (110, 307, 179, '9:29:25', '16:22:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (282, 350, 62, '7:37:17', '6:22:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 357, 51, '8:31:14', '16:19:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (50, 150, 305, '16:12:44', '15:48:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (177, 122, 341, '8:08:31', '5:12:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (301, 396, 268, '0:05:37', '5:28:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (181, 94, 231, '20:43:52', '4:35:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (127, 263, 247, '13:53:11', '19:53:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (148, 264, 250, '0:08:47', '17:00:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (192, 348, 131, '19:36:19', '6:17:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (169, 193, 128, '4:53:39', '14:24:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (85, 384, 262, '1:30:40', '15:21:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (261, 168, 348, '8:36:40', '1:31:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (159, 88, 45, '10:18:58', '9:12:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (165, 391, 331, '2:27:37', '13:14:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (256, 80, 220, '14:52:04', '9:38:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (227, 132, 151, '11:14:53', '8:45:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (211, 67, 301, '15:26:40', '22:05:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (242, 9, 374, '4:51:55', '6:37:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (152, 127, 254, '6:27:56', '4:37:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (128, 143, 232, '11:34:31', '20:43:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (222, 113, 136, '1:41:24', '5:20:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (179, 243, 76, '14:44:16', '10:13:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (75, 124, 125, '5:07:45', '4:51:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (38, 48, 272, '9:01:25', '20:13:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (89, 128, 278, '23:17:33', '14:37:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (81, 125, 209, '10:24:04', '17:24:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (9, 241, 357, '14:08:37', '21:12:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (269, 378, 158, '16:45:33', '4:40:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (173, 27, 248, '18:46:40', '20:58:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (63, 245, 127, '7:21:57', '16:36:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (71, 111, 57, '3:42:07', '4:58:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (36, 114, 166, '0:37:56', '1:46:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (50, 292, 131, '21:49:50', '4:56:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (213, 251, 91, '7:14:09', '5:39:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (199, 36, 317, '1:30:51', '16:27:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (298, 125, 244, '19:13:57', '10:03:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (1, 282, 320, '1:09:44', '14:24:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (293, 63, 221, '7:27:53', '2:29:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (227, 262, 331, '19:37:09', '23:50:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (165, 69, 173, '19:19:25', '6:27:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (143, 116, 384, '6:23:46', '23:47:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (212, 112, 276, '16:17:26', '21:03:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (47, 104, 183, '15:57:47', '22:13:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (9, 369, 295, '18:19:27', '4:53:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (153, 294, 51, '10:54:21', '23:34:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (61, 386, 241, '21:47:31', '3:44:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (274, 256, 12, '23:02:29', '15:50:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (85, 253, 282, '6:38:11', '2:26:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (148, 305, 175, '20:33:02', '8:09:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (279, 368, 340, '3:33:56', '16:45:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (151, 70, 114, '3:24:18', '22:59:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (138, 133, 275, '4:11:54', '5:23:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (26, 156, 123, '10:44:18', '18:15:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (226, 130, 11, '20:37:53', '16:48:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (166, 352, 185, '20:52:59', '6:53:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (356, 384, 284, '9:13:07', '23:15:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (4, 27, 183, '19:34:44', '15:45:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (313, 384, 169, '0:39:43', '11:26:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (341, 110, 228, '4:49:22', '3:51:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (34, 169, 115, '21:20:41', '10:45:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (156, 192, 333, '4:07:14', '19:57:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (378, 92, 116, '4:21:15', '1:02:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (138, 259, 309, '9:37:59', '10:48:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 70, 364, '5:21:24', '9:15:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (274, 353, 38, '16:10:05', '16:17:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (90, 207, 261, '5:49:40', '5:59:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (285, 201, 343, '12:18:20', '7:44:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (32, 363, 149, '2:46:19', '11:07:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (123, 23, 398, '13:41:06', '0:42:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (94, 63, 151, '2:24:49', '4:26:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (80, 253, 199, '18:31:41', '8:00:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (313, 307, 142, '19:12:58', '7:14:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (378, 246, 185, '7:08:21', '1:44:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (369, 367, 317, '13:25:31', '7:56:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (33, 191, 79, '11:00:57', '21:54:18', null);
commit;
prompt 500 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (41, 180, 46, '7:57:58', '6:53:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (118, 303, 334, '23:25:15', '15:16:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (45, 111, 155, '6:50:55', '1:31:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (317, 16, 153, '7:41:48', '14:16:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (83, 119, 37, '3:21:03', '19:51:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (396, 179, 340, '19:32:50', '9:35:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (185, 155, 140, '14:07:18', '17:12:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (42, 348, 225, '7:18:39', '21:09:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (152, 321, 370, '23:56:43', '12:40:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (345, 388, 26, '19:25:43', '9:36:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (393, 388, 134, '17:41:47', '23:02:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (176, 1, 84, '10:10:16', '2:04:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (160, 6, 263, '12:09:12', '0:23:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (216, 108, 249, '12:15:48', '10:53:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (383, 39, 203, '21:35:56', '8:06:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (272, 236, 296, '14:08:38', '20:01:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (76, 387, 400, '19:02:31', '20:40:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (128, 395, 57, '13:26:50', '17:21:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (233, 325, 296, '1:09:30', '17:09:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (295, 292, 219, '21:32:24', '18:58:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (11, 381, 22, '9:17:45', '4:15:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (90, 279, 138, '9:19:46', '2:05:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (140, 13, 324, '8:51:54', '12:01:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (189, 11, 219, '23:07:56', '19:37:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (179, 312, 36, '13:32:25', '13:27:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (54, 60, 387, '13:23:06', '9:13:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (152, 324, 35, '7:19:24', '17:47:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (185, 128, 134, '12:47:09', '12:56:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (372, 103, 180, '1:10:09', '4:28:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (388, 196, 77, '0:35:02', '18:25:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (109, 40, 6, '14:18:42', '5:55:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (213, 29, 33, '14:00:28', '8:21:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (151, 366, 250, '21:33:47', '21:03:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (254, 219, 265, '15:37:04', '10:44:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (38, 192, 34, '15:37:24', '3:09:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (266, 166, 163, '0:01:38', '4:53:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (246, 32, 359, '3:36:11', '21:05:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (92, 267, 49, '4:15:43', '9:32:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (366, 226, 228, '7:58:03', '1:10:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (224, 262, 114, '13:07:00', '3:54:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (101, 87, 349, '3:49:46', '19:24:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (301, 170, 25, '14:58:36', '1:11:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (73, 232, 211, '12:32:07', '21:32:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (150, 75, 49, '0:11:13', '1:27:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (332, 179, 228, '18:56:04', '7:58:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (76, 318, 168, '6:57:18', '19:36:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (130, 23, 71, '1:59:19', '4:10:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (276, 14, 303, '8:38:34', '12:31:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (388, 20, 251, '19:24:14', '6:12:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (366, 95, 316, '21:53:17', '15:34:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (281, 140, 27, '5:02:37', '12:44:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (58, 234, 159, '14:55:44', '3:55:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (362, 394, 257, '16:36:01', '19:33:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (254, 356, 398, '6:13:09', '6:27:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (212, 71, 127, '11:49:33', '8:16:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (350, 123, 397, '13:04:00', '0:54:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (173, 352, 344, '21:39:22', '12:55:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (200, 330, 201, '21:21:55', '3:24:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (55, 256, 399, '0:18:17', '20:01:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (173, 297, 76, '3:58:03', '20:18:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (361, 370, 274, '5:00:47', '8:30:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (219, 235, 104, '17:57:36', '10:51:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (272, 2, 169, '4:56:21', '13:01:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (283, 86, 319, '6:36:39', '13:40:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (220, 301, 397, '1:04:27', '8:51:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (114, 17, 291, '0:06:18', '8:58:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (367, 234, 283, '21:46:47', '11:14:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (318, 82, 80, '3:38:07', '6:40:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (259, 23, 130, '11:13:33', '6:45:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (269, 189, 365, '10:40:56', '1:36:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (91, 30, 70, '12:08:02', '6:54:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (295, 67, 348, '2:16:14', '3:25:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (243, 109, 49, '16:50:48', '22:56:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (171, 250, 322, '17:21:02', '19:12:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (23, 280, 55, '3:28:59', '16:26:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (358, 167, 280, '6:32:46', '1:52:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (107, 118, 383, '1:04:34', '1:28:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (181, 385, 236, '0:26:16', '15:51:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (48, 97, 11, '19:11:20', '5:25:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (269, 328, 88, '17:03:38', '11:37:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (233, 243, 216, '12:17:00', '10:49:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (321, 98, 199, '18:31:33', '10:19:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (61, 367, 33, '5:59:12', '12:03:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (95, 203, 160, '0:27:00', '20:40:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (75, 385, 264, '14:57:04', '2:19:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (304, 257, 225, '15:56:26', '12:04:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (39, 383, 326, '9:00:53', '16:11:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (374, 97, 64, '10:27:08', '19:23:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (270, 366, 237, '6:01:15', '20:26:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (156, 84, 374, '3:31:22', '18:08:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (45, 126, 324, '21:58:02', '21:54:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (176, 285, 293, '0:03:33', '18:53:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (24, 265, 63, '12:55:37', '15:43:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (263, 78, 181, '21:11:15', '3:09:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (79, 282, 285, '11:22:52', '22:13:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (377, 274, 138, '8:58:34', '2:54:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (240, 151, 369, '17:21:22', '5:12:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (61, 88, 286, '11:13:42', '12:57:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (332, 148, 222, '13:04:38', '15:22:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (14, 150, 225, '21:07:09', '8:43:32', null);
commit;
prompt 600 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 386, 244, '8:47:27', '16:10:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (33, 219, 100, '11:39:34', '20:22:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (48, 319, 218, '3:27:53', '4:24:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (53, 380, 187, '16:32:50', '13:51:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (58, 101, 141, '17:41:22', '12:11:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (120, 255, 390, '15:08:08', '13:38:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (310, 198, 253, '8:33:04', '21:30:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (255, 295, 233, '4:39:28', '15:02:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (226, 194, 288, '0:58:31', '5:35:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (245, 23, 245, '19:48:50', '16:23:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (245, 388, 10, '15:36:04', '0:57:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (308, 367, 34, '9:47:33', '11:44:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (240, 314, 247, '0:16:50', '10:45:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (207, 240, 160, '13:30:48', '19:27:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (11, 261, 310, '23:15:04', '0:18:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (254, 157, 96, '19:39:18', '13:33:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (241, 150, 354, '16:34:40', '23:28:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (238, 160, 210, '12:54:40', '7:25:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (158, 91, 335, '13:13:35', '6:18:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (301, 260, 88, '0:45:40', '18:10:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (311, 262, 188, '3:23:26', '6:02:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (293, 90, 108, '13:35:19', '16:01:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (360, 372, 182, '6:09:09', '11:35:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (175, 203, 385, '3:34:34', '7:30:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (236, 182, 324, '20:20:52', '22:41:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (304, 255, 41, '13:39:17', '23:20:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (324, 309, 328, '23:28:24', '17:26:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (260, 21, 399, '0:09:54', '22:13:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (326, 89, 166, '16:24:38', '0:13:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (161, 213, 195, '4:40:32', '7:30:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (287, 276, 269, '9:40:59', '15:13:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (393, 336, 225, '17:00:03', '18:45:39', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (27, 249, 296, '23:25:01', '18:02:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (207, 315, 61, '8:16:18', '18:29:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (72, 164, 119, '5:55:39', '9:57:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (285, 266, 168, '21:24:23', '16:51:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (193, 120, 137, '1:42:08', '1:57:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (203, 128, 28, '10:58:32', '18:21:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (239, 324, 310, '8:32:06', '22:21:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (256, 194, 375, '18:17:25', '11:52:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (223, 196, 142, '13:32:00', '8:24:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 238, 111, '4:36:30', '17:29:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (215, 262, 297, '3:40:13', '8:07:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (231, 43, 57, '20:25:35', '18:39:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (154, 371, 186, '0:22:08', '7:54:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (89, 264, 138, '9:08:10', '15:42:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (400, 135, 152, '14:04:43', '16:40:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (283, 192, 310, '13:11:17', '23:43:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (273, 118, 152, '6:35:11', '6:35:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (253, 146, 153, '20:07:34', '3:28:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (145, 267, 88, '19:17:49', '16:00:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (244, 170, 266, '11:43:20', '4:45:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (19, 360, 394, '2:50:19', '14:30:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 119, 399, '20:00:12', '8:27:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (247, 295, 188, '1:53:49', '12:33:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (246, 128, 166, '14:43:28', '10:34:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (111, 11, 377, '13:05:05', '10:47:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (122, 66, 304, '20:53:43', '9:32:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (229, 347, 17, '2:42:01', '10:44:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (10, 61, 195, '3:49:21', '2:33:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (57, 70, 172, '11:22:56', '12:27:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (350, 252, 343, '21:40:03', '5:06:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (194, 267, 136, '17:11:29', '10:52:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (88, 74, 2, '1:42:17', '19:03:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (314, 170, 178, '1:13:08', '10:20:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (369, 325, 383, '15:58:35', '4:05:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (109, 163, 234, '14:38:36', '2:30:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (267, 334, 378, '11:50:42', '4:22:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (9, 83, 8, '7:17:21', '20:50:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (179, 300, 25, '13:37:53', '9:40:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (132, 100, 285, '10:39:04', '6:06:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (83, 18, 63, '1:39:51', '12:58:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (6, 240, 398, '18:37:31', '14:10:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (268, 78, 101, '15:10:01', '1:55:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (251, 388, 86, '20:15:45', '23:29:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (338, 53, 233, '10:25:41', '5:09:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (335, 211, 23, '22:08:29', '7:42:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (123, 48, 343, '12:07:57', '11:20:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (396, 173, 58, '3:04:22', '23:44:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (99, 177, 226, '12:23:58', '22:35:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (228, 165, 115, '18:20:58', '14:58:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (165, 308, 24, '2:37:49', '13:15:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (65, 84, 3, '4:05:27', '11:30:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (182, 203, 307, '17:40:12', '19:18:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (329, 247, 258, '8:06:37', '13:30:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (53, 126, 276, '3:10:18', '23:03:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (315, 112, 233, '21:50:39', '4:31:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (2, 153, 77, '18:44:00', '17:30:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (102, 268, 285, '1:49:59', '14:25:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (210, 307, 254, '13:30:57', '19:00:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (177, 159, 106, '1:37:59', '19:58:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (129, 285, 296, '1:42:37', '17:13:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (152, 258, 247, '2:38:59', '23:06:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (262, 28, 160, '21:57:55', '0:11:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (70, 329, 251, '8:14:20', '10:51:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 354, 279, '6:31:37', '7:04:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (132, 312, 290, '15:15:52', '20:01:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (216, 64, 236, '1:01:08', '19:44:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (251, 243, 135, '0:37:32', '14:52:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (295, 326, 206, '12:36:37', '15:11:04', null);
commit;
prompt 700 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (91, 38, 327, '0:54:45', '13:25:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (320, 259, 341, '13:49:42', '16:20:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 252, 45, '18:21:15', '19:24:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (21, 25, 392, '16:05:10', '14:02:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (308, 192, 242, '19:59:58', '8:42:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (80, 307, 242, '4:59:00', '0:18:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (182, 180, 78, '10:00:59', '11:27:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (356, 350, 378, '16:41:53', '22:48:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (170, 235, 57, '16:55:55', '0:14:01', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (65, 294, 277, '10:33:03', '2:49:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (241, 196, 155, '1:57:08', '1:37:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (248, 104, 80, '2:19:22', '1:50:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (1, 89, 225, '16:50:44', '12:11:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (355, 17, 225, '8:08:14', '15:08:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (279, 256, 123, '17:35:03', '16:20:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (116, 54, 277, '19:57:10', '0:17:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (365, 237, 84, '23:06:32', '14:36:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (345, 43, 231, '0:03:54', '20:44:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (136, 68, 72, '5:20:30', '6:49:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (326, 92, 202, '13:02:23', '2:24:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (163, 89, 220, '20:58:34', '14:40:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (228, 41, 260, '8:52:29', '19:40:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (89, 32, 319, '11:12:05', '19:10:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (318, 36, 232, '4:44:46', '23:56:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (216, 256, 132, '2:46:24', '12:50:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (244, 194, 336, '22:53:51', '3:15:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (377, 42, 169, '0:43:42', '18:08:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (220, 27, 252, '9:37:24', '22:45:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (144, 14, 386, '11:59:44', '19:44:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 365, 291, '19:16:32', '8:53:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (232, 111, 182, '13:36:13', '2:54:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (397, 316, 289, '3:27:56', '14:47:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (253, 163, 169, '7:49:46', '3:16:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (355, 295, 168, '0:01:28', '15:10:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (215, 302, 377, '19:19:08', '10:55:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (384, 358, 337, '18:11:51', '21:40:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (17, 392, 105, '13:36:04', '19:00:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (388, 48, 185, '0:13:58', '5:22:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (134, 123, 319, '6:04:00', '22:21:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (86, 102, 236, '21:55:23', '21:29:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (156, 193, 183, '6:43:29', '22:03:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (88, 20, 219, '22:46:18', '22:34:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (199, 73, 216, '6:48:51', '7:34:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (377, 57, 106, '16:08:12', '18:43:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (165, 5, 36, '15:22:55', '14:58:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (74, 205, 254, '7:23:54', '9:46:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (119, 101, 301, '2:33:15', '21:25:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (389, 208, 323, '16:27:06', '13:32:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (373, 293, 180, '4:11:03', '10:13:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (76, 155, 63, '20:57:10', '10:44:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (130, 356, 377, '5:57:57', '1:02:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 160, 205, '8:11:44', '15:36:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (307, 342, 258, '11:14:45', '13:04:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (91, 55, 192, '21:16:43', '18:54:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (226, 138, 130, '17:06:19', '19:12:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (209, 331, 18, '2:08:25', '17:38:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (174, 261, 46, '15:40:19', '0:31:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (362, 181, 74, '14:39:10', '3:30:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (66, 356, 30, '14:05:32', '1:46:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (109, 252, 51, '2:19:05', '20:53:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (74, 211, 178, '17:01:13', '20:39:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (137, 227, 307, '18:29:13', '12:00:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (320, 177, 122, '0:39:34', '9:11:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (133, 19, 127, '7:29:55', '6:15:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (353, 61, 69, '17:51:51', '17:32:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (154, 91, 86, '23:44:33', '16:46:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 399, 107, '21:09:01', '1:57:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (64, 247, 304, '4:21:49', '2:28:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (50, 226, 312, '19:46:42', '7:12:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (382, 43, 232, '10:53:12', '15:13:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (204, 123, 393, '15:13:18', '2:41:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (190, 147, 322, '23:53:08', '17:51:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (99, 164, 3, '16:38:02', '17:46:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (208, 396, 143, '2:28:32', '15:38:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (74, 74, 360, '15:07:24', '4:26:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (7, 325, 351, '17:30:47', '14:25:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (46, 229, 387, '21:04:37', '3:20:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (156, 244, 44, '11:10:09', '9:15:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (65, 47, 378, '6:52:39', '2:00:11', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (32, 295, 272, '4:18:57', '17:00:47', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (38, 158, 335, '14:18:13', '15:59:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (184, 297, 328, '8:07:26', '9:19:43', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (264, 353, 309, '15:25:09', '15:08:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (352, 98, 359, '20:39:33', '8:19:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (79, 75, 388, '21:22:53', '11:16:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (363, 158, 191, '19:16:15', '21:22:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (195, 212, 19, '5:58:33', '7:04:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (56, 162, 70, '21:53:46', '11:35:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (66, 38, 144, '2:07:12', '9:17:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (186, 385, 315, '6:34:11', '3:55:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (261, 200, 221, '18:33:51', '15:30:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (323, 224, 238, '17:13:31', '20:21:06', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (324, 239, 280, '18:47:08', '7:51:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (218, 52, 104, '20:49:53', '15:34:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (239, 21, 265, '5:04:29', '2:01:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (368, 124, 187, '11:23:46', '13:20:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (228, 148, 92, '17:30:53', '21:58:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (67, 394, 216, '6:53:26', '11:08:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (217, 333, 100, '23:18:38', '7:10:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (103, 145, 332, '16:05:59', '9:44:28', null);
commit;
prompt 800 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (201, 249, 372, '15:07:49', '8:54:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (251, 170, 309, '10:31:20', '17:08:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (293, 235, 384, '8:29:27', '19:08:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (205, 43, 139, '22:56:56', '9:34:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (87, 372, 213, '4:14:22', '15:32:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (88, 394, 23, '13:10:27', '17:07:57', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (234, 283, 269, '13:22:53', '16:34:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (291, 342, 381, '11:29:32', '15:07:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (347, 34, 247, '17:55:35', '1:05:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (236, 130, 190, '16:09:53', '13:22:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (90, 174, 322, '12:17:50', '3:46:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (94, 369, 88, '1:30:33', '9:21:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (116, 269, 78, '17:00:48', '15:32:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (7, 27, 35, '12:18:52', '0:45:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (223, 190, 243, '19:37:58', '9:59:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (152, 200, 213, '2:56:35', '17:45:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (21, 212, 217, '3:27:12', '6:30:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (276, 353, 79, '12:57:54', '13:55:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (3, 256, 149, '13:02:24', '5:58:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (19, 374, 220, '21:36:42', '4:49:41', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (123, 323, 337, '18:32:57', '11:19:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (153, 174, 157, '20:05:01', '9:46:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (266, 145, 10, '0:00:28', '1:45:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (248, 203, 26, '12:14:03', '19:33:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (101, 158, 299, '12:12:35', '19:38:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (233, 393, 22, '21:22:03', '15:19:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (400, 111, 54, '14:21:14', '9:00:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (341, 312, 225, '9:31:24', '4:54:17', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (297, 213, 90, '10:26:17', '8:47:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (355, 38, 66, '12:35:37', '4:49:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (36, 371, 264, '7:52:49', '12:38:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (29, 238, 308, '15:42:03', '21:35:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 199, 224, '21:06:38', '9:04:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (278, 228, 208, '6:32:50', '22:49:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (180, 190, 392, '20:37:29', '6:01:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (368, 242, 146, '6:13:04', '5:32:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (362, 252, 80, '2:42:42', '6:26:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (192, 246, 153, '14:05:22', '15:06:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (17, 330, 241, '20:05:04', '22:31:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (244, 161, 290, '5:21:37', '19:35:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (172, 353, 105, '15:16:33', '12:19:27', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (158, 145, 40, '21:48:12', '4:27:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (11, 58, 212, '9:14:39', '14:38:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (38, 161, 28, '6:06:50', '5:20:32', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (387, 82, 91, '19:00:19', '0:30:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (104, 362, 318, '13:46:23', '11:12:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (76, 302, 237, '21:17:59', '19:51:24', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (82, 395, 121, '5:02:54', '9:26:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (329, 15, 187, '12:13:19', '20:59:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (91, 105, 346, '23:35:20', '23:21:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (218, 12, 194, '7:02:00', '0:03:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (391, 104, 325, '13:28:10', '5:52:51', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (298, 204, 206, '2:32:45', '19:57:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (40, 264, 268, '6:31:48', '0:40:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (371, 191, 144, '6:22:46', '11:18:31', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (297, 223, 145, '22:27:54', '12:13:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (297, 275, 243, '12:45:11', '19:43:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (297, 1, 141, '3:56:02', '21:24:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (282, 66, 275, '3:54:49', '14:15:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (379, 58, 226, '23:03:27', '2:22:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (213, 342, 338, '10:51:19', '7:01:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 268, 256, '21:11:20', '9:23:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (304, 141, 30, '20:19:26', '3:34:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (333, 331, 34, '0:44:39', '13:49:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (265, 256, 198, '7:27:55', '3:37:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (68, 73, 299, '22:00:12', '17:51:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (344, 250, 216, '19:18:19', '1:02:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (252, 242, 108, '7:21:03', '2:19:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (10, 109, 255, '22:04:49', '4:41:34', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (122, 266, 114, '12:51:36', '22:56:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (289, 23, 46, '23:15:35', '23:44:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (374, 332, 336, '8:06:27', '5:24:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (113, 243, 360, '5:51:20', '5:59:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (375, 334, 285, '6:30:59', '13:52:10', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (319, 138, 156, '15:34:56', '8:18:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (316, 30, 103, '17:52:02', '9:37:14', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (178, 124, 263, '19:25:28', '1:10:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (290, 13, 140, '16:54:42', '10:02:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (365, 280, 369, '18:15:38', '2:03:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (330, 61, 252, '11:25:22', '14:19:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (350, 179, 176, '22:30:27', '15:10:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (205, 67, 34, '4:30:54', '22:41:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (324, 269, 189, '10:31:59', '19:21:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (367, 346, 102, '0:13:47', '6:40:19', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (117, 204, 32, '3:24:13', '14:35:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (197, 262, 294, '7:57:42', '2:38:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (311, 174, 98, '11:37:43', '11:21:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (267, 364, 70, '4:13:04', '8:24:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (200, 250, 64, '5:23:04', '20:48:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (118, 371, 178, '16:27:54', '10:51:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (131, 188, 174, '22:32:56', '9:10:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (345, 168, 324, '3:42:23', '7:58:45', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (303, 317, 302, '17:37:51', '14:20:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (33, 52, 236, '2:42:19', '15:02:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (312, 179, 319, '9:30:08', '17:09:54', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (101, 82, 91, '8:10:59', '23:54:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (53, 222, 197, '4:31:10', '7:15:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (144, 67, 379, '7:14:29', '8:03:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (286, 364, 279, '6:26:27', '6:45:56', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (25, 188, 400, '21:46:18', '1:11:08', null);
commit;
prompt 900 records committed...
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (228, 386, 396, '2:37:18', '23:23:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (147, 97, 351, '16:38:09', '9:37:20', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (148, 306, 169, '21:23:55', '22:56:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (151, 181, 113, '18:03:01', '14:03:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (98, 211, 189, '0:20:15', '23:05:13', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (149, 322, 10, '5:52:46', '17:35:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (165, 315, 154, '0:39:07', '18:43:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (186, 351, 69, '5:04:03', '3:51:55', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (322, 344, 100, '18:08:04', '21:53:49', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (66, 223, 389, '18:37:04', '23:18:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (299, 192, 130, '21:41:06', '7:55:46', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (219, 21, 391, '7:12:43', '17:51:25', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (157, 35, 320, '10:24:26', '2:12:02', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (5, 52, 331, '4:53:04', '15:09:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (368, 68, 300, '17:38:31', '8:37:59', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (318, 325, 147, '6:40:37', '0:43:05', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (54, 213, 320, '2:17:57', '0:04:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (53, 216, 282, '19:02:32', '10:01:38', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (125, 267, 283, '4:46:40', '7:51:18', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (363, 233, 391, '14:10:03', '10:09:35', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (96, 282, 214, '5:03:15', '0:10:15', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (229, 299, 200, '2:21:36', '4:03:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (78, 390, 149, '14:49:57', '22:55:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (148, 212, 144, '20:34:27', '7:55:58', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (400, 344, 12, '23:45:37', '5:18:21', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (159, 192, 211, '15:58:01', '4:53:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (289, 389, 382, '14:08:12', '2:08:28', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (171, 206, 39, '13:10:43', '14:15:03', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (64, 377, 343, '18:04:10', '22:49:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (390, 313, 277, '0:36:46', '23:38:53', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (122, 23, 217, '11:44:28', '11:48:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (102, 400, 102, '16:28:01', '15:19:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (221, 33, 285, '5:59:49', '19:35:00', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (362, 244, 369, '15:18:18', '15:43:52', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (148, 152, 123, '4:38:12', '22:17:04', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (272, 122, 343, '9:21:52', '13:30:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (150, 107, 324, '16:20:34', '10:07:22', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (144, 219, 31, '13:28:36', '7:32:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (365, 270, 39, '5:22:49', '8:45:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (325, 204, 359, '9:45:31', '4:49:30', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (379, 73, 197, '1:53:34', '22:18:09', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (142, 299, 212, '3:59:03', '1:56:36', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (115, 133, 99, '22:12:50', '12:25:29', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (243, 3, 258, '12:03:33', '8:20:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (290, 237, 397, '3:38:29', '15:25:48', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (148, 269, 183, '14:47:41', '18:15:50', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (158, 317, 228, '8:58:42', '20:28:07', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (307, 324, 84, '9:05:25', '9:07:42', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (11, 143, 200, '6:34:52', '21:26:40', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (257, 222, 332, '6:37:32', '11:48:08', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (7, 305, 195, '11:33:50', '10:54:44', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (354, 162, 291, '7:24:26', '11:18:37', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (140, 83, 230, '18:01:40', '8:15:12', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (257, 197, 203, '6:58:29', '15:30:23', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (398, 276, 245, '16:49:18', '22:22:33', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (237, 82, 388, '17:49:42', '22:18:26', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (214, 132, 245, '8:00:17', '4:30:16', null);
insert into BUSRIDE (busid, lineid, driverid, starttime, finishtime, ticketid)
values (338, 102, 84, '23:29:28', '10:14:39', null);
commit;
prompt 958 records loaded
prompt Loading TAXI...
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (1, '15-193-82', 'Fox', 7, to_date('02-04-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (2, '94-642-54', 'Tracer', 6, to_date('22-01-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (3, '92-205-32', 'MX-6', 3, to_date('03-05-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (4, '65-691-37', 'V50', 5, to_date('14-12-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (5, '71-491-92', '911', 2, to_date('18-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (6, '38-227-49', 'Fox', 7, to_date('07-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (7, '77-247-65', '3500', 3, to_date('28-09-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (8, '13-040-19', 'Park Avenue', 4, to_date('08-07-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (9, '20-244-23', 'GL-Class', 10, to_date('07-02-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (10, '43-487-38', 'New Beetle', 4, to_date('21-01-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (11, '27-891-08', 'Regal', 10, to_date('27-11-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (12, '70-792-49', 'Taurus', 4, to_date('16-10-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (13, '32-655-31', '3500', 5, to_date('03-07-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (14, '43-381-94', 'S40', 8, to_date('16-03-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (15, '97-952-95', 'JUKE', 4, to_date('14-07-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (16, '29-420-65', 'Navigator L', 10, to_date('29-03-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (17, '77-513-19', 'Regal', 9, to_date('01-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (18, '01-396-44', 'Corvette', 10, to_date('30-10-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (19, '65-567-10', 'S40', 5, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (20, '21-603-51', 'Montana', 7, to_date('09-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (21, '83-879-04', 'Tempo', 10, to_date('25-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (22, '32-531-51', 'Legacy', 9, to_date('14-07-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (23, '70-935-17', 'M6', 8, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (24, '15-980-42', 'Frontier', 6, to_date('08-02-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (25, '75-009-92', 'Grand Prix', 7, to_date('06-02-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (26, '20-321-52', 'Aerostar', 6, to_date('21-08-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (27, '29-603-12', 'G-Class', 9, to_date('30-11-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (28, '72-736-04', 'Touareg', 9, to_date('09-04-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (29, '08-916-23', 'Econoline E250', 10, to_date('20-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (30, '58-984-80', 'Talon', 4, to_date('04-07-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (31, '80-183-19', 'Caprice Classic', 3, to_date('03-10-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (32, '41-292-71', 'S60', 7, to_date('06-01-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (33, '22-695-29', 'Mirage', 3, to_date('20-08-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (34, '07-225-09', 'Camry', 4, to_date('09-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (35, '83-036-19', 'Savana 1500', 3, to_date('29-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (36, '84-075-37', 'Escort', 2, to_date('09-09-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (37, '10-885-39', 'GTO', 8, to_date('03-01-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (38, '27-767-33', 'CR-V', 8, to_date('24-03-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (39, '75-029-78', 'Avanti', 9, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (40, '06-146-34', 'Diamante', 4, to_date('04-03-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (41, '06-665-17', 'ES', 6, to_date('09-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (42, '44-448-39', 'LeBaron', 10, to_date('05-09-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (43, '10-315-49', 'Mountaineer', 9, to_date('10-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (44, '34-363-62', 'Sunfire', 4, to_date('14-11-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (45, '00-068-36', 'Skylark', 5, to_date('17-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (46, '54-909-58', 'G-Series G10', 2, to_date('20-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (47, '08-907-91', 'Legacy', 3, to_date('19-04-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (48, '15-868-24', 'Uplander', 10, to_date('11-10-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (49, '54-762-07', 'Torrent', 3, to_date('23-07-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (50, '22-485-37', 'GranTurismo', 7, to_date('22-10-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (51, '48-148-92', 'Accord', 7, to_date('09-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (52, '27-562-32', 'Murano', 9, to_date('16-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (53, '24-726-62', 'Prelude', 7, to_date('18-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (54, '18-740-91', 'Sportvan G10', 7, to_date('18-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (55, '45-048-46', 'Century', 8, to_date('23-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (56, '59-524-64', 'Windstar', 3, to_date('24-12-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (57, '38-763-53', 'Defender Ice Edition', 5, to_date('02-06-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (58, '29-800-48', 'Frontier', 4, to_date('09-11-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (59, '63-064-70', 'TrailBlazer', 2, to_date('04-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (60, '31-962-08', 'CL-Class', 3, to_date('04-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (61, '93-207-41', 'Escalade EXT', 2, to_date('17-10-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (62, '93-767-42', 'MX-6', 10, to_date('23-03-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (63, '08-621-86', 'Montana', 4, to_date('14-12-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (64, '98-577-12', 'RX-7', 5, to_date('18-06-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (65, '17-872-73', '4Runner', 9, to_date('28-04-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (66, '41-274-53', 'Colorado', 5, to_date('26-02-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (67, '15-572-45', 'Countach', 10, to_date('07-09-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (68, '26-707-26', 'GTO', 9, to_date('13-11-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (69, '80-104-61', 'i-370', 10, to_date('20-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (70, '39-476-33', 'Prizm', 7, to_date('25-11-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (71, '99-422-87', 'Savana 1500', 8, to_date('16-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (72, '57-664-80', 'B-Series', 2, to_date('03-02-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (73, '31-917-37', 'Camaro', 7, to_date('14-10-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (74, '28-320-47', '1500', 5, to_date('27-08-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (75, '87-154-41', '300', 2, to_date('24-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (76, '10-543-36', 'Cabriolet', 3, to_date('09-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (77, '09-375-48', 'SL-Class', 10, to_date('06-09-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (78, '82-951-96', 'Explorer', 6, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (79, '02-556-38', 'MPV', 9, to_date('12-01-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (80, '96-872-39', 'A7', 2, to_date('13-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (81, '34-243-20', 'Frontier', 4, to_date('22-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (82, '90-746-94', 'G-Class', 7, to_date('14-03-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (83, '30-271-28', 'A8', 5, to_date('22-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (84, '56-419-31', '626', 9, to_date('31-12-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (85, '51-882-40', 'Mazdaspeed 3', 9, to_date('31-07-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (86, '19-825-01', 'XJ Series', 9, to_date('03-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (87, '98-229-21', '911', 9, to_date('16-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (88, '67-633-48', 'Vantage', 3, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (89, '41-119-65', 'MX-5', 7, to_date('09-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (90, '07-124-23', 'Mustang', 4, to_date('24-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (91, '71-558-24', 'Touareg', 6, to_date('15-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (92, '87-341-14', '911', 2, to_date('10-04-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (93, '60-578-31', 'Sunfire', 9, to_date('03-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (94, '81-094-74', 'Turbo Firefly', 10, to_date('12-05-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (95, '17-277-00', 'CR-V', 2, to_date('24-12-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (96, '13-544-81', 'Jetta', 8, to_date('11-12-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (97, '90-974-73', 'Cabriolet', 6, to_date('04-06-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (98, '37-373-81', 'Astra', 5, to_date('22-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (99, '05-391-52', '9-5', 2, to_date('02-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (100, '78-093-52', 'M-Class', 9, to_date('06-12-2018', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (101, '88-197-30', 'Golf III', 8, to_date('30-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (102, '93-380-34', 'Corsica', 9, to_date('26-06-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (103, '53-831-15', 'Mazdaspeed 3', 4, to_date('01-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (104, '47-919-26', 'Grand Voyager', 2, to_date('16-01-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (105, '24-938-42', 'Sable', 7, to_date('20-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (106, '98-062-91', 'Aspen', 4, to_date('27-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (107, '91-437-35', 'Odyssey', 3, to_date('22-05-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (108, '39-770-98', 'Silverado', 5, to_date('15-07-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (109, '66-730-43', 'Crown Victoria', 2, to_date('25-02-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (110, '41-261-65', 'Raider', 6, to_date('03-04-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (111, '23-197-70', 'F-Series', 3, to_date('15-08-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (112, '85-293-52', 'Corvair', 5, to_date('14-01-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (113, '77-473-72', 'V50', 7, to_date('30-08-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (114, '96-506-95', 'Hombre Space', 5, to_date('19-06-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (115, '99-472-72', 'Suburban 2500', 10, to_date('01-04-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (116, '88-150-25', 'NSX', 5, to_date('13-02-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (117, '98-417-07', 'Ram Van B350', 9, to_date('01-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (118, '50-474-16', 'Esteem', 9, to_date('11-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (119, '24-231-39', '4Runner', 7, to_date('18-11-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (120, '40-345-77', 'F150', 5, to_date('24-04-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (121, '00-981-43', 'L-Series', 7, to_date('01-01-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (122, '43-114-13', 'Fifth Ave', 4, to_date('11-09-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (123, '61-460-26', 'Century', 9, to_date('17-08-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (124, '77-869-05', 'EXP', 9, to_date('15-08-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (125, '51-083-55', 'Forester', 7, to_date('24-12-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (126, '44-423-70', 'Corsica', 8, to_date('25-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (127, '60-413-97', 'X5', 5, to_date('22-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (128, '00-795-17', 'Pajero', 3, to_date('29-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (129, '24-552-14', 'G-Series 2500', 5, to_date('24-06-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (130, '86-998-22', 'Escort', 9, to_date('09-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (131, '34-007-15', 'Legacy', 10, to_date('27-07-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (132, '23-909-46', 'E250', 10, to_date('21-07-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (133, '34-174-59', 'Maxima', 3, to_date('18-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (134, '62-716-62', 'Celica', 7, to_date('23-03-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (135, '12-179-51', 'Pacifica', 4, to_date('29-09-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (136, '05-918-78', 'Silhouette', 4, to_date('22-11-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (137, '42-257-18', 'G', 3, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (138, '61-935-73', 'Leganza', 6, to_date('15-01-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (139, '28-963-38', 'Sedona', 5, to_date('28-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (140, '47-961-58', 'Tracer', 3, to_date('27-12-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (141, '30-964-83', 'Bonneville', 4, to_date('10-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (142, '73-456-00', 'Catera', 6, to_date('07-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (143, '31-728-56', 'Verano', 3, to_date('07-08-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (144, '38-913-60', 'Echo', 9, to_date('25-03-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (145, '14-116-63', 'Grand Caravan', 10, to_date('11-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (146, '41-024-35', 'Camaro', 3, to_date('17-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (147, '79-670-58', 'Vitara', 8, to_date('14-07-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (148, '85-515-11', '300', 8, to_date('19-07-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (149, '91-978-45', 'Versa', 10, to_date('26-03-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (150, '09-739-22', 'GranSport', 6, to_date('11-11-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (151, '45-657-41', 'Golf', 4, to_date('21-11-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (152, '76-307-31', 'Tacoma Xtra', 6, to_date('02-07-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (153, '87-956-66', 'Countryman', 9, to_date('27-06-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (154, '73-197-16', 'Villager', 2, to_date('12-02-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (155, '73-628-96', 'Tredia', 9, to_date('05-09-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (156, '78-823-23', 'Riviera', 5, to_date('23-07-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (157, '82-250-84', 'S60', 3, to_date('06-11-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (158, '09-715-90', 'Rally Wagon 1500', 8, to_date('24-03-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (159, '90-979-25', 'Ram 1500', 7, to_date('30-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (160, '29-410-59', 'Freestar', 8, to_date('10-05-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (161, '66-471-72', 'A4', 9, to_date('14-11-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (162, '34-134-44', 'Frontier', 4, to_date('27-09-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (163, '20-633-06', 'Xterra', 8, to_date('25-09-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (164, '05-913-28', 'Ram', 5, to_date('09-11-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (165, '20-975-76', 'Miata MX-5', 8, to_date('10-05-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (166, '30-859-93', 'E-Class', 9, to_date('12-08-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (167, '63-526-51', 'Suburban 1500', 8, to_date('29-05-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (168, '40-182-29', 'Safari', 6, to_date('29-10-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (169, '60-657-62', 'XLR', 6, to_date('18-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (170, '77-516-90', 'Corolla', 9, to_date('23-09-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (171, '90-761-51', 'Silverado', 10, to_date('30-06-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (172, '53-727-68', 'XC90', 8, to_date('09-11-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (173, '73-863-98', 'Galant', 6, to_date('26-11-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (174, '43-247-00', 'Swift', 7, to_date('19-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (175, '07-689-48', 'Caravan', 10, to_date('17-10-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (176, '63-616-86', '5 Series', 7, to_date('14-06-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (177, '62-718-12', 'Echo', 7, to_date('24-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (178, '64-378-20', 'Escalade EXT', 10, to_date('10-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (179, '27-941-88', 'Tiguan', 4, to_date('23-05-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (180, '77-337-66', 'S80', 6, to_date('11-05-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (181, '14-477-59', 'Azera', 8, to_date('01-08-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (182, '36-475-52', 'Accent', 4, to_date('27-01-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (183, '78-599-51', 'Corvette', 2, to_date('16-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (184, '58-987-08', 'Grand Cherokee', 5, to_date('16-08-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (185, '06-014-41', 'Tacoma Xtra', 6, to_date('12-09-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (186, '36-761-85', 'DeVille', 5, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (187, '99-486-88', 'F150', 2, to_date('05-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (188, '17-409-77', 'F250', 7, to_date('07-11-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (189, '13-774-91', 'Corvette', 6, to_date('22-09-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (190, '49-702-51', 'Diablo', 4, to_date('07-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (191, '94-849-72', '500SEL', 8, to_date('13-02-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (192, '61-033-08', 'Maxima', 4, to_date('12-06-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (193, '99-841-22', 'Jetta', 6, to_date('21-11-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (194, '57-861-91', 'Savana 1500', 6, to_date('02-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (195, '32-046-27', 'Town & Country', 10, to_date('14-03-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (196, '29-092-24', 'Commander', 3, to_date('24-07-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (197, '59-765-45', 'Escalade', 10, to_date('26-01-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (198, '06-894-17', 'Firefly', 7, to_date('18-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (199, '78-767-25', '164', 6, to_date('03-04-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (200, '42-228-42', 'SLK-Class', 5, to_date('19-01-2022', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (201, '14-118-40', 'Express 2500', 7, to_date('30-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (202, '25-766-91', '929', 7, to_date('19-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (203, '11-412-47', 'Range Rover Sport', 8, to_date('18-10-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (204, '14-490-95', 'Savana', 2, to_date('23-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (205, '83-970-62', 'Passport', 6, to_date('14-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (206, '38-104-50', 'IS', 8, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (207, '58-522-28', '6000', 4, to_date('12-05-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (208, '15-146-09', 'Expedition EL', 9, to_date('02-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (209, '70-553-97', '62', 7, to_date('16-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (210, '45-552-86', 'GTI', 2, to_date('14-02-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (211, '00-897-59', 'G-Series 1500', 5, to_date('21-12-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (212, '14-387-25', 'CL-Class', 6, to_date('11-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (213, '70-783-97', 'Elantra', 3, to_date('07-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (214, '22-204-11', 'Pajero', 10, to_date('06-08-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (215, '27-395-95', 'S60', 4, to_date('28-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (216, '49-691-93', 'Avalanche 1500', 3, to_date('13-09-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (217, '63-227-27', 'Murano', 2, to_date('04-09-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (218, '94-041-04', 'B-Series Plus', 5, to_date('25-04-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (219, '81-333-37', 'Cayman', 6, to_date('26-11-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (220, '95-000-09', 'LX', 4, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (221, '45-005-29', '3 Series', 7, to_date('25-06-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (222, '81-433-07', 'Grand Cherokee', 9, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (223, '19-298-27', 'Nubira', 3, to_date('09-08-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (224, '48-044-20', 'Pajero', 5, to_date('30-10-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (225, '11-422-57', 'Topaz', 5, to_date('09-04-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (226, '93-546-88', 'Boxster', 4, to_date('09-02-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (227, '20-833-83', 'H1', 9, to_date('27-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (228, '04-477-33', 'Corolla', 4, to_date('20-02-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (229, '49-053-24', 'Corolla', 3, to_date('14-08-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (230, '47-972-29', 'DeVille', 10, to_date('24-02-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (231, '08-756-05', 'Suburban 2500', 4, to_date('01-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (232, '47-133-52', 'Sentra', 10, to_date('10-06-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (233, '76-265-81', 'GTI', 8, to_date('13-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (234, '13-280-66', 'M-Class', 9, to_date('05-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (235, '14-724-37', '911', 5, to_date('26-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (236, '76-659-24', 'Silverado', 5, to_date('06-11-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (237, '84-328-24', 'RX', 8, to_date('19-09-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (238, '69-239-29', '7 Series', 8, to_date('22-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (239, '11-311-43', 'Suburban 2500', 7, to_date('10-03-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (240, '58-232-99', 'Equinox', 7, to_date('23-07-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (241, '44-920-14', 'Cube', 7, to_date('25-09-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (242, '45-008-68', 'Challenger', 5, to_date('11-07-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (243, '06-884-85', 'Panamera', 6, to_date('12-02-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (244, '55-454-80', 'S-Class', 3, to_date('31-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (245, '82-479-39', 'Golf', 10, to_date('30-03-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (246, '17-429-94', 'Range Rover', 7, to_date('15-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (247, '82-462-03', 'Grand Am', 10, to_date('16-08-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (248, '85-189-40', 'Aveo', 6, to_date('05-03-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (249, '66-306-65', 'Xterra', 9, to_date('13-06-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (250, '88-567-66', 'Explorer', 5, to_date('05-04-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (251, '35-867-23', 'G6', 8, to_date('08-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (252, '59-426-68', 'Colt', 3, to_date('06-12-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (253, '47-112-14', 'Outlander', 8, to_date('07-03-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (254, '59-331-98', 'Daewoo Magnus', 4, to_date('23-02-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (255, '49-561-28', 'Azera', 8, to_date('15-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (256, '96-940-56', 'F150', 8, to_date('01-06-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (257, '37-336-97', 'Montana', 7, to_date('16-07-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (258, '50-506-15', 'Esperante', 8, to_date('27-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (259, '15-245-99', 'VUE', 5, to_date('26-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (260, '19-832-97', 'Econoline E250', 4, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (261, '73-721-82', '5 Series', 2, to_date('12-10-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (262, '75-479-41', 'F-Series', 9, to_date('11-03-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (263, '72-475-84', 'Precis', 7, to_date('11-08-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (264, '42-322-70', 'Pajero', 7, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (265, '23-023-14', 'GS', 2, to_date('05-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (266, '55-661-59', 'E250', 6, to_date('10-09-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (267, '08-789-43', 'Thunderbird', 3, to_date('05-11-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (268, '33-045-86', 'Golf', 9, to_date('15-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (269, '82-950-43', 'RS 6', 6, to_date('23-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (270, '71-984-73', '4Runner', 8, to_date('24-12-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (271, '90-708-67', 'Grand Voyager', 2, to_date('13-05-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (272, '13-189-61', 'Accord', 5, to_date('30-06-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (273, '12-980-28', 'Bravada', 5, to_date('02-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (274, '38-145-29', 'Rally Wagon 1500', 7, to_date('23-10-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (275, '23-489-03', 'Explorer', 5, to_date('22-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (276, '04-490-23', 'F250', 7, to_date('14-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (277, '00-314-56', '500SEL', 3, to_date('13-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (278, '95-347-01', 'XLR', 8, to_date('05-08-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (279, '86-937-98', 'A8', 8, to_date('09-07-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (280, '89-929-37', 'Santa Fe', 5, to_date('07-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (281, '71-114-66', 'Sable', 4, to_date('02-02-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (282, '58-027-73', 'Escort', 3, to_date('31-12-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (283, '05-378-24', 'GT-R', 8, to_date('15-07-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (284, '95-010-92', 'Sorento', 2, to_date('26-04-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (285, '69-090-90', 'Expedition EL', 6, to_date('17-12-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (286, '48-115-98', 'Silverado 3500', 4, to_date('20-02-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (287, '14-381-47', 'Tredia', 8, to_date('16-04-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (288, '35-700-27', 'Regal', 8, to_date('07-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (289, '41-622-46', 'D350', 9, to_date('14-07-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (290, '39-407-04', 'Park Avenue', 3, to_date('16-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (291, '82-692-73', 'Compass', 5, to_date('21-03-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (292, '86-824-64', 'Econoline E250', 6, to_date('16-11-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (293, '59-341-13', 'Reatta', 7, to_date('19-04-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (294, '85-792-73', 'LeSabre', 3, to_date('24-06-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (295, '79-777-81', 'TT', 7, to_date('07-07-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (296, '32-922-01', 'Safari', 8, to_date('22-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (297, '85-352-40', 'Altima', 2, to_date('19-07-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (298, '34-698-15', 'B2600', 3, to_date('10-03-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (299, '43-759-25', 'Capri', 5, to_date('14-02-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (300, '27-656-22', 'Bronco', 2, to_date('10-04-2024', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (301, '06-631-20', 'Prius', 4, to_date('03-02-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (302, '16-752-34', 'Grand Prix', 9, to_date('13-12-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (303, '58-728-13', '3 Series', 2, to_date('27-10-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (304, '24-816-61', 'Town Car', 8, to_date('06-02-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (305, '84-093-62', 'S40', 9, to_date('18-09-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (306, '11-650-87', 'Mirage', 10, to_date('15-06-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (307, '57-400-63', 'C70', 3, to_date('10-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (308, '47-180-49', 'S-Class', 7, to_date('10-05-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (309, '28-232-47', 'LeMans', 10, to_date('24-04-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (310, '33-611-38', 'GTI', 5, to_date('08-12-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (311, '77-838-03', 'Cougar', 10, to_date('12-08-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (312, '20-247-54', 'Sable', 6, to_date('11-03-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (313, '19-806-35', 'Sierra Denali', 8, to_date('23-06-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (314, '67-749-35', '929', 3, to_date('14-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (315, '29-493-63', 'Z3', 8, to_date('11-01-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (316, '56-200-95', 'Silverado 3500', 3, to_date('22-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (317, '90-921-77', 'Trooper', 9, to_date('08-11-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (318, '87-820-28', 'Laser', 6, to_date('17-05-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (319, '07-141-21', 'Mazda3', 3, to_date('22-07-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (320, '67-892-32', 'Versa', 2, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (321, '41-523-11', 'Avenger', 3, to_date('28-04-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (322, '62-069-22', 'Liberty', 4, to_date('10-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (323, '27-315-58', 'SL-Class', 8, to_date('28-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (324, '42-608-04', 'Justy', 3, to_date('15-09-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (325, '07-003-86', 'Truck Xtracab SR5', 9, to_date('12-11-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (326, '06-157-49', 'Diamante', 9, to_date('26-03-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (327, '03-255-50', 'Yaris', 3, to_date('19-10-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (328, '92-114-93', 'Jetta', 3, to_date('25-12-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (329, '75-851-91', '6 Series', 7, to_date('11-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (330, '91-910-56', 'Hombre', 3, to_date('17-10-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (331, '13-555-77', 'Corvette', 4, to_date('31-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (332, '24-748-84', 'Avenger', 9, to_date('26-03-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (333, '74-794-95', 'GTI', 4, to_date('21-03-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (334, '36-388-53', 'S10', 4, to_date('05-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (335, '02-808-33', 'Lancer', 5, to_date('19-11-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (336, '61-868-09', 'Zephyr', 8, to_date('04-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (337, '66-801-83', 'Stealth', 4, to_date('15-12-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (338, '98-608-76', 'S-Class', 5, to_date('20-11-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (339, '48-295-22', 'Silhouette', 7, to_date('26-03-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (340, '46-760-80', 'SL65 AMG', 2, to_date('19-06-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (341, '65-340-86', 'Gallardo', 9, to_date('25-01-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (342, '88-669-79', 'C-Class', 3, to_date('26-12-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (343, '37-075-62', 'B2600', 10, to_date('11-01-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (344, '88-460-66', 'Z4 M', 6, to_date('22-05-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (345, '66-389-27', 'Range Rover', 5, to_date('22-02-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (346, '03-152-26', 'SRX', 6, to_date('30-01-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (347, '42-722-46', 'RX', 3, to_date('08-04-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (348, '00-590-25', 'xB', 3, to_date('23-06-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (349, '80-382-30', 'Quest', 6, to_date('22-02-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (350, '79-153-82', 'Corvette', 2, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (351, '50-017-03', 'VUE', 7, to_date('28-02-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (352, '98-412-94', 'Grand Marquis', 10, to_date('16-05-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (353, '28-097-65', 'Suburban 1500', 5, to_date('01-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (354, '87-356-59', 'Armada', 8, to_date('07-02-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (355, '19-764-36', 'Armada', 2, to_date('30-03-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (356, '16-156-70', 'Armada', 8, to_date('04-07-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (357, '49-645-74', 'Sephia', 2, to_date('22-10-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (358, '39-793-10', 'Sky', 10, to_date('17-07-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (359, '42-577-10', 'SLR McLaren', 2, to_date('26-03-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (360, '04-938-00', 'Eclipse', 2, to_date('13-04-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (361, '58-976-56', 'Sierra 2500', 3, to_date('19-11-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (362, '59-708-87', 'Z3', 6, to_date('16-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (363, '09-217-57', 'B-Series', 7, to_date('04-03-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (364, '70-771-27', 'Sequoia', 3, to_date('26-03-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (365, '88-212-94', 'SLK-Class', 6, to_date('02-01-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (366, '71-871-87', 'Montero', 2, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (367, '96-393-13', 'LeMans', 6, to_date('24-07-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (368, '77-687-06', 'Accord', 2, to_date('08-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (369, '35-388-89', 'XL-7', 6, to_date('23-03-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (370, '31-770-23', 'Town & Country', 8, to_date('05-12-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (371, '25-521-87', 'Tiguan', 9, to_date('12-09-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (372, '16-730-76', 'Econoline E250', 3, to_date('07-10-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (373, '83-878-32', '100', 2, to_date('19-05-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (374, '34-020-82', 'Sebring', 5, to_date('15-09-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (375, '92-386-05', 'GT-R', 2, to_date('24-06-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (376, '76-481-96', 'Terraza', 2, to_date('30-05-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (377, '59-861-25', 'Escalade', 6, to_date('02-07-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (378, '33-813-11', '9000', 4, to_date('24-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (379, '46-342-40', 'Cayenne', 4, to_date('27-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (380, '61-310-28', 'Town Car', 10, to_date('28-03-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (381, '66-137-72', 'T100', 5, to_date('20-06-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (382, '40-869-56', '900', 4, to_date('08-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (383, '74-515-86', 'E-Class', 8, to_date('07-04-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (384, '72-150-04', 'E-Series', 2, to_date('02-09-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (385, '57-656-68', 'Touareg', 10, to_date('26-11-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (386, '86-450-87', 'Supra', 5, to_date('07-05-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (387, '08-786-46', 'xB', 4, to_date('06-08-2020', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (388, '88-286-47', 'Grand Am', 5, to_date('15-08-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (389, '62-290-99', 'Jetta', 4, to_date('14-11-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (390, '11-217-17', 'Suburban 2500', 3, to_date('07-02-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (391, '57-620-22', 'QX', 7, to_date('26-07-2017', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (392, '14-895-54', 'A4', 5, to_date('27-01-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (393, '62-528-82', 'GTI', 4, to_date('05-06-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (394, '11-829-54', 'Town & Country', 8, to_date('03-09-2022', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (395, '09-528-86', 'Cherokee', 10, to_date('06-02-2024', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (396, '35-019-58', 'Navigator', 7, to_date('31-07-2019', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (397, '02-922-35', 'Z3', 4, to_date('24-10-2023', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (398, '23-737-10', 'Catera', 2, to_date('24-10-2021', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (399, '47-574-57', 'Tribute', 4, to_date('24-10-2018', 'dd-mm-yyyy'));
insert into TAXI (taxiid, licenseplate, model, capacity, purchasedate)
values (400, '54-289-28', 'PT Cruiser', 2, to_date('16-10-2017', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading DRIVESINTAXI...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (348, 178, '6:17:08', '3:59:11', 'Satte');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (314, 390, '15:47:00', '14:06:23', 'Si Wilai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (374, 364, '5:02:56', '8:07:21', 'Biting');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (100, 110, '15:51:51', '14:42:33', 'WyszogrÃƒÂ³d');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (243, 295, '6:44:49', '17:07:51', 'San MartÃƒÂ­n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (26, 289, '13:34:19', '7:25:19', 'Ponta PorÃƒÂ£');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (150, 259, '11:45:31', '8:13:38', 'Diofior');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (217, 272, '0:11:46', '22:39:03', 'Yejia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (326, 196, '10:41:07', '18:16:10', 'Balut');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (93, 32, '0:54:37', '23:40:57', 'PanÃƒÂ³rama');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (78, 86, '12:33:17', '17:45:10', 'Ã¡Â¸Â¨adÃ„Â«dah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (253, 103, '7:29:07', '7:48:56', 'Kroonstad');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 374, '2:28:37', '20:26:43', 'MatÃƒÂ£o');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (400, 359, '17:32:45', '9:35:19', 'Socos');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (386, 76, '9:46:01', '8:27:29', 'Ipoh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (46, 39, '20:14:14', '0:23:21', 'El Corpus');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (215, 284, '23:53:15', '13:57:17', 'Musanze');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (221, 385, '7:24:05', '3:18:07', 'Anren');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (185, 392, '15:33:18', '0:47:47', 'Sardasht');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (378, 134, '23:20:01', '18:46:49', 'Belung Satu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (351, 326, '11:31:08', '11:01:36', 'Bryukhovychi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (267, 22, '12:10:49', '5:24:34', 'Moshkovo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (133, 271, '9:59:14', '10:47:04', 'Jami');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 304, '11:10:08', '23:20:50', 'Emiliano Zapata');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (89, 31, '19:37:51', '20:37:11', 'Abucayan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (159, 263, '12:47:09', '12:00:00', 'Muyi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (376, 142, '5:49:58', '4:13:40', 'Janakkala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (33, 221, '12:57:21', '16:17:36', 'Argel');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (213, 377, '6:38:04', '13:04:32', 'Sainte-Luce-sur-Loire');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (27, 400, '11:43:28', '7:13:31', 'Villa Allende');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (95, 352, '17:25:56', '14:33:15', 'Huayuan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (173, 150, '20:54:30', '17:48:43', 'Churubamba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (59, 150, '12:12:15', '22:31:00', 'Mayskiy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (370, 27, '6:37:11', '11:51:52', 'Deba Habe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (326, 38, '12:17:30', '11:49:15', 'Uppsala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (165, 130, '10:36:15', '23:00:02', 'KÃƒÂ¶ping');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (393, 287, '17:38:45', '9:23:35', 'Arapuey');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (315, 216, '9:28:50', '0:08:23', 'ArrapÃ¢â‚¬â„¢i');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (169, 180, '4:12:24', '6:58:49', 'Portland');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (5, 252, '17:52:07', '14:54:04', 'SolÃ¢â‚¬â„¢tsy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (240, 121, '16:10:40', '23:08:40', 'Pinamalayan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (188, 66, '21:59:21', '22:23:27', 'Nampera');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (371, 279, '3:12:09', '11:41:22', 'Changliu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (27, 246, '18:44:33', '4:53:39', 'Lazaro Cardenas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (204, 370, '2:54:45', '12:50:42', 'Veinticinco de Mayo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (88, 70, '6:49:50', '17:55:54', 'Balitai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (197, 200, '13:43:18', '20:32:21', 'Zavetnoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (332, 289, '5:06:10', '11:43:59', 'Neya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (208, 132, '7:20:36', '19:27:23', 'Quatre Bornes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (55, 128, '12:55:54', '23:05:01', 'Mikhaylovskoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (370, 144, '13:22:26', '7:53:08', 'Murtajih');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (41, 26, '16:32:47', '19:32:24', 'Espanola');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (69, 78, '22:45:16', '16:15:49', 'Lucheng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (209, 200, '12:01:44', '12:50:39', 'Gedongmulyo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (307, 267, '21:39:01', '17:39:36', 'Stare Pole');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (398, 19, '3:18:04', '22:09:25', 'Ja Ela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (115, 58, '4:19:47', '15:57:37', 'Canmore');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (68, 307, '14:54:16', '13:08:57', 'Mogzon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (273, 220, '8:19:42', '4:22:15', 'Bagnolet');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (327, 280, '7:44:12', '18:50:28', 'Lela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (185, 49, '7:28:05', '14:26:02', 'Aroroy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (305, 159, '14:42:47', '17:15:48', 'Lesnoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (137, 221, '20:42:19', '5:53:02', 'Penza');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 96, '10:32:55', '18:50:24', 'Mino');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (244, 315, '7:55:13', '10:04:07', 'Jelisavac');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (281, 289, '22:12:44', '3:49:22', 'Janes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (138, 42, '3:38:44', '18:00:35', 'Sukadana');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (66, 362, '7:41:49', '16:07:57', 'Helong');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (396, 4, '18:29:53', '19:18:27', 'Lumbatan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (231, 337, '11:07:28', '2:29:32', 'Almelo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (363, 287, '1:23:20', '9:26:31', 'Pines');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (209, 96, '18:44:46', '0:40:16', 'Ampahana');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (144, 75, '11:51:48', '1:28:19', 'Qingu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (290, 200, '7:51:42', '5:02:19', 'Jinnan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (385, 16, '13:38:29', '14:42:07', 'Richmond');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (123, 9, '4:51:59', '21:26:59', 'Purwojoyo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 79, '18:09:02', '4:13:02', 'Brgy. Nalook, kalibo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (200, 350, '12:26:33', '5:34:59', 'Padova');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (238, 107, '21:35:25', '21:47:51', 'Nong Saeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (256, 259, '4:48:13', '19:36:24', 'Al MadÃ„Â«d');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (84, 165, '10:03:22', '12:20:25', 'Yuyang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (66, 327, '23:43:48', '3:59:42', 'Hohhot');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (33, 365, '12:35:31', '2:57:59', 'Quebo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (255, 290, '7:58:19', '12:05:15', 'Washington');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (90, 235, '9:37:27', '6:17:14', 'TimrÃƒÂ¥');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (51, 193, '18:40:12', '9:54:25', 'Tuba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (337, 7, '23:01:04', '5:30:37', 'Ãƒâ€°bolowa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (63, 98, '11:51:36', '14:07:52', 'Puncakwangi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (245, 105, '12:10:39', '10:02:23', 'Spas-Klepiki');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (234, 35, '10:58:46', '10:27:36', 'Huazhu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (108, 284, '2:20:05', '11:44:38', 'Jieshipu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (105, 246, '11:48:17', '6:41:19', 'Shangyu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (28, 157, '11:35:56', '17:25:45', 'Sainte-Anne-de-Bellevue');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (325, 387, '19:21:12', '9:58:06', 'Huerta Grande');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (184, 88, '7:28:22', '16:13:24', 'Paris 15');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (26, 112, '21:24:11', '13:28:56', 'Barkly East');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (75, 188, '21:06:16', '2:42:24', 'Novaya Chigla');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (183, 281, '16:40:17', '4:26:22', 'Hexi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (78, 93, '23:40:40', '13:03:47', 'Sindanghayu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (157, 306, '4:17:03', '20:39:55', 'Zhugentan');
commit;
prompt 100 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (173, 306, '5:24:56', '19:54:46', 'Wangjiachang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (105, 180, '1:19:10', '23:42:38', 'ShÃ…Âbu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (396, 184, '1:23:49', '13:00:41', 'Heshi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (72, 42, '18:53:52', '4:04:39', 'Effium');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (179, 75, '1:39:12', '12:12:02', 'San AndrÃƒÂ©s');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (346, 258, '22:36:46', '7:13:34', 'KorisÃƒÂ³s');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (329, 175, '20:16:54', '17:10:24', 'Palca');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (220, 134, '9:45:06', '14:47:23', 'Khuean Ubonrat');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (286, 365, '16:04:45', '5:17:00', 'San Justo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (195, 65, '4:10:59', '14:49:11', 'Longshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (374, 243, '3:14:58', '17:26:40', 'Sukasirna');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (217, 188, '17:43:58', '23:51:20', 'Carlos Casares');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (96, 81, '13:32:14', '10:35:14', 'ButiÃƒÂ¡');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (2, 350, '2:29:09', '23:53:44', 'ÃƒÂgua de Pau');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (382, 55, '21:04:06', '22:23:09', 'BerlÃƒÂ­n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (268, 321, '15:17:48', '22:39:53', 'Orivesi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (101, 237, '10:01:02', '17:28:44', 'Changle');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (93, 316, '18:09:07', '18:08:41', 'Orikum');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (130, 52, '9:40:51', '20:03:36', 'Shibetsu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (284, 395, '18:02:21', '6:57:45', 'Francos');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (299, 337, '0:21:42', '5:01:07', 'Sanyantang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (310, 340, '0:51:46', '16:01:49', 'Dmitriyevskaya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (176, 151, '9:51:34', '20:18:20', 'Muaratiga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (81, 48, '11:30:30', '8:12:08', 'Bourgoin-Jallieu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (249, 98, '2:57:34', '3:17:04', 'Changtu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (224, 83, '12:11:35', '3:36:36', 'Nkhotakota');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (355, 270, '6:14:09', '2:07:28', 'ConceiÃƒÂ§ÃƒÂ£o da Barra');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (323, 368, '12:52:32', '10:48:03', 'Turku');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (127, 224, '18:33:49', '23:27:30', 'Cizhu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (248, 122, '17:43:26', '15:37:41', 'Ã…ÂÃ„â€¦ck');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (80, 53, '19:11:44', '12:16:08', 'ZÃ„ÂkhÃ…Â«');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (90, 198, '4:15:51', '11:46:57', 'Ban Tak');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (370, 18, '12:26:50', '1:45:32', 'Sheksna');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (84, 326, '19:45:00', '7:12:13', 'Ã„â‚¬dam');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (89, 43, '10:19:53', '18:54:31', 'Altamira');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (334, 276, '21:28:43', '2:56:34', 'Manning');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (175, 66, '2:51:03', '5:21:43', 'Votkinsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (289, 358, '7:20:34', '8:02:49', 'Cruzeiro');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (21, 90, '3:17:06', '4:36:31', 'MÃƒÂ¶nhbulag');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (10, 342, '4:57:36', '17:30:58', 'Valle de La Pascua');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (267, 17, '4:03:31', '3:45:38', 'Pujijie');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (335, 220, '13:31:39', '5:09:38', 'Soeng Sang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (197, 164, '2:48:26', '10:55:34', 'Masaran');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (161, 362, '3:31:31', '13:28:02', 'Bizana');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (75, 341, '12:17:28', '3:47:06', 'Changning');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (150, 185, '5:42:45', '7:17:23', 'Xiaopu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (349, 353, '1:07:22', '15:14:53', 'AtÃƒÂ£es');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (27, 295, '12:53:10', '15:03:38', 'Pitkyaranta');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (219, 176, '20:32:41', '17:34:54', 'Quatro Barras');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (185, 308, '9:57:55', '3:28:45', 'RÃƒÂ­o Segundo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (9, 62, '9:24:32', '13:17:54', 'Komi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (129, 281, '0:10:21', '22:15:11', 'Monte Plata');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (190, 316, '20:40:36', '20:45:19', 'Jinshiqiao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (129, 110, '1:12:31', '19:09:20', 'Renchaoxi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (105, 162, '8:07:18', '16:08:21', 'Thung Yang Daeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (396, 181, '7:25:28', '5:47:20', 'Luoxi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (201, 113, '15:54:04', '10:48:26', 'Klina');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (160, 208, '10:40:17', '21:02:24', 'Badajoz');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (350, 379, '20:48:50', '3:53:23', 'Itaocara');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (316, 173, '18:27:57', '22:25:29', 'Wangying');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (255, 76, '9:28:31', '0:31:25', 'Tongqian');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (382, 323, '7:37:25', '21:06:09', 'BiryulÃƒÂ«vo Zapadnoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (26, 400, '5:11:43', '1:28:59', 'Bolboc');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (347, 283, '14:13:19', '5:26:27', 'Mohammedia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (248, 220, '15:07:24', '18:58:55', 'Hepang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (16, 222, '9:34:12', '23:25:03', 'Douala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (369, 163, '8:27:23', '2:13:38', 'Pinar del RÃƒÂ­o');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (74, 369, '22:53:43', '2:05:38', 'Hidalgo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (397, 119, '5:26:02', '6:05:06', 'Indralayang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (331, 58, '2:12:33', '10:52:35', 'Callao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (246, 44, '2:27:01', '15:26:21', 'Ã¢â‚¬ËœIzbat al Burj');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (391, 375, '6:44:41', '0:05:12', 'Bakovci');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (309, 45, '18:34:34', '20:36:22', 'Ipoh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (281, 287, '4:00:44', '2:33:34', 'Dedza');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (301, 114, '11:05:48', '17:33:00', 'KÃ¢â‚¬â„¢anakÃ¢â‚¬â„¢erravan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (243, 292, '0:19:08', '0:03:47', 'Bukowina TatrzaÃ…â€žska');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (388, 374, '22:16:12', '7:44:12', 'Wellington');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (180, 74, '3:23:30', '0:53:20', 'Jiangcheng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (309, 90, '19:13:51', '4:14:06', 'Roi Et');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (107, 128, '8:33:52', '6:24:38', 'Des Moines');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (216, 157, '22:40:27', '0:21:18', 'Bello');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (336, 187, '11:48:15', '0:50:52', 'GuantÃƒÂ¡namo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (324, 263, '7:26:12', '12:10:48', 'Chunhu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 19, '14:02:38', '0:22:01', 'Jiakexi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (242, 304, '18:38:12', '14:22:57', 'TÃƒÂµrva');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (111, 272, '14:13:05', '4:21:17', 'Ã¡Â¸Â¨alÃ¡Â¸Â©Ã…Â«l');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (384, 354, '13:08:58', '3:26:16', 'Mariatana');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (327, 177, '6:38:16', '6:59:10', 'MuzayriÃ¢â‚¬Ëœ');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (291, 320, '17:40:56', '19:06:51', 'Kajuru');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (68, 20, '2:39:31', '20:39:52', 'Colonia Mauricio JosÃƒÂ© Troche');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (148, 58, '22:05:20', '16:51:28', 'Jingyang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (262, 324, '13:28:13', '5:49:42', 'Bonao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (340, 201, '12:56:32', '3:49:29', 'Anyu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (354, 270, '14:46:39', '10:29:46', 'Wufeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (126, 88, '5:32:51', '17:05:12', 'KomsomolÃ¢â‚¬â„¢skiy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (147, 304, '3:52:03', '11:16:39', 'Terara');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (279, 370, '10:16:06', '11:47:10', 'Tabivere');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (284, 116, '15:36:32', '17:23:47', 'Costa Nova do Prado');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (243, 14, '7:44:55', '10:11:33', 'Roberval');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (61, 231, '10:17:41', '23:17:01', 'LabÃƒÂ©');
commit;
prompt 200 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (375, 89, '16:11:53', '19:10:56', 'VÃƒÂ¤nersborg');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (367, 400, '23:12:18', '7:27:18', 'Hatton');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (343, 326, '1:39:30', '4:02:30', 'Nanhe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (234, 386, '19:03:02', '15:59:27', 'Okpoga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (247, 63, '10:14:26', '2:26:09', 'Marataizes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (288, 57, '16:46:45', '20:26:16', 'Amirdzhan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (166, 182, '2:24:55', '17:54:51', 'Jintao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (108, 315, '6:00:02', '17:14:21', 'Baunu-Timbangan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (350, 226, '2:09:18', '16:13:38', 'ChervonopartyzansÃ¢â‚¬â„¢k');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (66, 330, '20:08:16', '6:56:00', 'Obiliq');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (324, 169, '6:20:06', '21:19:50', 'Cuauhtemoc');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (116, 135, '19:51:05', '13:54:03', 'Dongshe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (378, 296, '6:50:16', '6:22:17', 'MorÃƒÂ³n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (49, 53, '13:21:07', '17:58:43', 'Nossa Senhora da GlÃƒÂ³ria');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (326, 104, '19:33:27', '20:21:02', 'Rabat');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (399, 169, '21:40:12', '4:21:37', 'Yunmeng Chengguanzhen');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (303, 373, '3:06:34', '2:39:33', 'Mababanaba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (105, 25, '4:48:05', '13:25:35', 'Betafo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (373, 360, '12:49:54', '7:45:30', 'Utrecht (stad)');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (334, 246, '14:25:52', '4:58:21', 'Peishe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (233, 239, '4:08:08', '18:38:27', '5 de Mayo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 117, '1:27:45', '8:25:33', 'Svetlyy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (100, 246, '22:17:41', '3:44:59', 'Obsharovka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (182, 239, '0:38:58', '19:55:13', 'Gagarawa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (64, 363, '9:21:37', '0:22:09', 'Port-Gentil');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (171, 339, '17:51:34', '0:02:52', 'Madrid');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (181, 93, '15:23:16', '0:11:47', 'Wiphawadi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 361, '6:46:49', '23:10:10', 'Klapagading');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (322, 208, '0:05:51', '20:46:09', 'Konde');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (208, 112, '20:49:02', '14:46:18', 'SincÃƒÂ©');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (277, 229, '21:22:51', '16:45:20', 'Chanuman');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (372, 365, '2:04:21', '16:23:38', 'Chiduo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (139, 92, '6:30:34', '16:52:03', 'Lyon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (54, 361, '4:02:48', '1:38:11', 'Lazaro Cardenas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (178, 95, '1:59:55', '7:36:55', 'Mondlo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (173, 244, '1:01:47', '2:01:55', 'Danjiangkou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (199, 135, '10:20:20', '1:05:21', 'Burgas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (182, 389, '14:53:50', '6:39:12', 'Situ');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (193, 13, '10:37:44', '6:04:06', 'Karangsonojabon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (186, 343, '15:38:20', '6:12:49', 'Valongo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (57, 246, '22:08:40', '14:03:20', 'Kushikino');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (84, 212, '16:00:03', '14:04:23', 'Santa BÃƒÂ¡rbara');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (55, 286, '5:22:41', '5:19:22', 'Tomohon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (318, 197, '18:25:00', '2:15:46', 'Buenlag');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (207, 2, '1:01:00', '16:58:04', 'Pitangueiras');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (135, 216, '16:45:15', '13:10:54', 'Gualaceo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (334, 130, '7:10:00', '20:17:02', 'KrzeczÃƒÂ³w');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (372, 305, '2:45:13', '5:52:05', 'Sedati');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (348, 13, '7:08:54', '20:04:11', 'Baolong');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (386, 130, '8:53:47', '18:34:50', 'Guinabsan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (291, 51, '13:43:13', '3:15:25', 'Masachapa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (23, 4, '22:57:34', '3:04:20', 'Beoga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (309, 275, '11:41:15', '21:33:46', 'Guangping');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (280, 389, '22:40:04', '2:27:38', 'Qiaotou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (290, 394, '2:42:59', '3:57:16', 'Patalan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (103, 34, '4:18:16', '7:02:27', 'CaÃƒÂ§apava');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (342, 394, '9:39:24', '0:23:08', 'Hongshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (223, 116, '7:11:14', '3:40:10', 'Ouahigouya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (179, 138, '11:13:27', '15:45:54', 'Cluain Meala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (77, 52, '22:36:25', '6:34:32', 'Huanghu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (238, 60, '15:19:17', '11:00:54', 'Baton Rouge');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (306, 196, '4:04:25', '17:15:56', 'Bakersfield');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (142, 108, '19:08:20', '8:00:05', 'Portela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (289, 33, '2:32:05', '9:19:12', 'Punta Gorda');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (18, 387, '18:40:32', '17:39:23', 'La Cuesta');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (191, 22, '13:55:19', '11:35:47', 'Sundsvall');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (263, 269, '23:40:39', '11:36:35', 'Bantengan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (108, 46, '7:03:27', '0:00:36', 'Torsby');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (148, 93, '6:28:22', '16:05:06', 'Jasieniec');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (392, 223, '23:58:25', '11:02:35', 'Tuanshansi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (305, 69, '16:00:19', '12:37:42', 'Itaparica');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (367, 262, '8:02:04', '15:56:04', 'Kos');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (290, 145, '0:57:07', '19:43:51', 'Bromma');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (138, 65, '18:14:31', '2:38:11', 'Sardasht');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (107, 275, '5:54:40', '17:20:10', 'Chadong');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (168, 135, '12:20:55', '15:11:06', 'Saint-Pierre-des-Corps');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (161, 226, '1:38:25', '17:53:47', 'VÃƒÂ¤llingby');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (341, 69, '1:44:16', '23:49:23', 'Leixlip');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (180, 155, '7:46:28', '12:50:23', 'Ximei');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (174, 182, '4:39:53', '23:21:27', 'BisÃƒÂ©e');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (170, 32, '1:33:30', '7:00:55', 'Khelyulya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (174, 379, '21:14:16', '15:48:08', 'Sinmak');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (3, 311, '11:52:06', '22:04:09', 'Povarovo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (359, 36, '21:08:03', '20:35:04', 'Yingyang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (273, 82, '21:54:33', '22:39:39', 'Salvacion');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (170, 315, '19:08:52', '23:37:05', 'Swinford');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (255, 195, '0:35:45', '17:27:29', 'Sedatigede');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (57, 242, '17:47:56', '19:26:13', 'Opatowiec');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 218, '12:46:12', '8:14:35', 'Moate');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (324, 294, '8:25:43', '4:12:10', 'Mori');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (349, 14, '10:03:00', '22:40:16', 'Gaoshi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (276, 245, '8:31:21', '10:08:32', 'Cumanacoa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (32, 44, '18:58:31', '20:01:26', 'Lincoln');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (208, 161, '14:34:58', '17:24:58', 'Tokmok');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (11, 143, '8:45:22', '9:58:22', 'Capela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (50, 160, '21:17:42', '14:25:33', 'Sezures');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (250, 63, '12:18:10', '16:13:53', 'Alfenas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (79, 243, '12:42:47', '11:07:25', 'Klimovsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (136, 46, '18:32:10', '4:59:54', 'PÃ„Âbna');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (120, 315, '16:23:06', '17:49:22', 'Duzhenwan');
commit;
prompt 300 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (239, 177, '11:48:14', '15:04:27', 'Loyola');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (133, 212, '15:13:24', '16:27:31', 'BollnÃƒÂ¤s');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (332, 320, '21:28:51', '4:37:46', 'Qijiang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (284, 306, '17:15:36', '1:51:17', 'Vespasiano');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (45, 159, '2:22:09', '3:29:19', 'Kulonkali');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (38, 46, '4:24:14', '13:35:55', 'Lazo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (71, 114, '12:26:44', '21:02:26', 'Higetegera');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (323, 369, '1:27:50', '2:50:01', 'Bang Kruai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 220, '21:57:01', '16:08:52', 'Velikovechnoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (9, 333, '2:16:26', '11:22:55', 'Maloyaroslavets');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (65, 131, '7:06:29', '12:12:07', 'Iralaya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (147, 19, '14:24:50', '7:24:27', 'Taibai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (47, 13, '2:04:34', '1:52:58', 'Makedonski Brod');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (329, 90, '2:13:50', '6:42:05', 'Laurel');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (337, 359, '10:29:20', '6:39:34', 'Mossendjo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (55, 311, '10:43:32', '2:33:16', 'TimashÃƒÂ«vsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (243, 16, '3:46:25', '3:56:15', 'Jiyizhuang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (317, 259, '13:37:12', '22:13:38', 'Mora');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (221, 245, '23:29:01', '16:34:44', 'Utrecht');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (120, 353, '11:05:41', '8:38:03', 'Bebedouro');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (359, 286, '20:16:16', '16:27:03', 'Lacdayan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (226, 332, '7:46:15', '10:01:13', 'Kopral');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (64, 84, '13:46:34', '12:44:58', 'Manyava');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (137, 233, '19:20:24', '12:17:29', 'Alexandria');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (258, 199, '2:11:39', '0:39:46', 'Shalakusha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (113, 56, '18:05:53', '1:36:35', 'NiÃ¢â‚¬â„¢ao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (162, 86, '3:26:27', '10:38:56', 'PyrgetÃƒÂ³s');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (355, 348, '8:16:29', '7:52:47', 'Brongkah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (147, 381, '8:00:32', '21:42:20', 'Tabant');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (76, 17, '5:07:13', '4:24:27', 'Terpinnya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (294, 297, '20:49:29', '19:31:36', 'Xilu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (314, 32, '18:11:10', '15:14:26', 'Lyaskelya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (362, 63, '5:55:53', '7:32:31', 'Futuroscope');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (46, 19, '16:21:05', '4:33:30', 'Bethlehem');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (189, 378, '7:50:36', '6:55:40', 'Salamina');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (256, 277, '13:48:27', '13:02:36', 'Quanzhou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (193, 88, '11:48:40', '22:23:32', 'Wanfu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (55, 278, '19:46:51', '6:50:00', 'Doubrava');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (234, 229, '5:47:28', '19:25:25', 'Xiashitai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 70, '20:53:12', '3:43:30', 'Shixian');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (122, 65, '6:27:58', '13:56:54', 'Remedios');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (365, 142, '18:44:52', '21:46:09', 'At TaÃ¡Â¸Â©Ã„Âlif');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (253, 41, '12:01:28', '6:59:42', 'Mata de SÃƒÂ£o JoÃƒÂ£o');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (251, 82, '23:47:45', '5:35:13', 'Porto Martins');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (39, 141, '11:52:39', '11:37:16', 'Krasnystaw');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (285, 300, '19:51:36', '21:48:38', 'Maindang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (135, 128, '13:46:44', '13:39:07', 'Patapan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (6, 123, '21:14:00', '14:15:37', 'Krajan Ngerdani');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (109, 121, '20:45:45', '5:53:20', 'Shatou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (76, 127, '20:25:06', '19:38:54', 'Baardheere');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (254, 351, '13:53:27', '13:18:37', 'Starobaltachevo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (265, 55, '6:28:20', '18:32:17', 'Bourgoin-Jallieu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (294, 130, '6:11:05', '16:33:48', 'Ngujung');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (258, 340, '19:47:32', '4:01:51', 'Mabini');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (216, 26, '17:53:15', '5:23:01', 'Santa Rosa de Cabal');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (232, 296, '8:48:44', '16:45:25', 'Nyimba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (77, 187, '10:48:32', '3:19:15', 'Serra de Santa Marinha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (305, 28, '7:42:43', '7:42:09', 'Panjiawan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (302, 281, '9:12:31', '3:30:04', 'Phan Thong');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (347, 390, '18:25:49', '12:41:33', 'Domont');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (254, 84, '11:25:52', '23:46:09', 'Zaandam');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (350, 284, '20:57:52', '18:20:20', 'Lamak');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (61, 129, '2:56:28', '2:15:29', 'Blagoveshchensk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (68, 19, '1:12:11', '23:58:39', 'Vitoria-Gasteiz');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (379, 195, '2:00:05', '2:37:53', 'Yaohua');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (5, 373, '17:14:54', '1:25:06', 'Marquard');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (280, 225, '17:14:05', '14:27:03', 'Sangar SarÃ„Ây');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (30, 88, '19:22:33', '17:57:41', 'Marapat');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (389, 143, '0:27:00', '9:33:31', 'Nelidovo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (9, 199, '16:56:06', '3:47:39', 'Kubanskiy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (334, 323, '10:19:53', '17:41:29', 'Tala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (294, 182, '21:36:26', '7:20:21', 'Xiling');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (344, 333, '17:56:20', '18:24:50', 'Oslo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (112, 38, '12:19:26', '4:10:14', 'VÃƒÂ¤sterÃƒÂ¥s');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (198, 49, '22:10:43', '6:13:20', 'Kota Kinabalu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 383, '0:19:46', '7:56:15', 'Kota Kinabalu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (174, 209, '1:28:15', '18:37:41', 'Motala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (119, 304, '9:04:05', '6:14:06', 'Szolnok');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (372, 59, '20:54:56', '22:14:58', 'SÃƒÂ£o Bento');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (379, 249, '3:34:37', '10:03:56', 'San BartolomÃƒÂ© Milpas Altas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (400, 380, '0:06:19', '11:30:04', 'Puerto Cabezas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (267, 192, '10:42:24', '10:27:21', 'Yanhu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (270, 3, '16:09:20', '20:45:53', 'Adjumani');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (135, 159, '20:36:29', '14:00:37', 'San Antonio SuchitepÃƒÂ©quez');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (113, 93, '15:09:37', '0:58:36', 'Lijiaxiang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (154, 129, '3:29:02', '7:19:19', 'Viterbo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (271, 106, '19:53:54', '13:51:11', 'Gaxung');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (147, 20, '17:56:10', '7:45:27', 'Haarlem');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (234, 150, '17:40:08', '0:41:40', 'Dukay');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (375, 363, '9:52:37', '22:00:28', 'Campbellton');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (33, 139, '12:07:56', '8:00:10', 'Laval');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (355, 282, '19:49:51', '13:06:26', 'Toki');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (249, 160, '2:56:32', '7:03:15', 'Staraya Derevnya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (290, 78, '19:36:03', '9:45:51', 'Sindangpanji');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (287, 7, '21:30:57', '9:48:54', 'Boden');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (360, 17, '19:02:10', '22:30:44', 'Bojongsari');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (120, 326, '10:50:00', '17:19:35', 'Santa Catalina');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (245, 16, '22:09:46', '21:02:18', 'Krajan Tengah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (133, 266, '19:11:25', '11:07:29', 'Xiaojing');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (231, 234, '3:42:18', '11:14:37', 'Zebrzydowice');
commit;
prompt 400 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (231, 81, '1:41:22', '10:17:53', 'YaÃ¢â‚¬â„¢ngan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (169, 3, '3:54:56', '0:32:48', 'Ciakar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (393, 258, '23:46:28', '11:22:11', 'Shipu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (143, 374, '10:26:05', '7:58:25', 'Vale de Figueira');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (208, 325, '14:52:04', '22:57:02', 'Tangqian');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (50, 346, '16:42:15', '8:30:53', 'Rantau');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (36, 81, '5:09:19', '1:49:48', 'Vidovci');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (144, 82, '22:18:17', '8:50:09', 'Rosario del Ingre');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (76, 359, '18:51:03', '4:25:31', 'Vallauris');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (373, 272, '22:08:30', '7:59:04', 'Laguilayan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (214, 241, '18:10:54', '6:45:51', 'Jianggao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (339, 210, '14:43:06', '0:59:41', 'Xugu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (101, 258, '4:53:07', '5:30:44', 'Seupakat');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (237, 20, '13:32:25', '4:14:29', 'Pringu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (67, 67, '15:40:46', '8:06:04', 'Barra do PiraÃƒÂ­');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (229, 68, '18:50:34', '11:20:19', 'Xirikxiy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (107, 347, '9:39:18', '15:29:14', 'Mintang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (197, 396, '6:28:43', '0:31:49', 'Pingtang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (239, 259, '18:59:31', '12:38:52', 'ItaberaÃƒÂ­');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (251, 46, '15:24:33', '14:49:14', 'Balkh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (217, 221, '16:13:48', '23:32:00', 'Khlung');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (348, 300, '22:08:02', '14:32:22', 'Divnomorskoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (53, 47, '7:09:43', '9:26:00', 'Alajuela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (376, 73, '7:34:05', '2:35:23', 'Thiers');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (224, 81, '10:59:28', '9:52:26', 'Damao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (238, 318, '5:47:40', '23:22:25', 'Youwei');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (326, 260, '18:17:26', '11:43:10', 'Kupang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 70, '23:11:06', '16:09:36', 'Chapimarca');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (297, 328, '1:54:44', '15:11:03', 'Stupsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (306, 374, '0:15:55', '18:51:03', 'Biyan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (212, 372, '20:18:04', '1:35:56', 'Strzelce KrajeÃ…â€žskie');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (242, 74, '4:36:34', '17:45:22', 'Vyksa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (380, 349, '20:17:12', '1:05:47', 'Santa Teresita');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (19, 367, '6:06:39', '23:23:22', 'Kawage');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (145, 129, '22:41:41', '17:46:00', 'Al MukallÃ„Â');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (363, 74, '21:10:59', '7:03:15', 'VÃƒÂ¡rzea');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (291, 48, '7:28:32', '4:30:36', 'Kuala Lumpur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (332, 125, '3:38:54', '20:08:52', 'SÃ…Â«rak');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (79, 48, '9:00:20', '11:37:54', 'Mtinko');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (31, 298, '19:19:55', '0:34:32', 'SolÃ¢â‚¬â„¢tsy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (251, 277, '23:00:28', '16:24:20', 'Limoeiro de Anadia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (188, 360, '18:45:35', '9:57:25', 'Arauca');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (122, 275, '4:54:33', '15:53:54', 'Saverne');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (392, 49, '5:22:47', '7:55:12', 'Bethlehem');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (167, 389, '8:55:08', '5:26:09', 'Kurashiki');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 377, '16:22:11', '1:18:05', 'Zabukovica');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (29, 243, '11:59:03', '11:59:30', 'Pittsburgh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 390, '21:14:50', '22:52:18', 'Mons');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (117, 215, '0:38:00', '18:15:45', 'Pilar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (9, 143, '22:29:42', '8:55:13', 'Coari');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (367, 322, '14:30:53', '5:06:59', 'Nansheng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (132, 98, '14:12:17', '18:57:50', 'Pitogo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (113, 36, '17:40:25', '4:00:52', 'Pordapor Barat');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (351, 144, '9:54:50', '7:23:50', 'Sukolilo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (159, 365, '17:23:33', '12:43:42', 'Montinho');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (313, 86, '11:59:02', '13:10:37', 'Kansas City');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (231, 132, '3:29:46', '14:40:36', 'CaparrapÃƒÂ­');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (57, 293, '1:16:31', '9:33:55', 'Tabou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (400, 168, '23:19:49', '18:43:57', 'Tabant');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (372, 232, '22:22:00', '0:07:19', 'Hamburg');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 69, '11:46:09', '8:44:19', 'Rokiciny');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (123, 211, '10:06:34', '11:21:37', 'Dongtang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (321, 287, '23:45:05', '22:43:13', 'Kotauneng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (54, 394, '9:41:45', '7:24:33', 'Wangzha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (151, 53, '21:57:12', '16:05:34', 'Suwalan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (117, 156, '1:28:50', '1:52:42', 'Nakajah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (156, 60, '9:05:06', '20:59:45', 'Kagadi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (329, 53, '18:58:24', '4:25:08', 'Dongping');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (200, 300, '19:04:16', '7:43:17', 'MazaÃ…â€žcowice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (48, 49, '0:02:53', '12:57:48', 'BaturitÃƒÂ©');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (241, 241, '1:58:07', '4:28:07', 'Zaolin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (156, 328, '20:54:46', '6:30:51', 'Huskvarna');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (250, 232, '2:49:52', '19:10:09', 'Zhoutie');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (232, 354, '22:26:30', '17:56:30', 'Liushutun');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (279, 316, '16:16:33', '14:16:26', 'LaÃ…Â¡ko');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 261, '19:56:55', '22:10:41', 'TobatÃƒÂ­');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (64, 367, '21:10:12', '4:54:23', 'Zilupe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (319, 153, '11:16:33', '13:12:25', 'Komprachcice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (386, 135, '15:28:18', '10:57:31', 'Wuda');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (345, 183, '2:43:01', '16:58:23', 'Erechim');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (92, 97, '21:29:04', '6:09:08', 'Hengdaohezi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (45, 204, '11:14:28', '17:12:37', 'Luwingu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (280, 13, '2:17:18', '5:36:49', 'Paris 19');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (328, 325, '10:16:58', '0:04:03', 'Komyshany');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (262, 117, '21:19:31', '6:57:26', 'Salaspils');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (130, 84, '6:44:04', '2:58:52', 'GardÃ„â€œz');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (360, 208, '3:49:34', '14:59:48', 'Orahovica');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (382, 276, '16:52:32', '6:12:27', 'CÃƒÂ³rdoba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (377, 352, '13:35:40', '3:37:19', 'Penanggapan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (257, 111, '16:20:15', '20:22:41', 'Dubna');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (260, 190, '14:44:05', '11:34:53', 'Dao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (215, 20, '17:27:26', '5:06:20', 'Caitang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (40, 325, '13:14:39', '9:34:41', 'Bangunharja');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (362, 252, '0:52:10', '2:19:58', 'La UniÃƒÂ³n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (116, 217, '20:11:46', '12:03:18', 'Guanshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 96, '20:19:46', '9:21:44', 'Grenoble');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (80, 25, '16:45:42', '3:12:00', 'Kosum Phisai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (109, 362, '1:07:55', '18:52:52', 'Flagstaff');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (49, 149, '23:58:07', '4:39:26', 'Ã¢â‚¬ËœAqrah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (357, 17, '9:45:38', '4:38:38', 'Fayzabad');
commit;
prompt 500 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (324, 34, '22:07:58', '21:51:10', 'Togitsu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (104, 273, '23:28:02', '4:54:57', 'Qinhe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (371, 39, '23:06:40', '8:19:06', 'Khovaling');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (284, 311, '5:48:54', '21:20:12', 'Canggou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (139, 234, '11:22:40', '6:57:16', 'Labuhanlalar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (365, 72, '19:37:58', '10:52:39', 'Tayirove');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (337, 237, '19:54:18', '19:14:45', 'Janeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (156, 220, '7:43:43', '6:58:24', 'KÃƒÂ¸benhavn');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (81, 279, '16:46:33', '22:19:45', 'Budapest');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (54, 363, '11:47:17', '19:19:07', 'Laibin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (385, 131, '4:28:51', '18:51:23', 'Segezha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (317, 252, '8:36:36', '10:52:05', 'Fangfan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (371, 310, '17:29:51', '14:32:01', 'Rajadesa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (243, 20, '19:33:48', '5:15:18', 'Sheshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (252, 134, '10:12:34', '15:27:38', 'Jajar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (233, 189, '2:40:50', '9:26:23', 'Jingouhe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (77, 170, '13:22:47', '2:43:09', 'Toulouse');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (76, 180, '10:18:19', '3:30:46', 'Druzhba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (148, 264, '0:05:15', '17:45:53', 'KÃƒÂ¸benhavn');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (143, 133, '17:02:47', '5:43:51', 'AÃƒÂ§u');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (56, 222, '19:51:12', '22:19:54', 'Damayan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (121, 248, '15:31:25', '5:48:29', 'Bogorame');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (384, 226, '2:28:59', '5:09:42', 'Vyshniy VolochÃƒÂ«k');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (322, 110, '11:50:06', '15:49:54', 'LapinjÃƒÂ¤rvi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (374, 323, '15:08:06', '2:41:47', 'JaguariaÃƒÂ­va');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (218, 246, '1:02:08', '3:48:59', 'Mariental');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (375, 341, '6:47:48', '16:50:39', 'Okinawa NÃƒÂºmero Uno');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (24, 26, '6:44:46', '9:49:57', 'Tigbao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (325, 205, '13:36:00', '2:21:55', 'KoÃ„Âevje');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (173, 157, '10:54:21', '15:27:00', 'Beijiang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (282, 246, '18:41:44', '18:13:57', 'Limbo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (134, 307, '6:27:55', '0:02:02', 'Temeke');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (3, 322, '22:06:23', '10:31:10', 'Xinhuang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (34, 317, '0:31:21', '23:27:50', 'Gaotang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (198, 301, '2:37:56', '3:13:27', 'Amio');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (9, 155, '21:12:45', '8:03:02', 'Malakwal City');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (323, 144, '23:50:45', '21:40:03', 'Zouiat ech CheÃƒÂ¯kh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (217, 34, '12:52:39', '2:45:34', 'Biritiba Mirim');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (237, 4, '6:02:44', '19:47:57', 'Jinsha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (189, 11, '7:49:49', '0:05:29', 'Krajan Sidodadi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (163, 378, '1:28:24', '12:51:06', 'Nangaroro');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (77, 43, '11:22:18', '2:54:39', 'Hailang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (182, 277, '1:34:22', '5:48:01', 'Podkamennaya Tunguska');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (397, 238, '3:27:16', '20:50:21', 'Rulenge');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (191, 356, '20:21:51', '15:17:45', 'Misawa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (122, 318, '13:26:11', '20:11:43', 'Jagodina');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (142, 301, '9:36:10', '9:10:26', 'Arras');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (120, 330, '15:34:31', '2:24:46', 'Panambi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (211, 100, '20:09:32', '22:11:08', 'Novopavlovsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (341, 18, '17:31:46', '23:32:05', 'Chekhov');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 257, '12:02:17', '12:54:52', 'Pasirlaja');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (325, 400, '3:10:38', '9:48:51', 'Jembangan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (9, 76, '11:35:37', '1:08:32', 'Sevlievo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (105, 278, '5:37:23', '3:13:34', 'Vilhelmina');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (220, 106, '0:18:23', '22:51:35', 'Changcun');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (235, 208, '16:51:23', '3:15:45', 'Bingawan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (125, 242, '3:35:37', '17:30:00', 'Jasugih Selatan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (253, 296, '10:06:55', '1:29:44', 'SÃ…Ânbong');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (255, 64, '10:33:31', '3:03:04', 'Oenunu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (207, 101, '18:09:18', '0:52:58', 'Sobienie Jeziory');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (8, 180, '6:06:15', '16:23:41', 'Ã…Å’magari');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 194, '14:40:45', '11:51:23', 'Sabanalarga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (354, 307, '20:30:26', '23:58:45', 'Uba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (246, 25, '8:54:36', '13:56:16', 'Al Jubayhah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (305, 145, '5:25:02', '9:34:56', 'Filipowice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (336, 205, '4:05:17', '14:25:48', 'Sumberejo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (164, 149, '5:11:03', '18:03:24', 'Qiman');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (62, 347, '18:55:09', '9:14:27', 'Sriwing');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (15, 159, '20:26:00', '22:47:07', 'Hecheng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (76, 242, '10:51:49', '7:45:08', 'Lagoa do Itaenga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (218, 188, '16:22:37', '1:44:50', 'Laboulaye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (113, 64, '9:14:24', '5:32:32', 'Gangshangji');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (122, 71, '6:01:57', '17:30:44', 'Mammari');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (378, 98, '16:19:09', '15:00:50', 'Stony Plain');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (61, 119, '9:28:53', '17:51:18', 'Woja');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (61, 97, '19:29:54', '18:51:15', 'Bual');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (266, 134, '2:22:19', '5:14:15', 'Tres Isletas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (115, 364, '0:05:45', '9:34:16', 'Datangzhuang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (400, 333, '15:31:22', '12:01:07', 'Chacapalpa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (232, 57, '3:11:19', '17:58:57', 'Timon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (14, 263, '18:17:50', '21:33:23', 'Vilar do Monte');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (399, 179, '23:52:57', '14:41:36', 'Papringan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (173, 24, '22:03:47', '23:17:45', 'Luozhou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (248, 369, '9:27:22', '8:49:11', 'Santa Cruz CabrÃƒÂ¡lia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 351, '2:40:22', '10:43:10', 'Uinskoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (108, 241, '11:51:50', '20:04:58', 'La Tigra');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (237, 348, '8:14:57', '16:29:04', 'GachancipÃƒÂ¡');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (64, 79, '12:37:04', '9:04:52', 'Hongjiang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (241, 132, '20:59:01', '17:50:44', 'Khlong Khuean');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (279, 313, '21:48:51', '18:32:41', 'Khromtau');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (228, 198, '21:27:15', '2:34:13', 'Khovd');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (366, 329, '0:40:46', '6:57:21', 'Bueng Khong Long');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (113, 148, '8:25:45', '22:13:23', 'Omsukchan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (80, 166, '6:57:00', '6:07:33', 'Monching');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (337, 33, '0:43:23', '6:32:39', 'Velyka Mykhaylivka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (287, 110, '10:19:06', '2:56:35', 'Karanganyar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (12, 256, '21:20:47', '15:37:49', 'Reriz');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (188, 84, '19:09:55', '3:58:10', 'Luzhai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (172, 376, '14:23:49', '22:02:04', 'Xinan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (389, 246, '15:32:36', '22:51:06', 'Swellendam');
commit;
prompt 600 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (1, 370, '18:40:39', '2:46:04', 'Balgatay');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (218, 314, '15:06:21', '2:22:44', 'GoÃƒÂºrnes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (201, 175, '21:38:14', '8:27:21', 'Zafar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (349, 382, '18:32:34', '7:15:58', 'Trzin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (39, 234, '6:25:48', '18:23:21', 'Nikopol');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (39, 128, '18:23:22', '10:11:04', 'Kumalarang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (198, 25, '22:39:52', '19:50:44', 'Calzada Larga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (157, 252, '10:47:12', '20:49:17', 'Nggelok');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (96, 27, '4:37:12', '12:53:53', 'Al BahlÃ…Â«lÃ„Â«yah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (262, 286, '1:32:29', '4:46:58', 'Colmar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (362, 158, '18:03:00', '2:54:51', 'Piskivka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (162, 66, '7:15:25', '12:19:25', 'Viraco');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (399, 348, '2:36:27', '1:04:06', 'Nassarawa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (277, 73, '15:25:35', '13:46:37', 'Shengli');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (159, 308, '8:22:35', '11:18:27', 'Ash ShaddÃ„Âdah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (194, 264, '15:11:34', '21:14:03', 'Chandra');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (55, 122, '3:55:27', '13:57:07', 'Sulo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (133, 346, '22:11:02', '3:55:06', 'Dawusu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (385, 44, '6:14:43', '10:02:20', 'Al MaÃ¡Â¸Â©allah al KubrÃƒÂ¡');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (294, 73, '20:44:59', '10:51:20', 'KhÃƒÂ³ra');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (103, 161, '16:35:19', '11:37:04', 'Aguazul');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (168, 323, '22:14:54', '9:19:42', 'NdÃƒÂ©lÃƒÂ©');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (267, 41, '13:34:07', '4:45:01', 'Dalonghua');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (383, 219, '7:24:05', '17:14:19', 'UniÃƒÂ£o dos Palmares');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (67, 127, '5:08:19', '23:15:47', 'Talondang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (306, 356, '0:55:09', '2:13:56', 'Drammen');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (34, 59, '6:42:31', '8:21:59', 'PamyatÃ¢â‚¬â„¢ Parizhskoy Kommuny');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (115, 293, '5:58:28', '8:09:29', 'Haarlem');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (87, 385, '7:05:48', '3:16:04', 'Bressuire');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (319, 225, '3:51:48', '23:10:09', 'Vale de Figueira');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (367, 103, '17:54:38', '1:22:23', 'Ebak');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (41, 339, '2:05:33', '16:48:53', 'Talok');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (29, 143, '4:44:10', '9:32:33', 'Kemiri Daya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (287, 190, '19:40:10', '13:53:32', 'Saint-FÃƒÂ©licien');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (41, 258, '0:08:53', '1:06:14', 'Lukrejo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (306, 207, '8:55:18', '7:37:14', 'Abade de Neiva');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (6, 136, '4:26:44', '2:33:41', 'Amiens');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (230, 160, '6:12:42', '13:25:04', 'Donglai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (217, 49, '10:52:44', '5:18:19', 'Lysekil');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (3, 359, '7:20:50', '13:36:19', 'Rostock');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (260, 307, '0:47:44', '8:51:58', 'Tampere');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (277, 161, '13:38:16', '3:56:39', 'Hrazdan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (141, 148, '4:11:10', '9:17:35', 'Butare');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (161, 69, '13:00:28', '7:13:50', 'Vila ViÃƒÂ§osa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (206, 130, '12:12:57', '8:57:20', 'Rozhnyativ');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (68, 176, '21:10:53', '1:17:10', 'Gunungangka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (369, 238, '11:03:31', '23:13:58', 'Donglinxi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (199, 329, '10:36:44', '14:01:47', 'Krajan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (303, 244, '23:36:17', '5:28:22', 'Anyang-si');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (33, 73, '1:18:36', '23:45:45', 'Uppsala');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (69, 114, '5:21:16', '0:19:42', 'Suphan Buri');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (206, 30, '15:42:26', '0:19:09', 'Corpus Christi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (193, 268, '3:20:19', '2:37:59', 'Fucun');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (319, 194, '23:04:09', '5:45:57', 'Timur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (242, 60, '22:36:59', '8:34:22', 'Pita');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (124, 108, '13:33:39', '18:13:19', 'Yuanqiao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (268, 44, '22:51:11', '9:59:09', 'Watoona');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (230, 244, '20:10:31', '19:39:51', 'Zeqin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (385, 248, '17:50:59', '20:36:56', 'Le Mans');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (272, 238, '13:04:23', '3:24:02', 'San Basilio');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (177, 173, '6:37:59', '22:43:34', 'Issia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (376, 149, '12:49:03', '19:24:22', 'Liuzuo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (164, 347, '2:59:31', '12:19:10', 'Graksop');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (222, 31, '8:19:49', '5:37:42', 'Carcavelos');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (214, 29, '9:38:46', '14:59:52', 'DueÃƒÂ±as');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (377, 96, '9:41:46', '16:37:55', 'Arroyo Naranjo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (310, 91, '10:34:39', '8:58:14', 'Daogao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (241, 98, '16:13:18', '12:10:15', 'NeochÃƒÂ³ri');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (62, 163, '0:27:04', '3:35:31', 'Gotemba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (366, 358, '23:00:52', '9:15:27', 'Slyudyanka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (262, 25, '18:20:11', '9:36:09', 'Velille');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (29, 253, '13:53:54', '1:43:34', 'Pakel');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (293, 224, '14:23:14', '2:16:19', 'VÃƒÂ¤xjÃƒÂ¶');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (387, 214, '19:19:48', '18:48:12', 'Dayapan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (56, 362, '1:15:33', '2:08:21', 'Dongqu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (384, 134, '3:45:20', '6:14:33', 'Dijon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (235, 390, '4:48:52', '9:41:38', 'Buenavista');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (247, 16, '17:14:03', '3:21:55', 'Guizi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (210, 187, '1:45:59', '20:26:49', 'Buyunshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (20, 50, '6:20:23', '2:10:45', 'Kobyzhcha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (86, 238, '1:55:00', '11:45:11', 'Huta Stara B');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (57, 222, '12:37:11', '10:28:25', 'Mramani');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (331, 236, '2:16:48', '20:23:18', 'Haikou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (1, 339, '6:02:57', '1:46:01', 'Turka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (334, 72, '11:47:09', '9:54:25', 'Rurrenabaque');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (171, 30, '15:29:58', '15:13:57', 'Ntoum');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (370, 369, '22:33:49', '20:07:02', 'Barvinkove');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (360, 336, '12:12:33', '3:57:39', 'Callanca');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (161, 294, '9:17:46', '12:30:09', 'Tignapalan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (104, 108, '9:03:45', '15:41:45', 'Luuka Town');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (270, 213, '11:08:40', '5:44:20', 'Ratchaburi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (379, 19, '9:07:17', '4:20:00', 'Walton');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (207, 181, '4:12:46', '20:26:39', 'SÃƒÂ£o FidÃƒÂ©lis');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (226, 292, '0:46:29', '8:35:15', 'Kvissleby');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (333, 38, '22:02:51', '9:57:59', 'Wonoharjo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (219, 166, '4:24:39', '3:51:55', 'YaÃ¢â‚¬Ëœbad');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (235, 299, '8:17:21', '9:20:25', 'Alaverdi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (138, 171, '13:09:54', '12:35:21', 'Puerto QuellÃƒÂ³n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (393, 311, '0:20:19', '9:14:32', 'Jambuir Timur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (137, 74, '14:09:06', '23:19:15', 'Yifaquan');
commit;
prompt 700 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (249, 156, '3:24:50', '6:35:56', 'Changlu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (301, 68, '22:58:09', '8:17:44', 'Gayny');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (369, 157, '12:48:00', '8:09:12', 'Santa Rosa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (159, 40, '13:25:30', '7:13:17', 'Houston');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (280, 142, '20:03:48', '9:59:03', 'Mangai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (212, 58, '22:59:20', '13:28:36', 'Jiujie');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (244, 54, '7:28:06', '5:07:34', 'Cartagena');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (392, 295, '15:44:24', '20:05:53', 'PÃƒÂ¡tmos');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (314, 84, '19:14:39', '8:51:57', 'Sumberbening');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (262, 283, '18:21:31', '0:35:20', 'Negara');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (200, 147, '9:16:52', '12:12:46', 'HatsÃ¢â‚¬â„¢avan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (19, 110, '15:42:42', '9:58:14', 'Brongkalan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (328, 73, '21:09:49', '2:43:43', 'SamothrÃƒÂ¡ki');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (213, 355, '9:46:56', '18:02:17', 'Mpophomeni');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (217, 214, '5:40:43', '23:26:53', 'Pontinha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (324, 105, '14:22:26', '1:39:09', 'Bacuyangan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (95, 232, '23:37:03', '22:41:04', 'QalÃ¢â‚¬Ëœah-ye NaÃ¢â‚¬ËœÃ„Â«m');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 397, '19:35:24', '12:21:32', 'El Asintal');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (229, 226, '17:20:47', '13:56:31', 'Donetsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (10, 383, '0:17:18', '9:19:36', 'Qindu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (5, 315, '14:01:49', '0:45:48', 'General Belgrano');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (389, 82, '18:11:15', '12:09:06', 'LamÃƒÂ­a');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (224, 284, '16:14:43', '22:53:59', 'Freiburg im Breisgau');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (287, 396, '15:24:12', '14:29:13', 'Miras');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (293, 145, '0:00:20', '20:54:01', 'Jiuxian');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (121, 271, '20:38:19', '11:44:22', 'Djibo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (165, 329, '9:04:46', '14:19:54', 'Sharga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (363, 82, '8:06:38', '20:18:00', 'ThÃ¡Â»â€¹ TrÃ¡ÂºÂ¥n YÃƒÂªn ThÃ¡ÂºÂ¿');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (369, 122, '2:10:06', '8:16:11', 'Karangboyo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (398, 11, '0:14:08', '6:33:38', 'Shangani');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (188, 64, '21:27:29', '1:09:23', 'Pyskowice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (75, 77, '17:16:19', '11:34:24', 'SremÃ„Âica');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (255, 92, '8:17:43', '12:53:47', 'AcherÃƒÂ­tou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (279, 293, '16:26:33', '2:20:40', 'Phu Khiao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (226, 250, '12:29:33', '16:16:09', 'Kebonagung');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (128, 264, '21:46:56', '13:50:28', 'Remas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (5, 59, '11:11:31', '3:48:52', 'Paris 01');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (380, 241, '22:41:20', '19:15:17', 'Vicente Guerrero');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (303, 242, '3:59:11', '1:39:27', 'Bailan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (307, 51, '20:48:40', '6:40:08', 'Itambacuri');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 270, '12:27:57', '11:58:25', 'Bachowice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (138, 342, '17:47:43', '0:24:44', 'KruÃ…Â¡evac');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (117, 122, '20:03:05', '2:22:16', 'Castro');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (156, 57, '2:11:31', '19:59:48', 'Ã¢â‚¬ËœArab ar RashÃ„Âydah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (38, 32, '15:50:31', '7:43:52', 'DolnÃƒÂ­ DvoÃ…â„¢iÃ…Â¡tÃ„â€º');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (204, 257, '2:37:09', '9:50:41', 'Warnes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (91, 46, '13:01:26', '10:13:32', 'Mombok');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 152, '3:41:28', '4:02:35', 'Mporokoso');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (83, 164, '18:09:13', '5:18:39', 'RyÃ…Âtsu-minato');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (257, 37, '8:16:36', '10:15:28', 'San Ignacio');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (134, 357, '6:08:50', '14:02:10', 'Sabanalarga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (140, 232, '11:54:03', '11:19:22', 'Senlis');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (46, 335, '21:22:22', '18:27:59', 'Ã„ÂÃƒÂ  BÃ¡ÂºÂ¯c');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (78, 76, '14:49:42', '21:33:02', 'Ã…Â»abno');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (132, 316, '19:24:17', '22:34:52', 'Sundsvall');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (213, 221, '2:19:57', '0:46:31', 'Oslo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (54, 308, '22:21:36', '4:03:27', 'Liujia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (273, 280, '1:35:58', '1:06:17', 'Taraco');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (178, 119, '12:11:45', '0:24:41', 'EÃ¡Â¹Â­ Ã¡Â¹Â¬aiyiba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (297, 183, '4:56:07', '5:12:51', 'Pospelikha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (18, 76, '4:37:37', '11:00:32', 'Falun');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (243, 6, '22:21:09', '3:50:56', 'Salisbury');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (246, 54, '17:05:18', '12:07:03', 'Klyuchevsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (381, 322, '8:31:33', '13:38:05', 'El Limon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (178, 221, '16:37:08', '6:32:06', 'Marseille');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (212, 123, '5:52:53', '12:19:10', 'Canhestros');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (83, 362, '0:50:04', '20:25:09', 'Tsaghkaber');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (106, 140, '16:48:33', '8:54:11', 'AngoulÃƒÂªme');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (104, 160, '22:03:00', '6:53:47', 'MiÃ„Ân ChannÃ…Â«n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (129, 274, '10:33:59', '18:51:26', 'Taizi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (377, 353, '13:15:57', '18:29:22', 'Sapotskin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (331, 346, '13:03:00', '21:38:07', 'Curridabat');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (278, 119, '19:03:03', '19:22:55', 'Taha Man Zu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (242, 19, '23:28:46', '14:04:31', 'HacÃ„Â±qabul');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (187, 50, '18:49:20', '1:47:07', 'Al QanÃ„ÂyÃ„Ât');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (143, 108, '2:30:22', '8:42:21', 'Were');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (224, 379, '16:17:27', '23:02:04', 'Yanhe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (341, 154, '11:27:00', '6:56:22', 'Nantes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (244, 247, '19:35:07', '5:48:40', 'Padangbatung');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (344, 250, '12:20:13', '23:56:32', 'Princeton');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (300, 138, '18:57:33', '10:56:10', 'Kwatarkwashi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (313, 203, '16:43:51', '3:11:42', 'Aguelmous');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (356, 387, '8:36:03', '2:41:04', 'Itapevi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (400, 319, '0:11:25', '4:56:22', 'KhÃƒÂ´ng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (235, 337, '11:20:39', '19:31:25', 'ThÃ¡Â»â€¹ TrÃ¡ÂºÂ¥n MÃ†Â°Ã¡Â»Âng KhÃ¡ÂºÂ¿n');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (51, 101, '14:46:01', '9:10:09', 'Kuantan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (203, 51, '11:41:59', '22:36:54', 'Lieksa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (293, 263, '17:32:53', '13:06:47', 'Markog');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (180, 380, '21:43:05', '11:41:22', 'Bagan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (58, 113, '9:59:10', '16:06:26', 'Uliastay');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (95, 313, '17:47:23', '17:58:33', 'Austin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (321, 67, '4:35:07', '23:10:02', 'Jinshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (203, 331, '6:27:19', '22:15:38', 'Nyrob');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (251, 255, '3:59:25', '19:43:31', 'Leskolovo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (244, 28, '12:40:33', '14:34:40', 'Murganhal');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (220, 222, '9:06:42', '4:11:30', 'Dusun Tengah Cihaurbeuti');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (35, 114, '12:57:51', '23:53:32', 'Agogo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (191, 368, '4:21:18', '6:31:01', 'SokalÃ¢â‚¬â„¢');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (251, 304, '11:31:04', '16:15:31', 'Xuanhua');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (86, 109, '0:17:00', '19:28:50', 'Acajutla');
commit;
prompt 800 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (258, 255, '15:23:16', '14:09:31', 'Zhangjiafan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (242, 314, '16:58:28', '3:27:26', 'Svenljunga');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (306, 307, '15:57:15', '15:01:14', 'El Paso');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (365, 356, '19:31:36', '20:25:34', 'BalÃ¢â‚¬â„¢shavik');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (299, 357, '19:56:51', '3:35:00', 'San Francisco');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (287, 96, '8:19:08', '3:39:22', 'Yangping');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (240, 238, '17:40:28', '14:56:52', 'Longsheng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (84, 41, '0:06:17', '7:58:07', 'Juru');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (109, 148, '11:35:41', '18:52:05', 'Kanshan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (230, 356, '10:57:44', '2:43:57', 'Nanqiao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (68, 175, '6:16:17', '2:55:52', 'Villeneuve-sur-Lot');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (246, 231, '22:41:02', '18:13:46', 'TÃ„Â«kÃ„Âpur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (366, 76, '4:24:46', '19:10:34', 'Rathdrum');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (10, 141, '20:24:31', '14:50:27', 'BerbÃƒÂ©rati');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (381, 187, '8:27:40', '0:58:41', 'Votkinsk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (269, 236, '9:51:05', '8:26:29', 'Lesnoy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (30, 30, '6:29:42', '10:47:51', 'Kedungwungu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (114, 7, '5:33:35', '16:03:53', 'Lugu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (273, 223, '0:27:26', '15:02:43', 'Hisai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (3, 61, '20:10:09', '11:25:03', 'Chartres');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (120, 162, '22:50:15', '17:31:52', 'QuÃ¡Â»â€˜c Oai');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (218, 91, '18:19:53', '18:26:51', 'Miraflores');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (99, 158, '5:49:13', '3:57:11', 'Palangkaraya');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (201, 141, '11:39:55', '19:19:33', 'Yurimaguas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (14, 202, '22:23:08', '16:47:20', 'XylaganÃƒÂ­');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (19, 263, '5:48:59', '19:48:01', 'Uherce Mineralne');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (374, 155, '16:42:07', '10:00:18', 'Cabannungan Second');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (297, 159, '7:44:19', '9:27:23', 'Changuinola');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (12, 260, '3:07:40', '3:13:14', 'Piraju');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (199, 104, '6:26:13', '19:32:26', 'Ban Haet');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (277, 325, '19:23:54', '17:59:30', 'Bryansk');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (391, 50, '22:55:00', '22:17:22', 'Echeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (218, 220, '3:13:19', '7:29:52', 'Mangochi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (101, 129, '20:10:16', '14:40:01', 'Sendafa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (264, 248, '15:02:01', '18:08:00', 'SÃƒÂ£o SepÃƒÂ©');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (336, 102, '12:36:43', '16:05:34', 'DÃ„Â«vÃ„Ândarreh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (102, 267, '7:42:31', '12:26:17', 'JadÃƒÂ³w');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (33, 178, '16:14:45', '10:42:16', 'Taoyao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (98, 146, '1:20:26', '3:03:47', 'Hatu Buh');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (71, 177, '19:53:02', '12:19:38', 'Buyant');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (378, 216, '3:51:56', '23:50:03', 'Lacdayan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (295, 107, '4:45:09', '17:54:00', 'Huayuan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (177, 265, '20:03:17', '17:30:57', 'Tertek');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (391, 320, '3:34:44', '22:11:59', 'Quinta da Courela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (112, 389, '23:52:56', '11:36:06', 'Modimolle');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (3, 197, '17:25:13', '14:40:26', 'Valdemarsvik');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (167, 274, '14:57:50', '11:57:54', 'Paris 01');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (350, 155, '12:40:51', '16:19:43', 'Lupo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (284, 224, '7:55:04', '9:47:43', 'Zhongchuan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (279, 241, '22:46:58', '7:26:06', 'Dortmund');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (280, 234, '20:56:57', '17:28:43', 'Nantes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (175, 65, '8:58:37', '13:38:34', 'Dapdap');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (19, 328, '22:08:21', '9:09:34', 'BoÃ…â„¢itov');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (316, 320, '13:19:28', '2:31:36', 'Venda Nova');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (230, 201, '18:33:08', '11:34:01', 'Jelcz');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (28, 364, '19:16:32', '7:45:11', 'Mazhu');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (16, 315, '11:22:51', '23:33:45', 'Papeete');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (239, 299, '6:50:32', '16:13:21', 'Krajan Gebangan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (115, 33, '7:19:52', '2:12:51', 'JoÃƒÂ£o Pessoa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (22, 289, '19:41:25', '22:08:48', 'Villa Castelli');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (306, 48, '10:28:03', '18:00:29', 'Yangchao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (329, 387, '20:12:51', '15:06:07', 'Ticrapo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (188, 252, '2:32:19', '22:33:41', 'Shiroi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (48, 263, '15:03:29', '8:22:32', 'Portland');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (380, 137, '15:22:43', '22:06:12', 'Bayt Ã¢â‚¬ËœÃ…Âªr at TaÃ¡Â¸Â©tÃ„Â');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (257, 181, '3:10:10', '13:45:42', 'San Rafael');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (143, 10, '1:29:33', '4:12:55', 'Bijie');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (169, 143, '4:48:36', '19:55:25', 'Doba');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (36, 322, '1:27:42', '20:30:30', 'Sankui');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (90, 118, '15:24:51', '6:27:46', 'Sukaraja');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (334, 244, '22:30:05', '17:44:53', 'Rumphi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (69, 119, '21:05:30', '9:37:08', 'Butha-Buthe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (318, 216, '4:20:23', '9:20:55', 'PodporozhÃ¢â‚¬â„¢ye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (150, 4, '19:21:46', '18:30:06', 'Aimin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (210, 23, '19:13:52', '5:06:43', 'Chiguayante');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (197, 177, '14:43:52', '15:32:21', 'Ngarus');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (17, 64, '5:39:22', '6:31:00', 'Majia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (326, 335, '0:37:37', '12:59:49', 'Smederevska Palanka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (222, 219, '16:27:02', '11:09:58', 'Wantian');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (57, 375, '18:58:25', '1:51:36', 'Banjar Banyualit');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (216, 54, '19:15:39', '22:12:21', 'Moreira de Geraz do Lima');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (309, 373, '16:19:18', '21:57:15', 'Pitalito');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (335, 261, '13:50:23', '16:38:33', 'Masarayao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (111, 65, '11:10:39', '19:07:07', 'Nezamyslice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (392, 21, '7:23:55', '9:01:02', 'Wenchang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (25, 32, '0:54:30', '8:00:12', 'KalÃƒÂ½ves PolygÃƒÂ½rou');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (396, 78, '4:34:24', '5:34:51', 'Kotawaikabubak');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (263, 396, '18:40:54', '20:28:18', 'Loshnitsa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (389, 319, '7:08:12', '18:51:15', 'Hultsfred');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (298, 199, '22:14:12', '13:39:35', 'Gandara');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (225, 182, '4:56:51', '22:25:56', 'Dashtobod');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (18, 86, '6:58:51', '1:58:13', 'Maikun');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (150, 3, '0:37:51', '22:55:39', 'Maevatanana');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (71, 8, '0:04:35', '0:11:48', 'Sulangan');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (167, 266, '19:32:00', '20:57:45', 'Dalovice');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (174, 13, '18:40:35', '2:28:14', 'Cipadung Timur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (331, 251, '10:45:09', '8:20:48', 'CampanÃƒÂ¡rio');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (129, 400, '0:30:54', '7:26:20', 'Marly');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (308, 236, '0:34:34', '10:31:19', 'Nong Bua Daeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (383, 193, '11:54:09', '6:35:12', 'Huangduobu');
commit;
prompt 900 records committed...
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (220, 279, '10:58:07', '0:36:32', 'Sumisip');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (145, 327, '22:42:53', '13:55:12', 'Al Kittah');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (271, 206, '16:08:22', '7:10:55', 'Dongshandi');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (65, 64, '17:48:41', '15:30:16', 'Trzcianka');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (183, 313, '21:41:56', '11:52:35', 'Maliana');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (378, 17, '2:30:43', '19:06:59', 'Banyumas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (342, 137, '21:19:53', '21:45:38', 'Lanas');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (192, 123, '2:11:54', '3:44:53', 'SirÃ„Âjganj');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (349, 374, '10:49:06', '8:23:29', 'Shanghuang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (235, 29, '9:52:33', '16:53:48', 'MelissochÃƒÂ³ri');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (296, 122, '1:20:46', '15:02:04', 'Engenheiro BeltrÃƒÂ£o');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (137, 345, '12:51:26', '12:30:07', 'Guararapes');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (390, 97, '2:04:29', '4:18:53', 'Kuala Lumpur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (96, 280, '15:42:35', '22:33:28', 'Altay');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (104, 323, '9:33:33', '7:44:42', 'Pejek');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (27, 254, '4:27:20', '14:49:28', 'Berlin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (24, 353, '21:10:27', '17:34:49', 'Atengmelang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (240, 23, '22:02:13', '14:44:29', 'Camabatela');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (319, 44, '4:46:30', '5:15:58', 'Pospelikha');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (257, 253, '9:42:03', '8:57:27', 'Qianguo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (376, 43, '4:44:16', '2:31:05', 'Alfena');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (283, 300, '4:32:55', '6:14:40', 'Kekeri');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 178, '8:08:56', '23:31:27', 'GuaranÃƒÂ©sia');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (188, 120, '11:38:16', '4:03:43', 'Shuitianhe');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (382, 118, '20:15:08', '13:31:05', 'KilkÃƒÂ­s');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (340, 382, '9:15:50', '9:35:33', 'Saverne');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (11, 178, '4:50:30', '0:01:39', 'Lordelo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (2, 227, '14:52:52', '3:53:37', 'Baofeng');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (155, 364, '3:33:44', '1:31:49', 'Palotina');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (352, 199, '8:32:48', '14:48:16', 'Helin');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (275, 59, '11:20:38', '5:38:39', 'Sukowiryo');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (108, 335, '12:39:43', '12:52:42', 'Paucar');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (101, 137, '8:03:11', '7:59:44', 'Hartswater');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (41, 302, '9:21:40', '10:12:05', 'Kuala Lumpur');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (373, 261, '0:37:33', '14:20:41', 'Ã…Â»arÃƒÂ³w');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (194, 193, '14:55:45', '3:25:14', 'Devesa');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (191, 373, '7:25:24', '11:46:48', 'Ayamaru');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (20, 31, '6:16:28', '13:31:03', 'Hagonoy');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (341, 309, '21:32:55', '1:36:11', 'Chenji');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (95, 370, '20:30:31', '17:21:26', 'Soloneshnoye');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (351, 72, '4:12:09', '4:21:03', 'Kikerino');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (56, 200, '17:21:22', '9:40:24', 'Kiraman');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (44, 97, '3:50:53', '13:11:45', 'Xiangyang');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (312, 250, '20:05:06', '9:33:39', 'Makarska');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (399, 324, '0:48:59', '8:34:47', 'Hongqiao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (164, 26, '7:10:40', '5:24:42', 'PatrocÃƒÂ­nio');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (59, 388, '10:53:38', '21:22:25', 'Buenavista');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (98, 377, '7:39:51', '2:20:00', 'Krajan Pangkah Kulon');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (174, 356, '5:20:43', '2:35:20', 'Guling');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (5, 158, '9:43:08', '0:40:36', 'Baimiao');
insert into DRIVESINTAXI (driverid, taxiid, starttime, finishtime, workingzone)
values (375, 333, '18:39:43', '14:54:39', 'BaÃƒÂ±os');
commit;
prompt 951 records loaded
prompt Loading PAYMENT_REPORT...
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1000, to_date('07-07-2023', 'dd-mm-yyyy'), 1000);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1001, to_date('22-07-2023', 'dd-mm-yyyy'), 1001);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1002, to_date('06-07-2023', 'dd-mm-yyyy'), 1002);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1003, to_date('11-07-2023', 'dd-mm-yyyy'), 1003);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1004, to_date('02-07-2023', 'dd-mm-yyyy'), 1004);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1005, to_date('06-07-2023', 'dd-mm-yyyy'), 1005);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1006, to_date('02-07-2023', 'dd-mm-yyyy'), 1006);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1007, to_date('15-07-2023', 'dd-mm-yyyy'), 1007);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1008, to_date('22-07-2023', 'dd-mm-yyyy'), 1008);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1009, to_date('17-07-2023', 'dd-mm-yyyy'), 1009);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1010, to_date('28-07-2023', 'dd-mm-yyyy'), 1010);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1012, to_date('06-07-2023', 'dd-mm-yyyy'), 1012);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1013, to_date('10-07-2023', 'dd-mm-yyyy'), 1013);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1014, to_date('26-07-2023', 'dd-mm-yyyy'), 1014);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1015, to_date('24-07-2023', 'dd-mm-yyyy'), 1015);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1016, to_date('21-07-2023', 'dd-mm-yyyy'), 1016);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1017, to_date('27-07-2023', 'dd-mm-yyyy'), 1017);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1018, to_date('05-07-2023', 'dd-mm-yyyy'), 1018);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1019, to_date('24-07-2023', 'dd-mm-yyyy'), 1019);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1020, to_date('15-07-2023', 'dd-mm-yyyy'), 1020);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1021, to_date('03-07-2023', 'dd-mm-yyyy'), 1021);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1022, to_date('05-07-2023', 'dd-mm-yyyy'), 1022);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1023, to_date('06-07-2023', 'dd-mm-yyyy'), 1023);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1024, to_date('18-07-2023', 'dd-mm-yyyy'), 1024);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1025, to_date('18-07-2023', 'dd-mm-yyyy'), 1025);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1026, to_date('29-07-2023', 'dd-mm-yyyy'), 1026);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1027, to_date('06-07-2023', 'dd-mm-yyyy'), 1027);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1028, to_date('29-07-2023', 'dd-mm-yyyy'), 1028);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1029, to_date('23-07-2023', 'dd-mm-yyyy'), 1029);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1030, to_date('09-07-2023', 'dd-mm-yyyy'), 1030);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1031, to_date('21-07-2023', 'dd-mm-yyyy'), 1031);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1032, to_date('23-07-2023', 'dd-mm-yyyy'), 1032);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1033, to_date('13-07-2023', 'dd-mm-yyyy'), 1033);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1034, to_date('17-07-2023', 'dd-mm-yyyy'), 1034);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1035, to_date('29-07-2023', 'dd-mm-yyyy'), 1035);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1036, to_date('15-07-2023', 'dd-mm-yyyy'), 1036);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1037, to_date('07-07-2023', 'dd-mm-yyyy'), 1037);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1038, to_date('23-07-2023', 'dd-mm-yyyy'), 1038);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1041, to_date('24-07-2023', 'dd-mm-yyyy'), 1041);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1042, to_date('24-07-2023', 'dd-mm-yyyy'), 1042);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1043, to_date('07-07-2023', 'dd-mm-yyyy'), 1043);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1044, to_date('22-07-2023', 'dd-mm-yyyy'), 1044);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1045, to_date('26-07-2023', 'dd-mm-yyyy'), 1045);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1046, to_date('06-07-2023', 'dd-mm-yyyy'), 1046);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1047, to_date('28-07-2023', 'dd-mm-yyyy'), 1047);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1048, to_date('21-07-2023', 'dd-mm-yyyy'), 1048);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1049, to_date('28-07-2023', 'dd-mm-yyyy'), 1049);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1050, to_date('24-07-2023', 'dd-mm-yyyy'), 1050);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1051, to_date('20-07-2023', 'dd-mm-yyyy'), 1051);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1052, to_date('18-07-2023', 'dd-mm-yyyy'), 1052);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1053, to_date('11-07-2023', 'dd-mm-yyyy'), 1053);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1054, to_date('27-07-2023', 'dd-mm-yyyy'), 1054);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1056, to_date('06-07-2023', 'dd-mm-yyyy'), 1056);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1057, to_date('28-07-2023', 'dd-mm-yyyy'), 1057);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1058, to_date('22-07-2023', 'dd-mm-yyyy'), 1058);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1059, to_date('26-07-2023', 'dd-mm-yyyy'), 1059);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1060, to_date('16-07-2023', 'dd-mm-yyyy'), 1060);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1061, to_date('05-07-2023', 'dd-mm-yyyy'), 1061);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1062, to_date('22-07-2023', 'dd-mm-yyyy'), 1062);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1063, to_date('14-07-2023', 'dd-mm-yyyy'), 1063);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1064, to_date('19-07-2023', 'dd-mm-yyyy'), 1064);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1065, to_date('23-07-2023', 'dd-mm-yyyy'), 1065);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1066, to_date('18-07-2023', 'dd-mm-yyyy'), 1066);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1067, to_date('08-07-2023', 'dd-mm-yyyy'), 1067);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1068, to_date('23-07-2023', 'dd-mm-yyyy'), 1068);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1070, to_date('15-07-2023', 'dd-mm-yyyy'), 1070);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1071, to_date('13-07-2023', 'dd-mm-yyyy'), 1071);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1072, to_date('04-07-2023', 'dd-mm-yyyy'), 1072);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1073, to_date('02-07-2023', 'dd-mm-yyyy'), 1073);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1074, to_date('16-07-2023', 'dd-mm-yyyy'), 1074);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1075, to_date('08-07-2023', 'dd-mm-yyyy'), 1075);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1076, to_date('02-07-2023', 'dd-mm-yyyy'), 1076);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1077, to_date('23-07-2023', 'dd-mm-yyyy'), 1077);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1078, to_date('21-07-2023', 'dd-mm-yyyy'), 1078);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1079, to_date('24-07-2023', 'dd-mm-yyyy'), 1079);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1080, to_date('09-07-2023', 'dd-mm-yyyy'), 1080);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1081, to_date('28-07-2023', 'dd-mm-yyyy'), 1081);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1082, to_date('19-07-2023', 'dd-mm-yyyy'), 1082);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1083, to_date('12-07-2023', 'dd-mm-yyyy'), 1083);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1084, to_date('19-07-2023', 'dd-mm-yyyy'), 1084);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1086, to_date('20-07-2023', 'dd-mm-yyyy'), 1086);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1087, to_date('08-07-2023', 'dd-mm-yyyy'), 1087);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1088, to_date('26-07-2023', 'dd-mm-yyyy'), 1088);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1089, to_date('08-07-2023', 'dd-mm-yyyy'), 1089);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1090, to_date('11-07-2023', 'dd-mm-yyyy'), 1090);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1091, to_date('13-07-2023', 'dd-mm-yyyy'), 1091);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1092, to_date('08-07-2023', 'dd-mm-yyyy'), 1092);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1093, to_date('17-07-2023', 'dd-mm-yyyy'), 1093);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1094, to_date('22-07-2023', 'dd-mm-yyyy'), 1094);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1095, to_date('06-07-2023', 'dd-mm-yyyy'), 1095);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1096, to_date('28-07-2023', 'dd-mm-yyyy'), 1096);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1097, to_date('02-07-2023', 'dd-mm-yyyy'), 1097);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1098, to_date('09-07-2023', 'dd-mm-yyyy'), 1098);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1099, to_date('24-07-2023', 'dd-mm-yyyy'), 1099);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1100, to_date('20-07-2023', 'dd-mm-yyyy'), 1100);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1102, to_date('13-07-2023', 'dd-mm-yyyy'), 1102);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1103, to_date('19-07-2023', 'dd-mm-yyyy'), 1103);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1104, to_date('09-07-2023', 'dd-mm-yyyy'), 1104);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1105, to_date('19-07-2023', 'dd-mm-yyyy'), 1105);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1106, to_date('18-07-2023', 'dd-mm-yyyy'), 1106);
commit;
prompt 100 records committed...
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1107, to_date('07-07-2023', 'dd-mm-yyyy'), 1107);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1108, to_date('23-07-2023', 'dd-mm-yyyy'), 1108);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1109, to_date('07-07-2023', 'dd-mm-yyyy'), 1109);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1110, to_date('09-07-2023', 'dd-mm-yyyy'), 1110);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1111, to_date('22-07-2023', 'dd-mm-yyyy'), 1111);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1112, to_date('12-07-2023', 'dd-mm-yyyy'), 1112);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1113, to_date('23-07-2023', 'dd-mm-yyyy'), 1113);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1114, to_date('09-07-2023', 'dd-mm-yyyy'), 1114);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1115, to_date('19-07-2023', 'dd-mm-yyyy'), 1115);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1116, to_date('04-07-2023', 'dd-mm-yyyy'), 1116);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1117, to_date('14-07-2023', 'dd-mm-yyyy'), 1117);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1118, to_date('15-07-2023', 'dd-mm-yyyy'), 1118);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1119, to_date('04-07-2023', 'dd-mm-yyyy'), 1119);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1120, to_date('28-07-2023', 'dd-mm-yyyy'), 1120);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1121, to_date('28-07-2023', 'dd-mm-yyyy'), 1121);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1122, to_date('28-07-2023', 'dd-mm-yyyy'), 1122);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1123, to_date('23-07-2023', 'dd-mm-yyyy'), 1123);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1124, to_date('14-07-2023', 'dd-mm-yyyy'), 1124);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1126, to_date('07-07-2023', 'dd-mm-yyyy'), 1126);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1127, to_date('03-07-2023', 'dd-mm-yyyy'), 1127);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1128, to_date('08-07-2023', 'dd-mm-yyyy'), 1128);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1130, to_date('15-07-2023', 'dd-mm-yyyy'), 1130);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1131, to_date('07-07-2023', 'dd-mm-yyyy'), 1131);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1132, to_date('22-07-2023', 'dd-mm-yyyy'), 1132);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1133, to_date('06-07-2023', 'dd-mm-yyyy'), 1133);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1134, to_date('10-07-2023', 'dd-mm-yyyy'), 1134);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1135, to_date('09-07-2023', 'dd-mm-yyyy'), 1135);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1136, to_date('08-07-2023', 'dd-mm-yyyy'), 1136);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1137, to_date('05-07-2023', 'dd-mm-yyyy'), 1137);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1138, to_date('21-07-2023', 'dd-mm-yyyy'), 1138);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1139, to_date('27-07-2023', 'dd-mm-yyyy'), 1139);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1140, to_date('15-07-2023', 'dd-mm-yyyy'), 1140);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1141, to_date('19-07-2023', 'dd-mm-yyyy'), 1141);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1142, to_date('27-07-2023', 'dd-mm-yyyy'), 1142);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1143, to_date('27-07-2023', 'dd-mm-yyyy'), 1143);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1145, to_date('11-07-2023', 'dd-mm-yyyy'), 1145);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1146, to_date('17-07-2023', 'dd-mm-yyyy'), 1146);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1147, to_date('19-07-2023', 'dd-mm-yyyy'), 1147);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1148, to_date('23-07-2023', 'dd-mm-yyyy'), 1148);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1149, to_date('11-07-2023', 'dd-mm-yyyy'), 1149);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1150, to_date('29-07-2023', 'dd-mm-yyyy'), 1150);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1151, to_date('11-07-2023', 'dd-mm-yyyy'), 1151);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1152, to_date('18-07-2023', 'dd-mm-yyyy'), 1152);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1153, to_date('13-07-2023', 'dd-mm-yyyy'), 1153);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1154, to_date('25-07-2023', 'dd-mm-yyyy'), 1154);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1155, to_date('26-07-2023', 'dd-mm-yyyy'), 1155);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1156, to_date('13-07-2023', 'dd-mm-yyyy'), 1156);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1157, to_date('08-07-2023', 'dd-mm-yyyy'), 1157);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1158, to_date('10-07-2023', 'dd-mm-yyyy'), 1158);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1159, to_date('09-07-2023', 'dd-mm-yyyy'), 1159);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1160, to_date('02-07-2023', 'dd-mm-yyyy'), 1160);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1161, to_date('05-07-2023', 'dd-mm-yyyy'), 1161);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1162, to_date('21-07-2023', 'dd-mm-yyyy'), 1162);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1163, to_date('11-07-2023', 'dd-mm-yyyy'), 1163);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1164, to_date('02-07-2023', 'dd-mm-yyyy'), 1164);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1165, to_date('13-07-2023', 'dd-mm-yyyy'), 1165);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1166, to_date('17-07-2023', 'dd-mm-yyyy'), 1166);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1167, to_date('29-07-2023', 'dd-mm-yyyy'), 1167);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1168, to_date('10-07-2023', 'dd-mm-yyyy'), 1168);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1169, to_date('24-07-2023', 'dd-mm-yyyy'), 1169);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1170, to_date('26-07-2023', 'dd-mm-yyyy'), 1170);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1171, to_date('02-07-2023', 'dd-mm-yyyy'), 1171);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1172, to_date('22-07-2023', 'dd-mm-yyyy'), 1172);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1173, to_date('21-07-2023', 'dd-mm-yyyy'), 1173);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1174, to_date('08-07-2023', 'dd-mm-yyyy'), 1174);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1175, to_date('02-07-2023', 'dd-mm-yyyy'), 1175);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1176, to_date('29-07-2023', 'dd-mm-yyyy'), 1176);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1177, to_date('02-07-2023', 'dd-mm-yyyy'), 1177);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1178, to_date('10-07-2023', 'dd-mm-yyyy'), 1178);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1179, to_date('13-07-2023', 'dd-mm-yyyy'), 1179);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1180, to_date('11-07-2023', 'dd-mm-yyyy'), 1180);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1181, to_date('11-07-2023', 'dd-mm-yyyy'), 1181);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1182, to_date('19-07-2023', 'dd-mm-yyyy'), 1182);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1183, to_date('29-07-2023', 'dd-mm-yyyy'), 1183);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1184, to_date('09-07-2023', 'dd-mm-yyyy'), 1184);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1185, to_date('09-07-2023', 'dd-mm-yyyy'), 1185);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1186, to_date('23-07-2023', 'dd-mm-yyyy'), 1186);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1187, to_date('13-07-2023', 'dd-mm-yyyy'), 1187);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1188, to_date('29-07-2023', 'dd-mm-yyyy'), 1188);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1189, to_date('04-07-2023', 'dd-mm-yyyy'), 1189);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1190, to_date('21-07-2023', 'dd-mm-yyyy'), 1190);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1191, to_date('13-07-2023', 'dd-mm-yyyy'), 1191);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1192, to_date('11-07-2023', 'dd-mm-yyyy'), 1192);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1193, to_date('26-07-2023', 'dd-mm-yyyy'), 1193);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1195, to_date('06-07-2023', 'dd-mm-yyyy'), 1195);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1197, to_date('07-07-2023', 'dd-mm-yyyy'), 1197);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1198, to_date('24-07-2023', 'dd-mm-yyyy'), 1198);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1199, to_date('15-07-2023', 'dd-mm-yyyy'), 1199);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1200, to_date('22-07-2023', 'dd-mm-yyyy'), 1200);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1201, to_date('19-07-2023', 'dd-mm-yyyy'), 1201);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1202, to_date('12-07-2023', 'dd-mm-yyyy'), 1202);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1203, to_date('11-07-2023', 'dd-mm-yyyy'), 1203);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1204, to_date('09-07-2023', 'dd-mm-yyyy'), 1204);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1205, to_date('19-07-2023', 'dd-mm-yyyy'), 1205);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1206, to_date('02-07-2023', 'dd-mm-yyyy'), 1206);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1207, to_date('11-07-2023', 'dd-mm-yyyy'), 1207);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1208, to_date('19-07-2023', 'dd-mm-yyyy'), 1208);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1209, to_date('29-07-2023', 'dd-mm-yyyy'), 1209);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1210, to_date('14-07-2023', 'dd-mm-yyyy'), 1210);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1211, to_date('14-07-2023', 'dd-mm-yyyy'), 1211);
commit;
prompt 200 records committed...
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1212, to_date('04-07-2023', 'dd-mm-yyyy'), 1212);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1213, to_date('11-07-2023', 'dd-mm-yyyy'), 1213);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1214, to_date('05-07-2023', 'dd-mm-yyyy'), 1214);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1215, to_date('13-07-2023', 'dd-mm-yyyy'), 1215);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1216, to_date('16-07-2023', 'dd-mm-yyyy'), 1216);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1217, to_date('07-07-2023', 'dd-mm-yyyy'), 1217);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1218, to_date('12-07-2023', 'dd-mm-yyyy'), 1218);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1219, to_date('29-07-2023', 'dd-mm-yyyy'), 1219);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1220, to_date('09-07-2023', 'dd-mm-yyyy'), 1220);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1221, to_date('15-07-2023', 'dd-mm-yyyy'), 1221);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1222, to_date('09-07-2023', 'dd-mm-yyyy'), 1222);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1223, to_date('06-07-2023', 'dd-mm-yyyy'), 1223);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1224, to_date('14-07-2023', 'dd-mm-yyyy'), 1224);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1225, to_date('10-07-2023', 'dd-mm-yyyy'), 1225);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1226, to_date('28-07-2023', 'dd-mm-yyyy'), 1226);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1227, to_date('05-07-2023', 'dd-mm-yyyy'), 1227);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1228, to_date('07-07-2023', 'dd-mm-yyyy'), 1228);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1229, to_date('15-07-2023', 'dd-mm-yyyy'), 1229);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1230, to_date('26-07-2023', 'dd-mm-yyyy'), 1230);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1231, to_date('12-07-2023', 'dd-mm-yyyy'), 1231);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1232, to_date('11-07-2023', 'dd-mm-yyyy'), 1232);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1233, to_date('28-07-2023', 'dd-mm-yyyy'), 1233);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1234, to_date('05-07-2023', 'dd-mm-yyyy'), 1234);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1235, to_date('04-07-2023', 'dd-mm-yyyy'), 1235);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1236, to_date('22-07-2023', 'dd-mm-yyyy'), 1236);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1237, to_date('22-07-2023', 'dd-mm-yyyy'), 1237);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1238, to_date('09-07-2023', 'dd-mm-yyyy'), 1238);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1239, to_date('23-07-2023', 'dd-mm-yyyy'), 1239);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1240, to_date('04-07-2023', 'dd-mm-yyyy'), 1240);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1241, to_date('19-07-2023', 'dd-mm-yyyy'), 1241);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1243, to_date('16-07-2023', 'dd-mm-yyyy'), 1243);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1244, to_date('18-07-2023', 'dd-mm-yyyy'), 1244);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1245, to_date('09-07-2023', 'dd-mm-yyyy'), 1245);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1246, to_date('11-07-2023', 'dd-mm-yyyy'), 1246);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1247, to_date('24-07-2023', 'dd-mm-yyyy'), 1247);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1248, to_date('10-07-2023', 'dd-mm-yyyy'), 1248);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1249, to_date('11-07-2023', 'dd-mm-yyyy'), 1249);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1250, to_date('29-07-2023', 'dd-mm-yyyy'), 1250);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1251, to_date('25-07-2023', 'dd-mm-yyyy'), 1251);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1252, to_date('07-07-2023', 'dd-mm-yyyy'), 1252);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1253, to_date('23-07-2023', 'dd-mm-yyyy'), 1253);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1254, to_date('17-07-2023', 'dd-mm-yyyy'), 1254);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1255, to_date('28-07-2023', 'dd-mm-yyyy'), 1255);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1256, to_date('12-07-2023', 'dd-mm-yyyy'), 1256);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1257, to_date('28-07-2023', 'dd-mm-yyyy'), 1257);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1258, to_date('12-07-2023', 'dd-mm-yyyy'), 1258);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1259, to_date('26-07-2023', 'dd-mm-yyyy'), 1259);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1260, to_date('23-07-2023', 'dd-mm-yyyy'), 1260);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1261, to_date('03-07-2023', 'dd-mm-yyyy'), 1261);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1262, to_date('28-07-2023', 'dd-mm-yyyy'), 1262);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1263, to_date('06-07-2023', 'dd-mm-yyyy'), 1263);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1265, to_date('16-07-2023', 'dd-mm-yyyy'), 1265);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1266, to_date('20-07-2023', 'dd-mm-yyyy'), 1266);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1267, to_date('26-07-2023', 'dd-mm-yyyy'), 1267);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1268, to_date('15-07-2023', 'dd-mm-yyyy'), 1268);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1269, to_date('05-07-2023', 'dd-mm-yyyy'), 1269);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1270, to_date('24-07-2023', 'dd-mm-yyyy'), 1270);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1272, to_date('06-07-2023', 'dd-mm-yyyy'), 1272);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1273, to_date('19-07-2023', 'dd-mm-yyyy'), 1273);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1274, to_date('17-07-2023', 'dd-mm-yyyy'), 1274);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1275, to_date('10-07-2023', 'dd-mm-yyyy'), 1275);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1276, to_date('24-07-2023', 'dd-mm-yyyy'), 1276);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1277, to_date('22-07-2023', 'dd-mm-yyyy'), 1277);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1278, to_date('27-07-2023', 'dd-mm-yyyy'), 1278);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1279, to_date('27-07-2023', 'dd-mm-yyyy'), 1279);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1280, to_date('04-07-2023', 'dd-mm-yyyy'), 1280);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1281, to_date('08-07-2023', 'dd-mm-yyyy'), 1281);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1283, to_date('12-07-2023', 'dd-mm-yyyy'), 1283);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1284, to_date('24-07-2023', 'dd-mm-yyyy'), 1284);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1285, to_date('09-07-2023', 'dd-mm-yyyy'), 1285);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1286, to_date('20-07-2023', 'dd-mm-yyyy'), 1286);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1287, to_date('12-07-2023', 'dd-mm-yyyy'), 1287);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1288, to_date('07-07-2023', 'dd-mm-yyyy'), 1288);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1289, to_date('07-07-2023', 'dd-mm-yyyy'), 1289);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1290, to_date('29-07-2023', 'dd-mm-yyyy'), 1290);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1291, to_date('11-07-2023', 'dd-mm-yyyy'), 1291);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1292, to_date('10-07-2023', 'dd-mm-yyyy'), 1292);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1293, to_date('29-07-2023', 'dd-mm-yyyy'), 1293);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1294, to_date('17-07-2023', 'dd-mm-yyyy'), 1294);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1295, to_date('20-07-2023', 'dd-mm-yyyy'), 1295);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1296, to_date('05-07-2023', 'dd-mm-yyyy'), 1296);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1297, to_date('08-07-2023', 'dd-mm-yyyy'), 1297);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1298, to_date('07-07-2023', 'dd-mm-yyyy'), 1298);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1299, to_date('25-07-2023', 'dd-mm-yyyy'), 1299);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1300, to_date('11-07-2023', 'dd-mm-yyyy'), 1300);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1301, to_date('26-07-2023', 'dd-mm-yyyy'), 1301);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1302, to_date('15-07-2023', 'dd-mm-yyyy'), 1302);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1303, to_date('28-07-2023', 'dd-mm-yyyy'), 1303);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1304, to_date('03-07-2023', 'dd-mm-yyyy'), 1304);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1305, to_date('16-07-2023', 'dd-mm-yyyy'), 1305);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1306, to_date('05-07-2023', 'dd-mm-yyyy'), 1306);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1308, to_date('16-07-2023', 'dd-mm-yyyy'), 1308);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1309, to_date('09-07-2023', 'dd-mm-yyyy'), 1309);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1310, to_date('16-07-2023', 'dd-mm-yyyy'), 1310);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1311, to_date('17-07-2023', 'dd-mm-yyyy'), 1311);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1312, to_date('02-07-2023', 'dd-mm-yyyy'), 1312);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1313, to_date('24-07-2023', 'dd-mm-yyyy'), 1313);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1314, to_date('07-07-2023', 'dd-mm-yyyy'), 1314);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1315, to_date('20-07-2023', 'dd-mm-yyyy'), 1315);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1316, to_date('10-07-2023', 'dd-mm-yyyy'), 1316);
commit;
prompt 300 records committed...
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1317, to_date('13-07-2023', 'dd-mm-yyyy'), 1317);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1318, to_date('19-07-2023', 'dd-mm-yyyy'), 1318);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1319, to_date('22-07-2023', 'dd-mm-yyyy'), 1319);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1321, to_date('07-07-2023', 'dd-mm-yyyy'), 1321);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1322, to_date('17-07-2023', 'dd-mm-yyyy'), 1322);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1323, to_date('11-07-2023', 'dd-mm-yyyy'), 1323);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1324, to_date('06-07-2023', 'dd-mm-yyyy'), 1324);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1325, to_date('19-07-2023', 'dd-mm-yyyy'), 1325);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1326, to_date('20-07-2023', 'dd-mm-yyyy'), 1326);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1327, to_date('06-07-2023', 'dd-mm-yyyy'), 1327);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1328, to_date('21-07-2023', 'dd-mm-yyyy'), 1328);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1329, to_date('05-07-2023', 'dd-mm-yyyy'), 1329);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1330, to_date('19-07-2023', 'dd-mm-yyyy'), 1330);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1331, to_date('10-07-2023', 'dd-mm-yyyy'), 1331);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1332, to_date('11-07-2023', 'dd-mm-yyyy'), 1332);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1333, to_date('25-07-2023', 'dd-mm-yyyy'), 1333);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1334, to_date('28-07-2023', 'dd-mm-yyyy'), 1334);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1335, to_date('21-07-2023', 'dd-mm-yyyy'), 1335);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1336, to_date('13-07-2023', 'dd-mm-yyyy'), 1336);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1337, to_date('25-07-2023', 'dd-mm-yyyy'), 1337);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1338, to_date('08-07-2023', 'dd-mm-yyyy'), 1338);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1339, to_date('17-07-2023', 'dd-mm-yyyy'), 1339);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1340, to_date('12-07-2023', 'dd-mm-yyyy'), 1340);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1341, to_date('08-07-2023', 'dd-mm-yyyy'), 1341);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1342, to_date('09-07-2023', 'dd-mm-yyyy'), 1342);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1343, to_date('10-07-2023', 'dd-mm-yyyy'), 1343);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1344, to_date('06-07-2023', 'dd-mm-yyyy'), 1344);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1345, to_date('28-07-2023', 'dd-mm-yyyy'), 1345);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1346, to_date('17-07-2023', 'dd-mm-yyyy'), 1346);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1347, to_date('19-07-2023', 'dd-mm-yyyy'), 1347);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1348, to_date('25-07-2023', 'dd-mm-yyyy'), 1348);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1351, to_date('21-07-2023', 'dd-mm-yyyy'), 1351);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1352, to_date('09-07-2023', 'dd-mm-yyyy'), 1352);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1353, to_date('27-07-2023', 'dd-mm-yyyy'), 1353);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1354, to_date('28-07-2023', 'dd-mm-yyyy'), 1354);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1355, to_date('28-07-2023', 'dd-mm-yyyy'), 1355);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1356, to_date('15-07-2023', 'dd-mm-yyyy'), 1356);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1357, to_date('25-07-2023', 'dd-mm-yyyy'), 1357);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1358, to_date('04-07-2023', 'dd-mm-yyyy'), 1358);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1360, to_date('02-07-2023', 'dd-mm-yyyy'), 1360);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1361, to_date('15-07-2023', 'dd-mm-yyyy'), 1361);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1362, to_date('18-07-2023', 'dd-mm-yyyy'), 1362);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1363, to_date('05-07-2023', 'dd-mm-yyyy'), 1363);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1364, to_date('24-07-2023', 'dd-mm-yyyy'), 1364);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1365, to_date('22-07-2023', 'dd-mm-yyyy'), 1365);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1366, to_date('02-07-2023', 'dd-mm-yyyy'), 1366);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1367, to_date('14-07-2023', 'dd-mm-yyyy'), 1367);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1368, to_date('16-07-2023', 'dd-mm-yyyy'), 1368);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1369, to_date('28-07-2023', 'dd-mm-yyyy'), 1369);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1370, to_date('09-07-2023', 'dd-mm-yyyy'), 1370);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1371, to_date('22-07-2023', 'dd-mm-yyyy'), 1371);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1372, to_date('28-07-2023', 'dd-mm-yyyy'), 1372);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1373, to_date('23-07-2023', 'dd-mm-yyyy'), 1373);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1374, to_date('29-07-2023', 'dd-mm-yyyy'), 1374);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1375, to_date('03-07-2023', 'dd-mm-yyyy'), 1375);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1378, to_date('08-07-2023', 'dd-mm-yyyy'), 1378);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1379, to_date('10-07-2023', 'dd-mm-yyyy'), 1379);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1380, to_date('25-07-2023', 'dd-mm-yyyy'), 1380);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1381, to_date('11-07-2023', 'dd-mm-yyyy'), 1381);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1382, to_date('14-07-2023', 'dd-mm-yyyy'), 1382);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1383, to_date('05-07-2023', 'dd-mm-yyyy'), 1383);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1385, to_date('14-07-2023', 'dd-mm-yyyy'), 1385);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1386, to_date('28-07-2023', 'dd-mm-yyyy'), 1386);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1387, to_date('15-07-2023', 'dd-mm-yyyy'), 1387);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1389, to_date('16-07-2023', 'dd-mm-yyyy'), 1389);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1390, to_date('26-07-2023', 'dd-mm-yyyy'), 1390);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1391, to_date('26-07-2023', 'dd-mm-yyyy'), 1391);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1392, to_date('28-07-2023', 'dd-mm-yyyy'), 1392);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1393, to_date('27-07-2023', 'dd-mm-yyyy'), 1393);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1394, to_date('06-07-2023', 'dd-mm-yyyy'), 1394);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1395, to_date('23-07-2023', 'dd-mm-yyyy'), 1395);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1396, to_date('11-07-2023', 'dd-mm-yyyy'), 1396);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1397, to_date('25-07-2023', 'dd-mm-yyyy'), 1397);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1398, to_date('21-07-2023', 'dd-mm-yyyy'), 1398);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1399, to_date('19-07-2023', 'dd-mm-yyyy'), 1399);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1400, to_date('17-07-2023', 'dd-mm-yyyy'), 1400);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1401, to_date('07-07-2023', 'dd-mm-yyyy'), 1401);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1402, to_date('18-07-2023', 'dd-mm-yyyy'), 1402);
insert into PAYMENT_REPORT (payment_id, payment_date, booking_id)
values (1403, to_date('19-07-2023', 'dd-mm-yyyy'), 1403);
commit;
prompt 379 records loaded
prompt Enabling triggers for TICKET...
alter table TICKET enable all triggers;
prompt Enabling triggers for BAGGAGE...
alter table BAGGAGE enable all triggers;
prompt Enabling triggers for PASSENGER...
alter table PASSENGER enable all triggers;
prompt Enabling triggers for TICKETSELLER...
alter table TICKETSELLER enable all triggers;
prompt Enabling triggers for BOOKING...
alter table BOOKING enable all triggers;
prompt Enabling triggers for BUS...
alter table BUS enable all triggers;
prompt Enabling triggers for DRIVER...
alter table DRIVER enable all triggers;
prompt Enabling triggers for SCHEDULE...
alter table SCHEDULE enable all triggers;
prompt Enabling triggers for STATION...
alter table STATION enable all triggers;
prompt Enabling triggers for LINE...
alter table LINE enable all triggers;
prompt Enabling triggers for BUSRIDE...
alter table BUSRIDE enable all triggers;
prompt Enabling triggers for TAXI...
alter table TAXI enable all triggers;
prompt Enabling triggers for DRIVESINTAXI...
alter table DRIVESINTAXI enable all triggers;
prompt Enabling triggers for PAYMENT_REPORT...
alter table PAYMENT_REPORT enable all triggers;

set feedback on
set define on
prompt Done
