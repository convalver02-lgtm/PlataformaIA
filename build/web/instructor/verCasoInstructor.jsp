<%-- 
    Document   : verCasoInstructor
    Created on : 11/01/2026, 11:35:34 PM
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

    // Obtener id del caso
    String idStr = request.getParameter("id");
    int idCaso = 0;
    boolean casoValido = false;
    String titulo = "";
    String problema = "";
    String solucion = "";
    String explicacion_tecnica = "";
    String resultado_pobre = "";
    String resultado_optimizado = "";

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            idCaso = Integer.parseInt(idStr);
            PreparedStatement ps = conexion.prepareStatement(
                "SELECT titulo, problema, solucion, explicacion_tecnica, resultado_pobre, resultado_optimizado " +
                "FROM casos_uso_ia WHERE id_caso = ? AND id_instructor = ?"
            );
            ps.setInt(1, idCaso);
            ps.setInt(2, idInstructor);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                casoValido = true;
                titulo = rs.getString("titulo");
                problema = rs.getString("problema");
                solucion = rs.getString("solucion");
                explicacion_tecnica = rs.getString("explicacion_tecnica");
                resultado_pobre = rs.getString("resultado_pobre") != null ? rs.getString("resultado_pobre") : "";
                resultado_optimizado = rs.getString("resultado_optimizado") != null ? rs.getString("resultado_optimizado") : "";
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            // Error silencioso
        }
    }

    if (!casoValido) {
        response.sendRedirect("casosUsoInstructor.jsp");
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
        .case-header { margin-bottom: 40px; padding-bottom: 20px; border-bottom: 3px solid #006299; }
        .case-section {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .case-title {
            color: #006299;
            font-weight: 700;
            margin-bottom: 15px;
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

            <!-- Vista previa del caso -->
            <div class="col-md-9">
                <div class="case-header">
                    <h1 class="title" style="margin: 0; color: #006299;"><%= titulo %> (Vista Previa)</h1>
                </div>

                <div class="case-section">
                    <h3 class="case-title">Problema Real</h3>
                    <p><%= problema.replace("\n", "<br>") %></p>
                </div>

                <div class="case-section">
                    <h3 class="case-title">Solución Propuesta con IA</h3>
                    <p><%= solucion.replace("\n", "<br>") %></p>
                </div>

                <div class="case-section">
                    <h3 class="case-title">Explicación Técnica de la Estrategia</h3>
                    <p><%= explicacion_tecnica.replace("\n", "<br>") %></p>
                </div>

                <% if (!resultado_pobre.isEmpty() || !resultado_optimizado.isEmpty()) { %>
                    <div class="row">
                        <% if (!resultado_pobre.isEmpty()) { %>
                            <div class="col-md-6">
                                <div class="case-section border-danger">
                                    <h3 class="case-title text-danger">Resultado Pobre</h3>
                                    <p><%= resultado_pobre.replace("\n", "<br>") %></p>
                                </div>
                            </div>
                        <% } %>
                        <% if (!resultado_optimizado.isEmpty()) { %>
                            <div class="col-md-6">
                                <div class="case-section border-success">
                                    <h3 class="case-title text-success">Resultado Optimizado</h3>
                                    <p><%= resultado_optimizado.replace("\n", "<br>") %></p>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>

                <div class="text-center mt-5">
                    <a href="casosUsoInstructor.jsp" class="primary-btn">
                        ← Volver a la Lista de Casos
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>
</body>
</html>