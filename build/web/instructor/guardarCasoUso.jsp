<%-- 
    Document   : guardarCasoUso
    Created on : 11/01/2026, 11:33:50 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // ¡La línea mágica DEBE ir ANTES de cualquier request.getParameter!
    request.setCharacterEncoding("UTF-8");

    String rol = (String) session.getAttribute("rol");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Ahora sí leemos los parámetros (ya en UTF-8)
    String titulo = request.getParameter("titulo");
    String problema = request.getParameter("problema");
    String solucion = request.getParameter("solucion");
    String explicacion = request.getParameter("explicacion_tecnica");
    String pobre = request.getParameter("resultado_pobre");
    String optimizado = request.getParameter("resultado_optimizado");

    if (titulo != null && !titulo.trim().isEmpty() &&
        problema != null && !problema.trim().isEmpty() &&
        solucion != null && !solucion.trim().isEmpty() &&
        explicacion != null && !explicacion.trim().isEmpty()) {
        try {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO casos_uso_ia (titulo, problema, solucion, explicacion_tecnica, resultado_pobre, resultado_optimizado, id_instructor) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, titulo.trim());
            ps.setString(2, problema.trim());
            ps.setString(3, solucion.trim());
            ps.setString(4, explicacion.trim());
            ps.setString(5, pobre != null && !pobre.trim().isEmpty() ? pobre.trim() : null);
            ps.setString(6, optimizado != null && !optimizado.trim().isEmpty() ? optimizado.trim() : null);
            ps.setInt(7, idInstructor);
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("casosUsoInstructor.jsp?msg=creado");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("nuevoCasoUso.jsp?error=1");
        }
    } else {
        response.sendRedirect("nuevoCasoUso.jsp?error=campos");
    }
%>