<%-- 
    Document   : update
    Created on : Mar 8, 2022, 12:02:47 PM
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
    </head>
    <body>
        <form action="update" method="POST">
            <input type="hidden" name="userId" value="${u.id}">
            <div>
                Tên: <input type="text" name = "name" value="${u.name}">
            </div>
            <div>
                Giới Tính: <input type="radio"
                            ${(u.sex)?"checked":""}
                            name="gender" value = "true">Male
                    <input type="radio" 
                            ${(!u.sex)?"checked":""}
                            name="gender" value = "false">Female
            </div>
            <div>
                Số điện thoại: <input type="text" name="phoneNumber" value="${u.phoneNumber}"><br>
            </div>
            <div>
                Gmail: <input type="text" name="gmail" value="${u.gmail}"><br>
            </div>
            <input type="submit" value="Sửa">
        </form>
    </body>
</html>
