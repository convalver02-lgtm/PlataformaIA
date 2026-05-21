<%-- 
    Document   : casosUsoAlumno
    Created on : 12/01/2026, 01:32:31 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    int idUsuario = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"ESTUDIANTE".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Casos de Uso IA - Plataforma IA</title>
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
        .case-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .case-card:hover {
            transform: translateY(-10px);
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
            <!-- Sidebar del alumno -->
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
                    <a href="casosUsoAlumno.jsp" class="sidebar-link active">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                </div>
            </div>

            <!-- Lista de casos -->
            <div class="col-md-9">
                <h2 class="title">Casos de Uso y Estrategias IA</h2>
                <p class="lead mb-4">Aprende cómo crear prompts efectivos con ejemplos reales</p>

                <%
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        ps = conexion.prepareStatement("SELECT id_caso, titulo FROM casos_uso_ia ORDER BY fecha_creacion DESC");
                        rs = ps.executeQuery();
                        if (!rs.isBeforeFirst()) {
                %>
                            <div class="alert alert-info text-center p-5">
                                <i class="fa fa-info-circle fa-3x mb-3"></i>
                                <h4>Aún no hay casos de uso disponibles</h4>
                                <p>¡Vuelve pronto!</p>
                            </div>
                <%
                        } else {
                            while (rs.next()) {
                %>
                                <div class="case-card">
                                    <h3 class="case-title"><%= rs.getString("titulo") %></h3>
                                    <div class="text-right">
                                        <a href="verCasoAlumno.jsp?id=<%= rs.getInt("id_caso") %>" class="primary-btn">
                                            Ver Caso Completo
                                        </a>
                                    </div>
                                </div>
                <%
                            }
                        }
                        rs.close();
                        ps.close();
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                    }
                %>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>
</body>
</html>
