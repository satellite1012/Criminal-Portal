<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Login</title>
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="888567468389-5h2gfmlvp5blgria6dnauldlbniloaio.apps.googleusercontent.com">
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="all,follow">
        <link rel="stylesheet" href="Resource/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,800">
        <link rel="stylesheet" href="css/orionicons.css">
        <link rel="stylesheet" href="Resource/css/style.default.css" id="theme-stylesheet">
        <link rel="stylesheet" href="Resource/css/custom.css">
        <link rel="stylesheet" href="Resource/css/clock.scss">
        <link rel="shortcut icon" href="Resource/img/favicon.png?3">
        <style>
            .errors {
                background-color: #FFCCCC;
                border: 1px solid #CC0000;
                margin-bottom: 8px;
            }
        </style>
    </head>
    <body>
        <video src="Resource/img/dog.mp4" style="min-width: 100%;min-height: 100%;position:fixed" autoplay muted loop></video>
        <br><br>
        <div class="page-holder d-flex align-items-center">
            <div class="container-fluid">
                 
                <div class="row align-items-center py-0">

                    <div class="col-5 col-lg-6 mx-auto mb-5 mb-lg-0 align-content-center">
                        <br><br><br><br><br>
                        <div id="clock" style="background-color: rgba(0,0,0,0.6);padding:15px 120px 15px 120px;border-radius:10px;border:10px;margin-left: 367px">
                            <p class="date" style="font-size:27px">{{ date }}</p>
                            <p class="time"  style="font-size:55px">{{ time }}</p>
                            <p class="text" style="padding:0px 20px;font-size:16px;color:orange;text-shadow: 0 0 20px orange,  0 0 20px rgba(10, 175, 230, 0);">Criminal Portal by POLICE TEAM</p>
                        </div>
                        <br><br><br><br><br><br>
                        <div class="elfsight-app-291aaa72-d4ae-4987-a10f-c338d8740ecc" style="border-radius:10px;top:0px;height: 80%"></div>
                    </div>

                    <div class="col-lg-5 px-lg-4" style="float:right;background-color: rgba(0,0,0,0.6);padding: 20px;padding-bottom: 88px;border:5px;border-radius: 8px;margin-right: 50px;">
                        <h1 class="text-base text-primary text-uppercase mb-4" style="font-size:35px;">LOGIN PORTAL</h1>
                        <br><br>
                        <h2 class="mb-4" style="color:white;font-size:40px;">Welcome back!</h2>
                        <p style="color:yellow;">In order to use all the features, please login!</p>
                        <c:if test="${log!=null}">
                            <div class="errors">
                                <p>${log}</p>
                            </div>
                        </c:if>
                        <form id="loginForm" action="userlogin" class="mt-4" method="post">
                            <div class="form-group mb-4">
                                <input type="text" name="user" placeholder="Username or Email address" class="form-control border-0 shadow form-control-lg">
                            </div>
                            <div class="form-group mb-4">
                                <input type="password" name="pass" placeholder="Password" class="form-control border-0 shadow form-control-lg text-violet">
                            </div>
                            <div class="form-group mb-4">
                                <div class="custom-control custom-checkbox">
                                    <input id="customCheck1" type="checkbox" checked class="custom-control-input">
                                    <label for="customCheck1" class="custom-control-label" style="color:white;">Remember Me</label>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary shadow px-5" style="display: inline-block;">Log in</button> 
                        </form>
                        <form id="gmailLoginForm" action="userlogingmail" method="post">
                            <input id="name" type="hidden" name="gmail_name" value="">
                            <input id="user" type="hidden" name="gmail_user" value="">
                            <input id="avatar" type="hidden" name="gmail_avatar" value="">
                            <input id="token" type="hidden" name="gmail_token" value="">
                        </form>
                        <script>
                            //Sign out
                            var auth2 = gapi.auth2.getAuthInstance();
                            auth2.signOut();
                        </script>
                        <div id="googlebutton" style="display: inline-block;margin-top:20px"><div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div></div>

                        <script>
                            function onSignIn(googleUser) {
                                //Sign out
                                var auth2 = gapi.auth2.getAuthInstance();
                                auth2.signOut();
                                // Get data
                                var profile = googleUser.getBasicProfile();
                                document.getElementById("name").value = profile.getName();
                                document.getElementById("user").value = profile.getEmail();
                                document.getElementById("avatar").value = profile.getImageUrl();
                                document.getElementById("token").value = googleUser.getAuthResponse().id_token;
                                // Submit to validate
                                if (profile !== null)
                                    document.getElementById("gmailLoginForm").submit();
                            }
                        </script>
                        <p class="mt-5 mb-0 text-gray-400 text-center" style="position: absolute;float:right">Design by <a href="https://www.facebook.com/satfomacej/" class="external" style="color:orange;">Five Police Team</a></p>
                    </div>
   
                </div>
              
            </div>
        </div>
        <!-- JavaScript files-->
        <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
        <script>
            var clock = new Vue({
                el: '#clock',
                data: {
                    time: '',
                    date: ''
                }
            });

            var week = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
            var timerID = setInterval(updateTime, 1000);
            updateTime();
            function updateTime() {
                var cd = new Date();
                clock.time = zeroPadding(cd.getHours(), 2) + ':' + zeroPadding(cd.getMinutes(), 2) + ':' + zeroPadding(cd.getSeconds(), 2);
                clock.date = zeroPadding(cd.getFullYear(), 4) + '-' + zeroPadding(cd.getMonth()+1, 2) + '-' + zeroPadding(cd.getDate(), 2) + ' ' + week[cd.getDay()];
            };

            function zeroPadding(num, digit) {
                var zero = '';
                for(var i = 0; i < digit; i++) {
                    zero += '0';
                }
                return (zero + num).slice(-digit);
            }
        </script>
        <script src="Resource/vendor/jquery/jquery.min.js"></script>
        <script src="Resource/vendor/popper.js/umd/popper.min.js"></script>
        <script src="Resource/vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="Resource/vendor/jquery.cookie/jquery.cookie.js"></script>
        <script src="Resource/vendor/chart.js/Chart.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script src="Resource/js/front.js"></script>
        <script src="https://apps.elfsight.com/p/platform.js" defer></script>
    </body>
</html>