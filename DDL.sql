--캠핑장 소유자--
CREATE TABLE Campsite_Owner (
campsite_id NUMBER(10) PRIMARY KEY,
owner_id NUMBER(10) NOT NULL,
campsite_name VARCHAR2(255) NOT NULL,
contact_info VARCHAR2(255) NOT NULL
);


--사이트--
CREATE TABLE Site (
site_id NUMBER(10) PRIMARY KEY,
site_type VARCHAR2(50) NOT NULL,
site_name VARCHAR2(255) NOT NULL,
capacity NUMBER(3) NOT NULL,
location VARCHAR2(255) NOT NULL,
campsite_id NUMBER(10) NOT NULL,
CONSTRAINT site_fk1 FOREIGN KEY (campsite_id) REFERENCES Campsite_Owner(campsite_id)
);


--캠퍼--
CREATE TABLE Camper (
camper_id NUMBER(10) PRIMARY KEY,
password VARCHAR2(255) NOT NULL,
gender VARCHAR2(10) NOT NULL,
age NUMBER(3) NOT NULL,
address VARCHAR2(255) NOT NULL
);


--예약--
CREATE TABLE Reservation (
reservation_id NUMBER(10) PRIMARY KEY,
camper_id NUMBER(10) NOT NULL,
site_id NUMBER(10) NOT NULL,
check_in_date DATE NOT NULL,
check_out_date DATE NOT NULL,
num_occupants NUMBER(3) NOT NULL,
addl_services VARCHAR2(255),
CONSTRAINT reservation_fk1 FOREIGN KEY (camper_id) REFERENCES Camper (camper_id),
CONSTRAINT reservation_fk2 FOREIGN KEY (site_id) REFERENCES Site (site_id)
);


--후기--
CREATE TABLE Review (
camper_id NUMBER(10),
campsite_id NUMBER(10),
rating NUMBER(1) NOT NULL,
feedback VARCHAR2(255),
date_written DATE NOT NULL,
CONSTRAINT review_pk PRIMARY KEY (camper_id, campsite_id),
CONSTRAINT review_fk1 FOREIGN KEY (camper_id) REFERENCES Camper (camper_id),
CONSTRAINT review_fk2 FOREIGN KEY (campsite_id) REFERENCES Campsite_Owner (campsite_id)
);