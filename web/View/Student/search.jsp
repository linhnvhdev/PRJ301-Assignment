<%-- 
    Document   : search
    Created on : Mar 2, 2022, 10:15:14 AM
    Author     : Linhnvhdev
--%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Học sinh</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script>
            function deleteStudent(id){
                var result = confirm("Are you sure?");
                if(result){
                    window.location.href = "delete?studentIdDel="+id;
                }
            }
            
            function displayForm(id){
                var form = document.getElementById(id);
                if(form.style.display === 'none'){
                    form.style.display = 'block';
                }
                else{
                    form.style.display = 'none';
                }
            }
            
            function resetForm(){
                let form = document.getElementById('searchform');
                form.elements['sname'].value="";
                form.elements['sclassId'].value="-1";
                form.elements['sgender'].value="none";
                form.elements['sroomId'].value="-1";
                document.getElementById('searchform').submit();
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
            <button onclick="displayForm('searchform')">
                Tìm kiếm
            </button>
                <form action="search" method="POST" id="searchform" style="display: none;" class="container-fluid">
                    <div class="form-group row mt-3">
                        <label class="col-sm-2 col-form-label" for="name">Tên:</label>
                        <div class="col-sm-8">
                            <input class="form-control col-10" id="name" type="text" name = "sname" 
                             value="${(requestScope.sname == null || requestScope.sname == 'none')?"":requestScope.sname}">
                        </div>
                    </div>
                    <div class="form-group row mt-3">
                        <label class="col-sm-2 col-form-label" for="class">Lớp:</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="class" name="sclassId">
                                <option value="-1"
                                        ${(requestScope.sclassId == null || requestScope.sclassId == -1)?"selected":""}>Tất cả</option>
                                <c:forEach items="${requestScope.classes}" var="c">
                                    <option value="${c.id}"
                                        ${(requestScope.sclassId != null && requestScope.sclassId == c.id)?"selected":""}>${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row mt-3">
                        <label class="col-sm-2 col-form-label" for="gender">Giới tính</label>
                        <div class="col-8">
                            <input type="radio" id="gender" name="sgender" value = "none" checked>Tất cả
                            <input type="radio" id="gender" name="sgender" value = "True"
                                   ${(requestScope.sgender != null && requestScope.sgender == 'True')?"checked":""}>Nam
                            <input type="radio" id="gender" name="sgender" value = "False"
                                   ${(requestScope.sgender != null && requestScope.sgender == 'False')?"checked":""}>Nữ
                        </div>
                    </div>
                    <div class="form-group row mt-3">
                        <label class="col-sm-2 col-form-label" for="room">Phòng</label>
                        <div class="col-8">
                            <select class="form-control" id="room" name="sroomId">
                                <option value="-1"
                                        ${(requestScope.sroomId == null || requestScope.sroomId == -1)?"selected":""}>Tất cả</option>
                                <option value="0"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 0)?"selected":""}>Chưa xếp</option>
                                <option value="1"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 1)?"selected":""}>1</option>
                                <option value="2"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 2)?"selected":""}>2</option>
                                <option value="3"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 3)?"selected":""}>3</option>
                                <option value="4"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 4)?"selected":""}>4</option>
                                <option value="5"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 5)?"selected":""}>5</option>
                                <option value="6"
                                        ${(requestScope.sroomId != null && requestScope.sroomId == 6)?"selected":""}>6</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-2"></div>
                        <div class="col-8 d-flex justify-content-end">
                            <input class="btn btn-primary" type="submit" value="Tìm kiếm">
                            <input class="btn btn-secondary" type="button" value="Bỏ tìm kiếm" onclick="resetForm()">
                        </div>
                    </div>
                </form>
            <c:if test="${requestScope.students.size() == 0}">
                <div>
                    Không có học sinh nào
                </div>  
            </c:if>
            <c:if test="${requestScope.students.size() > 0}">
                <table class="table table-striped border mt-3">
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Lớp</th>
                        <th>Giới tính</th>
                        <th>Số điện thoại</th>
                        <th>Phòng</th>
                        <th colspan="2" >Chức năng</th>
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
                            <form action="update" method="GET">
                                <button class="btn btn-primary" type="submit" name="studentId" value="${s.id}">
                                    Sửa
                                </button>
                            </form>
                        </td>
                        <td>
                            <button class="btn btn-danger" type="button" onclick="deleteStudent(${s.id})">
                                Xóa
                            </button>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
            </c:if>
            <button class="btn btn-success"><a class="btn-success" href="insert">Thêm học sinh</a></button>
        </div>        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>                
    </body>
</html>
