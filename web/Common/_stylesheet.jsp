<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Fonts -->
<link rel="dns-prefetch" href="//fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito">

<!-- Themes template -->
<link rel="stylesheet" href="Resource/vendor/bootstrap/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,800">
<link rel="stylesheet" href="Resource/css/orionicons.css" type="text/css">
<link rel="stylesheet" href="Resource/css/style.violet.css" id="theme-stylesheet" type="text/css">

<!-- Custom stylesheet -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="Resource/css/custom.css">
<link href="https://cdn.rawgit.com/michalsnik/aos/2.1.1/dist/aos.css" rel="stylesheet">
<link rel="shortcut icon" href="Resource/img/favicon.png?3" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/dataTables.semanticui.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css"/>

<style>
    * {box-sizing: border-box;}

    body {
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
    }

    .topnav {
        overflow: hidden;
        background-color: #e9e9e9;
    }
    
    .errors {
                background-color:#FFCCCC;
                border:1px solid #CC0000;
                margin-bottom:8px;
            }
            
    .topnav a {
        float: left;
        display: block;
        color: black;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
    }

    .topnav a:hover {
        background-color: #ddd;
        color: black;
    }

    .topnav a.active {
        background-color: #2196F3;
        color: white;
    }

    .topnav .search-container {
        float: right;
    }

    .topnav input[type=text] {
        padding: 6px;
        margin-top: 8px;
        font-size: 17px;
        border: none;
    }

    .topnav .search-container button {
        float: right;
        padding: 6px 10px;
        margin-top: 8px;
        margin-right: 16px;
        background: #ddd;
        font-size: 17px;
        border: none;
        cursor: pointer;
    }

    .topnav .search-container button:hover {
        background: #ccc;
    }

    @media screen and (max-width: 600px) {
        .topnav .search-container {
            float: none;
        }
        .topnav a, .topnav input[type=text], .topnav .search-container button {
            float: none;
            display: block;
            text-align: left;
            width: 100%;
            margin: 0;
            padding: 14px;
        }
        .topnav input[type=text] {
            border: 1px solid #ccc;  
        }
    }
</style>
<style>
    .dataTables_scrollBody{
        max-height: 1000px !important;
        height: 1000px !important;
    }
    .myPopupForm{
        background: rgba(0,0,0,0.6);
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        display: none;
        justify-content: center;
        align-items: center;
    }
    .myPopupContent{
        height: 250px;
        width:500px;
        background: whitesmoke;
        padding: 20px;
        border-radius: 5px;
        position: relative;
    }
    .myPopupClose{
        position: absolute;
        top: -15px;
        right: -15px;
        background: white;
        height: 20px;
        width: 20px;
        border-radius: 50%;
        box-shadow: 6px 6px 29px -4px rgba(0,0,0,0.75);
        cursor: pointer;
    }
    html{
        scroll-behavior: smooth;
    }
</style>  