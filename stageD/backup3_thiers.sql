prompt PL/SQL Developer Export Tables for user C##ORIPERL@XE
prompt Created by USER on יום שני 24 יוני 2024
set feedback off
set define off

prompt Dropping TICKET...
drop table TICKET cascade constraints;
prompt Dropping BAGGAGE...
drop table BAGGAGE cascade constraints;
prompt Dropping PASSENGER...
drop table PASSENGER cascade constraints;
prompt Dropping TICKETSELLER...
drop table TICKETSELLER cascade constraints;
prompt Dropping BOOKING...
drop table BOOKING cascade constraints;
prompt Dropping PAYMENT_REPORT...
drop table PAYMENT_REPORT cascade constraints;
prompt Creating TICKET...
create table TICKET
(
  ticket_id    NUMBER(38) not null,
  ticket_type  VARCHAR2(255) default 'Regular' not null,
  ticket_price FLOAT not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKET
  add primary key (TICKET_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BAGGAGE
  add primary key (BAGGAGE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PASSENGER
  add primary key (PASSENGER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TICKETSELLER...
create table TICKETSELLER
(
  seller_id      NUMBER(38) not null,
  seller_name    VARCHAR2(255) not null,
  seller_contact VARCHAR2(255) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKETSELLER
  add primary key (SELLER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKING
  add primary key (BOOKING_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKING
  add constraint UC_BOOKING_JOURNEYID unique (JOURNEY_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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

prompt Creating PAYMENT_REPORT...
create table PAYMENT_REPORT
(
  payment_id   NUMBER(38) not null,
  payment_date DATE not null,
  booking_id   NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENT_REPORT
  add primary key (PAYMENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
prompt Disabling triggers for PAYMENT_REPORT...
alter table PAYMENT_REPORT disable all triggers;
prompt Disabling foreign key constraints for BAGGAGE...
alter table BAGGAGE disable constraint SYS_C008542;
prompt Disabling foreign key constraints for BOOKING...
alter table BOOKING disable constraint SYS_C008550;
alter table BOOKING disable constraint SYS_C008551;
alter table BOOKING disable constraint SYS_C008552;
prompt Disabling foreign key constraints for PAYMENT_REPORT...
alter table PAYMENT_REPORT disable constraint SYS_C008563;
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
prompt Enabling foreign key constraints for BAGGAGE...
alter table BAGGAGE enable constraint SYS_C008542;
prompt Enabling foreign key constraints for BOOKING...
alter table BOOKING enable constraint SYS_C008550;
alter table BOOKING enable constraint SYS_C008551;
alter table BOOKING enable constraint SYS_C008552;
prompt Enabling foreign key constraints for PAYMENT_REPORT...
alter table PAYMENT_REPORT enable constraint SYS_C008563;
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
prompt Enabling triggers for PAYMENT_REPORT...
alter table PAYMENT_REPORT enable all triggers;

set feedback on
set define on
prompt Done
