INSERT ALL
INTO FIRE_LGA VALUES (
  Event_ID, LGA_Code, Event_Date
SELECT * FROM DUAL;

INSERT ALL
INTO FIRE_EVENT VALUES (
  Event_ID, Event_Name, Event_Lat, Event_Long, Event_AreaSize, Event_LivesLost
SELECT * FROM DUAL;

INSERT ALL
INTO LGA VALUES (
  LGA_Code, LGA_Name, LGA_Area, LGA_Size, LGA_CEO, LGA_ContactNum
SELECT * FROM DUAL;

INSERT ALL
INTO PROPERTY VALUES (
  Prop_ID, LGA_Code, Owner_ID, Type_ID, Prop_City, Prop_Suburb, Prop_StreetName, Prop_Size
SELECT * FROM DUAL;

INSERT ALL
INTO PROPERTY_TYPE VALUES (
  Type_ID, Prop_Type
SELECT * FROM DUAL;

INSERT ALL
INTO OWNER VALUES (
  Owner_ID, Owner_Type, Owner_ContactNum, Owner_Name, Owner_Surname, Bus_Type, Bus_Reg_Nr, BC_Employer
SELECT * FROM DUAL;

INSERT ALL
INTO OWNER_TYPE VALUES (
  Owner_Type, Owner_Description
SELECT * FROM DUAL;

INSERT ALL
INTO BUILDING VALUES (
  Building_ID, Prop_ID, Insurance_Code, Date_Approved, Building_Size, Building_Class
SELECT * FROM DUAL;

INSERT ALL
INTO DAMAGE_COST VALUES (
  Building_ID, Prop_ID, Event_ID, Assessor_ID, LGA_Code, Damage_Cost, Is_Destroyed
SELECT * FROM DUAL;

INSERT ALL
INTO ASSESSOR VALUES (
  Assessor_ID, Assessor_Name, Assessor_Surname, Assessor_ContactNum
SELECT * FROM DUAL;

INSERT ALL
INTO INSURANCE VALUES (
  Insurance_Code, Insurance_Name, Insurance_ContactNum
SELECT * FROM DUAL;

INSERT ALL
INTO ASSESSOR_HISTORY VALUES (
  Insurance_Code, Assessor_ID, Start_Date, End_Date
SELECT * FROM DUAL;

COMMIT;
