<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.Actividad" %>
<%@ page import="com.example.proyectouwu.Beans.Evento" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%int idUsuario=(int) request.getAttribute("idUsuario");
        String rolUsuario=(String) request.getAttribute("rolUsuario");
        String nombreCompletoUsuario=(String) request.getAttribute("nombreCompletoUsuario");
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        Evento e=(Evento)request.getAttribute("evento");
        String actividadEvento=(String)request.getAttribute("actividad");
        String estadoApoyo=(String)request.getAttribute("estadoApoyoAlumnoEvento");
        String lugar=(String)request.getAttribute("lugar");
        ArrayList<Integer>cantidadApoyos=(ArrayList<Integer>) request.getAttribute("cantidadApoyos");
        Integer solicitudesApoyoPendientes=(Integer) request.getAttribute("solicitudesApoyoPendientes");
        int delegadoDeEstaActividadID=(Integer) request.getAttribute("delegadoDeEstaActividadID");
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
    <title>Actividades - Siempre Fibra</title>
    <style>
        .carousel {
            position: relative;
            overflow: hidden;
            width: 100%;
            margin: 0 auto;
        }

        .carousel-inner {
            display: flex;
            transition: all 0.5s ease;
            width: 100%;
        }

        .carousel-item {
            flex: 0 0 100%;
        }

        .carousel img {
            width: 100%;
            height: auto;
        }

        .carousel-control-prev,
        .carousel-control-next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1;
        }

        .carousel-control-prev {
            left: 10px;
        }

        .carousel-control-next {
            right: 10px;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            width: 30px;
            height: 30px;
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .carousel-control-prev-icon::before,
        .carousel-control-next-icon::before {
            content: "‹"; /* Puedes ajustar los caracteres de flecha según tu preferencia */
            font-size: 24px;
        }

        .carousel-control-next-icon::before {
            content: "›";
        }

        @media screen and (max-width: 1000px) {
            .auxResponsive{
                display: none;;
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
        .bloque-izquierda,
        .bloque-derecha {
            position: absolute;
            width: 48%;
            height: 100%;
            background-color: rgb(255, 255, 255);
            color: rgb(0, 0, 0);
            opacity: 0;
            text-align: center;
            line-height: 100px;
        }


        .bloque-derecha {
            right: 0;
            left: initial;
        }

        .bloque-izquierda:hover {
            opacity: 0.5;
        }

        .bloque-derecha:hover {
            opacity: 0.5;
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
        <p class="user-short-description-text"><a style="color: <%=colorRol%>;"><%=rolUsuario%></a></p>
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
            <p class="navigation-widget-info-text" style="color: <%=colorRol%>;"><%=rolUsuario%></p>
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

    <div class="section-banner">
        <!-- SECTION BANNER ICON -->
        <img class="section-banner-icon" src="https://naucalpan.gob.mx/wp-content/uploads/2020/07/PORTADA.png" width="15%" alt="marketplace-icon">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title"><%=e.getTitulo()%></p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text "><%=actividadEvento%></p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- GRID -->
    <div class="grid grid-3-9">
        <!-- GRID COLUMN -->
        <div class="grid-column">
            <div class="streamer-box" style="background-image: linear-gradient(rgb(140, 255, 194),rgb(148, 249, 250));">
                <%if(!rolUsuario.equals("Delegado General")){%>
                <%if(delegadoDeEstaActividadID==idUsuario){%>
                <div class="streamer-box-info">
                    <!-- STREAMER BOX TITLE -->
                    <p class="streamer-box-title" style="font-size: 150%;">SOLICITUDES DE APOYO</p>
                    <!-- /STREAMER BOX TITLE -->

                    <!-- STREAMER BOX STATUS -->
                    <p class="mt-4">Eres el delegado de actividad en la que se encuentra este evento. No olvides de atender las solicitudes de los usuarios que deseen apoyar. Estas se encuentran en la ventana de notificaciones.</p>
                    <!-- /STREAMER BOX STATUS -->

                    <!-- USER STATS -->
                    <div class="user-stats">
                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <img src="css/solicitudesPendientes.png" width="50%">
                            <!-- /USER STAT TITLE -->
                            <p class="user-stat-text" style="font-size: 100%;"><%=solicitudesApoyoPendientes%></p>
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 100%;">Solicitudes pendientes de revisión</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                    </div>
                    <!-- /USER STATS -->

                </div>
                <%}else if(estadoApoyo==null){%>
                <!-- STREAMER BOX INFO -->
                <div class="streamer-box-info">
                    <!-- STREAMER BOX TITLE -->
                    <p class="streamer-box-title" style="font-size: 150%;">APOYA AL EVENTO</p>
                    <!-- /STREAMER BOX TITLE -->

                    <!-- STREAMER BOX STATUS -->
                    <p class="mt-4">¡Anímate a apoyar a la fibra y pasarás todos los cursos de Yarleque! Podrás ser elegido como:</p>
                    <!-- /STREAMER BOX STATUS -->

                    <!-- USER STATS -->
                    <div class="user-stats">
                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <img src="css/barra.png" width="50%">
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 100%;">Barra</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <!-- /USER STAT TITLE -->
                            <img src="css/jugar.png" width="50%" alt="">
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 100%;">Equipo</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                    </div>
                    <!-- /USER STATS -->

                    <!-- BUTTON -->
                    <a class="button small twitch" style="color: white;" id="mostrarPopupApoyar" >Apoyar al evento</a>
                    <!-- /BUTTON -->
                </div>
                <%}else{%>
                <div class="streamer-box-info">
                    <!-- STREAMER BOX TITLE -->
                    <p class="streamer-box-title" style="font-size: 150%;">GRACIAS POR APOYAR</p>
                    <!-- /STREAMER BOX TITLE -->

                    <!-- STREAMER BOX STATUS -->
                    <p class="mt-4" style="font-size: 150%">Actualmente estás apoyando como:</p>
                    <!-- /STREAMER BOX STATUS -->

                    <!-- USER STATS -->
                    <div class="user-stats">
                        <!-- USER STAT -->
                        <%if(estadoApoyo.equals("Barra")){%>
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <img src="css/barra.png" width="100%">
                            <!-- /USER STAT TITLE -->

                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 200%;">Barra</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                        <%}else{%>
                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <!-- /USER STAT TITLE -->
                            <img src="css/jugar.png" width="100%" alt="">
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 200%;">Equipo</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                        <%}%>
                    </div>
                    <!-- /USER STATS -->
                </div>
                <%}}else{%>
                <div class="streamer-box-info">
                    <!-- STREAMER BOX TITLE -->
                    <p class="streamer-box-title" style="font-size: 150%;">ESTADÍSTICAS DE APOYO</p>
                    <!-- /STREAMER BOX TITLE -->

                    <!-- STREAMER BOX STATUS -->
                    <p class="mt-4">Dentro de la cantidad total de apoyos se encuentran:</p>
                    <!-- /STREAMER BOX STATUS -->

                    <!-- USER STATS -->
                    <div class="user-stats">
                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <img src="css/barra.png" width="50%">
                            <!-- /USER STAT TITLE -->
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="color: blue ;font-size: 100%;"><%=cantidadApoyos.get(1)%></p>
                            <!-- /USER STAT TEXT -->
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 100%;">Barra</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->

                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <!-- /USER STAT TITLE -->
                            <img src="css/jugar.png" width="50%" alt="">
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="color:blueviolet ;font-size: 100%;"><%=cantidadApoyos.get(0)%></p>
                            <!-- /USER STAT TEXT -->
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 100%;">Equipo</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                    </div>
                    <!-- /USER STATS -->
                </div>
                <%}%>
                <!-- /STREAMER BOX INFO -->
                <img src="css/apoyar2.png" width="100%">
            </div>
            <!-- /STREAMER BOX -->

            <!-- WIDGET BOX -->
            <div class="widget-box">


                <!-- WIDGET BOX TITLE -->
                <p class="widget-box-title">Consideraciones acerca de apoyar:</p>
                <!-- /WIDGET BOX TITLE -->

                <!-- WIDGET BOX CONTENT -->
                <div class="widget-box-content">
                    <!-- SIMPLE ACCORDION LIST -->
                    <div class="simple-accordion-list">
                        <!-- SIMPLE ACCORDION -->
                        <div class="simple-accordion">
                            <!-- SIMPLE ACCORDION HEADER -->
                            <div class="simple-accordion-header accordion-trigger">
                                <!-- SIMPLE ACCORDION TITLE -->
                                <p class="simple-accordion-title">¿Qué sucede si no asisto al evento?</p>
                                <!-- /SIMPLE ACCORDION TITLE -->

                                <!-- SIMPLE ACCORDION ICON -->
                                <div class="simple-accordion-icon">
                                    <!-- ICON PLUS SMALL -->
                                    <svg class="icon-plus-small">
                                        <use xlink:href="#svg-plus-small"></use>
                                    </svg>
                                    <!-- /ICON PLUS SMALL -->

                                    <!-- ICON MINUS SMALL -->
                                    <svg class="icon-minus-small">
                                        <use xlink:href="#svg-minus-small"></use>
                                    </svg>
                                    <!-- /ICON MINUS SMALL -->
                                </div>
                                <!-- /SIMPLE ACCORDION ICON -->

                                <!-- SIMPLE ACCORDION CONTENT -->
                                <div class="simple-accordion-content accordion-content accordion-open">
                                    <!-- SIMPLE ACCORDION TEXT -->
                                    <p class="simple-accordion-text">Si has sido elegido para la barra o el equipo y no asistes el día del evento, el Delegado General será notificado y es posible que seas baneado de la plataforma.</p>
                                    <!-- /SIMPLE ACCORDION TEXT -->
                                </div>
                                <!-- /SIMPLE ACCORDION CONTENT -->
                            </div>
                            <!-- /SIMPLE ACCORDION HEADER -->
                        </div>
                        <!-- /SIMPLE ACCORDION -->

                        <!-- SIMPLE ACCORDION -->
                        <div class="simple-accordion">
                            <!-- SIMPLE ACCORDION HEADER -->
                            <div class="simple-accordion-header accordion-trigger">
                                <!-- SIMPLE ACCORDION TITLE -->
                                <p class="simple-accordion-title">¿Puedo elegir si apoyar en la barra o el equipo?</p>
                                <!-- /SIMPLE ACCORDION TITLE -->

                                <!-- SIMPLE ACCORDION ICON -->
                                <div class="simple-accordion-icon">
                                    <!-- ICON PLUS SMALL -->
                                    <svg class="icon-plus-small">
                                        <use xlink:href="#svg-plus-small"></use>
                                    </svg>
                                    <!-- /ICON PLUS SMALL -->

                                    <!-- ICON MINUS SMALL -->
                                    <svg class="icon-minus-small">
                                        <use xlink:href="#svg-minus-small"></use>
                                    </svg>
                                    <!-- /ICON MINUS SMALL -->
                                </div>
                                <!-- /SIMPLE ACCORDION ICON -->

                                <!-- SIMPLE ACCORDION CONTENT -->
                                <div class="simple-accordion-content accordion-content">
                                    <!-- SIMPLE ACCORDION TEXT -->
                                    <p class="simple-accordion-text">No. Será finalmente la decisión del Delegado de Actividad si participas en el equipo o como barra.</p>
                                    <!-- /SIMPLE ACCORDION TEXT -->
                                </div>
                                <!-- /SIMPLE ACCORDION CONTENT -->
                            </div>
                            <!-- /SIMPLE ACCORDION HEADER -->
                        </div>
                        <!-- /SIMPLE ACCORDION -->

                        <!-- SIMPLE ACCORDION -->
                        <div class="simple-accordion">
                            <!-- SIMPLE ACCORDION HEADER -->
                            <div class="simple-accordion-header accordion-trigger">
                                <!-- SIMPLE ACCORDION TITLE -->
                                <p class="simple-accordion-title">¿Es posible cancelar mi solicitud de apoyo?</p>
                                <!-- /SIMPLE ACCORDION TITLE -->

                                <!-- SIMPLE ACCORDION ICON -->
                                <div class="simple-accordion-icon">
                                    <!-- ICON PLUS SMALL -->
                                    <svg class="icon-plus-small">
                                        <use xlink:href="#svg-plus-small"></use>
                                    </svg>
                                    <!-- /ICON PLUS SMALL -->

                                    <!-- ICON MINUS SMALL -->
                                    <svg class="icon-minus-small">
                                        <use xlink:href="#svg-minus-small"></use>
                                    </svg>
                                    <!-- /ICON MINUS SMALL -->
                                </div>
                                <!-- /SIMPLE ACCORDION ICON -->

                                <!-- SIMPLE ACCORDION CONTENT -->
                                <div class="simple-accordion-content accordion-content">
                                    <!-- SIMPLE ACCORDION TEXT -->
                                    <p class="simple-accordion-text">En caso hayas presionado el botón de apoyar por error, puedes contactarte con el Delegado de Actividad directamente mediante el foro de la página.</p>
                                    <!-- /SIMPLE ACCORDION TEXT -->
                                </div>
                                <!-- /SIMPLE ACCORDION CONTENT -->
                            </div>
                            <!-- /SIMPLE ACCORDION HEADER -->
                        </div>
                        <!-- /SIMPLE ACCORDION -->

                        <!-- SIMPLE ACCORDION -->
                        <div class="simple-accordion">
                            <!-- SIMPLE ACCORDION HEADER -->
                            <div class="simple-accordion-header accordion-trigger">
                                <!-- SIMPLE ACCORDION TITLE -->
                                <p class="simple-accordion-title">¿Es cierto que los JPs de la malla dan puntaje extra por apoyar en Semana de Ingeniería?</p>
                                <!-- /SIMPLE ACCORDION TITLE -->

                                <!-- SIMPLE ACCORDION ICON -->
                                <div class="simple-accordion-icon">
                                    <!-- ICON PLUS SMALL -->
                                    <svg class="icon-plus-small">
                                        <use xlink:href="#svg-plus-small"></use>
                                    </svg>
                                    <!-- /ICON PLUS SMALL -->

                                    <!-- ICON MINUS SMALL -->
                                    <svg class="icon-minus-small">
                                        <use xlink:href="#svg-minus-small"></use>
                                    </svg>
                                    <!-- /ICON MINUS SMALL -->
                                </div>
                                <!-- /SIMPLE ACCORDION ICON -->

                                <!-- SIMPLE ACCORDION CONTENT -->
                                <div class="simple-accordion-content accordion-content">
                                    <!-- SIMPLE ACCORDION TEXT -->
                                    <p class="simple-accordion-text">Ello depende de qué tan bien apoyes a la fibra. Recuerda que varios JPs así como tú fueron alumnos, por lo que la pasión se comparte y es posible que se otorgue como incentivo.</p>
                                    <!-- /SIMPLE ACCORDION TEXT -->
                                </div>
                                <!-- /SIMPLE ACCORDION CONTENT -->
                            </div>
                            <!-- /SIMPLE ACCORDION HEADER -->
                        </div>
                        <!-- /SIMPLE ACCORDION -->
                    </div>
                    <!-- SIMPLE ACCORDION LIST -->
                </div>
                <!-- /WIDGET BOX CONTENT -->
            </div>
            <!-- /WIDGET BOX -->
        </div>
        <!-- /GRID COLUMN -->
        <div class="grid-column">
            <!-- STREAM BOX -->
            <div class="stream-box big">
                <!-- STREAM BOX VIDEO -->
                <div class="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="css/fibraVSelectroMedio.png" alt="Imagen 1">
                        </div>
                        <div class="carousel-item">
                            <img src="https://files.pucp.education/puntoedu/wp-content/uploads/2021/01/23021428/dsc_0981-web-920x613-1.jpg" alt="Imagen 2">
                        </div>
                        <div class="carousel-item">
                            <img src="https://fundeu.fiile.org.ar/uploadsfotos/voley.jpg" alt="Imagen 3">
                        </div>
                    </div>
                    <a class="carousel-control-prev" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Anterior</span>
                    </a>
                    <a class="carousel-control-next" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Siguiente</span>
                    </a>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const carouselItems = document.querySelectorAll(".carousel-item");
                        const prevButton = document.querySelector(".carousel-control-prev");
                        const nextButton = document.querySelector(".carousel-control-next");
                        let currentIndex = 0;

                        function showSlide(index) {
                            carouselItems[currentIndex].classList.remove("active");
                            currentIndex = (index + carouselItems.length) % carouselItems.length;
                            carouselItems[currentIndex].classList.add("active");
                        }

                        prevButton.addEventListener("click", function () {
                            showSlide(currentIndex - 1);
                        });

                        nextButton.addEventListener("click", function () {
                            showSlide(currentIndex + 1);
                        });

                        // Inicia el carousel con el primer elemento activo
                        showSlide(currentIndex);
                    });
                </script>
                <!-- /STREAM BOX VIDEO -->

                <!-- STREAM BOX INFO -->
                <div class="stream-box-info">

                    <!-- STREAM BOX TITLE -->
                    <p class="stream-box-title" >"<%=e.getFraseMotivacional()%>"</p>
                    <!-- /STREAM BOX TITLE -->
                    <!-- STREAM BOX CATEGORY -->
                    <p class="stream-box-category mt-3"><%=e.getDescripcionEventoActivo()%></p>
                    <!-- /STREAM BOX CATEGORY -->

                    <!-- STREAM BOX VIEWS -->
                    <p class="stream-box-views">¡No falten!</p>
                    <!-- /STREAM BOX VIEWS -->
                </div>
                <!-- /STREAM BOX INFO -->
            </div>
            <!-- /STREAM BOX -->

            <!-- WIDGET BOX -->
            <div class="widget-box">
                <!-- WIDGET BOX CONTENT -->
                <div class="widget-box-content">
                    <!-- WIDGET BOX TEXT -->
                    <div class="row align-items-around">
                        <div class="col-4 text-center" style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 700 !important;">
                            <img src="css/reloj.png" width="20%" alt="">
                            <a class="auxResponsive">Hora: </a>
                            <%String aux[]=e.getHora().toString().split(":");%>
                            <a><%=Integer.parseInt(aux[0])+":"+aux[1]%></a>
                        </div>
                        <div class="col-4 text-center" style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 700 !important;">
                            <img src="css/calendario.png" width="20%" alt="">
                            <a class="auxResponsive">Fecha: </a>
                            <%String aux2[]=e.getFecha().toString().split("-");%>
                            <a><%=aux2[2]+"/"+aux2[1]+"/"+aux2[0]%></a>
                        </div>
                        <div class="col-4 text-center" style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 700 !important;">
                            <img src="css/ubicacion.png" width="20%" alt="">
                            <a class="auxResponsive">Ubicación: </a>
                            <%String lugarAux;
                                if(lugar.length()>14) {
                                    String aux3[] = lugar.split(" ");
                                    lugarAux = "" + aux3[0].charAt(0);
                                    for (int i = 1; i < aux3.length; i++) {
                                        lugarAux += " " + aux3[i];
                                    }
                                }else
                                    lugarAux=lugar;%>
                            <a><%=lugarAux%></a>
                        </div>
                    </div>
                </div>
            </div>
            <%if(delegadoDeEstaActividadID==idUsuario){%>
            <div style="position: relative; text-align: end; bottom:375px; right: 10px;">
                <img src="css/ajustesEvento.png" id="mostrarPopupImagenes" style="cursor: pointer;" width="10%" alt="">
            </div>
            <%}%>
            <!-- /WIDGET BOX CONTENT -->
        </div>
        <!-- /WIDGET BOX -->
    </div>
    <!-- /GRID COLUMN -->
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
                <li><a>Política de Privacidad</a></li>
                <li><a>Términos y Condiciones</a></li>
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
<%if(!rolUsuario.equals("Delegado General")){%>
<div class="overlay" id="overlayApoyar">
    <div class="popup" id="popupApoyar">
        <svg class="cerrarPopup" id="cerrarPopupApoyar" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
        </svg>
        <p style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 500 !important; text-align: center;">Se ha enviado al Delegado de Actividad una solicitud para apoyar.</p>
    </div>
</div>
<%}if(delegadoDeEstaActividadID==idUsuario){%>
<div class="overlay" id="overlayEditarImagenes"></div>
<div class="popup" style="max-width: 100%;width: 80%!important" id="popupImagenes">
    <svg class="cerrarPopup" id="cerrarPopupImagenes" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div class="row">
        <div class="col-sm-4">
            <div class="bloque-izquierda btn-file1 d-flex align-items-center justify-content-center" style="position: absolute;">
                <a style="font-size: 200%; cursor: pointer;">Cambiar</a>
                <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
            </div>
            <a class="bloque-derecha d-flex align-items-center justify-content-center" id="borrarImagen1" style="font-size: 200%; cursor: pointer;">Borrar</a>
            <img src="https://cdn.www.gob.pe/uploads/document/file/965350/standard_310867105bd77816115eb8beca878465_L20200708-22286-1yuo6tw.jpg" id="imagen1" width="100%" height="auto">

        </div>
        <div class="col-sm-4">
            <div class="bloque-izquierda btn-file1 d-flex align-items-center justify-content-center" style="position: absolute;">
                <a style="font-size: 200%; cursor: pointer;">Cambiar</a>
                <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
            </div>
            <a class="bloque-derecha d-flex align-items-center justify-content-center" style="font-size: 200%; cursor: pointer;">Borrar</a>
            <img src="https://cdn.www.gob.pe/uploads/document/file/965350/standard_310867105bd77816115eb8beca878465_L20200708-22286-1yuo6tw.jpg" width="100%" height="auto">

        </div>
        <div class="col-sm-4">
            <div class="bloque-izquierda btn-file1 d-flex align-items-center justify-content-center" style="position: absolute;">
                <a style="font-size: 200%; cursor: pointer;">Cambiar</a>
                <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
            </div>
            <a class="bloque-derecha d-flex align-items-center justify-content-center" style="font-size: 200%; cursor: pointer;">Borrar</a>
            <img src="https://cdn.www.gob.pe/uploads/document/file/965350/standard_310867105bd77816115eb8beca878465_L20200708-22286-1yuo6tw.jpg" width="100%" height="auto">

        </div>
    </div>
    <div class="row d-flex justify-content-center" style="margin-top: 10px;">
        <div class="col-sm-6" style="margin-top: 5px;">
            <button type="submit" class="button secondary" id="cerrarPopupImagenes1">Confirmar cambios</button>
        </div>
        <div class="col-sm-6" style="margin-top: 5px;">
            <button class="button secondary" id="cerrarPopupImagenes2" style="background-color: grey;">Cancelar</button>
        </div>
    </div>
</div>
<%}%>
<script>
    function blockButton(id){
        document.getElementById(id).style.pointerEvents = "none";
        document.getElementById(id).style.opacity = "0.5";
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
    <%if(!rolUsuario.equals("Delegado General"))%>
    popupFunc('popupApoyar','mostrarPopupApoyar',['cerrarPopupApoyar'],'overlayApoyar');
    <%if(delegadoDeEstaActividadID==idUsuario){%>
    popupFunc('popupImagenes','mostrarPopupImagenes',['cerrarPopupImagenes','cerrarPopupImagenes1','cerrarPopupImagenes2'],'overlayEditarImagenes');
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
<!-- global.accordions -->
<script src="js/global/global.accordions.js"></script>
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