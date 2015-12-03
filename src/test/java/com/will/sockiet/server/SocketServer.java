package com.will.sockiet.server;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOServer;
import com.will.sockiet.entity.ChatObject;
import com.will.sockiet.listener.CharteventListener;

/**
 * 服务
 * @author maozhenggang
 */
public class SocketServer {
	public static void main(String[] args) throws InterruptedException {
		Configuration config = new Configuration();
		config.setHostname("localhost");
		config.setPort(9092);// 端口
		//
		SocketIOServer server = new SocketIOServer(config);
		CharteventListener listner = new CharteventListener();
		listner.setServer(server);
		server.addEventListener("chatevent", ChatObject.class, listner);
		server.start();
		Thread.sleep(Integer.MAX_VALUE);
		server.stop();
	}
}
