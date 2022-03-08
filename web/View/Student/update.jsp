<%-- 
    Document   : update
    Created on : Feb 28, 2022, 11:25:39 PM
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
            <input type="hidden" name="studentId" value="${requestScope.student.id}">
            <div>
                Tên: <input type="text" name = "name" value="${requestScope.student.name}">
            </div>
            <div>
            Lớp: <select name="classId">
                <c:forEach items="${requestScope.classes}" var="c">
                    <option
                        ${(requestScope.student.classes.id == c.id)?"selected=\"selected\"":""}
                        value="${c.id}">${c.name}</option>
                </c:forEach>
                </select>
            </div>
            <div>
                Giới Tính: <input type="radio"
                            ${(requestScope.student.sex)?"checked":""}
                            name="gender" value = "true">Male
                    <input type="radio" 
                            ${(!requestScope.student.sex)?"checked":""}
                            name="gender" value = "false">Female
            </div>
            <div>
            Số điện thoại: <input type="text" name="phoneNumber" value="${requestScope.student.phoneNumber}"><br>
            </div>
            <div>
            Phòng: <select name="roomId">
                <option 
                    ${(requestScope.student.roomId == 0)?"selected=\"selected\"":""}
                    value="0">Chưa xếp</option> 
                <c:forEach var="i" begin="1" end="6">
                <option 
                    ${(requestScope.student.roomId == i)?"selected=\"selected\"":""}
                    value=${i}>${i}</option>
                </c:forEach>
            </select>
            </div>
            <input type="submit" value="Sửa">
        </form>
    </body>
</html>

