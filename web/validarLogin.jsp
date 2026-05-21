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

    if(correo == null ||
       contrasena == null ||
       correo.trim().isEmpty() ||
       contrasena.trim().isEmpty()){

        response.sendRedirect(
        "login.jsp?error=campos");

        return;
    }

    correo = correo.trim();
    contrasena = contrasena.trim();

    try{

        // BUSCAR USUARIO SOLO POR CORREO
        String sql =
        "SELECT id_usuario, nombre, rol, contrasena " +
        "FROM usuarios WHERE correo=?";

        PreparedStatement ps =
        conexion.prepareStatement(sql);

        ps.setString(1, correo);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){

            String hashGuardado =
            rs.getString("contrasena");

            // VALIDAR PASSWORD BCRYPT
            if(BCrypt.checkpw(contrasena, hashGuardado)){

                session.setAttribute(
                "id_usuario",
                rs.getInt("id_usuario"));

                session.setAttribute(
                "usuario",
                rs.getString("nombre"));

                session.setAttribute(
                "rol",
                rs.getString("rol"));

                String rol =
                rs.getString("rol");

                if("ADMIN".equalsIgnoreCase(rol)){

                    response.sendRedirect(
                    "admin/panelAdmin.jsp");

                } else if("INSTRUCTOR".equalsIgnoreCase(rol)){

                    response.sendRedirect(
                    "instructor/panelInstructor.jsp");

                } else {

                    response.sendRedirect(
                    "alumno/panelAlumno.jsp");
                }

            } else {

                response.sendRedirect(
                "login.jsp?error=1");
            }

        } else {

            response.sendRedirect(
            "login.jsp?error=1");
        }

        rs.close();
        ps.close();

    } catch(Exception e){

        out.println(e.getMessage());
    }
%>