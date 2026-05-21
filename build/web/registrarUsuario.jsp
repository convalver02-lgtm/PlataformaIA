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
    correo = correo.trim();
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

    // PROTECCIÓN BÁSICA XSS
    if(nombre.contains("<") ||
       nombre.contains(">") ||
       correo.contains("<") ||
       correo.contains(">")){

        response.sendRedirect(
        "rGeneral.jsp?error=xss");

        return;
    }

    // VALIDAR PASSWORDS
    if(!contrasena.equals(confirmar)){

        response.sendRedirect(
        "rGeneral.jsp?error=contrasenas");

        return;
    }

    try{

        // VALIDAR EXISTENCIA
        PreparedStatement psCheck =
        conexion.prepareStatement(
        "SELECT id_usuario FROM usuarios WHERE correo=?");

        psCheck.setString(1, correo);

        ResultSet rsCheck =
        psCheck.executeQuery();

        if(rsCheck.next()){

            response.sendRedirect(
            "rGeneral.jsp?error=existe");

            return;
        }

        rsCheck.close();
        psCheck.close();

        // INSERTAR
        PreparedStatement ps =
        conexion.prepareStatement(
        "INSERT INTO usuarios(nombre, correo, contrasena, rol) " +
        "VALUES(?, ?, ?, 'ESTUDIANTE')"
        );

        ps.setString(1, nombre);
        ps.setString(2, correo);

        // BCRYPT
        
        String passwordHash =
        BCrypt.hashpw(contrasena, BCrypt.gensalt());

        ps.setString(3, passwordHash);

        ps.executeUpdate();

        ps.close();

        response.sendRedirect(
        "login.jsp?msg=registrado");

    } catch(Exception e){

        response.sendRedirect(
        "rGeneral.jsp?error=general");
    }
%>