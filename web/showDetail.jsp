<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="utf-8" %>
<%@ page import="save.data.Login" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="loginBean" class="save.data.Login" scope="session"/>
<head>

    <title>详情页——青青草原药品采购系统</title>
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="css/base.css" type="text/css" rel="stylesheet"/>
    <link href="css/main.css" type="text/css" rel="stylesheet"/>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/TouchSlide.1.1.js"></script>
</head>
<HTML>

<body>

<!--nav-->
<nav id="nav-page" class="clearfix">
    <section class="container">
        <%
            Login loginBean1 = null;
            String name1 = "未登录,点我登录";
            loginBean1 = (Login) session.getAttribute("loginBean");
            try {
                name1 = loginBean1.getLogname();
            } catch (Exception ee) {
                out.print("错误：" + ee);
            }
        %>
        <div align="left"><a href="login.jsp" class="fl home">
            <b style="font-size:20px;color: black;font-style: italic"><%=name1%>
            </b></a>
            </div>
        <a href="javascript:;" class="fr button" data-num="0">菜单<i class="glyphicon glyphicon-align-justify"></i></a>
        <ul class="nav-list">

            <li><a style="color:black" href="index.jsp">返回主页</a></li>
            <li><a style="color:black" href="lookShoppingCar.jsp">查看购物车</a></li>
            <li><a style="color:black" href="lookOrderForm.jsp">查看订单</a></li>
            <li><a style="color:black" href="exitServlet">退出</a></li>

        </ul>
    </section>
</nav>
<!--/nav-->


<% try {
    loginBean = (Login) session.getAttribute("loginBean");
    if (loginBean == null) {
        response.sendRedirect("login.jsp");//重定向到登录页面.
        return;
    } else {
        boolean b = loginBean.getLogname() == null ||
                loginBean.getLogname().length() == 0;
        if (b) {
            response.sendRedirect("login.jsp");//重定向到登录页面。
            return;
        }
    }
} catch (Exception exp) {
    response.sendRedirect("login.jsp");//重定向到登录页面。
    return;
}
    String drug_id = request.getParameter("drug_id");
    if (drug_id == null) {
        out.print("没有产品号，无法查看细节");
        return;
    }

    //直接加载JDBC-mySQL加载器
    try {
        Class.forName("com.mysql.jdbc.Driver");

    } catch (Exception e) {
        out.print("<h1>" + "数据库链接失败：#showDetail#" + e + "</h1>");
    }


    String url = "jdbc:mysql://localhost:3306/hospital?" +
            "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
    String us = "root", psw = "5200";


    Connection con = null;
    Statement sql;
    ResultSet rs;
    try {
        con = DriverManager.getConnection(url, us, psw);//直接连接数据库

        sql = con.createStatement();
        String query = "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id FROM drugdrug where drug_id = '" + drug_id + "'";
        rs = sql.executeQuery(query);
        String picture = "background.jpg";
        String id1 = "";
        String name = "";
        while (rs.next()) {
            drug_id = rs.getString(1);
            name = rs.getString(2);
            String maker = rs.getString(3);
            String price = rs.getString(4);
            picture = rs.getString(5);
            id1 = rs.getString(6);

            out.print("<section id=\"details-pc\" class=\"hidden-xs clearfix container mt15\">");
            out.print("<section class=\"fl bigImg\">");
            String pic1 = "<img src='YAOimage/" + id1 + "/" + picture + "' style='display:block;width:300px;height:300px'f class='img-responsive align:center'></img>";
            out.print(pic1); //产片图片
            out.print("</section>");

            out.print("<section class=\"fl des\">");
            out.print("<h1 style=font-size:30px>  " + name + "</h1>");
            out.print("<p><span>药品编号：  </span>" + drug_id + "</p>");
            out.print("<p><span>药品供应商：</span>" + maker + "</p>");
            out.print("<p><span>药品价格：</span>￥" + price + " 元</p>");
            out.print("<p><span>附件：</span>       包装盒 说明书 </p><br><br><br>");
            String shopping =
                    "<a href ='putGoodsServlet?drug_id=" + drug_id + "'>添加到购物车</a>";
            out.print("<button>" + shopping + "</button>");
            out.print("</section>");
            out.print("</section>");
        }

        con.close();
    } catch (SQLException exp) {
        out.print("<h1>" + "数据库链接失败：#showDetail#" + exp + "</h1>");
    } finally {
        try {
            con.close();
        } catch (Exception ee) {
        }
    }
%>


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
            <dd><a href="">青青草原药品生产管理局</a></dd>
            <dd><a href="">青青草原药品经营许可</a></dd>
        </dl>
        <dl>
            <dt>支付方式</dt>
            <dd><a href="">货到付款</a></dd>
            <dd><a href="">在线支付</a></dd>
            <dd><a href="">分期付款</a></dd>
            <dd><a href="">医院转账</a></dd>
        </dl>
        <dl>
            <dt>配送方式</dt>
            <dd><a href="">上门自提</a></dd>
            <dd><a href="">原外配送</a></dd>
            <dd><a href="">007准时达</a></dd>
            <dd><a href="">羊村究极汪汪队</a></dd>
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

        $(".imgList li").click(function () {
            var i = $(this).index();
            $(".bigImg img").eq(i).show().siblings().hide();
        })

        TouchSlide({
            slideCell: "#goods-scroll",
            titCell: ".banner-hd ul",
            mainCell: ".banner-bd ul",
            effect: "leftLoop",
            autoPage: true,//自动分页
            autoPlay: true //自动播放
        });

        TouchSlide({
            slideCell: "#picScroll",
            titCell: ".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
            autoPage: true, //自动分页
            pnLoop: "false", // 前后按钮不循环
            switchLoad: "_src" //切换加载，真实图片路径为"_src"
        });

        //滚动
        var step = $(".imgList section li").outerHeight() + 5;
        var i = 0;
        var maxLength = $(".imgList section li").length;
        console.log(maxLength);
        $(".imgList .up").click(function () {
            if (i <= (maxLength - 5)) {
                i++;
                $(".imgList section").css("top", "-=" + step + "px");
            }
        })
        $(".imgList .down").click(function () {
            if (i >= 1) {
                i--;
                $(".imgList section").css("top", "+=" + step + "px");
            }
        })

    })
</script>

</body>
</HTML>

