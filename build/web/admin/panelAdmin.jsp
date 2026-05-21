<%-- 
    Document   : panelAdmin
    Created on : 6/01/2026, 04:34:48 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    if (rol == null || !"ADMIN".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }
    String msg = request.getParameter("msg");
    String activeSection = request.getParameter("section"); // Para mantener sección activa al recargar
    if (activeSection == null) activeSection = "usuarios";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Administrador - Plataforma IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container { margin-top: 50px; margin-bottom: 150px; }
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
            cursor: pointer;
        }
        .sidebar-link:hover { background: #f1f3f5; color: #006299; text-decoration: none; }
        .sidebar-link.active { background: #006299; color: white; font-weight: bold; }
        .sidebar-link i { margin-right: 12px; width: 20px; text-align: center; }
        .section-content { display: none; }
        .section-content.active { display: block; }
        .card-admin {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            margin-bottom: 40px;
        }
        .form-rol {
            display: inline-block;
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
                            Administrador: <strong><%= nombreUsuario != null ? nombreUsuario : "Admin" %></strong>
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
                <li class="active"><a href="panelAdmin.jsp">Administración</a></li>
                <li><a href="../acercaDe.jsp">Acerca de</a></li>
            </ul>
        </div>
    </nav>
    <!-- Mensaje de éxito/error -->
    <% if (msg != null) { %>
        <div class="container mt-3">
            <% if ("rol_actualizado".equals(msg)) { %>
                <div class="alert alert-success">¡Rol actualizado correctamente!</div>
            <% } else { %>
                <div class="alert alert-danger">Error al actualizar el rol.</div>
            <% } %>
        </div>
    <% } %>
    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar izquierdo -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="#" class="sidebar-link <%= "usuarios".equals(activeSection) ? "active" : "" %>" data-section="usuarios">
                        <i class="fa fa-users"></i> Gestión de Usuarios
                    </a>
                    <a href="#" class="sidebar-link <%= "contenido".equals(activeSection) ? "active" : "" %>" data-section="contenido">
                        <i class="fa fa-file-text-o"></i> Administrar Contenido Informativo
                    </a>
                    <a href="#" class="sidebar-link <%= "estadisticas".equals(activeSection) ? "active" : "" %>" data-section="estadisticas">
                        <i class="fa fa-bar-chart"></i> Estadísticas
                    </a>
                </div>
            </div>
            <!-- Área principal -->
            <div class="col-md-9">
                <!-- Sección Gestión de Usuarios (se mantiene intacta tal como la tenías) -->
                <div id="usuarios" class="section-content <%= "usuarios".equals(activeSection) ? "active" : "" %>">
                    <h4 style="color: #006299; margin-bottom: 30px;">Gestión de Usuarios</h4>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Correo</th>
                                    <th>Rol Actual</th>
                                    <th>Asignar Rol</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    PreparedStatement psUsuarios = null;
                                    ResultSet rsUsuarios = null;
                                    try {
                                        psUsuarios = conexion.prepareStatement(
                                            "SELECT id_usuario, nombre, correo, rol FROM usuarios ORDER BY fecha_registro DESC"
                                        );
                                        rsUsuarios = psUsuarios.executeQuery();
                                        while (rsUsuarios.next()) {
                                            int idUsuario = rsUsuarios.getInt("id_usuario");
                                            String rolActual = rsUsuarios.getString("rol");
                                %>
                                            <tr>
                                                <td><%= rsUsuarios.getString("nombre") %></td>
                                                <td><%= rsUsuarios.getString("correo") %></td>
                                                <td>
                                                    <span class="badge badge-<%=
                                                        "ADMIN".equals(rolActual) ? "danger" :
                                                        "INSTRUCTOR".equals(rolActual) ? "warning" : "success"
                                                    %>">
                                                        <%= rolActual %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <form action="cambiarRol.jsp" method="post" class="form-rol">
                                                        <input type="hidden" name="id_usuario" value="<%= idUsuario %>">
                                                        <select name="nuevo_rol" class="form-control form-control-sm d-inline" style="width: auto;">
                                                            <option value="ESTUDIANTE" <%= "ESTUDIANTE".equals(rolActual) ? "selected" : "" %>>Estudiante</option>
                                                            <option value="INSTRUCTOR" <%= "INSTRUCTOR".equals(rolActual) ? "selected" : "" %>>Instructor</option>
                                                            <option value="ADMIN" <%= "ADMIN".equals(rolActual) ? "selected" : "" %>>Admin</option>
                                                        </select>
                                                        <button type="submit" class="btn btn-primary btn-sm btn-accion">
                                                            Guardar
                                                        </button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <a href="#" class="btn btn-danger btn-sm btn-accion"
                                                       onclick="return confirm('¿Eliminar este usuario?')">
                                                        Eliminar
                                                    </a>
                                                </td>
                                            </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try { if (rsUsuarios != null) rsUsuarios.close(); } catch (Exception e) {}
                                        try { if (psUsuarios != null) psUsuarios.close(); } catch (Exception e) {}
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Sección Administrar Contenido Informativo -->
                <div id="contenido" class="section-content <%= "contenido".equals(activeSection) ? "active" : "" %>">
                    <h2 class="title">Administrar Contenido Informativo</h2>
                    <p class="lead">Edita las páginas estáticas de la plataforma (no pedagógicas).</p>
                    <div class="alert alert-info">
                        Sección en desarrollo. Próximamente: edición de Acerca de, Aviso de Privacidad, Nosotros, Horarios, etc.
                    </div>
                </div>

                <!-- Sección Estadísticas -->
                <div id="estadisticas" class="section-content <%= "estadisticas".equals(activeSection) ? "active" : "" %>">
                    <h2 class="title">Estadísticas</h2>
                    <p class="lead">Resumen general de la plataforma.</p>
                    <div class="alert alert-info">
                        Sección en desarrollo. Próximamente: contadores de usuarios, contenido creado y métricas de uso.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>

    <!-- JavaScript para cambiar secciones -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const links = document.querySelectorAll('.sidebar-link');
            const sections = document.querySelectorAll('.section-content');
            links.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const sectionId = this.getAttribute('data-section');
                    links.forEach(l => l.classList.remove('active'));
                    sections.forEach(s => s.classList.remove('active'));
                    this.classList.add('active');
                    document.getElementById(sectionId).classList.add('active');
                });
            });
        });
    </script>
</body>
</html>