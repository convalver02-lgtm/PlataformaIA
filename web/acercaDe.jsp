<%-- 
    Document   : acercaDe
    Created on : 9/01/2026, 05:43:11 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Acerca de - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .about-section {
            padding: 80px 0;
            background: #f8f9fa;
        }
        .about-header {
            text-align: center;
            margin-bottom: 50px;
        }
        .about-header h1 {
            color: #006299;
            font-weight: 700;
        }
        .about-content {
            max-width: 900px;
            margin: 0 auto;
            line-height: 1.8;
            font-size: 17px;
        }
        .about-content img {
            max-width: 100%;
            border-radius: 12px;
            margin: 30px 0;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
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

    <!-- Contenido -->
    <section class="about-section">
        <div class="container">
            <div class="about-header">
                <h1>Acerca de Nosotros</h1>
                <p>La Plataforma Educativa de Inteligencia Artificial</p>
            </div>

            <div class="about-content">
                <p>
                    Somos una iniciativa educativa dedicada a democratizar el conocimiento sobre Inteligencia Artificial. 
                    Nuestra misión es ofrecer tutoriales accesibles, actualizados y de calidad para estudiantes, profesionales y entusiastas de la IA.
                </p>

                <p>
                    Fundada en 2025 en el Tecnológico de Estudios Superiores del Valle de Chalco, esta plataforma nace con el objetivo de preparar a la nueva generación de líderes tecnológicos en México y el mundo.
                </p>

                <!-- Puedes agregar una imagen aquí -->
                <!-- <img src="img/equipo.jpg" alt="Nuestro equipo"> -->

                <h3>Nuestros valores</h3>
                <ul>
                    <li>Accesibilidad: Contenido gratuito y abierto para todos</li>
                    <li>Actualización constante: Tutoriales al día con las últimas tendencias en IA</li>
                    <li>Calidad educativa: Explicaciones claras y prácticas</li>
                    <li>Inclusión: Diseñado para principiantes y avanzados</li>
                </ul>

                <h3>Contacto</h3>
                <p>Correo: <a href="mailto:aprendizajeia@udl.com">aprendizajeia@udl.com</a></p>
            </div>
        </div>
    </section>

    <%@include file="includes/footer.jsp"%>

</body>
</html>