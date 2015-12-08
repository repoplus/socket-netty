<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<title>Insert title here</title>
<script src="statics/jquery.js"></script>
<script src="statics/socket.io.js"></script>
<style>
body {
	padding: 20px;
}

#console {
	height: 400px;
	overflow: auto;
}

.username-msg {
	color: orange;
}

.connect-msg {
	color: green;
}

.disconnect-msg {
	color: red;
}

.send-msg {
	color: #888
}
</style>
</head>
<body>
    <h1>Andon Board Test</h1>
    <br />
    <div id="console" class="well"></div>
    <form class="well form-inline" onsubmit="return false;">
        <input id="name" class="input-xlarge" type="text" placeholder="用户名称. . . " />
        <input id="msg" class="input-xlarge" type="text" placeholder="发送内容. . . " />
        <button type="button" onClick="sendMessage()" class="btn">Send</button>
        <button type="button" onClick="sendDisconnect()" class="btn">Disconnect</button>
    </form>
</body>
<script type="text/javascript">
	//建立一个socket连接 
    var socket = io.connect('http://localhost:9092');
	//socket连接成功
    socket.on('connect',function() {
        output('<span class="connect-msg">成功连接服务端!</span>');
    });
    socket.on('connect_failed',function() {
        output('<span class="disconnect-msg">connection faild!</span>');
    });
	//正在重连
    socket.on('reconnecting',function() {
        output('<span class="disconnect-msg">正在重连</span>');
    });
	//
    socket.on('reconnect_failed',function() {
        output('<span class="disconnect-msg">重连失败</span>');
    });
	
    //socket断开事件
    socket.on('disconnect',function() {
        output('<span class="disconnect-msg">已经断开连接! </span>');
    });
     //socket监听chatevent事件
    socket.on('chatevent', function(data) {
        output('<span class="username-msg">' + data.userName + ' : </span>' + data.message);
    });
    function sendDisconnect() {
        socket.disconnect();
    }
    
    function sendMessage() {
        var userName = $("#name").val()
        var message = $('#msg').val();
        $('#msg').val('');
        socket.emit('chatevent', {
            userName : userName,
            message : message
        });
    }
    
    function output(message) {
        var currentTime = "<span class='time' >" + new Date() + "</span>";
        var element = $("<div>" + currentTime + " " + message + "</div>");
        $('#console').prepend(element);
    }
</script>
</html>