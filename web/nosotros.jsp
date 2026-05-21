<%-- 
    Document   : nosotros.jsp
    Created on : 9/01/2026, 05:46:00 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Nosotros - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .section {
            padding: 100px 0 60px;
        }
        h1 {
            color: #006299;
            font-weight: 700;
            margin-bottom: 40px;
        }
        .content {
            max-width: 1000px;
            margin: 0 auto;
            line-height: 1.9;
            font-size: 17px;
            text-align: justify;
        }
        footer {
            margin-top: 120px !important;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <div id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <div class="header-logo">
                            <a href="index.jsp" class="logo">
                                <img src="img/logo.png" alt="Logo">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-3 clearfix">
                        <ul class="header-links pull-right">
                            <li><a href="login.jsp"><i class="fa fa-user-o"></i> Iniciar Sesión</a></li>
                            <li><a href="rGeneral.jsp"><i class="fa fa-check"></i> Registrarme</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav id="navigation">
        <div class="container">
            <ul class="main-nav nav navbar-nav">
                <li><a href="index.jsp">Inicio</a></li>
                <li class="active"><a href="acercaDe.jsp">Acerca de</a></li>
            </ul>
        </div>
    </nav>

    <!-- Contenido centrado -->
    <section class="section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10 text-center">
                    <h1>Nosotros</h1>
                    <div class="content">
                        <p>
                            Somos una iniciativa educativa de la **Universidad de Londres Campus Vertiz** dedicada a democratizar el aprendizaje de Inteligencia Artificial.
                        </p>
                        <p>
                            Nuestro equipo de profesores, desarrolladores y estudiantes trabaja para ofrecer contenidos actualizados, tutoriales prácticos y recursos gratuitos que ayuden a estudiantes y profesionales a dominar esta tecnología transformadora.
                        </p>
                        <p>
                            La plataforma nació en 2025 como proyecto académico y de impacto social, con la visión de preparar a la nueva generación de talento mexicano en IA.
                        </p>
                        <h3>Nuestra misión</h3>
                        <p>Formar personas competentes en Inteligencia Artificial de manera accesible, inclusiva y de alta calidad.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%@include file="includes/footer.jsp"%>
</body>
</html>