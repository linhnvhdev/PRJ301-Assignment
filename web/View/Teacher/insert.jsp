<%-- 
    Document   : insert
    Created on : Mar 3, 2022, 10:41:41 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm giáo viên</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
                          <a class="nav-link" href="${pageContext.request.contextPath}/teacher/list"><strong>Giáo viên</strong></a>
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
        <div class="container-fluid mt-5 bg-light">          
            <form class="border" action="insert" method="POST">
                <div class="form-group row mt-3">
                    <label class="col-2 col-form-label" for="name">Tên:</label>
                    <div class="col-3">
                        <input class="form-control" id="name" type="text" name="name" required>
                    </div>
                </div>
                 <div class="form-group row mt-3">
                    <label class="col-sm-2 col-form-label" for="class">Lớp:</label>
                    <div class="col-sm-3">
                        <select class="form-control" id="class" name="classId">
                            <c:forEach items="${requestScope.classes}" var="c">
                                <option value="${c.id}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row mt-3">
                        <label class="col-sm-2 col-form-label" for="gender">Giới tính</label>
                        <div class="col-3">
                            <input type="radio" name="gender" value = "true">Nam
                            <input type="radio" name="gender" value = "false">Nữ
                        </div>
                </div>
                <div class="form-group row mt-3">
                    <label class="col-sm-2 col-form-label" for="phoneNumber">Số điện thoại</label>
                    <div class="col-3">
                        <input class="form-control" id="phoneNumber" type="text" name="phoneNumber"><br>
                    </div>
                </div>
                <div class="form-group row mt-3">
                    <label class="col-sm-2 col-form-label" for="gmail">Gmail</label>
                    <div class="col-3">
                        <input class="form-control" id="gmail" type="email" name="gmail"><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2">
                        </div>
                    <div class="col-8">
                        <input class="btn btn-success" type="submit" value="Thêm">
                    </div>
                </div>
            </form>
        </div>      
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
