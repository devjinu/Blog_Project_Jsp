package board;

import java.sql.*;

public class boardDAO {
    private Connection conn;
    private ResultSet rs;

    public boardDAO(){
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

    public String getDate(){
        String sql = "select now()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           if(rs.next()){
               return rs.getString(1);
           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public int getNext(){
        String sql = "select boardId from board order by boardId desc";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1)+1;
            }
            return 1; // 첫번째 게시글
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // DB오류
    }

    public int write(String boardTitle, String userId, String content){
        String sql = "insert into board values(?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,getNext());
            pstmt.setString(2,boardTitle);
            pstmt.setString(3,userId);
            pstmt.setString(4,getDate());
            pstmt.setString(5,content);
            pstmt.setInt(6,1);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // DB오류
    }

}
