<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="save.data.Login" %>
<%@ page import="java.sql.*" %>
<%@ page pageEncoding="utf-8" %>
<jsp:useBean id="loginBean" class="save.data.Login" scope="session"/>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>青青草原药品采购系统</title>
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="css/base.css" type="text/css" rel="stylesheet"/>
    <link href="css/main.css" type="text/css" rel="stylesheet"/>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>

<!--header-->
<header>
    <div>

        <center>
            <h2 style="color:black;font-size: 70px;font-family: 隶书">青青草原地区药品采购系统</h2>
        </center>
    </div>
    <%--<section>药品采购</section>--%>
</header>

<!--/header-->

<!--nav-->
<nav id="nav-index" class="clearfix">
    <section class="container">
        <%
            Login loginBean1 = null;
            String name = "未登录,点我登录";
            loginBean1 = (Login) session.getAttribute("loginBean");
            try {
                name = loginBean1.getLogname();
            } catch (Exception ee) {
                out.print("错误：" + ee);
            }
        %>
        <div align="left"><a href="login.jsp" class="fl home"><b style="color: mediumspringgreen;font-style: italic"><%=name%>
        </b></a>
            <p style="color:#FFFFFF;font-size:24px">,您好</p></div>
        <a href="javascript:;" class="fr button" data-num="0"><i class="glyphicon glyphicon-align-justify"></i></a>
        <div align="right"><b style="color:#FFFFFF;font-size:24px">菜单</b></div>
        <ul class="nav-list">
            <li><a style="color:#FFFFFF" href="index.jsp">返回主页</a></li>
            <li><a style="color:#FFFFFF" href="lookShoppingCar.jsp">查看购物车</a></li>
            <li><a style="color:#FFFFFF" href="lookOrderForm.jsp">查看订单</a></li>
            <li><a style="color:#FFFFFF" href="exitServlet">退出</a></li>
        </ul>
    </section>
</nav>
<!--/nav-->

<!--main-->
<section id="main" class="container mt10">
    <section class="row">
        <section class="col-sm-3 sidebar clearfix">
            <dl class="sidebar-cp">
                <dt class="clearfix">
                    <span class="fl">产品类别</span>
                    <i class="fr glyphicon glyphicon-list"></i>
                </dt>
                <section>
                    <dd>01- <a href=queryServlet2?id=1>止疼镇痛</a></dd>
                    <dd>02- <a href=queryServlet2?id=2>补益类用药</a></dd>
                    <dd>03- <a href=queryServlet2?id=3>维生素钙</a></dd>
                    <dd>04- <a href=queryServlet2?id=4>消化系统</a></dd>
                    <dd>05- <a href=queryServlet2?id=5>感冒用药</a></dd>
                    <dd>06- <a href=queryServlet2?id=6>儿科用药</a></dd>
                    <dd>07- <a href=queryServlet2?id=7>皮肤用药</a></dd>
                    <dd>08- <a href=queryServlet2?id=8>五官用药</a></dd>
                    <dd>09- <a href=queryServlet2?id=9>呼吸系统</a></dd>
                    <dd>10- <a href=queryServlet2?id=10>妇科用药</a></dd>
                    <dd>11- <a href=queryServlet2?id=11>计生避孕</a></dd>
                    <dd>12- <a href=queryServlet2?id=12>男科用药</a></dd>
                </section>
            </dl>
        </section>
        <section class="col-sm-9">
            <section class="clearfix mt10">

                <p id=tom>查询时可以输入药品的药品名称及价格。<br>①药品名称支持模糊查询。
                    <br>②输入价格是在2个值之间的价格，格式是：价格1-价格2.例如：5.5-15.5。
                </p>
                <section class="fr search">
                    <form action="searchByConditionServlet" method="post">

                        <input type=radio name="radio" value="drug_name">
                        药品名称
                        <input type=radio name="radio" value="drug_price" checked="ok">
                        药品价格<br>
                        输入查询信息，回车搜索:<input type=text name="searchMess">
                        <input type=submit value="提交">
                        <br>
                        <br>
                    </form>
                </section>
            </section>


            <div align="center">
                <% if (loginBean == null) {
                    response.sendRedirect("login.jsp");//重定向到登录页面。
                    return;
                } else {
                    boolean b = loginBean.getLogname() == null ||
                            loginBean.getLogname().length() == 0;
                    if (b) {
                        response.sendRedirect("login.jsp");//重定向到登录页面。
                        return;
                    }
                }

                    //直接加载JDBC-mySQL加载器
                    try {
                        Class.forName("com.mysql.jdbc.Driver");

                    } catch (Exception e) {
                        out.print("<h1>" + "数据库链接失败：#looShoppingCar#" + e + "</h1>");
                    }


                    String url = "jdbc:mysql://localhost:3306/hospital?" +
                            "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
                    String us = "root", psw = "5200";


                    Connection con = null;
                    Statement sql;
                    ResultSet rs;
                    out.print("<table border=1>");
                    out.print("<tr>");
                    out.print("<th id=tom width=120>" + "药品编号");
                    out.print("<th id=tom width=120>" + "药品名称");
                    out.print("<th id=tom width=120>" + "药品价格");
                    out.print("<th id=tom width=120>" + "购买数量");
                    out.print("<th id=tom width=50>" + "修改数量");
                    out.print("<th id=tom width=50>" + "删除商品");
                    out.print("</tr>");
                    try {
                        con = DriverManager.getConnection(url, us, psw);//直接连接数据库

                        sql = con.createStatement();
                        String SQL =
                                "SELECT car_id,car_name,car_price,car_Amount FROM shoppingcar" +
                                        " where logname ='" + loginBean.getLogname() + "'";
                        rs = sql.executeQuery(SQL);//查shoppingcar表。
                        String car_id = "";
                        String name1 = "";
                        float price = 0;
                        int amount = 0;
                        String orderForm = null; //订单。
                        while (rs.next()) {
                            car_id = rs.getString(1);
                            name1 = rs.getString(2);
                            price = rs.getFloat(3);
                            amount = rs.getInt(4);
                            out.print("<tr>");
                            out.print("<td id=tom>" + car_id + "</td>");
                            out.print("<td id=tom>" + name1 + "</td>");
                            out.print("<td id=tom>" + price + "</td>");
                            out.print("<td id=tom>" + amount + "</td>");
                            String update = "<form  action='updateServlet' method = 'post'>" +
                                    "<input type ='text'id=tom name='update' size =3 value= " + amount + " />" +
                                    "<input type ='hidden' name='car_id' value= " + car_id + " />" +
                                    "<input type ='submit' id=tom value='更新数量'  ></form>";
                            String del = "<form  action='deleteServlet' method = 'post'>" +
                                    "<input type ='hidden' name='car_id' value= " + car_id + " />" +
                                    "<input type ='submit' id=tom value='删除该商品' /></form>";
                            out.print("<td id=tom>" + update + "</td>");
                            out.print("<td id=tom>" + del + "</td>");
                            out.print("</tr>");
                        }
                        out.print("</table>");
                        orderForm = "<form action='buyServlet' method='post'>" +
                                "<input type ='hidden' name='logname' value= '" + loginBean.getLogname() + "'/>" +
                                "<input type ='submit' id=tom value='生成订单(同时清空购物车)'></form>";
                        out.print(orderForm);
                        con.close();
                    } catch (SQLException e) {
                        out.print("<h1>" + "数据库链接失败：#looShoppingCar#" + e + "</h1>");
                    } finally {
                        try {
                            con.close();
                        } catch (Exception ee) {
                        }
                    }
                %>
            </div>

            <!--main-->
        </section>
    </section>

    <!--/main-->
    <!--footer-->
    <footer class="clearfix">
        <section class="container">
            <p>Copyright 2000-2021 药品采购 青青草原 羊村 TRADING CO.,LIMITED All Rights Reserved.</p>
            <p class="mr">
                <a href="index.jsp" target="_blank" style="color:#ccc;">青青草原药品采购</a><br>
                热线电话: +86 321 321 4321<br>
                青青草原 羊村 <br>
                服务电话: +86 123 321 1234
            </p>
            <dl>
                <dt>关于青青草原药品采购</dt>
                <dd><a href="#">青青草原药品生产管理局</a></dd>
                <dd><a href="#">青青草原药品经营许可</a></dd>
            </dl>
            <dl>
                <dt>支付方式</dt>
                <dd><a href="#">货到付款</a></dd>
                <dd><a href="#">在线支付</a></dd>
                <dd><a href="#">分期付款</a></dd>
                <dd><a href="#">医院转账</a></dd>
            </dl>
            <dl>
                <dt>配送方式</dt>
                <dd><a href="#">上门自提</a></dd>
                <dd><a href="#">原外配送</a></dd>
                <dd><a href="#">007准时达</a></dd>
                <dd><a href="#">羊村究极汪汪队</a></dd>
            </dl>
        </section>
    </footer>
    <!--/footer-->
    <script>
        $(function () {
            $("nav .button").click(function () {
                var num = $(this).data("num");
                if (num == 0) {
                    $("nav .nav-list").slideDown();
                    $(this).data("num", 1);
                } else {
                    $("nav .nav-list").slideUp();
                    $(this).data("num", 0);
                }
            })
            $(".sidebar dt").click(function () {
                var wWidth = $(window).width();
                if (wWidth <= 767) {
                    $(".sidebar section").hide();
                }
                if ($(this).next("section:hidden").length == 0) {
                    $(this).next("section").slideUp();
                } else {
                    $(this).next("section").slideDown();
                }
            })

        })
    </script>
</section>


</body>
</HTML>

