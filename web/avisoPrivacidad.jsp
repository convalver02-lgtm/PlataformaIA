<%-- 
    Document   : avisoPrivacidad
    Created on : 9/01/2026, 05:49:55 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Aviso de Privacidad - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .section {
            padding: 100px 0 60px;  /* Más espacio arriba */
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
            margin-top: 120px !important;  /* Baja más el footer */
        }
    </style>
</head>
<body>

    <!-- Header -->
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
                    <h1>Aviso de Privacidad</h1>
                    <div class="content">
                        <p>
                            En cumplimiento con la **Ley Federal de Protección de Datos Personales en Posesión de los Particulares**, hacemos de su conocimiento que los datos personales recabados (nombre, correo electrónico y contraseña) serán utilizados exclusivamente para:
                        </p>
                        <ul class="text-left">
                            <li>Registro y acceso a la plataforma</li>
                            <li>Personalización de contenidos educativos</li>
                            <li>Mejora continua del servicio</li>
                            <li>Comunicación de actualizaciones o avisos importantes</li>
                        </ul>
                        <p>
                            No transferimos sus datos personales a terceros sin su consentimiento expreso, salvo las excepciones previstas por la ley.
                        </p>
                        <p>
                            Para mayor detalle, consulta el aviso completo en:
                            <a href="http://www.tecvalledechalco.edu.mx/Documentos/Legales/Aviso-de-Privacidad-Integral-Version-Final.pdf" target="_blank">
                                Aviso de Privacidad Integral (PDF)
                            </a>
                        </p>
                        <p>
                            Puedes ejercer tus derechos ARCO (Acceso, Rectificación, Cancelación y Oposición) enviando un correo a:
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