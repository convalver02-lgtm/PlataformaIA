<%-- 
    Document   : guardarTutorial
    Created on : 6/01/2026, 05:18:35 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // === ESTA LÍNEA ES LA SOLUCIÓN MÁGICA PARA LOS ACENTOS ===
    request.setCharacterEncoding("UTF-8");

    String rol = (String) session.getAttribute("rol");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String titulo = request.getParameter("titulo");
    String descripcion = request.getParameter("descripcion");
    String nivel = request.getParameter("nivel");
    String contenido = request.getParameter("contenido");
    String video_url = request.getParameter("video_url");

    if (titulo != null && !titulo.trim().isEmpty() && descripcion != null && nivel != null && contenido != null) {
        try {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO tutoriales (titulo, descripcion, nivel, contenido, video_url, id_instructor) " +
                "VALUES (?, ?, ?, ?, ?, ?)"
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
            ps.setInt(6, idInstructor);
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("panelInstructor.jsp?msg=creado");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("nuevoTutorial.jsp?error=1");
        }
    } else {
        response.sendRedirect("nuevoTutorial.jsp?error=1");
    }
%>