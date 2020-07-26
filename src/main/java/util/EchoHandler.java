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
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	//클라이언트 서버로 연결 처리
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessionList.add(session);
		Map<String, Object> map = session.getAttributes(); 
		logger.info("{}연결됨", (String)map.get("id"));
	}
	
	//클라이언트 서버로 메세지 전송 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		Map<String, Object> map = session.getAttributes(); 
		String[] msg = message.getPayload().split("//");
		logger.info("{}로 부터 {}받음",(String)map.get("id"),message.getPayload());
		for(WebSocketSession sess : sessionList) {
			if(msg[0].equals((String)map.get("id"))) {
				sess.sendMessage(new TextMessage(message.getPayload())); // 상대방 꾸미는 부분
			}
		}
	}
	
	//클라이언트가 연결을 끊음 처리
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status)throws Exception{
		//퇴장 사용자 세션 리스트 제거
		sessionList.remove(session);
		Map<String, Object> map = session.getAttributes(); 
		logger.info("{}연결끊김"+(String)map.get("id"));
		
	}

}
