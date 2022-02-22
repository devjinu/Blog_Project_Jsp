<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
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
    if (userId != null) {
        writer.println("<script>");
        writer.println("alert('이미 로그인이 되어있습니다')");
        writer.println("location.href='main.jsp'");
        writer.println("</script>");
    }


    if (user.getUserId() == null || user.getUserPassword() == null || user.getUserGender() == null
            || user.getUserEmail() == null || user.getUserName() == null) {
        writer.println("<script>");
        writer.println("alert('입력되지 않은 사항이 있습니다.')");
        writer.println("history.back()");
        writer.println("</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
        if (result == -1) {
            writer.println("<script>");
            writer.println("alert('이미 존재하는 아이디입니다.')");
            writer.println("history.back()");
            writer.println("</script>");
        } else {
            session.setAttribute("userId", user.getUserId());
            writer.println("<script>");
            writer.println("location.href='main.jsp'");
            writer.println("</script>");
        }
    }

%>
</body>
</html>