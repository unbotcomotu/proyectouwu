<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.*" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>

<%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 22/10/2023
  Time: 01:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String alerta=(String) request.getSession().getAttribute("alerta");
if(alerta!=null){
    request.getSession().removeAttribute("alerta");
}
Integer idDonacionElegida=(Integer) request.getSession().getAttribute("idDonacionElegida");
if(idDonacionElegida!=null){
    request.getSession().removeAttribute("idDonacionElegida");
}
%>

<html>
<head>
    <%Usuario usuarioActual=(Usuario) request.getSession().getAttribute("usuario");
        int idUsuario=usuarioActual.getIdUsuario();
        String rolUsuario=usuarioActual.getRol();
        String busquedaSolicitudes=(String) request.getAttribute("busquedaSolicitudes");
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String nombreCompletoUsuario=usuarioActual.getNombre()+" "+usuarioActual.getApellido();
        ArrayList<Usuario> listaSolicitudes=(ArrayList<Usuario>) request.getAttribute("listaSolicitudes");
        int cantidadTotalPageSolicitudes =request.getAttribute("cantidadTotalSolicitudes")!= null ? (int)Math.ceil((int)request.getAttribute("cantidadTotalSolicitudes")/12.0):0;
        int cantidadTotalPageDonaciones = request.getAttribute("cantidadTotalDonaciones") != null ? (int)Math.ceil((int)request.getAttribute("cantidadTotalDonaciones")/12.0):0;
        int cantidadTotalPageValidacion = request.getAttribute("cantidadTotalValidaciones") != null ? (int)Math.ceil((int)request.getAttribute("cantidadTotalValidaciones")/12.0):0;
        Integer pagActual = request.getAttribute("pagActual") != null ? (Integer) request.getAttribute("pagActual") : 1;
        Integer pagActualD = request.getAttribute("pagActualD") != null ? (Integer) request.getAttribute("pagActualD") : 1;
        Integer pagActualV = request.getAttribute("pagActualV") != null ? (Integer) request.getAttribute("pagActualV") : 1;
        ArrayList<Reporte> reportList = (ArrayList<Reporte>) request.getAttribute("reportList");
        ArrayList<Donacion> donacionList = (ArrayList<Donacion>) request.getAttribute("donacionList");
        ArrayList<Validacion> recuperacionList = (ArrayList<Validacion>) request.getAttribute("recuperacionList");
        Integer idActividadDelegatura=(Integer)request.getAttribute("idActividadDelegatura");
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        ArrayList<Usuario>listaIDyNombresDelegadosDeActividad=(ArrayList<Usuario>)request.getAttribute("IDyNombreDelegadosDeActividad");
        String colorRol;
        String servletActual="NotificacionesServlet";
        ArrayList<NotificacionDelegadoGeneral>listaNotificacionesCampanita=(ArrayList<NotificacionDelegadoGeneral>) request.getAttribute("listaNotificacionesCampanita");
        if(rolUsuario.equals("Alumno")){
            colorRol="";
        }else if(rolUsuario.equals("Delegado de Actividad")){
            colorRol="green";
        }else{
            colorRol="orange";
        }
        String buscar=(String) request.getAttribute("buscar");
        String vistaActualNueva= (String) request.getAttribute("vistaActualNueva");
        String fecha1=(String) request.getAttribute("fecha1");
        String fecha2=(String) request.getAttribute("fecha2");
        String buscarReportes=(String) request.getAttribute("buscarReportes");
        String ip=(String) request.getAttribute("ip");
    %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- bootstrap 4.3.1 -->
    <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
    <!-- styles -->
    <link rel="stylesheet" href="css/raw/stylesSanti.css">
    <!-- simplebar styles -->
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <!-- tiny-slider styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/vendor/tiny-slider.css">
    <!-- favicon -->
    <link rel="icon" href="css/murcielago.ico">
    <title>Notificaciones - Siempre Fibra</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* Estilos para resaltar las opciones clickeables */
        .clickeable {
            cursor: pointer;
            color: blue;
            text-decoration: underline;
        }

        /* Estilo para ocultar elementos por defecto */
        .oculto {
            display: none;
        }
        #boton {
            display: inline-block;
            height: 48px;
            border-radius: 10px;
            background-color: #3e3f5e;
            color: #fff;
            font-size: 0.875rem;
            font-weight: 700;
            text-align: center;
            line-height: 48px;
            cursor: auto !important;
            transition: background-color .2s ease-in-out, color .2s ease-in-out, border-color .2s ease-in-out, box-shadow .2s ease-in-out;
            box-shadow: 3px 5px 10px 0 rgba(62, 63, 94, 0.2);
        }
    </style>
    <style>
        .button-reject {
            background-color: red; /* Cambia el fondo del botón a rojo */
            color: white; /* Cambia el color del texto a blanco */
            /* Puedes ajustar otros estilos según tus preferencias, como el tamaño del texto, el borde, etc. */
        }
    </style>
    <style>
        .campanita{
            width: 500px;
        }
        @media screen and (max-width: 576px) {
            .auxResponsiveUwu{
                display: none;
            }
            .campanita{
                width: 345px;
            }
        }
    </style>
    <style>
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 10000;
        }

        /* Estilo para el contenido del popup */
        .popup {
            padding: 20px;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            border-radius: 12px;
            transform: translate(-50%, -50%);
            z-index: 10001;
            width: 100%;
            max-width: 650px;
            background-color: #fff;
        }

        /* Estilo para el botón de cerrar */
        .cerrarPopup {
            display: flex;
            -ms-flex-pack: center;
            justify-content: center;
            -ms-flex-align: center;
            align-items: center;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background-color: #45437f;
            cursor: pointer;
            position: absolute;
            top: -20px;
            right: -20px;
            z-index: 2;
            transition: background-color .2s ease-in-out;
        }
    </style>
</head>
<body>
<form id="logOut" method="post" action="InicioSesionServlet?action=logOut"></form>
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
        <% if(usuarioActual.getRol().equals("Delegado de Actividad")){ %>
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
            <% if(usuarioActual.getRol().equals("Delegado de Actividad")){ %>
            <p class="navigation-widget-info-text" style="color: <%=colorRol%>"><%=rolUsuario + ": " + new DaoUsuario().obtenerDelegaturaPorId(idUsuario)%></p>
            <%}else{%>
            <p class="navigation-widget-info-text" style="color: <%=colorRol%>"><%=rolUsuario%></p>
            <%}%>
            <!-- /NAVIGATION WIDGET INFO TEXT -->
        </div>
        <!-- /NAVIGATION WIDGET INFO -->
        <button onclick="enviarFormulario('logOut')" style="border:0;background: none;color: inherit" type="button"><a><p class="navigation-widget-info-button button small secondary">Cerrar sesión</p></a></button>
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
                <div class="dropdown-box header-dropdown campanita">
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
                        <form id="notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>" method="post" action="PaginaNoExisteServlet?action=notificacionLeidaCampanita">
                            <input type="hidden" name="idNotificacion" value="<%=noti.getIdNotificacion()%>">
                            <input type="hidden" name="servletActual" value="<%=servletActual%>">
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
                                    <p class="user-status-title"><a class="bold"><%=r.getUsuarioReportado().getNombre()%> <%=r.getUsuarioReportado().getApellido()%></a> ha sido <a class="highlighted">reportado</a> por el delegado de actividad <a class="bold" style="color: #491217"><%=r.getUsuarioQueReporta().getNombre()%> <%=r.getUsuarioQueReporta().getApellido()%></a></p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacion().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
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
                                    <%Integer diferenciaFechas[]=new DaoNotificacion().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
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
                                    <%Integer diferenciaFechas[]=new DaoNotificacion().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
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
                                if(new DaoValidacion().tipoValidacionPorID(noti.getValidacion().getIdCorreoValidacion()).equals("enviarLinkACorreo")){%>
                            <!-- Validación correo -->

                            <!-- Validación correo -->
                            <%}else if(new DaoValidacion().tipoValidacionPorID(noti.getValidacion().getIdCorreoValidacion()).equals("recuperarContrasena")){
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
                                    <%Integer diferenciaFechas[]=new DaoNotificacion().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
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
                            <%}else{
                                Validacion v3=new DaoValidacion().validacionPorIDNotificacionContrasena(noti.getValidacion().getIdCorreoValidacion());%>
                            <!-- Validación kit -->
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
                                    <p class="user-status-title"><a class="bold"><%=v3.getUsuario().getNombre()%> <%=v3.getUsuario().getApellido()%></a> ha realizado más de <a style="color: #8d7aff">S/.100</a> en donaciones y merece recibir un <a class="highlighted">kit</a>.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacion().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
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
                                        <img src="css/iconoKit.png" width="30px" style="opacity: 0.5" alt="">
                                        <!-- /ICON COMMENT -->
                                    </div>
                                    <!-- /USER STATUS ICON -->
                                </div>
                                <!-- /USER STATUS -->
                            </div>
                            <!-- Validación kit -->
                            <%}}%>
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
                <button onclick="enviarFormulario('logOut')" style="border:0;background: none;color: inherit" type="button"><a><img src="css/logOut.png" width="30%" style="" alt=""></a></button>
                <!-- /ACTION ITEM ICON -->
            </div>
            <!-- /ACTION ITEM -->

            <!-- DROPDOWN NAVIGATION -->

        </div>
        <!-- /ACTION ITEM WRAP -->
    </div>
    <!-- /HEADER ACTIONS -->
</header>
<!-- /HEADER -->

<!-- CONTENT GRID -->
<div class="content-grid">

    <!-- SECTION BANNER -->
    <div class="section-banner">
        <!-- SECTION BANNER ICON -->
        <img class="section-banner-icon" src="css/noti.png" width="14%" alt="">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title">Centro de Notificaciones</p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text">Aquí podrá ver las nuevas solicitudes de registro, las donaciones, los reportes y ¡más solicitudes!</p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <!-- GRID -->

    <div class="oculto" id="solicitudesContenido">

        <div class="section-filters-bar v1">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form method="get" action="<%=request.getContextPath()%>/NotificacionesServlet" class="form">
                    <input type="hidden" name="action" value="buscarUsuario">
                    <input type="hidden" name="p" value="<%=pagActual%>">
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button">
                        <label for="friends-search_1">Buscar por usuario</label>
                        <input type="text" id="friends-search_1" name="busquedaSolicitudes" <%if(busquedaSolicitudes!=null){%> value="<%=busquedaSolicitudes%>"<%}%>>
                        <!-- BUTTON -->
                        <button type="submit" class="button primary">
                            <!-- ICON MAGNIFYING GLASS -->
                            <svg class="icon-magnifying-glass">
                                <use xlink:href="#svg-magnifying-glass"></use>
                            </svg>
                            <!-- /ICON MAGNIFYING GLASS -->
                        </button>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /FORM INPUT -->
                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="cambiarVistaSolicitudesDeRegistro">Cambiar de vista</label>
                        <select id="cambiarVistaSolicitudesDeRegistro">
                            <option value="0">Solicitudes de Registro</option>
                            <option value="1">Donaciones</option>
                            <option value="2">Reportes</option>
                            <option value="3">Solicitudes de Validación</option>
                        </select>
                        <!--FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!--/FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->
                </form>
                <!-- /FORM -->

                <!-- FILTER TABS -->
                <div class="filter-tabs">
                    <!-- FILTER TAB -->
                    <div class="filter-tab active">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id="opcionSolicitudes" >Solicitudes de Registro</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id = "opcionDonaciones">Donaciones</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionReportes"  >Reportes</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- /FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionRecuperacion" > Solicitudes de Validación</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>

        <div class="grid grid-4-4-4 centered">

           <%int contador = 0;%>


            <%for (Usuario usuario_pendiente: listaSolicitudes) {%>
            <!-- USER PREVIEW -->
            <div class="user-preview">
                <!-- USER PREVIEW COVER -->
                <figure class="user-preview-cover liquid" style="background: linear-gradient(#122d5c,#07559d);"></figure>
                <!-- /USER PREVIEW COVER -->

                <!-- USER PREVIEW INFO -->
                <div class="user-preview-info">
                    <!-- USER SHORT DESCRIPTION -->
                    <div class="user-short-description">
                        <!-- USER SHORT DESCRIPTION AVATAR -->
                        <div class="user-short-description-avatar user-avatar medium">
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
                                <div class="hexagon-image-82-90" data-src="css\sin_foto_De_perfil.png"></div>
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

                            <!-- USER AVATAR PROGRESS BORDER -->
                            <div class="user-avatar-progress-border">
                                <!-- HEXAGON -->
                                <div class="hexagon-border-100-110"></div>
                                <!-- /HEXAGON -->
                            </div>
                            <!-- /USER AVATAR PROGRESS BORDER -->
                        </div>
                        <!-- /USER SHORT DESCRIPTION AVATAR -->

                        <!-- USER SHORT DESCRIPTION TITLE -->
                        <p class="user-short-description-title" style="color: rgb(22, 143, 143);"><%=usuario_pendiente.getNombre() +" "+ usuario_pendiente.getApellido() %></p>
                        <!-- /USER SHORT DESCRIPTION TITLE -->

                        <!-- USER SHORT DESCRIPTION TEXT -->
                        <p class="user-short-description-text" style="text-transform: lowercase;"><%=usuario_pendiente.getCorreo()%></p>
                        <!-- /USER SHORT DESCRIPTION TEXT -->

                        <!-- USER SHORT DESCRIPTION TEXT -->
                        <p class="user-short-description-text" style="text-transform: lowercase;"><%=usuario_pendiente.getFechaRegistro()%></p>
                        <!-- /USER SHORT DESCRIPTION TEXT -->
                    </div>
                    <!-- /USER SHORT DESCRIPTION -->

                    <!-- USER PREVIEW STATS SLIDES -->
                    <div id="user-preview-stats-slides-01_1" class="user-preview-stats-slides">
                        <!-- USER PREVIEW STATS SLIDE -->
                        <div class="user-preview-stats-slide">

                            <div class="container-fluid">

                                <div class="row">

                                    <div class="col-sm-6 px-5" style="text-align: center;">

                                        <p style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;" >Código: <%=usuario_pendiente.getCodigoPUCP()%></p>

                                    </div>

                                    <div class="col-sm-6 px-5" style="text-align: center;">

                                        <p style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;" >Condición: <%=usuario_pendiente.getCondicion()%></p>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <!-- /USER PREVIEW STATS SLIDES -->

                    <div class="user-preview-actions">
                        <!-- BUTTON -->

                        <div class="container-fluid">

                            <div class="row" >

                                <div class="col-sm-6">
                                    <form method="post" id="formAceptar<%=listaSolicitudes.indexOf(usuario_pendiente)%>" action="<%=request.getContextPath()%>/NotificacionesServlet?action=aceptarRegistro">
                                        <input type="hidden" name="idUsuarioARegistrar" value="<%=usuario_pendiente.getIdUsuario()%>">
                                        <a><button style="background-image: linear-gradient(to right,dodgerblue,blueviolet);" type="submit" class="button-accept">Aceptar</button></a>
                                    </form>
                                </div>
                                <div class="col-sm-6">

                                    <a><button style="background-image: linear-gradient(to right,brown,red);" type="button" onclick="func('popupRechazar<%=listaSolicitudes.indexOf(usuario_pendiente)%>',['cerrarPopupRechazar<%=listaSolicitudes.indexOf(usuario_pendiente)%>','cerrarPopupRechazar1Solicitud<%=listaSolicitudes.indexOf(usuario_pendiente)%>','cerrarPopupRechazar2Solicitud<%=listaSolicitudes.indexOf(usuario_pendiente)%>'],'overlayPopupRechazar<%=listaSolicitudes.indexOf(usuario_pendiente)%>')" class="button-accept">Rechazar</button></a>

                                </div>
                            </div>
                        </div>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /USER PREVIEW ACTIONS -->
                </div>
                <!-- /USER PREVIEW INFO -->
            </div>

            <%contador++;%>
            <!-- /USER PREVIEW -->
            <%}%>
        </div>
        <!-- /GRID -->

        <!-- SECTION PAGER BAR -->
        <div class="section-pager-bar">
            <!-- SECTION PAGER -->
            <div class="section-pager">
                <!-- SECTION PAGER ITEM -->
                <%  for(int p=0;p<cantidadTotalPageSolicitudes; p++){%>
                    <div class="section-pager-item <%if(pagActual==p+1){%>active<%}%>">
                        <%if(action.equals("buscarUsuario")){%>
                        <%if (p<9){%>
                        <!-- SECTION PAGER ITEM TEXT -->
                        <a class="section-pager-item-text" href="NotificacionesServlet?action=<%=action%>&busquedaSolicitudes=<%=busquedaSolicitudes%>&p=<%=p+1%>">0<%=p+1%></a>
                        <!-- /SECTION PAGER ITEM TEXT -->
                        <%} else {%>
                        <!-- SECTION PAGER ITEM TEXT -->
                        <a class="section-pager-item-text" href="NotificacionesServlet?action=<%=action%>&busquedaSolicitudes=<%=busquedaSolicitudes%>&p=<%=p+1%>"><%=p+1%></a>
                        <!-- /SECTION PAGER ITEM TEXT -->
                        <%}}else{%>
                        <%if (p<9){%>
                        <!-- SECTION PAGER ITEM TEXT -->
                        <a class="section-pager-item-text" href="NotificacionesServlet?p=<%=p+1%>">0<%=p+1%></a>
                        <!-- /SECTION PAGER ITEM TEXT -->
                        <%} else {%>
                        <!-- SECTION PAGER ITEM TEXT -->
                        <a class="section-pager-item-text" href="NotificacionesServlet?&p=<%=p+1%>"><%=p+1%></a>
                        <!-- /SECTION PAGER ITEM TEXT -->
                        <%}}%>
                    </div>
                <!-- /SECTION PAGER ITEM -->
                <%}%>
                <!-- /SECTION PAGER ITEM -->
            </div>
            <!-- /SECTION PAGER -->
        </div>
        <!-- /SECTION PAGER BAR -->

        <!-- SECTION RESULTS TEXT -->
        <p class="section-results-text">Mostrando <%=contador%> de <%=(int)request.getAttribute("cantidadTotalSolicitudes")%> solicitudes</p>
        <!-- /SECTION RESULTS TEXT -->
    </div>

    <div id="donacionesContenido" class="oculto">

        <div class="section-filters-bar v1">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form method="get" action="<%=request.getContextPath()%>/NotificacionesServlet" class="form">
                    <input type="hidden" name="action" value="buscarDonaciones">
                    <input type="hidden" name="pd" value="<%=pagActualD%>">
                    <input type="hidden" name="fecha1" <%if(fecha1!=null){%>value="<%=fecha1%>"<%}%>>
                    <input type="hidden" name="fecha2" <%if(fecha2!=null){%>value="<%=fecha2%>"<%}%>>
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button">
                        <label for="friends-search_5">Buscar por usuario</label>
                        <input type="text" id="friends-search_5" name="buscar" <%if(buscar!=null){%> value="<%=buscar%> <%}%>">
                        <!-- BUTTON -->
                        <button type="submit" class="button primary">
                            <!-- ICON MAGNIFYING GLASS -->
                            <svg class="icon-magnifying-glass">
                                <use xlink:href="#svg-magnifying-glass"></use>
                            </svg>
                            <!-- /ICON MAGNIFYING GLASS -->
                        </button>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /FORM INPUT -->

                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="cambiarVistaDonaciones">Cambiar de vista</label>
                        <select id="cambiarVistaDonaciones">
                            <option value="0">Solicitudes de Registro</option>
                            <option value="1">Donaciones</option>
                            <option value="2">Reportes</option>
                            <option value="3">Solicitudes de Validación</option>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->
                </form>
                <!-- /FORM -->

                <!-- FILTER TABS -->
                <div class="filter-tabs">
                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id="opcionSolicitudes_1" >Solicitudes de Registro</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab active">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id = "opcionDonaciones_1">Donaciones</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionReportes_1"  >Reportes</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionRecuperacion_1">Solicitudes de Validación</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>
        <div class="section-filters-bar v6 v6-2">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form method="get" action="<%=request.getContextPath()%>/NotificacionesServlet" class="form">
                    <input type="hidden" name="action" value="filtrarDonaciones">
                    <input type="hidden" name="pd" value="<%=pagActualD%>">
                    <input type="hidden" id="friends-search_2" name="buscar" <%if(buscar!=null){%> value="<%=buscar%><%}%>">
                    <!-- FORM ITEM -->
                    <div class="form-item split">
                        <!-- FORM INPUT DECORATED -->
                        <div class="form-input-decorated">
                            <!-- FORM INPUT -->
                            <div class="form-input small active">
                                <label for="statement-from-date">Fecha de Inicio</label>
                                <input type="date" id="statement-from-date" name="fecha1" placeholder="DD/MM/20AA" <%if(fecha1!=null){%> value="<%=fecha1%>" <%}%>>
                            </div>
                            <!-- /FORM INPUT -->

                            <!-- FORM INPUT ICON -->
                            <svg class="form-input-icon icon-events">
                                <use xlink:href="#svg-events"></use>
                            </svg>
                            <!-- /FORM INPUT ICON -->
                        </div>
                        <!-- /FORM INPUT DECORATED -->

                        <!-- FORM INPUT DECORATED -->
                        <div class="form-input-decorated">
                            <!-- FORM INPUT -->
                            <div class="form-input small active">
                                <label for="statement-to-date">Fecha de Fin</label>
                                <input type="date" id="statement-to-date" name="fecha2" placeholder="DD/MM/20AA" <%if(fecha2!=null){%> value="<%=fecha2%>" <%}%>>
                            </div>
                            <!-- /FORM INPUT -->

                            <!-- FORM INPUT ICON -->
                            <svg class="form-input-icon icon-events">
                                <use xlink:href="#svg-events"></use>
                            </svg>
                            <!-- /FORM INPUT ICON -->
                        </div>
                        <!-- /FORM INPUT DECORATED -->

                        <!-- BUTTON -->
                        <button class="button primary">
                            <!-- ICON MAGNIFYING GLASS -->
                            <svg class="icon-magnifying-glass">
                                <use xlink:href="#svg-magnifying-glass"></use>
                            </svg>
                            <!-- /ICON MAGNIFYING GLASS -->
                        </button>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /FORM ITEM -->
                </form>
                <!-- /FORM -->
            </div>
            <!-- /SECTION FILTERS BAR ACTIONS -->

            <!-- SECTION FILTERS BAR ACTIONS -->

            <!-- /SECTION FILTERS BAR ACTIONS -->
        </div>
        <!-- /SECTION FILTERS BAR -->

        <!-- TABLE WRAP -->
        <div class="table-wrap" data-simplebar>
            <!-- TABLE -->
            <div class="table table-sales">
                <!-- TABLE HEADER -->
                <div class="table-header">
                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Fecha</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column padded-left">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Usuario</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Tipo</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->

                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Donado</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Condición</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>

                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Imagen</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Estado</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>


                    <!-- /TABLE HEADER COLUMN -->
                </div>
                <!-- /TABLE HEADER -->

                <!-- TABLE BODY -->
                <div class="table-body same-color-rows">

                    <%int contadorD = 0;%>
                    <%for (Donacion donacion : donacionList){%>
                    <!-- TABLE ROW -->
                    <div class="table-row micro">
                        <!-- TABLE COLUMN -->
                        <div class="table-column">
                            <!-- TABLE TEXT -->
                            <p class="table-text"><span class="light"><%=donacion.getFecha()%></span></p>
                            <!-- /TABLE TEXT -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column padded-left">

                            <%DaoUsuario usuarioUwu = new DaoUsuario();%>
                            <!-- TABLE LINK -->
                            <p class="table-link"><span class="highlighted"> <%=usuarioUwu.nombreCompletoUsuarioPorId(donacion.getUsuario().getIdUsuario())%>  </span></p>
                            <!-- /TABLE LINK -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title"> <%=donacion.getMedioPago()%> </p>
                            <!-- /TABLE TITLE -->
                        </div>

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title">S/<%=donacion.getMonto()%></p>
                            <!-- /TABLE TITLE -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title"> <%= usuarioUwu.condicionUsuarioPorId(donacion.getUsuario().getIdUsuario())%> </p>
                            <!-- /TABLE TITLE -->
                        </div>

                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p id="mostrarPopupImagenDonacion<%=donacionList.indexOf(donacion)%>" style="cursor: pointer;" class="table-title" ><span class="highlighted">Pulse aquí</span></p>
                            <!-- /TABLE TITLE -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title"> <%=donacion.getEstadoDonacion()%> </p>
                            <!-- /TABLE TITLE -->
                        </div>
                        <%if(donacion.getEstadoDonacion().equals("Pendiente")){%>
                        <div class="table-column centered padded">
                            <button class="button-accept" id="mostrarPopupEditarDonacion<%=donacionList.indexOf(donacion)%>"><a>Editar</a></button>
                            <!-- TABLE TITLE -->
                            <button class="button-reject" type="button" onclick="func('popupRechazarDonacion<%=donacionList.indexOf(donacion)%>',['cerrarPopupRechazarDonacion<%=donacionList.indexOf(donacion)%>','cerrarPopupRechazar1Donacion<%=donacionList.indexOf(donacion)%>','cerrarPopupRechazar2Donacion<%=donacionList.indexOf(donacion)%>'],'overlayPopupRechazarDonacion<%=donacionList.indexOf(donacion)%>')"><a>Rechazar</a></button>
                        </div>
                        <%}else{%>
                        <div class="table-column centered padded">
                            <button class="button-accept" type="button" style="opacity: 60%; cursor: auto !important;"><a>Editar</a></button>
                            <!-- TABLE TITLE -->
                            <button class="button-reject" type="button" style="opacity: 60%; cursor: auto !important;"><a>Rechazar</a></button>
                        </div>
                        <%}%>
                        <!-- /TABLE COLUMN -->
                    </div>
                    <!-- /TABLE ROW -->
                    <%contadorD++;}%>
                </div>
                <!-- /TABLE BODY -->
            </div>
            <!-- /TABLE -->
        </div>
        <!-- /TABLE WRAP -->

        <!-- SECTION PAGER BAR WRAP -->
        <div class="section-pager-bar-wrap align-center">
            <!-- SECTION PAGER BAR -->
            <div class="section-pager-bar">
                <!-- SECTION PAGER -->
                <div class="section-pager">
                    <!-- SECTION PAGER ITEM -->
                    <%for(int p=0;p<cantidadTotalPageDonaciones; p++){%>
                    <div class="section-pager-item <%if(pagActualD==p+1){%>active<%}%>">
                        <%if(!action.isEmpty()){%>
                        <%if(p<9){%>
                        <a class="section-pager-item-text" href="NotificacionesServlet?action=<%=action%>&pd=<%=p+1%>&buscar=<%=buscar%>&fecha1=<%=fecha1%>&fecha2=<%=fecha2%>&vistaActualNueva=Donaciones">0<%=p+1%></a>
                        <%}else{%>
                        <a class="section-pager-item-text" href="NotificacionesServlet?action=<%=action%>&pd=<%=p+1%>&buscar=<%=buscar%>&fecha1=<%=fecha1%>&fecha2=<%=fecha2%>&vistaActualNueva=Donaciones"><%=p+1%></a>
                        <%}}else{%>
                        <%if(p<9){%>
                        <a class="section-pager-item-text" href="NotificacionesServlet?&pd=<%=p+1%>&vistaActualNueva=Donaciones">0<%=p+1%></a>
                        <%}else{%>
                        <a class="section-pager-item-text" href="NotificacionesServlet?&pd=<%=p+1%>&vistaActualNueva=Donaciones"><%=p+1%></a>
                        <%}}%>
                    </div>
                    <!-- /SECTION PAGER ITEM -->
                    <%}%>
                    <!-- /SECTION PAGER ITEM -->
                </div>
                <!-- /SECTION PAGER -->

                <!-- SECTION PAGER CONTROLS -->

                <!-- /SECTION PAGER CONTROLS -->
            </div>
            <!-- /SECTION PAGER BAR -->
        </div>


    </div>

    <div id = "reportesContenido" class="oculto">
        <div class="section-filters-bar v1">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form method="get" action="<%=request.getContextPath()%>/NotificacionesServlet" class="form">
                    <input type="hidden" name="action" value="buscarReportes">
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button">
                        <label for="friends-search_3">Buscar usuario reportado</label>
                        <input type="text" id="friends-search_3" name="buscarReportes" <%if(buscarReportes!=null){%> value="<%=buscarReportes%>" <%}%>>
                        <!-- BUTTON -->
                        <button type="submit" class="button primary">
                            <!-- ICON MAGNIFYING GLASS -->
                            <svg class="icon-magnifying-glass">
                                <use xlink:href="#svg-magnifying-glass"></use>
                            </svg>
                            <!-- /ICON MAGNIFYING GLASS -->
                        </button>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /FORM INPUT -->

                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="cambiarVistaReportes">Cambiar de vista</label>
                        <select id="cambiarVistaReportes">
                            <option value="0">Solicitudes de Registro</option>
                            <option value="1">Donaciones</option>
                            <option value="2">Reportes</option>
                            <option value="3">Solicitudes de Validación</option>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->
                </form>
                <!-- /FORM -->

                <!-- FILTER TABS -->
                <div class="filter-tabs">
                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id="opcionSolicitudes_2" >Solicitudes de Registro</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id = "opcionDonaciones_2">Donaciones</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab active">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionReportes_2"  >Reportes</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionRecuperacion_2" >Solicitudes de Validación</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>
        <div class="grid medium-space">

            <!-- GRID COLUMN -->
            <div class="account-hub-content">

                <!-- NOTIFICATION BOX LIST -->
                <div class="notification-box-list">
                    <!-- NOTIFICATION BOX -->
                    <% for (Reporte reporteNuevo : reportList ){%>

                    <div class="notification-box">
                        <!-- USER STATUS -->
                        <div class="user-status notification">
                            <!-- USER STATUS AVATAR -->
                            <a class="user-status-avatar" >
                                <!-- USER AVATAR -->
                                <div class="user-avatar small no-outline">
                                    <!-- USER AVATAR CONTENT -->
                                    <div class="user-avatar-content">
                                        <%request.getSession().setAttribute("fotoListaReporte"+reportList.indexOf(reporteNuevo),reporteNuevo.getUsuarioReportado().getFotoPerfil());%>
                                        <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
                                        <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=ListaReporte<%=reportList.indexOf(reporteNuevo)%>"></div>
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

                                </div>
                                <!-- /USER AVATAR -->
                            </a>
                            <!-- /USER STATUS AVATAR -->

                            <!-- USER STATUS TITLE -->
                            <%
                                DaoUsuario daoUser = new DaoUsuario();

                            %>
                            <p class="user-status-title"><a class="bold" ><%=daoUser.nombreCompletoUsuarioPorId(reporteNuevo.getUsuarioQueReporta().getIdUsuario())%></a> ha reportado a <a class="highlighted" ><%=daoUser.nombreCompletoUsuarioPorId(reporteNuevo.getUsuarioReportado().getIdUsuario())%></a> <%= reporteNuevo.getMotivoReporte()%></p>
                            <!-- /USER STATUS TITLE -->

                            <!-- USER STATUS TIMESTAMP -->
                            <p class="user-status-timestamp small-space"><%=reporteNuevo.getFecha()%></p>
                            <!-- /USER STATUS TIMESTAMP -->

                            <!-- /USER STATUS ICON -->
                        </div>
                        <!-- /USER STATUS -->

                        <!-- NOTIFICATION BOX CLOSE BUTTON -->
                        <div class="notification-box-close-button">
                            <!-- NOTIFICATION BOX CLOSE BUTTON ICON -->
                            <svg class="notification-box-close-button-icon icon-cross">
                                <use xlink:href="#svg-cross"></use>
                            </svg>
                            <!-- /NOTIFICATION BOX CLOSE BUTTON ICON -->
                        </div>
                        <!-- /NOTIFICATION BOX CLOSE BUTTON -->

                        <!-- MARK UNREAD BUTTON -->
                        <div class="mark-unread-button"></div>
                        <!-- /MARK UNREAD BUTTON -->
                    </div>
                    <%}%>
                    <!-- /NOTIFICATION BOX -->

                </div>
                <!-- /NOTIFICATION BOX LIST -->
            </div>
            <!-- /GRID COLUMN -->
        </div>

    </div>

    <div id="recuperacionContenido" class="oculto">

        <div class="section-filters-bar v1">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form class="form">
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button" style="opacity: 0;height: 1px!important;">
                        <label for="friends-search_4">Buscar por usuario</label>
                        <input type="text" id="friends-search_4" name="friends_search" disabled>
                        <!-- BUTTON -->
                        <button style="cursor: auto;" class="button primary">
                            <!-- ICON MAGNIFYING GLASS -->
                            <svg style="cursor: auto;" class="icon-magnifying-glass">
                                <use style="cursor: auto;" xlink:href="#svg-magnifying-glass"></use>
                            </svg>
                            <!-- /ICON MAGNIFYING GLASS -->
                        </button>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /FORM INPUT -->

                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="cambiarVistaSolicitudesDeValidacion">Cambiar de vista</label>
                        <select id="cambiarVistaSolicitudesDeValidacion">
                            <option value="0">Solicitudes de Registro</option>
                            <option value="1">Donaciones</option>
                            <option value="2">Reportes</option>
                            <option value="3">Solicitudes de Validación</option>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->
                </form>
                <!-- /FORM -->

                <!-- FILTER TABS -->
                <div class="filter-tabs">
                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable"  id="opcionSolicitudes_3">Solicitudes de Registro</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p  class="filter-tab-text clickeable" id="opcionDonaciones_3">Donaciones</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->

                    <!-- FILTER TAB -->
                    <div class="filter-tab">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionReportes_3">Reportes </p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                    <!-- /FILTER TAB -->
                    <div class="filter-tab active">
                        <!-- FILTER TAB TEXT -->
                        <p class="filter-tab-text clickeable" id="opcionRecuperacion_3"> Solicitudes de Validación</p>
                        <!-- /FILTER TAB TEXT -->
                    </div>
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>

        <!-- TABLE WRAP -->
        <div class="table-wrap" data-simplebar>
            <!-- TABLE -->
            <div class="table table-sales">
                <!-- TABLE HEADER -->
                <div class="table-header">
                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Fecha</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Correo</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Tipo</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->

                    <!-- /TABLE HEADER COLUMN -->

                    <!-- TABLE HEADER COLUMN -->
                    <div class="table-header-column centered padded">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">Código Validación</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>
                    <!-- /TABLE HEADER COLUMN -->

                    <div class="table-header-column centered padded text-center" style="display: none">
                        <!-- TABLE HEADER TITLE -->
                        <p class="table-header-title">link</p>
                        <!-- /TABLE HEADER TITLE -->
                    </div>

                    <!-- /TABLE HEADER COLUMN -->

                    <!-- /TABLE HEADER COLUMN -->
                </div>
                <!-- /TABLE HEADER -->

                <!-- TABLE BODY -->
                <div class="table-body same-color-rows">


                    <%for (Validacion validacion : recuperacionList){
                        if(!validacion.getTipo().equals("enviarLinkACorreo" )){%>
                    <!-- TABLE ROW -->
                    <div class="table-row micro">
                        <!-- TABLE COLUMN -->
                        <div class="table-column">
                            <!-- TABLE TEXT -->
                            <p class="table-text"><span class="light"><%=validacion.getFechaHora()%></span></p>
                            <!-- /TABLE TEXT -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->

                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title"> <%=validacion.getCorreo()%> </p>
                            <!-- /TABLE TITLE -->
                        </div>

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title"><%=validacion.getTipo()%></p>
                            <!-- /TABLE TITLE -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <div class="table-column centered padded">
                            <%if(validacion.getTipo().equals("NecesitaUnKit")){%>
                            <!-- TABLE TITLE -->
                            <p class="table-title">-</p>
                            <!-- /TABLE TITLE -->
                            <%}else{%>
                            <!-- TABLE TITLE -->
                            <p class="table-title"><%=validacion.getCodigoValidacion()%></p>
                            <!-- /TABLE TITLE -->
                            <%}%>
                        </div>

                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded" style="display: none">
                            <!-- TABLE TITLE -->
                            <%String link = "mips";%>
                            <%if(validacion.getTipo().equals("enviarLinkACorreo")) {
                                link = ip+":8080/proyectouwu_war_exploded/RegistroServlet?idCorreoValidacion=" + validacion.getIdCorreoValidacion() + "&codigoValidacion256=" + validacion.getCodigoValidacion256();
                            }else if(validacion.getTipo().equals("recuperarContrasena")){link = ip+"/proyectouwu_war_exploded/RecuperarContrasenaSegundoCasoServlet?idCorreoValidacion="+validacion.getIdCorreoValidacion()+"&codigoValidacion256="+validacion.getCodigoValidacion256();}%>
                            <p class="table-title"><a href="<%=link%>">Link</a></p>
                            <!-- /TABLE TITLE -->
                        </div>
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <%if(validacion.getTipo().equals("enviarLinkACorreo")){%>

                            <%}else if (validacion.getTipo().equals("recuperarContrasena")){%>
                                <%if(!validacion.isLinkEnviado()){%>
                                    <form method="post" action="?action=enviarCorreoJava">
                                        <input type="hidden" name="idCorreoValidacion" value="<%=validacion.getIdCorreoValidacion()%>">
                                        <button class="button-accept" type="submit">
                                            Enviar
                                        </button>
                                    </form>
                                <%}else{%>
                                    <button class="button-accept" style="opacity: 0.5">
                                        Enviado
                                    </button>
                                <%}%>
                            <%} else {%>
                                <%if(!validacion.isLinkEnviado()){%>
                                    <form method="post" action="?action=enviarCorreoJava">
                                        <input type="hidden" name="idCorreoValidacion" value="<%=validacion.getIdCorreoValidacion()%>">
                                        <button class="button-accept" type="submit">
                                            Enviar
                                        </button>
                                    </form>
                                <%}else{%>
                                    <button class="button-accept" style="opacity: 0.5">
                                        Enviado
                                    </button>
                                <%}%>
                            <%}%>
                            <!-- /TABLE TITLE -->
                        </div>
                        <!-- /TABLE COLUMN -->
                    </div>
                    <!-- /TABLE ROW -->
                    <%}
                    }
                    %>
                </div>
                <!-- /TABLE BODY -->
            </div>
            <!-- /TABLE -->
        </div>
        <!-- /TABLE WRAP -->

        <!-- SECTION PAGER BAR WRAP -->
        <div class="section-pager-bar-wrap align-center">
            <!-- SECTION PAGER BAR -->
            <div class="section-pager-bar">
                <!-- SECTION PAGER -->
                <div class="section-pager">
                    <!-- SECTION PAGER ITEM -->
                    <%for(int p=0;p<cantidadTotalPageValidacion;p++){%>
                    <div class="section-pager-item <%if(pagActualV==p+1){%>active<%}%>">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <%if(p<9){%>
                        <a class="section-pager-item-text" href="NotificacionesServlet?pv=<%=p+1%>&vistaActualNueva=Recuperacion">0<%=p+1%></a>
                        <%}else{%>
                        <a class="section-pager-item-text" href="NotificacionesServlet?pv=<%=p+1%>&vistaActualNueva=Recuperacion"><%=p+1%></a>
                        <%}%>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->
                    <%}%>
                </div>
                <!-- /SECTION PAGER -->

            </div>
            <!-- /SECTION PAGER BAR -->
        </div>


    </div>

</div> <!--GRID-->
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

<%for(int i=0;i<listaSolicitudes.size();i++){%>
<div class="overlay" id="overlayPopupRechazar<%=i%>"></div>
<div class="popup" style="max-width: 30%" id="popupRechazar<%=i%>">
    <svg class="cerrarPopup" id="cerrarPopupRechazar<%=i%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <h5 style="text-align: center;">Escribe el motivo de rechazo al usuario:</h5>
            </div>
            <div class="col-sm-1"></div>
        </div>
    </div>
    <br>
    <form method="post" action="NotificacionesServlet?action=rechazarRegistro">
        <div class="row">
            <div class="col-sm-1">
            </div>
            <div class="col-sm-10">
                <textarea name="motivoRechazo" cols="15" rows="6" required></textarea>
            </div>
            <div class="col-sm-1">
            </div>
        </div>
        <div style="margin-top: 3%" class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">

                    <input type="hidden" name="idUsuarioARegistrar" value="<%=listaSolicitudes.get(i).getIdUsuario()%>">
                    <a> <button type="submit" class="button secondary" id="cerrarPopupRechazar1Solicitud<%=i%>">Rechazar</button></a>

                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="button" class="button secondary" id="cerrarPopupRechazar2Solicitud<%=i%>" style="background-color: grey;">Cancelar</button>
                </div>
            </div>
        </div>
    </form>

</div>
<%}%>

<%for(int i=0;i<donacionList.size();i++){%>
<div class="overlay" id="overlayPopupImagenDonacion<%=i%>"></div>
<div class="popup" style="max-width: 30%" id="popupImagenDonacion<%=i%>">
    <svg class="cerrarPopup" id="cerrarPopupImagenDonacion<%=i%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div class="row">
        <%request.getSession().setAttribute("fotoDonacion"+i,donacionList.get(i).getCaptura());%>
        <div class="container-fluid">
            <img src="Imagen?tipoDeFoto=fotoDonacion&id=Donacion<%=i%>" class="img-fluid">
        </div>
    </div>
</div>
<%}%>

<%for(int i=0;i<donacionList.size();i++){%>
<div class="overlay" <%if(alerta!=null&&idDonacionElegida!=null&&idDonacionElegida==donacionList.get(i).getIdDonacion()){%>style="display: block"<%}%> id="overlayPopupEditarDonacion<%=i%>"></div>
<div class="popup" style="max-width: 400px;<%if(alerta!=null&&idDonacionElegida!=null&&idDonacionElegida==donacionList.get(i).getIdDonacion()){%>display: block<%}%>" id="popupEditarDonacion<%=i%>">
    <svg class="cerrarPopup" id="cerrarPopupEditarDonacion<%=i%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form method="post" action="<%=request.getContextPath()%>/NotificacionesServlet?action=edit" onsubmit="return validarMonto(<%=i%>)">
        <div class="mb-3">
            <input type="hidden" class="form-control" name="idDonacion" id="idDonacion<%=i%>" value="<%=donacionList.get(i).getIdDonacion()%>">
        </div>
        <div class="mb-3">
            <label>Monto</label>
            <div>
                <input type="text" class="form-control" name="montoDonacion" id="montoDonacion<%=i%>" oninput="limpiarAdvertencia(<%=i%>)" value="<%=donacionList.get(i).getMonto()%>">
                <%if(alerta!=null&&idDonacionElegida!=null&&idDonacionElegida==donacionList.get(i).getIdDonacion()){%><a style="color: red;">Ingrese un monto válido</a><%}%>
            </div>
        </div>
        <div class="mb-3">
            <label for="estadoDonacion<%=i%>">Estado de la donación</label>
            <select name="estadoDonacion" style="padding: 10px;" id="estadoDonacion<%=i%>">
                <option value="Validado" <%if(donacionList.get(i).getEstadoDonacion().equals("Validado")){%>selected<%}%>>&nbsp;&nbsp;&nbsp; Validado</option>
                <option value="Pendiente" <%if(donacionList.get(i).getEstadoDonacion().equals("Pendiente")){%>selected<%}%>>&nbsp;&nbsp;&nbsp; Pendiente</option>
            </select>
        </div>
        <br>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="submit" class="button secondary" id="cerrarPopupEditar1Donacion<%=i%>">Guardar</button>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <a class="button secondary" id="cerrarPopupEditar2Donacion<%=i%>" style="background-color: grey; width: 100%;color: white">Cancelar</a>
                </div>
            </div>
        </div>
    </form>
</div>
<%}%>

<%int d=0;
    for(Donacion donacion : donacionList){if(donacion.getEstadoDonacion().equals("Pendiente")){%>
<div class="overlay" id="overlayPopupRechazarDonacion<%=d%>"></div>
<div class="popup" style="max-width: 400px" id="popupRechazarDonacion<%=d%>">
    <svg class="cerrarPopup" id="cerrarPopupRechazarDonacion<%=d%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div class="row" style="display: flex;justify-content: center">
        <div style="margin-bottom: 10px">
            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-exclamation-circle-fill" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
            </svg>
        </div>
    </div>
    <form method="post" action="<%=request.getContextPath()%>/NotificacionesServlet?action=deleteDonacion">
        <div class="mb-3">
            <input type="hidden" class="form-control" name="id" value="<%=donacion.getIdDonacion()%>">
        </div>
        <div class="mb-3"><h5 class="text-center">¿Estás seguro de rechazar esta donación? Esta acción es irrevertible</h5></div>
        <br>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="submit" class="button secondary" id="cerrarPopupRechazar1Donacion<%=d%>">Rechazar</button>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <a class="button secondary" id="cerrarPopupRechazar2Donacion<%=d%>" style="background-color: grey; width: 100%;color: white">Cancelar</a>
                </div>
            </div>
        </div>
    </form>
</div>
<%}d++;}%>

<script>
        function limpiarAdvertencia(index) {
        var mensajeAdvertencia = document.getElementById('mensajeAdvertencia' + index);
        mensajeAdvertencia.textContent = ''; // Limpiar el mensaje de advertencia
    }

        function validarMonto(index) {
        var montoInput = document.getElementById('montoDonacion' + index).value;
        var mensajeAdvertencia = document.getElementById('mensajeAdvertencia' + index);

        if (montoInput === null || montoInput.trim() === '') {
        mensajeAdvertencia.textContent = 'Ingrese un monto numérico';
        return false; // Evitar que se envíe el formulario
    }

        // Validar que sea un número
        if (isNaN(parseFloat(montoInput))) {
        mensajeAdvertencia.textContent = 'El monto debe ser un valor numérico';
        return false; // Evitar que se envíe el formulario
    }

        mensajeAdvertencia.textContent = ''; // Limpiar el mensaje de advertencia
        return true; // Permitir que se envíe el formulario
    }
</script>

<script>
    function enviarFormulario(idForm) {
        var formulario = document.getElementById(idForm);
        formulario.submit();
    }

    function func(popupId,cerrarClass,overlayId){
        const overlay=document.getElementById(overlayId);
        const popup=document.getElementById(popupId);
        const mostrarPopup = () => {
            overlay.style.display = 'block';
            popup.style.display = 'block';
            // Desactivar el scroll
            document.body.style.overflow = 'hidden';
        };
        mostrarPopup();
        const cerrarPopup = () => {
            overlay.style.display = 'none';
            popup.style.display = 'none';
            document.body.style.overflow = 'auto';
        };
        for(let i=0;i<cerrarClass.length;i++){
            document.getElementById(cerrarClass[i]).addEventListener('click', cerrarPopup);
        }

        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) {
                cerrarPopup();
            }
        });

        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                cerrarPopup();
            }
        });
    }

    function popupFunc(popupId,abrirId,cerrarClass,overlayId){
        const showPopup=document.getElementById(abrirId);
        const overlay=document.getElementById(overlayId);
        const popup=document.getElementById(popupId);
        const mostrarPopup = () => {
            overlay.style.display = 'block';
            popup.style.display = 'block';
            // Desactivar el scroll
            document.body.style.overflow = 'hidden';
        };
        showPopup.addEventListener('click', mostrarPopup);
        const cerrarPopup = () => {
            overlay.style.display = 'none';
            popup.style.display = 'none';
            document.body.style.overflow = 'auto';
        };
        for(let i=0;i<cerrarClass.length;i++){
            document.getElementById(cerrarClass[i]).addEventListener('click', cerrarPopup);
        }

        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) {
                cerrarPopup();
            }
        });

        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                cerrarPopup();
            }
        });
    }
    <%for(int i=0;i<donacionList.size();i++){%>
    popupFunc('popupImagenDonacion<%=i%>','mostrarPopupImagenDonacion<%=i%>',['cerrarPopupImagenDonacion<%=i%>'],'overlayPopupImagenDonacion<%=i%>');
    <%}%>
    <%for(int i=0;i<donacionList.size();i++){%>
    popupFunc('popupEditarDonacion<%=i%>','mostrarPopupEditarDonacion<%=i%>',['cerrarPopupEditarDonacion<%=i%>','cerrarPopupEditar1Donacion<%=i%>','cerrarPopupEditar2Donacion<%=i%>'],'overlayPopupEditarDonacion<%=i%>');
    <%}%>
    <%for(int i=0;i<listaSolicitudes.size();i++){%>
    popupFunc('popupRechazar<%=i%>','mostrarPopupRechazar<%=i%>',['cerrarPopupRechazar<%=i%>','cerrarPopupRechazar1Solicitud<%=i%>','cerrarPopupRechazar2Solicitud<%=i%>'],'overlayPopupRechazar<%=i%>');
    <%}%>
</script>
    <!-- app -->
    <script src="js/utils/app.js"></script>
    <!-- page loader -->
    <script src="js/utils/page-loader.js"></script>
    <!-- simplebar -->
    <script src="js/vendor/simplebar.min.js"></script>
    <!-- liquidify -->
    <script src="js/utils/liquidify.js"></script>
    <!-- XM_Plugins -->
    <script src="js/vendor/xm_plugins.min.js"></script>
    <!-- tiny-slider -->
    <script src="js/vendor/tiny-slider.min.js"></script>
    <!-- global.hexagons -->
    <script src="js/global/global.hexagons.js"></script>
    <!-- global.tooltips -->
    <script src="js/global/global.tooltips.js"></script>
    <!-- global.popups -->
    <script src="js/global/global.popups.js"></script>
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
    <!-- global.accordions -->


<script>
    // Función para alternar entre las opciones y mostrar el contenido correspondiente
    function mostrarContenido(opcion) {
        const opciones = ["Solicitudes", "Donaciones", "Reportes","Recuperacion"];

        opciones.forEach(op => {
            const contenido = document.getElementById(op.toLowerCase() + "Contenido");
            if (op === opcion) {
                contenido.style.display = 'block';
            } else {
                contenido.style.display = 'none';
            }
        });
    }
    function cambiarVista(idSelect){
        let select=document.getElementById(idSelect);
        let solicitudes=document.getElementById('cambiarVistaSolicitudesDeRegistro');
        let reportes=document.getElementById('cambiarVistaReportes');
        let donaciones=document.getElementById('cambiarVistaDonaciones');
        let recuperacion=document.getElementById('cambiarVistaSolicitudesDeValidacion');
        select.addEventListener("change",function (){
           switch (select.value){
               case '0':
                   mostrarContenido("Solicitudes");
                   solicitudes.value='0';
                   reportes.value='0';
                   donaciones.value='0';
                   recuperacion.value='0';
                   break;
               case '1':
                   mostrarContenido("Donaciones");
                   solicitudes.value='1';
                   reportes.value='1';
                   donaciones.value='1';
                   recuperacion.value='1';
                   break;
               case '2':
                   mostrarContenido("Reportes");
                   solicitudes.value='2';
                   reportes.value='2';
                   donaciones.value='2';
                   recuperacion.value='2';
                   break;
               case '3':
                   mostrarContenido("Recuperacion");
                   solicitudes.value='3';
                   reportes.value='3';
                   donaciones.value='3';
                   recuperacion.value='3';
                   break;
           }
        });
    }
    cambiarVista('cambiarVistaSolicitudesDeRegistro');
    cambiarVista('cambiarVistaReportes');
    cambiarVista('cambiarVistaDonaciones');
    cambiarVista('cambiarVistaSolicitudesDeValidacion');
    // Agregar eventos de clic para cada opción
    document.getElementById("opcionSolicitudes").addEventListener("click", function() {
        mostrarContenido("Solicitudes");
    });

    document.getElementById("opcionDonaciones").addEventListener("click", function() {
        mostrarContenido("Donaciones");
    });

    document.getElementById("opcionReportes").addEventListener("click", function() {
        mostrarContenido("Reportes");
    });
    document.getElementById("opcionRecuperacion").addEventListener("click", function() {
        mostrarContenido("Recuperacion");
    });
    // Agregar eventos de clic para cada opción
    document.getElementById("opcionSolicitudes_1").addEventListener("click", function() {
        mostrarContenido("Solicitudes");
    });

    document.getElementById("opcionDonaciones_1").addEventListener("click", function() {
        mostrarContenido("Donaciones");
    });

    document.getElementById("opcionReportes_1").addEventListener("click", function() {
        mostrarContenido("Reportes");
    });
    document.getElementById("opcionRecuperacion_1").addEventListener("click", function() {
        mostrarContenido("Recuperacion");
    });
    document.getElementById("opcionSolicitudes_2").addEventListener("click", function() {
        mostrarContenido("Solicitudes");
    });

    document.getElementById("opcionDonaciones_2").addEventListener("click", function() {
        mostrarContenido("Donaciones");
    });

    document.getElementById("opcionReportes_2").addEventListener("click", function() {
        mostrarContenido("Reportes");
    });
    document.getElementById("opcionRecuperacion_2").addEventListener("click", function() {
        mostrarContenido("Recuperacion");
    });

    document.getElementById("opcionSolicitudes_3").addEventListener("click", function() {
        mostrarContenido("Solicitudes");
    });

    document.getElementById("opcionDonaciones_3").addEventListener("click", function() {
        mostrarContenido("Donaciones");
    });

    document.getElementById("opcionReportes_3").addEventListener("click", function() {
        mostrarContenido("Reportes");
    });
    document.getElementById("opcionRecuperacion_3").addEventListener("click", function() {
        mostrarContenido("Recuperacion");
    });
    <%if (vistaActualNueva==null){%>

        mostrarContenido("Solicitudes");

    <%}
    else{%>

        <%switch (vistaActualNueva){

            case "Solicitudes":%>

                mostrarContenido("Solicitudes");

               <% break;

            case "Donaciones":%>

                mostrarContenido("Donaciones");

                <% break;

            case "Reportes":%>

                mostrarContenido("Reportes");

                <% break;
            case "Recuperacion":%>

                mostrarContenido("Recuperacion");

    <% break;
}%>
    <%}%>


</script>
<script>
    // Obtener referencias a elementos HTML
    const fondo = document.getElementById('fondo');
    const showPopup = document.getElementById('showPopup');
    const imagePopup = document.getElementById('imagePopup');
    const closePopup = document.getElementById('closePopup');

    // Mostrar el pop-up al hacer clic en "link"
    showPopup.addEventListener('click', function () {
        imagePopup.style.display = 'block';
        fondo.style.display = 'block';
        document.body.style.overflow = 'hidden';
    });

    // Cerrar el pop-up al hacer clic en "Cerrar"
    closePopup.addEventListener('click', function () {
        imagePopup.style.display = 'none';
        document.body.style.overflow = 'auto';
        fondo.style.display = 'none';
    });
</script>

<script>
    // Obtener referencias a elementos HTML
    const showPopup_1 = document.getElementById('showPopup_1');
    const imagePopup_1 = document.getElementById('imagePopup_1');
    const closePopup_1 = document.getElementById('closePopup_1');

    // Mostrar el pop-up al hacer clic en "link"
    showPopup_1.addEventListener('click', function () {
        imagePopup_1.style.display = 'block';
        fondo.style.display = 'block';
        document.body.style.overflow = 'hidden';
    });

    // Cerrar el pop-up al hacer clic en "Cerrar"
    closePopup_1.addEventListener('click', function () {
        imagePopup_1.style.display = 'none';
        document.body.style.overflow = 'auto';
        fondo.style.display = 'none';
    });
</script>

<script>
    // Obtener elementos del DOM
    const openPopupButton = document.getElementById('openPopup');
    const montoPopup = document.getElementById('montoPopup');
    const nuevoMontoInput = document.getElementById('nuevoMonto');
    const guardarMontoButton = document.getElementById('guardarMonto');
    const cerrarPopupButton = document.getElementById('cerrarPopup');
    const botonValor = document.getElementById('openPopup');

    // Función para abrir el popup y mostrar el valor actual
    openPopupButton.addEventListener('click', function () {
        montoPopup.style.display = 'block';
        document.getElementById('popupMonto').style.display = 'block';
        nuevoMontoInput.value = botonValor.innerText.replace("S/", "");
    });

    // Función para cerrar el popup
    cerrarPopupButton.addEventListener('click', () => {
        montoPopup.style.display = 'none';
        document.getElementById('popupMonto').style.display = 'none';
    });

    // Función para guardar el nuevo monto y actualizar el botón
    guardarMontoButton.addEventListener('click', () => {
        const nuevoMonto = nuevoMontoInput.value;
        botonValor.innerText = `S/${nuevoMonto}`;
        montoPopup.style.display = 'none';
        document.getElementById('popupMonto').style.display = 'none';
    });
    function enviarCorreoAceptar(correo,idForm){
        var destinatario = correo;
        var asunto = '¡Su cuenta ha sido aprobada! - Siempre Fibra';
        var contenido = "Sus datos han sido correctamente validados dentro de la plataforma. Ahora ya puede iniciar sesión y formar parte vital del equipo en Semana de Ingeniería.\n\nIngrese a su cuenta en <%=ip%>:8080/proyectouwu_war_exploded/ y sé parte de la experiencia SDI.\n\n\nSiempre Fibra";
        var mailtoLink = 'NotificacionesServlet?correo='+destinatario +'&subject=' + encodeURIComponent(asunto) + '&body=' + encodeURIComponent(contenido);
        window.location.href = mailtoLink;
        let form=document.getElementById(idForm);
        form.submit();
    }
</script>

</body>
</html>