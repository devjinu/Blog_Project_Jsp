<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="board.boardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javafx.scene.control.Alert" %>
<% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
    <title>JSP 게시판 만들기</title>
</head>
<body>
<%
    PrintWriter writer = response.getWriter();
    String userId = null;
    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }
    // 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
    if (userId == null) {
        writer.println("<script>");
        writer.println("alert('로그인을 하세요')");
        writer.println("location.href='login.jsp'");
        writer.println("</script>");
    }

    int boardId = 0;
    if (request.getParameter("boardId") != null) {
        boardId = Integer.parseInt(request.getParameter("boardId"));
    }
    if (boardId == 0) {
        writer.println("<script>");
        writer.println("alert('유효하지 않은 글입니다')");
        writer.println("location.href='bbs.jsp'");
        writer.println("</script>");
    }
    Board board = new boardDAO().getBoard(boardId);
    if (!userId.equals(board.getUserId())) {
        writer.println("<script>");
        writer.println("alert('권한이 없습니다')");
        writer.println("location.href='bbs.jsp'");
        writer.println("</script>");
    } else {
        // 글 삭제 로직을 수행한다
        boardDAO boardDAO = new boardDAO();
        int result = boardDAO.delete(boardId);
        // 데이터베이스 오류인 경우
        if (result == -1) {
            writer.println("<script>");
            writer.println("alert('글 수정하기에 실패했습니다')");
            writer.println("history.back()");
            writer.println("</script>");
            // 글 삭제가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
        } else {
            writer.println("<script>");
            writer.println("alert('글 삭제하기 성공')");
            writer.println("location.href='board.jsp'");
            writer.println("</script>");
        }
    }

%>
</body>
</html>