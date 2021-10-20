package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:17
 */
import save.data.Register;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

@WebServlet("/registerServlet")

public class HandleRegister extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public  void  service(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException,IOException {
        request.setCharacterEncoding("utf-8");
        Connection con =null;
        PreparedStatement sql=null;
        Register userBean=new Register();  //创建bean。
        request.setAttribute("userBean",userBean);
        String logname=request.getParameter("logname").trim();
        String password=request.getParameter("password").trim();
        String again_password=request.getParameter("again_password").trim();
        String phone=request.getParameter("phone").trim();
        String address=request.getParameter("address").trim();
        String realname=request.getParameter("realname").trim();
        if(logname==null)
            logname="";
        if(password==null)
            password="";
        if(!password.equals(again_password)) {
            userBean.setBackNews("两次密码不同，注册失败，");
            RequestDispatcher dispatcher=
                    request.getRequestDispatcher("inputRegisterMess.jsp");
            dispatcher.forward(request, response);//转发
            return;
        }
        boolean isLD=true;
        for(int i=0;i<logname.length();i++){
            char c=logname.charAt(i);
            if(!(Character.isLetterOrDigit(c)||c=='_'))
                isLD=false;
        }
        boolean boo=logname.length()>0&&password.length()>0&&isLD;
        String backNews="";

        //直接加载JDBC-mySQL加载器
        try {
            Class.forName("com.mysql.jdbc.Driver");

        } catch (Exception e) {
//            String backNews = "数据库链接失败：" + e;
//            fail(request, response, logname, backNews);
            backNews="数据库链接失败#Register#"+e;
            userBean.setBackNews(backNews);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?"+
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root",psw = "5200";


        try{
            con = DriverManager.getConnection(url,us,psw);//直接连接数据库

            String insertCondition="INSERT INTO user VALUES (?,?,?,?,?)";
            sql=con.prepareStatement(insertCondition);
            if(boo){
                sql.setString(1,logname);
                password =
                        Encrypt.encrypt(password,"javajsp");//给用户密码加密。
                sql.setString(2,password);
                sql.setString(3,phone);
                sql.setString(4,address);
                sql.setString(5,realname);
                int m=sql.executeUpdate();
                if(m!=0){
                    backNews="注册成功";
                    userBean.setBackNews(backNews);
                    userBean.setLogname(logname);
                    userBean.setPhone(phone);
                    userBean.setAddress(address);
                    userBean.setRealname(realname);
                }
            }
            else {
                backNews="信息填写不完整或名字中有非法字符";
                userBean.setBackNews(backNews);
            }
            con.close();
        }
        catch(SQLException exp){
            backNews="该会员名已被使用，请您更换名字"+exp;
            userBean.setBackNews(backNews);
        }
        finally{
            try{
                con.close();
            }
            catch(Exception ee){}
        }
        RequestDispatcher dispatcher=
                request.getRequestDispatcher("inputRegisterMess.jsp");
        dispatcher.forward(request, response);//转发
    }
}
