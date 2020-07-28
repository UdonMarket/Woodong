package util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
	
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	//클라이언트 서버로 연결 처리
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		Map<String, Object> map = session.getAttributes();
		map.put("session", session);
		sessionList.add(map);
	}
	
	//클라이언트 서버로 메세지 전송 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		Map<String, Object> map = session.getAttributes();
		String id = (String)map.get("id");
		String[] msg = message.getPayload().split("//");

		for(Map<String, Object> sess : sessionList) {
			WebSocketSession userSession = (WebSocketSession)sess.get("session");
			if(!sess.get("id").equals(id)) {
				userSession.sendMessage(new TextMessage(message.getPayload())); // 상대방 꾸미는 부분
			}
		}
	}
	
	//클라이언트가 연결을 끊음 처리
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status)throws Exception{
		//퇴장 사용자 세션 리스트 제거
		System.out.println("sessionList size1 : " + sessionList.size());
		for(int i = 0 ;  i<sessionList.size() ; i++) {
			if(sessionList.get(i).get("session")==session) {
				sessionList.remove(i);
				break;
			}
		}
		System.out.println("sessionList size2 : " + sessionList.size());
		Map<String, Object> map = session.getAttributes(); 
		System.out.println("{}연결끊김"+(String)map.get("id"));
		
	}

}
