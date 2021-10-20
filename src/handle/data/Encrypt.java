package handle.data;

/**
 * @author MXHstrat
 * @create 2021 - 10 - 12  15:16
 */
public class Encrypt {
    static String encrypt(String sourceString,String password) {
        char [] p= password.toCharArray();
        int n = p.length;
        char [] c = sourceString.toCharArray();
        int m = c.length;
        for(int k=0;k<m;k++){
            int mima=c[k]+p[k%n];   //加密算法。
            c[k]=(char)mima;
        }
        return new String(c);    //返回密文。
    }
}