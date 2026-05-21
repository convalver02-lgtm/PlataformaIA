<%-- 
    Document   : newjsp
    Created on : 6/01/2026, 05:10:49 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Nuevo Tutorial - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container {
            margin-top: 80px;
            margin-bottom: 120px;
        }
        .form-container {
            background: white;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: bold;
            color: #006299;
        }
        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }
        .btn-guardar {
            background-color: #006299;
            color: white;
            padding: 12px 40px;
            font-size: 18px;
            border-radius: 40px;
        }
        .btn-guardar:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>

    <!-- Header logueado (igual que en nuevoCasoUso) -->
    <header>
        <div id="header" style="background-color: #006299; color: white;">
            <div class="container">
                <div class="row align-items-center" style="min-height: 80px;">
                    <div class="col-md-3">
                        <a href="../index.jsp">
                            <img src="../img/logo.png" alt="Logo" height="60">
                        </a>
                    </div>
                    <div class="col-md-6 text-center">
                        <h3 style="color: white; margin: 0;">Plataforma Educativa de Inteligencia Artificial</h3>
                    </div>
                    <div class="col-md-3 text-right">
                        <span style="color: white; font-size: 16px;">
                            <i class="fa fa-user-circle fa-lg"></i>
                            Bienvenido, <strong><%= nombreUsuario != null ? nombreUsuario : "Instructor" %></strong>
                        </span>
                        <br>
                        <a href="../cerrarSesion.jsp" class="primary-btn" style="margin-top: 10px; padding: 10px 25px;">
                            Cerrar Sesión
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav id="navigation">
        <div class="container">
            <ul class="main-nav nav navbar-nav">
                <li><a href="panelInstructor.jsp">Mis Tutorías</a></li>
                <li><a href="../acercaDe.jsp">Acerca de</a></li>
            </ul>
        </div>
    </nav>

    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelInstructor.jsp" class="sidebar-link active">
                        <i class="fa fa-chalkboard-teacher"></i> Tutorías
                    </a>
                    <a href="casosUsoInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                </div>
            </div>

            <!-- Formulario -->
            <div class="col-md-9">
                <h2 class="title">Crear Nuevo Tutorial</h2>
                <p class="lead mb-4">Comparte tu conocimiento con la comunidad</p>

                <div class="form-container">
                    <form action="guardarTutorial.jsp" method="post">
                        <div class="form-group">
                            <label for="titulo" class="form-label">Título del Tutorial</label>
                            <input type="text" name="titulo" id="titulo" class="form-control input" required placeholder="Ej: Introducción a Machine Learning">
                        </div>

                        <div class="form-group mt-4">
                            <label for="descripcion" class="form-label">Descripción corta</label>
                            <textarea name="descripcion" id="descripcion" class="form-control input" rows="3" required placeholder="Breve descripción que aparecerá en la tarjeta"></textarea>
                        </div>

                        <div class="form-group mt-4">
                            <label for="nivel" class="form-label">Nivel</label>
                            <select name="nivel" id="nivel" class="form-control input" required>
                                <option value="Principiante">Principiante</option>
                                <option value="Intermedio">Intermedio</option>
                                <option value="Avanzado">Avanzado</option>
                            </select>
                        </div>

                        <div class="form-group mt-4">
                            <label for="contenido" class="form-label">Contenido del Tutorial (texto)</label>
                            <textarea name="contenido" id="contenido" class="form-control input" rows="10" required placeholder="Escribe aquí el contenido completo del tutorial..."></textarea>
                        </div>

                        <div class="form-group mt-4">
                            <label for="video_url" class="form-label">Enlace del Video (YouTube) <small class="text-muted">(opcional)</small></label>
                            <input type="url" name="video_url" id="video_url" class="form-control input"
                                   placeholder="Ej: https://www.youtube.com/embed/dQw4w9WgXcQ">
                            <small class="form-text text-muted">
                                Usa el formato <strong>embed</strong> de YouTube (cambia watch?v= por embed/).
                            </small>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-guardar">
                                Guardar Tutorial
                            </button>
                            <a href="panelInstructor.jsp" class="btn btn-secondary ml-3">
                                Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>
</body>
</html>