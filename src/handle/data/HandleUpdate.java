package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:17
 */
import save.data.Login;

import javax.servlet.annotation.WebServlet;
import javax.sql.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

@WebServlet("/updateServlet")

public class HandleUpdate extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public  void  service(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException,IOException {
        request.setCharacterEncoding("utf-8");
        String amount = request.getParameter("update");
        String car_id = request.getParameter("car_id");
        if(amount ==null)
            amount="1";
        int newAmount = 0;
        try{
            newAmount =Integer.parseInt(amount);
            if(newAmount<0){
                newAmount = 1;
            }
        }
        catch(NumberFormatException exp){
            newAmount = 1;
        }
        Connection con=null;
        PreparedStatement pre=null; //预处理语句。
        Login loginBean=null;
        HttpSession session=request.getSession(true);
        try{
            loginBean = (Login)session.getAttribute("loginBean");
            if(loginBean==null){
                response.sendRedirect("login.jsp");//重定向到登录页面。
                return;
            }
            else {
                boolean b =loginBean.getLogname()==null||
                        loginBean.getLogname().length()==0;
                if(b){
                    response.sendRedirect("login.jsp");//重定向到登录页面。
                    return;
                }
            }
        }
        catch(Exception exp){
            response.sendRedirect("login.jsp");//重定向到登录页面。
            return;
        }

        //直接加载JDBC-mySQL加载器
        try {
            Class.forName("com.mysql.jdbc.Driver");

        } catch (Exception e) {
            response.getWriter().print("遇到错误！#HandleUpdate#"+e);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?"+
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root",psw = "5200";



        try {

            con = DriverManager.getConnection(url,us,psw);//直接连接数据库

            String updateSQL =
                    "update shoppingcar set car_Amount =? where car_id=?"; //更新购物车。
            pre = con.prepareStatement(updateSQL);
            pre.setInt(1,newAmount);
            pre.setString(2,car_id);
            pre.executeUpdate();
            con.close();
            response.sendRedirect("lookShoppingCar.jsp");//查看购物车。
        }
        catch(SQLException e) {
            response.getWriter().print(""+e);
        }
        finally{
            try{
                con.close();
            }
            catch(Exception ee){}
        }
    }
}
