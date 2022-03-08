<%-- 
    Document   : pwd
    Created on : Mar 8, 2022, 9:25:19 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <c:set var="u" value="${sessionScope.account.user}"/>
        <script>
            function validateForm(){
                let password = document.forms["changepwd"]["password"].value;
                let passwordNew = document.forms["changepwd"]["passwordNew"].value;
                let retypePasswordNew = document.forms["changepwd"]["retypePasswordNew"].value;
                if(password != ${sessionScope.account.password}){
                    alert("Mật khẩu nhập sai, không thể đổi");
                    return false;
                }
                if(passwordNew != retypePasswordNew){
                    alert("mật khẩu mới nhập lại sai");
                    return false;
                }
                alert("Đổi mật khẩu thành công");
                return true;
            }
        </script>
    </head>
    <body>
        <form name="changepwd" action="pwd" method="POST" onsubmit="return validateForm()">
            <div>
                Nhập mật khẩu:
                <input type="password" name="password" required="true"><br>
                Mật khẩu mới:
                <input type="password" name="passwordNew" required="true"><br>                
                Nhập lại mật khẩu mới:
                <input type="password" name="retypePasswordNew" required="true"><br>                
            </div>
            <input type="submit" value="Đổi mật khẩu">
        </form>
    </body>
</html>
