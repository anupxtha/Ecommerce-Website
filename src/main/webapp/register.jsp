<%-- 
    Document   : register
    Created on : Jul 23, 2021, 9:58:16 AM
    Author     : Anup-Xtha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.learn.mycart.helper.*" %>
<%@page import="com.learn.mycart.servlets.*" %>
<%@page import="com.learn.mycart.entities.*" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>

        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container-fluid">

            <div class="row mt-4">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-body px-5">

                            <%@include file="components/message.jsp" %>

                            <h3 class="text-center">Sign Up Here</h3>

                            <form action="RegisterServlet" method="post">
                                <div class="form-group">
                                    <label for="name">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name" placeholder="Enter Name Here" aria-describedby="emailHelp" placeholder="Enter email">
                                </div>
                                <div class="form-group">
                                    <label for="email">User Email</label>
                                    <input name="user_email" type="email" class="form-control" id="email" placeholder="Enter Email Here" aria-describedby="emailHelp" placeholder="Enter email">
                                </div>
                                <div class="form-group">
                                    <label for="password">User Password</label>
                                    <input name="user_password" type="password" class="form-control" id="password" placeholder="Enter password Here" aria-describedby="emailHelp" placeholder="Enter email">
                                </div>
                                <div class="form-group">
                                    <label for="phone">User phone</label>
                                    <input name="user_phone" type="number" class="form-control" id="phone" placeholder="Enter phone Here" aria-describedby="emailHelp" placeholder="Enter email">
                                </div>
                                <div class="form-group">
                                    <label for="address">User Address</label>
                                    <textarea style="height: 100px;" name="user_address" id="address" class="form-control" placeholder="Enter Your Address"></textarea>
                                </div>
                                <div class="container text-center">
                                    <button type="submit" class="btn btn-outline-success">Register</button>
                                    <button type="reset" class="btn btn-outline-success">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </body>

</html>
