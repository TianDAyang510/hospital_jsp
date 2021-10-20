package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:17
 */

import save.data.Login;

import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

@WebServlet("/buyServlet")

public class HandleBuyGoods extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String logname = request.getParameter("logname");
        Connection con = null;
        PreparedStatement pre = null; //预处理语句。
        ResultSet rs;
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            if (loginBean == null) {
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
        } catch (Exception exp) {
            response.sendRedirect("login.jsp");//重定向到登录页面。
            return;
        }


        //直接加载JDBC-mySQL加载器
        try {
            Class.forName("com.mysql.jdbc.Driver");

        } catch (Exception e) {
            response.getWriter().print("遇到错误！#lookDrug#" + e);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?" +
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root", psw = "5200";

        try {

            con = DriverManager.getConnection(url, us, psw);//直接连接数据库


            String querySQL =
                    "select * from shoppingcar where logname = ?"; //购物车。
            String insertSQL = "insert into orderForm values(?,?,?)";//订单表。
            String deleteSQL = "delete from shoppingcar where logname =?";
            pre = con.prepareStatement(querySQL);
            pre.setString(1, logname);
            rs = pre.executeQuery();//查询购物车。
            StringBuffer buffer = new StringBuffer();
            float sum = 0;
            boolean canCreateForm = false;//是否可以产生订单。
            while (rs.next()) {
                canCreateForm = true;
                String car_id = rs.getString(1);
                logname = rs.getString(2);
                String car_name = rs.getString(3);
                float price = rs.getFloat(4);
                int amount = rs.getInt(5);
                sum += price * amount;
                buffer.append("<br>药品编号：" + car_id + "，药品名称：" + car_name +
                        "，药品单价：" + price + "，药品数量：" + amount + "<br>");
            }
            if (canCreateForm == false) {
                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>" + logname + "请先选择商品添加到购物车");
                out.println("<br><a href =index.jsp>主页</a></h2>");
                out.println("</body></html>");
                return;
            }
            String strSum = String.format("%10.2f", sum);
            buffer.append("<br>" + logname + "<br><br>您的购物车药品总价为：<br>" + strSum + "元<br>");
            pre = con.prepareStatement(insertSQL);
            pre.setInt(1, 0);  //订单号会自动增加。
            pre.setString(2, logname);
            pre.setString(3, new String(buffer));
            pre.executeUpdate();//添加到订单表。
            pre = con.prepareStatement(deleteSQL);
            pre.setString(1, logname);
            pre.executeUpdate(); //删除logname的购物车中货物。
            con.close();//连接放回连接池。
            response.sendRedirect("lookOrderForm.jsp");//查看订单。
        } catch (Exception e) {
            response.getWriter().print("遇到错误！#lookDrug#" + e);
        } finally {
            try {
                con.close();
            } catch (Exception ee) {
            }
        }
    }
}
