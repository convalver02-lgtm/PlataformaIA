<%-- 
    Document   : favoritos
    Created on : 6/01/2026, 10:23:16 AM
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
    <title>Mis Favoritos - Plataforma IA</title>
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
        .no-favoritos {
            text-align: center;
            padding: 80px;
            color: #666;
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
                    <a href="favoritos.jsp" class="sidebar-link active">
                        <i class="fa fa-star"></i> Favoritos
                    </a>
                    
                    <a href="casosUsoAlumno.jsp" class="sidebar-link">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                    
                </div>
            </div>

            <!-- Lista de Favoritos -->
            <div class="col-md-9">
                <h2 class="title">Mis Favoritos</h2>

                <div class="row">
                    <%
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            ps = conexion.prepareStatement(
                                "SELECT t.id_tutorial, t.titulo, t.descripcion, t.nivel " +
                                "FROM favoritos f " +
                                "JOIN tutoriales t ON f.id_tutorial = t.id_tutorial " +
                                "WHERE f.id_usuario = ? " +
                                "ORDER BY f.fecha_guardado DESC"
                            );
                            ps.setInt(1, idUsuario);
                            rs = ps.executeQuery();

                            if (!rs.isBeforeFirst()) {
                    %>
                                <div class="col-12">
                                    <div class="no-favoritos">
                                        <i class="fa fa-star fa-5x mb-4 text-muted"></i>
                                        <h4>Aún no tienes tutoriales en favoritos</h4>
                                        <p>Explora el Centro de Aprendizaje y marca con ⭐ los que te gusten.</p>
                                        <a href="panelAlumno.jsp" class="primary-btn">Ir al Centro de Aprendizaje</a>
                                    </div>
                                </div>
                    <%
                            } else {
                                while (rs.next()) {
                    %>
                                    <div class="col-md-4 mb-5">
                                        <div class="card-tutorial">
                                            <div class="placeholder-img"></div>
                                            <h5><%= rs.getString("titulo") %></h5>
                                            <div class="btn-container">
                                                <a href="verTutorial.jsp?id=<%= rs.getInt("id_tutorial") %>" class="primary-btn">
                                                    Ver Tutorial
                                                </a>
                                                <a href="quitarFavorito.jsp?id=<%= rs.getInt("id_tutorial") %>" 
                                                   class="btn btn-danger btn-sm ml-2"
                                                   onclick="return confirm('¿Quitar de favoritos?')">
                                                    Quitar ⭐
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            out.println("<div class='alert alert-danger'>Error al cargar favoritos: " + e.getMessage() + "</div>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (ps != null) ps.close(); } catch (Exception e) {}
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>

</body>
</html>