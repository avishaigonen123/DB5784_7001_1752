-- add new field to BusRide, and also add foreign key constraint
ALTER TABLE BusRide
ADD TicketID NUMBER(38);

ALTER TABLE BusRide
ADD CONSTRAINT fk_TicketID FOREIGN KEY (TicketID) REFERENCES Ticket(TICKET_ID);
