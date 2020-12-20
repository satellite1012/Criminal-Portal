<%@page import="app.controllers.BlogController"%>
<%@page import="app.models.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="app.controllers.CulpritController"%>
<%@page import="app.models.Culprit"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    Culprit temp = CulpritController.culpritSelected;
    if (temp == null) {
        response.sendRedirect("tables");
    }
    //GET ROLE
    int role = 2;
    if (user != null) {
        role = user.getRole();
    }
    request.setAttribute("role", role);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="robots" content="all,follow">
        <link rel="icon" href="Resource/img/favicon.png" type="image/ico"/>

        <title>Culprit Profile</title>

        <jsp:include page="Common/_stylesheet.jsp"/>
    </head>
    <body>

        <jsp:include page="Common/_header.jsp" />
        <br><br>
        <div class="d-flex align-items-stretch">

            <jsp:include page="Common/_navbar.jsp" />   

            <!-- Content Wrapper -->
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">

                    <jsp:include page="Common/_statusband.jsp"/>

                    <section class="pb-5">
                        <div class="row">
                            <div class="col-md-6 ">
                                <a href="#case_section" class="message card px-5 py-3 bg-hover-gradient-primary no-anchor-style">
                                    <div class="row">
                                        <img src="${CulpritController.culpritSelected.getImage()}" alt=""
                                             style="width: 100%;height: 100%; max-width: 60px; max-height:60px;"
                                             class="rounded-circle mx-3">

                                        <div class="ml-2">
                                            <div class="row d-flex align-items-center ">
                                                <div class="text-light smaller roundy px-3 py-1 mr-1 exclode bg-gray-500">TỘI PHẠM</div>
                                                <strong class="h5 mb-0 py-1 text-gray-500 ">${CulpritController.culpritSelected.getBirth()}<sup class="small text-gray font-weight-normal">năm sinh</sup></strong>
                                            </div>
                                            <div class="row">
                                                <h4 class="mb-0 text-primary">${CulpritController.culpritSelected.getName()}</h4>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </section>  
                    <c:if test="${log!=null}">
                            <div class="errors" style="font-size:15px;">
                                <p>${log}</p>
                            </div>
                    </c:if>                        
                    <section class="pb-5">
                        <div class="row">
                            <div class="col-md-8 mb-4 mb-lg-0">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h2 class="text-primary mb-0">Thông tin tội phạm</h2>
                                        <div class="row">
                                            <c:if test="${role<=1}">
                                                <button onclick="editFunction1(${CulpritController.culpritSelected.id_culprit}, '${CulpritController.culpritSelected.identity_card}', '${CulpritController.culpritSelected.name}', '${CulpritController.culpritSelected.birth}', '${CulpritController.culpritSelected.create_at}')" class="btn btn-primary">
                                                    <i class="far fa-edit"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="card-body"><table class="table card-text table-hover">
                                            <tbody>
                                                <tr>
                                                    <th scope="row" style="width:30%;">ID Tội phạm</th>
                                                    <td>${CulpritController.culpritSelected.id_culprit}</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Họ và tên</th>
                                                    <td>${CulpritController.culpritSelected.name}</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">CMND</th>
                                                    <td>${CulpritController.culpritSelected.identity_card}</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Ngày sinh</th>
                                                    <td>${CulpritController.culpritSelected.birth}</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Ngày quyết định truy nã</th>
                                                    <td><input style="width:193px;" type="datetime-local" disabled value="${CulpritController.culpritSelected.create_at}"></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Vụ án tham gia 
                                                        <c:if test="${role<=1}">
                                                            <button onclick="addCaseFunction(${CulpritController.culpritSelected.id_culprit})" class="btn-success" style="border-radius: 3px;float:right;margin: 5px;">THÊM</button>
                                                        </c:if>
                                                    </th>
                                                    <td>
                                                        <c:forEach var="i" items="${CulpritController.culpritCaseList}">
                                                            <a style="color:red;" target="_blank" href="${i.case_description}">[ID = ${i.id_case}]${i.case_name}</a>
                                                            <br>
                                                            <c:if test="${role<=1}">
                                                                <button onclick="deleteCaseFunction(${i.id_case})" class="btn-danger" style="float:right;margin:5px;border-radius: 3px;">XÓA</button><br>
                                                            </c:if>
                                                            <hr>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 md-4 mb-lg-0 pl-lg-0">
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h2 class="text-primary mb-0">Nhận dạng</h2>
                                        <div class="row">
                                            <c:if test="${role<=1}">
                                                <button onclick="editFunction2(${CulpritController.culpritSelected.id_culprit}, '${CulpritController.culpritSelected.image}')" class="btn btn-primary">
                                                    <i class="far fa-edit"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <img src="${CulpritController.culpritSelected.image}" alt=""
                                                 style="width:100%;height: 100%;max-width: 390px;max-height: 390px;"
                                                 class="rounded-circle mx-3">
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </section>

                    <section id="case_section" class="pb-5">
                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <div class="card">
                                    <h2 class="card-header text-primary">Vụ án liên quan</h2>
                                    <c:forEach var="i" items="${CulpritController.culpritCaseList}">
                                        <div class="card-body">
                                            <h3 class="text-red mb-0">${i.getCase_name()}</h3>
                                            <h3 style="color:orange;font-size: 15px;">Tạo vào: ${i.created_at}
                                                <a href="${i.case_description}" target="_blank" class="btn btn-warning" style="float:right;margin-bottom: 5px;">
                                                    <svg style="font-size: 22px;" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.134 13.134 0 0 0 1.66 2.043C4.12 11.332 5.88 12.5 8 12.5c2.12 0 3.879-1.168 5.168-2.457A13.134 13.134 0 0 0 14.828 8a13.133 13.133 0 0 0-1.66-2.043C11.879 4.668 10.119 3.5 8 3.5c-2.12 0-3.879 1.168-5.168 2.457A13.133 13.133 0 0 0 1.172 8z"/>
                                                    <path fill-rule="evenodd" d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                                                    </svg>
                                                </a>
                                            </h3>
                                            <iframe src="${i.case_description}" width="100%" height="300">
                                                <p>Your browser does not support iframes.</p>
                                            </iframe>
                                        </div>
                                        <hr>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <!--EDIT TRÁI-->
        <script>
            function editFunction1(i, identity_card, name, birth, create_at) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Sửa thông tin tội phạm: Id = </strong>' + i + '</font>',
                    icon: 'info',
                    html:
                            '<form id="editform1" action="edit_culprit_more" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="culpritId_edit_more" value="' + i + '">' +
                            'Nhập CMND mới<br><input type="text" name="identity_card" value="' + identity_card + '"><br><hr>' +
                            'Nhập tên mới<br><input type="text" name="name" value="' + name + '"><br><hr>' +
                            'Nhập năm sinh mới<br><input type="text" name="birth" value="' + birth + '"><br><hr>' +
                            'Nhập ngày truy nã mới<br><input type="text" name="create_at" value="' + create_at + '"><br><hr>' +
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

        <!--EDIT PHẢI-->
        <script>
            function editFunction2(i, image) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Sửa ảnh tội phạm: Id = </strong>' + i + '</font>',
                    icon: 'info',
                    html:
                            '<form id="editform2" action="edit_culprit_image" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="culpritId_edit_image" value="' + i + '">' +
                            'Nhập link ảnh mới<br><input type="text" name="image" value="' + image + '"><br><hr>' +
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

        <!--EDIT VỤ ÁN-->
        <script>
            function addCaseFunction(i) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Thêm vụ án cho tội phạm: Id = </strong>' + i + '</font>',
                    icon: 'info',
                    html:
                            '<form id="editform3" action="add_culprit_case" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="culpritId_add_case" value="' + i + '">' +
                            '<select name="id_case" id="editCaseSelected" style="width:200px;">'+
                            '</select><br><br>'+
                            '<input style="padding:0px 30px 0px 30px;font-size:30px;border-radius:5px;background-color:green;color:white;" type="submit" value="THÊM"></form>',
                    showCloseButton: true,
                    showCancelButton: true,
                    showConfirmButton: false,
                    focusConfirm: false,
                    cancelButtonText:
                            'Hủy bỏ',
                    cancelButtonAriaLabel: 'Thumbs down'
                });
                
                var x=document.getElementById("editCaseSelected");
                var option;
                <c:forEach var="i" items="<%=BlogController.caseList%>">
                option = document.createElement("option");
                option.value = '${i.id_case}';
                option.text = '${i.case_name}';
                x.add(option);
                </c:forEach>
            }
        </script>

        <!--DELETE VỤ ÁN-->
        <form id="deleteform" method="post" action="delete_culprit_case">
            <input id="caseId_delete" type="hidden" name="caseId_delete" value="">
        </form>   
        <script>
            function deleteCaseFunction(i) {
                Swal.fire({
                    title: 'Xóa vụ án liên quan',
                    text: "Bạn có chắc muốn xóa sự liên quan tới vụ án này không?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Xóa ngay',
                    cancelButtonText: 'Hủy bỏ'
                }).then((result) => {
                    if (result.value) {
                        document.getElementById("caseId_delete").value = i;
                        Swal.fire(
                                'Đang xử lý',
                                'Hồ sơ tội phạm sẽ được cập nhật sau vài giây...',
                                'success'
                                );
                        document.getElementById("deleteform").submit();
                    }
                });
            }
        </script> 
        
        <jsp:include page="Common/_footer.jsp" />
        <jsp:include page="Common/_scripts.jsp"/>
    </body>
</html>