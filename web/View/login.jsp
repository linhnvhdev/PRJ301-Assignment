<%-- 
    Document   : login
    Created on : Feb 20, 2022, 9:49:00 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- header -->
        <div class="container-fluid bg-light header pt-4" >
            <div class="row pl-9">
                <div class="col-9 "><h3>Hệ thống quản lí bán trú trường THCS Lê Quý Đôn</h3></div>
                <div class="col-3 d-flex justify-content-end"></div>
            </div>
        </div>
        <!-- login -->
        <div class="d-flex justify-content-center align-items-center text-center myLogin">
            <form action = "login" method="POST" class="border border-dark">
                <h1 class="h3 m3">Đăng nhập</h1>
                <input type="text" name="username" class="form-control mt-3" required autofocus placeholder="Tên đăng nhập">
                <input type="password" name="password" class="form-control mt-3" required autofocus placeholder="Mật khẩu">
                <input type="submit" value='Login' class="btn btn-lg btn-primary btn-block mt-3">
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
