<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="content"/>
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
    }else {
        if(board.getBoardTitle() == null || board.getContent() == null){
            writer.println("<script>");
            writer.println("alert('입력이 되지 않은 사항이 있습니다')");
            writer.println("history.back();");
            writer.println("</script>");
        }else {
            boardDAO boardDAO = new boardDAO();
            int result = boardDAO.write(board.getBoardTitle(),userId, board.getContent());
            if(result ==-1){
                writer.println("<script>");
                writer.println("alert('글쓰기에 실패하였습니다')");
                writer.println("history.back();");
                writer.println("</script>");
            }else {
                writer.println("<script>");
                writer.println("location.href = 'board.jsp';");
                writer.println("</script>");
            }
        }
    }


%>
</body>
</html>