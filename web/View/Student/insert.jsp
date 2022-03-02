<%-- 
    Document   : insert
    Created on : Feb 9, 2022, 3:33:23 PM
    Author     : Linhnvhdev
--%>

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
        %>
    </head>
    <body>
        <form action="insert" method="POST">
            <div>
            Tên: <input type="text" name = "name">
            </div>
            <div>
            Lớp: <select name="classId">
                <%for(Classes c : classes){%>
                <option value="<%=c.getId()%>"><%=c.getName()%></option>
                <%}%>
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
            Phòng: <select name="roomId">
                <option value="0">Chưa xếp</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
            </div>
            <input type="submit" value="Thêm">
        </form>
    </body>
</html>
