<%@page import="app.controllers.BlogController"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="robots" content="all,follow">
        <link rel="icon" href="Resource/img/favicon.png" type="image/ico"/>
        <title>Home</title>
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

                    <c:forEach begin="0" end="5" varStatus="i">
                        <section class="pb-5">
                            <div class="row">
                                <div class="col">
                                    <div class="card">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h2 class="text-primary mb-0">${BlogController.caseList.get(i.index).getCase_name()}</h2>
                                            <a href="${BlogController.caseList.get(i.index).getCase_description()}" target="_blank" class="btn btn-primary">
                                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
                                                <path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
                                                </svg>
                                                ${BlogController.caseList.get(i.index).getCreated_at()}
                                            </a>
                                        </div>
                                        <div class="card-body" style="padding:0px;">
                                            <iframe src="${BlogController.caseList.get(i.index).getCase_description()}" width="100%" height="600">
                                                <p>Your browser does not support iframes.</p>
                                            </iframe>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </c:forEach>
                </div>
            </div>

        </div>

        <jsp:include page="Common/_footer.jsp" />   
        <jsp:include page="Common/_scripts.jsp"/>
    </body>
</html>