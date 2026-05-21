<%-- 
    Document   : registrarUsuario
    Created on : 8/01/2026, 05:07:53 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>

<%@include file="conexion.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");
    String confirmar = request.getParameter("confirmar");

    // VALIDAR NULOS
    if(nombre == null ||
       correo == null ||
       contrasena == null ||
       confirmar == null){

        response.sendRedirect(
        "rGeneral.jsp?error=campos");

        return;
    }

    // LIMPIAR ESPACIOS
    nombre = nombre.trim();
    correo = correo.trim().toLowerCase();
    contrasena = contrasena.trim();
    confirmar = confirmar.trim();

    // VALIDAR VACÍOS
    if(nombre.isEmpty() ||
       correo.isEmpty() ||
       contrasena.isEmpty() ||
       confirmar.isEmpty()){

        response.sendRedirect(
        "rGeneral.jsp?error=campos");

        return;
    }

    // VALIDAR LONGITUD
    if(nombre.length() > 100 ||
       correo.length() > 100 ||
       contrasena.length() > 100){

        response.sendRedirect(
        "rGeneral.jsp?error=longitud");

        return;
    }

    // VALIDAR LONGITUD MÍNIMA
    if(nombre.length() < 3 ||
       contrasena.length() < 6){

        response.sendRedirect(
        "rGeneral.jsp?error=minimo");

        return;
    }

    // VALIDAR FORMATO CORREO
    if(!correo.matches(
       "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")){

        response.sendRedirect(
        "rGeneral.jsp?error=correo");

        return;
    }

    // PROTECCIÓN XSS
    String patronXSS =
    "(<script>|</script>|<|>|javascript:|onerror=|onload=|alert\\()";

    if(nombre.matches("(?i).*" + patronXSS + ".*") ||
       correo.matches("(?i).*" + patronXSS + ".*")){

        response.sendRedirect(
        "rGeneral.jsp?error=xss");

        return;
    }

    // VALIDAR CONTRASEÑAS
    if(!contrasena.equals(confirmar)){

        response.sendRedirect(
        "rGeneral.jsp?error=contrasenas");

        return;
    }

    // VALIDAR FUERZA DE CONTRASEÑA
    boolean tieneMayuscula =
    contrasena.matches(".*[A-Z].*");

    boolean tieneNumero =
    contrasena.matches(".*[0-9].*");

    if(!tieneMayuscula || !tieneNumero){

        response.sendRedirect(
        "rGeneral.jsp?error=passwordsegura");

        return;
    }

    PreparedStatement psCheck = null;
    PreparedStatement ps = null;
    ResultSet rsCheck = null;

    try{

        // VERIFICAR EXISTENCIA DE CORREO
        psCheck =
        conexion.prepareStatement(
        "SELECT id_usuario FROM usuarios WHERE correo=?");

        psCheck.setString(1, correo);

        rsCheck = psCheck.executeQuery();

        if(rsCheck.next()){

            response.sendRedirect(
            "rGeneral.jsp?error=existe");

            return;
        }

        // GENERAR HASH BCRYPT
        String passwordHash =
        BCrypt.hashpw(
        contrasena,
        BCrypt.gensalt(12));

        // INSERTAR USUARIO
        ps =
        conexion.prepareStatement(
        "INSERT INTO usuarios " +
        "(nombre, correo, contrasena, rol) " +
        "VALUES (?, ?, ?, 'ESTUDIANTE')"
        );

        ps.setString(1, nombre);
        ps.setString(2, correo);
        ps.setString(3, passwordHash);

        int filas =
        ps.executeUpdate();

        if(filas > 0){

            response.sendRedirect(
            "login.jsp?msg=registrado");

        } else {

            response.sendRedirect(
            "rGeneral.jsp?error=general");
        }

    } catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
        "rGeneral.jsp?error=general");

    } finally {

        try{
            if(rsCheck != null){
                rsCheck.close();
            }
        } catch(Exception ex){}

        try{
            if(psCheck != null){
                psCheck.close();
            }
        } catch(Exception ex){}

        try{
            if(ps != null){
                ps.close();
            }
        } catch(Exception ex){}

        try{
            if(conexion != null){
                conexion.close();
            }
        } catch(Exception ex){}
    }
%>