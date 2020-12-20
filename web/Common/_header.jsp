<%@page import="app.models.User"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = new User("guest","guest","https://i.pinimg.com/originals/42/4c/33/424c33de1f2561239e58984676f473b3.png","Bạn đã tự động đăng nhập với tài khoản khách","Không có thông tin khi bạn đăng nhập với tài khoản khách","Tài Khoản Khách",2);
    String color = null;
    String nameRole = null;
    int isGuest=1;
    try {
        User temp = (User) session.getAttribute("user");
        if (temp!=null){
            user=temp;
            isGuest=0;
        }
        switch (user.getRole()) {
            case 0:
                color = "red";
                nameRole = "ADMIN";
                break;
            case 1:
                color = "orangered";
                nameRole = "MODERATORS";
                break;
            case 2:
                color = "blue";
                nameRole = "PRIMARY USER";
                break;
        }
    } catch (Exception e) {
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="cc" style="position:fixed;width: 100%;z-index: 10;">
<header class="header" >
    <nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow">
        <a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead">
            <i class="fas fa-align-left"></i>
        </a>
        <a href="index" class="navbar-brand font-weight-bold text-uppercase">
            Bảng điều khiển
        </a>
        <ul class="ml-auto d-flex align-items-center list-unstyled mb-0">
            <li class="nav-item dropdown ml-auto">
                <a id="userInfo" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle">
                    <img src="<%=user.getAvatar()%>"
                         alt="Profile picture" style="max-width: 2.5rem; min-height: 2.5rem;"
                         class="img-fluid rounded-circle shadow">
                </a>
                <div aria-labelledby="userInfo" class="dropdown-menu" style="font-family: arial;width: 200px;">
                    <a href="localProfile" class="dropdown-item">
                        <h4 class="d-block" style="font-family: arial;text-align: center;">
                            <%=user.getFull_name()%>
                        </h4>
                        <h6 style="text-align: center;color:<%=color%>"><%=nameRole%></h6>
                        <hr>
                        <h6 style="color:gray;text-align: center;"><b>Hồ sơ cá nhân</b></h6>
                    </a>
                    <div class="dropdown-divider"></div>
                        <a href="charts" class="dropdown-item">Settings</a>
                        <a href="charts" class="dropdown-item">Activity log</a>
                    <br><br>
                    <%
                        if (isGuest==0) out.println("<a href=\"userlogout\" class=\"dropdown-item\" style=\"background-color:orangered;color:white;text-align:center;\"><b>LogOut</b></a>"); else
                            out.println("<a href=\"login\" class=\"dropdown-item\" style=\"background-color:orange;color:white;text-align:center;\"><b>Log In</b></a>");
                    %>                     
                </div>
            </li>
        </ul>
    </nav>
</header>
</div>

