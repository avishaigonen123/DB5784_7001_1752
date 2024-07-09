-- Create view 1 (Receiving_Team_Line_View)
-- View to show integrated line details with start and end station names
CREATE VIEW Receiving_Team_Line_View AS
SELECT l.lineid, l.linename, s1.stationname AS start_station, s2.stationname AS end_station
FROM LINE l
JOIN STATION s1 ON l.startofstationid = s1.stationid
JOIN STATION s2 ON l.endofstationid = s2.stationid;

-- Query 1 on view 1 (Receiving_Team_Line_View)
-- Retrieve the lines which starts in start_station entered by input
SELECT linename, start_station, end_station
FROM Receiving_Team_Line_View
WHERE start_station = '&<name="StartStation" list="SELECT start_station from Receiving_Team_Line_View">';
      
-- Query 2 on view 1 (Receiving_Team_Line_View)
-- Retrieve all linenames
SELECT linename
FROM Receiving_Team_Line_View;

-- create view 2 (Original_Team_Ticket_View)
CREATE VIEW Original_Team_Ticket_View AS
SELECT t.ticket_id, t.ticket_type, t.ticket_price,
       b.booking_id, b.booking_date, b.journey_id,
       p.passenger_name, s.seller_name
FROM TICKET t
JOIN BOOKING b ON t.ticket_id = b.ticket_id
JOIN PASSENGER p ON b.passenger_id = p.passenger_id
JOIN TICKETSELLER s ON b.seller_id = s.seller_id;

SELECT * FROM Original_Team_Ticket_View

-- Query 1 on view 2 (Original_Team_Ticket_View)
-- Retrieve the total revenue generated by each ticket type
SELECT ticket_type, SUM(ticket_price) AS total_revenue
FROM Original_Team_Ticket_View
GROUP BY ticket_type
ORDER BY total_revenue DESC;


-- Query 2 on view 2 (Original_Team_Ticket_View)
-- Retrieve the average ticket price for each seller
SELECT s.seller_name, AVG(V.ticket_price) AS avg_ticket_price
FROM Original_Team_Ticket_View v
JOIN TICKETSELLER s ON v.seller_name = s.seller_name
GROUP BY s.seller_name
ORDER BY avg_ticket_price DESC;