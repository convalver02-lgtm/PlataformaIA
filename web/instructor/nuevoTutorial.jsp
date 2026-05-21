<%-- 
    Document   : newjsp
    Created on : 6/01/2026, 05:10:49 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>

<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");

    Integer idInstructorObj =
    (Integer) session.getAttribute("id_usuario");

    if (rol == null ||
       !"INSTRUCTOR".equalsIgnoreCase(rol) ||
        idInstructorObj == null) {

        response.sendRedirect("../index.jsp");
        return;
    }

    // CONSERVAR DATOS
    String titulo =
    request.getParameter("titulo") != null
    ? request.getParameter("titulo")
    : "";

    String descripcion =
    request.getParameter("descripcion") != null
    ? request.getParameter("descripcion")
    : "";

    String contenido =
    request.getParameter("contenido") != null
    ? request.getParameter("contenido")
    : "";

    String video_url =
    request.getParameter("video_url") != null
    ? request.getParameter("video_url")
    : "";

    String error =
    request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Crear Nuevo Tutorial - Plataforma IA</title>

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
            margin-top:10px;
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
                            <%= nombreUsuario != null
                                ? nombreUsuario
                                : "Instructor" %>
                        </strong>

                    </span>

                    <br>

                    <a href="../cerrarSesion.jsp"
                       class="primary-btn"
                       style="margin-top:10px;
                              padding:10px 25px;">

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

                <a href="casosUsoInstructor.jsp"
                   class="sidebar-link">

                    <i class="fa fa-lightbulb-o"></i>
                    Casos de Uso IA

                </a>

            </div>

        </div>

        <!-- FORM -->
        <div class="col-md-9">

            <h2 class="title">
                Crear Nuevo Tutorial
            </h2>

            <p class="lead mb-4">
                Comparte tu conocimiento con la comunidad
            </p>

            <!-- MENSAJES -->
            <% if(error != null){ %>

                <div class="alert alert-danger">

                    <% if("campos".equals(error)){ %>

                        Todos los campos obligatorios deben completarse.

                    <% } else if("longitud".equals(error)){ %>

                        Uno o más campos exceden el límite permitido.

                    <% } else if("xss".equals(error)){ %>

                        Se detectaron caracteres peligrosos.

                    <% } else if("url".equals(error)){ %>

                        El enlace del video no es válido.

                    <% } else { %>

                        Error al guardar tutorial.

                    <% } %>

                </div>

            <% } %>

            <div class="form-container">

                <form action="guardarTutorial.jsp"
                      method="post"
                      id="formTutorial">

                    <!-- TITULO -->
                    <div class="form-group">

                        <label for="titulo"
                               class="form-label">

                            Título del Tutorial
                            <span style="color:red;">*</span>

                        </label>

                        <input type="text"
                               name="titulo"
                               id="titulo"
                               class="form-control input"
                               required
                               maxlength="150"
                               minlength="5"
                               value="<%= titulo %>"
                               placeholder="Ej: Introducción a Machine Learning">

                        <small class="text-muted">
                            Máximo 150 caracteres
                        </small>

                    </div>

                    <!-- DESCRIPCION -->
                    <div class="form-group mt-4">

                        <label for="descripcion"
                               class="form-label">

                            Descripción corta
                            <span style="color:red;">*</span>

                        </label>

                        <textarea name="descripcion"
                                  id="descripcion"
                                  class="form-control input"
                                  rows="3"
                                  required
                                  maxlength="300"
                                  placeholder="Breve descripción del tutorial"><%= descripcion %></textarea>

                        <small class="text-muted">
                            Máximo 300 caracteres
                        </small>

                    </div>

                    <!-- NIVEL -->
                    <div class="form-group mt-4">

                        <label for="nivel"
                               class="form-label">

                            Nivel
                            <span style="color:red;">*</span>

                        </label>

                        <select name="nivel"
                                id="nivel"
                                class="form-control input"
                                required>

                            <option value="">
                                Selecciona un nivel
                            </option>

                            <option value="Principiante">
                                Principiante
                            </option>

                            <option value="Intermedio">
                                Intermedio
                            </option>

                            <option value="Avanzado">
                                Avanzado
                            </option>

                        </select>

                    </div>

                    <!-- CONTENIDO -->
                    <div class="form-group mt-4">

                        <label for="contenido"
                               class="form-label">

                            Contenido del Tutorial
                            <span style="color:red;">*</span>

                        </label>

                        <textarea name="contenido"
                                  id="contenido"
                                  class="form-control input"
                                  rows="10"
                                  required
                                  maxlength="5000"
                                  placeholder="Escribe aquí el contenido del tutorial..."><%= contenido %></textarea>

                        <small class="text-muted">
                            Máximo 5000 caracteres
                        </small>

                    </div>

                    <!-- VIDEO -->
                    <div class="form-group mt-4">

                        <label for="video_url"
                               class="form-label">

                            Enlace del Video
                            <small class="text-muted">
                                (opcional)
                            </small>

                        </label>

                        <input type="url"
                               name="video_url"
                               id="video_url"
                               class="form-control input"
                               maxlength="300"
                               value="<%= video_url %>"
                               placeholder="https://www.youtube.com/embed/...">

                        <small class="form-text text-muted">

                            Usa únicamente enlaces embed de YouTube.

                        </small>

                    </div>

                    <!-- MENSAJE XSS -->
                    <div id="mensajeXSS"
                         class="xss-error">

                        ⚠ Entrada potencialmente peligrosa detectada.

                    </div>

                    <!-- BOTONES -->
                    <div class="text-center mt-5">

                        <button type="submit"
                                class="btn btn-guardar">

                            Guardar Tutorial

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

document.addEventListener("DOMContentLoaded", function(){

    const formulario =
    document.getElementById("formTutorial");

    const campos = [
        document.getElementById("titulo"),
        document.getElementById("descripcion"),
        document.getElementById("contenido"),
        document.getElementById("video_url")
    ];

    const mensaje =
    document.getElementById("mensajeXSS");

    function validarXSS(valor){

        const patron =
        /<script>|<\/script>|<|>|javascript:|onerror=|onload=|alert\(|document\.cookie/gi;

        return patron.test(valor);
    }

    function mostrarError(campo){

        campo.classList.add("input-error");

        mensaje.style.display = "block";
    }

    function limpiarError(campo){

        campo.classList.remove("input-error");

        let existeError = false;

        campos.forEach(function(c){

            if(c && validarXSS(c.value)){
                existeError = true;
            }

        });

        if(!existeError){
            mensaje.style.display = "none";
        }
    }

    campos.forEach(function(campo){

        if(campo){

            campo.addEventListener(
            "keyup",
            function(){

                if(validarXSS(campo.value)){

                    mostrarError(campo);

                } else {

                    limpiarError(campo);
                }

            });

        }

    });

    // BLOQUEAR ENVÍO
    formulario.addEventListener(
    "submit",
    function(e){

        let peligro = false;

        campos.forEach(function(campo){

            if(campo &&
               validarXSS(campo.value)){

                mostrarError(campo);

                peligro = true;
            }

        });

        if(peligro){

            e.preventDefault();

            alert(
            "Se detectó una entrada potencialmente peligrosa."
            );
        }

    });

});

</script>

</body>
</html>