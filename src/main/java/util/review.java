
package util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.WooMemberVO;
import model.WooMypageImpl;

public class review { 
   
   public static Map<String, Object> revireScore(SqlSession sqlSession, String user_id) {
      ArrayList<String> review_score = sqlSession.getMapper(WooMypageImpl.class).review_score(user_id);
      double review_scoreSum = 0;
      for(int i=0; i<review_score.size(); i++) {
         review_scoreSum += Double.parseDouble(review_score.get(i));
      }
      WooMemberVO memberVO = sqlSession.getMapper(WooMypageImpl.class).myInfo(user_id);
      
      int trade_count = Integer.parseInt(memberVO.getTrade_count());
      
      double avg_score1 = 0;
      if(trade_count==0) {
         avg_score1 = 1;
      }
      else {
         avg_score1 = review_scoreSum / (double)trade_count;
      }
      double avg_score2 = ((double)Math.round(avg_score1*10)/10);
      int avg_score_update = sqlSession.getMapper(WooMypageImpl.class).avg_score_update(avg_score2, user_id);   
      double avg_score = Double.parseDouble(memberVO.getAvg_score());

      String score = "";

      int full = (int) avg_score % 5;
      int half = (int) ((avg_score - full) * 10);
      
      for (int i = 1; i <= full; i++) {
         score += "<img src='../resources/img/그냥튀김우동.png' alt='' />";
      }
      if (half < 5) {
         for (int j = full + 1; j <= 5; j++) {
            score += "<img src='../resources/img/회색우동.png' alt='' />";
         }
      } else {
         score += "<img src='../resources/img/반쪽우동.png' alt='' />";
         for (int j = full + 2; j <= 5; j++) {
            score += "<img src='../resources/img/회색우동.png' alt='' />";
         }
      }

      String udongGrade = "";
      int getUserGrade = 1;
      if (trade_count < 5) {
         udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
      } else if (trade_count >= 5 && trade_count < 10) {
         if (avg_score >= 1 && avg_score < 2)
            udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
         else
            udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
         	getUserGrade = 2;
      } else if (trade_count >= 10 && trade_count < 15) {
         if (avg_score >= 1 && avg_score < 2)
            udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
         else if (avg_score >= 2 && avg_score < 4) {
            udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
            getUserGrade = 2;
         }
         else {
            udongGrade += "<img src='../resources/img/파랑온도계.png' alt='' />";
            getUserGrade = 3;
         }
      } else if (trade_count >= 15) {
         if (avg_score >= 1 && avg_score < 2)
            udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
         else if (avg_score >= 2 && avg_score < 4) {
            udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
            getUserGrade = 2;
         }
         else {
            udongGrade += "<img src='../resources/img/빨간온도계.png' alt='' />";
            getUserGrade = 4;
         }
      }
      

      Map<String, Object> map = new HashMap<String, Object>();
      map.put("udongGrade", udongGrade);
      map.put("getUserGrade", getUserGrade);
      map.put("score", score);
      map.put("memberVO", memberVO);
      map.put("avg_score", avg_score);
      return map;
   }
   
}

