package board;

import java.sql.*;
import java.util.ArrayList;

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

    public ArrayList<Board> getList(int pageNumber){
        String sql = "select * from board where boardid < ? and available = 1 order by userid desc limit 10";
        ArrayList<Board> list = new ArrayList<Board>();
        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()){
                Board board = new Board();
                board.setBoardId(rs.getInt(1));
                board.setBoardTitle(rs.getString(2));
                board.setUserId(rs.getString(3));
                board.setDate(rs.getDate(4));
                board.setContent(rs.getString(5));
                board.setAvailable(rs.getInt(6));
                list.add(board);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

    public boolean nextPage(int pageNumber){
        String sql ="select * from board where boardid < ? and available = 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10 );
            rs = pstmt.executeQuery();
            if(rs.next()){
                return true;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public Board getBoard(int boardId){
        String sql = "select * from board where boardid = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,boardId);
            rs = pstmt.executeQuery();
            if(rs.next()){
                Board board = new Board();
                board.setBoardId(rs.getInt(1));
                board.setBoardTitle(rs.getString(2));
                board.setUserId(rs.getString(3));
                board.setDate(rs.getDate(4));
                board.setContent(rs.getString(5));
                board.setAvailable(rs.getInt(6));
                return board;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

}
