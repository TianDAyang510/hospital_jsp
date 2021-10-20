package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:18
 */
//
//import save.data.Record_Bean;
//
//import java.sql.*;
//import java.io.*;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import javax.sql.DataSource;
//import javax.naming.Context;
//import javax.naming.InitialContext;
//
//@WebServlet("/searchByConditionServlet")
//
//public class SearchByCondition extends HttpServlet {
//    public void init(ServletConfig config) throws ServletException {
//        super.init(config);
//    }
//
//    public void service(HttpServletRequest request,
//                        HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("utf-8");
//        HttpSession session = request.getSession(true);
//        String searchMess = request.getParameter("searchMess");
//        String radioMess = request.getParameter("radio");
//        if (searchMess == null || searchMess.length() == 0) {
//            response.getWriter().print("没有查询信息，无法查询");
//            return;
//        }
//        Connection con = null;
//        String queryCondition = "";
//        float max = 0, min = 0;
////        if (radioMess.contains("mobile_version")) {
////            queryCondition =
////                    "SELECT mobile_version,mobile_name,mobile_made,mobile_price " +
////                            "FROM mobileForm where mobile_version='" + searchMess + "'";
////        } else
//            if (radioMess.contains("drug_name")) {
//            queryCondition =
//                    "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id" +
//                            "FROM drugdrug where drug_name like '%" + searchMess + "%'";
//        } else if (radioMess.contains("drug_price")) {
//            String priceMess[] = searchMess.split("[-]+");
//            try {
//                min = Float.parseFloat(priceMess[0]);
//                max = Float.parseFloat(priceMess[1]);
//            } catch (NumberFormatException exp) {
//                min = 0;
//                max = 0;
//            }
//            queryCondition =
//                    "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id" +
//                            "FROM drugdrug where drug_price<=" + max + " and drug_price>=" + min;
//        }
//        Record_Bean dataBean = null;
//        try {
//            dataBean = (Record_Bean) session.getAttribute("dataBean");
//            if (dataBean == null) {
//                dataBean = new Record_Bean();  //创建bean。
//                session.setAttribute("dataBean", dataBean);//是session bean。
//            }
//        } catch (Exception exp) {
//        }
//
//
//        //直接加载JDBC-mySQL加载器
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//
//        } catch (Exception e) {
//            response.getWriter().print("遇到错误！#SearchByCondition#" + e);
//        }
//
//
//        String url = "jdbc:mysql://localhost:3306/hospital?" +
//                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
//        String us = "root", psw = "5200";
//
//
//        try {
//
//            con = DriverManager.getConnection(url, us, psw);//直接连接数据库
//
//            Statement sql = con.createStatement();
//            ResultSet rs = sql.executeQuery(queryCondition);
//            ResultSetMetaData metaData = rs.getMetaData();
//            int columnCount = metaData.getColumnCount(); //得到结果集的列数。
//            rs.last();
//            int rows = rs.getRow();  //得到记录数。
//            String[][] tableRecord = dataBean.getTableRecord();
//            tableRecord = new String[rows][columnCount];
//            rs.beforeFirst();
//            int i = 0;
//            while (rs.next()) {
//                for (int k = 0; k < columnCount; k++)
//                    tableRecord[i][k] = rs.getString(k + 1);
//                i++;
//            }
//            dataBean.setTableRecord(tableRecord); //更新bean。
//            con.close();
//            response.sendRedirect("byPageShow.jsp"); //重定向。
//        } catch (Exception e) {
//            response.getWriter().print("遇到错误！#SearchByCondition#" + e);
//        } finally {
//            try {
//                con.close();
//            } catch (Exception ee) {
//            }
//        }
//    }
//}
import save.data.Record_Bean;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/searchByConditionServlet")

public class SearchByCondition extends HttpServlet{
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response) throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        HttpSession session=request.getSession(true);
        String searchMess= request.getParameter("searchMess");
        String radioMess= request.getParameter("radio");
        if(searchMess==null||searchMess.length()==0) {
            response.getWriter().print("没有查询信息，无法查询");
            return;
        }
        Connection con=null;
        String queryCondition="";
        float max=0,min=0;
        if(radioMess.contains("drug_id")){
            queryCondition =
                    "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id "+
                            "FROM drugdrug where drug_id='"+searchMess+"'";
        }
        else if(radioMess.contains("drug_name")) {
            queryCondition =
                    "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id  "+
                            "FROM drugdrug where drug_name like '%"+searchMess+"%'";
        }
        else if(radioMess.contains("drug_price")) {
            String priceMess[] = searchMess.split("[-]+");
            try{
                min = Float.parseFloat(priceMess[0]);
                max = Float.parseFloat(priceMess[1]);
            }
            catch(NumberFormatException exp){
                min = 0;
                max = 0;
            }
            queryCondition =
                    "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id "+
                            "FROM drugdrug where drug_price<="+max+" and drug_price>="+min;
        }
        Record_Bean dataBean=null;
        try{
            dataBean=(Record_Bean)session.getAttribute("dataBean");
            if(dataBean==null){
                dataBean=new Record_Bean();  //创建bean。
                session.setAttribute("dataBean",dataBean);//是session bean。
            }
        }
        catch(Exception exp){}

        //直接加载JDBC-mySQL加载器
        try {
            Class.forName("com.mysql.jdbc.Driver");

        } catch (Exception e) {
            response.getWriter().print("遇到错误！#SearchByCondition#" + e);
        }

        String url = "jdbc:mysql://localhost:3306/hospital?" +
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root", psw = "5200";

        try{

            con = DriverManager.getConnection(url, us, psw);//直接连接数据库

            Statement sql=con.createStatement();
            ResultSet rs=sql.executeQuery(queryCondition);
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount(); //得到结果集的列数。
            rs.last();
            int rows=rs.getRow();  //得到记录数。
            String [][] tableRecord=dataBean.getTableRecord();
            tableRecord = new String[rows][columnCount];
            rs.beforeFirst();
            int i=0;
            while(rs.next()){
                for(int k=0;k<columnCount;k++)
                    tableRecord[i][k] = rs.getString(k+1);
                i++;
            }
            dataBean.setTableRecord(tableRecord); //更新bean。
            con.close();
            response.sendRedirect("byPageShow.jsp"); //重定向。
        }
        catch(Exception e){
            response.getWriter().print("遇到错误！#SearchByCondition#" + e);
        }
        finally{
            try{
                con.close();
            }
            catch(Exception ee){}
        }
    }
}
