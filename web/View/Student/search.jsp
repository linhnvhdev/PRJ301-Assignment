<%-- 
    Document   : search
    Created on : Mar 2, 2022, 10:15:14 AM
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
            function deleteStudent(id){
                var result = confirm("Are you sure?");
                if(result){
                    window.location.href = "delete?studentIdDel="+id;
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
        <button><a href="insert">Thêm học sinh</a></button>
        <button onclick="displayForm('searchform')">
            Tìm kiếm
        </button>
            <form action="search" method="POST" id="searchform" style="display: none;">
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
                        <input type="radio" name="sgender" value = "True">Nam
                        <input type="radio" name="sgender" value = "False">Nữ
                </div>
                <div>
                Số điện thoại: <input type="text" name="sphoneNumber"><br>
                </div>
                <div>
                Phòng: <select name="sroomId">
                    <option value="-1">Tất cả</option>
                    <option value="0">Chưa xếp</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                </select>
                </div>
                <input type="submit" value="Tìm kiếm">
            </form>
        <c:if test="${requestScope.students.size() == 0}">
            <div>
                Không có học sinh nào
            </div>  
        </c:if>
        <c:if test="${requestScope.students.size() > 0}">
            <table border="1px">
                <tr>
                    <td>ID</td>
                    <td>Tên</td>
                    <td>Lớp</td>
                    <td>Giới tính</td>
                    <td>Số điện thoại</td>
                    <td>Phòng</td>
                    <td></td>
                    <td></td>
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
                        <form action="update" method="GET">
                            <button type="submit" name="studentId" value="${s.id}">
                                Sửa
                            </button>
                        </form>
                    </td>
                    <td>
                        <button type="button" onclick="deleteStudent(${s.id})">
                            Xóa
                        </button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </c:if>
    </body>
</html>
