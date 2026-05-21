<%-- 
    Document   : verTutorialInstructor
    Created on : 12/01/2026, 09:27:02 AM
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

    // Obtener id del tutorial
    String idStr = request.getParameter("id");
    int idTutorial = 0;
    boolean tutorialValido = false;
    String titulo = "";
    String descripcion = "";
    String nivel = "";
    String contenido = "";
    String video_url = "";

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            idTutorial = Integer.parseInt(idStr);
            PreparedStatement ps = conexion.prepareStatement(
                "SELECT titulo, descripcion, nivel, contenido, video_url " +
                "FROM tutoriales WHERE id_tutorial = ? AND id_instructor = ?"
            );
            ps.setInt(1, idTutorial);
            ps.setInt(2, idInstructor);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                tutorialValido = true;
                titulo = rs.getString("titulo");
                descripcion = rs.getString("descripcion");
                nivel = rs.getString("nivel");
                contenido = rs.getString("contenido") != null ? rs.getString("contenido") : "";
                video_url = rs.getString("video_url") != null ? rs.getString("video_url") : "";
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            // Error silencioso
        }
    }

    if (!tutorialValido) {
        response.sendRedirect("panelInstructor.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= titulo %> - Vista Previa (Instructor)</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container { margin-top: 80px; margin-bottom: 120px; }
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
        .sidebar-link i { margin-right: 12px; width: 20px; text-align: center; }
        .tutorial-header { margin-bottom: 40px; padding-bottom: 20px; border-bottom: 3px solid #006299; }
        .tutorial-content {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            line-height: 1.8;
        }
        .video-container {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 aspect ratio */
            height: 0;
            overflow: hidden;
            margin-bottom: 30px;
        }
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
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

    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar lateral (solo "Tutorías" activo) -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelInstructor.jsp" class="sidebar-link active">
                        <i class="fa fa-chalkboard-teacher"></i> Tutorías
                    </a>
                    <a href="casosUsoInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                    <a href="diccionarioInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-book"></i> Diccionario IA
                    </a>
                </div>
            </div>

            <!-- Vista previa del tutorial -->
            <div class="col-md-9">
                <div class="tutorial-header">
                    <h1 class="title" style="margin: 0; color: #006299;"><%= titulo %> (Vista Previa)</h1>
                    <p class="lead"><%= descripcion %></p>
                    <span class="badge badge-pill badge-<%= 
                        "Principiante".equals(nivel) ? "success" :
                        "Intermedio".equals(nivel) ? "warning" : "danger" 
                    %>">
                        <%= nivel %>
                    </span>
                </div>

                <!-- Video si existe -->
                <% if (video_url != null && !video_url.trim().isEmpty()) { %>
                    <div class="video-container">
                        <iframe src="<%= video_url %>" 
                                title="Video del tutorial" 
                                frameborder="0" 
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                allowfullscreen></iframe>
                    </div>
                <% } %>

                <!-- Contenido textual -->
                <div class="tutorial-content">
                    <%= contenido.replace("\n", "<br>") %>
                </div>

                <div class="text-center mt-5">
                    <a href="panelInstructor.jsp" class="primary-btn">
                        ← Volver al Panel
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>
</body>
</html>