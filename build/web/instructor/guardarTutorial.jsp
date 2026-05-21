<%-- 
    Document   : guardarTutorial
    Created on : 6/01/2026, 05:18:35 AM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    // VALIDAR SESIÓN
    String rol =
    (String) session.getAttribute("rol");

    Integer idInstructorObj =
    (Integer) session.getAttribute("id_usuario");

    if(rol == null ||
      !"INSTRUCTOR".equalsIgnoreCase(rol) ||
       idInstructorObj == null){

        response.sendRedirect("../index.jsp");
        return;
    }

    int idInstructor =
    idInstructorObj;

    // RECIBIR DATOS
    String titulo =
    request.getParameter("titulo");

    String descripcion =
    request.getParameter("descripcion");

    String nivel =
    request.getParameter("nivel");

    String contenido =
    request.getParameter("contenido");

    String video_url =
    request.getParameter("video_url");

    // VALIDAR NULOS
    if(titulo == null ||
       descripcion == null ||
       nivel == null ||
       contenido == null){

        response.sendRedirect(
        "nuevoTutorial.jsp?error=campos");

        return;
    }

    // LIMPIAR ESPACIOS
    titulo = titulo.trim();
    descripcion = descripcion.trim();
    nivel = nivel.trim();
    contenido = contenido.trim();

    if(video_url != null){
        video_url = video_url.trim();
    }

    // VALIDAR VACÍOS
    if(titulo.isEmpty() ||
       descripcion.isEmpty() ||
       nivel.isEmpty() ||
       contenido.isEmpty()){

        response.sendRedirect(
        "nuevoTutorial.jsp?error=campos");

        return;
    }

    // VALIDAR LONGITUDES
    if(titulo.length() > 150 ||
       descripcion.length() > 300 ||
       contenido.length() > 5000 ||
       (video_url != null &&
        video_url.length() > 300)){

        response.sendRedirect(
        "nuevoTutorial.jsp?error=longitud");

        return;
    }

    // VALIDAR NIVELES
    if(!nivel.equals("Principiante") &&
       !nivel.equals("Intermedio") &&
       !nivel.equals("Avanzado")){

        response.sendRedirect(
        "nuevoTutorial.jsp?error=nivel");

        return;
    }

    // PATRÓN XSS
    String patronXSS =
    "(<script>|</script>|<|>|javascript:|onerror=|onload=|alert\\(|document\\.cookie)";

    // VALIDAR XSS
    if(titulo.matches("(?i).*" + patronXSS + ".*") ||
       descripcion.matches("(?i).*" + patronXSS + ".*") ||
       contenido.matches("(?i).*" + patronXSS + ".*") ||
       (video_url != null &&
        video_url.matches("(?i).*" + patronXSS + ".*"))){

        response.sendRedirect(
        "nuevoTutorial.jsp?error=xss");

        return;
    }

    // VALIDAR URL YOUTUBE
    if(video_url != null &&
      !video_url.isEmpty()){

        boolean urlValida =
        video_url.startsWith(
        "https://www.youtube.com/embed/");

        if(!urlValida){

            response.sendRedirect(
            "nuevoTutorial.jsp?error=url");

            return;
        }
    }

    PreparedStatement ps = null;

    try{

        // INSERTAR TUTORIAL
        String sql =
        "INSERT INTO tutoriales " +
        "(titulo, descripcion, nivel, contenido, video_url, id_instructor) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

        ps =
        conexion.prepareStatement(sql);

        ps.setString(1, titulo);
        ps.setString(2, descripcion);
        ps.setString(3, nivel);
        ps.setString(4, contenido);

        if(video_url != null &&
          !video_url.isEmpty()){

            ps.setString(5, video_url);

        } else {

            ps.setNull(
            5,
            java.sql.Types.VARCHAR);
        }

        ps.setInt(6, idInstructor);

        int filas =
        ps.executeUpdate();

        if(filas > 0){

            response.sendRedirect(
            "panelInstructor.jsp?msg=creado");

        } else {

            response.sendRedirect(
            "nuevoTutorial.jsp?error=general");
        }

    } catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
        "nuevoTutorial.jsp?error=general");

    } finally {

        try{
            if(ps != null){
                ps.close();
            }
        } catch(Exception ex){}

        try{
            if(conexion != null){
                conexion.close();
            }
        } catch(Exception ex){}
    }
%>