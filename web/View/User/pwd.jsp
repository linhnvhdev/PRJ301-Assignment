<%-- 
    Document   : pwd
    Created on : Mar 8, 2022, 9:25:19 PM
    Author     : Linhnvhdev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đổi mật khẩu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet" type="text/css"/>
        <c:set var="u" value="${sessionScope.account.user}"/>
        <script>
            function validateForm(){
                let password = document.forms["changepwd"]["password"].value;
                let passwordNew = document.forms["changepwd"]["passwordNew"].value;
                let retypePasswordNew = document.forms["changepwd"]["retypePasswordNew"].value;
                if(password != ${sessionScope.account.password}){
                    alert("Mật khẩu nhập sai, không thể đổi");
                    return false;
                }
                if(passwordNew != retypePasswordNew){
                    alert("mật khẩu mới nhập lại sai");
                    return false;
                }
                alert("Đổi mật khẩu thành công");
                return true;
            }
        </script>
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
                          <a class="nav-link" href="${pageContext.request.contextPath}/profile/pwd"><strong>Đổi mật khẩu</strong></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng xuất</a>
                        </li>             
                      </ul>
                    </div>
                </nav>        
            </div>        
        </div>
        <div class="container-fluid bg-light mt-3">              
            <form name="changepwd" action="pwd" method="POST" onsubmit="return validateForm()">
                <div class="form-group row mt-3">
                    <label for="password" class="col-sm-2 border col-form-label">Nhập mật khẩu</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="password" id="password" name="password" required="true">
                    </div>
                </div>
                <div class="form-group row mt-3">
                    <label for="passwordNew" class="col-sm-2 border col-form-label">Mật khẩu mới:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="password" id="passwordNew" name="passwordNew" required="true">
                    </div>
                </div>
                <div class="form-group row mt-3">
                    <label for="retypePasswordNew" class="col-sm-2 border col-form-label">Nhập lại mật khẩu mới:</label>
                    <div class="col-sm-4">
                        <input class="form-control" type="password" id="retypePasswordNew" name="retypePasswordNew" required="true">
                    </div>
                </div>              
                <div class="row mt-3">
                    <div class="col-2"></div>
                    <div class="col-6"><input class="btn btn-primary" type="submit" value="Đổi mật khẩu"></div>
                </div>
            </form>
        </div>      
        <!-- javascript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
