<%-- 
    Document   : student
    Created on : Feb 27, 2022, 9:47:26 PM
    Author     : Linhnvhdev
--%>

<%@page import="Model.Classes"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <% 
            ArrayList<Student> students = (ArrayList<Student>) request.getAttribute("students");
            ArrayList<Classes> classes = (ArrayList<Classes>)request.getAttribute("classes");
        %>
        <script>
            function deleteStudent(id){
                var result = confirm("Are you sure?");
                if(result) document.getElementById("delStudent").submit();
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
        <button><a href="student/insert">Thêm học sinh</a></button>
        <button onclick="displayForm('searchform')">
            Tìm kiếm
        </button>
            <form action="search" method="GET" id="searchform" style="display: none;">
                <div>
                Tên: <input type="text" name = "sname">
                </div>
                <div>
                Lớp: <select name="sclassId">
                    <option value="-1">Tất cả</option>
                    <%for(Classes c : classes){%>
                    <option value="<%=c.getId()%>"><%=c.getName()%></option>
                    <%}%>
                </select>
                </div>
                <div>
                Giới Tính:
                        <input type="radio" name="sgender" value = "none" checked>Tất cả
                        <input type="radio" name="sgender" value = "true">Nam
                        <input type="radio" name="sgender" value = "false">Nữ
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
            <%for(Student s: students){%>
            <tr>
                <td><%=s.getId()%></td>
                <td><%=s.getName()%></td>
                <td><%=s.getClasses().getName()%></td>
                <td><%=(s.isSex())?"Nam":"Nữ"%></td>
                <td><%=s.getPhoneNumber()%></td>
                <td><%=(s.getRoomId()==0)?"Chưa có":s.getRoomId()%></td>
                <td>
                    <form action="student/update" method="GET">
                        <button type="submit" name="studentId" value="<%=s.getId()%>">
                            Sửa
                        </button>
                    </form>
                </td>
                <td>
                    <form action="student/delete" method="GET" id="delStudent">
                        <input type="hidden" name="studentId" value="<%=s.getId()%>">
                        <button type="button" onclick="deleteStudent()">
                            Xóa
                        </button>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
