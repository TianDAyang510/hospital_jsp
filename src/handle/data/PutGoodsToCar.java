package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:18
 */
import save.data.Login;

import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

@WebServlet("/putGoodsServlet")

public class PutGoodsToCar extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public  void  service(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException,IOException {
        request.setCharacterEncoding("utf-8");
        Connection con=null;
        PreparedStatement pre=null; //预处理语句。
        ResultSet rs;
        String drug_id = request.getParameter("drug_id");
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
//            String backNews = "数据库链接失败：" + e;
//            fail(request, response, logname, backNews);
            response.getWriter().print("遇到错误！#PutGoodsToCar#"+e);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?"+
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root",psw = "5200";



        try {

            con = DriverManager.getConnection(url,us,psw);//直接连接数据库

            String queryDrugForm =
                    "select * from drugdrug where drug_id =?";//查询商品表。
            String queryShoppingForm =
                    "select car_Amount from shoppingcar where car_id =?";//购物车表。
            String updateSQL =
                    "update shoppingcar set car_Amount =? where car_id=?"; //更新购物车。
            String insertSQL =
                    "insert into shoppingcar values(?,?,?,?,?)";//添加到购物车。
            pre = con.prepareStatement(queryShoppingForm);
            pre.setString(1,drug_id);
            rs = pre.executeQuery();
            if(rs.next()){ //该货物已经在购物车中。
                int amount = rs.getInt(1);
                amount++;
                pre = con.prepareStatement(updateSQL);
                pre.setInt(1,amount);
                pre.setString(2,drug_id);
                pre.executeUpdate(); //更新购物车中该货物的数量。
            }
            else {  //向购物车添加商品。
                pre = con.prepareStatement(queryDrugForm);
                pre.setString(1,drug_id);
                rs = pre.executeQuery();
                if(rs.next()){
                    pre = con.prepareStatement(insertSQL);
                    pre.setString(1,rs.getString("drug_id"));
                    pre.setString(2,loginBean.getLogname());
                    pre.setString(3,rs.getString("drug_name"));
                    pre.setFloat(4,rs.getFloat("drug_price"));
                    pre.setInt(5,1);
                    pre.executeUpdate(); //向购物车中添加该货物。
                }
            }
            con.close();
            response.sendRedirect("lookShoppingCar.jsp");//查看购物车。
        }
        catch(SQLException exp){
            response.getWriter().print("遇到错误！#PutGoodsToCar#"+exp);
        }
//        catch(NamingException exp){}
        finally{
            try{
                con.close();
            }
            catch(Exception ee){}
        }
    }
}
