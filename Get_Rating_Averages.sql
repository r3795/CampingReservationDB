CREATE OR REPLACE FUNCTION Get_Rating_Averages(p_camper_id NUMBER)
  RETURN VARCHAR2
IS
  v_likes NUMBER := 0;
  v_downvotes NUMBER := 0;
  v_average_rating NUMBER := 0;
BEGIN
  SELECT COUNT(CASE WHEN rating > 3 THEN 1 END) AS likes,
         COUNT(CASE WHEN rating < 3 THEN 1 END) AS downvotes,
         AVG(rating) AS average_rating
  INTO v_likes, v_downvotes, v_average_rating
  FROM Review
  WHERE camper_id = p_camper_id;

  RETURN 'Likes: ' || v_likes || ', Downvotes: ' || v_downvotes || ', Average Rating: ' || v_average_rating;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN '해당 캠퍼의 리뷰가 없습니다.';
  WHEN OTHERS THEN
    RETURN 'Error: ' || SQLERRM;
END;

------------------------------------------------출력시 이용하는 코드------------------------------------------------
SELECT Get_Rating_Averages(1) AS rating_info FROM DUAL;
