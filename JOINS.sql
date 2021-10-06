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
--Fire events by date (period to period)
--Number of fire events per LGA
--Biggest fire event per LGA

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
SELECT DAMAGE_COST.Damage_Cost AS "Damage Cost(R)",property.prop_id AS "Property ID" FROM DAMAGE_COST
INNER JOIN PROPERTY ON DAMAGE_COST.Prop_ID = PROPERTY.Prop_ID
ORDER BY Damage_Cost DESC;

--Number of buildings damaged by time period
--Properties/Buildings by Size
--All properties within a certain area
--Properties/buildings according to owner type or owner
