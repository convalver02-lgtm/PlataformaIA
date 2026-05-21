<%-- 
    Document   : index
    Created on : 8/11/2025, 01:40:51 PM
    Author     : 16003
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    boolean logueado = (rol != null);
    String panelUrl = "";
    if (logueado) {
        if ("ESTUDIANTE".equalsIgnoreCase(rol)) {
            panelUrl = "alumno/panelAlumno.jsp";
        } else if ("INSTRUCTOR".equalsIgnoreCase(rol)) {
            panelUrl = "instructor/panelInstructor.jsp";
        } else if ("ADMIN".equalsIgnoreCase(rol)) {
            panelUrl = "admin/panelAdmin.jsp";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Plataforma Educativa de Inteligencia Artificial</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Icono -->
    <link rel="icon" type="image/png" href="img/logoicono.png">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Plugins -->
    <link rel="stylesheet" href="css/nouislider.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <!-- Estilos propios -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/ventanas.css">
    <!-- CSS para footer abajo -->
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        .content {
            flex: 1;
        }
    </style>
</head>
<body>

<!-- ===================== HEADER ===================== -->
<header>
    <div id="header">
        <div class="container">
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-9">
                    <div class="header-logo">
                        <a href="index.jsp" class="logo">
                            <img src="img/logo.png" alt="Logo">
                        </a>
                    </div>
                </div>
                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <ul class="header-links pull-right">
                        <% if (logueado) { %>
                            <li><a href="#"><i class="fa fa-user"></i> Bienvenido, <%= nombreUsuario %></a></li>
                            <li><a href="<%= panelUrl %>"><i class="fa fa-dashboard"></i> Ir a mi panel</a></li>
                            <li><a href="cerrarSesion.jsp"><i class="fa fa-sign-out"></i> Cerrar Sesión</a></li>
                        <% } else { %>
                            <li><a href="login.jsp"><i class="fa fa-user-o"></i> Iniciar Sesión</a></li>
                            <li><a href="rGeneral.jsp"><i class="fa fa-check"></i> Registrarme</a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- ===================== /HEADER ===================== -->

<!-- ===================== NAV ===================== -->
<nav id="navigation">
    <div class="container">
        <div id="responsive-nav">
            <ul class="main-nav nav navbar-nav">
                <li class="active"><a href="index.jsp">Inicio</a></li>
                <li><a href="acercaDe.jsp">Acerca de</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- ===================== /NAV ===================== -->

<!-- ===================== BANNER CARRUSEL ===================== -->
<div class="container-fluid p-0">
    <div id="homeCarousel" class="carousel slide" data-ride="carousel">

        <!-- Slides -->
        <div class="carousel-inner">

            <div class="item active">
                <img src="img/banner1.png" class="img-responsive" alt="Banner 1">
            </div>

            <div class="item">
                <img src="img/banner2.png" class="img-responsive" alt="Banner 2">
            </div>

            <div class="item">
                <img src="img/banner3.png" class="img-responsive" alt="Banner 3">
            </div>

            <div class="item">
                <img src="img/banner4.png" class="img-responsive" alt="Banner 3">
            </div>
            
            <div class="item">
                <img src="img/banner5.png" class="img-responsive" alt="Banner 3">
            </div>
        </div>

        <!-- Controls -->
        
        
        <a class="left carousel-control" href="#homeCarousel" data-slide="prev">
        <i class="fa fa-angle-left"></i>
        </a>
        <a class="right carousel-control" href="#homeCarousel" data-slide="next">
        <i class="fa fa-angle-right"></i>
        </a>

    </div>
</div>
<!-- ===================== /BANNER CARRUSEL ===================== -->


<!-- ===================== CONTENIDO ===================== -->
<div class="content">
    <!-- Puedes dejar vacío o agregar texto si quieres -->
</div>
<!-- ===================== /CONTENIDO ===================== -->

<!-- ===================== FOOTER ===================== -->
<footer id="footer">
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="row align-items-center">
                    <div class="col-md-1 col-xs-12 text-end">
                        <img src="" width="100">
                    </div>
                    <div class="col-md-3 col-xs-6">
                        <h3 class="footer-title">Contacto</h3>
                        <ul class="footer-links">
                            <li><i class="fa fa-envelope-o"></i> aprendizajeia@udl.com</li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-xs-6">
                        <h3 class="footer-title">Acerca de</h3>
                        <ul class="footer-links">
                            <li><a href="nosotros.jsp">Nosotros</a></li>
                            <li><a href="horarios.jsp">Horarios</a></li>
                            <li>
                                <a href="avisoPrivacidad.jsp" target="_blank">
                                    Aviso de Privacidad
                                </a>
                            </li>
                        </ul>
                    </div>
                    <!-- Espaciador real -->
                    <div class="col-md-2 d-none d-md-block"></div>
                    <div class="col-md-3 col-xs-12 text-end">
                        <img src="img/logo1.png" width="100" alt="Logo">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="bottom-footer" class="section">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <span class="copyright">
                        &copy; <script>document.write(new Date().getFullYear());</script>
                        Todos los derechos reservados
                    </span>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- ===================== /FOOTER ===================== -->

<!-- JS (orden crítico) -->
<!--<script src="js/jquery.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!--<script src="js/bootstrap.min.js"></script> -->


<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<!-- Comenta estos si no los usas en index.jsp -->
<script src="js/slick.min.js"></script>
<script src="js/nouislider.min.js"></script>
<script src="js/jquery.zoom.min.js"></script>
<script src="js/main.js"></script>

</body>


</body>
</html>