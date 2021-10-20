package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:17
 */

import save.data.*;

import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

@WebServlet("/loginServlet")

public class HandleLogin extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        Statement sql;
        String logname = request.getParameter("logname").trim(),
                password = request.getParameter("password").trim();
        password = Encrypt.encrypt(password, "javajsp");//给用户密码加密。
        boolean boo = (logname.length() > 0) && (password.length() > 0);

        //直接加载JDBC-mySQL加载器
        try {
            Class.forName("com.mysql.jdbc.Driver");

        } catch (Exception e) {
            String backNews = "数据库链接失败：" + e;
            fail(request, response, logname, backNews);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?"+
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root",psw = "5200";

        try {

            con = DriverManager.getConnection(url,us,psw);//直接连接数据库

            String condition = "select * from user where logname = '" + logname +
                    "' and password ='" + password + "'";
            sql = con.createStatement();
            if (boo) {
                ResultSet rs = sql.executeQuery(condition);
                boolean m = rs.next();
                if (m == true) {
                    //调用登录成功的方法:
                    success(request, response, logname, password);
                    RequestDispatcher dispatcher =
                            request.getRequestDispatcher("index.jsp");//转发
                    dispatcher.forward(request, response);
                } else {
                    String backNews = "您输入的用户名不存在，或密码不般配";
                    //调用登录失败的方法:
                    fail(request, response, logname, backNews);
                }
            } else {
                String backNews = "请输入用户名和密码";
                fail(request, response, logname, backNews);
            }
            con.close();//连接返回连接池。
        } catch (SQLException exp) {
            String backNews = "" + exp;
            fail(request, response, logname, backNews);
        } finally {
            try {
                con.close();
            } catch (Exception ee) {
            }
        }
    }

    public void success(HttpServletRequest request,
                        HttpServletResponse response,
                        String logname, String password) {
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            if (loginBean == null) {
                loginBean = new Login();  //创建新的数据模型 。
                session.setAttribute("loginBean", loginBean);
                loginBean = (Login) session.getAttribute("loginBean");
            }
            String name = loginBean.getLogname();
            if (name.equals(logname)) {
                loginBean.setBackNews(logname + "已经登录了");
                loginBean.setLogname(logname);
            } else {  //数据模型存储新的登录用户:
                loginBean.setBackNews(logname + "登录成功");
                loginBean.setLogname(logname);
            }
        } catch (Exception ee) {
            loginBean = new Login();
            session.setAttribute("loginBean", loginBean);
            loginBean.setBackNews(ee.toString());
            loginBean.setLogname(logname);
        }
    }

    public void fail(HttpServletRequest request,
                     HttpServletResponse response,
                     String logname, String backNews) {
        response.setContentType("text/html;charset=utf-8");
        try {
            PrintWriter out = response.getWriter();
            out.println("<html><body><center>");
            out.println("<h2>用户--" + logname + "--登录反馈结果:<br></h2>");
            out.println("<h2 style=\"color:firebrick\">"+ backNews +"</h2>");
            out.println("返回登录页面或主页<br>");
            out.println("<br><a href =login.jsp>点我返回：登录页面</a><br>");
            out.println("<br><a href =index.jsp>点我返回：主页</a>");
            out.println("</center></body></html>");
        } catch (IOException exp) {
        }
    }
}
