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
        <title>Báo cáo</title>
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
            
            function submitForm(){
                let form = document.getElementById('searchform');
                form.elements['reportAttendance'].value="${requestScope.reportAttendance}";
                document.getElementById('searchform').submit();
            }
            
        </script>
    </head>
    <body>
        <div class="container-fluid header" >
            <div class="row pl-9">
                <div class="col-9 h3">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/imgs/SchoolLogo.png" alt="SchoolLogo" width="90" height="90" />
                    Hệ thống quản lí bán trú trường THCS Lê Quý Đôn
                </div>
                <div class="col-3 d-flex align-items-center justify-content-end login-link">Chào ${sessionScope.account.user.name}</div>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/report"><strong>Báo cáo</strong></a>
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
                          <a class="nav-link" href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a>
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
            <form action="report" method="GET" id="searchform" class="container-fluid">
                <div>
                    <label for="monthForm">Tháng:</label>
                    <select name="month" id="monthForm" onchange="submitForm()">
                        <c:forEach var="i" begin="1" end="12">
                            <option value="${i}" ${(month == i)?"selected=\"selected\"":""}>${i}</option>
                        </c:forEach>
                    </select>
                    <label class="ml-6" for="yearForm">Năm:</label>
                    <select class="mt-4" name="year" id="yearForm" onchange="submitForm()">
                        <c:forEach var="i" begin="${year-1}" end="${year}">
                            <option value="${i}" ${(year == i)?"selected=\"selected\"":""}>${i}</option>
                        </c:forEach>
                    </select>
                    <div>
                        <c:if test="${!requestScope.reportAttendance}">
                            <input type="hidden" name="reportAttendance" value="true">
                            <input class="btn btn-danger border border-dark mt-4" type="submit" value="Xem báo cáo điểm danh">
                        </c:if>
                        <c:if test="${requestScope.reportAttendance}">
                            <input type="hidden" name="reportAttendance" value="false">
                            <input class="btn btn-danger border border-dark mt-4" type="submit" value="Xem báo cáo tổng quát">
                        </c:if>
                    </div>    
                </div>    
            </form>
            <c:if test="${requestScope.students.size() == 0}">
                <div>
                    Không có học sinh nào
                </div>  
            </c:if>
            <c:if test="${requestScope.students.size() > 0}">
                <c:if test="${requestScope.reportAttendance}">
                    <table class="table table-bordered table-striped border mt-4">
                        <tr border>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Lớp</th>
                        <script>
                            var days = getDaysInMonth(${month},${year});
                            for(let i = 0;i < days.length;i++){
                                if(days[i].getDay() > 0 && days[i].getDay() < 6){
                                    if(days[i].getDate() === today.getDate() && days[i].getMonth() === today.getMonth()){
                                        document.write("<th>"+myGetDate(days[i])+"(Hôm nay)</th>\n");
                                    }
                                    else
                                        document.write("<th>"+myGetDate(days[i])+"</th>\n");
                                }
                            }
                        </script>
                            <th>Tổng</th>
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
                                        if(a === -1) document.write("<td class=\"bg-secondary border border-white\">"+"</td>");
                                        if(a === 0)  document.write("<td class=\"bg-danger border border-white\">"+"</td>");
                                        if(a === 1)  document.write("<td class=\"bg-success border border-white\">"+"</td>");
                                }
                            </c:forEach>
                        </script>
                        <td>${requestScope.totalAttendance.get(s.id)}</td>
                        </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="3">Tổng</td>
                            <script>
                                <c:forEach var="i" begin="0" end="${requestScope.daysInMonth-1}">
                                    if(days[${i}].getDay() > 0 && days[${i}].getDay() < 6){
                                            document.write("<td>"+${requestScope.totalPerDay[i]}+"</td>");
                                    }
                                </c:forEach>
                            </script>
                            <td>${requestScope.totalDayEaten}</td>
                        </tr>
                    </table>
                </c:if>
                <c:if test="${!requestScope.reportAttendance}">
                    <table class="table table-bordered table-striped border mt-4">
                        <tr border>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Lớp</th>
                            <th>Tổng số ngày ăn</th>
                            <th>Tiền đóng</th>
                            <th>Thừa/Thiếu</th>
                        </tr>
                        <c:forEach items="${requestScope.students}" var="s">
                        <tr>
                            <td>${s.id}</td>
                            <td>${s.name}</td>
                            <td>${s.classes.name}</td>
                            <td>${requestScope.totalAttendance.get(s.id)}</td>
                            <td>${requestScope.orders.get(s.id)?initParam.MoneyPerMonth:"Chưa đóng"}</td>
                            <td>${(requestScope.orders.get(s.id)?initParam.MoneyPerMonth:0)-requestScope.totalAttendance.get(s.id)*initParam.MoneyPerDay}</td>
                        </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="3">Tổng</td>
                            <td>${requestScope.totalDayEaten}</td>
                            <td>${requestScope.totalMoneyPay}</td>
                            <td>${requestScope.totalLeft}</td>
                        </tr>
                    </table>    
                </c:if>
            </c:if>
        </div>    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>                    
    </body>
</html>
