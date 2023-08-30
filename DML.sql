INSERT INTO Campsite_Owner (campsite_id, owner_id, campsite_name, contact_info)
VALUES (1, 1001, 'Pine Ridge Campground', '010-2131-4233');

INSERT INTO Campsite_Owner (campsite_id, owner_id, campsite_name, contact_info)
VALUES (2, 1002, 'Lakeview Campsite', '010-3124-7657');

INSERT INTO Campsite_Owner (campsite_id, owner_id, campsite_name, contact_info)
VALUES (3, 1003, 'Mountain Retreat', '010-1323-3435');

INSERT INTO Campsite_Owner (campsite_id, owner_id, campsite_name, contact_info)
VALUES (4, 1004, 'Riverside Campground', '010-5345-3123');

INSERT INTO Campsite_Owner (campsite_id, owner_id, campsite_name, contact_info)
VALUES (5, 1005, 'Sunset Valley Campsite', '010-4353-3221');



INSERT INTO Site (site_id, site_type, site_name, capacity, location, campsite_id)
VALUES (1, 'Tent', 'Site A', 5, 'Forest Area', 1);

INSERT INTO Site (site_id, site_type, site_name, capacity, location, campsite_id)
VALUES (2, 'RV', 'Site B', 3, 'Lakefront', 1);

INSERT INTO Site (site_id, site_type, site_name, capacity, location, campsite_id)
VALUES (3, 'Cabin', 'Site C', 2, 'Mountain View', 2);

INSERT INTO Site (site_id, site_type, site_name, capacity, location, campsite_id)
VALUES (4, 'Tent', 'Site D', 4, 'Riverbank', 2);

INSERT INTO Site (site_id, site_type, site_name, capacity, location, campsite_id)
VALUES (5, 'RV', 'Site E', 6, 'Valley Area', 3);



INSERT INTO Camper (camper_id, password, gender, age, address)
VALUES (1, 'pass123', 'Male', 28, '1234 Main St');

INSERT INTO Camper (camper_id, password, gender, age, address)
VALUES (2, 'letmein', 'Female', 35, '5678 Elm St');

INSERT INTO Camper (camper_id, password, gender, age, address)
VALUES (3, 'securepw', 'Male', 42, '9101 Oak St');

INSERT INTO Camper (camper_id, password, gender, age, address)
VALUES (4, 'mypassword', 'Female', 31, '1213 Pine St');

INSERT INTO Camper (camper_id, password, gender, age, address)
VALUES (5, 'hello123', 'Male', 26, '1415 Maple St');



INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (1, 1, 1, TO_DATE('2023-06-05', 'YYYY-MM-DD'), TO_DATE('2023-06-08', 'YYYY-MM-DD'), 2, 'Firewood');

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (2, 2, 2, TO_DATE('2023-07-10', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'), 4, 'Bicycle Rental');

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (3, 3, 3, TO_DATE('2023-08-20', 'YYYY-MM-DD'), TO_DATE('2023-08-25', 'YYYY-MM-DD'), 2, NULL);

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (4, 4, 4, TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-07', 'YYYY-MM-DD'), 2, 'WiFi Access');

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (5, 5, 5, TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), 6, 'BBQ Grill');

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (6, 1, 1, TO_DATE('2023-06-12', 'YYYY-MM-DD'), TO_DATE('2023-06-13', 'YYYY-MM-DD'), 2, 'Firewood');





INSERT INTO Review (camper_id, campsite_id, rating, feedback, date_written)
VALUES (1, 1, 4, 'Great camping experience!', TO_DATE('2023-06-10', 'YYYY-MM-DD'));

INSERT INTO Review (camper_id, campsite_id, rating, feedback, date_written)
VALUES (2, 2, 5, 'Beautiful location with excellent amenities.', TO_DATE('2023-07-15', 'YYYY-MM-DD'));

INSERT INTO Review (camper_id, campsite_id, rating, feedback, date_written)
VALUES (3, 3, 3, 'Decent campsite, but could use more facilities.', TO_DATE('2023-08-22', 'YYYY-MM-DD'));

INSERT INTO Review (camper_id, campsite_id, rating, feedback, date_written)
VALUES (4, 4, 4, 'Enjoyed the peaceful riverside setting.', TO_DATE('2023-09-08', 'YYYY-MM-DD'));

