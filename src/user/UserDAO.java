package user;

import sun.print.PSStreamPrinterFactory;

import java.sql.*;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO(){
        try {
            String dbURL = "jdbc:mysql://localhost:3306/bbs";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userId, String userPassword){
        String SQL = "select userpassword from user where userid = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if(rs.next()){
                // 아이디, 비밀번호 확인 -> 성공 return 1
                if(rs.getString(1).equals(userPassword)){
                    return 1;
                }else {
                    // 비밀번호 오류
                    return 0;
                }
            }
            // 아이디가 없음
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            // DB오류
            return -2;
        }
    }

}
