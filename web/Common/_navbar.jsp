<%@page import="app.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = null;
    try {
        user = (User) session.getAttribute("user");
        if (user==null) throw new Exception("Not Login Yet");
    } catch (Exception e) {

    }
%>
<div id="sidebar" class="sidebar py-3" >
    <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family"><font style="color:green;">MAIN</font></div>
    <ul class="sidebar-menu list-unstyled">
        <li class="sidebar-list-item"><a id="nav1" href="index" class="sidebar-link text-muted"><i class="o-home-1 mr-3 text-gray" style="width:22px;height: 22px;"></i><span>Home</span></a></li>
        <li class="sidebar-list-item"><a id="nav2" href="localProfile" class="sidebar-link text-muted"><i class="o-sales-up-1 mr-3 text-gray" style="width:22px;height: 22px;"></i><span>Profile</span></a></li>
        <li class="sidebar-list-item"><a id="nav3" href="tables" class="sidebar-link text-muted"><i class="o-table-content-1 mr-3 text-gray" style="width:22px;height: 22px;"></i><span>Crime Tables</span></a></li>
        <li class="sidebar-list-item"><a id="nav4" href="forms" class="sidebar-link text-muted"><i class="o-survey-1 mr-3 text-gray" style="width:22px;height: 22px;"></i><span>Hot News</span></a></li>
        <%
            if (user!=null&&user.getRole()<=1)
                out.println("<li class=\"sidebar-list-item\"><a id=\"nav5\" href=\"history\" class=\"sidebar-link text-muted\"><i class=\"o-paperwork-1 mr-3 text-gray\" style=\"width:22px;height: 22px;\"></i><span>History</span></a></li>");
            if (user!=null&&user.getRole()<=0)
                out.println("<li class=\"sidebar-list-item\"><a id=\"nav6\" href=\"user\" class=\"sidebar-link text-muted\"><i class=\"o-database-1 mr-3 text-gray\" style=\"width:22px;height: 22px;\"></i><span>Account List</span></a></li>"); 
        %>
        <script>
        var s = document.title;
        if (s === "Account Management") {
            document.getElementById('nav2').classList.add('active');
        }
        else if (s === "Crime | Hot News") {
            document.getElementById('nav4').classList.add('active');
        }
        else if (s === "Home") {
            document.getElementById('nav1').classList.add('active');
        }
        else if (s === "History") {
            document.getElementById('nav5').classList.add('active');
        }
        else if (s === "Crime | Table") {
            document.getElementById('nav3').classList.add('active');
        }
        else if (s === "Users Management") {
            document.getElementById('nav6').classList.add('active');
        }
        </script>       
        <li class="sidebar-list-item" style="background-color: rgba(252, 186, 3,0.7);"><a id="nav5" href="login" class="sidebar-link text-muted"><i class="o-exit-1 mr-3 text-gray" style="width:22px;height: 22px;color:white;"></i><span style="color:white;">Login</span></a></li>
    </ul>
        <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family"><font style="color:orangered;">CREATORS</font></div>
    <ul class="sidebar-menu list-unstyled">
        <li class="sidebar-list-item"><a target="_blank" href="https://www.facebook.com/satfomacej" class="sidebar-link text-muted"><img src="https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.0-9/87840332_1088728771476001_4513091706958118912_n.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=pcB0NOOez8wAX96IzEP&_nc_ht=scontent.fsgn2-1.fna&oh=f5add095b66085d878fdeeeab8b1a96e&oe=5F2A2D00" style="width:25px;height: 25px;margin-right: 12px;"><span>Tín</span></a></li>
        <li class="sidebar-list-item"><a target="_blank" href="https://www.facebook.com/voxvanhieu" class="sidebar-link text-muted"><img src="https://scontent.fsgn2-4.fna.fbcdn.net/v/t31.0-8/19025291_948335358641712_860676922420202969_o.jpg?_nc_cat=109&_nc_sid=a4a2d7&_nc_ohc=roxiPsJg1yYAX-KR5E3&_nc_ht=scontent.fsgn2-4.fna&oh=baab51d9223bf2651fb9e9416d2d9d59&oe=5F287256" style="width:25px;height: 25px;margin-right: 12px;"><span>Hiếu</span></a></li>
        <li class="sidebar-list-item"><a target="_blank" href="https://www.facebook.com/SeiSilver" class="sidebar-link text-muted"><img src="https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.0-9/87364787_1415759678602383_2143203416736792576_o.jpg?_nc_cat=107&_nc_sid=09cbfe&_nc_ohc=yrbbSZdJRm8AX9iKHyB&_nc_ht=scontent.fsgn2-1.fna&oh=67391b762f342a944f5a23e9e96440af&oe=5F296BB1" style="width:25px;height: 25px;margin-right: 12px;"><span>Đạt</span></a></li>
        <li class="sidebar-list-item"><a target="_blank" href="https://www.facebook.com/huymu.phuc" class="sidebar-link text-muted"><img src="https://scontent.fsgn2-1.fna.fbcdn.net/v/t31.0-8/19243068_635035666698592_7491125879475688431_o.jpg?_nc_cat=107&_nc_sid=09cbfe&_nc_ohc=TVhCvj3NtXQAX8YOdQ-&_nc_ht=scontent.fsgn2-1.fna&oh=a3274c70802e6b8c690ac588e4203194&oe=5F29C92E" style="width:25px;height: 25px;margin-right: 12px;"><span>Huy</span></a></li>
        <li class="sidebar-list-item"><a target="_blank" href="https://www.facebook.com/profile.php?id=100009186848301" class="sidebar-link text-muted"><img src="https://scontent.fsgn2-5.fna.fbcdn.net/v/t1.0-9/84728124_2470100726639465_7412986048201883648_n.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=ysIXvZyLCvAAX-WMSHb&_nc_ht=scontent.fsgn2-5.fna&oh=34bd59e6dd1e8b9a80b64eed3e5483e2&oe=5F2960F3" style="width:25px;height: 25px;margin-right: 12px;"><span>Khoa</span></a></li>
    </ul>
</div>

