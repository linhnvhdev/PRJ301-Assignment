<%-- 
    Document   : attendance
    Created on : Mar 8, 2022, 10:35:48 PM
    Author     : Linhnvhdev
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Điểm danh</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/attendance"><strong>Điểm danh</strong></a>
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
            <form action="attendance" method="GET">
                Ngày: <input type="date" name="date" value="${requestScope.Date}" onchange="this.form.submit()">
            </form>
            <form class="mt-3" action="attendance" method="POST">
                <input type="hidden" name="date" value="${requestScope.Date}">
                <table class="table table-striped border">
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Lớp</th>
                        <th>Giới tính</th>
                        <th>Số điện thoại</th>
                        <th>Phòng</th>
                        <th>Điểm danh</th>
                        <th>Vắng</th>
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
                                <input type="radio" name="${"attendance"}${s.id}" value = "True"
                                       ${(requestScope.attendances.get(s.id))?"checked=\"true\"":""}>
                            </td>
                            <td>
                                <input type="radio" name="${"attendance"}${s.id}" value = "False" 
                                       ${(!requestScope.attendances.get(s.id))?"checked=\"true\"":""}>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <input class="btn btn-success" type="submit" value="Điểm danh">
            </form>
        </div>    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>                    
    </body>
</html>
