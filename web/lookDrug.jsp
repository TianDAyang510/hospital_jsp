<%--
  Created by IntelliJ IDEA.
  User: 天下第一苗人凤
  Date: 2021/10/12
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding = "utf-8" %>
<%@ page import="java.sql.*" %>
<HEAD><%@ include file="head.txt" %></HEAD>
<title>浏览药品页面</title>
<style>
    #ok{
        font-family:宋体;font-size:26px;color:black;
    }
</style>
<HTML><body id=ok background =image/back.jpg>
<div align="center">
    选择某类药品,分页显示这类药品。
    <%

        Connection con=null;
        Statement sql;
        ResultSet rs;
        //直接加载JDBC-mySQL加载器
        try {
            Class.forName("com.mysql.jdbc.Driver");

        } catch (Exception e) {
            out.print("数据库链接失败：#lookDrug#" +e);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?"+
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root",psw = "5200";

        try {
            con = DriverManager.getConnection(url,us,psw);//直接连接数据库

            sql=con.createStatement();
            //读取drugType表，获得分类：
            rs=sql.executeQuery("SELECT * FROM drugtype");
            out.print("<form action='queryServlet' id =ok method ='post'>") ;
            out.print("<select id =ok name='fenleiNumber'>") ;
            while(rs.next()){
                int id = rs.getInt(1);
                String name = rs.getString(2);
                out.print("<option value ="+id+">"+name+"</option>");
            }
            out.print("</select>");
            out.print("<input type ='submit' id =ok value ='提交'>");
            out.print("</form>");
            rs.close();
            con.close();
        }
        catch(SQLException e){
            out.print(e);
        }
        finally{
            try{
                con.close();
            }
            catch(Exception ee){}
        }
    %>
</div></body></HTML>
