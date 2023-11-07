<%@ page import="com.example.proyectouwu.Beans.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.Reporte" %>
<%@ page import="com.example.proyectouwu.Daos.DaoUsuario" %>
<%@ page import="com.example.proyectouwu.Beans.Donacion" %>
<%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 22/10/2023
  Time: 01:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <%int idUsuario=(int) request.getAttribute("idUsuario");
        String rolUsuario=(String) request.getAttribute("rolUsuario");
        String nombreCompletoUsuario=(String) request.getAttribute("nombreCompletoUsuario");
        ArrayList<Usuario> listaSolicitudes=(ArrayList<Usuario>) request.getAttribute("listaSolicitudes");
        ArrayList<Reporte> reportList = (ArrayList<Reporte>) request.getAttribute("reportList");
        ArrayList<Donacion> donacionList = (ArrayList<Donacion>) request.getAttribute("donacionList");
        Integer idActividadDelegatura=(Integer)request.getAttribute("idActividadDelegatura");
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        ArrayList<Usuario>listaIDyNombresDelegadosDeActividad=(ArrayList<Usuario>)request.getAttribute("IDyNombreDelegadosDeActividad");
        String colorRol;
        if(rolUsuario.equals("Alumno")){
            colorRol="";
        }else if(rolUsuario.equals("Delegado de Actividad")){
            colorRol="green";
        }else{
            colorRol="orange";
        }

        String vistaActualNueva= (String) request.getAttribute("vistaActualNueva");

        System.out.println(vistaActualNueva );
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
    <link rel="icon" href="img/favicon.ico">
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
    </style>


    <style>
        .button-reject {
            background-color: red; /* Cambia el fondo del botón a rojo */
            color: white; /* Cambia el color del texto a blanco */
            /* Puedes ajustar otros estilos según tus preferencias, como el tamaño del texto, el borde, etc. */
        }
    </style>

    <style>
        @media screen and (max-width: 680px) {
            .auxResponsiveUwu{
                display: none;
            }
        }
    </style>



    <style>
        /* Estilos para el pop-up */
        .popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);

            /*align-items: center;
            justify-content: center;*/
        }
        .popup-content {
            background-color: white;
            /*max-width: 80%;*/
            padding: 20px;
            top: 50%;
            left: 50%;
            border-radius: 5px;
            transform: translate(-50%, -50%);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            /*text-align: center; /* Centra horizontalmente el contenido */
            display: none;
            position: fixed;
        }
        .popup-content img {
            max-width: 50%;
            height: auto;
            display: block; /* Elimina cualquier espacio en blanco debajo de la imagen */
            margin: 0 auto;

        }
    </style>

</head>
<body>

<!-- PAGE LOADER -->
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
            <div class="hexagon-image-30-32" data-src="css/fotoMichi.png"></div>
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
                <!-- HEXAGON -->
                <div class="hexagon-22-24"></div>
                <!-- /HEXAGON -->
            </div>
            <!-- /USER AVATAR BADGE BORDER -->

            <!-- USER AVATAR BADGE CONTENT -->
            <div class="user-avatar-badge-content">
                <!-- HEXAGON -->
                <div class="hexagon-dark-16-18"></div>
                <!-- /HEXAGON -->
            </div>
            <!-- /USER AVATAR BADGE CONTENT -->

            <!-- USER AVATAR BADGE TEXT -->
            <p class="user-avatar-badge-text">24</p>
            <!-- /USER AVATAR BADGE TEXT -->
        </div>
        <!-- /USER AVATAR BADGE -->
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
            <a class="menu-item-link text-tooltip-tfr" href="<%=request.getContextPath()%>/MiCuentaServlet?idUsuario=<%=idUsuario%>" data-title="Mi cuenta">
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
            <a class="menu-item-link text-tooltip-tfr" href="<%=request.getContextPath()%>/ListaDeActividadesServlet?idUsuario=<%=idUsuario%>" data-title="Actividades">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/actividadIconoGris.png" class="menu-item-link-icon icon-members" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <%if(rolUsuario.equals("Delegado General")){%>
        <li class="menu-item <%if(vistaActual.equals("analiticas")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr text-center" href="<%=request.getContextPath()%>/AnaliticasServlet?idUsuario=<%=idUsuario%>" data-title="Analíticas">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/analiticasIcono.png" width="70%" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <!-- /MENU ITEM -->
        <li class="menu-item <%if(vistaActual.equals("listaDeUsuarios")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr text-center" href="<%=request.getContextPath()%>/ListaDeUsuariosServlet?idUsuario=<%=idUsuario%>" data-title="Usuarios">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/usuariosIcono.png" width="70%" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <%}else{%>
        <li class="menu-item <%if(vistaActual.equals("misEventos")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr" href="<%=request.getContextPath()%>/MisEventosServlet?idUsuario=<%=idUsuario%>" data-title="Mis eventos">
                <!-- MENU ITEM LINK ICON -->
                <img src="css/misEventosIcono.png" class="menu-item-link-icon icon-members" alt="">
                <!-- /MENU ITEM LINK ICON -->
            </a>
            <!-- /MENU ITEM LINK -->
        </li>
        <li class="menu-item <%if(vistaActual.equals("misDonaciones")){%>active<%}%>">
            <!-- MENU ITEM LINK -->
            <a class="menu-item-link text-tooltip-tfr" href="<%=request.getContextPath()%>/MisDonacionesServlet?idUsuario=<%=idUsuario%>" data-title="Donaciones">
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
                <div class="hexagon-image-82-90" data-src="css/fotoMichi.png"></div>
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
        <a class="menu-item-link" href="<%=request.getContextPath()%>/MiCuentaServlet?idUsuario=<%=idUsuario%>">
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
        <a class="menu-item-link" href="<%=request.getContextPath()%>/ListaDeActividadesServlet?idUsuario=<%=idUsuario%>">
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
        <a class="menu-item-link" href="<%=request.getContextPath()%>/AnaliticasServlet?idUsuario=<%=idUsuario%>">
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
        <a class="menu-item-link" href="<%=request.getContextPath()%>/ListaDeUsuariosServlet?idUsuario=<%=idUsuario%>">
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
        <a class="menu-item-link" href="<%=request.getContextPath()%>/MisEventosServlet?idUsuario=<%=idUsuario%>">
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
        <a class="menu-item-link" href="<%=request.getContextPath()%>/MisDonacionesServlet?idUsuario=<%=idUsuario%>">
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
                    <div class="hexagon-image-30-32" data-src="css/fotoMichi.png"></div>
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

        <!-- NAVIGATION WIDGET BUTTON -->
        <a href="<%=request.getContextPath()%>/IndexServlet"><p class="navigation-widget-info-button button small secondary">Cerrar sesión</p></a>
        <!-- /NAVIGATION WIDGET BUTTON -->
    </div>
    <!-- /NAVIGATION WIDGET INFO WRAP -->

    <!-- MENU -->
    <ul class="menu">



        <!-- NAVIGATION WIDGET SECTION TITLE -->
        <p class="navigation-widget-section-title">Perfil</p>
        <!-- /NAVIGATION WIDGET SECTION TITLE -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/MiCuentaServlet?idUsuario=<%=idUsuario%>">Mi cuenta</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->

        <!-- NAVIGATION WIDGET SECTION TITLE -->
        <p class="navigation-widget-section-title">Funciones</p>
        <!-- /NAVIGATION WIDGET SECTION TITLE -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/ListaDeActividadesServlet?idUsuario=<%=idUsuario%>">Actividades</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->
        <%if(rolUsuario.equals("Delegado General")){%>
        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/AnaliticasServlet?idUsuario=<%=idUsuario%>">Analíticas</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/ListaDeUsuariosServlet?idUsuario=<%=idUsuario%>">Usuarios</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->
        <%}else{%>
        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/MisEventosServlet?idUsuario=<%=idUsuario%>">Mis eventos</a>
        <!-- /NAVIGATION WIDGET SECTION LINK -->

        <!-- NAVIGATION WIDGET SECTION LINK -->
        <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/MisDonacionesServlet?idUsuario=<%=idUsuario%>">Donaciones</a>
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
            <a href="<%=request.getContextPath()%>"><img src="css/logOut.png" width="30%" alt=""></a>
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
                    <a class="dropdown-box-button secondary" href="<%=request.getContextPath()%>/NotificacionesServlet?idUsuario=<%=idUsuario%>">Ver todas las notificaciones</a>
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
                <a href="<%=request.getContextPath()%>"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
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
                                <p class="user-status-title"><a class="bold">Javier Milei</a> está solicitando la aprobación de su <a class="highlighted">registro</a> en la plataforma.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 20 minutos</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/iconoRegistro.png" width="30px" alt="">
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
                                            <div class="hexagon-image-30-32" data-src="css/fotoAlex.png"></div>
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
                                <p class="user-status-title"><a class="bold">Alex Segovia</a> realizó una  <a class="highlighted">donación</a> de <a style="color: orange;">S/. 3</a>.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 37 minutos</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/donacionIcono.png" width="30px" alt="">
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
                                            <div class="hexagon-image-30-32" data-src="css/fotoMayte.png"></div>
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
                                <p class="user-status-title"><a class="bold">Mayte Asto</a> realizó una  <a class="highlighted">donación</a> de <a style="color: orange;">S/. 100</a>.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 54 minutos</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/donacionIcono.png" width="30px" alt="">
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
                                <p class="user-status-title"><a class="bold">Rubén Agapito</a> está solicitando la aprobación de su <a class="highlighted">registro</a> en la plataforma.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 1 hora</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/iconoRegistro.png" width="30px" alt="">
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
                                            <div class="hexagon-image-30-32" data-src="css/fotoYarleque.png"></div>
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
                                <p class="user-status-title"><a class="bold">Manuel Yarleque</a> realizó una  <a class="highlighted">donación</a> de <a style="color: orange;">S/. 1</a>.</p>
                                <!-- /USER STATUS TITLE -->

                                <!-- USER STATUS TIMESTAMP -->
                                <p class="user-status-timestamp">Hace 2 horas</p>
                                <!-- /USER STATUS TIMESTAMP -->

                                <!-- USER STATUS ICON -->
                                <div class="user-status-icon">
                                    <!-- ICON COMMENT -->
                                    <img src="css/donacionIcono.png" width="30px" alt="">
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
                    <a class="dropdown-box-button secondary" href="<%=request.getContextPath()%>/NotificacionesServlet?idUsuario=<%=idUsuario%>">Ver todas las notificaciones</a>
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
                <a href="<%=request.getContextPath()%>"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
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
        <img class="section-banner-icon" src="css/noti.png" width="14%" alt="">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title">Centro de Notificaciones</p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text">Aquí podrá ver las nuevas solicitudes de registro, las donaciones y los reportes</p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <!-- GRID -->

    <div class="oculto" id="solicitudesContenido">

        <div class="section-filters-bar v1">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form method="post" action="<%=request.getContextPath()%>/NotificacionesServlet?action=buscarUsuario" class="form">
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button">
                        <label for="friends-search_1">Buscar usuarios</label>
                        <%String busquedaSolicitudes=(String) request.getAttribute("busquedaSolicitudes");%>
                        <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                        <input type="text" id="friends-search_1" name="busquedaSolicitudes" <%if(busquedaSolicitudes!=null){%> value="<%=busquedaSolicitudes%>"<%}%>>
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

                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="friends-filter-category_1">Filter By</label>
                        <select id="friends-filter-category_1">
                            <option >Solicitudes de Registro</option>
                            <option >Donaciones</option>
                            <option >Reportes</option>
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
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>

        <div class="grid grid-4-4-4 centered">

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


                            <!-- /USER STATS -->
                        </div>

                    </div>
                    <!-- /USER PREVIEW STATS SLIDES -->

                    <div class="user-preview-actions">
                        <!-- BUTTON -->

                        <div class="container-fluid">

                            <div class="row" >


                                <div class="col-sm-6">
                                    <a href="<%=request.getContextPath()%>/NotificacionesServlet?action=aceptarRegistro&idUsuarioARegistrar=<%=usuario_pendiente.getIdUsuario()%>&idUsuario=<%=idUsuario%>" ><button class="button-accept">Aceptar</button></a>
                                </div>
                                <div class="col-sm-6">
                                    <a href="<%=request.getContextPath()%>/NotificacionesServlet?action=rechazarRegistro&idUsuarioARegistrar=<%=usuario_pendiente.getIdUsuario()%>&idUsuario=<%=idUsuario%>"><button class="button-reject"  >Rechazar</button></a>
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
            <%}%>
        </div>
        <!-- /GRID -->

        <!-- SECTION PAGER BAR -->
        <div class="section-pager-bar">
            <!-- SECTION PAGER -->
            <div class="section-pager">
                <!-- SECTION PAGER ITEM -->
                <div class="section-pager-item active">
                    <!-- SECTION PAGER ITEM TEXT -->
                    <p class="section-pager-item-text">01</p>
                    <!-- /SECTION PAGER ITEM TEXT -->
                </div>
                <!-- /SECTION PAGER ITEM -->

                <!-- SECTION PAGER ITEM -->
                <div class="section-pager-item">
                    <!-- SECTION PAGER ITEM TEXT -->
                    <p class="section-pager-item-text">02</p>
                    <!-- /SECTION PAGER ITEM TEXT -->
                </div>
                <!-- /SECTION PAGER ITEM -->

                <!-- SECTION PAGER ITEM -->
                <div class="section-pager-item">
                    <!-- SECTION PAGER ITEM TEXT -->
                    <p class="section-pager-item-text">03</p>
                    <!-- /SECTION PAGER ITEM TEXT -->
                </div>
                <!-- /SECTION PAGER ITEM -->

                <!-- SECTION PAGER ITEM -->
                <div class="section-pager-item">
                    <!-- SECTION PAGER ITEM TEXT -->
                    <p class="section-pager-item-text">04</p>
                    <!-- /SECTION PAGER ITEM TEXT -->
                </div>
                <!-- /SECTION PAGER ITEM -->

                <!-- SECTION PAGER ITEM -->
                <div class="section-pager-item">
                    <!-- SECTION PAGER ITEM TEXT -->
                    <p class="section-pager-item-text">05</p>
                    <!-- /SECTION PAGER ITEM TEXT -->
                </div>
                <!-- /SECTION PAGER ITEM -->

                <!-- SECTION PAGER ITEM -->
                <div class="section-pager-item">
                    <!-- SECTION PAGER ITEM TEXT -->
                    <p class="section-pager-item-text">06</p>
                    <!-- /SECTION PAGER ITEM TEXT -->
                </div>
                <!-- /SECTION PAGER ITEM -->
            </div>
            <!-- /SECTION PAGER -->

            <!-- SECTION PAGER CONTROLS -->
            <div class="section-pager-controls">
                <!-- SLIDER CONTROL -->
                <div class="slider-control left disabled">
                    <!-- SLIDER CONTROL ICON -->
                    <svg class="slider-control-icon icon-small-arrow">
                        <use xlink:href="#svg-small-arrow"></use>
                    </svg>
                    <!-- /SLIDER CONTROL ICON -->
                </div>
                <!-- /SLIDER CONTROL -->

                <!-- SLIDER CONTROL -->
                <div class="slider-control right">
                    <!-- SLIDER CONTROL ICON -->
                    <svg class="slider-control-icon icon-small-arrow">
                        <use xlink:href="#svg-small-arrow"></use>
                    </svg>
                    <!-- /SLIDER CONTROL ICON -->
                </div>
                <!-- /SLIDER CONTROL -->
            </div>
            <!-- /SECTION PAGER CONTROLS -->
        </div>
        <!-- /SECTION PAGER BAR -->

        <!-- SECTION RESULTS TEXT -->
        <p class="section-results-text">Mostrando 6 de 38 solicitudes</p>
        <!-- /SECTION RESULTS TEXT -->
    </div>

    <div id="donacionesContenido" class="oculto">

        <div class="section-filters-bar v1">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form class="form">
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button">
                        <label for="friends-search_2">Buscar usuarios</label>
                        <input type="text" id="friends-search_2" name="friends_search">
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

                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="friends-filter-category_2">Filter By</label>
                        <select id="friends-filter-category_2" name="friends_filter_category">
                            <option >Solicitudes de Registro</option>
                            <option >Donaciones</option>
                            <option >Reportes</option>
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
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>
        <div class="section-filters-bar v6 v6-2">
            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                <form class="form">
                    <!-- FORM ITEM -->
                    <div class="form-item split">
                        <!-- FORM INPUT DECORATED -->
                        <div class="form-input-decorated">
                            <!-- FORM INPUT -->
                            <div class="form-input small active">
                                <label for="statement-from-date">Fecha de Inicio</label>
                                <input type="text" id="statement-from-date" name="statement_from_date" value="02/10/2023">
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
                                <input type="text" id="statement-to-date" name="statement_to_date" value="11/10/2023">
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
                            <a class="table-link" href="marketplace-product.html"><span class="highlighted"> <%=usuarioUwu.nombreCompletoUsuarioPorId(donacion.getIdUsuario())%>  </span></a>
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
                            <p class="table-title"> <%= usuarioUwu.condicionUsuarioPorId(donacion.getIdUsuario())%> </p>
                            <!-- /TABLE TITLE -->
                        </div>

                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title" ><span class="highlighted">pulse aquí</span></p>
                            <!-- /TABLE TITLE -->
                        </div>
                        <!-- /TABLE COLUMN -->

                        <!-- TABLE COLUMN -->
                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                            <p class="table-title"> <%=donacion.getEstadoDonacion()%> </p>
                            <!-- /TABLE TITLE -->
                        </div>

                        <div class="table-column centered padded">
                            <!-- TABLE TITLE -->
                             <a class="button-accept" href="<%=request.getContextPath()%>/NotificacionesServlet?action=edit&id=<%=donacion.getIdDonacion()%>&idUsuario=<%=idUsuario%>">Editar</a>
                            <!-- /TABLE TITLE -->
                        </div>

                        <div class="table-column centered padded">
                            <a class="button-reject" href="<%=request.getContextPath()%>/NotificacionesServlet?action=delete&id=<%=donacion.getIdDonacion()%>&idUsuario=<%=idUsuario%>">Borrar</a>

                        </div>

                        <!-- /TABLE COLUMN -->
                    </div>
                    <!-- /TABLE ROW -->

                    <%}%>


                </div>
                <!-- /TABLE BODY -->
            </div>
            <!-- /TABLE -->
        </div>
        <!-- /TABLE WRAP -->

        <!-- SECTION PAGER BAR WRAP -->
        <div class="section-pager-bar-wrap align-right">
            <!-- SECTION PAGER BAR -->
            <div class="section-pager-bar">
                <!-- SECTION PAGER -->
                <div class="section-pager">
                    <!-- SECTION PAGER ITEM -->
                    <div class="section-pager-item active">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <p class="section-pager-item-text">01</p>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->

                    <!-- SECTION PAGER ITEM -->
                    <div class="section-pager-item">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <p class="section-pager-item-text">02</p>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->

                    <!-- SECTION PAGER ITEM -->
                    <div class="section-pager-item">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <p class="section-pager-item-text">03</p>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->

                    <!-- SECTION PAGER ITEM -->
                    <div class="section-pager-item">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <p class="section-pager-item-text">04</p>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->

                    <!-- SECTION PAGER ITEM -->
                    <div class="section-pager-item">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <p class="section-pager-item-text">05</p>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->

                    <!-- SECTION PAGER ITEM -->
                    <div class="section-pager-item">
                        <!-- SECTION PAGER ITEM TEXT -->
                        <p class="section-pager-item-text">06</p>
                        <!-- /SECTION PAGER ITEM TEXT -->
                    </div>
                    <!-- /SECTION PAGER ITEM -->
                </div>
                <!-- /SECTION PAGER -->

                <!-- SECTION PAGER CONTROLS -->
                <div class="section-pager-controls">
                    <!-- SLIDER CONTROL -->
                    <div class="slider-control left disabled">
                        <!-- SLIDER CONTROL ICON -->
                        <svg class="slider-control-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /SLIDER CONTROL ICON -->
                    </div>
                    <!-- /SLIDER CONTROL -->

                    <!-- SLIDER CONTROL -->
                    <div class="slider-control right">
                        <!-- SLIDER CONTROL ICON -->
                        <svg class="slider-control-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /SLIDER CONTROL ICON -->
                    </div>
                    <!-- /SLIDER CONTROL -->
                </div>
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
                <form class="form">
                    <!-- FORM INPUT -->
                    <div class="form-input small with-button">
                        <label for="friends-search_3">Buscar usuarios</label>
                        <input type="text" id="friends-search_3" name="friends_search">
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

                    <!-- FORM SELECT -->
                    <div class="form-select">
                        <label for="friends-filter-category_3">Filter By</label>
                        <select id="friends-filter-category_3" name="friends_filter_category">
                            <option >Solicitudes de Registro</option>
                            <option >Donaciones</option>
                            <option >Reportes</option>
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
                </div>
                <!-- /FILTER TABS -->
            </div>

        </div>
        <div class="grid medium-space">

            <!-- GRID COLUMN -->
            <div class="account-hub-content">
                <!-- SECTION HEADER -->
                <div class="section-header">
                    <!-- SECTION HEADER INFO -->
                    <div class="section-header-info">

                        <!-- SECTION TITLE -->
                        <h2 class="section-title">Notificaciones</h2>
                        <!-- /SECTION TITLE -->
                    </div>
                    <!-- /SECTION HEADER INFO -->

                    <!-- SECTION HEADER ACTIONS -->
                    <div class="section-header-actions">
                        <!-- SECTION HEADER ACTION -->
                        <p class="section-header-action">Marcar todos como leídos</p>
                        <!-- /SECTION HEADER ACTION -->
                    </div>
                    <!-- /SECTION HEADER ACTIONS -->
                </div>
                <!-- /SECTION HEADER -->

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
                                        <!-- HEXAGON -->
                                        <div class="hexagon-image-30-32" data-src="css\fotoAlex.png"></div>
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
                            <p class="user-status-title"><a class="bold" ><%=daoUser.nombreCompletoUsuarioPorId(reporteNuevo.getIdUsuarioQueReporta())%></a> ha reportado a <a class="highlighted" ><%=daoUser.nombreCompletoUsuarioPorId(reporteNuevo.getIdUsuarioReportado())%></a> <%= reporteNuevo.getMotivoReporte()%></p>
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

                <!-- LOADER BARS -->
                <div class="loader-bars">
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                    <div class="loader-bar"></div>
                </div>
                <!-- /LOADER BARS -->
            </div>
            <!-- /GRID COLUMN -->
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
            <p>© 2023 Fibra tóxica</p>
            <ul class="lista">
                <li><a>Siguenos en: </a> <i class="fab fa-facebook"></i> <i class="fab fa-instagram"></i> <i class="fab fa-youtube"></i></li>
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
<div class="popup" id="fondo">
</div>

<div class="popup-content" id="imagePopup">
    <img src="css\plin.jpeg" alt="Imagen">
    <button class= "mt-3"id="closePopup">Cerrar</button>
</div>

<div class="popup-content" id="imagePopup_1">
    <img src="css/yape.jpeg" alt="Imagen">
    <button class= "mt-3"id="closePopup_1">Cerrar</button>
</div>

<div class="popup" id="montoPopup"></div>
<div class="popup-content" id="popupMonto">
    <label for="nuevoMonto">Nuevo Monto: </label>
    <input type="text" id="nuevoMonto">
    <button id="guardarMonto">Guardar</button>
    <button id="cerrarPopup">Cerrar</button>
</div>


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
        const opciones = ["Solicitudes", "Donaciones", "Reportes"];

        opciones.forEach(op => {
            const contenido = document.getElementById(op.toLowerCase() + "Contenido");
            if (op === opcion) {
                contenido.style.display = 'block';
            } else {
                contenido.style.display = 'none';
            }
        });
    }

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
    document.getElementById("opcionSolicitudes_2").addEventListener("click", function() {
        mostrarContenido("Solicitudes");
    });

    document.getElementById("opcionDonaciones_2").addEventListener("click", function() {
        mostrarContenido("Donaciones");
    });

    document.getElementById("opcionReportes_2").addEventListener("click", function() {
        mostrarContenido("Reportes");
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
</script>

</body>
</html>
