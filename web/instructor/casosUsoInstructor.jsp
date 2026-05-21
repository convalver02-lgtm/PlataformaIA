<%-- 
    Document   : casosUsoInstructor
    Created on : 11/01/2026, 11:32:01 PM
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
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Casos de Uso IA - Instructor</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container {
            margin-top: 80px; /* Más espacio arriba */
            margin-bottom: 120px; /* Más espacio abajo para que el footer baje */
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
        .btn-crear {
            background-color: #006299;
            color: white;
            font-size: 18px;
            padding: 15px 30px;
            border-radius: 40px;
            margin-bottom: 40px;
        }
        .btn-crear:hover {
            opacity: 0.9;
            color: white;
        }
        table th {
            background-color: #006299;
            color: white;
        }
        .btn-accion {
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <!-- Header logueado (igual que en panelInstructor.jsp) -->
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
    <!-- Mensaje de éxito/error -->
    <%
        if (msg != null) {
    %>
        <div class="container mt-3">
            <% if ("creado".equals(msg) || "actualizado".equals(msg) || "eliminado".equals(msg)) { %>
                <div class="alert alert-success alert-dismissible fade show">
                    ¡Caso <%= msg.equals("creado") ? "creado" : msg.equals("actualizado") ? "actualizado" : "eliminado" %> correctamente!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } else { %>
                <div class="alert alert-danger alert-dismissible fade show">
                    Ocurrió un error al procesar la acción.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
        </div>
    <%
        }
    %>
    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-chalkboard-teacher"></i> Tutorías
                    </a>
                    <a href="casosUsoInstructor.jsp" class="sidebar-link active">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                    <a href="diccionarioInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-book"></i> Diccionario IA
                    </a>
                </div>
            </div>
            <!-- Área de gestión -->
            <div class="col-md-9">
                <h2 class="title">Gestión de Casos de Uso y Estrategias IA</h2>
                <p class="lead">Crea y edita ejemplos prácticos para enseñar prompts efectivos</p>
                <!-- Botón Crear Nuevo -->
                <div class="text-center mb-4">
                    <a href="nuevoCasoUso.jsp" class="btn btn-crear">
                        <i class="fa fa-plus-circle fa-lg"></i> Crear Nuevo Caso
                    </a>
                </div>
                <!-- Lista de casos -->
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                PreparedStatement ps = conexion.prepareStatement(
                                    "SELECT id_caso, titulo, fecha_creacion FROM casos_uso_ia WHERE id_instructor = ? ORDER BY fecha_creacion DESC"
                                );
                                ps.setInt(1, idInstructor);
                                ResultSet rs = ps.executeQuery();
                                if (!rs.isBeforeFirst()) {
                            %>
                                <tr>
                                    <td colspan="3" class="text-center">
                                        <em>No has creado casos de uso aún.</em>
                                    </td>
                                </tr>
                            <%
                                } else {
                                    while (rs.next()) {
                            %>
                                <tr>
                                    <td><strong><%= rs.getString("titulo") %></strong></td>
                                    <td><%= rs.getTimestamp("fecha_creacion") %></td>
                                    <td>
                                        <a href="verCasoInstructor.jsp?id=<%= rs.getInt("id_caso") %>" class="btn btn-primary btn-sm btn-accion">Ver</a>
                                        <a href="editarCasoUso.jsp?id=<%= rs.getInt("id_caso") %>" class="btn btn-info btn-sm btn-accion">Editar</a>
                                        <a href="eliminarCasoUso.jsp?id=<%= rs.getInt("id_caso") %>"
                                           class="btn btn-danger btn-sm btn-accion"
                                           onclick="return confirm('¿Seguro que deseas eliminar este caso?')">Eliminar</a>
                                    </td>
                                </tr>
                            <%
                                    }
                                }
                                rs.close();
                                ps.close();
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>