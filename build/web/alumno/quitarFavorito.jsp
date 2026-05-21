<%-- 
    Document   : quitarFavorito
    Created on : 8/01/2026, 02:42:32 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    if (!"ESTUDIANTE".equalsIgnoreCase((String) session.getAttribute("rol"))) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String idTutorialStr = request.getParameter("id");
    int idUsuario = (Integer) session.getAttribute("id_usuario");

    if (idTutorialStr != null) {
        try {
            int idTutorial = Integer.parseInt(idTutorialStr);
            PreparedStatement ps = conexion.prepareStatement(
                "DELETE FROM favoritos WHERE id_usuario = ? AND id_tutorial = ?"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTutorial);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            // Silencioso o redirigir con error
        }
    }
    response.sendRedirect("favoritos.jsp");
%>