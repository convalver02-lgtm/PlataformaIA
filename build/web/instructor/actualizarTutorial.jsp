<%-- 
    Document   : actualizarTutorial
    Created on : 6/01/2026, 05:20:15 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String rol = (String) session.getAttribute("rol");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String idTutorialStr = request.getParameter("id_tutorial");
    String titulo = request.getParameter("titulo");
    String descripcion = request.getParameter("descripcion");
    String nivel = request.getParameter("nivel");
    String contenido = request.getParameter("contenido");
    String video_url = request.getParameter("video_url");

    if (idTutorialStr != null && titulo != null && descripcion != null && nivel != null && contenido != null) {
        try {
            int idTutorial = Integer.parseInt(idTutorialStr);

            PreparedStatement ps = conexion.prepareStatement(
                "UPDATE tutoriales SET titulo = ?, descripcion = ?, nivel = ?, contenido = ?, video_url = ? " +
                "WHERE id_tutorial = ? AND id_instructor = ?"
            );
            ps.setString(1, titulo.trim());
            ps.setString(2, descripcion.trim());
            ps.setString(3, nivel);
            ps.setString(4, contenido.trim());
            if (video_url != null && !video_url.trim().isEmpty()) {
                ps.setString(5, video_url.trim());
            } else {
                ps.setNull(5, java.sql.Types.VARCHAR);
            }
            ps.setInt(6, idTutorial);
            ps.setInt(7, idInstructor);
            int filas = ps.executeUpdate();
            ps.close();

            response.sendRedirect("panelInstructor.jsp?msg=" + (filas > 0 ? "actualizado" : "error"));
        } catch (Exception e) {
            response.sendRedirect("panelInstructor.jsp?msg=error");
        }
    } else {
        response.sendRedirect("panelInstructor.jsp");
    }
%>
