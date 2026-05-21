<%-- 
    Document   : validarLogin
    Created on : 6/01/2026, 04:30:54 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%@page import="java.sql.*"%>
<%@include file="conexion.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Procesando Login...</title>
</head>
<body>

<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    // Validación básica de parámetros
    if (correo == null || contrasena == null || correo.trim().isEmpty() || contrasena.trim().isEmpty()) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }

    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Verificar conexión
        if (conexion == null) {
            out.println("<h3>Error: No se pudo conectar a la base de datos.</h3>");
            out.println("<p><a href='login.jsp'>Volver al login</a></p>");
            return;
        }

        String sql = "SELECT id_usuario, nombre, rol FROM usuarios WHERE correo = ? AND contrasena = ?";
        ps = conexion.prepareStatement(sql);
        ps.setString(1, correo.trim());
        ps.setString(2, contrasena);

        rs = ps.executeQuery();

        if (rs.next()) {
            String nombre = rs.getString("nombre");
            String rol = rs.getString("rol");
            int idUsuario = rs.getInt("id_usuario");

            session.setAttribute("usuario", nombre);
            session.setAttribute("rol", rol);
            session.setAttribute("id_usuario", idUsuario);

            if ("ADMIN".equalsIgnoreCase(rol)) {
                response.sendRedirect("admin/panelAdmin.jsp");
            } else if ("INSTRUCTOR".equalsIgnoreCase(rol)) {
                response.sendRedirect("instructor/panelInstructor.jsp");
            } else if ("ESTUDIANTE".equalsIgnoreCase(rol)) {
                response.sendRedirect("alumno/panelAlumno.jsp");
            } else {
                response.sendRedirect("login.jsp?error=rol");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }

    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error al procesar el login:</h3>");
        out.println("<pre>");
        e.printStackTrace(response.getWriter());
        out.println("</pre>");
        out.println("<p><a href='login.jsp'>← Volver al login</a></p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    }
%>

</body>
</html>