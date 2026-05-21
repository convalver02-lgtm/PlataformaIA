<%-- 
    Document   : rGeneral
    Created on : 8/01/2026, 02:38:56 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>

<%
    String rol = (String) session.getAttribute("rol");

    if (rol != null) {

        if ("ESTUDIANTE".equalsIgnoreCase(rol)) {
            response.sendRedirect("alumno/panelAlumno.jsp");
        } else if ("INSTRUCTOR".equalsIgnoreCase(rol)) {
            response.sendRedirect("instructor/panelInstructor.jsp");
        } else if ("ADMIN".equalsIgnoreCase(rol)) {
            response.sendRedirect("admin/panelAdmin.jsp");
        }

        return;
    }

    String error = request.getParameter("error");
    String msg = request.getParameter("msg");

    String nombre = request.getParameter("nombre") != null
            ? request.getParameter("nombre")
            : "";

    String correo = request.getParameter("correo") != null
            ? request.getParameter("correo")
            : "";
%>

<!DOCTYPE html>
<html>
<head>

    <title>Registrarme - Plataforma IA</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="image/png" href="img/logoicono.png">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">

    <style>

        body{
            background: linear-gradient(to bottom right, #f8f9fa, #e9ecef);
            min-height:100vh;
            display:flex;
            flex-direction:column;
        }

        .main-content{
            flex:1;
        }

        .register-container{
            background:white;
            padding:50px;
            border-radius:20px;
            box-shadow:0 15px 40px rgba(0,0,0,0.15);
            max-width:500px;
            margin:60px auto;
        }

        .btn-register{
            background-color:#006299;
            color:white;
            padding:14px 50px;
            font-size:18px;
            border-radius:40px;
            width:100%;
        }

        .btn-register:hover{
            color:white;
            opacity:0.9;
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

<%@include file="includes/header.jsp"%>

<!-- MENSAJES -->
<div class="container">

    <% if(error != null){ %>

        <div class="alert alert-danger">

            <% if("campos".equals(error)){ %>
                Todos los campos son obligatorios.

            <% } else if("contrasenas".equals(error)){ %>
                Las contraseñas no coinciden.

            <% } else if("existe".equals(error)){ %>
                El correo ya está registrado.

            <% } else if("longitud".equals(error)){ %>
                Uno o más campos exceden el límite permitido.

            <% } else if("xss".equals(error)){ %>
                Caracteres peligrosos detectados.

            <% } else { %>
                Error al registrar usuario.

            <% } %>

        </div>

    <% } %>

    <% if("registrado".equals(msg)){ %>

        <div class="alert alert-success">
            Registro exitoso. Ya puedes iniciar sesión.
        </div>

    <% } %>

</div>

<div class="main-content">

    <div class="container">

        <div class="register-container">

            <div class="text-center">

                <img src="img/logo.png"
                     alt="Logo"
                     style="height:80px; margin-bottom:20px;">

                <h2 style="color:#006299;">
                    Crear mi cuenta
                </h2>

                <p>
                    Registro de estudiantes
                </p>

            </div>

            <!-- INFO -->
            <div class="alert alert-info text-center">

                Para registrarte como instructor,
                contacta al administrador del sistema.

            </div>

            <!-- FORM -->
            <form action="registrarUsuario.jsp"
                  method="post"
                  id="formRegistro">

                <!-- NOMBRE -->
                <div class="form-group">

                    <label>
                        Nombre completo
                        <span style="color:red;">*</span>
                    </label>

                    <input type="text"
                           name="nombre"
                           id="nombre"
                           class="form-control"
                           required
                           maxlength="100"
                           minlength="3"
                           value="<%= nombre %>"
                           placeholder="Ejemplo: Juan Pérez">

                </div>

                <!-- CORREO -->
                <div class="form-group">

                    <label>
                        Correo electrónico
                        <span style="color:red;">*</span>
                    </label>

                    <input type="email"
                           name="correo"
                           id="correo"
                           class="form-control"
                           required
                           maxlength="100"
                           value="<%= correo %>"
                           placeholder="usuario@correo.com">

                </div>

                <!-- MENSAJE XSS -->
                <div id="mensajeXSS" class="xss-error">
                    ⚠ Entrada potencialmente peligrosa detectada (XSS)
                </div>

                <!-- PASSWORD -->
                <div class="form-group">

                    <label>
                        Contraseña
                        <span style="color:red;">*</span>
                    </label>

                    <input type="password"
                           name="contrasena"
                           class="form-control"
                           required
                           minlength="6"
                           maxlength="100">

                    <small class="text-muted">
                        Mínimo 6 caracteres
                    </small>

                </div>

                <!-- CONFIRMAR -->
                <div class="form-group">

                    <label>
                        Confirmar contraseña
                        <span style="color:red;">*</span>
                    </label>

                    <input type="password"
                           name="confirmar"
                           class="form-control"
                           required
                           minlength="6"
                           maxlength="100">

                </div>

                <button type="submit"
                        class="btn btn-register">

                    Registrarme

                </button>

            </form>

        </div>

    </div>

</div>

<%@include file="includes/footer.jsp"%>

<script>

document.addEventListener("DOMContentLoaded", function(){

    const nombre =
    document.getElementById("nombre");

    const correo =
    document.getElementById("correo");

    const mensaje =
    document.getElementById("mensajeXSS");

    const formulario =
    document.getElementById("formRegistro");

    function validarXSS(valor){

        const patron =
        /<script>|<\/script>|<|>|javascript:|onerror=|onload=/gi;

        return patron.test(valor);
    }

    function mostrarError(campo){

        campo.classList.add("input-error");

        mensaje.style.display = "block";
    }

    function limpiarError(campo){

        campo.classList.remove("input-error");

        if(
            !validarXSS(nombre.value) &&
            !validarXSS(correo.value)
        ){
            mensaje.style.display = "none";
        }
    }

    nombre.addEventListener("keyup", function(){

        if(validarXSS(nombre.value)){

            mostrarError(nombre);

        } else {

            limpiarError(nombre);
        }
    });

    correo.addEventListener("keyup", function(){

        if(validarXSS(correo.value)){

            mostrarError(correo);

        } else {

            limpiarError(correo);
        }
    });

    // BLOQUEAR ENVÍO SI HAY XSS
    formulario.addEventListener("submit", function(e){

        if(
            validarXSS(nombre.value) ||
            validarXSS(correo.value)
        ){

            e.preventDefault();

            mensaje.style.display = "block";

            alert("Entrada peligrosa detectada.");

        }

    });

});

</script>

</body>
</html>