<%-- 
    Document   : verTutorial
    Created on : 6/01/2026, 10:22:27 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    int idUsuario = 0;
    if (session.getAttribute("id_usuario") != null) {
        idUsuario = (Integer) session.getAttribute("id_usuario");
    }
    if (rol == null || !"ESTUDIANTE".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Obtener el id del tutorial
    String idStr = request.getParameter("id");
    int idTutorial = 0;
    boolean tutorialValido = false;
    String titulo = "";
    String descripcion = "";
    String nivel = "";
    String contenido = "";
    String video_url = "";
    boolean esFavorito = false;

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            idTutorial = Integer.parseInt(idStr);

            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Obtener datos del tutorial
                ps = conexion.prepareStatement(
                    "SELECT titulo, descripcion, nivel, contenido, video_url FROM tutoriales WHERE id_tutorial = ?"
                );
                ps.setInt(1, idTutorial);
                rs = ps.executeQuery();

                if (rs.next()) {
                    tutorialValido = true;
                    titulo = rs.getString("titulo");
                    descripcion = rs.getString("descripcion");
                    nivel = rs.getString("nivel");
                    contenido = rs.getString("contenido") != null ? rs.getString("contenido") : "";
                    video_url = rs.getString("video_url") != null ? rs.getString("video_url").trim() : "";
                }
                rs.close();
                ps.close();

                // Registrar vista (solo si es válido)
                if (tutorialValido) {
                    ps = conexion.prepareStatement(
                        "INSERT IGNORE INTO vistas_tutoriales (id_usuario, id_tutorial) VALUES (?, ?)"
                    );
                    ps.setInt(1, idUsuario);
                    ps.setInt(2, idTutorial);
                    ps.executeUpdate();
                    ps.close();
                }

                // Verificar si está en favoritos
                if (tutorialValido) {
                    ps = conexion.prepareStatement(
                        "SELECT 1 FROM favoritos WHERE id_usuario = ? AND id_tutorial = ?"
                    );
                    ps.setInt(1, idUsuario);
                    ps.setInt(2, idTutorial);
                    rs = ps.executeQuery();
                    esFavorito = rs.next();
                    rs.close();
                    ps.close();
                }

            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error al cargar el tutorial: " + e.getMessage() + "</div>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (ps != null) ps.close(); } catch (Exception e) {}
            }
        } catch (NumberFormatException e) {
            // ID inválido
        }
    }

    if (!tutorialValido) {
        response.sendRedirect("panelAlumno.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= titulo %> - Plataforma IA</title>
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
        .tutorial-header {
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 3px solid #006299;
        }
        .tutorial-content {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            line-height: 1.8;
            font-size: 17px;
        }
        .favorito-btn-big {
            font-size: 40px;
            color: #ccc;
            transition: 0.3s;
            cursor: pointer;
        }
        .favorito-btn-big.activo {
            color: #ff8c00;
            text-shadow: 0 0 15px rgba(255,140,0,0.6);
        }
        .favorito-btn-big:hover {
            transform: scale(1.2);
        }
        
        .video-container {
            position: relative;
            padding-bottom: 56.25%;  /* Aspect ratio 16:9 */
            height: 0;
            overflow: hidden;
            background: #000;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            margin: 40px 0;
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
                            Bienvenido, <strong><%= nombreUsuario != null ? nombreUsuario : "Estudiante" %></strong>
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

    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelAlumno.jsp" class="sidebar-link">
                        <i class="fa fa-graduation-cap"></i> Centro de Aprendizaje
                    </a>
                    <a href="diccionarioIA.jsp" class="sidebar-link">
                        <i class="fa fa-book"></i> Diccionario IA
                    </a>
                    <a href="favoritos.jsp" class="sidebar-link">
                        <i class="fa fa-star"></i> Favoritos
                    </a>
                </div>
            </div>

            <!-- Contenido del Tutorial -->
            <div class="col-md-9">
                <div class="tutorial-header">
                    <div class="row align-items-center">
                        <div class="col-md-9">
                            <h1 class="title" style="margin: 0; color: #006299;"><%= titulo %></h1>
                            <p style="font-size: 18px; margin: 10px 0;"><%= descripcion %></p>
                            <span class="badge badge-pill badge-<%= 
                                "Principiante".equals(nivel) ? "success" :
                                "Intermedio".equals(nivel) ? "warning" : "danger"
                            %>">
                                <%= nivel %>
                            </span>
                        </div>
                        <div class="col-md-3 text-right">
                            <a href="guardarFavorito.jsp?id=<%= idTutorial %>" 
                               class="favorito-btn-big <%= esFavorito ? "activo" : "" %>" 
                               title="<%= esFavorito ? "Quitar de favoritos" : "Agregar a favoritos" %>">
                                <%= esFavorito ? "★" : "☆" %>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Video si existe -->
                <% if (video_url != null && !video_url.trim().isEmpty()) { %>
                    <div class="video-container">
                        <iframe src="<%= video_url %>"
                                title="Video del tutorial: <%= titulo %>"
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
                    <a href="panelAlumno.jsp" class="primary-btn">
                        ← Volver al Centro de Aprendizaje
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>

</body>
</html>