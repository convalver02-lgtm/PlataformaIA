<%-- 
    Document   : horarios
    Created on : 9/01/2026, 05:48:41 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Horarios - Plataforma IA</title>
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
                    <h1>Horarios de Atención</h1>
                    <div class="content">
                        <p>
                            La plataforma es **100% en línea** y está disponible **24 horas al día, 7 días a la semana** para que puedas estudiar cuando mejor te convenga.
                        </p>
                        <h3>Soporte técnico y consultas</h3>
                        <ul class="text-left">
                            <li>Lunes a viernes: 9:00 a 18:00 hrs (hora de México)</li>
                            <li>Sábados: 10:00 a 14:00 hrs</li>
                            <li>Domingos y días festivos: Sin soporte en tiempo real</li>
                        </ul>
                        <p>
                            Para cualquier duda o problema técnico, escríbenos a: 
                            <a href="mailto:aprendizajeia@udl.com">aprendizajeia@udl.com</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%@include file="includes/footer.jsp"%>
</body>
</html>