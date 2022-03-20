<%-- 
    Document   : profile
    Created on : Mar 8, 2022, 11:09:31 AM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ sơ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-----------------------------  Heading---------------------------- -->
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
        <div class="container-fluid mt-3 bg-light border">
            <c:set var="u" value="${sessionScope.account.user}"/>
            <div class="row border mt-3">
                <label for="Id" class="col-sm-2 border col-form-label">Id</label>
                <div class="col-sm-10">
                    <input type="text" readonly class="form-control-plaintext" id="Id" value="${u.id}">
                </div>
            </div>
            <div class="row border mt-3">
                <label for="Name" class="col-sm-2 border col-form-label">Tên</label>
                <div class="col-sm-10">
                    <input type="text" readonly class="form-control-plaintext" id="Name" value="${u.name}">
                </div>
            </div>
            <div class="row border mt-3">
                <label for="Gender" class="col-sm-2 border col-form-label">Giới tính</label>
                <div class="col-sm-10">
                    <input type="text" readonly class="form-control-plaintext" id="gender" value="${u.sex?"Nam":"Nữ"}">
                </div>
            </div>
            <!-- Giáo viên thêm thông tin lớp -->
            <c:if test="${u.role == 3}">
                <div class="row border mt-3">
                    <label for="class" class="col-sm-2 border col-form-label">Lớp</label>
                    <div class="col-sm-10">
                        <input type="text" readonly class="form-control-plaintext" id="class" value="${teacher.classes.name}">
                    </div>
                </div>
            </c:if>
            <!-- Học sinh thêm thông tin lớp và phòng -->
            <c:if test="${u.role == 4}">
                <div class="row border mt-3">
                    <label for="class" class="col-sm-2 border col-form-label">Lớp</label>
                    <div class="col-sm-10">
                        <input type="text" readonly class="form-control-plaintext" id="class" value="${student.classes.name}">
                    </div>
                </div>
                <div class="row border mt-3">
                    <label for="room" class="col-sm-2 border col-form-label">Phòng</label>
                    <div class="col-sm-10">
                        <input type="text" readonly class="form-control-plaintext" id="room" value="${student.roomId}">
                    </div>
                </div>    
            </c:if>    
            <div class="row border mt-3">
                <label for="phone" class="col-sm-2 border col-form-label">SĐT</label>
                <div class="col-sm-10">
                    <input type="text" readonly class="form-control-plaintext" id="phone" value="${u.phoneNumber}">
                </div>
            </div>
            <div class="row border mt-3">
                <label for="gmail" class="col-sm-2 border col-form-label">Gmail</label>
                <div class="col-sm-10">
                    <input type="text" readonly class="form-control-plaintext" id="gmail" value="${u.gmail}">
                </div>
            </div>
            <div class="mt-3"> 
                <a class="btn btn-primary" href="profile/update">Sửa thông tin</a>
                <c:if test="${u.role == 4}">
                    <a class="btn btn-warning" href="profile/attendance">Xem tình trạng điểm danh</a>
                </c:if>
            </div>
        </div>        
        <!-- javascript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
