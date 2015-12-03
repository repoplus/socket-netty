package com.will.sockiet.listener;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.DataListener;
import com.will.sockiet.entity.ChatObject;

/**
 * 监听
 * @author maozhenggang
 */
public class CharteventListener implements DataListener<ChatObject> {
	protected SocketIOServer server;

	public void setServer(SocketIOServer server) {
		this.server = server;
	}

	public void onData(SocketIOClient client, ChatObject data, AckRequest ackSender) throws Exception {
		// chatevent 事件的名称，data为发送的内容
		this.server.getBroadcastOperations().sendEvent("chatevent", data);
	}
}
