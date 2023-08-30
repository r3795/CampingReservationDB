CREATE OR REPLACE PROCEDURE Add_Review( 
    p_camper_id NUMBER, 
    p_reservation_id NUMBER, 
    p_rating NUMBER, 
    p_feedback VARCHAR2 
) AS 
    v_site_id NUMBER; 
    v_campsite_id NUMBER; 
    v_date_written DATE := SYSDATE; 
BEGIN 
    SELECT Site.campsite_id 
    INTO v_campsite_id 
    FROM Reservation 
    JOIN Site ON Reservation.site_id = Site.site_id 
    WHERE Reservation.reservation_id = p_reservation_id AND p_camper_id = Reservation.camper_id; 
 
    INSERT INTO Review(camper_id, campsite_id, rating, feedback, date_written) 
    VALUES (p_camper_id, v_campsite_id, p_rating, p_feedback, v_date_written); 
     
    COMMIT; 
    DBMS_OUTPUT.PUT_LINE('리뷰를 성공적으로 추가했습니다.'); 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('예약이나 사이트가 없습니다.');
        ROLLBACK;  
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); 
        ROLLBACK; 
END;
------------------------------------------------출력시 이용하는 코드------------------------------------------------
BEGIN 
    Add_Review(5, 5, 5, 'Amazing views and friendly staff!'); 
END;

DECLARE
    v_reviews SYS_REFCURSOR;
BEGIN
    GetReviewByOwnerId(1005, v_reviews);
END;