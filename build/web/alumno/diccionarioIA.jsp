<%-- 
    Document   : diccionarioIA
    Created on : 8/01/2026, 02:08:39 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    if (rol == null || !"ESTUDIANTE".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Búsqueda
    String busqueda = request.getParameter("busqueda");
    if (busqueda == null) busqueda = "";
    busqueda = busqueda.trim();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Diccionario de IA - Plataforma IA</title>
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
        .search-box {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            margin-bottom: 40px;
        }
        .termino-item {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: 0.3s;
        }
        .termino-item:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }
        .termino-titulo {
            color: #006299;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .no-resultados {
            text-align: center;
            padding: 60px;
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

    <!-- Contenido principal (sin navigation superior) -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelAlumno.jsp" class="sidebar-link">
                        <i class="fa fa-graduation-cap"></i> Centro de Aprendizaje
                    </a>
                    <a href="diccionarioIA.jsp" class="sidebar-link active">
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

            <!-- Área del Diccionario -->
            <div class="col-md-9">
                <h2 class="title">Diccionario de Inteligencia Artificial</h2>

                <!-- Buscador -->
                <div class="search-box">
                    <form action="diccionarioIA.jsp" method="get" class="form-inline">
                        <div class="input-group w-100">
                            <input type="text" name="busqueda" class="form-control input" 
                                   placeholder="Buscar término..." value="<%= busqueda %>">
                            <div class="input-group-append">
                                <button type="submit" class="btn primary-btn">
                                    <i class="fa fa-search"></i> Buscar
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Lista de términos -->
                <%
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        String sql = "SELECT termino, definicion FROM diccionario_ia";
                        if (!busqueda.isEmpty()) {
                            sql += " WHERE termino LIKE ? OR definicion LIKE ?";
                        }
                        sql += " ORDER BY termino ASC";

                        ps = conexion.prepareStatement(sql);
                        if (!busqueda.isEmpty()) {
                            String like = "%" + busqueda + "%";
                            ps.setString(1, like);
                            ps.setString(2, like);
                        }
                        rs = ps.executeQuery();

                        if (!rs.isBeforeFirst()) {
                %>
                            <div class="no-resultados">
                                <i class="fa fa-search fa-4x mb-4 text-muted"></i>
                                <h4>No se encontraron resultados</h4>
                                <p>Prueba con otra palabra o agrega términos nuevos.</p>
                            </div>
                <%
                        } else {
                            while (rs.next()) {
                %>
                                <div class="termino-item">
                                    <div class="termino-titulo"><%= rs.getString("termino") %></div>
                                    <p><%= rs.getString("definicion") %></p>
                                </div>
                <%
                            }
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error al cargar el diccionario: " + e.getMessage() + "</div>");
                    } finally {
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