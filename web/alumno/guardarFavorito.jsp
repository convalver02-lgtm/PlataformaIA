<%-- 
    Document   : guardarFavorito
    Created on : 6/01/2026, 10:24:50 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // Protección: solo estudiante logueado
    String rol = (String) session.getAttribute("rol");
    Integer idUsuarioObj = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"ESTUDIANTE".equalsIgnoreCase(rol) || idUsuarioObj == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    int idUsuario = idUsuarioObj.intValue();

    // Obtener el id del tutorial
    String idTutorialStr = request.getParameter("id");
    if (idTutorialStr == null || idTutorialStr.trim().isEmpty()) {
        response.sendRedirect("panelAlumno.jsp");
        return;
    }
    int idTutorial;
    try {
        idTutorial = Integer.parseInt(idTutorialStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("panelAlumno.jsp");
        return;
    }

    // Obtener la página de origen (para redirigir de vuelta)
    String referer = request.getHeader("Referer");
    if (referer == null || referer.isEmpty()) {
        referer = "panelAlumno.jsp";
    }

    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        // Verificar si ya está en favoritos
        ps = conexion.prepareStatement(
            "SELECT id_favorito FROM favoritos WHERE id_usuario = ? AND id_tutorial = ?"
        );
        ps.setInt(1, idUsuario);
        ps.setInt(2, idTutorial);
        rs = ps.executeQuery();

        if (rs.next()) {
            // Ya está en favoritos → QUITAR
            ps.close();
            ps = conexion.prepareStatement(
                "DELETE FROM favoritos WHERE id_usuario = ? AND id_tutorial = ?"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTutorial);
            ps.executeUpdate();
        } else {
            // No está → AGREGAR
            ps.close();
            ps = conexion.prepareStatement(
                "INSERT INTO favoritos (id_usuario, id_tutorial, fecha_guardado) VALUES (?, ?, CURRENT_TIMESTAMP)"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idTutorial);
            ps.executeUpdate();
        }
    } catch (Exception e) {
        // En caso de error, redirigir sin hacer nada (o puedes mostrar mensaje)
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
    }

    // Redirigir a la página de origen
    response.sendRedirect(referer);
%>