<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.boardDAO" %>
<%@ page import="board.Board" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewprot" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
    int boardId = 0;
    String userId = null;
    PrintWriter writer = response.getWriter();
    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }
    if (userId == null) {
        writer.println("<script>");
        writer.println("alert('로그인을 해주세요.')");
        writer.println("location.href='login.jsp'");
        writer.println("</script>");
    }
    System.out.println("update.jsp boardId 파라미터값 넣기 전: "+boardId);
    if (request.getParameter("boardId") != null) {
        boardId = Integer.parseInt(request.getParameter("boardId"));
    }
    System.out.println("update.jsp boardId 파라미터값 넣은 후 : "+boardId);
    if (boardId == 0) {
        writer.println("<script>");
        writer.println("alert('유효하지 않은 글입니다.')");
        writer.println("location.href='board.jsp'");
        writer.println("</script>");
    }
    Board board = new boardDAO().getBoard(boardId);
    if (!userId.equals(board.getUserId())) {
        writer.println("<script>");
        writer.println("alert('권한이 없습니다.')");
        writer.println("location.href='board.jsp'");
        writer.println("</script>");
    }
%>
<nav class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li class="active"><a href="board.jsp">게시판</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="logoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <form method="post" action="updateAction.jsp?boardId=<%=boardId%>">
            <table class="table table-striped" style="text-align: center" border="1px solid #dddddd">
                <thead>
                <tr>
                    <th colspan="2" style="background-color: #eeeeee; text-align: center">게시판 글 수정 양식</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input type="text" class="form-control" placeholder="글 제목" name="boardTitle" maxlength="50"
                               value="<%=board.getBoardTitle()%>">
                    </td>
                </tr>
                <tr>
                    <td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048"
                                  height="350em;" value="<%=board.getContent()%>"></textarea></td>
                </tr>
                </tbody>
            </table>
            <input type="submit" class="btn btn-primary pull-right" value="수정하기">
        </form>
    </div>
</div>
<script src="https://code.juery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
