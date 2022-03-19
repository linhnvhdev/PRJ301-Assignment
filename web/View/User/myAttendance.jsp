<%-- 
    Document   : myAttendance
    Created on : Mar 19, 2022, 4:27:44 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử điểm danh</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script>
            const daysOfWeek = ["Chủ nhật","Thứ 2","Thứ 3","Thứ 4","Thứ 5","Thứ 6","Thứ 7"];
            var today = new Date();
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
            
            function myGetDate(date){
                return date.getDate()+"/"+(date.getMonth()+1);
            }
        </script>
    </head>
    <body>
        <div class="container-fluid header pt-4" >
            <div class="row pl-9">
                <div class="col-9 "><h3>Hệ thống quản lí bán trú trường THCS Lê Quý Đôn</h3></div>
                <div class="col-3 d-flex justify-content-end login-link">Chào ${sessionScope.account.user.name}</div>
            </div>
        </div>
        <!-----------------------------  Nav bar---------------------------- -->
        <div class="container-fluid">
            <div class="row">
                <nav class="col-8 navbar navbar-expand-lg navbar-light bg-light pt-4 myNavbar">
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                          <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/student/search">Học sinh</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/teacher/list">Giáo viên</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/attendance">Điểm danh</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/order">Đóng tiền</a>
                        </li>                
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/report">Báo cáo</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/Register">Tạo tài khoản</a>
                        </li>
                      </ul>
                    </div>
                </nav>
                <nav class="col-4 navbar navbar-expand-lg navbar-light bg-light pt-4 myNavbar">
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/profile"><strong>Thông tin cá nhân</strong></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/profile/pwd">Đổi mật khẩu</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng xuất</a>
                        </li>             
                      </ul>
                    </div>
                </nav>        
            </div>        
        </div>
        <div class="container-fluid mt-3">
            <form action="attendance" method="GET" id="searchform" class="container-fluid">
                <div>
                    <label for="monthForm">Tháng:</label>
                    <select name="month" id="monthForm" onchange="this.form.submit()">
                        <c:forEach var="i" begin="1" end="12">
                            <option value="${i}" ${(month == i)?"selected=\"selected\"":""}>${i}</option>
                        </c:forEach>
                    </select>
                    <label class="ml-6" for="yearForm">Năm:</label>
                    <select class="mt-4" name="year" id="yearForm" onchange="this.form.submit()">
                        <c:forEach var="i" begin="${year-1}" end="${year}">
                            <option value="${i}" ${(year == i)?"selected=\"selected\"":""}>${i}</option>
                        </c:forEach>
                    </select>    
                </div>    
            </form>
            <table class="col-8 table table-bordered table-striped border mt-4">
                <tr class="text-center">
                    <th>Ngày</th>
                    <th>Tình trạng điểm danh</th>
                </tr>
                <script>
                    var days = getDaysInMonth(${month},${year});
                    <c:forEach var="i" begin="0" end="${requestScope.daysInMonth-1}">
                        if(days[${i}].getDay() > 0 && days[${i}].getDay() < 6){
                            document.write("<tr class=\"text-center\">\n");
                            if(days[${i}].getDate() === today.getDate() && days[${i}].getMonth() === today.getMonth()){
                                document.write("<td>"+myGetDate(days[${i}])+"(Hôm nay)</td>\n");
                                let a = ${requestScope.attendances.get(i)};
                                if(a === -1) document.write("<td class=\"bg-secondary border border-white\">"+"</td>\n");
                                if(a === 0)  document.write("<td class=\"bg-danger border border-white\">"+"</td>\n");
                                if(a === 1)  document.write("<td class=\"bg-success border border-white\">"+"</td>\n");
                            }
                            else
                                document.write("<td>"+myGetDate(days[${i}])+"</td>\n");
                                let a = ${requestScope.attendances.get(i)};
                                if(a === -1) document.write("<td class=\"bg-secondary border border-white\">"+"</td>\n");
                                if(a === 0)  document.write("<td class=\"bg-danger border border-white\">"+"</td>\n");
                                if(a === 1)  document.write("<td class=\"bg-success border border-white\">"+"</td>\n");
                            document.write("</tr>\n");
                        }
                    </c:forEach>
                </script>
                <tr class="text-center">
                    <td>Tổng</td>
                    <td>${requestScope.totalAttendance}</td>
                </tr>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
