package save.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:18
 */
import java.util.*;
public class Login {
    String logname="",
            backNews="未登录";
    public void setLogname(String logname){
        this.logname = logname;
    }
    public String getLogname(){
        return logname;
    }
    public void setBackNews(String s) {
        backNews = s;
    }
    public String getBackNews(){
        return backNews;
    }
}
