<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
    <meta name="viewprot" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="css/custom.css">
    <script src="js/bootstrap.js"></script>
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
<%

    String userId = null;
    if (session.getAttribute("userID") != null) {
        userId = (String) session.getAttribute("userId");
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
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a>
            <li><a href="board.jsp">게시판</a>
        </ul>
        <%
            if (userId == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropddown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
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
                <a href="#" class="dropdown-toggle" data-toggle="dropddown" role="button" aria-haspopup="true"
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
    <div class="jumbotron">
        <div class="container">
            <h1>웹 사이트 소개</h1>
            <p>이 웹 사이트는 부트스트랩으로 만든 JSP 웹 사이트 입니다. 최소한의 간단한 로직만을 이용해서 개발했습니다. 디자인 템플릿으로는 부트스트랩을 이용하였습니다.</p>
            <p><a class="btn btn-primary" href="#" role="button">자세히 알아보기</a></p>
        </div>
    </div>
</div>
<div class="container">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"> </li>
            <li data-target="#myCarousel" data-slide-to="1"> </li>
            <li data-target="#myCarousel" data-slide-to="2"> </li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img src="/mages/1.jpg">
            </div>
            <div class="item">
                <img src="images/2.jpg">
            </div>
            <div class="item">
                <img src="images/3.jpg">
            </div>
        </div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
</div>
<script src="https://code.juery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
</body>
</html>
