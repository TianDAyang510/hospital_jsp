package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 17  18:03
 */



import save.data.Record_Bean;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/queryServlet2")

public class Query02 extends HttpServlet{
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        String idNumber= request.getParameter("id");
        if(idNumber==null)
            idNumber="1";
        int id = Integer.parseInt(idNumber);
        HttpSession session=request.getSession(true);
        Connection con=null;
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
            response.getWriter().print("遇到错误！#QueryAllRecord#" + e);
        }


        String url = "jdbc:mysql://localhost:3306/hospital?" +
                "useSSL=false&amp;serverTimezone=CST&amp;characterEncoding=utf-8";
        String us = "root", psw = "5200";



        try{

            con = DriverManager.getConnection(url, us, psw);//直接连接数据库

            Statement sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            String query=
                    "SELECT drug_id,drug_name,drug_sup,drug_price,drug_pic,id "+
                            "FROM drugdrug where id="+id;
            ResultSet rs=sql.executeQuery(query);
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
            response.getWriter().print("遇到错误!!!!!!！#QueryAllRecord#" + e);
        }
        finally{
            try{
                con.close();
            }
            catch(Exception ee){}
        }
    }
}
