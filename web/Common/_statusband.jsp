<%@page import="app.controllers.UserController"%>
<%@page import="app.controllers.CulpritController"%>
<%@page import="app.controllers.BlogController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<section class="py-5">
    <div class="row">
        <div class="col-xl-3 col-lg-6 mb-4 mb-xl-0">
            <a href="tables" style="color:black;">
            <div class="bg-white shadow roundy p-4 h-100 d-flex align-items-center justify-content-between bg-hover-gradient-primary">
                <div class="flex-grow-1 d-flex align-items-center">
                    <div class="dot mr-3 bg-violet"></div>
                    <div class="text">
                        <h6 class="mb-0">Tổng số tội phạm</h6><span class="text-gray"><%=CulpritController.culpritList.size()%></span>
                    </div>
                </div>
                <div class="icon text-white bg-violet"><i class="fas fa-user"></i></div>
            </div>
            </a>
        </div>
        <div class="col-xl-3 col-lg-6 mb-4 mb-xl-0">
            <a href="forms" style="color:black;">
            <div class="bg-white shadow roundy p-4 h-100 d-flex align-items-center justify-content-between bg-hover-gradient-primary">
                <div class="flex-grow-1 d-flex align-items-center">
                    <div class="dot mr-3 bg-green"></div>
                    <div class="text">
                        <h6 class="mb-0">Tổng số vụ án</h6><span class="text-gray"><%=BlogController.caseList.size()%></span>
                    </div>
                </div>
                <div class="icon text-white bg-green"><i class="fas fa-user-friends"></i></div>
            </div>
            </a>
        </div>
        <div class="col-xl-3 col-lg-6 mb-4 mb-xl-0">
            <a href="user" style="color:black;">
            <div class="bg-white shadow roundy p-4 h-100 d-flex align-items-center justify-content-between bg-hover-gradient-primary">
                <div class="flex-grow-1 d-flex align-items-center">
                    <div class="dot mr-3 bg-blue"></div>
                    <div class="text">
                        <h6 class="mb-0">Số lượng người dùng</h6><span class="text-gray"><%=UserController.userList.size()%></span>
                    </div>
                </div>
                <div class="icon text-white bg-blue"><i class="fa fa-dolly-flatbed"></i></div>
            </div>
            </a>
        </div>
        <div class="col-xl-3 col-lg-6 mb-4 mb-xl-0">
            <a href="index" style="color:black;">
            <div class="bg-white shadow roundy p-4 h-100 d-flex align-items-center justify-content-between bg-hover-gradient-primary">
                <div class="flex-grow-1 d-flex align-items-center">
                    <div class="dot mr-3 bg-red"></div>
                    <div class="text">
                        <h6 class="mb-0">Ngày</h6><span class="text-gray"><%=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime())%></span>
                    </div>
                </div>
                <div class="icon text-white bg-red"><i class="fas fa-receipt"></i></div>
            </div>
            </a>
        </div>
    </div>
</section>