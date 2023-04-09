-- Segment, total user count and users who booked flight in apr 2022

Select u.segment, count(distinct u.user_id) as no_of_users
,count(distinct case When b.Line_of_business = 'flight' and b.Booking_date between '2022-04-01' and '2022-04-30' then b.user_id end) as user_who_booked_flight_in_apr2022
from user_table u
left Join booking_table b on b.user_id = u.user_id
Group by u.segment;


-- Identify users whose first booking was a hotel booking

Select * from (
Select * 
, rank() over (partition by user_id order by booking_date) as rn
from booking_table) a
where rn=1 and Line_of_business = 'hotel'


-- Calculate the days between first and last booking of each user

Select user_id, min(booking_date), max(booking_date),
Datediff(day, min(booking_date), max(booking_date)) as no_of_days
from booking_table 
group by user_id


-- Count the number of flights and hotel booking in each of the user segments 

SELECT Segment,
SUM(CASE WHEN Line_of_business='Flight' THEN 1 ELSE 0 END)AS No_of_Flights ,
SUM(CASE WHEN Line_of_business='Hotel' THEN 1 ELSE 0 END)AS No_of_Hotels
FROM booking_table a
INNER JOIN User_table b ON a.User_id=b.User_id
GROUP BY Segment