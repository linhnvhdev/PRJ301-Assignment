<%-- 
    Document   : report
    Created on : Mar 10, 2022, 10:26:33 AM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            const daysOfWeek = ["Chủ nhật","Thứ 2","Thứ 3","Thứ 4","Thứ 5","Thứ 6","Thứ 7"];
            function getDaysInMonth(month, year) {
                let date = new Date(year, month-1, 1);
                let days = [];
                while (date.getMonth() === month-1) {
                  days.push(new Date(date));
                  date.setDate(date.getDate() + 1);
                }
                return days;
            }
            
            function getDaysOfWeek(date){    
                return daysOfWeek[date.getDay()];
            }
            
        </script>
    </head>
    <body>
        <form action="report" method="GET">
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
                <script>
                    var days = getDaysInMonth(${month},${year});
                    for(let i = 0;i < days.length;i++){
                        if(days[i].getDay() > 0 && days[i].getDay() < 6){
                            document.write("<td>"+getDaysOfWeek(days[i])+ " "+days[i]+"</td>\n");
                        }
                    }
                </script>
                </tr>
                <c:forEach items="${requestScope.students}" var="s">
                <tr>
                    <td>${s.id}</td>
                    <td>${s.name}</td>
                    <td>${s.classes.name}</td>
                <script>
                    <c:forEach var="i" begin="0" end="${requestScope.daysInMonth-1}">
                        if(days[${i}].getDay() > 0 && days[${i}].getDay() < 6){
                            let a = ${requestScope.attendances.get(s.id).get(i)};
                            if(a === -1) document.write("<td style=\"background-color: grey\""+a+"</td>");
                            if(a === 0)  document.write("<td style=\"background-color: red\""+a+"</td>");
                            if(a === 1)  document.write("<td style=\"background-color: green\""+a+"</td>");
                        }
                    </c:forEach>
                </script>                    
                </tr>
                </c:forEach>
            </table>
        </c:if>
    </body>
</html>
