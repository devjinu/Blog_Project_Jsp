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
        }
        // DB오류
        return -2;
    }

    public int join(User user){
        String sql = "insert into user values(?,?,?,?,? )";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }


}
