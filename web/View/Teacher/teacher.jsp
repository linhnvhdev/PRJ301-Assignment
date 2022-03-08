<%-- 
    Document   : teacher
    Created on : Mar 3, 2022, 9:57:48 AM
    Author     : Linhnvhdev
--%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function deleteTeacher(id){
                var result = confirm("Are you sure?");
                if(result){
                    window.location.href = "delete?teacherIdDel="+id;
                }
            }
            
            function displayForm(id){
                var form = document.getElementById(id);
                if(form.style.display === 'none'){
                    form.style.display = 'block';
                }
                else{
                    form.style.display = 'none';
                }
            }
        </script>
    </head>
    <body>
        <button><a href="insert">Thêm giáo viên</a></button>
        <button onclick="displayForm('searchform')">
            Tìm kiếm
        </button>
            <form action="list" method="POST" id="searchform" style="display: none;">
                <div>
                Tên: <input type="text" name = "sname">
                </div>
                <div>
                Lớp: <select name="sclassId">
                    <option value="-1">Tất cả</option>
                    <c:forEach items="${requestScope.classes}" var="c">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>
                </div>
                <div>
                Giới Tính:
                        <input type="radio" name="sgender" value = "none" checked>Tất cả
                        <input type="radio" name="sgender" value = "true">Nam
                        <input type="radio" name="sgender" value = "false">Nữ
                </div>
                <input type="submit" value="Tìm kiếm">
            </form>
    <c:if test="${requestScope.teachers.size() == 0}">
            <div>
                Không có giáo viên nào
            </div>  
        </c:if>
    <c:if test="${requestScope.teachers.size() > 0}">
            <table border="1px">
                <tr>
                    <td>ID</td>
                    <td>Tên</td>
                    <td>Lớp</td>
                    <td>Giới tính</td>
                    <td>Số điện thoại</td>
                    <td>Gmail</td>
                    <td></td>
                    <td></td>
                </tr>
                <c:forEach items="${requestScope.teachers}" var="t">
                <tr>
                    <td>${t.id}</td>
                    <td>${t.name}</td>
                    <td>${t.classes.name}</td>
                    <td>${t.sex?"Nam":"Nữ"}</td>
                    <td>${t.phoneNumber}</td>
                    <td>${t.gmail}</td>
                    <td>
                        <form action="update" method="GET">
                            <button type="submit" name="teacherId" value="${t.id}">
                                Sửa
                            </button>
                        </form>
                    </td>
                    <td>
                        <button type="button" onclick="deleteTeacher(${t.id})">
                            Xóa
                        </button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:if>
    </body>
</html>
