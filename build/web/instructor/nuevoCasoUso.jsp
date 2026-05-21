<%-- 
    Document   : nuevoCasoUso
    Created on : 11/01/2026, 11:53:47 PM
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
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Nuevo Caso de Uso IA - Plataforma IA</title>
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
        .sidebar-dashboard {
            background: white;
            border-radius: 12px;
            padding: 20px 0;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }
        .sidebar-link {
            display: block;
            padding: 16px 30px;
            font-size: 16px;
            color: #333;
            border-bottom: 1px solid #eee;
            transition: 0.3s;
        }
        .sidebar-link:hover {
            background: #f1f3f5;
            color: #006299;
            text-decoration: none;
        }
        .sidebar-link.active {
            background: #006299;
            color: white;
            font-weight: bold;
        }
        .sidebar-link i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
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

    <!-- Header logueado -->
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

    <!-- Mensaje de error (si hay) -->
    <%
        if (error != null) {
    %>
        <div class="container mt-3">
            <div class="alert alert-danger alert-dismissible fade show">
                <% if ("campos".equals(error)) { %>
                    Completa todos los campos obligatorios.
                <% } else { %>
                    Error al guardar el caso. Intenta de nuevo.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    <%
        }
    %>

    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar lateral (igual que panelInstructor) -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-chalkboard-teacher"></i> Tutorías
                    </a>
                    <a href="casosUsoInstructor.jsp" class="sidebar-link active">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                </div>
            </div>

            <!-- Formulario -->
            <div class="col-md-9">
                <h2 class="title">Crear Nuevo Caso de Uso IA</h2>
                <p class="lead mb-4">Comparte un ejemplo práctico para enseñar cómo crear prompts efectivos</p>

                <div class="form-container">
                    <form action="guardarCasoUso.jsp" method="post">
                        <div class="form-group">
                            <label for="titulo" class="form-label">Título del Caso</label>
                            <input type="text" name="titulo" id="titulo" class="form-control input" required placeholder="Ej: Generar plan de marketing para un café local con IA">
                        </div>

                        <div class="form-group mt-4">
                            <label for="problema" class="form-label">Problema Real</label>
                            <textarea name="problema" id="problema" class="form-control input" rows="5" required placeholder="Describe el problema real que enfrenta alguien..."></textarea>
                        </div>

                        <div class="form-group mt-4">
                            <label for="solucion" class="form-label">Solución Propuesta con IA</label>
                            <textarea name="solucion" id="solucion" class="form-control input" rows="5" required placeholder="Describe el prompt usado y la respuesta de la IA..."></textarea>
                        </div>

                        <div class="form-group mt-4">
                            <label for="explicacion_tecnica" class="form-label">Explicación Técnica (por qué funciona)</label>
                            <textarea name="explicacion_tecnica" id="explicacion_tecnica" class="form-control input" rows="5" required placeholder="Explica por qué el prompt fue efectivo..."></textarea>
                        </div>

                        <div class="form-group mt-4">
                            <label for="resultado_pobre" class="form-label">Resultado Pobre (opcional)</label>
                            <textarea name="resultado_pobre" id="resultado_pobre" class="form-control input" rows="3" placeholder="Ejemplo de resultado malo sin optimización..."></textarea>
                        </div>

                        <div class="form-group mt-4">
                            <label for="resultado_optimizado" class="form-label">Resultado Optimizado (opcional)</label>
                            <textarea name="resultado_optimizado" id="resultado_optimizado" class="form-control input" rows="3" placeholder="Ejemplo de resultado excelente con el prompt optimizado..."></textarea>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-guardar">
                                Guardar Caso
                            </button>
                            <a href="casosUsoInstructor.jsp" class="btn btn-secondary ml-3">
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