-- Generated by Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   at:        2021-10-08 11:14:53 CAT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

-- Group Members:
-- [32969694 - L Anthony] – (Group Leader)
-- [30010993 - MC Steyn]
-- [28612337 - CL Isaacs]
-- [31614132 - Z Stoltz]
-- [31775357 - S Boshoff]
-- [33648263 - L Steyn]
-- [31591272 - MG Visagie]
-- [28739213 - S Pietersen]
-- [25909932 - N van der Linde]

DROP TABLE FIRE_EVENT CASCADE CONSTRAINTS;
DROP TABLE FIRE_LGA CASCADE CONSTRAINTS;
DROP TABLE LGA CASCADE CONSTRAINTS;
DROP TABLE PROPERTY CASCADE CONSTRAINTS;
DROP TABLE BUILDING CASCADE CONSTRAINTS;
DROP TABLE PROPERTY_TYPE CASCADE CONSTRAINTS;
DROP TABLE OWNER CASCADE CONSTRAINTS;
DROP TABLE OWNER_TYPE CASCADE CONSTRAINTS;
DROP TABLE INSURANCE CASCADE CONSTRAINTS;
DROP TABLE ASSESSOR_HISTORY CASCADE CONSTRAINTS;
DROP TABLE ASSESSOR CASCADE CONSTRAINTS;
DROP TABLE DAMAGE_COST CASCADE CONSTRAINTS;

CREATE TABLE assessor (
    assessor_id         NUMBER(10) NOT NULL,
    assessor_name       VARCHAR2(50) NOT NULL,
    assessor_surname    VARCHAR2(50) NOT NULL,
    assessor_contactnum CHAR(10) NOT NULL
);

ALTER TABLE assessor
    ADD CONSTRAINT check_phone CHECK ( length(assessor_contactnum) = 10 );

ALTER TABLE assessor ADD CONSTRAINT pk_assessor PRIMARY KEY ( assessor_id );

ALTER TABLE assessor ADD CONSTRAINT unq_assessor_contactnum UNIQUE ( assessor_contactnum );

CREATE TABLE assessor_history (
    insurance_code NUMBER(10) NOT NULL,
    assessor_id    NUMBER(10) NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE
);

ALTER TABLE assessor_history ADD CONSTRAINT pk_assessor_history PRIMARY KEY ( insurance_code,
                                                                              assessor_id );

CREATE TABLE building (
    building_id    NUMBER(10) NOT NULL,
    prop_id        NUMBER(10) NOT NULL,
    insurance_code NUMBER(10) NOT NULL,
    date_approved  DATE NOT NULL,
    building_size  FLOAT(10) NOT NULL,
    building_class CHAR(2) NOT NULL
);

ALTER TABLE building ADD CONSTRAINT pk_building PRIMARY KEY ( building_id,
                                                              prop_id );

CREATE TABLE damage_cost (
    building_id  NUMBER(10) NOT NULL,
    prop_id      NUMBER(10) NOT NULL,
    event_id     NUMBER(10) NOT NULL,
    assessor_id  NUMBER(10),
    lga_code     NUMBER(10),
    damage_cost  FLOAT(10) NOT NULL,
    is_destroyed CHAR(1) DEFAULT 'N' NOT NULL
);

ALTER TABLE damage_cost
    ADD CONSTRAINT pk_damage_cost PRIMARY KEY ( building_id,
                                                prop_id,
                                                event_id );

CREATE TABLE fire_event (
    event_id        NUMBER(10) NOT NULL,
    event_name      VARCHAR2(50) NOT NULL,
    event_lat       FLOAT(10) NOT NULL,
    event_long      FLOAT(10) NOT NULL,
    "FLOAT"         unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    event_liveslost NUMBER(10)
);

ALTER TABLE fire_event ADD CONSTRAINT pk_fire_event PRIMARY KEY ( event_id );

CREATE TABLE fire_lga (
    event_id   NUMBER(10) NOT NULL,
    lga_code   NUMBER(10) NOT NULL,
    event_date DATE NOT NULL
);

ALTER TABLE fire_lga ADD CONSTRAINT pk_fire_lga PRIMARY KEY ( event_id,
                                                              lga_code );

CREATE TABLE insurance (
    insurance_code       NUMBER(10) NOT NULL,
    insurance_name       VARCHAR2(50) NOT NULL,
    insurance_contactnum CHAR(10) NOT NULL
);

ALTER TABLE insurance
    ADD CONSTRAINT check_insurance_phone CHECK ( length(insurance_contactnum) = 10 );

ALTER TABLE insurance ADD CONSTRAINT pk_insurance PRIMARY KEY ( insurance_code );

ALTER TABLE insurance ADD CONSTRAINT unq_insurance_contactnum UNIQUE ( insurance_contactnum );

CREATE TABLE lga (
    lga_code       NUMBER(10) NOT NULL,
    lga_name       VARCHAR2(50) NOT NULL,
    lga_area       FLOAT(10) NOT NULL,
    lga_size       FLOAT(10) NOT NULL,
    lga_ceo        VARCHAR2(50) NOT NULL,
    lga_contactnum CHAR(10) NOT NULL
);

ALTER TABLE lga
    ADD CONSTRAINT check_lga_phone CHECK ( length(lga_contactnum) = 10 );

ALTER TABLE lga ADD CONSTRAINT pk_lga PRIMARY KEY ( lga_code );

ALTER TABLE lga ADD CONSTRAINT unq_lga_contactnum UNIQUE ( lga_contactnum );

ALTER TABLE lga ADD CONSTRAINT unq_lga_ceo UNIQUE ( lga_ceo );

CREATE TABLE owner (
    owner_id         NUMBER(10) NOT NULL,
    owner_type       NUMBER(10) NOT NULL,
    owner_contactnum CHAR(10) NOT NULL,
    owner_name       VARCHAR2(50),
    owner_surname    VARCHAR2(50),
    bus_type         VARCHAR2(50),
    bus_reg_num      CHAR(14),
    bc_employer      VARCHAR2(50)
);

ALTER TABLE owner
    ADD CONSTRAINT check_owner_contactnum CHECK ( length(owner_contactnum) = 10 );

ALTER TABLE owner
    ADD CONSTRAINT check_bus_reg_num CHECK ( length(bus_reg_num) <= 14 );

ALTER TABLE owner ADD CONSTRAINT pk_owner PRIMARY KEY ( owner_id );

CREATE TABLE owner_type (
    owner_type       NUMBER(10) NOT NULL,
    type_description VARCHAR2(50) NOT NULL
);

ALTER TABLE owner_type
    ADD CONSTRAINT check_owner_type CHECK ( type_description IN ( 'Individual', 'Business', 'Body Corporate' ) );

ALTER TABLE owner_type ADD CONSTRAINT pk_owner_type PRIMARY KEY ( owner_type );

ALTER TABLE owner_type ADD CONSTRAINT unq_owner_type UNIQUE ( type_description );

CREATE TABLE property (
    prop_id         NUMBER(10) NOT NULL,
    lga_code        NUMBER(10) NOT NULL,
    type_id         NUMBER(10) NOT NULL,
    owner_id        NUMBER(10) NOT NULL,
    prop_city       VARCHAR2(50) NOT NULL,
    prop_suburb     VARCHAR2(50) NOT NULL,
    prop_streetname VARCHAR2(50) NOT NULL,
    prop_size       FLOAT NOT NULL
);

ALTER TABLE property ADD CONSTRAINT pk_property PRIMARY KEY ( prop_id );

CREATE TABLE property_type (
    type_id   NUMBER(10) NOT NULL,
    prop_type CHAR(1) NOT NULL
);

ALTER TABLE property_type
    ADD CONSTRAINT check_prop_type CHECK ( prop_type IN ( 'Residential', 'Farm', 'Business' ) );

ALTER TABLE property_type ADD CONSTRAINT pk_prop_type PRIMARY KEY ( type_id );

ALTER TABLE property_type ADD CONSTRAINT unq_prop_type UNIQUE ( prop_type );

ALTER TABLE assessor_history
    ADD CONSTRAINT fk1_assessor_history FOREIGN KEY ( insurance_code )
        REFERENCES insurance ( insurance_code );

ALTER TABLE building
    ADD CONSTRAINT fk1_building FOREIGN KEY ( prop_id )
        REFERENCES property ( prop_id );

ALTER TABLE damage_cost
    ADD CONSTRAINT fk1_damage_cost FOREIGN KEY ( building_id,
                                                 prop_id )
        REFERENCES building ( building_id,
                              prop_id );

ALTER TABLE fire_lga
    ADD CONSTRAINT fk1_fire_lga FOREIGN KEY ( event_id )
        REFERENCES fire_event ( event_id );

ALTER TABLE owner
    ADD CONSTRAINT fk1_owner FOREIGN KEY ( owner_type )
        REFERENCES owner_type ( owner_type );

ALTER TABLE property
    ADD CONSTRAINT fk1_property FOREIGN KEY ( lga_code )
        REFERENCES lga ( lga_code );

ALTER TABLE assessor_history
    ADD CONSTRAINT fk2_assessor_history FOREIGN KEY ( assessor_id )
        REFERENCES assessor ( assessor_id );

ALTER TABLE building
    ADD CONSTRAINT fk2_building FOREIGN KEY ( insurance_code )
        REFERENCES insurance ( insurance_code );

ALTER TABLE damage_cost
    ADD CONSTRAINT fk2_damage_cost FOREIGN KEY ( event_id )
        REFERENCES fire_event ( event_id );

ALTER TABLE fire_lga
    ADD CONSTRAINT fk2_fire_lga FOREIGN KEY ( lga_code )
        REFERENCES lga ( lga_code );

ALTER TABLE property
    ADD CONSTRAINT fk2_property FOREIGN KEY ( type_id )
        REFERENCES property_type ( type_id );

ALTER TABLE damage_cost
    ADD CONSTRAINT fk3_damage_cost FOREIGN KEY ( assessor_id )
        REFERENCES assessor ( assessor_id );

ALTER TABLE damage_cost
    ADD CONSTRAINT fk3_damage_costv1 FOREIGN KEY ( lga_code )
        REFERENCES lga ( lga_code );

ALTER TABLE property
    ADD CONSTRAINT fk3_property FOREIGN KEY ( owner_id )
        REFERENCES owner ( owner_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   1
-- WARNINGS                                 0
