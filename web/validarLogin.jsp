<%-- 
    Document   : validarLogin
    Created on : 6/01/2026, 04:30:54 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%@page import="java.sql.*"%>

<%@include file="conexion.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    // VALIDAR CAMPOS VACÍOS
    if(correo == null || contrasena == null ||
       correo.trim().isEmpty() ||
       contrasena.trim().isEmpty()){

        response.sendRedirect(
            "login.jsp?error=campos&correo=" + correo
        );
        return;
    }

    // VALIDAR LONGITUD
    if(correo.length() > 100 ||
       contrasena.length() > 100){

        response.sendRedirect(
            "login.jsp?error=longitud&correo=" + correo
        );
        return;
    }

    // PROTECCIÓN BÁSICA XSS
    correo = correo.replaceAll("<", "")
                   .replaceAll(">", "");

    try{

        String sql =
        "SELECT id_usuario, nombre, rol " +
        "FROM usuarios " +
        "WHERE correo=? AND contrasena=?";

        PreparedStatement ps =
        conexion.prepareStatement(sql);

        ps.setString(1, correo.trim());
        ps.setString(2, contrasena.trim());

        ResultSet rs = ps.executeQuery();

        if(rs.next()){

            session.setAttribute(
                "id_usuario",
                rs.getInt("id_usuario")
            );

            session.setAttribute(
                "usuario",
                rs.getString("nombre")
            );

            session.setAttribute(
                "rol",
                rs.getString("rol")
            );

            String rol = rs.getString("rol");

            if("ADMIN".equalsIgnoreCase(rol)){

                response.sendRedirect(
                    "admin/panelAdmin.jsp"
                );

            } else if("INSTRUCTOR".equalsIgnoreCase(rol)){

                response.sendRedirect(
                    "instructor/panelInstructor.jsp"
                );

            } else {

                response.sendRedirect(
                    "alumno/panelAlumno.jsp"
                );
            }

        } else {

            response.sendRedirect(
                "login.jsp?error=1&correo=" + correo
            );
        }

        rs.close();
        ps.close();

    } catch(Exception e){

        response.sendRedirect(
            "login.jsp?error=general"
        );
    }
%>