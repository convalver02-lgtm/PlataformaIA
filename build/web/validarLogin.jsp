<%-- 
    Document   : validarLogin
    Created on : 6/01/2026, 04:30:54 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>

<%@page import="java.sql.*"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>

<%@include file="conexion.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    // VALIDAR NULOS
    if(correo == null ||
       contrasena == null){

        response.sendRedirect(
        "login.jsp?error=campos");

        return;
    }

    // LIMPIAR ESPACIOS
    correo = correo.trim();
    contrasena = contrasena.trim();

    // VALIDAR VACÍOS
    if(correo.isEmpty() ||
       contrasena.isEmpty()){

        response.sendRedirect(
        "login.jsp?error=campos");

        return;
    }

    // VALIDAR LONGITUD
    if(correo.length() > 100 ||
       contrasena.length() > 100){

        response.sendRedirect(
        "login.jsp?error=longitud");

        return;
    }

    // VALIDACIÓN XSS BÁSICA
    if(correo.contains("<script>") ||
       correo.contains("</script>") ||
       correo.contains("<") ||
       correo.contains(">") ||
       correo.contains("'") ||
       correo.contains("\"")){

        response.sendRedirect(
        "login.jsp?error=xss");

        return;
    }

    PreparedStatement ps = null;
    ResultSet rs = null;

    try{

        // VALIDAR CONEXIÓN
        if(conexion == null){

            response.sendRedirect(
            "login.jsp?error=conexion");

            return;
        }

        // BUSCAR USUARIO
        String sql =
        "SELECT id_usuario, nombre, rol, contrasena " +
        "FROM usuarios WHERE correo=?";

        ps = conexion.prepareStatement(sql);

        ps.setString(1, correo);

        rs = ps.executeQuery();

        // VALIDAR EXISTENCIA
        if(rs.next()){

            String hashGuardado =
            rs.getString("contrasena");

            // VALIDAR HASH BCRYPT
            if(BCrypt.checkpw(contrasena, hashGuardado)){

                // CREAR SESIÓN
                session.setAttribute(
                "id_usuario",
                rs.getInt("id_usuario"));

                session.setAttribute(
                "usuario",
                rs.getString("nombre"));

                session.setAttribute(
                "rol",
                rs.getString("rol"));

                // REDIRECCIONES
                String rol =
                rs.getString("rol");

                if("ADMIN".equalsIgnoreCase(rol)){

                    response.sendRedirect(
                    "admin/panelAdmin.jsp");

                } else if("INSTRUCTOR".equalsIgnoreCase(rol)){

                    response.sendRedirect(
                    "instructor/panelInstructor.jsp");

                } else if("ESTUDIANTE".equalsIgnoreCase(rol)){

                    response.sendRedirect(
                    "alumno/panelAlumno.jsp");

                } else {

                    response.sendRedirect(
                    "login.jsp?error=rol");
                }

            } else {

                // PASSWORD INCORRECTO
                response.sendRedirect(
                "login.jsp?error=1&correo=" +
                java.net.URLEncoder.encode(correo, "UTF-8"));
            }

        } else {

            // USUARIO NO EXISTE
            response.sendRedirect(
            "login.jsp?error=1&correo=" +
            java.net.URLEncoder.encode(correo, "UTF-8"));
        }

    } catch(Exception e){

        // ERROR GENERAL
        response.sendRedirect(
        "login.jsp?error=general");

    } finally{

        // CERRAR RECURSOS
        try{
            if(rs != null){
                rs.close();
            }
        } catch(Exception ex){}

        try{
            if(ps != null){
                ps.close();
            }
        } catch(Exception ex){}
    }
%>