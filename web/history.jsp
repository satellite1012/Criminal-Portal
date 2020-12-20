<%@page import="app.models.User"%>
<%@page import="app.controllers.HistoryController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User s = (User) session.getAttribute("user");
    if (s == null || s.getRole() > 1) {
        response.sendRedirect("index");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>History</title>
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

                    <jsp:include page="Common/_statusband.jsp"/>
                    <c:if test="${log!=null}">
                        <div class="errors" style="font-size:22px;text-align: center;">
                            <p>${log}</p>
                        </div>
                    </c:if>
                    <section class="pb-5">
                        <div class="row justify-content-center">
                            <div class="col-md-11">
                                <div class="card">
                                    <h2 class="card-header text-primary">Lịch Sử Chỉnh Sửa<button onclick="deleteAllFunction()" class="btn-danger" style="border-radius: 5px;float:right;padding: 5px 30px 5px 30px;font-size:20px;font-family: arial;">XÓA TOÀN BỘ LỊCH SỬ<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-exclamation-diamond-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M9.05.435c-.58-.58-1.52-.58-2.1 0L.436 6.95c-.58.58-.58 1.519 0 2.098l6.516 6.516c.58.58 1.519.58 2.098 0l6.516-6.516c.58-.58.58-1.519 0-2.098L9.05.435zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                                  </svg></button></h2>
                                    <div class="card-body" style="padding:0px;padding-left: 15px;padding-top: 18px;">

                                        <table id="myTable" class="display" >
                                            <thead>
                                                <tr>
                                                    <th>Thao tác</th>
                                                    <th>Id</th>
                                                    <th>Người thực hiện</th>
                                                    <th>Id user đã thay đổi</th>
                                                    <th>Id vụ án đã thay đổi</th>
                                                    <th>Id tội phạm đã thay đổi</th>
                                                    <th>Thay đổi tội phạm tham gia vụ án</th>
                                                    <th>Hành động đã thực hiện</th>
                                                    <th>Vào lúc</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="i" items="<%=HistoryController.historyList%>">
                                                    <tr>
                                                        <td><button class="btn-danger" onclick="deleteFunction(${i.getId_history()})" style="padding:8px;"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                                                            <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708-.708l7-7a.5.5 0 0 1 .708 0z"/>
                                                            <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 0 0 0 .708l7 7a.5.5 0 0 0 .708-.708l-7-7a.5.5 0 0 0-.708 0z"/>
                                                            </svg></button>
                                                        </td>
                                                        <td>${i.id_history}</td>
                                                        <td>${i.id_user}</td>
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_user())!=0}">    
                                                            <td><font style="color:red;"><b>${Integer.toString(i.getEdited_at_id_user())}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_user())==0}">    
                                                            <td></td>
                                                        </c:if>
                                                            
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_case())!=0}">    
                                                            <td><font style="color:red;"><b>${Integer.toString(i.getEdited_at_id_case())}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_case())==0}">    
                                                            <td></td>
                                                        </c:if>
                                                            
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_culprit())!=0}">    
                                                            <td><font style="color:red;"><b>${Integer.toString(i.getEdited_at_id_culprit())}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_culprit())==0}">    
                                                            <td></td>
                                                        </c:if>
                                                            
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_case_culprit())!=0}">    
                                                            <td><font style="color:red;"><b>${Integer.toString(i.getEdited_at_id_case_culprit())}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${Integer.toString(i.getEdited_at_id_case_culprit())==0}">    
                                                            <td></td>
                                                        </c:if>
                                                            
                                                        <c:if test="${i.getAction()=='Update'}">
                                                        <td><font style="color:orange;font-size: 22px;"><b>${i.getAction()}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${i.getAction()=='Delete'}">
                                                        <td><font style="color:red;font-size: 22px;"><b>${i.getAction()}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${i.getAction()=='Insert'}">
                                                        <td><font style="color:blue;font-size: 22px;"><b>${i.getAction()}</b></font></td>
                                                        </c:if>
                                                        <c:if test="${i.getAction()!='Update'&&i.getAction()!='Delete'&&i.getAction()!='Insert'}">
                                                        <td><font style="color:black;font-size: 22px;"><b>${i.getAction()}</b></font></td>
                                                        </c:if>
                                                        
                                                        <td>${i.getModified_at()}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                </div>
            </div>
        </div>
                    
        <!--DELETE ALL-->
        <script>
            function deleteAllFunction() {
                Swal.fire({
                    title: '<font style="color:orangered;"><strong>Xóa toàn bộ lịch sử</strong></font>',
                    icon: 'warning',
                    html:
                            '<form id="deleteform1" action="delete_all_history" method="post" style="font-size:22px;">' +
                            '<input type="password" name="passForDelete" placeholder="Nhập mật khẩu cấp 2"><br><hr>' +
                            '<input  style="padding:0px 30px 0px 30px;font-size:30px;border-radius:5px;background-color:orangered;color:white;" type="submit" value="XÓA TẤT CẢ"></form>',
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
        <form id="deleteform2" method="post" action="delete_history">
            <input type="hidden" value="" id="historyId_delete" name="historyId_delete">
        </form>   
        <script>
            function deleteFunction(i) {
                Swal.fire({
                    title: 'Xóa lịch sửa: id = '+i,
                    text: "Bạn có chắc muốn xóa lịch sửa này không",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Xóa ngay',
                    cancelButtonText: 'Hủy bỏ'
                }).then((result) => {
                    if (result.value) {   
                        document.getElementById("historyId_delete").value=i;
                        Swal.fire(
                                'Đang xử lý',
                                'Danh sách lịch sử sẽ được cập nhật sau vài giây...',
                                'success'
                                );
                        document.getElementById("deleteform2").submit(); 
                    }
                });
            }
        </script> 
        <jsp:include page="Common/_footer.jsp" />
        <jsp:include page="Common/_scripts.jsp"/>
    </body>
</html>