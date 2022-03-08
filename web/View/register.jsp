<%-- 
    Document   : register
    Created on : Mar 7, 2022, 10:38:07 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function validateForm(){
                let password = document.forms["registerForm"]["password"].value;
                let retypePassword = document.forms["registerForm"]["retypePassword"].value;
                if(password !== retypePassword){
                    alert("mật khẩu nhập lại sai");
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <form name="registerForm" action="Register" method="POST" onsubmit="return validateForm()">
            <div>
                Loại tài khoản:
                <select name="role">
                    <option value="admin">admin</option>
                    <option value="manager">Quản lí</option>
                    <option value="teacher">Giáo viên</option>
                    <option value="student">Học sinh</option>
                </select>
            </div>
            <div>
                Tên đăng nhập:
                <input type="text" name="username" required="true">
            </div>
            <div>
                Mật khẩu:
                <input type="password" name="password" required="true"><br>
                Nhập lại Mật khẩu:
                <input type="password" name="retypePassword" required="true"><br>                
            </div>
            <div>
                Tên: <input type="text" name = "name" required="true">
            </div>
            <div>
            Giới Tính: <input type="radio" name="gender" value = "true" checked>Male
                    <input type="radio" name="gender" value = "false">Female
            </div>
            <div>
            Số điện thoại: <input type="text" name="phoneNumber"><br>
            </div>
            <div>
            Gmail: <input type="text" name="gmail"><br>
            </div>
            <input type="submit" value="Thêm">
        </form>
    </body>
</html>
