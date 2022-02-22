<%--
  Created by IntelliJ IDEA.
  User: Moon
  Date: 2022-02-22
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userId" />
<jsp:setProperty name="user" property="userPassword" />
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user.getUserId(), user.getUserPassword());
    PrintWriter writer = response.getWriter();
    if(result == 1){
        writer.println("<script>");
        writer.println("location.href='main.jsp'");
        writer.println("</script>");
    }else if(result == 0){
        writer.println("<script>");
        writer.println("alert('비밀번호가 틀립니다')");
        writer.println("history.back()");
        writer.println("</script>");
    }else if(result == -1){
        writer.println("<script>");
        writer.println("alert('아이디가 존재하지 않습니다')");
        writer.println("history.back()");
        writer.println("</script>");
    }else if(result == -2){
        writer.println("<script>");
        writer.println("alert('DB오류가 발생했습니다')");
        writer.println("history.back()");
        writer.println("</script>");
    }
%>
</body>
</html>
