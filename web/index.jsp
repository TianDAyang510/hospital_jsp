<%@ page import="save.data.Login" %><%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


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
            }catch (Exception ee){
                out.print("错误："+ee);
            }
        %>
        <div align="left"><a href="login.jsp" class="fl home"><b style="color: mediumspringgreen;font-style: italic"><%=name%></b></a><p style="color:#FFFFFF;font-size:24px">,您好</p></div>
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
                    <form action="searchByConditionServlet"  method="post" >

                        <input type =radio name="radio"  value="drug_name" >
                        药品名称
                        <input type =radio name="radio" value="drug_price" checked="ok">
                        药品价格<br>
                        输入查询信息，回车搜索:<input type=text  name="searchMess">
                        <input type=submit value="提交">
                    </form>
                </section>
            </section>
            <ul class="prolist">
                <li>
                    <a href="showDetail.jsp?drug_id=24">
                        <img src="YAOimage/6/小葵花.jpg" class="img-responsive"/>

                        <p>
                            小葵花
                        </p>
                        <span>价格 ￥16 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=17">
                        <img src="YAOimage/5/感冒灵.jpg" class="img-responsive">
                        <p>
                            感冒灵
                        </p>
                        <span>价格 ￥26 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=31">
                        <img src="YAOimage/8/西瓜霜.jpg" class="img-responsive">
                        <p>
                            西瓜霜
                        </p>
                        <span>价格 ￥9.8 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=22">
                        <img src="YAOimage/6/儿童退烧.jpg" class="img-responsive">
                        <p>
                            儿童退烧
                        </p>
                        <span>价格 ￥20 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=36">
                        <img src="YAOimage/9/口罩.jpg" class="img-responsive">
                        <p>
                            口罩
                        </p>
                        <span>价格 ￥15.5 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=6">
                        <img src="YAOimage/2/复方阿胶.jpg" class="img-responsive"/>
                        <p>
                            复方阿胶
                        </p>
                        <span>价格 ￥289 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=14">
                        <img src="YAOimage/4/开塞露.jpg" class="img-responsive">
                        <p>
                            开塞露
                        </p>
                        <span>价格 ￥9.9 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=5">
                        <img src="YAOimage/1/消炎片.jpg" class="img-responsive">
                        <p>
                            消炎片
                        </p>
                        <span>价格 ￥57 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=33">
                        <img src="YAOimage/8/珍视明.jpg" class="img-responsive">
                        <p>
                            珍视明
                        </p>
                        <span>价格 ￥16 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=52">
                        <img src="YAOimage/12/肾宝.jpg" class="img-responsive">
                        <p>
                            肾宝
                        </p>
                        <span>价格 ￥243 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=18">
                        <img src="YAOimage/5/连花清瘟.jpg" class="img-responsive">
                        <p>
                            连花清瘟胶囊
                        </p>
                        <span>价格 ￥24 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=49">
                        <img src="YAOimage/12/风油精.jpg" class="img-responsive">
                        <p>
                            风油精
                        </p>
                        <span>价格 ￥2 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=16">
                        <img src="YAOimage/4/十滴水.jpg" class="img-responsive">
                        <p>
                            十滴水
                        </p>
                        <span>价格 ￥10 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=4">
                        <img src="YAOimage/1/三黄片.jpg" class="img-responsive">
                        <p>
                            三黄片
                        </p>
                        <span>价格 ￥12 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=19">
                        <img src="YAOimage/5/三九.jpg" class="img-responsive">
                        <p>
                            999感冒药
                        </p>
                        <span>价格 ￥25 RMB</span>
                    </a>
                </li>
                <li>
                     <a href="showDetail.jsp?drug_id=21">
                        <img src="YAOimage/6/丁桂儿脐贴.jpg" class="img-responsive">
                        <p>
                            丁桂儿脐贴
                        </p>
                        <span>价格 ￥80 RMB</span>
                    </a>
                </li>
            </ul>
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
</html>