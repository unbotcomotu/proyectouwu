<%@ page import="com.example.proyectouwu.Beans.AlumnoPorEvento" %>
<%@ page import="com.example.proyectouwu.Beans.Usuario" %>
<%@ page import="com.example.proyectouwu.Daos.DaoUsuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Daos.DaoNotificacion" %>
<%@ page import="com.example.proyectouwu.Daos.DaoEvento" %><%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 24/10/2023
  Time: 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <%Usuario usuarioActual=(Usuario) request.getSession().getAttribute("usuario");
        int idUsuario=usuarioActual.getIdUsuario();
        String rolUsuario=usuarioActual.getRol();
        String nombreCompletoUsuario=usuarioActual.getNombre()+" "+usuarioActual.getApellido();
        String action = request.getSession().getAttribute("actionNotificacionesServlet")!= null ? (String) request.getSession().getAttribute("actionNotificacionesServlet") : "";
        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo=(ArrayList<AlumnoPorEvento>) request.getAttribute("listaSolicitudesApoyo");
        Integer idActividadDelegatura= (Integer) request.getAttribute("idActividadDelegatura");
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        ArrayList<Usuario>listaIDyNombresDelegadosDeActividad=(ArrayList<Usuario>)request.getAttribute("IDyNombreDelegadosDeActividad");
        int pSolicitudesDeApoyo=Integer.parseInt ((String) request.getSession().getAttribute("pSolicitudesDeApoyo"));
        int cantidadTotalSolicitudesDeApoyo= (int)  Math.ceil((int)request.getAttribute("cantidadTotalSolicitudesApoyo")/12.0);
        String servletActual="NotificacionesServlet";
        ArrayList<AlumnoPorEvento>listaNotificacionesDelegadoDeActividad=(ArrayList<AlumnoPorEvento>) request.getAttribute("listaNotificacionesDelegadoDeActividad");
        String colorRol;
        if(rolUsuario.equals("Alumno")){
            colorRol="";
        }else if(rolUsuario.equals("Delegado de Actividad")){
            colorRol="green";
        }else{
            colorRol="orange";
        }
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
    <link rel="stylesheet" href="css/vendor/tiny-slider.css">
    <!-- favicon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="icon" href="img/favicon.ico">
    <title>Notificaciones - Siempre Fibra</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @media screen and (max-width: 680px) {
            .auxResponsiveUwu{
                display: none;
            }
        }
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

    <!-- NO BORRAR ESTO-->
    <%if(rolUsuario.equals("Alumno")){%>
    <!-- ACTION ITEM WRAP USUARIO -->
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
    <%}else if(rolUsuario.equals("Delegado de Actividad")){%>
    <!-- HEADER ACTIONS DELEGADO DE ACTIVIDAD -->
    <div class="header-actions">
        <!-- ACTION LIST -->
        <div class="action-list dark">
            <!-- ACTION LIST ITEM WRAP -->
            <div class="action-list-item-wrap">
                <!-- ACTION LIST ITEM -->
                <div class="action-list-item  <%if(!listaNotificacionesDelegadoDeActividad.isEmpty()){%> unread <%}%>header-dropdown-trigger">
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
                        <%for(AlumnoPorEvento noti:listaNotificacionesDelegadoDeActividad){%>
                        <form id="notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>" method="post" action="PaginaNoExisteServlet?action=notificacionLeidaCampanitaDelegadoDeActividad">
                            <input type="hidden" name="idAlumnoPorEvento" value="<%=noti.getIdAlumnoPorEvento()%>">
                            <input type="hidden" name="servletActual" value="<%=servletActual%>">
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
                                                <%request.getSession().setAttribute("fotoActividad"+listaNotificacionesDelegadoDeActividad.indexOf(noti),noti.getAlumno().getFotoPerfil());%>
                                                <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
                                                <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Actividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>"></div>
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
                                    <p class="user-status-title"><a class="bold"><%=noti.getAlumno().getNombre()%> <%=noti.getAlumno().getApellido()%></a> desea apoyar el evento <a class="highlighted">Fibra Tóxica VS <%=noti.getEvento().getTitulo()%></a></p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacion().obtenerDiferenciaEntre2FechasNotificacionesDelegadoDeActividad(noti.getIdAlumnoPorEvento());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario('notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>')">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                </div>
                                <!-- /USER STATUS -->
                            </div>
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
    <%}else{%>
    <!-- HEADER ACTIONS DELEGADO GENERAL -->
    <!-- /HEADER ACTIONS -->
    <%}%>
    <!-- /HEADER ACTIONS -->
</header>
<!-- /HEADER -->

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
        <p class="section-banner-text">Aquí se podrá ver las solicitudes de apoyo a la actividad.</p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <!-- GRID -->

    <div class="section-filters-bar v1">
        <!-- SECTION FILTERS BAR ACTIONS -->
        <div class="section-filters-bar-actions">
            <!-- FORM -->
            <form method="get" action="<%=request.getContextPath()%>/NotificacionesServlet" class="form">
                <!-- FORM INPUT -->

                <div class="form-input small with-button">
                    <label for="friends-search">Buscar usuarios</label>
                    <input type="hidden" name="action" value="buscarUsuario">
                    <%String busquedaSolicitudes=(String) request.getAttribute("busquedaSolicitudes");%>
                    <input type="text" id="friends-search" name="busquedaSolicitudes" <%if(busquedaSolicitudes!=null){%> value="<%=busquedaSolicitudes%>"<%}%>>
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
                <!-- /FORM INPUT -->


            </form>
            <!-- /FORM -->

            <!-- FILTER TABS -->
            <div class="filter-tabs">
                <!-- FILTER TAB -->
                <div class="filter-tab active">
                    <!-- FILTER TAB TEXT -->
                    <p  class="filter-tab-text" >Solicitudes de Apoyo</p>
                    <!-- /FILTER TAB TEXT -->
                </div>
                <!-- /FILTER TAB -->

                <!-- /FILTER TAB -->
            </div>
            <!-- /FILTER TABS -->
        </div>

    </div>

    <div class="grid grid-4-4-4 centered">
        <%int contador = 0;%>
        <%for (AlumnoPorEvento alumnoPorEvento : listaSolicitudesApoyo ){%>
        <!-- USER PREVIEW -->
        <div class="user-preview">
            <!-- USER PREVIEW COVER -->
            <figure class="user-preview-cover liquid" style="background: linear-gradient(to right,#38abd9,#1fbfac);"></figure>
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
                            <%request.getSession().setAttribute("fotoPerfil"+listaSolicitudesApoyo.indexOf(alumnoPorEvento),alumnoPorEvento.getAlumno().getFotoPerfil());%>
                            <!-- HEXAGON -->
                            <div class="hexagon-image-82-90" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Perfil<%=listaSolicitudesApoyo.indexOf(alumnoPorEvento)%>"></div>
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
                    <%DaoUsuario usuarioOWO = new DaoUsuario();%>

                    <!-- USER SHORT DESCRIPTION TITLE -->
                    <p class="user-short-description-title" style="color: rgb(22, 143, 143);"> <%= usuarioOWO.nombreCompletoUsuarioPorId(alumnoPorEvento.getAlumno().getIdUsuario())%> </p>
                    <!-- /USER SHORT DESCRIPTION TITLE -->

                    <!-- USER SHORT DESCRIPTION TEXT -->
                    <p class="user-short-description-text" style="text-transform: lowercase;"> <%= usuarioOWO.correoUsuarioPorId(alumnoPorEvento.getAlumno().getIdUsuario())%>  </p>
                    <!-- /USER SHORT DESCRIPTION TEXT -->
                    <div style="display: flex;justify-content: center;margin-top: 20px">
                        <button onclick="popupFunc('popupSeguro<%=listaSolicitudesApoyo.indexOf(alumnoPorEvento)%>',['cerrarPopupSeguro<%=listaSolicitudesApoyo.indexOf(alumnoPorEvento)%>'],'overlaySeguro<%=listaSolicitudesApoyo.indexOf(alumnoPorEvento)%>')" style="width: 40px;background: none;border:0;color: inherit"><img src="css/iconoSeguro.png" style="width: 100%;" alt=""></button>
                    </div>
                </div>
                <!-- /USER SHORT DESCRIPTION -->

                <!-- USER PREVIEW STATS SLIDES -->
                <div id="user-preview-stats-slides-01_1" class="user-preview-stats-slides" style="margin-top: 10px !important;">
                    <!-- USER PREVIEW STATS SLIDE -->
                    <div class="user-preview-stats-slide">

                        <div class="container-fluid">

                            <div class="row">

                                <div class="col-sm-6 px-5 mt-3" style="text-align: center;">

                                    <p style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.75rem;width: 100%;" >Rival: <%= new DaoEvento().nombreEventoPorID(alumnoPorEvento.getEvento().getIdEvento())%> </p>

                                </div>

                                <div class="col-sm-6 px-5 mt-3" style="text-align: center;">

                                    <p style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;width: 100%" >Condición: <%= usuarioOWO.condicionUsuarioPorId(alumnoPorEvento.getAlumno().getIdUsuario())%> </p>

                                </div>
                            </div>

                        </div>


                        <!-- /USER STATS -->
                    </div>

                </div>
                <!-- /USER PREVIEW STATS SLIDES -->

                <div class="user-preview-actions">
                    <!-- BUTTON -->
                    <div class="container-fluid">
                        <div class="row" >
                            <div class="col-sm-6">
                                <form method="post" action="<%=request.getContextPath()%>/NotificacionesServlet?action=aceptarSolicitudApoyo">
                                    <input type="hidden" name="idAlumnoPorEvento" value="<%=alumnoPorEvento.getIdAlumnoPorEvento()%>">
                                    <input type="hidden" name="tipoDeApoyo" value="Barra">
                                    <button type="submit" class="button-accept">Barra</button>
                                </form>
                            </div>
                            <div class="col-sm-6">
                                <form method="post" action="<%=request.getContextPath()%>/NotificacionesServlet?action=aceptarSolicitudApoyo">
                                    <input type="hidden" name="idAlumnoPorEvento" value="<%=alumnoPorEvento.getIdAlumnoPorEvento()%>">
                                    <input type="hidden" name="tipoDeApoyo" value="Jugador">
                                    <button type="submit" class="button-reject">Jugador</button>
                                </form>
                            </div>
                        </div>
                        <!--<button class="button-accept">Aceptar</button>
                        <button class="button-reject">Rechazar</button>-->
                    </div>
                    <!-- /BUTTON -->
                </div>
                <!-- /USER PREVIEW ACTIONS -->
            </div>
            <!-- /USER PREVIEW INFO -->
        </div>
        <!-- /USER PREVIEW -->
        <%contador++;%>
        <%}%>

    </div>
    <!-- /GRID -->

    <!-- SECTION PAGER BAR -->
    <div class="section-pager-bar">
        <!-- SECTION PAGER -->
        <div class="section-pager">
            <!-- SECTION PAGER ITEM -->
            <%  for(int p=0;p<cantidadTotalSolicitudesDeApoyo; p++){%>
            <div class="section-pager-item <%if(pSolicitudesDeApoyo==p+1){%>active<%}%>">
                <%if(!action.isEmpty()){%>
                <%if (p<9){%>
                <!-- SECTION PAGER ITEM TEXT -->
                <a class="section-pager-item-text" href="NotificacionesServlet?p=<%=p+1%>&busquedaSolicitudes=<%=busquedaSolicitudes%>">0<%=p+1%></a>
                <!-- /SECTION PAGER ITEM TEXT -->
                <%} else {%>
                <!-- SECTION PAGER ITEM TEXT -->
                <a class="section-pager-item-text" href="NotificacionesServlet?&p=<%=p+1%>&busquedaSolicitudes=<%=busquedaSolicitudes%>"><%=p+1%></a>
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
    <p class="section-results-text">Mostrando <%=contador%> de <%=(Integer) request.getAttribute("cantidadTotalSolicitudesApoyo")%> solicitudes</p>
    <!-- /SECTION RESULTS TEXT -->



</div> <!--GRID-->

<footer style="font-size: 80%;">
    <!-- Primera fila -->
    <div class="fila">
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
    </div>
    <div class="fila">

    </div>
</footer>
<!-- /GRID -->
<%for(int i=0;i<listaSolicitudesApoyo.size();i++){%>
<div class="overlay" id="overlaySeguro<%=i%>"></div>
<div class="popup" style="max-width: 30%" id="popupSeguro<%=i%>">
    <svg class="cerrarPopup" id="cerrarPopupSeguro<%=i%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div class="row"><div class="col"><h5 style="text-align: center;">Foto subida del seguro</h5></div></div>
    <div class="row" style="margin-top: 20px">
        <%request.getSession().setAttribute("fotoSeguro"+i,listaSolicitudesApoyo.get(i).getAlumno().getFotoSeguro());%>
        <div class="container-fluid">
            <img src="Imagen?tipoDeFoto=fotoSeguro&id=Seguro<%=i%>" class="img-fluid">
        </div>
    </div>
</div>
<%}%>

<script>
    function enviarFormulario(idForm) {
        var formulario = document.getElementById(idForm);
        formulario.submit();
    }
    function popupFunc(popupId,cerrarClass,overlayId){
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
            if(popupId=='popupApoyar'){
                blockButton('mostrarPopupApoyar');
            }
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


<!--Scripts para cambios de vista-->

</body>
</html>
