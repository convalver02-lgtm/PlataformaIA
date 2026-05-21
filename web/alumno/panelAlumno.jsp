<%-- 
    Document   : panelAumno
    Created on : 6/01/2026, 04:33:30 AM
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
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Estudiante - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container {
            margin-top: 50px;
            margin-bottom: 100px;
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
        .progress-box {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            margin-bottom: 50px;
        }
        .progress {
            height: 50px;
            border-radius: 25px;
            background-color: #e9ecef;
        }
        .progress-bar {
            background-color: #006299;
            font-size: 20px;
            font-weight: 700;
            line-height: 50px;
        }
        .tutorial-row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
        }
        .tutorial-col {
            padding: 15px;
            flex: 0 0 33.333333%;
            max-width: 33.333333%;
        }
        @media (max-width: 992px) {
            .tutorial-col { flex: 0 0 50%; max-width: 50%; }
        }
        @media (max-width: 768px) {
            .tutorial-col { flex: 0 0 100%; max-width: 100%; }
        }
        .card-tutorial {
            background: white;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.3s ease;
        }
        .card-tutorial:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        .placeholder-img {
            background: #e9ecef;
            height: 160px;
            border-radius: 12px;
            margin-bottom: 25px;
        }
        .card-tutorial h5 {
            color: #006299;
            margin: 0 0 20px;
            flex-grow: 1;
            text-align: center;
        }
        .btn-container {
            text-align: right;
        }
        .favorito-btn {
            font-size: 28px;
            color: #ccc;
            transition: 0.3s;
        }
        .favorito-btn.activo {
            color: #ff8c00;
            text-shadow: 0 0 10px rgba(255,140,0,0.5);
        }
        .favorito-btn:hover {
            color: #ff8c00;
            transform: scale(1.2);
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
            <!-- Sidebar (restaurado como lo tenías) -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelAlumno.jsp" class="sidebar-link active">
                        <i class="fa fa-graduation-cap"></i> Centro de Aprendizaje
                    </a>
                    <a href="diccionarioIA.jsp" class="sidebar-link">
                        <i class="fa fa-book"></i> Diccionario IA
                    </a>
                    <a href="favoritos.jsp" class="sidebar-link">
                        <i class="fa fa-star"></i> Favoritos
                    </a>
                    <a href="casosUsoAlumno.jsp" class="sidebar-link">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                </div>
            </div>

            <!-- Área de tutoriales y progreso -->
            <div class="col-md-9">
                <h2 class="title">Tutoriales Recomendados</h2>

                <!-- Progreso General -->
                <div class="progress-box">
                    <h4 style="color: #006299; margin-bottom: 20px;">Progreso General</h4>
                    <%
                        int totalTutoriales = 0;
                        int vistos = 0;
                        int porcentaje = 0;

                        PreparedStatement psTotal = null;
                        ResultSet rsTotal = null;
                        PreparedStatement psVistos = null;
                        ResultSet rsVistos = null;
                        try {
                            psTotal = conexion.prepareStatement("SELECT COUNT(*) AS total FROM tutoriales");
                            rsTotal = psTotal.executeQuery();
                            if (rsTotal.next()) {
                                totalTutoriales = rsTotal.getInt("total");
                            }
                            rsTotal.close();
                            psTotal.close();

                            psVistos = conexion.prepareStatement(
                                "SELECT COUNT(DISTINCT id_tutorial) AS vistos FROM vistas_tutoriales WHERE id_usuario = ?"
                            );
                            psVistos.setInt(1, idUsuario);
                            rsVistos = psVistos.executeQuery();
                            if (rsVistos.next()) {
                                vistos = rsVistos.getInt("vistos");
                            }
                            rsVistos.close();
                            psVistos.close();

                            if (totalTutoriales > 0) {
                                porcentaje = (vistos * 100) / totalTutoriales;
                            }
                        } catch (Exception e) {
                            porcentaje = 0;
                        } finally {
                            try { if (rsTotal != null) rsTotal.close(); } catch (Exception e) {}
                            try { if (psTotal != null) psTotal.close(); } catch (Exception e) {}
                            try { if (rsVistos != null) rsVistos.close(); } catch (Exception e) {}
                            try { if (psVistos != null) psVistos.close(); } catch (Exception e) {}
                        }
                    %>
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" style="width: <%= porcentaje %>%;" aria-valuenow="<%= porcentaje %>" aria-valuemin="0" aria-valuemax="100">
                            <%= porcentaje %>%
                        </div>
                    </div>
                </div>

                <!-- Lista de tutoriales -->
                <%
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    PreparedStatement psFav = null;
                    ResultSet rsFav = null;
                    try {
                        ps = conexion.prepareStatement("SELECT id_tutorial, titulo, descripcion, nivel FROM tutoriales ORDER BY nivel, fecha_creacion DESC");
                        rs = ps.executeQuery();
                        String currentNivel = "";
                        while (rs.next()) {
                            int idTutorial = rs.getInt("id_tutorial");
                            String nivel = rs.getString("nivel");

                            // Verificar si ya está en favoritos
                            boolean esFavorito = false;
                            psFav = conexion.prepareStatement("SELECT 1 FROM favoritos WHERE id_usuario = ? AND id_tutorial = ?");
                            psFav.setInt(1, idUsuario);
                            psFav.setInt(2, idTutorial);
                            rsFav = psFav.executeQuery();
                            if (rsFav.next()) {
                                esFavorito = true;
                            }
                            rsFav.close();
                            psFav.close();

                            if (!nivel.equals(currentNivel)) {
                                if (!currentNivel.isEmpty()) out.println("</div>");
                                currentNivel = nivel;
                %>
                                <h4 style="color: #006299; margin: 40px 0 20px;"><%= nivel %></h4>
                                <div class="tutorial-row">
                <%
                            }
                %>
                            <div class="tutorial-col">
                                <div class="card-tutorial">
                                    <div class="placeholder-img"></div>
                                    <h5><%= rs.getString("titulo") %></h5>
                                    <div class="btn-container">
                                        <a href="verTutorial.jsp?id=<%= idTutorial %>" class="primary-btn">
                                            Ver Tutorial
                                        </a>
                                        <a href="guardarFavorito.jsp?id=<%= idTutorial %>" 
                                           class="favorito-btn <%= esFavorito ? "activo" : "" %>" 
                                           title="<%= esFavorito ? "Quitar de favoritos" : "Agregar a favoritos" %>">
                                            <%= esFavorito ? "★" : "☆" %>
                                        </a>
                                    </div>
                                </div>
                            </div>
                <%
                        }
                        if (!currentNivel.isEmpty()) out.println("</div>");
                        if (currentNivel.isEmpty()) {
                %>
                            <div class="alert alert-info text-center p-5">
                                <i class="fa fa-info-circle fa-3x mb-3"></i>
                                <h4>No hay tutoriales disponibles</h4>
                                <p>¡Vuelve pronto para nuevos contenidos!</p>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                    } finally {
                        try { if (rsFav != null) rsFav.close(); } catch (Exception e) {}
                        try { if (psFav != null) psFav.close(); } catch (Exception e) {}
                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                        try { if (ps != null) ps.close(); } catch (Exception e) {}
                    }
                %>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>

</body>
</html>