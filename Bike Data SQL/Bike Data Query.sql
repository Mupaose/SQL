--USE bikedata

SELECT *
FROM [dbo].['202206_tripdata$']

-- number of rows
SELECT COUNT(*)
FROM [dbo].['202206_tripdata$']

-- select casual only
SELECT *
FROM [dbo].['202206_tripdata$']
WHERE member_casual = 'casual'

-- select member only
SELECT TOP 100 *
FROM [dbo].['202206_tripdata$']
WHERE member_casual = 'member'

-- select type, id, end & start station & convert length to time format
SELECT
rideable_type,
ride_id,
CAST(ride_length AS time) ride_length,
start_station_name,
end_station_name,
member_casual
FROM [dbo].['202206_tripdata$']

--removing NULL values
SELECT start_station_name, start_station_id, end_station_name
FROM [dbo].['202206_tripdata$']
WHERE start_station_name IS NOT NULL AND start_station_id IS NOT NULL AND end_station_name IS NOT NULL

--SELECT *
--FROM [dbo].['202206_tripdata$']


-- average ride length

--WITH temp_table
--AS
--(
--SELECT CAST(ride_length AS time) AS ride_length
--FROM [dbo].['202206_tripdata$']
--)

--SELECT AVG(ride_length)
--FROM [dbo].['202206_tripdata$'], temp_table
		

--distinct start stations & end stations
SELECT 
COUNT(DISTINCT(start_station_name)) total_start_stations,
COUNT(DISTINCT(end_station_name)) total_end_station
FROM [dbo].['202206_tripdata$']

SELECT *
FROM [dbo].['202206_tripdata$']


-- identify day of rides per type of user and location.
SELECT
ride_id,
rideable_type,
start_station_name,
end_station_name,
CASE WHEN day_of_week = 2 THEN 'Monday'
	WHEN day_of_week = 3 THEN 'Tuesday'
	WHEN day_of_week = 4 THEN 'Wednesday'
	WHEN day_of_week = 5 THEN 'Thursday'
	WHEN day_of_week = 6 THEN 'Friday'
	ELSE 'Weekend'
END AS day_of_week
FROM [dbo].['202206_tripdata$']
WHERE start_station_name IS NOT NULL AND end_station_name IS NOT NULL

--simplifying the above
SELECT
ride_id,
rideable_type,
start_station_name,
end_station_name,
CASE WHEN day_of_week IN (1,2,3,4,5) THEN 'Monday'
	ELSE 'Weekend'
END AS day_of_week
FROM [dbo].['202206_tripdata$']
WHERE start_station_name IS NOT NULL AND end_station_name IS NOT NULL

SELECT *
FROM [dbo].['202206_tripdata$']


--USE [bikedata]
SELECT * FROM [dbo].['202206_tripdata$']


-- number of trips per DISTINCT stations for members or casual
SELECT 
DISTINCT start_station_name,
SUM(
	CASE WHEN ride_id = ride_id AND start_station_name = start_station_name THEN 1 ELSE 0 END
	) AS total,
SUM(CASE WHEN member_casual = 'member' AND start_station_name = start_station_name THEN 1 ELSE 0 END
	) AS member,
SUM(CASE WHEN member_casual = 'casual' AND start_station_name = start_station_name THEN 1 ELSE 0 END
	) AS casual
FROM [dbo].['202206_tripdata$']
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY total DESC
	
