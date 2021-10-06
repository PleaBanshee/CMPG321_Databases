--Number of damaged buildings on a property
SELECT Prop_ID AS "Prop_ID", Is_Destroyed AS "Destroyed"
FROM Property
NATURAL JOIN Damage_Cost
WHERE Is_Destroyed = 'T';

--All buildings covered by a particular insurer
SELECT Building_ID AS "Building", Insurance_Name AS "Ins_Name"
FROM Building
NATURAL JOIN Insurance
WHERE Insurance_Name = 'Old Mutual';

--Fire events by date (Asc or Desc)
SELECT FIRE_EVENT.Event_Name, FIRE_LGA.Event_Date
FROM FIRE_EVENT
INNER JOIN FIRE_LGA ON FIRE_LGA.Event_ID = FIRE_EVENT.Event_ID
ORDER BY FIRE_LGA.Event_Date;

--Fire events by date (period to period)
SELECT FIRE_EVENT.Event_Name, FIRE_LGA.Event_Date
FROM FIRE_EVENT
INNER JOIN FIRE_LGA on FIRE_LGA.Event_ID = FIRE_EVENT.Event_ID
WHERE FIRE_LGA.Event_Date BETWEEN '01-APR-21' AND '31-AUG-21'
ORDER BY FIRE_LGA.Event_Date;

--Number of fire events per LGA
SELECT LGA.Lga_Name, COUNT(FIRE_LGA.LGA_Code) AS "Number of fire events"
FROM LGA
INNER JOIN FIRE_LGA ON LGA.LGA_Code = FIRE_LGA.LGA_Code
GROUP BY LGA.LGA_Name;

--Biggest fire event per LGA
SELECT LGA.LGA_Name, FIRE_EVENT.Event_Name, MAX(FIRE_EVENT.Event_Areasize) AS "Area Size"
FROM LGA
INNER JOIN FIRE_LGA ON LGA.LGA_Code = FIRE_EVENT.Event_ID
INNER JOIN FIRE_EVENT ON FIRE_LGA.Event_ID = FIRE_EVENT.Event_ID
GROUP BY LGA.LGA_Name, FIRE_EVENT.Event_Name;

--Highest body count per LGA
--List of owners by type
--Owner contact details
--All owners sorted alphabetically be surname

--List of assessor histories (between dates)
--Number of assessments done by a assessor
SELECT ASSESSOR.Assessor_Name AS Name,ASSESSOR.Assessor_Surname AS Surname,(COUNT(DAMAGE_COST.Assessor_ID)) AS "Number of Assessments" FROM DAMAGE_COST 
INNER JOIN ASSESSOR ON DAMAGE_COST.Assessor_ID = ASSESSOR.Assessor_ID
GROUP BY assessor.assessor_id, ASSESSOR.Assessor_Name, ASSESSOR.Assessor_Surname;
--Overall (total) damage cost
SELECT SUM(Damage_Cost) AS "Total Damage Cost(R)" FROM DAMAGE_COST;
--Damage Costs DESC
SELECT DAMAGE_COST.Damage_Cost AS "Damage Cost(R)",PROPERTY.Prop_Name AS "Property" FROM DAMAGE_COST
INNER JOIN PROPERTY ON DAMAGE_COST.Prop_ID = PROPERTY.Prop_ID
ORDER BY Damage_Cost DESC;

--Number of buildings damaged by time period
SELECT Building_ID AS "Build_ID", Is_Destroyed AS "Destroyed"
FROM Building
NATURAL JOIN Damage_Cost
WHERE Is_Destroyed = 'T'
ORDER BY Event_Date;

--Properties/Buildings by Size
SELECT Building_ID AS "Build_ID", Prop_ID AS "Prop_ID"
FROM Building
NATURAL JOIN Property
ORDER BY Building_Size;

--All properties within a certain area
SELECT Prop_ID AS "Prop_ID"
FROM Property
NATURAL JOIN Owner
ORDER BY Prop_City;

--Properties/buildings according to owner type or owner
SELECT Prop_ID AS "Prop_ID", Owner_ID AS "Owner_ID"
FROM Property
NATURAL JOIN Owner
ORDER BY Owner_Type;