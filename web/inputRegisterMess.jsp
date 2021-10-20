<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="userBean" class="save.data.Register" scope="request"/>
<html lang="en">
<link rel="stylesheet" type="text/css" href="css/login.css">
<head>
    <meta charset="UTF-8">
    <title>青青草原地区药品采购系统注册</title>
</head>

<body>
<div align="center">
    <br>
    <h2 style="color:black;font-size: 70px;font-family: 隶书">青青草原地区药品采购系统</h2>
</div>
<div id="login_box">
    <h2>注册界面</h2>

    <div align="center">
        <form action="registerServlet" method="post">


            <div id="form">
                <div id="input_box">
                    <i class="fa fa-user" aria-hidden="true"></i>
                    <input name="logname" type="text" placeholder="账号：">
                </div>
                <div id="input_box">
                    <i class="fa fa-key" aria-hidden="true"></i>
                    <input name="password" type="password" placeholder="密码：">
                </div>

                <div id="input_box">
                    <i class="fa fa-2key" aria-hidden="true"></i>
                    <input name="again_password" type="password" placeholder="重复密码：">
                </div>
                <div id="input_box">
                    <i class="fa fa-phone" aria-hidden="true"></i>
                    <input name="phone" type="text" placeholder="联系电话：">
                </div>
                <div id="input_box">
                    <i class="fa fa-site" aria-hidden="true"></i>
                    <input name="address" type="text" placeholder="医院名称：">
                </div>
                <div id="input_box">
                    <i class="fa fa-name" aria-hidden="true"></i>
                    <input name="realname" type="test" placeholder="部门名称：">
                </div>

                <br>
                <input type=submit id=ok value="提交">
            </div>


            <div align="center">
                <b style="color: black;">注册反馈：</b>
                <p style="color: crimson">
                    <jsp:getProperty name="userBean" property="backNews"/>
                </p>
                <table id=yes border=1>
                    <tr>
                        <td>会员名称:</td>
                        <td>
                            <p style="color: green;">
                                <jsp:getProperty name="userBean" property="logname"/>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>姓名:</td>
                        <td>
                            <p style="color: green;">
                                <jsp:getProperty name="userBean" property="realname"/>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>地址:</td>
                        <td>
                            <p style="color: green;">
                                <jsp:getProperty name="userBean" property="address"/>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>电话:</td>
                        <td>
                            <p style="color: green;">
                                <jsp:getProperty name="userBean" property="phone"/>
                            </p>
                        </td>
                    </tr>
                </table>
            </div>


            <div id="Sign">
                <a href="login.jsp" style="color:firebrick;">已注册？点我去登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>


