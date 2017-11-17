<%--
  Created by IntelliJ IDEA.
  User: sakura
  Date: 17-11-17
  Time: 下午8:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="author" content="Yeeku.H.Lee(CrazyIt.org)" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title> 使用WebSocket通信 </title>
  <script type="text/javascript">
      // 创建WebSocket对象
      try {
          var webSocket = new WebSocket("ws://localhost:8080/chat");
          var sendMsg = function()
          {
              var inputElement = document.getElementById('msg');
              // 发送消息
              webSocket.send(inputElement.value);
              // 清空单行文本框
              inputElement.value = '{uid:"",msg:""}';
          }
          var send = function(event)
          {
              if (event.keyCode == 13)
              {
                  sendMsg();
              }
          };
          webSocket.onopen = function()
          {
              // 为onmessage事件绑定监听器，接收消息
              webSocket.onmessage= function(event)
              {
                  var show = document.getElementById('show')
                  // 接收、并显示消息
                  show.innerHTML += event.data + "<br/>";
                  show.scrollTop = show.scrollHeight;
              }
              document.getElementById('msg').onkeydown = send;
              document.getElementById('sendBn').onclick = sendMsg;
          };
          webSocket.onclose = function ()
          {
              document.getElementById('msg').onkeydown = null;
              document.getElementById('sendBn').onclick = null;
              console.log('WebSocket已经被关闭。');
          };
      } catch(e) {
          // statements
          console.log(e);
      }
  </script>
</head>
<body>
<div style="width:600px;height:240px;
	overflow-y:auto;border:1px solid #333;" id="show"></div>
<input type="text" size="80" id="msg" name="msg" placeholder="输入聊天内容" value='{uid:"",msg:""}'/>
<input type="button" value="发送" id="sendBn" name="sendBn"/>
</body>
</html>
