<%-- 
    Document   : attendance
    Created on : Mar 8, 2022, 10:35:48 PM
    Author     : Linhnvhdev
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function submitForm(){

            }
        </script>
    </head>
    <body>
        <form>
            Ngày: <input type="date" name="date" value="${requestScope.Date}" onchange="this.form.submit()">
        </form>
        <form action="attendance" method="POST">
            <input type="hidden" name="date" value="${requestScope.Date}">
            <table border="1px">
                <tr>
                    <td>ID</td>
                    <td>Tên</td>
                    <td>Lớp</td>
                    <td>Giới tính</td>
                    <td>Số điện thoại</td>
                    <td>Phòng</td>
                    <td colspan="2">Điểm danh</td>
                </tr>
                <c:forEach items="${requestScope.students}" var="s">
                    <tr>
                        <td>${s.id}</td>
                        <td>${s.name}</td>
                        <td>${s.classes.name}</td>
                        <td>${s.sex?"Nam":"Nữ"}</td>
                        <td>${s.phoneNumber}</td>
                        <td>${(s.roomId==0)?"Chưa có":s.getRoomId()}</td>
                        <td>
                            <input type="radio" name="${"attendance"}${s.id}" value = "True"
                                   ${(requestScope.attendances.get(s.id))?"checked=\"true\"":""}>
                        </td>
                        <td>
                            <input type="radio" name="${"attendance"}${s.id}" value = "False" 
                                   ${(!requestScope.attendances.get(s.id))?"checked=\"true\"":""}>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <input type="submit" value="Điểm danh"> 
            <input type="reset" value="reset">
        </form>
    </body>
</html>
