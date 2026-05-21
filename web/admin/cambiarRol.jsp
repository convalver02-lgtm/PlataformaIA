<%-- 
    Document   : cambiarRol
    Created on : 8/01/2026, 01:59:54 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // Protección: solo admin
    if (!"ADMIN".equalsIgnoreCase((String) session.getAttribute("rol"))) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String idUsuarioStr = request.getParameter("id_usuario");
    String nuevoRol = request.getParameter("nuevo_rol");

    if (idUsuarioStr != null && nuevoRol != null) {
        try {
            int idUsuario = Integer.parseInt(idUsuarioStr);
            PreparedStatement ps = conexion.prepareStatement(
                "UPDATE usuarios SET rol = ? WHERE id_usuario = ?"
            );
            ps.setString(1, nuevoRol.toUpperCase());
            ps.setInt(2, idUsuario);
            int filas = ps.executeUpdate();
            ps.close();

            // Redirige de vuelta al panel con mensaje
            response.sendRedirect("panelAdmin.jsp?msg=" + (filas > 0 ? "rol_actualizado" : "error"));
        } catch (Exception e) {
            response.sendRedirect("panelAdmin.jsp?msg=error");
        }
    } else {
        response.sendRedirect("panelAdmin.jsp");
    }
%>
