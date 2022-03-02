<%-- 
    Document   : update
    Created on : Feb 28, 2022, 11:25:39 PM
    Author     : Linhnvhdev
--%>

<%@page import="Model.Student"%>
<%@page import="Model.Classes"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            ArrayList<Classes> classes = (ArrayList<Classes>)request.getAttribute("classes");
            Student student = (Student) request.getAttribute("student");
        %>
    </head>
    <body>
        <form action="update" method="POST">
            <input type="hidden" name="studentId" value="<%=student.getId()%>"
            <div>
                Tên: <input type="text" name = "name" value="<%=student.getName()%>">
            </div>
            <div>
            Lớp: <select name="classId">
                <%for(Classes c : classes){%>
                <option
                    <%=(student.getClasses().getId() == c.getId())?"selected=\"selected\"":""%>
                    value="<%=c.getId()%>"><%=c.getName()%></option>
                <%}%>
            </select>
            </div>
            <div>
                Giới Tính: <input type="radio"
                            <%=(student.isSex())?"checked":""%> 
                            name="gender" value = "true">Male
                    <input type="radio" 
                            <%=(!student.isSex())?"checked":""%>
                            name="gender" value = "false">Female
            </div>
            <div>
            Số điện thoại: <input type="text" name="phoneNumber" value="<%=student.getPhoneNumber()%>"><br>
            </div>
            <div>
            Phòng: <select name="roomId">
                <option 
                    <%=(student.getRoomId() == 0)?"selected=\"selected\"":""%>
                    value="0">Chưa xếp</option>
                <%for(int i = 1;i <= 6;i++){%>
                <option 
                    <%=(student.getRoomId() == i)?"selected=\"selected\"":""%>
                    value="<%=i%>"><%=i%></option>
                <%}%>
            </select>
            </div>
            <input type="submit" value="Sửa">
        </form>
    </body>
</html>

