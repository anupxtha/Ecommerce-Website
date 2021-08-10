<%@page import="com.learn.mycart.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("check", "error");
        session.setAttribute("message", "You are not login in !! Login First !!");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("admin")) {
            session.setAttribute("check", "error");
            session.setAttribute("message", "You are Admin!! Why are you trying to login as Normal!!");
            response.sendRedirect("login.jsp");
            return;
        }
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Normal Panel - My Cart</title>

        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <h1>This is  Normal panel</h1>

    </body>
</html>
