<%-- 
    Document   : guardarConcepto
    Created on : 12/01/2026, 09:38:39 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    // ¡Línea mágica para que los acentos y la ñ se guarden correctamente!
    request.setCharacterEncoding("UTF-8");

    String rol = (String) session.getAttribute("rol");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Leer parámetros del formulario
    String termino = request.getParameter("termino");
    String definicion = request.getParameter("definicion");

    // Validación básica
    if (termino != null && !termino.trim().isEmpty() && 
        definicion != null && !definicion.trim().isEmpty()) {
        try {
            PreparedStatement ps = conexion.prepareStatement(
                "INSERT INTO diccionario_ia (termino, definicion) VALUES (?, ?)"
            );
            ps.setString(1, termino.trim());
            ps.setString(2, definicion.trim());
            ps.executeUpdate();
            ps.close();

            // Redirigir a la lista con mensaje de éxito
            response.sendRedirect("diccionarioInstructor.jsp?msg=creado");
        } catch (Exception e) {
            e.printStackTrace();
            // Si hay error, redirigir al formulario con mensaje de error
            response.sendRedirect("nuevoConcepto.jsp?error=1");
        }
    } else {
        // Si faltan campos, redirigir al formulario con mensaje de campos requeridos
        response.sendRedirect("nuevoConcepto.jsp?error=campos");
    }
%>
