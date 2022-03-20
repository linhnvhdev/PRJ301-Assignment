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
        <title>Đóng tiền</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script>
            function submitForm(){
                let form = document.getElementById('searchform');
                form.elements['search'].value="${requestScope.search}";
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/order"><strong>Đóng tiền</strong></a>
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
            <form action="order" id="searchform" method="GET" class="container-fluid">
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
                </div>
                <c:if test="${!requestScope.search}">
                    <input type="hidden" name="search" value="true">
                    <input class="btn btn-danger border border-dark mt-4" type="submit" value="Xem học sinh chưa đóng tiền">
                </c:if>
                <c:if test="${requestScope.search}">
                    <input type="hidden" name="search" value="false">
                    <input class="btn btn-danger border border-dark mt-4" type="submit" value="Xem tất cả">
                </c:if>
            </form>
            <c:if test="${requestScope.students.size() == 0}">
                <div class="mt-4">
                    Không có học sinh nào
                </div>  
            </c:if>
            <c:if test="${requestScope.students.size() > 0}">
                <form class="mt-4" action="order" method="POST">
                    <input type="hidden" name="month" value="${month}">
                    <input type="hidden" name="year" value="${year}">
                    <table class="table table-striped border">
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Lớp</th>
                            <th>Số điện thoại</th>
                            <th>Phòng</th>
                            <th>Đóng tiền tháng</th>
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
                    <input class="btn btn-primary" type="submit" value="Cập nhập">
                </form>
            </c:if>
        </div>    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>                    
    </body>
</html>
