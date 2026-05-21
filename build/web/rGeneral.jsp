<%-- 
    Document   : rGeneral
    Created on : 8/01/2026, 02:38:56 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    // Si ya está logueado, redirigir al panel correspondiente
    String rol = (String) session.getAttribute("rol");
    if (rol != null) {
        if ("ESTUDIANTE".equalsIgnoreCase(rol)) {
            response.sendRedirect("alumno/panelAlumno.jsp");
        } else if ("INSTRUCTOR".equalsIgnoreCase(rol)) {
            response.sendRedirect("instructor/panelInstructor.jsp");
        } else if ("ADMIN".equalsIgnoreCase(rol)) {
            response.sendRedirect("admin/panelAdmin.jsp");
        }
        return;
    }

    String error = request.getParameter("error");
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Registrarme - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(to bottom right, #f8f9fa, #e9ecef);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1;
        }
        .register-container {
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            max-width: 500px;
            margin: 60px auto;
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-header img {
            height: 80px;
            margin-bottom: 20px;
        }
        .register-header h2 {
            color: #006299;
            font-weight: 700;
        }
        .register-header p {
            color: #666;
        }
        .btn-register {
            background-color: #006299;
            color: white;
            padding: 14px 50px;
            font-size: 18px;
            border-radius: 40px;
            width: 100%;
        }
        .btn-register:hover {
            opacity: 0.9;
            color: white;
        }
    </style>
</head>
<body>

    <!-- Header público -->
    <header>
        <div id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <a href="index.jsp">
                            <img src="img/logo.png" alt="Logo">
                        </a>
                    </div>
                    <div class="col-md-3 text-right">
                        <ul class="header-links">
                            <li><a href="login.jsp"><i class="fa fa-user"></i> Iniciar Sesión</a></li>
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
                <li><a href="acercaDe.jsp">Acerca de</a></li>
            </ul>
        </div>
    </nav>

    <!-- Mensajes -->
    <% if (error != null || msg != null) { %>
        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <% if ("contrasenas".equals(error)) { %>
                        <div class="alert alert-danger">Las contraseñas no coinciden.</div>
                    <% } else if ("existe".equals(error)) { %>
                        <div class="alert alert-warning">Este correo ya está registrado.</div>
                    <% } else if ("general".equals(error)) { %>
                        <div class="alert alert-danger">Error al registrar. Intenta de nuevo.</div>
                    <% } else if ("registrado".equals(msg)) { %>
                        <div class="alert alert-success">¡Registro exitoso! Ya puedes iniciar sesión.</div>
                    <% } %>
                </div>
            </div>
        </div>
    <% } %>

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="register-container">

                        <div class="register-header">
                            <img src="img/logo.png" alt="Logo">
                            <h2>Crear mi cuenta</h2>
                            <p>Únete como ESTUDIANTE a la Plataforma Educativa de Inteligencia Artificial</p>
                        </div>

                        <!-- MENSAJE PARA REGISTRO DE INSTRUCTORES -->
                        <div class="alert alert-info text-center" style="border-radius: 12px;">
                            <strong>Registro de instructores</strong><br>
                            Si deseas registrarte como <strong>instructor</strong>, solicita tu registro enviando tu
                            <strong>nombre, correo y teléfono</strong> al correo
                            <a href="mailto:aprendizaje@ia.com">aprendizaje@ia.com</a>.
                        </div>

                        <form action="registrarUsuario.jsp" method="post">

                            <div class="form-group">
                                <label for="nombre"><strong>Nombre completo</strong></label>
                                <input type="text" name="nombre" id="nombre"
                                       class="form-control input"
                                       required
                                       placeholder="Ej: Juan Pérez">
                            </div>

                            <div class="form-group mt-4">
                                <label for="correo"><strong>Correo electrónico</strong></label>
                                <input type="email" name="correo" id="correo"
                                       class="form-control input"
                                       required
                                       placeholder="Ej: juan@example.com">
                            </div>

                            <div class="form-group mt-4">
                                <label for="contrasena"><strong>Contraseña</strong></label>
                                <input type="password" name="contrasena" id="contrasena"
                                       class="form-control input"
                                       required
                                       minlength="6">
                                <small class="form-text text-muted">Mínimo 6 caracteres</small>
                            </div>

                            <div class="form-group mt-4">
                                <label for="confirmar"><strong>Confirmar contraseña</strong></label>
                                <input type="password" name="confirmar" id="confirmar"
                                       class="form-control input"
                                       required
                                       minlength="6">
                            </div>

                            <div class="text-center mt-5">
                                <button type="submit" class="btn btn-register">
                                    Registrarme
                                </button>
                            </div>

                            <div class="text-center mt-4">
                                <p>¿Ya tienes cuenta?
                                    <a href="login.jsp" style="color:#006299; font-weight:bold;">
                                        Iniciar Sesión
                                    </a>
                                </p>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="includes/footer.jsp"%>

</body>
</html>
