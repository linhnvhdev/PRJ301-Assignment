<%-- 
    Document   : order
    Created on : Mar 15, 2022, 10:59:12 AM
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
        <form action="order" method="GET">
            <select name="month" id="monthForm" onchange="this.form.submit()">
                <c:forEach var="i" begin="1" end="12">
                    <option value="${i}" ${(month == i)?"selected=\"selected\"":""}>${i}</option>
                </c:forEach>
            </select>
            <select name="year" id="yearForm" onchange="this.form.submit()">
                <c:forEach var="i" begin="${year-1}" end="${year}">
                    <option value="${i}" ${(year == i)?"selected=\"selected\"":""}>${i}</option>
                </c:forEach>
            </select>
        </form>
        <form action="order" method="GET">
            <c:if test="${!requestScope.search}">
                <input type="hidden" name="search" value="true">
                <input type="submit" value="Xem học sinh chưa đóng tiền">
            </c:if>
            <c:if test="${requestScope.search}">
                <input type="hidden" name="search" value="false">
                <input type="submit" value="Xem tất cả">
            </c:if>
        </form>
        <c:if test="${requestScope.students.size() == 0}">
            <div>
                Không có học sinh nào
            </div>  
        </c:if>
        <c:if test="${requestScope.students.size() > 0}">
            <form action="order" method="POST">
                <input type="hidden" name="month" value="${month}">
                <input type="hidden" name="year" value="${year}">
                <table border="1px">
                    <tr>
                        <td>ID</td>
                        <td>Tên</td>
                        <td>Lớp</td>
                        <td>Số điện thoại</td>
                        <td>Phòng</td>
                        <td>Đóng tiền tháng</td>
                    </tr>
                    <c:forEach items="${requestScope.students}" var="s">
                    <tr>
                        <td>${s.id}</td>
                        <td>${s.name}</td>
                        <td>${s.classes.name}</td>
                        <td>${s.phoneNumber}</td>
                        <td>${(s.roomId==0)?"Chưa có":s.getRoomId()}</td>
                        <td><input type="checkbox" name="isOrder${s.id}" value="true"
                                   ${requestScope.orders.get(s.id)?"checked=\"true\"":""}></td>
                    </tr>
                    </c:forEach>
                </table>
                <input type="submit" value="Cập nhập">
            </form>
        </c:if>
    </body>
</html>
