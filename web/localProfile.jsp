<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="app.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = new User("guest","guest","https://i.pinimg.com/originals/42/4c/33/424c33de1f2561239e58984676f473b3.png","Bạn đã tự động đăng nhập với tài khoản khách","Không có thông tin khi bạn đăng nhập với tài khoản khách","Tài Khoản Khách",2);
    String color = null;
    String nameRole = null;
    boolean isGuest=true;
    try {
        //FOR PROFILE
        User temp = (User) session.getAttribute("user");
        if (temp!=null){
            isGuest=false;
            user=temp;
        } else throw new Exception("Not login");
        switch (user.getRole()) {
            case 0:
                color = "red";
                nameRole = "ADMIN";
                break;
            case 1:
                color = "orangered";
                nameRole = "MODERATOR";
                break;
            case 2:
                color = "blue";
                nameRole = "PRIMARY USER";
                break;
        }
    } catch (Exception e) {
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Account Management</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <jsp:include page="Common/_stylesheet.jsp"/>    
  </head>
  <body>
        <jsp:include page="Common/_header.jsp" />
        <br><br>
        <div class="d-flex align-items-stretch">
            <jsp:include page="Common/_navbar.jsp" />   
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">
                    <br><br>
                    <c:if test="${log!=null}">
                            <div class="errors" style="font-size:22px;text-align: center;">
                                <p>${log}</p>
                            </div>
                    </c:if>
                    <section>
                        <div class="row">                          
                            <!-- Inline Form-->
                            <div class="col-lg-8 mb-5">                           
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="h6 mb-0" style="font-size: 40px;text-align: center;">HỒ SƠ NGƯỜI DÙNG</h3>
                                    </div>
                                    <div class="card-body">
                                        <c:if test="<%=!isGuest%>">
                                        <button onclick="editFunction1(<%=user.getId_user()%>,'<%=user.getProfile_title()%>')" class="btn btn-primary" style="float:right;">
                                            <i class="far fa-edit"></i>
                                        </button><br></c:if>
                                        <h4 style="font-family:arial;color:red;font-size:35px;font-weight: normal;"><%=user.getProfile_title()%></h4>                                     
                                        <hr>
                                        <c:if test="<%=!isGuest%>">
                                        <button onclick="editFunction2(<%=user.getId_user()%>,`<%=user.getProfile_description()%>`)" class="btn btn-primary" style="float:right;">
                                            <i class="far fa-edit"></i>
                                        </button><br></c:if>
                                        <h4 style="font-family:arial;color:rgba(0,0,0,0.8);font-size:18px;font-weight: normal;"><%=user.getProfile_description()%>
                                        </h4>
                                    </div>
                                </div>
                            </div>
                            <!-- Modal Form-->
                            <div class="col-lg-4 mb-5">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="h6 mb-0" style="font-size:26px;text-align: center;">Thông tin cơ bản
                                        <c:if test="<%=!isGuest%>">
                                        <button onclick="editFunction3(<%=user.getId_user()%>,'<%=user.getFull_name()%>','<%=user.getUsername()%>','<%=user.getPassword()%>','<%=user.getAvatar()%>')" class="btn btn-primary" style="float:right;">
                                            <i class="far fa-edit"></i>
                                        </button><br></c:if>
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <img style="max-height: 100%;max-width: 100%;width: 300px;height: 300px;border-style: solid;" src="<%=user.getAvatar()%>">
                                        <br><br>
                                        <p style="font-family:arial;font-size: 20px;"><b>Họ và tên: <%=user.getFull_name()%></b></p>
                                        <hr>
                                        <p style="font-family:arial;font-size: 17px;">Tên người dùng: <i><%=user.getUsername()%></i></p>
                                        <p style="font-family:arial;font-size: 17px;">Mật khẩu: <i id="showhidepass"><%=user.getPassword()%></i> <img id="showhideimg" style="width:30px;height: 30px;margin-left: 20px;" src="https://cdn4.iconfinder.com/data/icons/adjusting-the-interface/256/Ui_glyphs_invisible-512.png" onclick="myFunction()"></p>
                                        <hr>
                                        <p style="font-family:arial;font-size: 17px;color:<%=color%>"><b>Quyền hạn: <%=nameRole%></b></p>
                                        <br>
                                        <p style="font-family:arial;font-size: 17px;color:gray;">Ngày tạo tài khoản <br><input style="font-size:25px;width:305px;" type="datetime-local" disabled value="<%=user.getCreated_at()%>"></p>
                                     
                                    </div>
                                </div>
                            </div>                  
                        </div>
                    </section>
                </div>
            </div>
        </div>
                
        <!--EDIT-->
        <script>
            function editFunction1(i,string) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Sửa thông tin chi tiết</strong></font>',
                    icon: 'info',
                    html:
                            '<form id="editform1" action="edit_user_title" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="userId_edit" value="'+i+'">'+
                            'Nhập tiêu đề cho trang cá nhân<br><br><textarea type="text" name="profile_title" style="width:300px;height:350px;">'+string+'</textarea><br><hr>' +
                            '<input  style="padding:0px 30px 0px 30px;font-size:30px;border-radius:5px;background-color:orangered;color:white;" type="submit" value="SỬA"></form>',
                    showCloseButton: true,
                    showCancelButton: true,
                    showConfirmButton: false,
                    focusConfirm: false,
                    cancelButtonText:
                              'Hủy bỏ',
                    cancelButtonAriaLabel: 'Thumbs down'
                });
            }
            function editFunction2(i,string) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Sửa thông tin chi tiết</strong></font>',
                    icon: 'info',
                    html:
                            '<form id="editform2" action="edit_user_description" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="userId_edit" value="'+i+'">'+
                            'Nhập tiêu đề cho trang cá nhân<br><br><textarea type="text" name="profile_description" style="width:300px;height:350px;">'+string+'</textarea><br><hr>' +
                            '<input  style="padding:0px 30px 0px 30px;font-size:30px;border-radius:5px;background-color:orangered;color:white;" type="submit" value="SỬA"></form>',
                    showCloseButton: true,
                    showCancelButton: true,
                    showConfirmButton: false,
                    focusConfirm: false,
                    cancelButtonText:
                              'Hủy bỏ',
                    cancelButtonAriaLabel: 'Thumbs down'
                });
            }
            function editFunction3(i,fullname,username,pass,image) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Sửa thông tin chi tiết</strong></font>',
                    icon: 'info',
                    html:
                            '<form id="editform3" action="edit_user_more" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="userId_edit" value="'+i+'">'+
                            'Nhập tên mới<br><input type="text" name="full_name" value="'+fullname+'"><br><hr>' +
                            'Nhập password mới<br><input type="text" name="password" value="'+pass+'"><br><hr>' +
                            'Nhập link ảnh mới<br><input type="text" name="avatar" value="'+image+'"><br><hr>' +    
                            '<input style="padding:0px 30px 0px 30px;font-size:30px;border-radius:5px;background-color:orangered;color:white;" type="submit" value="SỬA"></form>',
                    showCloseButton: true,
                    showCancelButton: true,
                    showConfirmButton: false,
                    focusConfirm: false,
                    cancelButtonText:
                              'Hủy bỏ',
                    cancelButtonAriaLabel: 'Thumbs down'
                });
            }
        </script>   
        
        <script>
        var temp=document.getElementById("showhidepass").innerHTML;
        document.getElementById("showhidepass").innerHTML="******";
        function myFunction() {
          var x = document.getElementById("showhidepass");
          if (x.innerHTML !== "******") {
            x.innerHTML = "******";
            document.getElementById("showhideimg").src="https://cdn4.iconfinder.com/data/icons/adjusting-the-interface/256/Ui_glyphs_invisible-512.png";
          } else {
            x.innerHTML=temp;
            document.getElementById("showhideimg").src="https://cdn1.iconfinder.com/data/icons/disable-sign/300/Blind-eye-dark-512.png";
          }
        }
        </script>        
        <jsp:include page="Common/_footer.jsp" />   
        <jsp:include page="Common/_scripts.jsp"/>
  </body>
</html>