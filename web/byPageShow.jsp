<%@ page import="save.data.Login" %>
<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html" %>
<%@ page pageEncoding="utf-8" %>

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
<jsp:useBean id="dataBean" class="save.data.Record_Bean"
             scope="session"/>
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
            Login loginBean = null;
            String name = "未登录,点我登录";
            loginBean = (Login) session.getAttribute("loginBean");
            try {
                name = loginBean.getLogname();
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
            <%--<li> <a href="queryServlet?drug_sup=">双肩包</a></li>--%>
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
                    </form>
                </section>
            </section>


            <center>
                <jsp:setProperty name="dataBean" property="pageSize" param="pageSize"/>
                <jsp:setProperty name="dataBean" property="currentPage" param="currentPage"/>
                </p>
                <table border=1>
                    <% String[][] table = dataBean.getTableRecord();
                        if (table == null) {
                            out.print("没有记录");
                            return;
                        }
                    %>
                    <tr>
                        <th>药品图片</th>
                        <th>药品编号</th>
                        <th>药品名称</th>
                        <th>药品供应商</th>
                        <th>药品价格</th>
                        <th>查看详情</th>
                        <td>添加到购物车</td>
                    </tr>
                    <% int totalRecord = table.length;
                        int pageSize = dataBean.getPageSize();  //每页显示的记录数。
                        int totalPages = dataBean.getTotalPages();
                        if (totalRecord % pageSize == 0)
                            totalPages = totalRecord / pageSize;//总页数。
                        else
                            totalPages = totalRecord / pageSize + 1;
                        dataBean.setPageSize(pageSize);
                        dataBean.setTotalPages(totalPages);
                        if (totalPages >= 1) {
                            if (dataBean.getCurrentPage() < 1)
                                dataBean.setCurrentPage(dataBean.getTotalPages());
                            if (dataBean.getCurrentPage() > dataBean.getTotalPages())
                                dataBean.setCurrentPage(1);
                            int index = (dataBean.getCurrentPage() - 1) * pageSize;
                            int start = index;  //table的currentPage页起始位置。
                            for (int i = index; i < pageSize + index; i++) {
                                if (i == totalRecord)
                                    break;
                                out.print("<tr>");
                                out.print("<td>" + "<img src=\"YAOimage/" + table[i][5] + "/" + table[i][4] + "\" class=\"img-responsive\" width=\"150\" height=\"150\"/>" + "</td>");
                                for (int j = 0; j < table[0].length - 2; j++) {
                                    out.print("<td>" + table[i][j] + "</td>");
                                }
                                String detail =
                                        "<a href ='showDetail.jsp?drug_id=" + table[i][0] + "'>药品详情</a>";
                                out.print("<td>" + detail + "</td>");
                                String shopping =
                                        "<a href ='putGoodsServlet?drug_id=" + table[i][0] + "'>添加到购物车</a>";
                                out.print("<td>" + shopping + "</td>");
                                out.print("</tr>");
                            }
                        }
                    %>
                </table>
                <%--<img src="back.jpg" width="300" height="300">--%>
                <p>全部记录数:
                    <jsp:getProperty name="dataBean"
                                     property="totalRecords"/>
                    。
                    <br>每页最多显示
                    <jsp:getProperty name="dataBean" property="pageSize"/>
                    条记录。
                    <br>当前显示第
                    <jsp:getProperty name="dataBean" property="currentPage"/>
                    页
                    (共有
                    <jsp:getProperty name="dataBean" property="totalPages"/>
                    页)。</p>
                <table>
                    <tr>
                        <td>
                            <form action="" method=post>
                                <input type=hidden name="currentPage"
                                       value="<%=dataBean.getCurrentPage()-1 %>"/>
                                <input type=submit value="上一页"/></form>
                        </td>
                        <td>
                            <form action="" method=post>
                                <input type=hidden name="currentPage"
                                       value="<%=dataBean.getCurrentPage()+1 %>"/>
                                <input type=submit value="下一页"></form>
                        </td>
                        <td>
                            <form action="" method=post>
                                输入页码：<input type=textid name="currentPage" size=2>
                                <input type=submit value="提交"></form>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td>
                            <form action="" method=post>
                                每页显示<input type=text name="pageSize" value=<%=dataBean.getPageSize()%> size=1>
                                条记录<input type=submit value="确定"></form>
                        </td>
                    </tr>
                </table>
            </center>


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

