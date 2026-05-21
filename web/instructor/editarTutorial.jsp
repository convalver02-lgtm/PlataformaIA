<%-- 
    Document   : editarTutorial
    Created on : 6/01/2026, 05:19:25 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    // VALIDAR SESIÓN
    String rol =
    (String) session.getAttribute("rol");

    String nombreUsuario =
    (String) session.getAttribute("usuario");

    Integer idInstructor =
    (Integer) session.getAttribute("id_usuario");

    if(rol == null ||
       idInstructor == null ||
       !"INSTRUCTOR".equalsIgnoreCase(rol)){

        response.sendRedirect("../index.jsp");
        return;
    }

    // OBTENER ID
    String idStr =
    request.getParameter("id");

    int idTutorial = 0;

    boolean valido = false;

    // VARIABLES
    String titulo = "";
    String descripcion = "";
    String nivel = "";
    String contenido = "";
    String video_url = "";

    // MENSAJES
    String error =
    request.getParameter("error");

    // VALIDAR ID
    if(idStr != null &&
       !idStr.trim().isEmpty()){

        try{

            idTutorial =
            Integer.parseInt(idStr);

            if(idTutorial <= 0){

                response.sendRedirect(
                "panelInstructor.jsp");

                return;
            }

            // CONSULTAR TUTORIAL
            PreparedStatement ps =
            conexion.prepareStatement(

            "SELECT titulo, descripcion, " +
            "nivel, contenido, video_url " +
            "FROM tutoriales " +
            "WHERE id_tutorial=? " +
            "AND id_instructor=?"

            );

            ps.setInt(1, idTutorial);
            ps.setInt(2, idInstructor);

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                valido = true;

                titulo =
                rs.getString("titulo") != null
                ? rs.getString("titulo")
                : "";

                descripcion =
                rs.getString("descripcion") != null
                ? rs.getString("descripcion")
                : "";

                nivel =
                rs.getString("nivel") != null
                ? rs.getString("nivel")
                : "";

                contenido =
                rs.getString("contenido") != null
                ? rs.getString("contenido")
                : "";

                video_url =
                rs.getString("video_url") != null
                ? rs.getString("video_url")
                : "";
            }

            rs.close();
            ps.close();

        } catch(Exception e){

            response.sendRedirect(
            "panelInstructor.jsp");

            return;
        }
    }

    // VALIDAR EXISTENCIA
    if(!valido){

        response.sendRedirect(
        "panelInstructor.jsp");

        return;
    }

    // ESCAPAR HTML
    titulo =
    titulo.replace("<", "&lt;")
           .replace(">", "&gt;")
           .replace("\"", "&quot;");

    descripcion =
    descripcion.replace("<", "&lt;")
               .replace(">", "&gt;");

    contenido =
    contenido.replace("<", "&lt;")
             .replace(">", "&gt;");

    video_url =
    video_url.replace("<", "&lt;")
             .replace(">", "&gt;");
%>

<!DOCTYPE html>
<html>

<head>

    <title>
        Editar Tutorial - Plataforma IA
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
            margin-top:80px;
            margin-bottom:120px;
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

        .form-container{
            background:white;
            padding:50px;
            border-radius:16px;
            box-shadow:0 6px 20px rgba(0,0,0,0.1);
        }

        .form-label{
            font-weight:bold;
            color:#006299;
        }

        textarea.form-control{
            resize:vertical;
            min-height:120px;
        }

        .btn-guardar{
            background-color:#006299;
            color:white;
            padding:12px 40px;
            font-size:18px;
            border-radius:40px;
        }

        .btn-guardar:hover{
            opacity:0.9;
            color:white;
        }

        .xss-error{
            color:red;
            font-weight:bold;
            margin-top:8px;
            display:none;
        }

        .input-error{
            border:2px solid red !important;
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

                        Bienvenido,
                        <strong>
                            <%= nombreUsuario %>
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

<!-- NAV -->
<nav id="navigation">

    <div class="container">

        <ul class="main-nav nav navbar-nav">

            <li>
                <a href="panelInstructor.jsp">
                    Mis Tutorías
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

    <% if(error != null){ %>

        <div class="alert alert-danger">

            <% if("campos".equals(error)){ %>

                Todos los campos son obligatorios.

            <% } else if("longitud".equals(error)){ %>

                Uno o más campos exceden el límite permitido.

            <% } else if("xss".equals(error)){ %>

                Entrada peligrosa detectada.

            <% } else { %>

                Error al actualizar tutorial.

            <% } %>

        </div>

    <% } %>

</div>

<!-- CONTENIDO -->
<div class="container dashboard-container">

    <div class="row">

        <!-- SIDEBAR -->
        <div class="col-md-3">

            <div class="sidebar-dashboard">

                <a href="panelInstructor.jsp"
                   class="sidebar-link active">

                    <i class="fa fa-chalkboard-teacher"></i>

                    Tutorías

                </a>

            </div>

        </div>

        <!-- FORM -->
        <div class="col-md-9">

            <h2 class="title">
                Editar Tutorial
            </h2>

            <p class="lead mb-4">
                Modifica tu tutorial
            </p>

            <div class="form-container">

                <form action="actualizarTutorial.jsp"
                      method="post"
                      id="formTutorial">

                    <input type="hidden"
                           name="id_tutorial"
                           value="<%= idTutorial %>">

                    <!-- TÍTULO -->
                    <div class="form-group">

                        <label class="form-label">
                            Título del Tutorial
                        </label>

                        <input type="text"
                               name="titulo"
                               id="titulo"
                               class="form-control"
                               required
                               maxlength="200"
                               minlength="5"
                               value="<%= titulo %>">

                    </div>

                    <!-- DESCRIPCIÓN -->
                    <div class="form-group mt-4">

                        <label class="form-label">
                            Descripción
                        </label>

                        <textarea name="descripcion"
                                  id="descripcion"
                                  class="form-control"
                                  rows="3"
                                  required
                                  maxlength="1000"><%= descripcion %></textarea>

                    </div>

                    <!-- NIVEL -->
                    <div class="form-group mt-4">

                        <label class="form-label">
                            Nivel
                        </label>

                        <select name="nivel"
                                class="form-control"
                                required>

                            <option value="Principiante"
                            <%= "Principiante".equals(nivel)
                            ? "selected"
                            : "" %>>

                                Principiante

                            </option>

                            <option value="Intermedio"
                            <%= "Intermedio".equals(nivel)
                            ? "selected"
                            : "" %>>

                                Intermedio

                            </option>

                            <option value="Avanzado"
                            <%= "Avanzado".equals(nivel)
                            ? "selected"
                            : "" %>>

                                Avanzado

                            </option>

                        </select>

                    </div>

                    <!-- CONTENIDO -->
                    <div class="form-group mt-4">

                        <label class="form-label">
                            Contenido
                        </label>

                        <textarea name="contenido"
                                  id="contenido"
                                  class="form-control"
                                  rows="10"
                                  required
                                  maxlength="10000"><%= contenido %></textarea>

                    </div>

                    <!-- VIDEO -->
                    <div class="form-group mt-4">

                        <label class="form-label">
                            Video YouTube
                        </label>

                        <input type="url"
                               name="video_url"
                               id="video_url"
                               class="form-control"
                               maxlength="500"
                               value="<%= video_url %>">

                    </div>

                    <!-- XSS -->
                    <div id="mensajeXSS"
                         class="xss-error">

                        ⚠ Entrada peligrosa detectada

                    </div>

                    <!-- BOTONES -->
                    <div class="text-center mt-5">

                        <button type="submit"
                                class="btn btn-guardar">

                            Actualizar Tutorial

                        </button>

                        <a href="panelInstructor.jsp"
                           class="btn btn-secondary ml-3">

                            Cancelar

                        </a>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

<%@include file="../includes/footer.jsp"%>

<script>

document.addEventListener(
"DOMContentLoaded",
function(){

    const campos = [

        document.getElementById("titulo"),
        document.getElementById("descripcion"),
        document.getElementById("contenido"),
        document.getElementById("video_url")

    ];

    const mensaje =
    document.getElementById("mensajeXSS");

    const formulario =
    document.getElementById("formTutorial");

    function validarXSS(valor){

        const patron =
        /<script>|<\/script>|<|>|javascript:|onerror=|onload=/gi;

        return patron.test(valor);
    }

    campos.forEach(function(campo){

        campo.addEventListener(
        "keyup",
        function(){

            if(validarXSS(campo.value)){

                campo.classList.add(
                "input-error");

                mensaje.style.display =
                "block";

            } else {

                campo.classList.remove(
                "input-error");

                let peligro = false;

                campos.forEach(function(c){

                    if(validarXSS(c.value)){
                        peligro = true;
                    }

                });

                if(!peligro){

                    mensaje.style.display =
                    "none";
                }
            }

        });

    });

    formulario.addEventListener(
    "submit",
    function(e){

        let peligro = false;

        campos.forEach(function(campo){

            if(validarXSS(campo.value)){

                peligro = true;

                campo.classList.add(
                "input-error");
            }

        });

        if(peligro){

            e.preventDefault();

            mensaje.style.display =
            "block";

            alert(
            "Entrada peligrosa detectada.");
        }

    });

});

</script>

</body>
</html>