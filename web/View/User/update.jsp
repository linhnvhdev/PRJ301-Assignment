<%-- 
    Document   : update
    Created on : Mar 8, 2022, 12:02:47 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sửa thông tin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet" type="text/css"/>
        <c:set var="u" value="${sessionScope.account.user}"/>
    </head>
    <body>
        <!-----------------------------  Heading---------------------------- -->
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
        <div class="container-fluid mt-3 bg-light border">             
            <form action="update" method="POST">
                <input type="hidden" name="userId" value="${u.id}">
                <div class="form-group row border mt-3">
                    <label for="Id" class="col-sm-2 border col-form-label">Id</label>
                    <div class="col-sm-6">
                        <input type="text" readonly class="form-control-plaintext" id="Id" value="${u.id}">
                    </div>
                </div>
                <div class="form-group row border mt-3">
                    <label for="Name" class="col-sm-2 border col-form-label">Tên</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="name" id="Name" value="${u.name}">
                    </div>
                </div>
                <div class="form-group row border mt-3 mt-3">
                    <label class="col-sm-2 border col-form-label" for="gender">Giới tính</label>
                    <div class="col-6">
                        <input id="gender" type="radio"
                            ${(u.sex)?"checked":""}
                            name="gender" value = "true">Nam
                        <input id="gender" type="radio" 
                            ${(!u.sex)?"checked":""}
                            name="gender" value = "false">Nữ
                    </div>
                </div>
                <div class="form-group border row mt-3">
                    <label for="phone" class="col-sm-2 border col-form-label">SĐT</label>
                    <div class="col-sm-6">
                        <input type="text" name="phoneNumber" class="form-control" id="phone" value="${u.phoneNumber}">
                    </div>
                </div>
                <div class="form-group row border mt-3">
                    <label for="gmail" class="col-sm-2 border col-form-label">Gmail</label>
                    <div class="col-sm-6">
                        <input type="text" name="gmail" class="form-control" id="gmail" value="${u.gmail}">
                    </div>
                </div>
                <input class="btn btn-primary mt-3" type="submit" value="Sửa thông tin">
            </form>
        </div>       
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>    
    </body>
</html>
