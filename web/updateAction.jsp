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
    if (userId == null) {
        writer.println("<script>");
        writer.println("alert('로그인을 해주세요')");
        writer.println("location.href='login.jsp'");
        writer.println("</script>");
    }
    int boardId = 0;
    System.out.println("updateAction boardId : 파라미터 넣기 전 -> "+boardId);
    if (request.getParameter("boardId") != null) {
        boardId = Integer.parseInt(request.getParameter("boardId"));
    }
    System.out.println("updateAction boardId : 파라미터 넣은 후 -> "+boardId);
    // 입력이 안 됐거나 빈 값이 있는지 체크한다
    if (request.getParameter("boardTitle") == null || request.getParameter("content") == null
            || request.getParameter("boardTitle").equals("") || request.getParameter("content").equals("")) {
        writer.println("<script>");
        writer.println("alert('입력이 안 된 사항이 있습니다')");
        writer.println("history.back()");
        writer.println("</script>");
    } else {
        // 정상적으로 입력이 되었다면 글 수정 로직을 수행한다
        boardDAO boardDAO = new boardDAO();
        int result = boardDAO.update(boardId, request.getParameter("boardTitle"), request.getParameter("content"));
        // 데이터베이스 오류인 경우
        if (result == -1) {
            writer.println("<script>");
            writer.println("alert('글 수정하기에 실패했습니다')");
            writer.println("history.back()");
            writer.println("</script>");
            // 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
        } else {
            writer.println("<script>");
            writer.println("alert('글 수정하기 성공')");
            writer.println("location.href='board.jsp'");
            writer.println("</script>");
        }
    }


%>
</body>
</html>