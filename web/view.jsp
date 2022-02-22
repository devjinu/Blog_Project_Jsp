<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.boardDAO" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewprot" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
    PrintWriter writer = response.getWriter();
    String userId = null;
    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }
    int boardId = 0;
    if (request.getParameter("boardId") != null) {
        boardId = Integer.parseInt(request.getParameter("boardId"));
    }
    if (boardId == 0) {
        writer.println("<script>");
        writer.println("alert('유효하지 않은 글입니다.')");
        writer.println("location.href='board.jsp'");
        writer.println("</script>");
    }
    Board board = new boardDAO().getBoard(boardId);
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
        <%
            if (userId == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li class="active"><a href="login.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <%
        } else {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="logoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center" border="1px solid #dddddd">
            <thead>
            <tr>
                <th colspan="3" style="background-color: #eeeeee; text-align: center">게시판 글 보기</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="width: 20%;">글 제목</td>
                <td colspan="2"><%= board.getBoardTitle()%>
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td colspan="2"><%= board.getUserId()%>
                </td>
            </tr>
            <tr>
                <td>작성일</td>
                <td colspan="2"><%= board.getDate()%>
                </td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="2" style="min-height: 200px; text-align: left"><%= board.getContent().replaceAll(" ", "&nbsp;".replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>"))%>
                </td>
            </tr>
            </tbody>
        </table>
        <a href="board.jsp" class="btn btn-primary">목록</a>
        <%
            if (userId != null && userId.equals(board.getUserId())) {
        %>
        <a href="update.jsp?boardId=<%=boardId%>" class="btn btn-primary">수정</a>
        <a href="deleteAction.jsp?boardId=<%=boardId%>" class="btn btn-primary">삭제</a>
                <%
        }
        %>
            <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
    </div>
</div>
<script src="https://code.juery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
