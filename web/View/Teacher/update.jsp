<%-- 
    Document   : update
    Created on : Mar 3, 2022, 10:43:32 PM
    Author     : Linhnvhdev
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="update" method="POST">
            <input type="hidden" name="teacherId" value="${requestScope.teacher.id}">
            <div>
                Tên: <input type="text" name = "name" value="${requestScope.teacher.name}">
            </div>
            <div>
            Lớp: <select name="classId">
                <c:forEach items="${requestScope.classes}" var="c">
                    <option
                        ${(requestScope.teacher.classes.id == c.id)?"selected=\"selected\"":""}
                        value="${c.id}">${c.name}</option>
                </c:forEach>
                </select>
            </div>
            <div>
                Giới Tính: <input type="radio"
                            ${(requestScope.teacher.sex)?"checked":""}
                            name="gender" value = "true">Male
                    <input type="radio" 
                            ${(!requestScope.teacher.sex)?"checked":""}
                            name="gender" value = "false">Female
            </div>
            <div>
                Số điện thoại: <input type="text" name="phoneNumber" value="${requestScope.teacher.phoneNumber}"><br>
            </div>
            <div>
                Gmail: <input type="text" name="gmail" value="${requestScope.teacher.gmail}"><br>
            </div>
            <input type="submit" value="Sửa">
        </form>
    </body>
</html>
