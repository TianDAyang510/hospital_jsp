<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding = "utf-8" %>
<HEAD><%@ include file="head.txt" %></HEAD>
<title>查询页面</title>
<style>
    #tom{
        font-family:宋体;font-size:26px;color:black;
    }
</style>
<HTML><body bgcolor =pink id=tom>
<div align="center">
    <p>查询时可以输入药品的编号或药品名称及价格。<br>
        药品名称支持模糊查询。
        <br>输入价格是在2个值之间的价格，格式是：价格1-价格2<br>
        例如：897.98-10000。
    </p>
    <form action="searchByConditionServlet" id =tom method="post" >
        <br>输入查询信息:<input type=text id=tom name="searchMess"><br>
        <input type =radio name="radio" id =tom value="drug_id"/>
        药品编号
        <input type =radio name="radio" id =tom value="drug_name" >
        药品名称
        <input type =radio name="radio" value="drug_price" checked="ok">
        药品价格
        <br><input type=submit id =tom value="提交">
    </form>
</div></body></HTML>
