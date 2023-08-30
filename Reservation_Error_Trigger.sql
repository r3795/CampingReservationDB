CREATE OR REPLACE TRIGGER reservation_error_trigger
BEFORE INSERT OR UPDATE ON Reservation
FOR EACH ROW
DECLARE
    max_capacity Site.capacity%TYPE;
    current_occupancy NUMBER;
    exceed_capacity_error EXCEPTION;
    overlap_reservation_error EXCEPTION;
BEGIN
    SELECT capacity INTO max_capacity FROM Site WHERE site_id = :new.site_id;
    
    SELECT COUNT(*) INTO current_occupancy
    FROM Reservation
    WHERE site_id = :new.site_id
    AND check_in_date <= :new.check_out_date
    AND check_out_date >= :new.check_in_date;
    
    IF :new.num_occupants > max_capacity THEN
        RAISE exceed_capacity_error;
    END IF;
    
    IF current_occupancy > 0 THEN
        RAISE overlap_reservation_error;
    END IF;
EXCEPTION
    WHEN exceed_capacity_error THEN
        RAISE_APPLICATION_ERROR(-20001, '사이트의 수용량보다 예약인원이 많습니다.');
    WHEN overlap_reservation_error THEN
        RAISE_APPLICATION_ERROR(-20002, '해당 날짜에 예약이 중복됩니다.');
    WHEN NO_DATA_FOUND THEN
        NULL;
END;
------------------------------------------------출력시 이용하는 코드------------------------------------------------
INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (7, 3, 3, TO_DATE('2023-08-21', 'YYYY-MM-DD'), TO_DATE('2023-08-24', 'YYYY-MM-DD'), 2, NULL);

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (7, 3, 3, TO_DATE('2023-08-26', 'YYYY-MM-DD'), TO_DATE('2023-08-28', 'YYYY-MM-DD'), 3, NULL);

INSERT INTO Reservation (reservation_id, camper_id, site_id, check_in_date, check_out_date, num_occupants, addl_services)
VALUES (7, 3, 3, TO_DATE('2023-08-26', 'YYYY-MM-DD'), TO_DATE('2023-08-28', 'YYYY-MM-DD'), 2, NULL);