<%-- 
    Document   : insert
    Created on : Mar 3, 2022, 10:41:41 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="insert" method="POST">
            <div>
            Tên: <input type="text" name = "name">
            </div>
            <div>
            Lớp: <select name="classId">
                <c:forEach items="${requestScope.classes}" var="c">
                    <option value="${c.id}">${c.name}</option>
                </c:forEach>
            </select>
            </div>
            <div>
            Giới Tính: <input type="radio" name="gender" value = "true">Male
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
