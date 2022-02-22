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
    // 현재 세션 상태를 체크한다
    String userId = null;
    if(session.getAttribute("userId") != null){
        userId = (String)session.getAttribute("userId");
    }
    // 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
    if(userId == null){
        writer.println("<script>");
        writer.println("alert('로그인을 하세요')");
        writer.println("location.href='login.jsp'");
        writer.println("</script>");
    }else{
        // 입력이 안 된 부분이 있는지 체크한다
        if(board.getBoardTitle() == null || board.getContent() == null){
            writer.println("<script>");
            writer.println("alert('입력이 되지 않은 사항이 있습니다')");
            writer.println("history.back()");
            writer.println("</script>");
        }else{
            // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
            boardDAO boardDAO = new boardDAO();
            int result = boardDAO.write(board.getBoardTitle(), userId, board.getContent());
            // 데이터베이스 오류인 경우
            if(result == -1){
                writer.println("<script>");
                writer.println("alert('글쓰기에 실패했습니다')");
                writer.println("history.back()");
                writer.println("</script>");
                // 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
            }else {
                writer.println("<script>");
                writer.println("alert('글쓰기 성공')");
                writer.println("location.href='board.jsp'");
                writer.println("</script>");
            }
        }
    }

%>
</body>
</html>