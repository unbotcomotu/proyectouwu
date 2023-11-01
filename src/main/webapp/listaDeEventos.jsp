<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.Actividad" %>
<%@ page import="com.example.proyectouwu.Beans.Evento" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.proyectouwu.Beans.LugarEvento" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%int idUsuario=(int) request.getAttribute("idUsuario");
        int idActividad = (int) request.getAttribute("idActividad");
        String rolUsuario=(String) request.getAttribute("rolUsuario");
        String nombreCompletoUsuario=(String) request.getAttribute("nombreCompletoUsuario");
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        ArrayList<Evento>listaEventos=(ArrayList<Evento>)request.getAttribute("listaEventos");
        String nombreActividad=(String)request.getAttribute("nombreActividad");
        ArrayList<LugarEvento>listaLugares=(ArrayList<LugarEvento>) request.getAttribute("listaLugares");
        int delegadoDeEstaActividadID=(int)request.getAttribute("delegadoDeEstaActividadID");
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
    <link rel="stylesheet" href="css/raw/styles.css">
    <!-- simplebar styles -->
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <!-- favicon -->
    <link rel="icon" href="img/favicon.ico">
    <title><%=nombreActividad%> - Siempre Fibra</title>
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
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            border-radius: 12px;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            z-index: 10001;
        }
        /* Estilo para el botón de cerrar */
        .cerrarPopup {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }
        .btn-file1 {
            position: relative;
            overflow: hidden;
        }

        .btn-file1 input[type="file"] {
            position: absolute;
            top: 0;
            right: 0;
            min-width: 100%;
            min-height: 100%;
            font-size: 100px;
            filter: alpha(opacity=0);
            opacity: 0;
            outline: none;
            background: white;
            cursor: inherit;
            display: block;
        }
        .text-sticker-aux{
            height: 32px;
            padding: 0;
            border-radius: 200px;
            background-color: #fff;
            box-shadow: 3px 5px 20px 0 rgba(94, 92, 154, 0.12);
            font-size: 0.875rem;
            font-weight: 700;
            line-height: 32px;
        }
        .text-sticker-aux.round {
            border-radius: 12px;
        }

        .text-sticker-aux .highlighted {
            color: #00c7d9;
        }

        .text-sticker-aux .text-sticker-icon {
            margin-right: 4px;
            fill: #00c7d9;
        }

        .text-sticker-aux.small-text {
            font-size: 0.75rem;
        }

        .text-sticker-aux.small {
            height: 24px;
            padding: 0 12px;
            font-size: 0.75rem;
            line-height: 24px;
        }

        .text-sticker-aux.medium {
            height: 44px;
            padding: 0 16px;
            line-height: 44px;
        }

        .text-sticker-aux.negative {
            color: #fff;
            background: #15151f;
        }

        .text-sticker.aux.void {
            box-shadow: none;
            background-color: transparent;
        }
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
        @media screen and (max-width: 577px) {
            .contenedor2{
                top:20px !important;
            }
        }
        @media screen and (max-width: 680px) {
            .auxResponsiveUwu{
                display: none;
            }
        }
        @media screen and (max-width: 777px) {
            .recuadroTexto {
                margin-bottom: 15px;
            }

            .contenedorCrear {
                width: 80% !important;
            }
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
        <img class="section-banner-icon" src="css/telitoVoley.png" alt="marketplace-icon">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title"><%=nombreActividad%></p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text">Encuentra todos los eventos dentro de <%=nombreActividad%></p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <!-- SECTION HEADER -->
    <div class="section-header">
        <div class="container-fluid" style="width: 100%;">
            <!-- SECTION HEADER INFO -->
            <div class="row" style="width: 100%;">
                <div class="section-header-info col-sm-auto recuadroTexto">
                    <!-- SECTION PRETITLE -->
                    <p class="section-pretitle">Busca los eventos que desees</p>
                    <!-- /SECTION PRETITLE -->

                    <!-- SECTION TITLE -->
                    <h2 class="section-title">Lista de eventos</h2>
                    <!-- /SECTION TITLE -->
                </div>
                <%if(delegadoDeEstaActividadID==idUsuario){%>
                <div class="section-filters-bar-actions col-sm-auto d-flex justify-content-end recuadro recuadroFila" style="width: 150px;">
                    <!-- BUTTON -->
                    <button class="button secondary popup-event-creation-trigger botones" style="width: 100%;" id="mostrarPopupCrear">Crear evento</button>
                    <!-- /BUTTON -->
                </div>
                <!-- /SECTION HEADER INFO -->
                <div class="section-filters-bar-actions col-sm-auto d-flex justify-content-end recuadro recuadroFila" style="width: 150px;">
                    <!-- BUTTON -->
                    <button class="button secondary popup-event-creation-trigger botones" id="mostrarPopupFinalizar" style="width: 100%;">Finalizar evento</button>
                    <!-- /BUTTON -->
                </div>
                <%}%>
            </div>
        </div>
    </div>
    <!-- /SECTION HEADER -->

    <!-- SECTION FILTERS BAR -->
    <div class="section-filters-bar v4">
        <!-- SECTION FILTERS BAR ACTIONS -->
        <div class="section-filters-bar-actions">
            <!-- FORM -->
            <form class="form">
                <!-- FORM ITEM -->
                <div class="form-item split">
                    <!-- FORM INPUT -->
                    <div class="form-input small">
                        <label for="items-search">Buscar evento</label>
                        <input type="text" id="items-search" name="items_search">
                    </div>
                    <!-- /FORM INPUT -->

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
        <div class="section-filters-bar-actions">
            <!-- FORM -->
            <form class="form">
                <!-- FORM ITEM -->
                <div class="form-item split medium">
                    <!-- FORM SELECT -->
                    <div class="form-select small">
                        <label for="items-filter-category">Ordenar por</label>
                        <select id="items-filter-category" name="items_filter_category">
                            <option value="0">Más reciente</option>
                            <option value="1">Orden alfabético</option>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->

                    <!-- FORM SELECT -->
                    <div class="form-select small">
                        <label for="items-filter-order">Sentido</label>
                        <select id="items-filter-order" name="items_filter_order">
                            <option value="0">Ascendente</option>
                            <option value="1">Descendente</option>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->

                    <!-- BUTTON -->
                    <button class="button secondary">Aplicar filtros</button>
                    <!-- /BUTTON -->
                </div>
                <!-- /FORM ITEM -->
            </form>
            <!-- /FORM -->
        </div>
        <!-- /SECTION FILTERS BAR ACTIONS -->
    </div>
    <!-- /SECTION FILTERS BAR -->

    <!-- GRID -->
    <div class="grid grid-3-9 small-space">
        <!-- MARKETPLACE SIDEBAR -->
        <div class="marketplace-sidebar">
            <!-- SIDEBAR BOX -->
            <div class="sidebar-box">
                <!-- SIDEBAR BOX TITLE -->
                <p class="sidebar-box-title">Estado</p>
                <!-- SIDEBAR BOX TITLE -->
                <div class="sidebar-box-items">
                    <!-- CHECKBOX LINE -->
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="category-logos-and-badges" name="cantidadEventosFinalizados">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="category-logos-and-badges">Finalizado</label>
                        </div>
                        <!-- /CHECKBOX WRAP -->
                        <!-- CHECKBOX LINE TEXT -->
                        <%Integer cantidadEventosFinalizados=(Integer) request.getAttribute("cantidadEventosFinalizados");%>
                        <p class="checkbox-line-text"><%=cantidadEventosFinalizados%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->
                    <%if(!rolUsuario.equals("Delegado General")){%>
                    <!-- CHECKBOX LINE -->
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="category-sketch" name="cantidadEventosApoyando">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="category-sketch">Apoyando</label>
                        </div>
                        <!-- /CHECKBOX WRAP -->

                        <!-- CHECKBOX LINE TEXT -->
                        <%Integer cantidadEventosApoyando=(Integer) request.getAttribute("cantidadEventosApoyando");%>
                        <p class="checkbox-line-text"><%=cantidadEventosApoyando%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->
                    <!-- /SIDEBAR BOX TITLE -->
                    <%}if(delegadoDeEstaActividadID==idUsuario||rolUsuario.equals("Delegado General")){%>
                    <!-- CHECKBOX LINE -->
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="ola" name="ola">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="ola">Oculto</label>
                        </div>
                        <!-- /CHECKBOX WRAP -->
                        <%Integer cantidadEventosOcultos=(Integer) request.getAttribute("cantidadEventosOcultos");%>
                        <!-- CHECKBOX LINE TEXT -->
                        <p class="checkbox-line-text"><%=cantidadEventosOcultos%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->
                    <%}%>
                </div>
                    <!-- SIDEBAR BOX TITLE -->
                    <p class="sidebar-box-title">Ubicación</p>
                    <!-- /SIDEBAR BOX TITLE -->
                <!-- SIDEBAR BOX ITEMS -->
                <div class="sidebar-box-items">
                    <!-- CHECKBOX LINE -->
                    <%ArrayList<Integer[]>listaLugaresCantidad=(ArrayList<Integer[]>) request.getAttribute("listaLugaresCantidad");
                    for(Integer[] par:listaLugaresCantidad){%>
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="category-<%=listaLugaresCantidad.indexOf(par)%>" name="lugar<%=listaLugaresCantidad.indexOf(par)%>">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="category-<%=listaLugaresCantidad.indexOf(par)%>"><%=new DaoLugarEvento().lugarPorID(par[0])%></label>
                        </div>
                        <!-- /CHECKBOX WRAP -->

                        <!-- CHECKBOX LINE TEXT -->
                        <p class="checkbox-line-text"><%=par[1]%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->
                    <%}%>
                </div>
                <!-- /SIDEBAR BOX ITEMS -->

                <!-- SIDEBAR BOX TITLE -->
                <p class="sidebar-box-title">Fecha</p>
                <!-- /SIDEBAR BOX TITLE -->

                <!-- SIDEBAR BOX ITEMS -->
                <div class="sidebar-box-items">
                    <!-- CHECKBOX LINE -->
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="category-photoshop" name="category_photoshop">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="category-photoshop">Hoy</label>
                        </div>
                        <!-- /CHECKBOX WRAP -->

                        <!-- CHECKBOX LINE TEXT -->
                        <%Integer cantidadEventosHoy=(Integer) request.getAttribute("cantidadEventosHoy");%>
                        <p class="checkbox-line-text"><%=cantidadEventosHoy%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->

                    <!-- CHECKBOX LINE -->
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="category-illustrator" name="category_illustrator">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="category-illustrator">Mañana</label>
                        </div>
                        <!-- /CHECKBOX WRAP -->
                        <%Integer cantidadEventosManana=(Integer) request.getAttribute("cantidadEventosManana");%>
                        <!-- CHECKBOX LINE TEXT -->
                        <p class="checkbox-line-text"><%=cantidadEventosManana%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->

                    <!-- CHECKBOX LINE -->
                    <div class="checkbox-line">
                        <!-- CHECKBOX WRAP -->
                        <div class="checkbox-wrap">
                            <input type="checkbox" id="category-html-css" name="category_html-css">
                            <!-- CHECKBOX BOX -->
                            <div class="checkbox-box">
                                <!-- ICON CROSS -->
                                <svg class="icon-cross">
                                    <use xlink:href="#svg-cross"></use>
                                </svg>
                                <!-- /ICON CROSS -->
                            </div>
                            <!-- /CHECKBOX BOX -->
                            <label for="category-html-css">En 2 a más días</label>
                        </div>
                        <!-- /CHECKBOX WRAP -->
                        <%Integer cantidadEventos2DiasMas=(Integer) request.getAttribute("cantidadEventos2DiasMas");%>
                        <!-- CHECKBOX LINE TEXT -->
                        <p class="checkbox-line-text"><%=cantidadEventos2DiasMas%></p>
                        <!-- /CHECKBOX LINE TEXT -->
                    </div>
                    <!-- /CHECKBOX LINE -->
                </div>
                <!-- /SIDEBAR BOX ITEMS -->

                <!-- SIDEBAR BOX TITLE -->
                <p class="sidebar-box-title">Rango de horas</p>
                <!-- /SIDEBAR BOX TITLE -->

                <!-- SIDEBAR BOX ITEMS -->
                <div class="sidebar-box-items small-space">
                    <!-- FORM ITEM -->
                    <div class="form-item split">
                        <!-- FORM INPUT -->
                        <div class="form-input small active always-active">
                            <label for="price-from">Desde</label>
                            <input type="text" id="price-from" name="price_from">
                        </div>
                        <!-- /FORM INPUT -->

                        <!-- FORM INPUT -->
                        <div class="form-input small active always-active">
                            <label for="price-to">Hasta</label>
                            <input type="text" id="price-to" name="price_to">
                        </div>
                        <!-- /FORM INPUT -->
                    </div>
                    <!-- /FORM ITEM -->
                </div>
                <!-- /SIDEBAR BOX ITEMS -->

                <!-- BUTTON -->
                <p class="button small primary">Aplicar filtros de categoría</p>
                <!-- /BUTTON -->
            </div>
            <!-- /SIDEBAR BOX -->
        </div>
        <!-- /MARKETPLACE SIDEBAR -->

        <!-- MARKETPLACE CONTENT -->
        <div class="marketplace-content">
            <!-- GRID -->
            <div class="grid grid-3-3-3 centered">
                <%if(listaEventos!=null){%>
                <%for(Evento e:listaEventos){%>
                <!-- PRODUCT PREVIEW -->
                <%if(delegadoDeEstaActividadID==idUsuario||rolUsuario.equals("Delegado General")){%>
                <div class="product-preview">
                    <!-- PRODUCT PREVIEW IMAGE -->
                    <figure class="product-preview-image liquid" style="position: relative">
                        <a href="<%=request.getContextPath()%>/EventoServlet?idEvento=<%=e.getIdEvento()%>&idUsuario=<%=idUsuario%>">
                            <img src="css/fibraVShormigonMedio.png" style="position: absolute; z-index: 0" height="100%" alt="item-01">
                        </a>
                        <%if(delegadoDeEstaActividadID==idUsuario){%>
                        <a id="mostrarPopupEditarEvento<%=listaEventos.indexOf(e)%>">
                            <img src="css/ajustesEvento.png" style="position: absolute;left: 82%; z-index: 100;height: 50px;width: 50px;cursor: pointer" alt="">
                        </a>
                        <%}%>
                    </figure>
                    <!-- /PRODUCT PREVIEW IMAGE -->

                    <!-- PRODUCT PREVIEW INFO -->
                    <div class="product-preview-info">
                        <!-- TEXT STICKER -->
                        <p class="text-sticker" style="right: 180px;">
                            <%if(e.isEventoOculto()){%>
                            <span style="color: green;">Oculto</span>
                            <%}else{%>
                            <span style="color: brown;">No oculto</span><%}%>
                        </p>
                        <p class="text-sticker"><span class="highlighted">Fecha: </span>
                            <%if(e.isEventoFinalizado()){%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre</span>
                            <%}else{%>
                            <%int diasQueFaltanParaElEvento=new DaoEvento().diferenciaDiasEventoActualidad(e.getIdEvento());
                                if(diasQueFaltanParaElEvento==0){%>
                            <span style="color: red;">Hoy</span>
                            <%}else if(diasQueFaltanParaElEvento==1){%>
                            <span style="color: orangered;">Mañana</span>
                            <%}else if(diasQueFaltanParaElEvento==2){%>
                            <span style="color: orange;">En 2 días</span>
                            <%}else{%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre</span>
                            <%}}%>
                        </p>
                        <!-- /TEXT STICKER -->
                        <!-- PRODUCT PREVIEW TITLE -->
                        <%int tamanoLetraTitulo=0;
                        if(e.getTitulo().length()>36){
                            tamanoLetraTitulo=90;
                        }else if (e.getTitulo().length()>33){
                            tamanoLetraTitulo=95;
                        }else if(e.getTitulo().length()>30){
                            tamanoLetraTitulo=100;
                        }else{
                            tamanoLetraTitulo=110;
                        }%>
                        <p class="product-preview-title d-flex justify-content-center"><a style="font-size: <%=tamanoLetraTitulo%>%"><%=e.getTitulo()%></a></p>
                        <!-- /PRODUCT PREVIEW TITLE -->

                        <div class="row d-flex justify-content-around">
                            <div class="col-5">
                                <!-- PRODUCT PREVIEW CATEGORY -->
                                <p class="product-preview-category digital"><span class="highlighted">Hora: </span> <%String aux[]=e.getHora().toString().split(":");%><span style="color: blue"><%=Integer.parseInt(aux[0])+":"+aux[1]%></span></p>

                                <!-- /PRODUCT PREVIEW CATEGORY -->
                            </div>
                            <div class="col-7">
                                <!-- PRODUCT PREVIEW CATEGORY -->
                                <p class="product-preview-category digital"><span class="highlighted">Lugar: </span>
                                    <%String lugar=new DaoEvento().lugarPorEventoID(e.getLugarEvento());
                                        String lugarAux;
                                        if(lugar.length()>14) {
                                            String aux3[] = lugar.split(" ");
                                            lugarAux = aux3[0].charAt(0)+".";
                                            for (int i = 1; i < aux3.length; i++) {
                                                lugarAux += " " + aux3[i];
                                            }
                                        }else{
                                            lugarAux=lugar;
                                        }%>
                                    <span style="color: brown"><%=lugarAux%></span>
                                </p>
                                <!-- /PRODUCT PREVIEW CATEGORY -->
                            </div>
                        </div>
                        <!-- PRODUCT PREVIEW TEXT -->
                        <%String texto="";
                            if(e.isEventoFinalizado()){
                                texto=e.getResumen();
                            }else {
                                texto = e.getFraseMotivacional() + " " + e.getDescripcionEventoActivo();
                            }
                            String textoAux = "";
                            if(texto.length()>=107) {
                                char charAux[] = texto.toCharArray();

                                for (int i = 0; i < 107; i++) {
                                    textoAux += charAux[i];
                                }textoAux+="...";
                            }else{
                                textoAux=texto;
                            }
                        %>
                        <p class="product-preview-text"><%=textoAux%></p>
                        <!-- /PRODUCT PREVIEW TEXT -->
                    </div>
                    <!-- /PRODUCT PREVIEW INFO -->
                </div>
                <!-- /PRODUCT PREVIEW -->
                <%}else if(!e.isEventoOculto()){%>
                <!-- /PRODUCT PREVIEW -->
                <div class="product-preview">
                    <!-- PRODUCT PREVIEW IMAGE -->
                    <a href="<%=request.getContextPath()%>/EventoServlet?idEvento=<%=e.getIdEvento()%>&idUsuario=<%=idUsuario%>">
                        <figure class="product-preview-image liquid">
                            <img src="css/fibraVShormigonMedio.png" alt="item-01">
                        </figure>
                    </a>
                    <!-- /PRODUCT PREVIEW IMAGE -->

                    <!-- PRODUCT PREVIEW INFO -->
                    <div class="product-preview-info">
                        <!-- TEXT STICKER -->
                        <%if(new DaoAlumnoPorEvento().verificarApoyo(e.getIdEvento(),idUsuario)!=null){%>
                        <p class="text-sticker" style="right: 180px;"><span style="color: green;">Apoyando</span></p>
                        <%}else{%>
                        <p class="text-sticker" style="right: 170px;"><span style="color: brown;">No apoyando</span></p>
                        <%}%>
                        <p class="text-sticker"><span class="highlighted">Fecha: </span>
                            <%if(e.isEventoFinalizado()){%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre</span>
                            <%}else{%>
                            <%int diasQueFaltanParaElEvento=new DaoEvento().diferenciaDiasEventoActualidad(e.getIdEvento());
                                if(diasQueFaltanParaElEvento==0){%>
                            <span style="color: red;">Hoy</span>
                            <%}else if(diasQueFaltanParaElEvento==1){%>
                            <span style="color: orangered;">Mañana</span>
                            <%}else if(diasQueFaltanParaElEvento==2){%>
                            <span style="color: orange;">En 2 días</span>
                            <%}else{%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre</span>
                            <%}}%>
                        </p>
                        <!-- /TEXT STICKER -->
                        <%int tamanoLetraTitulo=0;
                            if(e.getTitulo().length()>36){
                                tamanoLetraTitulo=90;
                            }else if (e.getTitulo().length()>33){
                                tamanoLetraTitulo=95;
                            }else if(e.getTitulo().length()>30){
                                tamanoLetraTitulo=100;
                            }else{
                                tamanoLetraTitulo=110;
                            }%>
                        <p class="product-preview-title d-flex justify-content-center"><a style="font-size: <%=tamanoLetraTitulo%>%"><%=e.getTitulo()%></a></p>

                        <div class="row d-flex justify-content-around">
                            <div class="col-5">
                                <!-- PRODUCT PREVIEW CATEGORY -->
                                <p class="product-preview-category digital"><span class="highlighted">Hora: </span> <%String aux[]=e.getHora().toString().split(":");%><span style="color: blue"><%=Integer.parseInt(aux[0])+":"+aux[1]%></span>
                                </p>

                                <!-- /PRODUCT PREVIEW CATEGORY -->
                            </div>
                            <div class="col-7">
                                <!-- PRODUCT PREVIEW CATEGORY -->
                                <p class="product-preview-category digital"><span class="highlighted">Lugar: </span>
                                    <%String lugar=new DaoEvento().lugarPorEventoID(e.getLugarEvento());
                                        String lugarAux;
                                        if(lugar.length()>14) {
                                            String aux3[] = lugar.split(" ");
                                            lugarAux = aux3[0].charAt(0)+".";
                                            for (int i = 1; i < aux3.length; i++) {
                                                lugarAux += " " + aux3[i];
                                            }
                                        }else
                                            lugarAux=lugar;%>
                                    <span style="color: brown"><%=lugarAux%></span></p>
                                <!-- /PRODUCT PREVIEW CATEGORY -->
                            </div>
                        </div>
                        <!-- PRODUCT PREVIEW TEXT -->
                        <%String texto="";
                            if(e.isEventoFinalizado()){
                                texto=e.getResumen();
                            }else {
                                texto = e.getFraseMotivacional() + " " + e.getDescripcionEventoActivo();
                            }
                            String textoAux = "";
                            if(texto.length()>=107) {
                                char charAux[] = texto.toCharArray();

                                for (int i = 0; i < 107; i++) {
                                    textoAux += charAux[i];
                                }textoAux+="...";
                            }else{
                                textoAux=texto;
                            }
                        %>
                        <p class="product-preview-text"><%=textoAux%></p>
                        <!-- /PRODUCT PREVIEW TEXT -->
                    </div>
                    <!-- /PRODUCT PREVIEW INFO -->
                </div>
                <!-- PRODUCT PREVIEW -->
                <%}}}%>
            </div>
            <!-- /GRID -->

            <!-- SECTION PAGER BAR WRAP -->
            <div class="section-pager-bar-wrap align-center">
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
            <!-- /SECTION PAGER BAR WRAP -->
        </div>
        <!-- /MARKETPLACE CONTENT -->

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
<%if(delegadoDeEstaActividadID==idUsuario){%>
<div class="overlay" id="overlayCrear">
<div class="popup contenedorCrear" style="width: 700px;" id="popupCrear">
    <svg class="cerrarPopup" id="cerrarPopupCrear" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form  method="post" action="<%=request.getContextPath()%>/ListaDeEventosServlet?action=addConfirm" >
        <div class="container-fluid">
        <div class="row"><div class="col"><h5 style="text-align: center;">Crear evento</h5></div></div>
        <div class="row">
            <div class="col-sm-7">
                <br>
                <input hidden name="idUsuario" value=<%=idUsuario%>>
                <input hidden name="addActividadID" value=<%=idActividad%>>
                <label style="margin-top: 25px;"><b>Nombre del evento:</b></label>
                <input type="text" name="addTitulo" placeholder="Fibra Tóxica VS *" required>
                <label style="margin-top: 25px;" ><b>Frase motivacional:</b></label>
                <input type="text" name="addFraseMotivacional" placeholder="Frase motivacional" required>
                <label style="margin-top: 25px;"><b>Descripción del evento:</b></label>
                <input type="text" name="addDescripcionEventoActivo" placeholder="Descripción" required>
                <div class="row" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="delegado"><b>Hora (HH:MM):</b></label>
                        <input type="text" name="addHora" placeholder="00:00" required>
                    </div>
                    <div class="col-6">
                        <label for="delegado"><b>Lugar:</b></label>
                        <input type="text" list="lugarlist" name="addLugar" placeholder="Lugar" required>
                        <datalist id="lugarlist">
                            <%for(LugarEvento l:listaLugares){%>
                            <option value="<%=l.getLugar()%>"><%=l.getLugar()%></option>
                            <%}%>
                        </datalist>
                    </div>
                </div>
                <div class="row" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="delegado"><b>Fecha (día):</b></label>
                        <input type="text" name="addFecha" multiple id="delegado" placeholder="... de Octubre" required>
                    </div>
                    <div class="col-6">
                        <p style="width: 100%;"><b>Ocultar evento:</b></p>
                        <input type="checkbox" name="addEventoOculto" style="width: 30%; position: relative; top: 15px; left: 60px;">
                    </div>
                </div>
            </div>
            <div class="col-sm-5 contenedor2" style="top: 140px">
                <div class="container-fluid btn btn-file1">
                    <img class="img-fluid" src="css/subirArchivo.jpg" style="opacity: 50%;" alt="">
                    <p style="margin-top: 10px"><b>Agregar foto miniatura</b></p>
                    <input type="file" name="addfotoMiniatura" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
                </div>
            </div>
        </div>
    </div>
    <br>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6" style="margin-top: 5px;">
                <button type="submit" class="button secondary" id="cerrarPopupCrear1">Crear</button>
            </div>
            <div class="col-sm-6" style="margin-top: 5px;">
                <button class="button secondary" id="cerrarPopupCrear2" style="background-color: grey;">Cancelar</button>
            </div>
        </div>
    </div>
</form>
</div>
</div>
<div class="overlay" id="overlayFinalizar">
<div class="popup" style="width: 500px;" id="popupFinalizar">
    <svg class="cerrarPopup" id="cerrarPopupFinalizar" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form  method="post" action="<%=request.getContextPath()%>/ListaDeEventosServlet?action=finConfirm" >
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <label for="eventoFinalizar"><h5 style="text-align: center;">Seleccione el evento: </h5></label>
                <div style="margin-top: 20px;">
                    <input type="text" multiple id="eventoFinalizar" list="eventos" placeholder="Título" required>
                    <datalist id="eventos">
                        <%for(Evento e:listaEventos){
                        if(!e.isEventoFinalizado()){%>
                        <option value="<%=e.getTitulo()%>"><%=e.getTitulo()%></option>
                        <%}}%>
                    </datalist>
                </div>
                <label style="margin-top: 25px;"><b>Resumen:</b></label>
                <input type="text" placeholder="Resumen" required>
                <label style="margin-top: 25px;"><b>Resultado:</b></label>
                <select style="padding: 12.5px" id="resultado" required>
                    <option value="Victoria">Victoria</option>
                    <option value="Derrota">Derrota</option>
                </select>
            </div>
            <div class="col-sm-1"></div>
        </div>

    </div>
    <br>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6" style="margin-top: 5px;">
                <button class="button secondary" style="opacity: 50%;" id="cerrarPopupFinalizar1" disabled="true">Finalizar</button>
            </div>
            <div class="col-sm-6" style="margin-top: 5px;">
                <button class="button secondary" id="cerrarPopupFinalizar2" style="background-color: grey;">Cancelar</button>
            </div>
        </div>
    </div>
    </form>
</div>
</div>
<%if(!listaEventos.isEmpty()){
    for(Evento e:listaEventos){%>
<div class="overlay" id="overlayEditarEvento<%=listaEventos.indexOf(e)%>">
<div class="popup contenedorCrear" style="width: 700px;" id="popupEditarEvento<%=listaEventos.indexOf(e)%>">
    <svg class="cerrarPopup" id="cerrarPopupEditarEvento<%=listaEventos.indexOf(e)%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form  method="post" action="<%=request.getContextPath()%>/ListaDeEventosServlet?action=updateConfirm">
        <div class="container-fluid">
        <div class="row"><div class="col"><h5 style="text-align: center;">Editar evento</h5></div></div>
        <div class="row">
            <div class="col-sm-7">
                <br>
                <label style="margin-top: 25px;"><b>Nombre del evento:</b></label>
                <input type="text" placeholder="Fibra Tóxica VS *" value="<%=e.getTitulo()%>" required>
                <%if(e.isEventoFinalizado()){%>
                <label style="margin-top: 25px;" ><b>Resumen:</b></label>
                <input type="text" placeholder="Resumen" value="<%=e.getResumen()%>" required>
                <label style="margin-top: 25px;" ><b>Resultado:</b></label>
                <select style="padding: 12.5px" id="resultado" required>
                    <%if(e.getResultadoEvento().equals("Derrota")){%>
                    <option value="Derrota">Derrota</option>
                    <option value="Victoria">Victoria</option>
                    <%}else{%>
                    <option value="Victoria">Victoria</option>
                    <option value="Derrota">Derrota</option>
                    <%}%>
                </select>
                <p style="width: 100%; margin-top: 25px;"><b>Ocultar evento:</b></p>
                <input type="checkbox" style="width: 30%; position: relative; top: 15px; left: 120px;" <%if(e.isEventoOculto()){%>checked<%}%>>
                <%}else{%>
                <label style="margin-top: 25px;" ><b>Frase motivacional:</b></label>
                <input type="text" placeholder="Frase motivacional" value="<%=e.getFraseMotivacional()%>" required>
                <label style="margin-top: 25px;"><b>Descripción del evento:</b></label>
                <input type="text" placeholder="Descripción" value="<%=e.getDescripcionEventoActivo()%>" required>
                <div class="row" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="delegado"><b>Hora (HH:MM):</b></label>
                        <input type="text" placeholder="00:00" value="<%=Integer.parseInt(e.getHora().toString().split(":")[0])+":"+e.getHora().toString().split(":")[1]%>" required>
                    </div>
                    <div class="col-6">
                        <label for="delegado"><b>Lugar:</b></label>
                        <input type="text" list="lugar" placeholder="Lugar" value="<%=new DaoLugarEvento().lugarPorID(e.getLugarEvento())%>" required>
                        <datalist id="lugar">
                            <%for(LugarEvento l:listaLugares){%>
                            <option value="<%=l.getLugar()%>"><%=l.getLugar()%></option>
                            <%}%>
                        </datalist>
                    </div>
                </div>
                <div class="row" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="delegado"><b>Fecha (día):</b></label>
                        <input type="text" multiple id="delegado" placeholder="... de Octubre" value="<%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre" required>
                    </div>
                    <div class="col-6">
                        <p style="width: 100%;"><b>Ocultar evento:</b></p>
                        <input type="checkbox" style="width: 30%; position: relative; top: 15px; left: 60px;" <%if(e.isEventoOculto()){%>checked<%}%>>
                    </div>
                </div>
                <%}%>
            </div>
            <div class="col-sm-5 contenedor2" style="top: 140px">
                <div class="container-fluid btn btn-file1">
                    <img class="img-fluid" src="css/fibraVShormigon.png" alt="">
                    <p style="margin-top: 10px"><b>Editar foto miniatura</b></p>
                    <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
                </div>
            </div>
        </div>
    </div>
    <br>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6" style="margin-top: 5px;">
                <button type="submit" class="button secondary" id="cerrarPopupEditar1Evento<%=listaEventos.indexOf(e)%>">Editar</button>
            </div>
            <div class="col-sm-6" style="margin-top: 5px;">
                <button type="button" class="button secondary" id="cerrarPopupEditar2Evento<%=listaEventos.indexOf(e)%>" style="background-color: grey;">Cancelar</button>
            </div>
        </div>
    </div>
    </form>
</div>
</div>
<%}}}%>

<script>
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
    <%if(delegadoDeEstaActividadID==idUsuario){%>
    popupFunc('popupCrear','mostrarPopupCrear',['cerrarPopupCrear','cerrarPopupCrear1','cerrarPopupCrear2'],'overlayCrear');
    popupFunc('popupFinalizar','mostrarPopupFinalizar',['cerrarPopupFinalizar','cerrarPopupFinalizar1','cerrarPopupFinalizar2'],'overlayFinalizar');
    <%if(listaEventos!=null){
    for(int i=0;i<listaEventos.size();i++){%>
    popupFunc('popupEditarEvento<%=i%>','mostrarPopupEditarEvento<%=i%>',['cerrarPopupEditarEvento<%=i%>','cerrarPopupEditar1Evento<%=i%>','cerrarPopupEditar2Evento<%=i%>'],'overlayEditarEvento<%=i%>');
    <%}}%>
    // Obtener elementos del DOM
    const textElement = document.getElementById('eventoFinalizar');
    const buttonElement = document.getElementById('cerrarPopupFinalizar1');
    const opciones=document.getElementById('eventos').getElementsByTagName('option');
    // Agregar un evento de escucha al campo de texto y la lista de opciones
    textElement.addEventListener('input', validarCampo);

    function validarCampo() {
        const textoIngresado = textElement.value.trim();
        // Verificar si la opción seleccionada está en el texto ingresado

        for(let i=0; i<opciones.length; i++){
            if (textoIngresado==opciones[i].value) {
                buttonElement.removeAttribute('disabled'); // Activar el botón
                buttonElement.style.opacity="100%";
                break;
            } else {
                buttonElement.setAttribute('disabled', 'true'); // Desactivar el botón
                buttonElement.style.opacity="50%";
            }
        }
    }
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
<!-- global.hexagons -->
<script src="js/global/global.hexagons.js"></script>
<!-- global.tooltips -->
<script src="js/global/global.tooltips.js"></script>
<!-- header -->
<script src="js/header/header.js"></script>
<!-- sidebar -->
<script src="js/sidebar/sidebar.js"></script>
<!-- form.utils -->
<script src="js/form/form.utils.js"></script>
<!-- SVG icons -->
        <script src="js/utils/svg-loader.js"></script></form>
</body>
</html>