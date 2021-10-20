<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="utf-8" %>
<jsp:useBean id="loginBean" class="save.data.Login" scope="session"/>

<html lang="en">
<link rel="stylesheet" type="text/css" href="css/login.css">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>青青草原地区药品采购系统登录</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/5.13.0/css/all.css">
    <link rel="stylesheet" href="../login.css">
</head>

<body>
<div align="center">
    <br>
    <h2 style="color:black;font-size: 70px;font-family: 隶书">青青草原地区药品采购系统</h2>
</div>
<div id="login_box">
    <h2>登录界面</h2>
    <form action="loginServlet" method="post">
        <div id="form">
            <div id="input_box">
                <i class="fa fa-user" aria-hidden="true"></i>
                <input name="logname" type="text" placeholder="账号：">
            </div>
            <div id="input_box">
                <i class="fa fa-key" aria-hidden="true"></i>
                <input name="password" type="password" placeholder="密码：">
            </div>
        </div>
        <br>
        <div>
            <input type=submit id=tom value="提交">
        </div>
    </form>

        登录反馈信息:
        <p style="font-size:10px;color:mediumspringgreen;"><jsp:getProperty name="loginBean" property="backNews"/></p>
        <br>登录名称:
        <p style="font-size:10px;color: mediumspringgreen;"><jsp:getProperty name="loginBean" property="logname"/></p>

        <div id="Sign">
            <a href="inputRegisterMess.jsp">没有账号？点我注册</a>
        </div>
</div>
</body>
</html>