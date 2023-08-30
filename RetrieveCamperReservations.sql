CREATE OR REPLACE PROCEDURE RetrieveCamperReservations(
    pCamperId IN NUMBER
)
IS
    CURSOR cReservations IS
        SELECT reservation_id, site_id, check_in_date, check_out_date, num_occupants, addl_services
        FROM Reservation
        WHERE camper_id = pCamperId;
        
    vReservationId Reservation.reservation_id%TYPE;
    vSiteId Reservation.site_id%TYPE;
    vCheckInDate Reservation.check_in_date%TYPE;
    vCheckOutDate Reservation.check_out_date%TYPE;
    vNumOccupants Reservation.num_occupants%TYPE;
    vAddlServices Reservation.addl_services%TYPE;
    
    vTotalReservations NUMBER := 0;
    vTotalOccupants NUMBER := 0;

    no_reservations EXCEPTION;
    too_many_reservations EXCEPTION;
    too_many_occupants EXCEPTION;
    
    vErrorMessage VARCHAR2(100);
    
    FUNCTION CalculateStayDuration(
        pStartDate IN DATE,
        pEndDate IN DATE
    ) RETURN NUMBER
    IS
    BEGIN
        RETURN pEndDate - pStartDate;
    END CalculateStayDuration;

    FUNCTION IsReservationWithinRange(
        pCheckInDate IN DATE,
        pCheckOutDate IN DATE,
        pStartDate IN DATE,
        pEndDate IN DATE
    ) RETURN BOOLEAN
    IS
    BEGIN
        RETURN (pCheckInDate >= pStartDate AND pCheckOutDate <= pEndDate);
    END IsReservationWithinRange;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Reservations for Camper ID: ' || pCamperId);
    
    OPEN cReservations;
    
    FETCH cReservations INTO vReservationId, vSiteId, vCheckInDate, vCheckOutDate, vNumOccupants, vAddlServices;
    
    IF cReservations%NOTFOUND THEN
        RAISE no_reservations;
    ELSE
        LOOP
            vTotalReservations := vTotalReservations + 1;
            vTotalOccupants := vNumOccupants;

            DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || vReservationId);
            DBMS_OUTPUT.PUT_LINE('Site ID: ' || vSiteId);
            DBMS_OUTPUT.PUT_LINE('Check-in Date: ' || TO_CHAR(vCheckInDate, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('Check-out Date: ' || TO_CHAR(vCheckOutDate, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('Number of Occupants: ' || vNumOccupants);
            DBMS_OUTPUT.PUT_LINE('Additional Services: ' || vAddlServices);
            DBMS_OUTPUT.PUT_LINE('------------------------');
            
            DECLARE
                vStayDuration NUMBER;
            BEGIN
                vStayDuration := CalculateStayDuration(vCheckInDate, vCheckOutDate);
                DBMS_OUTPUT.PUT_LINE('Stay Duration (in days): ' || vStayDuration);
            END;
            
			DECLARE
    			vReservationWithinRange BOOLEAN;
    			vSiteCapacity NUMBER;
			BEGIN
    			SELECT capacity INTO vSiteCapacity FROM Site WHERE site_id = vSiteId;
    
    			IF vTotalOccupants > vSiteCapacity THEN
        			RAISE too_many_occupants;
    			END IF;
    
    			vReservationWithinRange := IsReservationWithinRange(vCheckInDate, vCheckOutDate, SYSDATE, SYSDATE + 365);
    
    			IF vReservationWithinRange THEN
        			DBMS_OUTPUT.PUT_LINE('예약이 유효합니다.');
    			ELSE
        			DBMS_OUTPUT.PUT_LINE('예약은 최대 1년 범위까지 가능합니다.');
    			END IF;
			END;
            
            DBMS_OUTPUT.PUT_LINE('========================');
            
            FETCH cReservations INTO vReservationId, vSiteId, vCheckInDate, vCheckOutDate, vNumOccupants, vAddlServices;
            EXIT WHEN cReservations%NOTFOUND;
        END LOOP;
        
        IF vTotalReservations > 1 THEN
            RAISE too_many_reservations;
        END IF;
        
        
        DBMS_OUTPUT.PUT_LINE('Total Reservations: ' || vTotalReservations);
        DBMS_OUTPUT.PUT_LINE('Total Occupants: ' || vTotalOccupants);
    END IF;
    
    CLOSE cReservations;
    
EXCEPTION
    WHEN no_reservations THEN
        DBMS_OUTPUT.PUT_LINE('신청하신 예약이 없습니다.');
    WHEN too_many_reservations THEN
        DBMS_OUTPUT.PUT_LINE('예약이 너무 많습니다. 예약은 최대 1개 가능합니다.');
    WHEN too_many_occupants THEN
        DBMS_OUTPUT.PUT_LINE('투숙객이 너무 많습니다. 투숙 인원수는 사이트의 수용량을 넘을 수 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예약을 검색하는 동안 오류가 발생했습니다. Error: ' || SQLERRM);
END;
------------------------------------------------출력시 이용하는 코드------------------------------------------------
exec RetrieveCamperReservations(1);