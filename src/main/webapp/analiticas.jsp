<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.ZonedDateTime" %>
<%@ page import="com.mysql.cj.xdevapi.JsonString" %>
<%@ page import="com.mysql.cj.xdevapi.JsonArray" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.example.proyectouwu.Beans.*" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>
<%@ page import="com.example.proyectouwu.DTOs.TopDonador" %>
<%@ page import="com.example.proyectouwu.DTOs.TopApoyo" %>
<%@ page import="java.sql.Blob" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%Usuario usuarioActual=(Usuario) request.getSession().getAttribute("usuario");
        int idUsuario=usuarioActual.getIdUsuario();
        String rolUsuario=usuarioActual.getRol();
        String nombreCompletoUsuario=usuarioActual.getNombre()+" "+usuarioActual.getApellido();
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        String colorRol;
        ArrayList<String>listaNombresActividadesOrden=(ArrayList<String>) request.getAttribute("listaNombresActividadesOrden");
        ArrayList<Integer>cantidadApoyosEstudiantesPorActividadOrden=(ArrayList<Integer>) request.getAttribute("cantidadApoyosEstudiantesPorActividadOrden");
        ArrayList<Integer>cantidadApoyosEgresadosPorActividadOrden=(ArrayList<Integer>) request.getAttribute("cantidadApoyosEgresadosPorActividadOrden");
        Integer cantidadTotalApoyosEgresados=(Integer)request.getAttribute("cantidadTotalApoyosEgresados");
        Integer cantidadTotalApoyosEstudiantes=(Integer) request.getAttribute("cantidadTotalApoyosEstudiantes");
        String servletActual="AnaliticasServlet";
        ArrayList<NotificacionDelegadoGeneral>listaNotificacionesCampanita=(ArrayList<NotificacionDelegadoGeneral>) request.getAttribute("listaNotificacionesCampanita");
        if(rolUsuario.equals("Alumno")){
            colorRol="";
        }else if(rolUsuario.equals("Delegado de Actividad")){
            colorRol="green";
        }else{
            colorRol="orange";
        }
        Integer cantidadTotalBaneados=(Integer)request.getAttribute("cantidadTotalBaneados");
        Integer cantidadTotalReportados=(Integer)request.getAttribute("cantidadTotalReportados");
        float[]donacionesUltimaSemanaEgresados=(float[])request.getAttribute("donacionesUltimaSemanaEgresados");
        float[]donacionesUltimaSemanaEstudiantes=(float[]) request.getAttribute("donacionesUltimaSemanaEstudiantes");
        String[] fechas={"Lunes 25-09","Martes 26-09","Miércoles 27-09","Jueves 28-09","Viernes 29-09","Sábado 30-09","Domingo 01-10","Lunes 02-10","Martes 03-10","Miércoles 04-10","Jueves 05-10","Viernes 06-10","Sábado 07-10","Domingo 08-10","Lunes 09-10","Martes 10-10","Miércoles 11-10","Jueves 12-10","Viernes 13-10","Sábado 14-10","Domingo 15-10","Lunes 16-10","Martes 17-10","Miércoles 18-10","Jueves 19-10","Viernes 29-10","Sábado 21-10","Domingo 22-10","Lunes 23-10","Martes 24-10","Miércoles 25-10","Jueves 26-10","Viernes 27-10","Sábado 28-10","Domingo 29-10","Lunes 30-10","Martes 31-10","Miércoles 01-11","Jueves 02-11","Viernes 03-11","Sábado 04-11","Domingo 05-11","Lunes 06-11","Martes 07-11","Miércoles 08-11","Jueves 09-11","Viernes 10-11","Sábado 11-11","Domingo 12-11","Lunes 13-11","Martes 14-11","Miércoles 15-11","Jueves 16-11","Viernes 17-11","Sábado 18-11","Domingo 19-11","Lunes 20-11","Martes 21-11","Miércoles 22-11","Jueves 23-11","Viernes 24-11","Sábado 25-11","Domingo 26-11","Lunes 27-11","Martes 28-11","Miércoles 29-11","Jueves 30-11","Viernes 01-12","Sábado 02-12"};
        String[] diasSemana=new String[7];
        String[] aux=ZonedDateTime.now().toString().split("T")[0].split("-");
        String diaMesActual=aux[2]+"-"+aux[1];
        float donacionesHoy=(float) request.getAttribute("donacionesHoy");
        float donacionesAyer=(float) request.getAttribute("donacionesAyer");
        Integer reportesHoy=(Integer) request.getAttribute("reportesHoy");
        Integer reportesAyer=(Integer) request.getAttribute("reportesAyer");
        Integer baneosHoy=(Integer) request.getAttribute("baneosHoy");
        Integer baneosAyer=(Integer) request.getAttribute("baneosAyer");
        Integer solicitudesApoyoHoy=(Integer) request.getAttribute("solicitudesApoyoHoy");
        Integer solicitudesApoyoAyer=(Integer) request.getAttribute("solicitudesApoyoAyer");
        Integer totalEstudiantesRegistrados=(Integer) request.getAttribute("totalEstudiantesRegistrados");
        Integer totalEgresadosRegistrados=(Integer) request.getAttribute("totalEgresadosRegistrados");
        float totalDonacionesEstudiantes=(float) request.getAttribute("totalDonacionesEstudiantes");
        float totalDonacionesEgresados=(float) request.getAttribute("totalDonacionesEgresados");
        TopApoyo topApoyoUltimaSemana= request.getAttribute("topApoyoUltimaSemana") != null ? (TopApoyo) request.getAttribute("topApoyoUltimaSemana") : new TopApoyo();
        TopApoyo topApoyoTotal= request.getAttribute("topApoyoTotal") != null ? (TopApoyo) request.getAttribute("topApoyoTotal") : new TopApoyo();
        TopDonador topDonadorTotal = request.getAttribute("topDonadorTotal") != null ? (TopDonador) request.getAttribute("topDonadorTotal") : new TopDonador();
        TopDonador topDonadorUltimaSemana = request.getAttribute("topDonadorUltimaSemana") != null ? (TopDonador) request.getAttribute("topDonadorUltimaSemana") : new TopDonador();
        for(int i=0;i<fechas.length;i++){
            if(diaMesActual.equals(fechas[i].split(" ")[1])){
                for(int j=0;j<7;j++){
                    diasSemana[6-j]=fechas[i].split("-")[0];
                    i--;
                }
                break;
            }
        }
    %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- bootstrap 4.3.1 -->
    <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
    <!-- styles -->
    <link rel="stylesheet" href="css/raw/styles.css">
    <!-- simplebar styles -->
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <!-- favicon -->
    <link rel="icon" href="img/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>Actividades - Siempre Fibra</title>
    <style>
        footer {
            background-color: #322D31;
            color: white;
            font-family: 'Titillium Web', sans-serif;
            padding: 20px 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            text-align: center; /* Centrar el contenido horizontalmente */
        }

        .fila {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 10px;

        }

        .columna {
            width: 30%;
            padding: 10px;
            box-sizing: border-box;
            background-color: #322D31;
        }

        .columna p {
            text-align: center;
            color: white;
            margin: 0; /* Eliminar el margen por defecto del párrafo */
        }

        /* Estilo para la lista */
        .lista {
            text-align: center;
            list-style: none;
            padding: 0;
            color: #EDE8DF;
        }

        .lista li {
            margin: 5px 0;
            text-align: center;
            color: #EDE8DF;
        }
        .titulo {
            font-weight: bold;
            font-size: 1.2em; /* Aumentar el tamaño de fuente del título */
        }
        .lista a {
            text-decoration: none;
            color: #EDE8DF;
            font-weight: bold;
        }

        .lista a:hover {
            text-decoration: underline; /* Subrayar en el hover */
        }
        @media screen and (max-width: 680px) {
            .auxResponsiveUwu{
                display: none;
            }
        }
    </style>
</head>
<body>

<!-- PAGE LOADER -->
<div class="page-loader">
    <!-- PAGE LOADER DECORATION -->
    <div class="page-loader-decoration">
        <!-- ICON LOGO -->
        <img src="css/logoTelito.png" width="400%" alt="">
        <!-- /ICON LOGO -->
    </div>
    <!-- /PAGE LOADER DECORATION -->
    <br>
    <!-- PAGE LOADER INFO -->
    <div class="page-loader-info">
        <!-- PAGE LOADER INFO TITLE -->
        <p class="page-loader-info-title">SIEMPRE FIBRA</p>
        <!-- /PAGE LOADER INFO TITLE -->

        <!-- PAGE LOADER INFO TEXT -->
        <p class="page-loader-info-text">Cargando...</p>
        <!-- /PAGE LOADER INFO TEXT -->
    </div>
    <!-- /PAGE LOADER INFO -->

    <!-- PAGE LOADER INDICATOR -->
    <div class="page-loader-indicator loader-bars">
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
        <div class="loader-bar"></div>
    </div>
    <!-- /PAGE LOADER INDICATOR -->
</div>
<!-- /PAGE LOADER -->

<nav id="navigation-widget-small" class="navigation-widget navigation-widget-desktop closed sidebar left delayed">
    <!-- USER AVATAR -->
    <a class="user-avatar small no-outline online">
        <!-- USER AVATAR CONTENT -->
        <div class="user-avatar-content">
            <!-- HEXAGON -->
            <%request.getSession().setAttribute("fotoPersonal0",usuarioActual.getFotoPerfil());%>
            <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Personal0"></div>
            <!-- /HEXAGON -->
        </div>
        <!-- /USER AVATAR CONTENT -->

        <!-- USER AVATAR PROGRESS -->
        <div class="user-avatar-progress">
            <!-- HEXAGON -->
            <div class="hexagon-progress-40-44"></div>
            <!-- /HEXAGON -->
        </div>
        <!-- /USER AVATAR PROGRESS -->

        <!-- USER AVATAR PROGRESS BORDER -->
        <div class="user-avatar-progress-border">
            <!-- HEXAGON -->
            <div class="hexagon-border-40-44"></div>
            <!-- /HEXAGON -->
        </div>
        <!-- /USER AVATAR PROGRESS BORDER -->
    </a>
    <!-- /USER AVATAR -->

    <!-- MENU -->
    <ul class="menu small">
        <!-- MENU ITEM -->
        <!-- MENU ITEM -->
        <!-- MENU ITEM -->
        <!-- MENU ITEM -->
        <li class="menu-item <%if(vistaActual.equals("miCuenta")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr" href="MiCuentaServlet" data-title="Mi cuenta">
                <!-- MENU ITEM LINK ICON -->
                <svg class="menu-item-link-icon icon-members">
                    <use xlink:href="#svg-members"></use>
                </svg>
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <li class="menu-item <%if(vistaActual.equals("listaDeActividades")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr" href="ListaDeActividadesServlet" data-title="Actividades">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/actividadIconoGris.png" class="menu-item-link-icon icon-members" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <%if(rolUsuario.equals("Delegado General")){%>
        <li class="menu-item <%if(vistaActual.equals("analiticas")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr text-center" href="AnaliticasServlet" data-title="Analíticas">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/analiticasIcono.png" width="70%" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <!-- /MENU ITEM -->
        <li class="menu-item <%if(vistaActual.equals("listaDeUsuarios")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr text-center" href="ListaDeUsuariosServlet" data-title="Usuarios">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/usuariosIcono.png" width="70%" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <%}else{%>
        <li class="menu-item <%if(vistaActual.equals("misEventos")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr" href="MisEventosServlet" data-title="Mis eventos">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/misEventosIcono.png" class="menu-item-link-icon icon-members" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <li class="menu-item <%if(vistaActual.equals("misDonaciones")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr" href="MisDonacionesServlet" data-title="Donaciones">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/donacionIcono.png" class="menu-item-link-icon icon-members" style="opacity: 50%;" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <%}%>
    </ul>
    <!-- /MENU -->
</nav>
<!-- /NAVIGATION WIDGET -->

<!-- NAVIGATION WIDGET -->
<nav id="navigation-widget" class="navigation-widget navigation-widget-desktop sidebar left hidden" data-simplebar>
    <!-- NAVIGATION WIDGET COVER -->
    <figure class="navigation-widget-cover liquid">

    </figure>
    <!-- /NAVIGATION WIDGET COVER -->

    <!-- USER SHORT DESCRIPTION -->
    <div class="user-short-description">
        <!-- USER SHORT DESCRIPTION AVATAR -->
        <a class="user-short-description-avatar user-avatar medium">
            <!-- USER AVATAR BORDER -->
            <div class="user-avatar-border">
                <!-- HEXAGON -->
                <div class="hexagon-120-132"></div>
                <!-- /HEXAGON -->
            </div>
            <!-- /USER AVATAR BORDER -->

            <!-- USER AVATAR CONTENT -->
            <div class="user-avatar-content">
                <!-- HEXAGON -->
                <%request.getSession().setAttribute("fotoPersonal1",usuarioActual.getFotoPerfil());%>
                <div class="hexagon-image-82-90" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Personal1"></div>
                <!-- /HEXAGON -->
            </div>
            <!-- /USER AVATAR CONTENT -->

            <!-- USER AVATAR PROGRESS -->
            <div class="user-avatar-progress">
                <!-- HEXAGON -->
                <div class="hexagon-progress-100-110"></div>
                <!-- /HEXAGON -->
            </div>
            <!-- /USER AVATAR PROGRESS -->

            <!-- /USER AVATAR BADGE -->
        </a>
        <!-- /USER SHORT DESCRIPTION AVATAR -->

        <!-- USER SHORT DESCRIPTION TITLE -->
        <p class="user-short-description-title"><a><%=nombreCompletoUsuario%></a></p>
        <!-- /USER SHORT DESCRIPTION TITLE -->

        <!-- USER SHORT DESCRIPTION TEXT -->
        <% if(new DaoUsuario().usuarioEsDelegadoDeActividad(idUsuario)){ %>
        <p class="user-short-description-text"><a style="color: <%=colorRol%>;"><%=rolUsuario + ": " + new DaoUsuario().obtenerDelegaturaPorId(idUsuario)%></a></p>
        <%}else{%>
        <p class="user-short-description-text"><a style="color: <%=colorRol%>;"><%=rolUsuario%></a></p>
        <%}%>
        <!-- /USER SHORT DESCRIPTION TEXT -->
    </div>
    <!-- /USER SHORT DESCRIPTION -->


    <hr>
    <!-- MENU -->
    <!-- MENU ITEM -->
    <li class="menu-item">
        <!-- MENU ITEM LINK -->
        <a class="menu-item-link" href="MiCuentaServlet">
            <!-- MENU ITEM LINK ICON -->
            <svg class="menu-item-link-icon icon-members">
                <use xlink:href="#svg-members"></use>
            </svg>
            <!-- /MENU ITEM LINK ICON -->
            Mi cuenta
        </a>
        <!-- /MENU ITEM LINK -->
    </li>
    <!-- /MENU ITEM -->

    <hr>
    <!-- MENU ITEM -->
    <li class="menu-item">
        <!-- MENU ITEM LINK -->
        <a class="menu-item-link" href="ListaDeActividadesServlet">
            <!-- MENU ITEM LINK ICON -->
            <img src="css/actividadIconoGris.png" class="menu-item-link-icon icon-members" alt="">
            <!-- /MENU ITEM LINK ICON -->
            Actividades
        </a>
        <!-- /MENU ITEM LINK -->
    </li>
    <!-- /MENU ITEM -->
    <br>
    <%if(rolUsuario.equals("Delegado General")){%>
    <!-- MENU ITEM -->
    <li class="menu-item">
        <!-- MENU ITEM LINK -->
        <a class="menu-item-link" href="AnaliticasServlet">
            <!-- MENU ITEM LINK ICON -->
            <img src="css/analiticasIcono.png" width="7%" alt="">
            <!-- /MENU ITEM LINK ICON -->
            Analíticas
        </a>
        <!-- /MENU ITEM LINK -->
    </li>
    <!-- /MENU ITEM -->
    <br>
    <li class="menu-item">
        <!-- MENU ITEM LINK -->
        <a class="menu-item-link" href="ListaDeUsuariosServlet">
            <!-- MENU ITEM LINK ICON -->
            <img src="css/usuariosIcono.png" width="7%" alt="">
            <!-- /MENU ITEM LINK ICON -->
            Usuarios
        </a>
        <!-- /MENU ITEM LINK -->
    </li>
    <!-- /MENU ITEM -->
    <%}else{%>
    <!-- MENU ITEM -->
    <li class="menu-item">
        <!-- MENU ITEM LINK -->
        <a class="menu-item-link" href="MisEventosServlet">
            <!-- MENU ITEM LINK ICON -->
            <img src="css/misEventosIcono.png" class="menu-item-link-icon icon-members" alt="">
            <!-- /MENU ITEM LINK ICON -->
            Mis eventos
        </a>
        <!-- /MENU ITEM LINK -->
    </li>
    <!-- /MENU ITEM -->
    <br>
    <!-- MENU ITEM -->
    <li class="menu-item">
        <!-- MENU ITEM LINK -->
        <a class="menu-item-link" href="MisDonacionesServlet">
            <!-- MENU ITEM LINK ICON -->
            <img src="css/donacionIcono.png" class="menu-item-link-icon icon-members" style="opacity: 50%;" alt="">
            <!-- /MENU ITEM LINK ICON -->
            Donaciones
        </a>
        <!-- /MENU ITEM LINK -->
    </li>
    <!-- /MENU ITEM -->
    <%}%>
    </ul>
    <!-- /MENU -->
</nav>
<!-- /NAVIGATION WIDGET -->

<!-- NAVIGATION WIDGET -->
<nav id="navigation-widget-mobile" class="navigation-widget navigation-widget-mobile sidebar left hidden" data-simplebar>
    <!-- NAVIGATION WIDGET CLOSE BUTTON -->
    <div class="navigation-widget-close-button">
        <!-- NAVIGATION WIDGET CLOSE BUTTON ICON -->
        <svg class="navigation-widget-close-button-icon icon-back-arrow">
            <use xlink:href="#svg-back-arrow"></use>
        </svg>
        <!-- NAVIGATION WIDGET CLOSE BUTTON ICON -->
    </div>
    <!-- /NAVIGATION WIDGET CLOSE BUTTON -->

    <!-- NAVIGATION WIDGET INFO WRAP -->
    <div class="navigation-widget-info-wrap">
        <!-- NAVIGATION WIDGET INFO -->
        <div class="navigation-widget-info">
            <!-- USER AVATAR -->
            <a class="user-avatar small no-outline">
                <!-- USER AVATAR CONTENT -->
                <div class="user-avatar-content">
                    <!-- HEXAGON -->
                    <%request.getSession().setAttribute("fotoPersonal2",usuarioActual.getFotoPerfil());%>
                    <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Personal2"></div>
                    <!-- /HEXAGON -->
                </div>
                <!-- /USER AVATAR CONTENT -->

                <!-- USER AVATAR PROGRESS -->
                <div class="user-avatar-progress">
                    <!-- HEXAGON -->
                    <div class="hexagon-progress-40-44"></div>
                    <!-- /HEXAGON -->
                </div>
                <!-- /USER AVATAR PROGRESS -->

                <!-- USER AVATAR PROGRESS BORDER -->
                <div class="user-avatar-progress-border">
                    <!-- HEXAGON -->
                    <div class="hexagon-border-40-44"></div>
                    <!-- /HEXAGON -->
                </div>
                <!-- /USER AVATAR PROGRESS BORDER -->

                <!-- USER AVATAR BADGE -->
                <div class="user-avatar-badge">
                    <!-- USER AVATAR BADGE BORDER -->
                    <!-- /USER AVATAR BADGE BORDER -->
                </div>
                <!-- /USER AVATAR BADGE -->
            </a>
            <!-- /USER AVATAR -->

            <!-- NAVIGATION WIDGET INFO TITLE -->
            <p class="navigation-widget-info-title"><a><%=nombreCompletoUsuario%></a></p>
            <!-- /NAVIGATION WIDGET INFO TITLE -->

            <!-- NAVIGATION WIDGET INFO TEXT -->
            <% if(new DaoUsuario().usuarioEsDelegadoDeActividad(idUsuario)){ %>
            <p class="navigation-widget-info-text" style="color: <%=colorRol%>"><%=rolUsuario + ": " + new DaoUsuario().obtenerDelegaturaPorId(idUsuario)%></p>
            <%}else{%>
            <p class="navigation-widget-info-text" style="color: <%=colorRol%>"><%=rolUsuario%></p>
            <%}%>
            <!-- /NAVIGATION WIDGET INFO TEXT -->
        </div>
        <!-- /NAVIGATION WIDGET INFO -->

        <form method="post" action="InicioSesionServlet?action=logOut">
            <button style="border:0;background: none;color: inherit" type="submit"><a><p class="navigation-widget-info-button button small secondary">Cerrar sesión</p></a></button>
        </form>
    </div>
    <!-- /NAVIGATION WIDGET INFO WRAP -->

    <!-- MENU -->
    <ul class="menu">



        <!-- NAVIGATION WIDGET SECTION TITLE -->
        <p class="navigation-widget-section-title">Perfil</p>
        <!-- /NAVIGATION WIDGET SECTION TITLE -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="MiCuentaServlet">Mi cuenta</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->

        <!-- NAVIGATION WIDGET SECTION TITLE -->
        <p class="navigation-widget-section-title">Funciones</p>
        <!-- /NAVIGATION WIDGET SECTION TITLE -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="ListaDeActividadesServlet">Actividades</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->
        <%if(rolUsuario.equals("Delegado General")){%>
        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="AnaliticasServlet">Analíticas</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="ListaDeUsuariosServlet">Usuarios</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->
        <%}else{%>
        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="MisEventosServlet">Mis eventos</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="MisDonacionesServlet">Donaciones</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->
        <%}%>
    </ul>
</nav>
<!-- /NAVIGATION WIDGET -->

<!-- HEADER -->
<header class="header">
    <!-- HEADER ACTIONS -->
    <div class="header-actions">
        <!-- HEADER BRAND -->
        <div class="header-brand">
            <!-- LOGO -->
            <div class="logo auxResponsiveUwu">
                <!-- ICON LOGO VIKINGER -->
                <div class="icon-logo-vikinger small">
                    <img src="css/telitoBlanco.png" width="150%" alt="">
                </div>
                <!-- /ICON LOGO VIKINGER -->
            </div>
            <!-- /LOGO -->

            <!-- HEADER BRAND TEXT -->
            <h1 class="header-brand-text">SEMANA DE INGENIERÍA</h1>
            <!-- /HEADER BRAND TEXT -->
        </div>
        <!-- /HEADER BRAND -->
        <!-- SIDEMENU TRIGGER -->
        <div class="sidemenu-trigger navigation-widget-trigger">
            <!-- ICON GRID -->
            <svg class="icon-grid">
                <use xlink:href="#svg-grid"></use>
            </svg>
            <!-- /ICON GRID -->
        </div>
        <!-- /SIDEMENU TRIGGER -->

        <!-- MOBILEMENU TRIGGER -->
        <div class="mobilemenu-trigger navigation-widget-mobile-trigger">
            <!-- BURGER ICON -->
            <div class="burger-icon inverted">
                <!-- BURGER ICON BAR -->
                <div class="burger-icon-bar"></div>
                <!-- /BURGER ICON BAR -->

                <!-- BURGER ICON BAR -->
                <div class="burger-icon-bar"></div>
                <!-- /BURGER ICON BAR -->

                <!-- BURGER ICON BAR -->
                <div class="burger-icon-bar"></div>
                <!-- /BURGER ICON BAR -->
            </div>
            <!-- /BURGER ICON -->
        </div>
        <!-- /MOBILEMENU TRIGGER -->
    </div>
    <!-- /HEADER ACTIONS -->

    <!-- NO BORRAR ESTO-->

    <!-- HEADER ACTIONS -->
    <div class="header-actions">
        <!-- PROGRESS STAT -->
        <div class="progress-stat">
            <!-- BAR PROGRESS WRAP -->
            <div class="bar-progress-wrap">
                <!-- BAR PROGRESS INFO -->
                <!-- /BAR PROGRESS INFO -->
            </div>
            <!-- /BAR PROGRESS WRAP -->
        </div>
        <!-- /PROGRESS STAT -->
    </div>
    <!-- /HEADER ACTIONS -->

    <!-- NO BORRAR ESTO-->
    <%if(rolUsuario.equals("Alumno")){%>
    <!-- ACTION ITEM WRAP USUARIO -->
    <div class="action-item-wrap auxResponsiveUwu">
        <!-- ACTION ITEM -->
        <div class="action-item dark header-settings-dropdown-trigger">
            <!-- ACTION ITEM ICON -->
            <form method="post" action="InicioSesionServlet?action=logOut">
                <button style="border:0;background: none;color: inherit" type="submit"><a><img src="css/logOut.png" width="30%" style="" alt=""></a></button>
            </form>
            <!-- /ACTION ITEM ICON -->
        </div>
        <!-- /ACTION ITEM -->

        <!-- DROPDOWN NAVIGATION -->

    </div>
    <!-- /ACTION ITEM WRAP -->
    <%}else if(rolUsuario.equals("Delegado de Actividad")){%>
    <!-- HEADER ACTIONS DELEGADO DE ACTIVIDAD -->
    <div class="header-actions">
        <!-- ACTION LIST -->
        <div class="action-list dark">
            <!-- ACTION LIST ITEM WRAP -->
            <div class="action-list-item-wrap">
                <!-- ACTION LIST ITEM -->
                <div class="action-list-item unread header-dropdown-trigger">
                    <!-- ACTION LIST ITEM ICON -->
                    <svg class="action-list-item-icon icon-notification">
                        <use xlink:href="#svg-notification"></use>
                    </svg>
                    <!-- /ACTION LIST ITEM ICON -->
                </div>
                <!-- /ACTION LIST ITEM -->

                <!-- DROPDOWN BOX -->
                <div class="dropdown-box header-dropdown">
                    <!-- DROPDOWN BOX HEADER -->
                    <div class="dropdown-box-header">
                        <!-- DROPDOWN BOX HEADER TITLE -->
                        <p class="dropdown-box-header-title">Notificaciones</p>
                        <!-- /DROPDOWN BOX HEADER TITLE -->
                    </div>
                    <!-- /DROPDOWN BOX HEADER -->

                    <!-- DROPDOWN BOX LIST -->
                    <div class="dropdown-box-list" data-simplebar>
                        <!-- DROPDOWN BOX LIST ITEM -->
                        <div class="dropdown-box-list-item unread">
                            <!-- USER STATUS -->
                            <div class="user-status notification">
                                <!-- USER STATUS AVATAR -->
                                <a class="user-status-avatar">
                                    <!-- USER AVATAR -->
                                    <div class="user-avatar small no-outline">
                                        <!-- USER AVATAR CONTENT -->
                                        <div class="user-avatar-content">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-image-30-32" data-src="css/fabiana.png"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR CONTENT -->

                                        <!-- USER AVATAR PROGRESS -->
                                        <div class="user-avatar-progress">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-progress-40-44"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR PROGRESS -->

                                        <!-- USER AVATAR PROGRESS BORDER -->
                                        <div class="user-avatar-progress-border">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-border-40-44"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR PROGRESS BORDER -->

                                        <!-- USER AVATAR BADGE -->
                                        <div class="user-avatar-badge">
                                            <!-- USER AVATAR BADGE BORDER -->
                                            <div class="user-avatar-badge-border">
                                            </div>
                                            <!-- /USER AVATAR BADGE BORDER -->

                                        </div>
                                        <!-- /USER AVATAR BADGE -->
                                    </div>
                                    <!-- /USER AVATAR -->
                                </a>
                                <!-- /USER STATUS AVATAR -->

                                <!-- USER STATUS TITLE -->
                                <p class="user-status-title"><a class="bold">Fabiana Rojas</a> desea apoyar el evento <a class="highlighted">Fibra Tóxica VS Huascaminas</a> dentro de la actividad <a style="color: blueviolet;">Voley</a>.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 24 minutos</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/voleyIcono.png" width="30px" alt="">
                                    <!-- /ICON COMMENT -->
                                </div>
                                <!-- /USER STATUS ICON -->
                            </div>
                            <!-- /USER STATUS -->
                        </div>
                        <!-- /DROPDOWN BOX LIST ITEM -->
                        <!-- DROPDOWN BOX LIST ITEM -->
                        <div class="dropdown-box-list-item unread">
                            <!-- USER STATUS -->
                            <div class="user-status notification">
                                <!-- USER STATUS AVATAR -->
                                <a class="user-status-avatar">
                                    <!-- USER AVATAR -->
                                    <div class="user-avatar small no-outline">
                                        <!-- USER AVATAR CONTENT -->
                                        <div class="user-avatar-content">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-image-30-32" data-src="css/edisonFlores.png"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR CONTENT -->

                                        <!-- USER AVATAR PROGRESS -->
                                        <div class="user-avatar-progress">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-progress-40-44"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR PROGRESS -->

                                        <!-- USER AVATAR PROGRESS BORDER -->
                                        <div class="user-avatar-progress-border">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-border-40-44"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR PROGRESS BORDER -->

                                        <!-- USER AVATAR BADGE -->
                                        <div class="user-avatar-badge">
                                            <!-- USER AVATAR BADGE BORDER -->
                                            <div class="user-avatar-badge-border">
                                            </div>
                                            <!-- /USER AVATAR BADGE BORDER -->

                                        </div>
                                        <!-- /USER AVATAR BADGE -->
                                    </div>
                                    <!-- /USER AVATAR -->
                                </a>
                                <!-- /USER STATUS AVATAR -->

                                <!-- USER STATUS TITLE -->
                                <p class="user-status-title"><a class="bold">Edison Flores</a> desea apoyar el evento <a class="highlighted">Fibra Tóxica VS PXO Industrial</a> dentro de la actividad <a style="color: blueviolet;">Futsal</a>.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 1 hora</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/futsalIcono.png" width="30px" alt="">
                                    <!-- /ICON COMMENT -->
                                </div>
                                <!-- /USER STATUS ICON -->
                            </div>
                            <!-- /USER STATUS -->
                        </div>
                        <!-- /DROPDOWN BOX LIST ITEM -->
                        <!-- DROPDOWN BOX LIST ITEM -->
                        <div class="dropdown-box-list-item unread">
                            <!-- USER STATUS -->
                            <div class="user-status notification">
                                <!-- USER STATUS AVATAR -->
                                <a class="user-status-avatar">
                                    <!-- USER AVATAR -->
                                    <div class="user-avatar small no-outline">
                                        <!-- USER AVATAR CONTENT -->
                                        <div class="user-avatar-content">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-image-30-32" data-src="css/raulRomero.png"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR CONTENT -->

                                        <!-- USER AVATAR PROGRESS -->
                                        <div class="user-avatar-progress">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-progress-40-44"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR PROGRESS -->

                                        <!-- USER AVATAR PROGRESS BORDER -->
                                        <div class="user-avatar-progress-border">
                                            <!-- HEXAGON -->
                                            <div class="hexagon-border-40-44"></div>
                                            <!-- /HEXAGON -->
                                        </div>
                                        <!-- /USER AVATAR PROGRESS BORDER -->

                                        <!-- USER AVATAR BADGE -->
                                        <div class="user-avatar-badge">
                                            <!-- USER AVATAR BADGE BORDER -->
                                            <div class="user-avatar-badge-border">
                                            </div>
                                            <!-- /USER AVATAR BADGE BORDER -->

                                        </div>
                                        <!-- /USER AVATAR BADGE -->
                                    </div>
                                    <!-- /USER AVATAR -->
                                </a>
                                <!-- /USER STATUS AVATAR -->

                                <!-- USER STATUS TITLE -->
                                <p class="user-status-title"><a class="bold">Raul Romero</a> desea apoyar el evento <a class="highlighted">Fibra Tóxica VS Hormigón Armado</a> dentro del evento <a style="color: blueviolet;">Six Pract</a>.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 2 horas</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/sixPractIcono.png" width="30px" alt="">
                                    <!-- /ICON COMMENT -->
                                </div>
                                <!-- /USER STATUS ICON -->
                            </div>
                            <!-- /USER STATUS -->
                        </div>
                        <!-- /DROPDOWN BOX LIST ITEM -->
                    </div>
                    <!-- /DROPDOWN BOX LIST -->
                    <!--ARRIBA ESTÁN LAS NOTIFICACIONES-->
                    <!-- DROPDOWN BOX BUTTON -->
                    <a class="dropdown-box-button secondary" href="NotificacionesServlet">Ver todas las notificaciones</a>
                    <!-- /DROPDOWN BOX BUTTON -->
                </div>
                <!-- /DROPDOWN BOX -->
            </div>
            <!-- /ACTION LIST ITEM WRAP -->
        </div>
        <!-- /ACTION LIST -->

        <!-- ACTION ITEM WRAP -->
        <div class="action-item-wrap auxResponsiveUwu">
            <!-- ACTION ITEM -->
            <div class="action-item dark header-settings-dropdown-trigger">
                <!-- ACTION ITEM ICON -->
                <form method="post" action="InicioSesionServlet?action=logOut">
                    <button style="border:0;background: none;color: inherit" type="submit"><a><img src="css/logOut.png" width="30%" style="" alt=""></a></button>
                </form>
                <!-- /ACTION ITEM ICON -->
            </div>
            <!-- /ACTION ITEM -->

            <!-- DROPDOWN NAVIGATION -->

        </div>
        <!-- /ACTION ITEM WRAP -->
    </div>
    <!-- /HEADER ACTIONS -->
    <%}else{%>
    <!-- HEADER ACTIONS DELEGADO GENERAL -->
    <div class="header-actions">
        <!-- ACTION LIST -->
        <div class="action-list dark">
            <!-- ACTION LIST ITEM WRAP -->
            <div class="action-list-item-wrap">
                <!-- ACTION LIST ITEM -->
                <div class="action-list-item  <%if(!listaNotificacionesCampanita.isEmpty()){%> unread <%}%>header-dropdown-trigger">
                    <!-- ACTION LIST ITEM ICON -->
                    <svg class="action-list-item-icon icon-notification">
                        <use xlink:href="#svg-notification"></use>
                    </svg>
                    <!-- /ACTION LIST ITEM ICON -->
                </div>
                <!-- /ACTION LIST ITEM -->

                <!-- DROPDOWN BOX -->
                <div class="dropdown-box header-dropdown">
                    <!-- DROPDOWN BOX HEADER -->
                    <div class="dropdown-box-header">
                        <!-- DROPDOWN BOX HEADER TITLE -->
                        <p class="dropdown-box-header-title">Notificaciones</p>
                        <!-- /DROPDOWN BOX HEADER TITLE -->
                    </div>
                    <!-- /DROPDOWN BOX HEADER -->

                    <!-- DROPDOWN BOX LIST -->
                    <div class="dropdown-box-list" data-simplebar>
                        <%for(NotificacionDelegadoGeneral noti:listaNotificacionesCampanita){%>
                        <form id="notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>" method="post" action="/<%=servletActual%>?action=notificacionLeidaCampanita">
                            <input type="hidden" name="idNotificacion" value="<%=noti.getIdNotificacion()%>">
                            <%if(noti.getReporte().getIdReporte()!=0){
                                Reporte r=new DaoReporte().reportePorIdReporteNotificacion(noti.getReporte().getIdReporte());%>
                            <!-- Reporte -->
                            <div class="dropdown-box-list-item unread">
                                <!-- USER STATUS -->
                                <div class="user-status notification">
                                    <!-- USER STATUS AVATAR -->
                                    <a class="user-status-avatar">
                                        <!-- USER AVATAR -->
                                        <div class="user-avatar small no-outline">
                                            <!-- USER AVATAR CONTENT -->
                                            <div class="user-avatar-content">
                                                <%request.getSession().setAttribute("foto0"+listaNotificacionesCampanita.indexOf(noti),new DaoReporte().getFotoPerfilPorIDReporte(noti.getReporte().getIdReporte()));%>
                                                <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
                                                <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=0<%=listaNotificacionesCampanita.indexOf(noti)%>"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR CONTENT -->

                                            <!-- USER AVATAR PROGRESS -->
                                            <div class="user-avatar-progress">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-progress-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS -->

                                            <!-- USER AVATAR PROGRESS BORDER -->
                                            <div class="user-avatar-progress-border">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-border-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS BORDER -->

                                            <!-- USER AVATAR BADGE -->
                                            <div class="user-avatar-badge">
                                                <!-- USER AVATAR BADGE BORDER -->
                                                <div class="user-avatar-badge-border">
                                                </div>
                                                <!-- /USER AVATAR BADGE BORDER -->

                                            </div>
                                            <!-- /USER AVATAR BADGE -->
                                        </div>
                                        <!-- /USER AVATAR -->
                                    </a>
                                    <!-- /USER STATUS AVATAR -->

                                    <!-- USER STATUS TITLE -->
                                    <p class="user-status-title"><a class="bold"><%=r.getUsuarioReportado().getNombre()%> <%=r.getUsuarioReportado().getApellido()%></a> ha sido <a class="highlighted">reportado</a> por el delegado de actividad <a class="bold"><%=r.getUsuarioQueReporta().getNombre()%> <%=r.getUsuarioQueReporta().getApellido()%></a></p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <!-- USER STATUS ICON -->
                                    <div class="user-status-icon">
                                        <!-- ICON COMMENT -->
                                        <img src="css/iconoReporte.png" width="30px" style="opacity: 0.5" alt="">
                                        <!-- /ICON COMMENT -->
                                    </div>
                                    <!-- /USER STATUS ICON -->
                                </div>
                                <!-- /USER STATUS -->
                            </div>
                            <!-- Reporte -->
                            <%}else if(noti.getDonacion().getIdDonacion()!=0){
                                Donacion d=new DaoDonacion().donacionPorIDNotificacion(noti.getDonacion().getIdDonacion());%>
                            <!-- Donacion -->
                            <div class="dropdown-box-list-item unread">
                                <!-- USER STATUS -->
                                <div class="user-status notification">
                                    <!-- USER STATUS AVATAR -->
                                    <a class="user-status-avatar">
                                        <!-- USER AVATAR -->
                                        <div class="user-avatar small no-outline">
                                            <!-- USER AVATAR CONTENT -->
                                            <div class="user-avatar-content">
                                                <%request.getSession().setAttribute("foto0"+listaNotificacionesCampanita.indexOf(noti),new DaoDonacion().getFotoPerfilPorIDDonacion(noti.getDonacion().getIdDonacion()));%>
                                                <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
                                                <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=0<%=listaNotificacionesCampanita.indexOf(noti)%>"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR CONTENT -->

                                            <!-- USER AVATAR PROGRESS -->
                                            <div class="user-avatar-progress">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-progress-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS -->

                                            <!-- USER AVATAR PROGRESS BORDER -->
                                            <div class="user-avatar-progress-border">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-border-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS BORDER -->

                                            <!-- USER AVATAR BADGE -->
                                            <div class="user-avatar-badge">
                                                <!-- USER AVATAR BADGE BORDER -->
                                                <div class="user-avatar-badge-border">
                                                </div>
                                                <!-- /USER AVATAR BADGE BORDER -->

                                            </div>
                                            <!-- /USER AVATAR BADGE -->
                                        </div>
                                        <!-- /USER AVATAR -->
                                    </a>
                                    <!-- /USER STATUS AVATAR -->

                                    <!-- USER STATUS TITLE -->
                                    <p class="user-status-title"><a class="bold"><%=d.getUsuario().getNombre()%> <%=d.getUsuario().getApellido()%></a> realizó una <a class="highlighted">donación</a> de <a style="color: orange;">S/. <%=d.getMonto()%></a>.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <!-- USER STATUS ICON -->
                                    <div class="user-status-icon">
                                        <!-- ICON COMMENT -->
                                        <img src="css/donacionIcono.png" width="30px" style="opacity: 0.5" alt="">
                                        <!-- /ICON COMMENT -->
                                    </div>
                                    <!-- /USER STATUS ICON -->
                                </div>
                                <!-- /USER STATUS -->
                            </div>
                            <!-- Donacion -->
                            <%}else if(noti.getUsuario().getIdUsuario()!=0){
                                Usuario u=new DaoUsuario().usuarioPorIdNotificacion(noti.getUsuario().getIdUsuario());%>
                            <!-- Solicitud de registro -->
                            <div class="dropdown-box-list-item unread">
                                <!-- USER STATUS -->
                                <div class="user-status notification">
                                    <!-- USER STATUS AVATAR -->
                                    <a class="user-status-avatar">
                                        <!-- USER AVATAR -->
                                        <div class="user-avatar small no-outline">
                                            <!-- USER AVATAR CONTENT -->
                                            <div class="user-avatar-content">
                                                <!-- HEXAGON AQUÍ ESTA FOTO ES ESTÁTICA -->
                                                <div class="hexagon-image-30-32" data-src="css/iconoPerfil.png"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR CONTENT -->

                                            <!-- USER AVATAR PROGRESS -->
                                            <div class="user-avatar-progress">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-progress-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS -->

                                            <!-- USER AVATAR PROGRESS BORDER -->
                                            <div class="user-avatar-progress-border">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-border-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS BORDER -->

                                            <!-- USER AVATAR BADGE -->
                                            <div class="user-avatar-badge">
                                                <!-- USER AVATAR BADGE BORDER -->
                                                <div class="user-avatar-badge-border">
                                                </div>
                                                <!-- /USER AVATAR BADGE BORDER -->

                                            </div>
                                            <!-- /USER AVATAR BADGE -->
                                        </div>
                                        <!-- /USER AVATAR -->
                                    </a>
                                    <!-- /USER STATUS AVATAR -->

                                    <!-- USER STATUS TITLE -->
                                    <p class="user-status-title"><a class="bold"><%=u.getNombre()%> <%=u.getApellido()%></a> está solicitando la aprobación de su <a class="highlighted">registro</a> en la plataforma.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <!-- USER STATUS ICON -->
                                    <div class="user-status-icon">
                                        <!-- ICON COMMENT -->
                                        <img src="css/iconoRegistro.png" width="30px" style="opacity: 0.5" alt="">
                                        <!-- /ICON COMMENT -->
                                    </div>
                                    <!-- /USER STATUS ICON -->
                                </div>
                                <!-- /USER STATUS -->
                            </div>
                            <!-- Solicitud de registro -->
                            <%}else if(noti.getValidacion().getIdCorreoValidacion()!=0){
                                if(new DaoValidacion().tipoValidacionPorID(noti.getValidacion().getIdCorreoValidacion()).equals("enviarLinkACorreo")){
                                    Validacion v1=new DaoValidacion().validacionPorIDNotificacionCorreo(noti.getValidacion().getIdCorreoValidacion());%>
                            <!-- Validación correo -->
                            <div class="dropdown-box-list-item unread">
                                <!-- USER STATUS -->
                                <div class="user-status notification">
                                    <!-- USER STATUS AVATAR -->
                                    <a class="user-status-avatar">
                                        <!-- USER AVATAR -->
                                        <div class="user-avatar small no-outline">
                                            <!-- USER AVATAR CONTENT -->
                                            <div class="user-avatar-content">
                                                <!-- HEXAGON AQUÍ ESTA FOTO ES ESTÁTICA -->
                                                <div class="hexagon-image-30-32" data-src="css/iconoPerfil.png"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR CONTENT -->

                                            <!-- USER AVATAR PROGRESS -->
                                            <div class="user-avatar-progress">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-progress-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS -->

                                            <!-- USER AVATAR PROGRESS BORDER -->
                                            <div class="user-avatar-progress-border">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-border-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS BORDER -->

                                            <!-- USER AVATAR BADGE -->
                                            <div class="user-avatar-badge">
                                                <!-- USER AVATAR BADGE BORDER -->
                                                <div class="user-avatar-badge-border">
                                                </div>
                                                <!-- /USER AVATAR BADGE BORDER -->

                                            </div>
                                            <!-- /USER AVATAR BADGE -->
                                        </div>
                                        <!-- /USER AVATAR -->
                                    </a>
                                    <!-- /USER STATUS AVATAR -->

                                    <!-- USER STATUS TITLE -->
                                    <p class="user-status-title">Un nuevo usuario <a class="bold"><%=v1.getCorreo()%></a> está solicitando la verificación de su <a class="highlighted">correo electrónico</a> con el código de validación <a style="color: #8d7aff"><%=v1.getCodigoValidacion()%></a>.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <!-- USER STATUS ICON -->
                                    <div class="user-status-icon">
                                        <!-- ICON COMMENT -->
                                        <img src="css/iconoVerificarCorreo.png" width="30px" style="opacity: 0.5" alt="">
                                        <!-- /ICON COMMENT -->
                                    </div>
                                    <!-- /USER STATUS ICON -->
                                </div>
                                <!-- /USER STATUS -->
                            </div>
                            <!-- Validación correo -->
                            <%}else{
                                Validacion v2=new DaoValidacion().validacionPorIDNotificacionContrasena(noti.getValidacion().getIdCorreoValidacion());%>
                            <!-- Validación recuperar contraseña -->
                            <div class="dropdown-box-list-item unread">
                                <!-- USER STATUS -->
                                <div class="user-status notification">
                                    <!-- USER STATUS AVATAR -->
                                    <a class="user-status-avatar">
                                        <!-- USER AVATAR -->
                                        <div class="user-avatar small no-outline">
                                            <!-- USER AVATAR CONTENT -->
                                            <div class="user-avatar-content">
                                                <%request.getSession().setAttribute("foto0"+listaNotificacionesCampanita.indexOf(noti),new DaoValidacion().getFotoPerfilPorIDCorreoValidacion(noti.getValidacion().getIdCorreoValidacion()));%>
                                                <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
                                                <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=0<%=listaNotificacionesCampanita.indexOf(noti)%>"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR CONTENT -->

                                            <!-- USER AVATAR PROGRESS -->
                                            <div class="user-avatar-progress">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-progress-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS -->

                                            <!-- USER AVATAR PROGRESS BORDER -->
                                            <div class="user-avatar-progress-border">
                                                <!-- HEXAGON -->
                                                <div class="hexagon-border-40-44"></div>
                                                <!-- /HEXAGON -->
                                            </div>
                                            <!-- /USER AVATAR PROGRESS BORDER -->

                                            <!-- USER AVATAR BADGE -->
                                            <div class="user-avatar-badge">
                                                <!-- USER AVATAR BADGE BORDER -->
                                                <div class="user-avatar-badge-border">
                                                </div>
                                                <!-- /USER AVATAR BADGE BORDER -->

                                            </div>
                                            <!-- /USER AVATAR BADGE -->
                                        </div>
                                        <!-- /USER AVATAR -->
                                    </a>
                                    <!-- /USER STATUS AVATAR -->

                                    <!-- USER STATUS TITLE -->
                                    <p class="user-status-title"><a class="bold"><%=v2.getUsuario().getNombre()%> <%=v2.getUsuario().getApellido()%></a> está solicitando la recuperación de su <a class="highlighted">contraseña</a> con el código de validación <a style="color: #8d7aff"><%=v2.getCodigoValidacion()%></a>.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <!-- USER STATUS ICON -->
                                    <div class="user-status-icon">
                                        <!-- ICON COMMENT -->
                                        <img src="css/iconoCambiarPass.png" width="30px" style="opacity: 0.5" alt="">
                                        <!-- /ICON COMMENT -->
                                    </div>
                                    <!-- /USER STATUS ICON -->
                                </div>
                                <!-- /USER STATUS -->
                            </div>
                            <!-- Validación recuperar contraseña -->
                            <%}}%>
                            <script>
                                function enviarFormulario(idForm) {
                                    var formulario = document.getElementById(idForm);
                                    formulario.submit();
                                }
                            </script>
                        </form>
                        <%}%>
                    </div>
                    <!-- /DROPDOWN BOX LIST -->
                    <!--ARRIBA ESTÁN LAS NOTIFICACIONES-->
                    <!-- DROPDOWN BOX BUTTON -->
                    <a class="dropdown-box-button secondary" href="NotificacionesServlet">Ver todas las notificaciones</a>
                    <!-- /DROPDOWN BOX BUTTON -->
                </div>
                <!-- /DROPDOWN BOX -->
            </div>
            <!-- /ACTION LIST ITEM WRAP -->
        </div>
        <!-- /ACTION LIST -->

        <!-- ACTION ITEM WRAP -->
        <div class="action-item-wrap auxResponsiveUwu">
            <!-- ACTION ITEM -->
            <div class="action-item dark header-settings-dropdown-trigger">
                <!-- ACTION ITEM ICON -->
                <form method="post" action="InicioSesionServlet?action=logOut">
                    <button style="border:0;background: none;color: inherit" type="submit"><a><img src="css/logOut.png" width="30%" style="" alt=""></a></button>
                </form>
                <!-- /ACTION ITEM ICON -->
            </div>
            <!-- /ACTION ITEM -->

            <!-- DROPDOWN NAVIGATION -->

        </div>
        <!-- /ACTION ITEM WRAP -->
    </div>
    <!-- /HEADER ACTIONS -->
    <%}%>
    <!-- /HEADER ACTIONS -->
</header>
<!-- /HEADER -->

<!-- CONTENT GRID -->
<div class="content-grid">
    <!-- SECTION BANNER -->
    <div class="section-banner">
        <!-- SECTION BANNER ICON -->
        <img class="section-banner-icon" src="img/banner/overview-icon.png" alt="overview-icon">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title">Analíticas</p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text">Revisa cómo anda la plataforma mediante estadísticas</p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <!-- SECTION HEADER -->
    <div class="section-header">
        <!-- SECTION HEADER INFO -->
        <div class="section-header-info">
            <!-- SECTION PRETITLE -->
            <p class="section-pretitle">Resumen</p>
            <!-- /SECTION PRETITLE -->

            <!-- SECTION TITLE -->
            <h2 class="section-title">Estadísticas generales</h2>
            <!-- /SECTION TITLE -->
        </div>
        <!-- /SECTION HEADER INFO -->
    </div>
    <!-- /SECTION HEADER -->



    <!-- GRID -->
    <div class="grid">
        <!-- GRID -->
        <div class="grid grid-3-3-3-3 centered">
            <!-- STATS BOX -->
            <div class="stats-box small stat-profile-views">
                <!-- STATS BOX VALUE WRAP -->
                <div class="stats-box-value-wrap">
                    <!-- STATS BOX VALUE -->
                    <p class="stats-box-value">S/. <%=donacionesHoy%></p>
                    <!-- /STATS BOX VALUE -->
                    <!-- STATS BOX DIFF -->
                    <div class="stats-box-diff">
                        <!-- STATS BOX DIFF ICON -->
                        <%float porcentajeHoyRespectoAyerDonaciones=(donacionesHoy-donacionesAyer)*100/donacionesAyer;
                            if(porcentajeHoyRespectoAyerDonaciones<0){%>
                        <div class="stats-box-diff-icon negative">
                            <!-- ICON MINUS SMALL -->
                            <svg class="icon-minus-small">
                                <use xlink:href="#svg-minus-small"></use>
                            </svg>
                            <!-- /ICON MINUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerDonaciones*-1%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}else{%>
                        <!-- STATS BOX DIFF ICON -->
                        <div class="stats-box-diff-icon positive">
                            <!-- ICON PLUS SMALL -->
                            <svg class="icon-plus-small">
                                <use xlink:href="#svg-plus-small"></use>
                            </svg>
                            <!-- /ICON PLUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerDonaciones%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}%>
                    </div>
                    <!-- /STATS BOX DIFF -->
                </div>
                <!-- /STATS BOX VALUE WRAP -->

                <!-- STATS BOX TITLE -->
                <p class="stats-box-title">Monto total de donaciones</p>
                <!-- /STATS BOX TITLE -->

                <!-- STATS BOX TEXT -->
                <p class="stats-box-text">En comparación a ayer</p>
                <!-- /STATS BOX TEXT -->
            </div>
            <!-- /STATS BOX -->

            <!-- STATS BOX -->
            <div class="stats-box small stat-posts-created">
                <!-- STATS BOX VALUE WRAP -->
                <div class="stats-box-value-wrap">
                    <!-- STATS BOX VALUE -->
                    <p class="stats-box-value"><%=reportesHoy%></p>
                    <!-- /STATS BOX VALUE -->

                    <!-- STATS BOX DIFF -->
                    <div class="stats-box-diff">
                        <%float porcentajeHoyRespectoAyerReportes= (float) ((reportesHoy - reportesAyer) * 100) /reportesAyer;
                            if(porcentajeHoyRespectoAyerReportes<0){%>
                        <div class="stats-box-diff-icon negative">
                            <!-- ICON MINUS SMALL -->
                            <svg class="icon-minus-small">
                                <use xlink:href="#svg-minus-small"></use>
                            </svg>
                            <!-- /ICON MINUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerReportes*-1%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}else{%>
                        <!-- STATS BOX DIFF ICON -->
                        <div class="stats-box-diff-icon positive">
                            <!-- ICON PLUS SMALL -->
                            <svg class="icon-plus-small">
                                <use xlink:href="#svg-plus-small"></use>
                            </svg>
                            <!-- /ICON PLUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerReportes%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}%>
                    </div>
                    <!-- /STATS BOX DIFF -->
                </div>
                <!-- /STATS BOX VALUE WRAP -->

                <!-- STATS BOX TITLE -->
                <p class="stats-box-title">Usuarios reportados</p>
                <!-- /STATS BOX TITLE -->

                <!-- STATS BOX TEXT -->
                <p class="stats-box-text">En comparación a ayer</p>
                <!-- /STATS BOX TEXT -->
            </div>
            <!-- /STATS BOX -->

            <!-- STATS BOX -->
            <div class="stats-box small stat-reactions-received">
                <!-- STATS BOX VALUE WRAP -->
                <div class="stats-box-value-wrap">
                    <!-- STATS BOX VALUE -->
                    <p class="stats-box-value"><%=baneosHoy%></p>
                    <!-- /STATS BOX VALUE -->

                    <!-- STATS BOX DIFF -->
                    <div class="stats-box-diff">
                        <%float porcentajeHoyRespectoAyerBaneos= (float) ((baneosHoy - baneosAyer) * 100) /baneosAyer;
                            if(porcentajeHoyRespectoAyerBaneos<0){%>
                        <div class="stats-box-diff-icon negative">
                            <!-- ICON MINUS SMALL -->
                            <svg class="icon-minus-small">
                                <use xlink:href="#svg-minus-small"></use>
                            </svg>
                            <!-- /ICON MINUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerBaneos*-1%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}else{%>
                        <!-- STATS BOX DIFF ICON -->
                        <div class="stats-box-diff-icon positive">
                            <!-- ICON PLUS SMALL -->
                            <svg class="icon-plus-small">
                                <use xlink:href="#svg-plus-small"></use>
                            </svg>
                            <!-- /ICON PLUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerBaneos%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}%>
                    </div>
                    <!-- /STATS BOX DIFF -->
                </div>
                <!-- /STATS BOX VALUE WRAP -->

                <!-- STATS BOX TITLE -->
                <p class="stats-box-title">Usuarios baneados</p>
                <!-- /STATS BOX TITLE -->

                <!-- STATS BOX TEXT -->
                <p class="stats-box-text">En comparación a ayer</p>
                <!-- /STATS BOX TEXT -->
            </div>
            <!-- /STATS BOX -->

            <!-- STATS BOX -->
            <div class="stats-box small stat-comments-received">
                <!-- STATS BOX VALUE WRAP -->
                <div class="stats-box-value-wrap">
                    <!-- STATS BOX VALUE -->
                    <p class="stats-box-value"><%=solicitudesApoyoHoy%></p>
                    <!-- /STATS BOX VALUE -->

                    <!-- STATS BOX DIFF -->
                    <div class="stats-box-diff">
                        <%float porcentajeHoyRespectoAyerSolicitudesApoyo= (float) ((solicitudesApoyoHoy - solicitudesApoyoAyer) * 100) /solicitudesApoyoAyer;
                            if(porcentajeHoyRespectoAyerSolicitudesApoyo<0){%>
                        <div class="stats-box-diff-icon negative">
                            <!-- ICON MINUS SMALL -->
                            <svg class="icon-minus-small">
                                <use xlink:href="#svg-minus-small"></use>
                            </svg>
                            <!-- /ICON MINUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerSolicitudesApoyo*-1%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}else{%>
                        <!-- STATS BOX DIFF ICON -->
                        <div class="stats-box-diff-icon positive">
                            <!-- ICON PLUS SMALL -->
                            <svg class="icon-plus-small">
                                <use xlink:href="#svg-plus-small"></use>
                            </svg>
                            <!-- /ICON PLUS SMALL -->
                        </div>
                        <!-- /STATS BOX DIFF ICON -->
                        <!-- STATS BOX DIFF VALUE -->
                        <p class="stats-box-diff-value"><%=porcentajeHoyRespectoAyerSolicitudesApoyo%>%</p>
                        <!-- /STATS BOX DIFF VALUE -->
                        <%}%>
                    </div>
                    <!-- /STATS BOX DIFF -->
                </div>
                <!-- /STATS BOX VALUE WRAP -->

                <!-- STATS BOX TITLE -->
                <p class="stats-box-title">Solicitudes para apoyar</p>
                <!-- /STATS BOX TITLE -->

                <!-- STATS BOX TEXT -->
                <p class="stats-box-text">En comparación a ayer</p>
                <!-- /STATS BOX TEXT -->
            </div>
            <!-- /STATS BOX -->
        </div>
        <!-- /GRID -->

        <!-- GRID -->
        <div class="grid grid-6-6 stretched">
            <!-- GRID COLUMN -->
            <div class="grid-column">
                <!-- widget BOX -->
                <div class="widget-box">
                    <!-- widget BOX ACTIONS -->
                    <div class="widget-box-actions">
                        <!-- widget BOX ACTION -->
                        <div class="widget-box-action">
                            <!-- widget BOX TITLE -->
                            <p class="widget-box-title">Usuarios registrados</p>
                            <!-- /widget BOX TITLE -->
                        </div>
                        <!-- /widget BOX ACTION -->
                    </div>
                    <!-- /widget BOX ACTIONS -->

                    <!-- widget BOX CONTENT -->
                    <div class="widget-box-content">
                        <!-- PROGRESS ARC WRAP -->
                        <div class="progress-arc-wrap">
                            <!-- PROGRESS ARC -->
                            <div class="progress-arc">
                                <canvas id="engagements-chart"></canvas>
                            </div>
                            <!-- PROGRESS ARC -->

                            <!-- PROGRESS ARC INFO -->
                            <div class="progress-arc-info">
                                <!-- PROGRESS ARC TITLE -->
                                <p class="progress-arc-title"><%=totalEstudiantesRegistrados+totalEgresadosRegistrados%></p>
                                <!-- /PROGRESS ARC TITLE -->

                                <!-- PROGRESS ARC TEXT -->
                                <p class="progress-arc-text">Usuarios</p>
                                <!-- /PROGRESS ARC TEXT -->
                            </div>
                            <!-- /PROGRESS ARC INFO -->
                        </div>
                        <!-- /PROGRESS ARC WRAP -->

                        <!-- USER STATS -->
                        <div class="user-stats reference">
                            <!-- USER STAT -->
                            <div class="user-stat big">
                                <!-- REFERENCE BULLET -->
                                <div class="reference-bullet secondary"></div>
                                <!-- /REFERENCE BULLET -->

                                <!-- USER STAT TITLE -->
                                <p class="user-stat-title"><%=totalEstudiantesRegistrados%></p>
                                <!-- /USER STAT TITLE -->

                                <!-- USER STAT TEXT -->
                                <p class="user-stat-text">Estudiantes</p>
                                <!-- /USER STAT TEXT -->
                            </div>
                            <!-- /USER STAT -->

                            <!-- USER STAT -->
                            <div class="user-stat big">
                                <!-- REFERENCE BULLET -->
                                <div class="reference-bullet primary"></div>
                                <!-- /REFERENCE BULLET -->

                                <!-- USER STAT TITLE -->
                                <p class="user-stat-title"><%=totalEgresadosRegistrados%></p>
                                <!-- /USER STAT TITLE -->

                                <!-- USER STAT TEXT -->
                                <p class="user-stat-text">Egresados</p>
                                <!-- /USER STAT TEXT -->
                            </div>
                            <!-- /USER STAT -->
                        </div>
                        <!-- /USER STATS -->
                    </div>
                    <!-- widget BOX CONTENT -->
                </div>
                <!-- /widget BOX -->
            </div>
            <!-- /GRID COLUMN -->

            <!-- GRID COLUMN -->
            <div class="grid-column">
                <!-- widget BOX -->
                <div class="widget-box">
                    <!-- widget BOX ACTIONS -->
                    <div class="widget-box-actions">
                        <!-- widget BOX ACTION -->
                        <div class="widget-box-action">
                            <!-- widget BOX TITLE -->
                            <p class="widget-box-title">Donaciones totales</p>
                            <!-- /widget BOX TITLE -->
                        </div>
                        <!-- /widget BOX ACTION -->
                    </div>
                    <!-- /widget BOX ACTIONS -->

                    <!-- widget BOX CONTENT -->
                    <div class="widget-box-content">
                        <!-- PROGRESS ARC WRAP -->
                        <div class="progress-arc-wrap">
                            <!-- PROGRESS ARC -->
                            <div class="progress-arc">
                                <canvas id="engagements-chart-donacion"></canvas>
                            </div>
                            <!-- PROGRESS ARC -->

                            <!-- PROGRESS ARC INFO -->
                            <div class="progress-arc-info">
                                <!-- PROGRESS ARC TITLE -->
                                <p class="progress-arc-title"><%=totalDonacionesEgresados+totalDonacionesEstudiantes%></p>
                                <!-- /PROGRESS ARC TITLE -->

                                <!-- PROGRESS ARC TEXT -->
                                <p class="progress-arc-text">Nuevos soles</p>
                                <!-- /PROGRESS ARC TEXT -->
                            </div>
                            <!-- /PROGRESS ARC INFO -->
                        </div>
                        <!-- /PROGRESS ARC WRAP -->

                        <!-- USER STATS -->
                        <div class="user-stats reference">
                            <!-- USER STAT -->
                            <div class="user-stat big">
                                <!-- REFERENCE BULLET -->
                                <div class="reference-bullet secondary"></div>
                                <!-- /REFERENCE BULLET -->

                                <!-- USER STAT TITLE -->
                                <p class="user-stat-title">S/. <%=totalDonacionesEstudiantes%></p>
                                <!-- /USER STAT TITLE -->

                                <!-- USER STAT TEXT -->
                                <p class="user-stat-text">Estudiantes</p>
                                <!-- /USER STAT TEXT -->
                            </div>
                            <!-- /USER STAT -->

                            <!-- USER STAT -->
                            <div class="user-stat big">
                                <!-- REFERENCE BULLET -->
                                <div class="reference-bullet primary"></div>
                                <!-- /REFERENCE BULLET -->

                                <!-- USER STAT TITLE -->
                                <p class="user-stat-title">S/. <%=totalDonacionesEgresados%></p>
                                <!-- /USER STAT TITLE -->

                                <!-- USER STAT TEXT -->
                                <p class="user-stat-text">Egresados</p>
                                <!-- /USER STAT TEXT -->
                            </div>
                            <!-- /USER STAT -->
                        </div>
                        <!-- /USER STATS -->
                    </div>
                    <!-- widget BOX CONTENT -->
                </div>
                <!-- /widget BOX -->
            </div>
            <!-- /GRID COLUMN -->
        </div>
        <!-- /GRID -->







        <!-- GRID -->
        <div class="grid grid-3-3-3-3 centered">
            <!-- FEATURED STAT BOX -->
            <div class="featured-stat-box reactioner">
                <!-- FEATURED STAT BOX COVER -->
                <div class="featured-stat-box-cover">
                    <!-- FEATURED STAT BOX COVER TITLE -->
                    <p class="featured-stat-box-cover-title">Top Donador</p>
                    <!-- /FEATURED STAT BOX COVER TITLE -->

                    <!-- FEATURED STAT BOX COVER TEXT -->
                    <p class="featured-stat-box-cover-text">en la última semana</p>
                    <!-- /FEATURED STAT BOX COVER TEXT -->
                </div>
                <!-- /FEATURED STAT BOX COVER -->

                <!-- FEATURED STAT BOX INFO -->
                <div class="featured-stat-box-info">
                    <!-- USER AVATAR -->
                    <div class="user-avatar small">
                        <!-- USER AVATAR BORDER -->
                        <div class="user-avatar-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-50-56"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR BORDER -->

                        <!-- USER AVATAR CONTENT -->
                        <div class="user-avatar-content">
                            <%request.getSession().setAttribute("foto1",topDonadorUltimaSemana.getUsuario().getFotoPerfil());%>
                            <!-- HEXAGON -->
                            <div class="hexagon-image-30-32" data-src="Imagen?id=1"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR CONTENT -->

                        <!-- USER AVATAR PROGRESS -->
                        <div class="user-avatar-progress">
                            <!-- HEXAGON -->
                            <div class="hexagon-progress-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS -->

                        <!-- USER AVATAR PROGRESS BORDER -->
                        <div class="user-avatar-progress-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-border-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS BORDER -->

                        <!-- USER AVATAR BADGE -->

                        <!-- /USER AVATAR BADGE -->
                    </div>
                    <!-- /USER AVATAR -->

                    <!-- FEATURED STAT BOX TITLE -->
                    <p class="featured-stat-box-title"><%=topDonadorUltimaSemana.getMontoTotal()%></p>
                    <!-- /FEATURED STAT BOX TITLE -->

                    <!-- FEATURED STAT BOX SUBTITLE -->
                    <p class="featured-stat-box-subtitle">Nuevos soles</p>
                    <!-- /FEATURED STAT BOX SUBTITLE -->

                    <!-- FEATURED STAT BOX TEXT -->
                    <p class="featured-stat-box-text"><%=topDonadorUltimaSemana.getUsuario().getNombre()+" "+topDonadorUltimaSemana.getUsuario().getApellido()%></p>
                    <!-- /FEATURED STAT BOX TEXT -->
                </div>
                <!-- /FEATURED STAT BOX INFO -->
            </div>
            <!-- /FEATURED STAT BOX -->

            <!-- FEATURED STAT BOX -->
            <div class="featured-stat-box reactioner">
                <!-- FEATURED STAT BOX COVER -->
                <div class="featured-stat-box-cover">
                    <!-- FEATURED STAT BOX COVER TITLE -->
                    <p class="featured-stat-box-cover-title">Top Donador</p>
                    <!-- /FEATURED STAT BOX COVER TITLE -->

                    <!-- FEATURED STAT BOX COVER TEXT -->
                    <p class="featured-stat-box-cover-text">de todos los tiempos</p>
                    <!-- /FEATURED STAT BOX COVER TEXT -->
                </div>
                <!-- /FEATURED STAT BOX COVER -->

                <!-- FEATURED STAT BOX INFO -->
                <div class="featured-stat-box-info">
                    <!-- USER AVATAR -->
                    <div class="user-avatar small">
                        <!-- USER AVATAR BORDER -->
                        <div class="user-avatar-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-50-56"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR BORDER -->

                        <!-- USER AVATAR CONTENT -->
                        <div class="user-avatar-content">
                            <%request.getSession().setAttribute("foto2",topDonadorTotal.getUsuario().getFotoPerfil());%>
                            <!-- HEXAGON -->
                            <div class="hexagon-image-30-32" data-src="Imagen?id=2"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR CONTENT -->

                        <!-- USER AVATAR PROGRESS -->
                        <div class="user-avatar-progress">
                            <!-- HEXAGON -->
                            <div class="hexagon-progress-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS -->

                        <!-- USER AVATAR PROGRESS BORDER -->
                        <div class="user-avatar-progress-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-border-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS BORDER -->
                    </div>
                    <!-- /USER AVATAR -->

                    <!-- FEATURED STAT BOX TITLE -->
                    <p class="featured-stat-box-title"><%=topDonadorTotal.getMontoTotal()%></p>
                    <!-- /FEATURED STAT BOX TITLE -->

                    <!-- FEATURED STAT BOX SUBTITLE -->
                    <p class="featured-stat-box-subtitle">Nuevos soles</p>
                    <!-- /FEATURED STAT BOX SUBTITLE -->

                    <!-- FEATURED STAT BOX TEXT -->
                    <p class="featured-stat-box-text"><%=topDonadorTotal.getUsuario().getNombre()+" "+topDonadorTotal.getUsuario().getApellido()%></p>
                    <!-- /FEATURED STAT BOX TEXT -->
                </div>
                <!-- /FEATURED STAT BOX INFO -->
            </div>
            <!-- /FEATURED STAT BOX -->

            <!-- FEATURED STAT BOX -->
            <div class="featured-stat-box commenter">
                <!-- FEATURED STAT BOX COVER -->
                <div class="featured-stat-box-cover">
                    <!-- FEATURED STAT BOX COVER TITLE -->
                    <p class="featured-stat-box-cover-title">Top Apoyo</p>
                    <!-- /FEATURED STAT BOX COVER TITLE -->

                    <!-- FEATURED STAT BOX COVER TEXT -->
                    <p class="featured-stat-box-cover-text">en la última semana</p>
                    <!-- /FEATURED STAT BOX COVER TEXT -->
                </div>
                <!-- /FEATURED STAT BOX COVER -->

                <!-- FEATURED STAT BOX INFO -->
                <div class="featured-stat-box-info">
                    <!-- USER AVATAR -->
                    <div class="user-avatar small">
                        <!-- USER AVATAR BORDER -->
                        <div class="user-avatar-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-50-56"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR BORDER -->

                        <!-- USER AVATAR CONTENT -->
                        <div class="user-avatar-content">
                            <!-- HEXAGON AQUÍ SE PONE LA FOTO DEL TOP APOYO ÚLTIMA SEMANA-->
                            <%request.getSession().setAttribute("foto3",topApoyoUltimaSemana.getUsuario().getFotoPerfil());%>
                            <div class="hexagon-image-30-32" data-src="Imagen?id=3"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR CONTENT -->

                        <!-- USER AVATAR PROGRESS -->
                        <div class="user-avatar-progress">
                            <!-- HEXAGON -->
                            <div class="hexagon-progress-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS -->

                        <!-- USER AVATAR PROGRESS BORDER -->
                        <div class="user-avatar-progress-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-border-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS BORDER -->

                    </div>
                    <!-- /USER AVATAR -->

                    <!-- FEATURED STAT BOX TITLE -->
                    <p class="featured-stat-box-title"><%=topApoyoUltimaSemana.getCantidadEventosApoyados()%></p>
                    <!-- /FEATURED STAT BOX TITLE -->

                    <!-- FEATURED STAT BOX SUBTITLE -->
                    <p class="featured-stat-box-subtitle">Eventos</p>
                    <!-- /FEATURED STAT BOX SUBTITLE -->

                    <!-- FEATURED STAT BOX TEXT -->
                    <p class="featured-stat-box-text"><%=topApoyoUltimaSemana.getUsuario().getNombre()%> <%=topApoyoUltimaSemana.getUsuario().getApellido()%></p>
                    <!-- /FEATURED STAT BOX TEXT -->
                </div>
                <!-- /FEATURED STAT BOX INFO -->
            </div>
            <!-- /FEATURED STAT BOX -->

            <!-- FEATURED STAT BOX -->
            <div class="featured-stat-box commenter">
                <!-- FEATURED STAT BOX COVER -->
                <div class="featured-stat-box-cover">
                    <!-- FEATURED STAT BOX COVER TITLE -->
                    <p class="featured-stat-box-cover-title">Top Apoyo</p>
                    <!-- /FEATURED STAT BOX COVER TITLE -->

                    <!-- FEATURED STAT BOX COVER TEXT -->
                    <p class="featured-stat-box-cover-text">de todos los tiempos</p>
                    <!-- /FEATURED STAT BOX COVER TEXT -->
                </div>
                <!-- /FEATURED STAT BOX COVER -->

                <!-- FEATURED STAT BOX INFO -->
                <div class="featured-stat-box-info">
                    <!-- USER AVATAR -->
                    <div class="user-avatar small">
                        <!-- USER AVATAR BORDER -->
                        <div class="user-avatar-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-50-56"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR BORDER -->

                        <!-- USER AVATAR CONTENT -->
                        <div class="user-avatar-content">
                            <!-- HEXAGON AQUÍ SE PONE LA FOTO DEL TOP APOYO TOTAL-->
                            <%request.getSession().setAttribute("foto4",topApoyoTotal.getUsuario().getFotoPerfil());%>
                            <div class="hexagon-image-30-32" data-src="Imagen?id=4"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR CONTENT -->

                        <!-- USER AVATAR PROGRESS -->
                        <div class="user-avatar-progress">
                            <!-- HEXAGON -->
                            <div class="hexagon-progress-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS -->

                        <!-- USER AVATAR PROGRESS BORDER -->
                        <div class="user-avatar-progress-border">
                            <!-- HEXAGON -->
                            <div class="hexagon-border-40-44"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR PROGRESS BORDER -->


                    </div>
                    <!-- /USER AVATAR -->

                    <!-- FEATURED STAT BOX TITLE -->
                    <p class="featured-stat-box-title"><%=topApoyoTotal.getCantidadEventosApoyados()%></p>
                    <!-- /FEATURED STAT BOX TITLE -->

                    <!-- FEATURED STAT BOX SUBTITLE -->
                    <p class="featured-stat-box-subtitle">Eventos</p>
                    <!-- /FEATURED STAT BOX SUBTITLE -->

                    <!-- FEATURED STAT BOX TEXT -->
                    <p class="featured-stat-box-text"><%=topApoyoTotal.getUsuario().getNombre()%> <%=topApoyoTotal.getUsuario().getApellido()%></p>
                    <!-- /FEATURED STAT BOX TEXT -->
                </div>
                <!-- /FEATURED STAT BOX INFO -->
            </div>
            <!-- /FEATURED STAT BOX -->
        </div>
        <!-- /GRID -->

        <!-- SECTION HEADER -->
        <div class="section-header">
            <!-- SECTION HEADER INFO -->
            <div class="section-header-info">
                <!-- SECTION PRETITLE -->
                <p class="section-pretitle">Resumen</p>
                <!-- /SECTION PRETITLE -->

                <!-- SECTION TITLE -->
                <h2 class="section-title">Estadísticas detalladas</h2>
                <!-- /SECTION TITLE -->
            </div>
            <!-- /SECTION HEADER INFO -->
        </div>
        <!-- /SECTION HEADER -->

        <div class="widget-box">
            <!-- WIDGET BOX ACTIONS -->
            <div class="widget-box-actions">
                <!-- WIDGET BOX ACTION -->
                <div class="widget-box-action">
                    <!-- WIDGET BOX TITLE -->
                    <p class="widget-box-title">Revisión de cantidad de apoyos por actividad</p>
                    <!-- /WIDGET BOX TITLE -->
                </div>
                <!-- /WIDGET BOX ACTION -->

                <!-- WIDGET BOX ACTION -->
                <div class="widget-box-action">
                    <!-- REFERENCE ITEM LIST -->
                    <div class="reference-item-list">
                        <!-- REFERENCE ITEM -->
                        <div class="reference-item">
                            <!-- REFERENCE BULLET -->
                            <div class="reference-bullet primary"></div>
                            <!-- REFERENCE BULLET -->

                            <!-- REFERENCE ITEM TEXT -->
                            <p class="reference-item-text">Egresados</p>
                            <!-- /REFERENCE ITEM TEXT -->
                        </div>
                        <!-- /REFERENCE ITEM -->

                        <!-- REFERENCE ITEM -->
                        <div class="reference-item">
                            <!-- REFERENCE BULLET -->
                            <div class="reference-bullet secondary"></div>
                            <!-- REFERENCE BULLET -->

                            <!-- REFERENCE ITEM TEXT -->
                            <p class="reference-item-text">Estudiantes</p>
                            <!-- /REFERENCE ITEM TEXT -->
                        </div>
                        <!-- /REFERENCE ITEM -->
                    </div>
                    <!-- /REFERENCE ITEM LIST -->
                </div>
                <!-- /WIDGET BOX ACTION -->
            </div>
            <!-- /WIDGET BOX ACTIONS -->

            <!-- WIDGET BOX CONTENT -->
            <div class="widget-box-content">
                <!-- CHART WRAP -->
                <div class="chart-wrap">
                    <!-- CHART -->
                    <div class="chart">
                        <canvas id="ve-monthly-report-chart"></canvas>
                    </div>
                    <!-- /CHART -->
                </div>
                <!-- /CHART WRAP -->
            </div>
            <!-- WIDGET BOX CONTENT -->

            <!-- WIDGET BOX FOOTER -->
            <div class="widget-box-footer">
                <!-- CHART INFO -->
                <div class="chart-info">
                    <!-- PROGRESS ARC WRAP -->
                    <div class="progress-arc-wrap tiny">
                        <!-- PROGRESS ARC -->
                        <div class="progress-arc">
                            <canvas id="ve-monthly-report-ratio-chart"></canvas>
                        </div>
                        <!-- PROGRESS ARC -->

                        <!-- PROGRESS ARC INFO -->
                        <div class="progress-arc-info">
                            <!-- PROGRESS ARC TITLE -->
                            <p class="progress-arc-title">Ratio</p>
                            <!-- /PROGRESS ARC TITLE -->
                        </div>
                        <!-- /PROGRESS ARC INFO -->
                    </div>
                    <!-- /PROGRESS ARC WRAP -->

                    <!-- USER STATS -->
                    <div class="user-stats">
                        <!-- USER STAT -->
                        <div class="user-stat big">
                            <!-- USER STAT TITLE -->
                            <p class="user-stat-title"><%=cantidadTotalApoyosEgresados+cantidadTotalApoyosEstudiantes%></p>
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text">Total de apoyos</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat big">
                            <!-- USER STAT TITLE -->
                            <p class="user-stat-title"><%=cantidadTotalApoyosEstudiantes%></p>
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text">Estudiantes</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat big">
                            <!-- USER STAT TITLE -->
                            <p class="user-stat-title"><%=cantidadTotalApoyosEgresados%></p>
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text">Egresados</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat big">
                            <%int posicionMayorCantidadApoyos=0;
                                int mayorCantidadApoyos=0;
                                for(int i=0;i<listaNombresActividadesOrden.size();i++){
                                    if(cantidadApoyosEstudiantesPorActividadOrden.get(i)+cantidadApoyosEgresadosPorActividadOrden.get(i)>mayorCantidadApoyos){
                                        mayorCantidadApoyos=cantidadApoyosEgresadosPorActividadOrden.get(i)+cantidadApoyosEstudiantesPorActividadOrden.get(i);
                                        posicionMayorCantidadApoyos=i;
                                    }
                                }
                            %>
                            <!-- USER STAT TITLE -->
                            <p class="user-stat-title"><%=listaNombresActividadesOrden.get(posicionMayorCantidadApoyos)%></p>
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text">Mayor cantidad de apoyos</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat big">
                            <%int posicionMenorCantidadApoyos=0;
                                int menorCantidadApoyos=999999;
                                for(int i=0;i<listaNombresActividadesOrden.size();i++){
                                    if(cantidadApoyosEstudiantesPorActividadOrden.get(i)+cantidadApoyosEgresadosPorActividadOrden.get(i)>menorCantidadApoyos){
                                        menorCantidadApoyos=cantidadApoyosEgresadosPorActividadOrden.get(i)+cantidadApoyosEstudiantesPorActividadOrden.get(i);
                                        posicionMenorCantidadApoyos=i;
                                    }
                                }
                            %>
                            <!-- USER STAT TITLE -->
                            <p class="user-stat-title"><%=listaNombresActividadesOrden.get(posicionMenorCantidadApoyos)%></p>
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text">Menor cantidad de apoyos</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat big">
                            <!-- USER STAT TITLE -->
                            <p class="user-stat-title"><%=(cantidadTotalApoyosEgresados+cantidadTotalApoyosEstudiantes)/listaNombresActividadesOrden.size()%></p>
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text">Promedio de apoyos por actividad</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                    </div>
                    <!-- /USER STATS -->
                </div>
                <!-- /CHART INFO -->
            </div>
            <!-- /WIDGET BOX FOOTER -->
        </div>



        <!-- WIDGET BOX -->
        <div class="widget-box">

            <div class="widget-box-actions">
                <!-- WIDGET BOX ACTION -->
                <div class="widget-box-action">
                    <!-- WIDGET BOX TITLE -->
                    <p class="widget-box-title">Recaudaciones por donación en la última semana</p>
                    <!-- /WIDGET BOX TITLE -->
                </div>
                <!-- /WIDGET BOX ACTION -->

                <!-- WIDGET BOX ACTION -->
                <div class="widget-box-action">
                    <!-- REFERENCE ITEM LIST -->
                    <div class="reference-item-list">
                        <!-- REFERENCE ITEM -->
                        <div class="reference-item">
                            <!-- REFERENCE BULLET -->
                            <div class="reference-bullet primary"></div>
                            <!-- REFERENCE BULLET -->

                            <!-- REFERENCE ITEM TEXT -->
                            <p class="reference-item-text">Egresados</p>
                            <!-- /REFERENCE ITEM TEXT -->
                        </div>
                        <!-- /REFERENCE ITEM -->

                        <!-- REFERENCE ITEM -->
                        <div class="reference-item">
                            <!-- REFERENCE BULLET -->
                            <div class="reference-bullet secondary"></div>
                            <!-- REFERENCE BULLET -->

                            <!-- REFERENCE ITEM TEXT -->
                            <p class="reference-item-text">Estudiantes</p>
                            <!-- /REFERENCE ITEM TEXT -->
                        </div>
                        <!-- /REFERENCE ITEM -->
                    </div>
                    <!-- /REFERENCE ITEM LIST -->
                </div>
                <!-- /WIDGET BOX ACTION -->
            </div>
            <!-- WIDGET BOX CONTENT -->
            <div class="widget-box-content">
                <!-- CHART WRAP -->
                <div class="chart-wrap">
                    <!-- CHART -->
                    <div class="chart">
                        <canvas id="rc-yearly-report-chart"></canvas>
                    </div>
                    <!-- /CHART -->
                </div>
                <!-- /CHART WRAP -->
            </div>
            <!-- WIDGET BOX CONTENT -->
        </div>
        <!-- /WIDGET BOX -->
    </div>
    <!-- /GRID -->
</div>

<!-- /CONTENT GRID -->
<footer style="font-size: 80%;">
    <!-- Primera fila -->
    <div class="fila">
        <div class="columna">
            <span class="titulo">Contactos</span>
            <ul class="lista">
                <%for(int i=0;i<listaCorreosDelegadosGenerales.size();i++){%>
                <li>Delegado general <%=(i+1)%>: <a href="mailto:<%=listaCorreosDelegadosGenerales.get(i)%>"><%=listaCorreosDelegadosGenerales.get(i)%></a></li>
                <%}%>
            </ul>
        </div>
        <div class="columna">
            <span class="titulo">© 2023 Fibra tóxica</span>
            <ul class="lista">
                <li><a href="enlace-de-politica-de-privacidad">Política de Privacidad</a></li>
            </ul>
            <span class="titulo">Síguenos en:</span>
            <ul class="lista">
                <li>
                    <a href="https://www.facebook.com/profile.php?id=100010710095134"><i class="fab fa-facebook"></i></a>   <a href="https://www.instagram.com/fibra.toxic/"><i class="fab fa-instagram"></i></a>   <a href="https://www.instagram.com/fibra.toxic/"><i class="fab fa-youtube"></i></a>
                </li>
            </ul>
        </div>
        <div class="columna">
            <span class="titulo">Sobre nosotros</span>
            <ul class="lista">
                <li>Somos un grupo de estudiantes que</li>
                <li>busca conectar a todos los amantes</li>
                <li>de esta maravillosa carrera</li>
            </ul>
        </div>
    </div>
</footer>
<!-- app -->
<script>
    const app = {
        deepExtend: function (a, b) {
            for (const prop in b) {
                if (typeof b[prop] === 'object') {
                    a[prop] = b[prop] instanceof Array ? [] : {};
                    this.deepExtend(a[prop], b[prop]);
                } else {
                    a[prop] = b[prop];
                }
            }
        },
        query: function (options) {
            const config = {
                method: 'GET',
                async: true,
                header: {
                    type: 'Content-type',
                    value: 'application/json'
                },
                data: ''
            };

            this.deepExtend(config, options);

            return new Promise( function (resolve, reject) {
                const xhttp = new XMLHttpRequest();

                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState !== 4) return;

                    if (xhttp.status === 200) {
                        resolve(xhttp.responseText);
                    } else {
                        reject({
                            status: xhttp.status,
                            statusText: xhttp.statusText
                        });
                    }
                };

                xhttp.open(config.method, config.url, config.async);
                xhttp.setRequestHeader(config.header.type, config.header.value);

                if (config.method === 'GET') {
                    xhttp.send();
                } else if (config.method === 'POST') {
                    xhttp.send(config.data);
                }
            });
        },
        querySelector: function (selector, callback) {
            const el = document.querySelectorAll(selector);

            if (el.length) {
                callback(el);
            }
        },
        liquidify: function (el) {
            const image = el.querySelector('img'),
                imageSrc = image.getAttribute('src');

            image.style.display = 'none';
            el.style.background = `url("${imageSrc}") no-repeat center`;
            el.style.backgroundSize = 'cover';
        },
        liquidifyStatic: function (figure, image) {
            image.style.display = 'none';
            figure.style.background = `url("${image.getAttribute('src')}") no-repeat center`;
            figure.style.backgroundSize = 'cover';
        },
        dateDiff: function (date1, date2 = new Date()) {
            const timeDiff = Math.abs(date1.getTime() - date2.getTime()),
                secondsDiff = Math.ceil(timeDiff / (1000)),
                minutesDiff = Math.floor(timeDiff / (1000 * 60)),
                hoursDiff = Math.floor(timeDiff / (1000 * 60 * 60)),
                daysDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24)),
                weeksDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 7)),
                monthsDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 7 * 4)),
                yearsDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24 * 7 * 4 * 12));

            let unit;

            if (secondsDiff < 60) {
                unit = secondsDiff === 1 ? 'second' : 'seconds';

                return {
                    unit: unit,
                    value: secondsDiff
                }
            } else if (minutesDiff < 60) {
                unit = minutesDiff === 1 ? 'minute' : 'minutes';

                return {
                    unit: unit,
                    value: minutesDiff
                }
            } else if (hoursDiff < 24) {
                unit = hoursDiff === 1 ? 'hour' : 'hours';

                return {
                    unit: unit,
                    value: hoursDiff
                }
            } else if (daysDiff < 7) {
                unit = daysDiff === 1 ? 'day' : 'days';

                return {
                    unit: unit,
                    value: daysDiff
                }
            } else if (weeksDiff < 4) {
                unit = weeksDiff === 1 ? 'week' : 'weeks';

                return {
                    unit: unit,
                    value: weeksDiff
                }
            } else if (monthsDiff < 12) {
                unit = monthsDiff === 1 ? 'month' : 'months';

                return {
                    unit: unit,
                    value: monthsDiff
                }
            } else {
                unit = yearsDiff === 1 ? 'year' : 'years';

                return {
                    unit: unit,
                    value: yearsDiff
                }
            }
        },
        existsInDOM: function (selector) {
            return document.querySelectorAll(selector).length;
        },
        plugins: {
            createTab: function (options) {
                if (app.existsInDOM(options.triggers) && app.existsInDOM(options.elements)) {
                    return new XM_Tab(options);
                }
            },
            createHexagon: function (options) {
                if (app.existsInDOM(options.container) || typeof options.containerElement !== 'undefined') {
                    return new XM_Hexagon(options);
                }
            },
            createProgressBar: function (options) {
                if (app.existsInDOM(options.container)) {
                    return new XM_ProgressBar(options);
                }
            },
            createDropdown: function (options) {
                if (((app.existsInDOM(options.container) || typeof options.containerElement !== 'undefined') && options.controlToggle) || ((app.existsInDOM(options.trigger) || typeof options.triggerElement !== 'undefined') && (app.existsInDOM(options.container) || typeof options.containerElement !== 'undefined'))) {
                    return new XM_Dropdown(options);
                }
            },
            createTooltip: function (options) {
                if (app.existsInDOM(options.container)) {
                    return new XM_Tooltip(options);
                }
            },
            createSlider: function (options) {
                if (app.existsInDOM(options.container)) {
                    return tns(options);
                }
            },
            createPopup: function (options) {
                if (app.existsInDOM(options.container) && app.existsInDOM(options.trigger)) {
                    return new XM_Popup(options);
                }
            },
            createAccordion: function (options) {
                if (app.existsInDOM(options.triggerSelector) && app.existsInDOM(options.contentSelector)) {
                    return new XM_Accordion(options);
                }
            },
            createChart: function (ctx, options) {
                return new Chart(ctx, options);
            }
        }
    };
</script>
<!-- page loader -->
<script src="js/utils/page-loader.js"></script>
<!-- simplebar -->
<script src="js/vendor/simplebar.min.js"></script>
<!-- liquidify -->
<script>
    app.querySelector('.liquid', function (images) {
        for (const image of images) {
            app.liquidify(image);
        }
    });
</script>
<!-- XM_Plugins -->
<script src="js/vendor/xm_plugins.min.js"></script>
<!-- tiny-slider -->
<script src="js/vendor/tiny-slider.min.js"></script>
<!-- chartJS -->
<script src="js/vendor/Chart.bundle.min.js"></script>
<!-- global.hexagons -->
<script>
    /*---------------------------
    USER AVATAR HEXAGONS
---------------------------*/
    app.plugins.createHexagon({
        container: '.hexagon-148-164',
        width: 148,
        height: 164,
        roundedCorners: true,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-progress-124-136',
        width: 124,
        height: 136,
        lineWidth: 8,
        roundedCorners: true,
        gradient: {
            colors: ['#41efff', '#615dfa']
        },
        scale: {
            start: 0,
            end: 1,
            stop: .74
        }
    });

    app.plugins.createHexagon({
        container: '.hexagon-border-124-136',
        width: 124,
        height: 136,
        lineWidth: 8,
        roundedCorners: true,
        lineColor: '#e7e8ee'
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-100-110',
        width: 100,
        height: 110,
        roundedCorners: true,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-120-132',
        width: 120,
        height: 132,
        roundedCorners: true,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-progress-100-110',
        width: 100,
        height: 110,
        lineWidth: 6,
        roundedCorners: true,
        gradient: {
            colors: ['#41efff', '#615dfa']
        },
        scale: {
            start: 0,
            end: 1,
            stop: .8
        }
    });

    app.plugins.createHexagon({
        container: '.hexagon-border-100-110',
        width: 100,
        height: 110,
        lineWidth: 6,
        roundedCorners: true,
        lineColor: '#e7e8ee'
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-82-90',
        width: 82,
        height: 90,
        roundedCorners: true,
        roundedCornerRadius: 3,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-100-110',
        width: 100,
        height: 110,
        roundedCorners: true,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-progress-84-92',
        width: 84,
        height: 92,
        lineWidth: 5,
        roundedCorners: true,
        roundedCornerRadius: 3,
        gradient: {
            colors: ['#41efff', '#615dfa']
        },
        scale: {
            start: 0,
            end: 1,
            stop: .8
        }
    });

    app.plugins.createHexagon({
        container: '.hexagon-border-84-92',
        width: 84,
        height: 92,
        lineWidth: 5,
        roundedCorners: true,
        roundedCornerRadius: 3,
        lineColor: '#e7e8ee'
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-68-74',
        width: 68,
        height: 74,
        roundedCorners: true,
        roundedCornerRadius: 3,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-50-56',
        width: 50,
        height: 56,
        roundedCorners: true,
        roundedCornerRadius: 2,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-progress-40-44',
        width: 40,
        height: 44,
        lineWidth: 3,
        roundedCorners: true,
        roundedCornerRadius: 1,
        gradient: {
            colors: ['#41efff', '#615dfa']
        },
        scale: {
            start: 0,
            end: 1,
            stop: .8
        }
    });

    app.plugins.createHexagon({
        container: '.hexagon-border-40-44',
        width: 40,
        height: 44,
        lineWidth: 3,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#e7e8ee'
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-30-32',
        width: 30,
        height: 32,
        roundedCorners: true,
        roundedCornerRadius: 1,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-40-44',
        width: 40,
        height: 44,
        roundedCorners: true,
        roundedCornerRadius: 1,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-dark-32-34',
        width: 32,
        height: 34,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#45437f',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-32-36',
        width: 32,
        height: 36,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#fff',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-dark-26-28',
        width: 26,
        height: 28,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#45437f',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-28-32',
        width: 28,
        height: 32,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#fff',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-dark-22-24',
        width: 22,
        height: 24,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#45437f',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-22-24',
        width: 22,
        height: 24,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#fff',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-dark-16-18',
        width: 16,
        height: 18,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: '#45437f',
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-120-130',
        width: 120,
        height: 130,
        roundedCorners: true,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-100-108',
        width: 100,
        height: 108,
        roundedCorners: true,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-124-136',
        width: 124,
        height: 136,
        roundedCorners: true,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-84-92',
        width: 84,
        height: 92,
        roundedCorners: true,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-34-36',
        width: 34,
        height: 36,
        roundedCorners: true,
        roundedCornerRadius: 1,
        fill: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-40-44',
        width: 40,
        height: 44,
        roundedCorners: true,
        roundedCornerRadius: 1,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-24-26',
        width: 24,
        height: 26,
        roundedCorners: true,
        roundedCornerRadius: 1,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-image-18-20',
        width: 18,
        height: 20,
        roundedCorners: true,
        roundedCornerRadius: 1,
        clip: true
    });

    app.plugins.createHexagon({
        container: '.hexagon-overlay-30-32',
        width: 30,
        height: 32,
        roundedCorners: true,
        roundedCornerRadius: 1,
        lineColor: 'rgba(97, 93, 250, .9)',
        fill: true
    });
</script>
<!-- global.tooltips -->
<script>
    /*----------------
    TOOLTIPS
----------------*/
    app.plugins.createTooltip({
        container: '.text-tooltip-tfr',
        offset: 4,
        direction: 'right',
        animation: {
            type: 'translate-in-fade'
        }
    });

    app.plugins.createTooltip({
        container: '.text-tooltip-tft',
        offset: 4,
        direction: 'top',
        animation: {
            type: 'translate-out-fade'
        }
    });

    app.plugins.createTooltip({
        container: '.text-tooltip-tft-medium',
        offset: 8,
        direction: 'top',
        animation: {
            type: 'translate-out-fade'
        }
    });
</script>
<!-- global.charts -->
<script>
    //Mis constantes
    let usuariosBaneados=<%=cantidadTotalBaneados%>;
    let usuariosReportados=<%=cantidadTotalReportados%>;
    let totalEstudiantesRegistrados=<%=totalEstudiantesRegistrados%>;
    let totalEgresadosRegistrados=<%=totalEgresadosRegistrados%>;
    const listaDonacionesEgresados=[450,500,450,600];
    const listaDonacionesEstudiantes=[650,350,950,450];
    const donacionesUltimaSemanaEgresados=<%=Arrays.toString(donacionesUltimaSemanaEgresados)%>;
    const donacionesUltimaSemanaEstudiantes=<%=Arrays.toString(donacionesUltimaSemanaEstudiantes)%>;
    const diasSemana=[<%for(int j=0;j<7;j++){%>'<%=diasSemana[j]%>'<%if(j!=6){%>,<%}}%>];
    const actividadesLista=[<%for(int i=0;i< listaNombresActividadesOrden.size();i++){%>'<%=listaNombresActividadesOrden.get(i)%>'<%if(i!=listaNombresActividadesOrden.size()-1){%>,<%}}%>];
    const apoyosEstudiantes=<%=Arrays.toString(cantidadApoyosEstudiantesPorActividadOrden.toArray(new Integer[0]))%>;
    const apoyosEgresados=<%=Arrays.toString(cantidadApoyosEgresadosPorActividadOrden.toArray(new Integer[0]))%>;
    const totalDonacionesEgresados=<%=totalDonacionesEgresados%>;
    const totalDonacionesEstudiantes=<%=totalDonacionesEstudiantes%>;
    //Mis funciones
    function suma(array){
        let suma=0;
        for(let i=0; i<array.length; i++){
            suma+=array[i];
        }
        return suma;
    }

    function sumaArrays(array1,array2){
        let array3=new Array(array1.length);
        for(let i=0;i<array1.length;i++){
            array3[i]=array1[i]+array2[i];
        }return array3;
    }

    function hallarEstudiantesNoApoyos(){
        document.getElementById('totalEstudiantesNoApoyos').textContent = totalEstudiantesRegistrados-suma(apoyosEstudiantes);
    }
    function hallarEgresadosNoApoyos(){
        document.getElementById('totalEgresadosNoApoyos').textContent = totalEgresadosRegistrados-suma(apoyosEgresados);
    }
    function hallarTotal(array,id){
        document.getElementById(id).textContent = suma(array);
    }
    function hallarTotalApoyos(){
        document.getElementById('totalApoyos').textContent = suma(apoyosEstudiantes)+suma(apoyosEgresados);
    }
    function hallarActividadMayorCantApoyos() {
        let posicion=0;
        mayor=0;
        for(let i=0; i<apoyosEstudiantes.length; i++){
            if(apoyosEstudiantes[i]+apoyosEgresados[i]>mayor){
                mayor=apoyosEstudiantes[i]+apoyosEgresados[i];
                posicion=i;
            }
        }document.getElementById('actividadMayorCantApoyos').textContent = actividadesLista[posicion];
    }

    function hallarActividadMenorCantApoyos() {
        let posicion=0;
        menor=99999;
        for(let i=0; i<apoyosEstudiantes.length; i++){
            if(apoyosEstudiantes[i]+apoyosEgresados[i]<menor){
                menor=apoyosEstudiantes[i]+apoyosEgresados[i];
                posicion=i;
            }
        }document.getElementById('actividadMenorCantApoyos').textContent = actividadesLista[posicion];
    }

    function maximo(array){
        let max=0;
        for(let i=0;i<array.length;i++){
            if(array[i]>max){
                max=array[i];
            }
        }return max;
    }

    function hallarPromedioApoyosActividades(){
        let suma=0;
        for(let i=0; i<apoyosEstudiantes.length; i++){
            suma+=apoyosEstudiantes[i]+apoyosEgresados[i];
        }document.getElementById('promedioApoyosActividades').textContent = (suma/apoyosEstudiantes.length).toFixed(2);
    }
    function hallarTotalEstudiantesRegistrados(){
        document.getElementById('totalEstudiantesRegistrados').textContent = totalEstudiantesRegistrados;
    }
    function hallarTotalEgresadosRegistrados(){
        document.getElementById('totalEgresadosRegistrados').textContent = totalEgresadosRegistrados;
    }
    function hallarTotalUsuariosRegistrados(){
        document.getElementById('totalUsuariosRegistrados').textContent = totalEstudiantesRegistrados+totalEgresadosRegistrados;
    }
    function hallarTotalDonacionesEstudiantes(){
        document.getElementById('totalEstudiantesDonaciones').textContent = suma(listaDonacionesEstudiantes);
    }
    function hallarTotalDonacionesEgresados(){
        document.getElementById('totalEgresadosDonaciones').textContent = suma(listaDonacionesEgresados);
    }
    function hallarTotalDonacionesUsuarios(){
        document.getElementById('totalDonacionesRegistradas').textContent = suma(listaDonacionesEstudiantes)+suma(listaDonacionesEgresados);
    }

    //Fin de mis funciones


    const getLabelNumbers = function (count) {
        const labels = [];
        for (let i = 1; i <= count; i++) {
            const label = i < 10 ? `0${i}` : i.toString();
            labels.push(label);
        }

        return labels;
    };

    const getCompleterData = function (datasetsData, maxValue) {
        const completerData = (new Array(datasetsData[0].length)).fill(maxValue);

        for (let i = 0; i < datasetsData.length; i++) {
            for (let j = 0; j < datasetsData[i].length; j++) {
                completerData[j] -= datasetsData[i][j];
            }
        }

        return completerData;
    };


    /*------------------------
        ENGAGEMENTS CHART
    ------------------------*/
    app.querySelector('#engagements-chart', function (el) {
        const canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                datasets: [{
                    data: [totalEstudiantesRegistrados, totalEgresadosRegistrados],
                    backgroundColor: [
                        '#615dfa',
                        '#23d2e2'
                    ],
                    hoverBackgroundColor: [
                        '#615dfa',
                        '#23d2e2'
                    ],
                    borderWidth: 0
                }],
                labels: [
                    'Estudiantes',
                    'Egresados'
                ]
            },
            chartOptions = {
                cutoutPercentage: 88,
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    callbacks: {
                        label: function (tooltipItem, data) {
                            const labelText = data.datasets[0].data[tooltipItem.index];

                            return labelText;
                        }
                    }
                }
            };

        app.plugins.createChart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions
        });
    });

    app.querySelector('#engagements-chart-donacion', function (el) {
        const canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                datasets: [{
                    data: [totalDonacionesEstudiantes,totalDonacionesEgresados],
                    backgroundColor: [
                        '#615dfa',
                        '#23d2e2'
                    ],
                    hoverBackgroundColor: [
                        '#615dfa',
                        '#23d2e2'
                    ],
                    borderWidth: 0
                }],
                labels: [
                    'Estudiantes',
                    'Egresados'
                ]
            },
            chartOptions = {
                cutoutPercentage: 88,
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    callbacks: {
                        label: function (tooltipItem, data) {
                            const labelText ="S/. "+ data.datasets[0].data[tooltipItem.index];

                            return labelText;
                        }
                    }
                }
            };

        app.plugins.createChart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions
        });
    });
    /*-------------------------------------
        VE MONTHLY REPORT RATIO CHART
    -------------------------------------*/
    app.querySelector('#ve-monthly-report-ratio-chart', function (el) {
        const canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                datasets: [{
                    data: [(suma(apoyosEstudiantes)*100/(suma(apoyosEstudiantes)+suma(apoyosEgresados))).toFixed(2),(suma(apoyosEgresados)*100/(suma(apoyosEstudiantes)+suma(apoyosEgresados))).toFixed(2)],
                    backgroundColor: [
                        '#615dfa',
                        '#23d2e2'
                    ],
                    hoverBackgroundColor: [
                        '#615dfa',
                        '#23d2e2'
                    ],
                    borderWidth: 0
                }],
                labels: [
                    'Estudiantes',
                    'Egresados'
                ]
            },
            chartOptions = {
                cutoutPercentage: 74,
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    callbacks: {
                        label: function (tooltipItem, data) {
                            const labelText = data.datasets[0].data[tooltipItem.index] + '%';

                            return labelText;
                        }
                    }
                }
            };

        app.plugins.createChart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions
        });
    });

    /*-------------------------------
        PROFILE COMPLETION CHART
    -------------------------------*/
    app.querySelector('#profile-completion-chart', function (el) {
        const canvas = el[0],
            ctx = canvas.getContext('2d'),
            gradient = ctx.createLinearGradient(0, 70, 140, 70);

        gradient.addColorStop(0, '#41efff');
        gradient.addColorStop(1, '#615dfa');

        const chartData = {
                datasets: [{
                    data: [59, 41],
                    backgroundColor: [
                        gradient,
                        '#e8e8ef'
                    ],
                    hoverBackgroundColor: [
                        gradient,
                        '#e8e8ef'
                    ],
                    borderWidth: 0
                }]
            },
            chartOptions = {
                cutoutPercentage: 88,
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    enabled: false
                },
                animation: {
                    animateRotate: false
                }
            };

        app.plugins.createChart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions
        });
    });

    /*-----------------------------
        POSTS ENGAGEMENT CHART
    -----------------------------*/
    app.querySelector('#posts-engagement-chart', function (el) {
        const canvas = el[0],
            ctx = canvas.getContext('2d'),
            gradient = ctx.createLinearGradient(0, 40, 80, 40);

        gradient.addColorStop(0, '#41efff');
        gradient.addColorStop(1, '#615dfa');

        const chartData = {
                datasets: [{
                    data: [87, 13],
                    backgroundColor: [
                        gradient,
                        '#e8e8ef'
                    ],
                    hoverBackgroundColor: [
                        gradient,
                        '#e8e8ef'
                    ],
                    borderWidth: 0
                }]
            },
            chartOptions = {
                cutoutPercentage: 85,
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    enabled: false
                },
                animation: {
                    animateRotate: false
                }
            };

        app.plugins.createChart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions
        });
    });

    /*-------------------------
        POSTS SHARED CHART
    -------------------------*/
    app.querySelector('#posts-shared-chart', function (el) {
        const canvas = el[0],
            ctx = canvas.getContext('2d'),
            gradient = ctx.createLinearGradient(0, 40, 80, 40);

        gradient.addColorStop(0, '#41efff');
        gradient.addColorStop(1, '#615dfa');

        const chartData = {
                datasets: [{
                    data: [42, 58],
                    backgroundColor: [
                        gradient,
                        '#e8e8ef'
                    ],
                    hoverBackgroundColor: [
                        gradient,
                        '#e8e8ef'
                    ],
                    borderWidth: 0
                }]
            },
            chartOptions = {
                cutoutPercentage: 85,
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    enabled: false
                },
                animation: {
                    animateRotate: false
                }
            };

        app.plugins.createChart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: chartOptions
        });
    });

    /*------------------------------
        VE MONTHLY REPORT CHART
    ------------------------------*/
    app.querySelector('#ve-monthly-report-chart', function (el) {
        canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                labels: actividadesLista,
                datasets: [
                    {
                        label: 'Estudiantes',
                        data: apoyosEstudiantes,
                        maxBarThickness: 16,
                        backgroundColor: '#615dfa'
                    },
                    {
                        label: 'Egresados',
                        data: apoyosEgresados,
                        maxBarThickness: 16,
                        backgroundColor: '#3ad2fe'
                    },
                ]
            },
            chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    displayColors: false,
                    callbacks: {
                        title: function() {}
                    }
                },
                scales: {
                    xAxes: [
                        {
                            stacked: true,
                            gridLines: {
                                display: false
                            },
                            ticks: {
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500
                            }
                        }
                    ],
                    yAxes: [
                        {
                            stacked: true,
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false,
                                drawTicks: false
                            },
                            ticks: {
                                padding: 20,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500,
                                max: maximo(sumaArrays(apoyosEgresados,apoyosEstudiantes)),
                                stepSize: Math.ceil(maximo(sumaArrays(apoyosEgresados,apoyosEstudiantes))/10),
                            }
                        }
                    ]
                }
            };

        app.plugins.createChart(ctx, {
            type: 'bar',
            data: chartData,
            options: chartOptions
        });
    });

    /*-----------------------------
        RC YEARLY REPORT CHART
    -----------------------------*/
    app.querySelector('#rc-yearly-report-chart', function (el) {
        canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                labels: diasSemana,
                datasets: [
                    {
                        data: donacionesUltimaSemanaEgresados,
                        fill: false,
                        lineTension: 0,
                        borderWidth: 4,
                        borderColor: "#23d2e2",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0,
                        borderJoinStyle: 'bevel',
                        pointBorderColor: "#23d2e2",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 4,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "#fff",
                        pointHoverBorderColor: "#23d2e2",
                        pointHoverBorderWidth: 4,
                        pointRadius: 5,
                        pointHitRadius: 10
                    },
                    {
                        data: donacionesUltimaSemanaEstudiantes,
                        fill: false,
                        lineTension: 0,
                        borderWidth: 4,
                        borderColor: "#4f91ff",
                        borderCapStyle: 'bevel',
                        borderDash: [],
                        borderDashOffset: 0,
                        borderJoinStyle: 'bevel',
                        pointBorderColor: "#4f91ff",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 4,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "#fff",
                        pointHoverBorderColor: "#4f91ff",
                        pointHoverBorderWidth: 4,
                        pointRadius: 5,
                        pointHitRadius: 10
                    }
                ]
            },
            chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    displayColors: false,
                    callbacks: {
                        title: function() {}
                    }
                },
                scales: {
                    xAxes: [
                        {
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false,
                                drawTicks: false
                            },
                            ticks: {
                                padding: 14,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500
                            }
                        }
                    ],
                    yAxes: [
                        {
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false
                            },
                            ticks: {
                                padding: 20,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500,
                                min: 0,
                                max: Math.ceil(maximo([maximo(donacionesUltimaSemanaEgresados),maximo(donacionesUltimaSemanaEstudiantes)])),
                                stepSize: Math.ceil(maximo([maximo(donacionesUltimaSemanaEgresados),maximo(donacionesUltimaSemanaEstudiantes)])/20),
                            }
                        }
                    ]
                }
            };

        app.plugins.createChart(ctx, {
            type: 'line',
            data: chartData,
            options: chartOptions
        });
    });

    /*---------------------------
        VS PERFORMANCE CHART
    ---------------------------*/
    app.querySelector('#vs-performance-chart', function (el) {
        const datasetData1 = [140, 90, 155, 180],
            datasetData2 = [120, 25, 130, 110],
            canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                labels: ['Aug', 'Sep', 'Oct', 'Nov'],
                datasets: [
                    {
                        label: 'Views',
                        data: datasetData1,
                        maxBarThickness: 16,
                        backgroundColor: '#615dfa'
                    },
                    {
                        label: 'Sales',
                        data: datasetData2,
                        maxBarThickness: 16,
                        backgroundColor: '#3ad2fe'
                    }
                ]
            },
            chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    displayColors: false,
                    callbacks: {
                        title: function() {}
                    }
                },
                scales: {
                    xAxes: [
                        {
                            gridLines: {
                                display: false
                            },
                            ticks: {
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500
                            }
                        }
                    ],
                    yAxes: [
                        {
                            gridLines: {
                                display: false
                            },
                            ticks: {
                                display: false
                            }
                        }
                    ]
                }
            };

        app.plugins.createChart(ctx, {
            type: 'bar',
            data: chartData,
            options: chartOptions
        });
    });

    /*---------------------------
        EARNINGS REPORT CHART
    ---------------------------*/
    app.querySelector('#earnings-report-chart', function (el) {
        const datasetData = [0, 15, 0, 0, 0, 20, 10, 15, 40, 20, 25, 25, 15, 10, 20, 23, 23, 15, 30, 40, 30, 20, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                labels: getLabelNumbers(31),
                datasets: [
                    {
                        label: 'Earnings',
                        data: datasetData,
                        lineTension: .5,
                        borderWidth: 2,
                        backgroundColor: 'rgba(35, 210, 226, .2)',
                        borderColor: "#23d2e2",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0,
                        borderJoinStyle: 'bevel',
                        pointBorderColor: "#fff",
                        pointBackgroundColor: "#23d2e2",
                        pointBorderWidth: 2,
                        pointHoverRadius: 4,
                        pointHoverBorderColor: "#fff",
                        pointHoverBackgroundColor: "#23d2e2",
                        pointHoverBorderWidth: 2,
                        pointRadius: 4,
                        pointHitRadius: 5
                    }
                ]
            },
            chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    displayColors: false,
                    callbacks: {
                        title: function() {}
                    }
                },
                scales: {
                    xAxes: [
                        {
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false,
                                drawTicks: false
                            },
                            ticks: {
                                padding: 14,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500
                            }
                        }
                    ],
                    yAxes: [
                        {
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false
                            },
                            ticks: {
                                padding: 20,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500,
                                max: 55,
                                stepSize: 5,
                                callback: function(value, index, values) {
                                    return '$' + value;
                                }
                            }
                        }
                    ]
                }
            };

        app.plugins.createChart(ctx, {
            type: 'line',
            data: chartData,
            options: chartOptions
        });
    });

    /*---------------------------
        MEMBERS REPORT CHART
    ---------------------------*/
    app.querySelector('#members-report-chart', function (el) {
        const datasetData = [8, 4, 8, 5, 10, 13, 11, 11, 13, 17, 5, 12],
            canvas = el[0],
            ctx = canvas.getContext('2d'),
            chartData = {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [
                    {
                        label: 'Members',
                        data: datasetData,
                        lineTension: 0,
                        borderWidth: 2,
                        backgroundColor: 'rgba(97, 93, 250, .1)',
                        borderColor: "#615dfa",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0,
                        borderJoinStyle: 'bevel',
                        pointBorderColor: "#615dfa",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 2,
                        pointHoverRadius: 4,
                        pointHoverBorderColor: "#615dfa",
                        pointHoverBackgroundColor: "#fff",
                        pointHoverBorderWidth: 2,
                        pointRadius: 4,
                        pointHitRadius: 5
                    }
                ]
            },
            chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    bodyFontFamily: "'Titillium Web', sans-serif",
                    displayColors: false,
                    callbacks: {
                        title: function() {}
                    }
                },
                scales: {
                    xAxes: [
                        {
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false,
                                drawTicks: false
                            },
                            ticks: {
                                padding: 14,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500
                            }
                        }
                    ],
                    yAxes: [
                        {
                            gridLines: {
                                color: "rgba(234, 234, 245, 1)",
                                zeroLineColor: "rgba(234, 234, 245, 1)",
                                drawBorder: false
                            },
                            ticks: {
                                padding: 20,
                                fontFamily: "'Rajdhani', sans-serif",
                                fontColor: '#8f91ac',
                                fontSize: 12,
                                fontStyle: 500,
                                max: 20,
                                stepSize: 2,
                                beginAtZero: true
                            }
                        }
                    ]
                }
            };

        app.plugins.createChart(ctx, {
            type: 'line',
            data: chartData,
            options: chartOptions
        });
    });
    hallarTotalApoyos();
    hallarTotal(apoyosEstudiantes,'totalApoyosEstudiantes');
    hallarTotal(apoyosEgresados,'totalApoyosEgresados');
    hallarActividadMayorCantApoyos();
    hallarActividadMenorCantApoyos();
    hallarTotalEgresadosRegistrados();
    hallarTotalUsuariosRegistrados();
    hallarTotalEstudiantesRegistrados();
    hallarTotalDonacionesUsuarios();
    hallarTotalDonacionesEgresados();
    hallarTotalDonacionesEstudiantes();
    hallarPromedioApoyosActividades();
</script>
<!-- header -->
<script src="js/header/header.js"></script>
<!-- sidebar -->
<script src="js/sidebar/sidebar.js"></script>
<!-- content -->
<script src="js/content/content.js"></script>
<!-- form.utils -->
<script src="js/form/form.utils.js"></script>
<!-- SVG icons -->
<script src="js/utils/svg-loader.js"></script>
</body>
</html>