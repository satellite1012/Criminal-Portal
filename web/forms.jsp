<%@page import="app.models.User"%>
<%@page import="app.controllers.BlogController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    boolean isEditable = false;
    User s = (User) session.getAttribute("user");
    if (s != null && s.getRole() <= 1) {
        isEditable = true;
    }
    request.setAttribute("isEditable", isEditable);
%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Crime | Hot News</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="all,follow">
        <jsp:include page="Common/_stylesheet.jsp" />
    </head>

    <body>
        <jsp:include page="Common/_header.jsp" />
        <br><br>
        <div class="d-flex align-items-stretch">
            <jsp:include page="Common/_navbar.jsp" />

            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">

                    <jsp:include page="Common/_statusband.jsp" />
                    <c:if test="${log!=null}">
                            <div class="errors" style="font-size:22px;text-align: center;">
                                <p>${log}</p>
                            </div>
                    </c:if>
                    <section class="pb-5">
                        <div class="row justify-content-center">
                            <div class="col-md-11">
                                <div class="card">
                                    <c:if test="${isEditable}">
                                    <h2 class="card-header text-primary">Những Vụ Án Nổi Bật<button onclick="addFunction()" class="btn-blue" style="border-radius: 5px;float:right;padding: 5px 30px 10px 30px;font-size:20px;font-family: arial;"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4a.5.5 0 0 0-1 0v3.5H4a.5.5 0 0 0 0 1h3.5V12a.5.5 0 0 0 1 0V8.5H12a.5.5 0 0 0 0-1H8.5V4z"/>
                                            </svg></button></h2>
                                    <div class="card-body" style="padding:0px;padding-left: 15px;padding-top: 18px;">

                                        <table id="myTable" class="display">
                                            <thead>
                                                <tr>
                                                    <th>Thao tác</th>
                                                    <th>Id</th>
                                                    <th>Case Name</th>
                                                    <th>Date Start</th>
                                                    <th>Date End</th>
                                                    <th style="text-align: center;">Image</th>
                                                    <th>Create At</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="i" items="<%=BlogController.caseList%>">
                                                    <tr>
                                                        <td class="justify-content-center"> 
                                                            <a href="${i.case_description}" style="text-decoration: none;" target="_blank"><button  class="btn-success" style="border-radius: 5px;margin-bottom: 8px;padding: 5px 30px 10px 30px;font-size:20px;font-family: arial;"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
                                                                <path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
                                                                </svg></button></a><br>
                                                            <button onclick="editFunction(${i.id_case}, '${i.case_name}','${i.case_description}', '${i.date_start}', '${i.date_end}', '${i.image}')" class="btn-warning" style="border-radius: 5px;margin-bottom: 8px;padding: 5px 30px 10px 30px;font-size:20px;font-family: arial;"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pen" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                                <path fill-rule="evenodd" d="M5.707 13.707a1 1 0 0 1-.39.242l-3 1a1 1 0 0 1-1.266-1.265l1-3a1 1 0 0 1 .242-.391L10.086 2.5a2 2 0 0 1 2.828 0l.586.586a2 2 0 0 1 0 2.828l-7.793 7.793zM3 11l7.793-7.793a1 1 0 0 1 1.414 0l.586.586a1 1 0 0 1 0 1.414L5 13l-3 1 1-3z"/>
                                                                <path fill-rule="evenodd" d="M9.854 2.56a.5.5 0 0 0-.708 0L5.854 5.855a.5.5 0 0 1-.708-.708L8.44 1.854a1.5 1.5 0 0 1 2.122 0l.293.292a.5.5 0 0 1-.707.708l-.293-.293z"/>
                                                                <path d="M13.293 1.207a1 1 0 0 1 1.414 0l.03.03a1 1 0 0 1 .03 1.383L13.5 4 12 2.5l1.293-1.293z"/>
                                                                </svg></button><br>
                                                            <button onclick="deleteFunction(${i.id_case})" class="btn-danger" style="border-radius: 5px;margin-bottom: 8px;padding: 5px 30px 10px 30px;font-size:20px;font-family: arial;"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-octagon-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                                <path fill-rule="evenodd" d="M11.46.146A.5.5 0 0 0 11.107 0H4.893a.5.5 0 0 0-.353.146L.146 4.54A.5.5 0 0 0 0 4.893v6.214a.5.5 0 0 0 .146.353l4.394 4.394a.5.5 0 0 0 .353.146h6.214a.5.5 0 0 0 .353-.146l4.394-4.394a.5.5 0 0 0 .146-.353V4.893a.5.5 0 0 0-.146-.353L11.46.146zm.394 4.708a.5.5 0 0 0-.708-.708L8 7.293 4.854 4.146a.5.5 0 1 0-.708.708L7.293 8l-3.147 3.146a.5.5 0 0 0 .708.708L8 8.707l3.146 3.147a.5.5 0 0 0 .708-.708L8.707 8l3.147-3.146z"/>
                                                                </svg></button>
                                                        </td>
                                                        <td>${i.id_case}</td>
                                                        <td style="width: 150px;">${i.case_name}</td>
                                                        <td><input style="width:130px;" type="datetime-local" disabled value="${i.date_start}"></td>
                                                        <c:if test="${i.date_end!=null}">
                                                        <td><input style="width:130px;" type="datetime-local" disabled value="${i.date_end}"></td>
                                                        </c:if>
                                                        <c:if test="${i.date_end==null}">
                                                        <td><input style="color:red;width:130px;" disabled value="Chưa kết thúc"></td>
                                                        </c:if>
                                                        <td style="min-width:250px;min-height: 150px;"><img src="${i.image}" alt="" style="max-width:250px;max-height:150px;width:100%;height: 100%;"></td>
                                                        <td><input style="width:193px;" type="datetime-local" disabled value="${i.created_at}"></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    </c:if>
                                    
                                    <c:if test="${!isEditable}">
                                    <h2 class="card-header text-primary">Những Vụ Án Nổi Bật</h2>
                                    <div class="card-body" style="padding:0px;padding-left: 15px;padding-top: 18px;">

                                        <table id="myTable" class="display">
                                            <thead>
                                                <tr>
                                                    <th>Thao tác</th>
                                                    <th>Id</th>
                                                    <th>Case Name</th>
                                                    <th>Date Start</th>
                                                    <th>Date End</th>
                                                    <th style="text-align: center;">Image</th>
                                                    <th>Create At</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="i" items="<%=BlogController.caseList%>">
                                                    <tr>
                                                        <td class="justify-content-center"> 
                                                            <a href="${i.case_description}" style="text-decoration: none;" target="_blank"><button  class="btn-success" style="border-radius: 5px;margin-bottom: 8px;padding: 5px 30px 10px 30px;font-size:20px;font-family: arial;"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
                                                                <path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
                                                                </svg></button></a><br>                                                           
                                                        </td>
                                                        <td>${i.id_case}</td>
                                                        <td style="width: 150px;">${i.case_name}</td>
                                                        <td><input style="width:130px;" type="datetime-local" disabled value="${i.date_start}"></td>
                                                        <c:if test="${i.date_end!=null}">
                                                        <td><input style="width:130px;" type="datetime-local" disabled value="${i.date_end}"></td>
                                                        </c:if>
                                                        <c:if test="${i.date_end==null}">
                                                        <td><input style="color:red;width:130px;" disabled value="Chưa kết thúc"></td>
                                                        </c:if>
                                                        <td style="min-width:250px;min-height: 150px;"><img src="${i.image}" alt="" style="max-width:250px;max-height:150px;width:100%;height: 100%;"></td>
                                                        <td><input style="width:193px;" type="datetime-local" disabled value="${i.created_at}"></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>    
        
        <!--EDIT-->
        <script>
            function editFunction(i,case_name,case_description,date_start,date_end,image) {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Sửa thông tin vụ án: Id = </strong>'+i+'</font>',
                    icon: 'info',
                    html:
                            '<form id="editform" action="edit_case" method="post" style="font-size:22px;">' +
                            '<input type="hidden" name="caseId_edit" value="'+i+'">'+
                            'Nhập tên mới<br><input type="text" name="case_name" value="'+case_name+'"><br><hr>' +
                            'Nhập link bài báo mới<br><input type="text" name="case_description" value="'+case_description+'"><br><hr>' +
                            'Nhập ngày bắt đầu mới<br><input type="datetime-local" name="date_start" value="'+date_start+'"><br><hr>' +
                            'Nhập ngày kết thúc mới<br><input type="datetime-local" name="date_end" value="'+date_end+'"><br><hr>' +
                            'Nhập link ảnh mới<br><input type="text" name="image" value="'+image+'"><br><hr>' +
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
        </script> 

        <!--DELETE-->
        <form id="deleteform" method="post" action="delete_case">
            <input id="caseId_delete" type="hidden" name="caseId_delete" value="">
        </form>   
        <script>
            function deleteFunction(i) {
                Swal.fire({
                    title: 'Xóa vụ án?',
                    text: "Bạn có chắc muốn xóa vụ án này không",
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
                                'Danh sách vụ án sẽ được cập nhật sau vài giây...',
                                'success'
                                );
                        document.getElementById("deleteform").submit(); 
                    }
                });
            }
        </script> 
        
        <!--ADD-->
        <script>
            function addFunction() {
                Swal.fire({
                    title: '<font style="color:blue"><strong>Thêm mới vụ án</strong></font>',
                    icon: 'info',
                    html:
                            '<form id="addform" action="add_case" method="post" style="font-size:22px;">' +
                            'Nhập tên<br><input type="text" name="case_name"><br><hr>' +
                            'Nhập link bài báo<br><input type="text" name="case_description" ><br><hr>' +
                            'Nhập ngày bắt đầu<br><input type="datetime-local" name="date_start" ><br><hr>' +
                            'Nhập ngày kết thúc<br><input type="datetime-local" name="date_end" ><br><hr>' +
                            'Nhập link ảnh<br><input type="text" name="image"><br><hr>' +
                            '<input style="padding:0px 30px 0px 30px;font-size:30px;border-radius:5px;background-color:blue;color:white;" type="submit" value="THÊM"></form>',
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
        <jsp:include page="Common/_footer.jsp" />
        <jsp:include page="Common/_scripts.jsp" />

    </body>

</html>