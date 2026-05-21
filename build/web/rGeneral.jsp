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

    // CONSERVAR DATOS
    String nombre = request.getParameter("nombre") != null
            ? request.getParameter("nombre")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
            : "";

    String correo = request.getParameter("correo") != null
            ? request.getParameter("correo")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
            : "";
%>

<!DOCTYPE html>
<html>

<head>

    <title>Registrarme - Plataforma IA</title>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="icon"
          type="image/png"
          href="img/logoicono.png">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
          rel="stylesheet">

    <link rel="stylesheet"
          href="css/bootstrap.min.css">

    <link rel="stylesheet"
          href="css/font-awesome.min.css">

    <link rel="stylesheet"
          href="css/style.css">

    <style>

        body{
            background: linear-gradient(to bottom right,
            #f8f9fa,
            #e9ecef);

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

        .contador{

            font-size:12px;

            color:#777;

            margin-top:5px;
        }

        .password-ok{

            color:green;

            font-size:13px;
        }

        .password-error{

            color:red;

            font-size:13px;
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

            <!-- ENCABEZADO -->
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

            <!-- FORMULARIO -->
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
                           autocomplete="off"
                           value="<%= nombre %>"
                           placeholder="Ejemplo: Juan Pérez">

                    <div id="contadorNombre"
                         class="contador">

                        0 / 100 caracteres

                    </div>

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
                           autocomplete="off"
                           value="<%= correo %>"
                           placeholder="usuario@correo.com">

                    <div id="contadorCorreo"
                         class="contador">

                        0 / 100 caracteres

                    </div>

                </div>

                <!-- XSS -->
                <div id="mensajeXSS"
                     class="xss-error">

                    ⚠ Entrada potencialmente peligrosa detectada.

                </div>

                <!-- PASSWORD -->
                <div class="form-group">

                    <label>

                        Contraseña
                        <span style="color:red;">*</span>

                    </label>

                    <input type="password"
                           name="contrasena"
                           id="contrasena"
                           class="form-control"
                           required
                           minlength="6"
                           maxlength="100"
                           autocomplete="new-password">

                    <small class="text-muted">

                        Debe contener:
                        mayúscula,
                        número
                        y carácter especial.

                    </small>

                    <div id="mensajePassword"></div>

                </div>

                <!-- CONFIRMAR -->
                <div class="form-group">

                    <label>

                        Confirmar contraseña
                        <span style="color:red;">*</span>

                    </label>

                    <input type="password"
                           name="confirmar"
                           id="confirmar"
                           class="form-control"
                           required
                           minlength="6"
                           maxlength="100"
                           autocomplete="new-password">

                    <div id="mensajeConfirmacion"></div>

                </div>

                <!-- BOTÓN -->
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

    const contrasena =
    document.getElementById("contrasena");

    const confirmar =
    document.getElementById("confirmar");

    const mensajeXSS =
    document.getElementById("mensajeXSS");

    const mensajePassword =
    document.getElementById("mensajePassword");

    const mensajeConfirmacion =
    document.getElementById("mensajeConfirmacion");

    const formulario =
    document.getElementById("formRegistro");

    // XSS
    function validarXSS(valor){

        const patron =
        /<script>|<\/script>|<|>|javascript:|onerror=|onload=/gi;

        return patron.test(valor);
    }

    // NOMBRE
    function validarNombre(valor){

        const patron =
        /^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$/;

        return patron.test(valor);
    }

    // PASSWORD SEGURA
    function validarPassword(password){

        const patron =
        /^(?=.*[A-Z])(?=.*[0-9])(?=.*[\W]).{6,}$/;

        return patron.test(password);
    }

    // CONTADORES
    nombre.addEventListener("input", function(){

        document.getElementById(
        "contadorNombre"
        ).innerHTML =
        nombre.value.length +
        " / 100 caracteres";

    });

    correo.addEventListener("input", function(){

        document.getElementById(
        "contadorCorreo"
        ).innerHTML =
        correo.value.length +
        " / 100 caracteres";

    });

    // VALIDACIÓN XSS
    function revisarXSS(campo){

        if(validarXSS(campo.value)){

            campo.classList.add("input-error");

            mensajeXSS.style.display = "block";

        } else {

            campo.classList.remove("input-error");

            if(
                !validarXSS(nombre.value) &&
                !validarXSS(correo.value)
            ){

                mensajeXSS.style.display = "none";
            }
        }
    }

    nombre.addEventListener("input", function(){

        revisarXSS(nombre);

        if(!validarNombre(nombre.value) &&
           nombre.value.length > 0){

            nombre.classList.add("input-error");

        }
    });

    correo.addEventListener("input", function(){

        revisarXSS(correo);
    });

    // PASSWORD FUERTE
    contrasena.addEventListener("input", function(){

        if(validarPassword(contrasena.value)){

            mensajePassword.innerHTML =
            "<span class='password-ok'>✓ Contraseña segura</span>";

            contrasena.classList.remove("input-error");

        } else {

            mensajePassword.innerHTML =
            "<span class='password-error'>Debe incluir mayúscula, número y carácter especial</span>";

            contrasena.classList.add("input-error");
        }

    });

    // CONFIRMAR PASSWORD
    confirmar.addEventListener("input", function(){

        if(contrasena.value === confirmar.value){

            mensajeConfirmacion.innerHTML =
            "<span class='password-ok'>✓ Las contraseñas coinciden</span>";

            confirmar.classList.remove("input-error");

        } else {

            mensajeConfirmacion.innerHTML =
            "<span class='password-error'>Las contraseñas no coinciden</span>";

            confirmar.classList.add("input-error");
        }

    });

    // VALIDAR ENVÍO
    formulario.addEventListener("submit", function(e){

        if(

            validarXSS(nombre.value) ||
            validarXSS(correo.value) ||

            !validarNombre(nombre.value) ||

            !validarPassword(contrasena.value) ||

            contrasena.value !== confirmar.value

        ){

            e.preventDefault();

            alert(
            "Corrige los campos marcados antes de continuar."
            );
        }

    });

});

</script>

</body>
</html>