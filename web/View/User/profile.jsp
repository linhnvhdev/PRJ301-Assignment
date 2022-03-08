<%-- 
    Document   : profile
    Created on : Mar 8, 2022, 11:09:31 AM
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
        <c:set var="u" value="${sessionScope.account.user}"/>
        <table border="1px">
            <tr>
                <td>ID</td>
                <td>Tên</td>
                <td>Giới tính</td>
                <td>Số điện thoại</td>
                <td>Gmail</td>
                <c:if test="${(u.role == 3 || u.role == 4)}">
                    <td>Lớp</td>
                </c:if>
                <c:if test="${u.role == 4}">
                    <td>Phòng</td>
                </c:if>
                <td></td>
            </tr>
            
                <tr>
                    <td>${u.id}</td>
                    <td>${u.name}</td>
                    <td>${u.sex?"Nam":"Nữ"}</td>
                    <td>${u.phoneNumber}</td>
                    <td>${u.gmail}</td>
                    <c:if test="${(u.role == 3 || u.role == 4)}">
                        <c:if test="${u.role == 3}"><td>${requestScope.teacher.classes.name}</td></c:if>
                        <c:if test="${u.role == 4}"><td>${requestScope.student.classes.name}</td></c:if>
                    </c:if>
                    <c:if test="${u.role == 4}">
                    <td>${requestScope.student.roomId}</td>
                     </c:if>
                    <td>
                        <form action="profile/update" method="GET">
                            <button type="submit" name="userId" value="${u.id}">
                                Sửa
                            </button>
                        </form>
                    </td>
                </tr>
        </table>
                                
        <a href="profile/pwd">Đổi mật khẩu</a>
    </body>
</html>
