<%-- 
    Document   : editarConcepto
    Created on : 12/01/2026, 08:57:47 PM
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
    boolean valido = false;
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
                valido = true;
                termino = rs.getString("termino");
                definicion = rs.getString("definicion");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            // Error silencioso
        }
    }

    if (!valido) {
        response.sendRedirect("diccionarioInstructor.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Concepto - Diccionario IA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../img/logoicono.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .dashboard-container {
            margin-top: 80px;
            margin-bottom: 120px;
        }
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
        .sidebar-link i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
        }
        .form-container {
            background: white;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: bold;
            color: #006299;
        }
        textarea.form-control {
            resize: vertical;
            min-height: 150px;
        }
        .btn-guardar {
            background-color: #006299;
            color: white;
            padding: 12px 40px;
            font-size: 18px;
            border-radius: 40px;
        }
        .btn-guardar:hover {
            opacity: 0.9;
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
            <!-- Sidebar -->
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

            <!-- Formulario de edición -->
            <div class="col-md-9">
                <h2 class="title">Editar Concepto</h2>
                <p class="lead mb-4">Modifica el término y su definición</p>

                <div class="form-container">
                    <form action="actualizarConcepto.jsp" method="post">
                        <input type="hidden" name="id_termino" value="<%= idConcepto %>">

                        <div class="form-group">
                            <label for="termino" class="form-label">Término / Concepto</label>
                            <input type="text" name="termino" id="termino" class="form-control input" value="<%= termino %>" required>
                        </div>

                        <div class="form-group mt-4">
                            <label for="definicion" class="form-label">Definición</label>
                            <textarea name="definicion" id="definicion" class="form-control input" rows="6" required><%= definicion %></textarea>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-guardar">
                                Actualizar Concepto
                            </button>
                            <a href="diccionarioInstructor.jsp" class="btn btn-secondary ml-3">
                                Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>
</body>
</html>
