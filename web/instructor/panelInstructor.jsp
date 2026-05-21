<%-- 
    Document   : panel Instructor
    Created on : 6/01/2026, 04:32:14 AM
    Author     : 16003
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    int idInstructor = 0;
    if (session.getAttribute("id_usuario") != null) {
        idInstructor = (Integer) session.getAttribute("id_usuario");
    }
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Instructor - Plataforma IA</title>
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
        .section-content { display: none; }
        .section-content.active { display: block; }
        .btn-crear {
            background-color: #006299;
            color: white;
            font-size: 18px;
            padding: 15px 30px;
            border-radius: 40px;
            margin-bottom: 40px;
        }
        table th { background-color: #006299; color: white; }
        .btn-accion { margin: 0 5px; }
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
                <li class="active"><a href="panelInstructor.jsp">Mis Tutorías</a></li>
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
                    ¡<%= msg.equals("creado") ? "Caso/Tutorial/Concepto creado" : 
                        msg.equals("actualizado") ? "Caso/Tutorial/Concepto actualizado" : 
                        "Caso/Tutorial/Concepto eliminado" %> correctamente!
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
            <!-- Sidebar izquierdo -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="#" class="sidebar-link active" data-section="tutoriales">
                        <i class="fa fa-chalkboard-teacher"></i> Tutorías
                    </a>
                    <a href="#" class="sidebar-link" data-section="casos">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                    <a href="#" class="sidebar-link" data-section="diccionario">
                        <i class="fa fa-book"></i> Diccionario IA
                    </a>
                </div>
            </div>

            <!-- Área principal -->
            <div class="col-md-9">
                <!-- Sección Tutorías -->
                <div id="tutoriales" class="section-content active">
                    <h2 class="title">Panel del Instructor</h2>
                    <div class="text-center">
                        <a href="nuevoTutorial.jsp" class="btn btn-crear">
                            <i class="fa fa-plus-circle fa-lg"></i> Crear Tutorial
                        </a>
                    </div>
                    <h4 style="color: #006299; margin-top: 40px;">Mis Tutoriales</h4>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>Título</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Tu código actual de tutoriales -->
                                <%
                                    PreparedStatement psTut = null;
                                    ResultSet rsTut = null;
                                    try {
                                        psTut = conexion.prepareStatement(
                                            "SELECT id_tutorial, titulo FROM tutoriales WHERE id_instructor = ? ORDER BY fecha_creacion DESC"
                                        );
                                        psTut.setInt(1, idInstructor);
                                        rsTut = psTut.executeQuery();
                                        if (!rsTut.isBeforeFirst()) {
                                %>
                                            <tr>
                                                <td colspan="2" class="text-center">
                                                    <em>No has creado tutoriales aún.</em>
                                                </td>
                                            </tr>
                                <%
                                        } else {
                                            while (rsTut.next()) {
                                %>
                                                <tr>
                                                    <td><strong><%= rsTut.getString("titulo") %></strong></td>
                                                    <td>
                                                        <a href="verTutorialInstructor.jsp?id=<%= rsTut.getInt("id_tutorial") %>" class="btn btn-primary btn-sm btn-accion">Ver</a>
                                                        <a href="editarTutorial.jsp?id=<%= rsTut.getInt("id_tutorial") %>" class="btn btn-info btn-sm btn-accion">Editar</a>
                                                        <a href="eliminarTutorial.jsp?id=<%= rsTut.getInt("id_tutorial") %>" 
                                                           class="btn btn-danger btn-sm btn-accion"
                                                           onclick="return confirm('¿Seguro que deseas eliminar este tutorial?')">Eliminar</a>
                                                    </td>
                                                </tr>
                                <%
                                            }
                                        }
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='2' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try { if (rsTut != null) rsTut.close(); } catch (Exception e) {}
                                        try { if (psTut != null) psTut.close(); } catch (Exception e) {}
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Sección Casos de Uso -->
                <div id="casos" class="section-content">
                    <h2 class="title">Gestionar Casos de Uso y Estrategias IA</h2>
                    <div class="text-right mb-3">
                        <a href="nuevoCasoUso.jsp" class="btn primary-btn">Añadir Caso de Uso</a>
                    </div>
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
                                <!-- Tu código actual de casos -->
                                <%
                                    PreparedStatement psCaso = null;
                                    ResultSet rsCaso = null;
                                    try {
                                        psCaso = conexion.prepareStatement(
                                            "SELECT id_caso, titulo, fecha_creacion FROM casos_uso_ia WHERE id_instructor = ? ORDER BY fecha_creacion DESC"
                                        );
                                        psCaso.setInt(1, idInstructor);
                                        rsCaso = psCaso.executeQuery();
                                        if (!rsCaso.isBeforeFirst()) {
                                %>
                                            <tr>
                                                <td colspan="3" class="text-center">
                                                    <em>No has creado casos de uso aún.</em>
                                                </td>
                                            </tr>
                                <%
                                        } else {
                                            while (rsCaso.next()) {
                                %>
                                                <tr>
                                                    <td><strong><%= rsCaso.getString("titulo") %></strong></td>
                                                    <td><%= rsCaso.getTimestamp("fecha_creacion") %></td>
                                                    <td>
                                                        <a href="verCasoInstructor.jsp?id=<%= rsCaso.getInt("id_caso") %>" class="btn btn-primary btn-sm btn-accion">Ver</a>
                                                        <a href="editarCasoUso.jsp?id=<%= rsCaso.getInt("id_caso") %>" class="btn btn-info btn-sm btn-accion">Editar</a>
                                                        <a href="eliminarCasoUso.jsp?id=<%= rsCaso.getInt("id_caso") %>" class="btn btn-danger btn-sm btn-accion" onclick="return confirm('¿Seguro?')">Eliminar</a>
                                                    </td>
                                                </tr>
                                <%
                                            }
                                        }
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='3' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try { if (rsCaso != null) rsCaso.close(); } catch (Exception e) {}
                                        try { if (psCaso != null) psCaso.close(); } catch (Exception e) {}
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Nueva sección Diccionario IA -->
                <div id="diccionario" class="section-content">
                    <h2 class="title">Gestión de Diccionario IA</h2>
                    <div class="text-center mb-4">
                        <a href="nuevoConcepto.jsp" class="btn btn-crear">
                            <i class="fa fa-plus-circle fa-lg"></i> Añadir Concepto
                        </a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>Término</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    PreparedStatement psDic = null;
                                    ResultSet rsDic = null;
                                    try {
                                        psDic = conexion.prepareStatement(
                                            "SELECT id_termino, termino FROM diccionario_ia ORDER BY termino ASC"
                                        );
                                        rsDic = psDic.executeQuery();
                                        if (!rsDic.isBeforeFirst()) {
                                %>
                                            <tr>
                                                <td colspan="2" class="text-center">
                                                    <em>No hay conceptos en el diccionario aún.</em>
                                                </td>
                                            </tr>
                                <%
                                        } else {
                                            while (rsDic.next()) {
                                %>
                                                <tr>
                                                    <td><strong><%= rsDic.getString("termino") %></strong></td>
                                                    <td>
                                                        <a href="verConceptoInstructor.jsp?id=<%= rsDic.getInt("id_termino") %>" class="btn btn-primary btn-sm btn-accion">Ver</a>
                                                        <a href="editarConcepto.jsp?id=<%= rsDic.getInt("id_termino") %>" class="btn btn-info btn-sm btn-accion">Editar</a>
                                                        <a href="eliminarConcepto.jsp?id=<%= rsDic.getInt("id_termino") %>" class="btn btn-danger btn-sm btn-accion" onclick="return confirm('¿Seguro que deseas eliminar este concepto?')">Eliminar</a>
                                                    </td>
                                                </tr>
                                <%
                                            }
                                        }
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='2' class='text-danger'>Error al cargar conceptos: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try { if (rsDic != null) rsDic.close(); } catch (Exception e) {}
                                        try { if (psDic != null) psDic.close(); } catch (Exception e) {}
                                    }
                                %>
                            </tbody>
                        </table>
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