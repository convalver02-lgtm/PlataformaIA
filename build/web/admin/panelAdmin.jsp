<%-- 
    Document   : panelAdmin
    Created on : 6/01/2026, 04:34:48 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    // =========================================
    // VALIDAR SESIÓN
    // =========================================
    String rol =
    (String) session.getAttribute("rol");

    String nombreUsuario =
    (String) session.getAttribute("usuario");

    Integer idAdminObj =
    (Integer) session.getAttribute("id_usuario");

    if(
        rol == null ||
        !"ADMIN".equalsIgnoreCase(rol) ||
        idAdminObj == null
    ){

        response.sendRedirect("../index.jsp");
        return;
    }

    int idAdmin = idAdminObj;

    // =========================================
    // MENSAJES
    // =========================================
    String msg =
    request.getParameter("msg");

    String activeSection =
    request.getParameter("section");

    if(
        activeSection == null ||
        activeSection.trim().isEmpty()
    ){

        activeSection = "usuarios";
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>
        Panel del Administrador - Plataforma IA
    </title>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="icon"
          type="image/png"
          href="../img/logoicono.png">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
          rel="stylesheet">

    <link rel="stylesheet"
          href="../css/bootstrap.min.css">

    <link rel="stylesheet"
          href="../css/font-awesome.min.css">

    <link rel="stylesheet"
          href="../css/style.css">

    <style>

        .dashboard-container{
            margin-top:50px;
            margin-bottom:150px;
        }

        .sidebar-dashboard{
            background:white;
            border-radius:12px;
            padding:20px 0;
            box-shadow:0 4px 16px rgba(0,0,0,0.1);
        }

        .sidebar-link{
            display:block;
            padding:16px 30px;
            font-size:16px;
            color:#333;
            border-bottom:1px solid #eee;
            transition:0.3s;
            cursor:pointer;
        }

        .sidebar-link:hover{
            background:#f1f3f5;
            color:#006299;
            text-decoration:none;
        }

        .sidebar-link.active{
            background:#006299;
            color:white;
            font-weight:bold;
        }

        .sidebar-link i{
            margin-right:12px;
            width:20px;
            text-align:center;
        }

        .section-content{
            display:none;
        }

        .section-content.active{
            display:block;
        }

        .card-admin{
            background:white;
            border-radius:16px;
            padding:30px;
            box-shadow:0 4px 16px rgba(0,0,0,0.08);
            margin-bottom:40px;
        }

        .form-rol{
            display:inline-block;
        }

        table th{
            background-color:#006299;
            color:white;
        }

        .btn-accion{
            margin:2px;
        }

        .badge{
            padding:8px 12px;
            font-size:13px;
        }

    </style>

</head>

<body>

<!-- HEADER -->
<header>

    <div id="header"
         style="background-color:#006299; color:white;">

        <div class="container">

            <div class="row align-items-center"
                 style="min-height:80px;">

                <div class="col-md-3">

                    <a href="../index.jsp">

                        <img src="../img/logo.png"
                             alt="Logo"
                             height="60">

                    </a>

                </div>

                <div class="col-md-6 text-center">

                    <h3 style="color:white; margin:0;">

                        Plataforma Educativa de Inteligencia Artificial

                    </h3>

                </div>

                <div class="col-md-3 text-right">

                    <span style="color:white; font-size:16px;">

                        <i class="fa fa-user-circle fa-lg"></i>

                        Administrador:
                        <strong>

                            <%= nombreUsuario != null
                                ? nombreUsuario
                                : "Admin" %>

                        </strong>

                    </span>

                    <br>

                    <a href="../cerrarSesion.jsp"
                       class="primary-btn"
                       style="margin-top:10px; padding:10px 25px;">

                        Cerrar Sesión

                    </a>

                </div>

            </div>

        </div>

    </div>

</header>

<!-- NAVIGATION -->
<nav id="navigation">

    <div class="container">

        <ul class="main-nav nav navbar-nav">

            <li class="active">
                <a href="panelAdmin.jsp">
                    Administración
                </a>
            </li>

            <li>
                <a href="../acercaDe.jsp">
                    Acerca de
                </a>
            </li>

        </ul>

    </div>

</nav>

<!-- MENSAJES -->
<div class="container mt-3">

<%
    if(msg != null){
%>

    <% if("rol_actualizado".equals(msg)){ %>

        <div class="alert alert-success">
            Rol actualizado correctamente.
        </div>

    <% } else if("usuario_eliminado".equals(msg)){ %>

        <div class="alert alert-success">
            Usuario eliminado correctamente.
        </div>

    <% } else if("no_autEliminar".equals(msg)){ %>

        <div class="alert alert-danger">
            No puedes eliminar tu propia cuenta.
        </div>

    <% } else if("id_invalido".equals(msg)){ %>

        <div class="alert alert-danger">
            ID inválido.
        </div>

    <% } else if("no_existe".equals(msg)){ %>

        <div class="alert alert-warning">
            El usuario ya no existe.
        </div>

    <% } else if("metodo_invalido".equals(msg)){ %>

        <div class="alert alert-danger">
            Método no permitido.
        </div>

    <% } else { %>

        <div class="alert alert-danger">
            Ocurrió un error.
        </div>

    <% } %>

<%
    }
%>

</div>

<!-- CONTENIDO -->
<div class="container dashboard-container">

    <div class="row">

        <!-- SIDEBAR -->
        <div class="col-md-3">

            <div class="sidebar-dashboard">

                <a href="#"
                   class="sidebar-link <%= "usuarios".equals(activeSection) ? "active" : "" %>"
                   data-section="usuarios">

                    <i class="fa fa-users"></i>

                    Gestión de Usuarios

                </a>

                <a href="#"
                   class="sidebar-link <%= "contenido".equals(activeSection) ? "active" : "" %>"
                   data-section="contenido">

                    <i class="fa fa-file-text-o"></i>

                    Administrar Contenido

                </a>

                <a href="#"
                   class="sidebar-link <%= "estadisticas".equals(activeSection) ? "active" : "" %>"
                   data-section="estadisticas">

                    <i class="fa fa-bar-chart"></i>

                    Estadísticas

                </a>

            </div>

        </div>

        <!-- CONTENIDO PRINCIPAL -->
        <div class="col-md-9">

            <!-- USUARIOS -->
            <div id="usuarios"
                 class="section-content <%= "usuarios".equals(activeSection) ? "active" : "" %>">

                <div class="card-admin">

                    <h4 style="color:#006299; margin-bottom:30px;">

                        Gestión de Usuarios

                    </h4>

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

    try{

        psUsuarios =
        conexion.prepareStatement(

        "SELECT id_usuario, nombre, correo, rol " +
        "FROM usuarios " +
        "ORDER BY fecha_registro DESC"

        );

        rsUsuarios =
        psUsuarios.executeQuery();

        while(rsUsuarios.next()){

            int idUsuario =
            rsUsuarios.getInt("id_usuario");

            String nombre =
            rsUsuarios.getString("nombre");

            String correo =
            rsUsuarios.getString("correo");

            String rolActual =
            rsUsuarios.getString("rol");
%>

                                <tr>

                                    <td>

                                        <%= nombre %>

                                        <% if(idUsuario == idAdmin){ %>

                                            <span class="badge badge-info">
                                                Tú
                                            </span>

                                        <% } %>

                                    </td>

                                    <td>
                                        <%= correo %>
                                    </td>

                                    <td>

                                        <span class="badge badge-<%=

                                            "ADMIN".equals(rolActual)
                                            ? "danger"

                                            : "INSTRUCTOR".equals(rolActual)
                                            ? "warning"

                                            : "success"

                                        %>">

                                            <%= rolActual %>

                                        </span>

                                    </td>

                                    <td>

                                        <form action="cambiarRol.jsp"
                                              method="post"
                                              class="form-rol">

                                            <input type="hidden"
                                                   name="id_usuario"
                                                   value="<%= idUsuario %>">

                                            <select name="nuevo_rol"
                                                    class="form-control form-control-sm d-inline"
                                                    style="width:auto;">

                                                <option value="ESTUDIANTE"
                                                <%= "ESTUDIANTE".equals(rolActual)
                                                ? "selected"
                                                : "" %>>

                                                    Estudiante

                                                </option>

                                                <option value="INSTRUCTOR"
                                                <%= "INSTRUCTOR".equals(rolActual)
                                                ? "selected"
                                                : "" %>>

                                                    Instructor

                                                </option>

                                                <option value="ADMIN"
                                                <%= "ADMIN".equals(rolActual)
                                                ? "selected"
                                                : "" %>>

                                                    Admin

                                                </option>

                                            </select>

                                            <button type="submit"
                                                    class="btn btn-primary btn-sm btn-accion">

                                                Guardar

                                            </button>

                                        </form>

                                    </td>

                                    <td>

<%
    if(idUsuario != idAdmin){
%>

                                        <form action="eliminarUsuario.jsp"
                                              method="post"
                                              style="display:inline;"
                                              onsubmit="return confirm('¿Seguro que deseas eliminar este usuario?');">

                                            <input type="hidden"
                                                   name="id_usuario"
                                                   value="<%= idUsuario %>">

                                            <button type="submit"
                                                    class="btn btn-danger btn-sm btn-accion">

                                                Eliminar

                                            </button>

                                        </form>

<%
    } else {
%>

                                        <button class="btn btn-secondary btn-sm"
                                                disabled>

                                            Protegido

                                        </button>

<%
    }
%>

                                    </td>

                                </tr>

<%
        }

    } catch(Exception e){

        out.println(

        "<tr>" +
        "<td colspan='5' class='text-danger'>" +
        "Error al cargar usuarios." +
        "</td>" +
        "</tr>"

        );

    } finally {

        try{
            if(rsUsuarios != null){
                rsUsuarios.close();
            }
        } catch(Exception e){}

        try{
            if(psUsuarios != null){
                psUsuarios.close();
            }
        } catch(Exception e){}
    }
%>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

            <!-- CONTENIDO -->
            <div id="contenido"
                 class="section-content <%= "contenido".equals(activeSection) ? "active" : "" %>">

                <div class="card-admin">

                    <h2 class="title">

                        Administrar Contenido

                    </h2>

                    <div class="alert alert-info">

                        Próximamente podrás editar:

                        <ul>

                            <li>Acerca de</li>
                            <li>Aviso de privacidad</li>
                            <li>Preguntas frecuentes</li>
                            <li>Políticas</li>

                        </ul>

                    </div>

                </div>

            </div>

            <!-- ESTADÍSTICAS -->
            <div id="estadisticas"
                 class="section-content <%= "estadisticas".equals(activeSection) ? "active" : "" %>">

                <div class="card-admin">

                    <h2 class="title">

                        Estadísticas de la Plataforma

                    </h2>

<%
    PreparedStatement psStats = null;
    ResultSet rsStats = null;

    int totalUsuarios = 0;
    int totalTutoriales = 0;
    int totalCasos = 0;

    try{

        psStats =
        conexion.prepareStatement(
        "SELECT COUNT(*) total FROM usuarios"
        );

        rsStats =
        psStats.executeQuery();

        if(rsStats.next()){

            totalUsuarios =
            rsStats.getInt("total");
        }

        rsStats.close();
        psStats.close();

        psStats =
        conexion.prepareStatement(
        "SELECT COUNT(*) total FROM tutoriales"
        );

        rsStats =
        psStats.executeQuery();

        if(rsStats.next()){

            totalTutoriales =
            rsStats.getInt("total");
        }

        rsStats.close();
        psStats.close();

        psStats =
        conexion.prepareStatement(
        "SELECT COUNT(*) total FROM casos_uso_ia"
        );

        rsStats =
        psStats.executeQuery();

        if(rsStats.next()){

            totalCasos =
            rsStats.getInt("total");
        }

    } catch(Exception e){

    } finally {

        try{
            if(rsStats != null){
                rsStats.close();
            }
        } catch(Exception e){}

        try{
            if(psStats != null){
                psStats.close();
            }
        } catch(Exception e){}
    }
%>

                    <div class="row text-center">

                        <div class="col-md-4">

                            <div class="alert alert-primary">

                                <h2>
                                    <%= totalUsuarios %>
                                </h2>

                                Usuarios

                            </div>

                        </div>

                        <div class="col-md-4">

                            <div class="alert alert-success">

                                <h2>
                                    <%= totalTutoriales %>
                                </h2>

                                Tutoriales

                            </div>

                        </div>

                        <div class="col-md-4">

                            <div class="alert alert-warning">

                                <h2>
                                    <%= totalCasos %>
                                </h2>

                                Casos IA

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

<%@include file="../includes/footer.jsp"%>

<!-- JS -->
<script>

document.addEventListener(
"DOMContentLoaded",
function(){

    const links =
    document.querySelectorAll(
    ".sidebar-link"
    );

    const sections =
    document.querySelectorAll(
    ".section-content"
    );

    links.forEach(function(link){

        link.addEventListener(
        "click",
        function(e){

            e.preventDefault();

            const sectionId =
            this.getAttribute(
            "data-section"
            );

            links.forEach(function(l){

                l.classList.remove(
                "active"
                );

            });

            sections.forEach(function(s){

                s.classList.remove(
                "active"
                );

            });

            this.classList.add(
            "active"
            );

            document.getElementById(
            sectionId
            ).classList.add(
            "active"
            );

        });

    });

});

</script>

</body>

</html>