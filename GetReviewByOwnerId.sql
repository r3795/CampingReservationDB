CREATE OR REPLACE PROCEDURE GetReviewByOwnerId( 
    p_owner_id IN Campsite_Owner.owner_id%TYPE, 
    p_reviews OUT SYS_REFCURSOR 
) 
AS 
    v_campsite_id Campsite_Owner.campsite_id%TYPE; 
    -- Variables to store each property in Review 
    v_camper_id Review.camper_id%TYPE; 
    v_rating Review.rating%TYPE; 
    v_feedback Review.feedback%TYPE; 
    v_date_written Review.date_written%TYPE; 
BEGIN 
    -- Retrieve the campsite_id based on the owner_id 
    SELECT campsite_id INTO v_campsite_id 
    FROM Campsite_Owner 
    WHERE owner_id = p_owner_id; 
     
    OPEN p_reviews FOR 
    SELECT camper_id, rating, feedback, date_written 
    FROM Review 
    WHERE campsite_id = v_campsite_id; 
     
    LOOP 
        FETCH p_reviews INTO v_camper_id, v_rating, v_feedback, v_date_written; 
        EXIT WHEN p_reviews%NOTFOUND; 
         
        DBMS_OUTPUT.PUT_LINE('Camper ID: ' || v_camper_id); 
        DBMS_OUTPUT.PUT_LINE('Rating: ' || v_rating); 
        DBMS_OUTPUT.PUT_LINE('Feedback: ' || v_feedback); 
        DBMS_OUTPUT.PUT_LINE('Date Written: ' || v_date_written); 
    END LOOP; 
     
    CLOSE p_reviews; 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('리뷰가 없습니다.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('예약을 검색하는 동안 오류가 발생했습니다. Error: ' || SQLERRM); 
END;
------------------------------------------------출력시 이용하는 코드------------------------------------------------
DECLARE
    v_reviews SYS_REFCURSOR;
BEGIN
    GetReviewByOwnerId(1003, v_reviews);
END;

DECLARE
    v_reviews SYS_REFCURSOR;
BEGIN
    GetReviewByOwnerId(1006, v_reviews);
END;