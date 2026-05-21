<%-- 
    Document   : verConceptoInstructor
    Created on : 12/01/2026, 08:55:33 PM
    Author     : 16003
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conexion.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");
    String nombreUsuario = (String) session.getAttribute("usuario");
    int idInstructor = (Integer) session.getAttribute("id_usuario");
    if (rol == null || !"INSTRUCTOR".equalsIgnoreCase(rol)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // Obtener id del concepto
    String idStr = request.getParameter("id");
    int idConcepto = 0;
    boolean conceptoValido = false;
    String termino = "";
    String definicion = "";

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            idConcepto = Integer.parseInt(idStr);
            PreparedStatement ps = conexion.prepareStatement(
                "SELECT termino, definicion FROM diccionario_ia WHERE id_termino = ?"
            );
            ps.setInt(1, idConcepto);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                conceptoValido = true;
                termino = rs.getString("termino");
                definicion = rs.getString("definicion");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            // Error silencioso
        }
    }

    if (!conceptoValido) {
        response.sendRedirect("diccionarioInstructor.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= termino %> - Vista Previa (Instructor)</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container { margin-top: 80px; margin-bottom: 120px; }
        .sidebar-dashboard {
            background: white;
            border-radius: 12px;
            padding: 20px 0;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }
        .sidebar-link {
            display: block;
            padding: 16px 30px;
            font-size: 16px;
            color: #333;
            border-bottom: 1px solid #eee;
            transition: 0.3s;
        }
        .sidebar-link:hover {
            background: #f1f3f5;
            color: #006299;
            text-decoration: none;
        }
        .sidebar-link.active {
            background: #006299;
            color: white;
            font-weight: bold;
        }
        .sidebar-link i { margin-right: 12px; width: 20px; text-align: center; }
        .concept-header { margin-bottom: 40px; padding-bottom: 20px; border-bottom: 3px solid #006299; }
        .concept-section {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .concept-title {
            color: #006299;
            font-weight: 700;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <!-- Header logueado -->
    <header>
        <div id="header" style="background-color: #006299; color: white;">
            <div class="container">
                <div class="row align-items-center" style="min-height: 80px;">
                    <div class="col-md-3">
                        <a href="../index.jsp">
                            <img src="../img/logo.png" alt="Logo" height="60">
                        </a>
                    </div>
                    <div class="col-md-6 text-center">
                        <h3 style="color: white; margin: 0;">Plataforma Educativa de Inteligencia Artificial</h3>
                    </div>
                    <div class="col-md-3 text-right">
                        <span style="color: white; font-size: 16px;">
                            <i class="fa fa-user-circle fa-lg"></i>
                            Bienvenido, <strong><%= nombreUsuario != null ? nombreUsuario : "Instructor" %></strong>
                        </span>
                        <br>
                        <a href="../cerrarSesion.jsp" class="primary-btn" style="margin-top: 10px; padding: 10px 25px;">
                            Cerrar Sesión
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav id="navigation">
        <div class="container">
            <ul class="main-nav nav navbar-nav">
                <li><a href="panelInstructor.jsp">Mis Tutorías</a></li>
                <li><a href="../acercaDe.jsp">Acerca de</a></li>
            </ul>
        </div>
    </nav>

    <!-- Contenido principal -->
    <div class="container dashboard-container">
        <div class="row">
            <!-- Sidebar lateral (igual que panelInstructor) -->
            <div class="col-md-3">
                <div class="sidebar-dashboard">
                    <a href="panelInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-chalkboard-teacher"></i> Tutorías
                    </a>
                    <a href="casosUsoInstructor.jsp" class="sidebar-link">
                        <i class="fa fa-lightbulb-o"></i> Casos de Uso IA
                    </a>
                    <a href="diccionarioInstructor.jsp" class="sidebar-link active">
                        <i class="fa fa-book"></i> Diccionario IA
                    </a>
                </div>
            </div>

            <!-- Vista previa del concepto -->
            <div class="col-md-9">
                <div class="concept-header">
                    <h1 class="title" style="margin: 0; color: #006299;"><%= termino %> (Vista Previa)</h1>
                </div>

                <div class="concept-section">
                    <h3 class="concept-title">Definición</h3>
                    <p><%= definicion.replace("\n", "<br>") %></p>
                </div>

                <div class="text-center mt-5">
                    <a href="diccionarioInstructor.jsp" class="primary-btn">
                        ← Volver a la Lista de Conceptos
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>
</body>
</html>
