<%-- 
    Document   : registrarUsuario
    Created on : 8/01/2026, 05:07:53 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    request.setCharacterEncoding("UTF-8"); // Para acentos en nombre

    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");
    String confirmar = request.getParameter("confirmar");

    if (nombre != null && correo != null && contrasena != null && confirmar != null) {
        if (!contrasena.equals(confirmar)) {
            response.sendRedirect("rGeneral.jsp?error=contrasenas");
            return;
        }

        try {
            // Verificar si el correo ya existe
            PreparedStatement psCheck = conexion.prepareStatement("SELECT id_usuario FROM usuarios WHERE correo = ?");
            psCheck.setString(1, correo.trim());
            ResultSet rsCheck = psCheck.executeQuery();
            if (rsCheck.next()) {
                response.sendRedirect("rGeneral.jsp?error=existe");
                return;
            }
            rsCheck.close();
            psCheck.close();

            // Insertar nuevo usuario como ESTUDIANTE por defecto
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO usuarios (nombre, correo, contrasena, rol) VALUES (?, ?, ?, 'ESTUDIANTE')"
            );
            ps.setString(1, nombre.trim());
            ps.setString(2, correo.trim());
            ps.setString(3, contrasena); // En producción deberías hashear la contraseña, pero por ahora simple
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("login.jsp?msg=registrado");
        } catch (Exception e) {
            response.sendRedirect("rGeneral.jsp?error=general");
        }
    } else {
        response.sendRedirect("rGeneral.jsp");
    }
%>
