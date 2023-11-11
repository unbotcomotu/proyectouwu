<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>
<%@ page import="com.example.proyectouwu.Beans.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%int idUsuario=(int) request.getAttribute("idUsuario");
    String rolUsuario=(String) request.getAttribute("rolUsuario");
    String nombreCompletoUsuario=(String) request.getAttribute("nombreCompletoUsuario");
    ArrayList<Actividad>listaActividades=(ArrayList<Actividad>) request.getAttribute("listaActividades");
    Integer idActividadDelegatura=(Integer)request.getAttribute("idActividadDelegatura");
    String vistaActual=(String) request.getAttribute("vistaActual");
    ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
    ArrayList<Usuario>listaIDyNombresDelegadosDeActividad=(ArrayList<Usuario>)request.getAttribute("IDyNombreDelegadosDeActividad");
    Integer idActividadElegida=(Integer) request.getAttribute("idActividadElegida");
    String puntajeNoNumerico=(String) request.getAttribute("puntajeNoNumerico");
    String colorRol;
    String servletActual="ListaDeActividadesServlet";
    ArrayList<NotificacionDelegadoGeneral>listaNotificacionesCampanita=(ArrayList<NotificacionDelegadoGeneral>) request.getAttribute("listaNotificacionesCampanita");
    if(rolUsuario.equals("Alumno")){
        colorRol="";
    }else if(rolUsuario.equals("Delegado de Actividad")){
        colorRol="green";
    }else{
        colorRol="orange";
    }
    %>
    <meta charset="utf-8">
    <meta name="viewport" content= +"width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- bootstrap 4.3.1 -->
    <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
    <!-- styles -->
    <link rel="stylesheet" href="css/raw/styles.css">
    <!-- simplebar styles -->
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <!-- favicon -->
    <link rel="icon" href="img/favicon.ico">
    <title>Actividades - Siempre Fibra</title>
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
            <a href="<%=request.getContextPath()%>/inicioSesion.jsp"><img src="css/logOut.png" width="30%" alt=""></a>
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
                <a href="<%=request.getContextPath()%>/inicioSesion.jsp"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
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
                        <form id="notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>" method="post" action="<%=request.getContextPath()%>/<%=servletActual%>?action=notificacionLeidaCampanita">
                            <input type="hidden" name="idNotificacion" value="<%=noti.getIdNotificacion()%>">
                            <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
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
                                                <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
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
                                    <p class="user-status-title"><a class="bold"><%=r.getUsuarioReportado().getNombre()%> <%=r.getUsuarioReportado().getApellido()%></a> ha sido <a class="highlighted">reportado</a> por el delegado de actividad <a class="bold"><%=r.getUsuarioQueReporta().getNombre()%> <%=r.getUsuarioQueReporta().getApellido()%></a></p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
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
                                                <!-- HEXAGON AQUÍ FALTA LA FOTOOOO -->
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
                                    <p class="user-status-title"><a class="bold"><%=d.getUsuario().getNombre()%> <%=d.getUsuario().getApellido()%></a> realizó una <a class="highlighted">donación</a> de <a style="color: orange;">S/. <%=d.getMonto()%></a>.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        System.out.println(diferenciaFechas[0]);
                                        System.out.println(diferenciaFechas[1]);
                                        System.out.println(diferenciaFechas[2]);
                                        System.out.println(diferenciaFechas[3]);
                                        System.out.println(diferenciaFechas[4]);
                                        System.out.println(diferenciaFechas[5]);
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
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
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
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
                                                <!-- HEXAGON AQUÍ ESTA FOTO SE CAMBIAAA -->
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
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
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
                                                <!-- HEXAGON AQUÍ ESTA FOTO SE CAMBIAAA -->
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
                                    <p class="user-status-title"><a class="bold"><%=v2.getUsuario().getNombre()%> <%=v2.getUsuario().getApellido()%></a> está solicitando la recuperación de su <a class="highlighted">contraseña</a> con el código de validación <a style="color: #8d7aff"><%=v2.getCodigoValidacion()%></a>.</p>
                                    <!-- /USER STATUS TITLE -->
                                    <%Integer diferenciaFechas[]=new DaoNotificacionDelegadoGeneral().obtenerDiferenciaEntre2FechasNotificaciones(noti.getIdNotificacion());
                                        if(diferenciaFechas[0]>0){
                                            if(diferenciaFechas[0]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 año <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[0]%> años <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[1]>0){
                                        if(diferenciaFechas[1]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 mes <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[1]%> meses <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[2]>0){
                                        if(diferenciaFechas[2]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 día <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[2]%> días <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[3]>0){
                                        if(diferenciaFechas[3]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 hora <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[3]%> horas <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[4]>0){
                                        if(diferenciaFechas[4]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 minuto <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[4]%> minutos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]>0){
                                        if(diferenciaFechas[5]==1){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace 1 segundo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}else{%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Hace <%=diferenciaFechas[5]%> segundos <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
                                    <!-- /USER STATUS TIMESTAMP -->
                                    <%}%>
                                    <%}else if(diferenciaFechas[5]==0){%>
                                    <!-- USER STATUS TIMESTAMP -->
                                    <p class="user-status-timestamp">Ahora mismo <a style="color: #20c997;cursor: pointer" onclick="enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>()">Leído</a></p>
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
                                function enviarFormulario<%=listaNotificacionesCampanita.indexOf(noti)%>() {
                                    var formulario = document.getElementById('notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>');
                                    formulario.submit();
                                }
                            </script>
                        </form>
                        <%}%>
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
                <a href="<%=request.getContextPath()%>/inicioSesion.jsp"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
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
        <img class="section-banner-icon" src="https://naucalpan.gob.mx/wp-content/uploads/2020/07/PORTADA.png" width="15%" alt="marketplace-icon">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title">Actividades</p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text">Encuentra todas las actividades a realizar en Semana de Ingeniería</p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <div class="section-header">
        <div class="container-fluid" style="width: 100%;">
            <!-- SECTION HEADER INFO -->
            <div class="row" style="width: 100%;">
                <div class="section-header-info col-sm-auto recuadroTexto">
                    <!-- SECTION PRETITLE -->
                    <p class="section-pretitle">Busca la actividad que desees</p>
                    <!-- /SECTION PRETITLE -->

                    <!-- SECTION TITLE -->
                    <h2 class="section-title">Lista de actividades</h2>
                    <!-- /SECTION TITLE -->
                </div>
                <%if(rolUsuario.equals("Delegado General")){%>
                <div class="section-filters-bar-actions col-sm-auto d-flex justify-content-end recuadro recuadroFila" style="width: 150px;">
                    <!-- BUTTON -->
                    <button class="button secondary popup-event-creation-trigger botones" id="mostrarPopupCrear" style="width: 100%;">Crear actividad</button>
                    <!-- /BUTTON -->
                </div>
                <%}%>
            </div>
        </div>
    </div>


    <!-- SECTION FILTERS BAR -->
    <div class="section-filters-bar v4">
        <!-- SECTION FILTERS BAR ACTIONS -->
        <div class="section-filters-bar-actions">
            <!-- FORM -->
            <form method="get" action="<%=request.getContextPath()%>/ListaDeActividadesServlet" class="form">
                <input type="hidden" name="action" value="buscarActividad">
                <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                <!-- FORM ITEM -->
                <div class="form-item split">
                    <!-- FORM INPUT -->
                    <%String actividad=(String) request.getAttribute("actividad");%>
                    <div class="form-input small">
                        <label for="items-search"><%if(actividad==null){%>Buscar actividad<%}%></label>
                        <input type="text" id="items-search" name="actividad" <%if(actividad!=null){%> value="<%=actividad%>"<%}%>>
                    </div>
                    <!-- /FORM INPUT -->

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
                <!-- /FORM ITEM -->
            </form>
            <!-- /FORM -->
        </div>
        <!-- /SECTION FILTERS BAR ACTIONS -->

        <!-- SECTION FILTERS BAR ACTIONS -->
        <div class="section-filters-bar-actions">
            <!-- FORM -->
            <form method="get" action="<%=request.getContextPath()%>/ListaDeActividadesServlet" class="form">
                <input type="hidden" name="action" value="filtroActividad">
                <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                <!-- FORM ITEM -->
                <div class="form-item split medium">
                    <%Integer idFiltroActividades=(Integer) request.getAttribute("idFiltroActividades");%>
                    <!-- FORM SELECT -->
                    <div class="form-select small">
                        <label for="items-filter-category">Ordenar por</label>
                        <select id="items-filter-category" name="idFiltroActividades">
                            <option value="0" <%if(idFiltroActividades!=null && idFiltroActividades==0){%>selected<%}%>>Orden alfabético</option>
                            <option value="1" <%if(idFiltroActividades!=null && idFiltroActividades==1){%>selected<%}%>>Cantidad de eventos</option>
                            <option value="2" <%if(idFiltroActividades!=null && idFiltroActividades==2){%>selected<%}%>>Cantidad de puntos por primer lugar</option>
                            <option value="3" <%if(idFiltroActividades!=null && idFiltroActividades==3){%>selected<%}%>>Finalizados primero</option>
                            <%if(rolUsuario.equals("Delegado General")){%>
                            <option value="4" <%if(idFiltroActividades!=null && idFiltroActividades==4){%>selected<%}%>>Ocultos primero</option>
                            <%}%>
                            <%if(rolUsuario.equals("Delegado de Actividad")){%>
                            <option value="5" <%if(idFiltroActividades!=null && idFiltroActividades==5){%>selected<%}%>>Mi delegatura primero</option>
                            <%}%>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->
                    <%Integer idOrdenarActividades=(Integer)request.getAttribute("idOrdenarActividades");%>
                    <!-- FORM SELECT -->
                    <div class="form-select small">
                        <label for="items-filter-order">Sentido</label>
                        <select id="items-filter-order" name="idOrdenarActividades">
                            <option value="0" <%if(idOrdenarActividades!=null){if(idOrdenarActividades==0){%>selected<%}}%>>De mayor a menor</option>
                            <option value="1" <%if(idOrdenarActividades!=null){if(idOrdenarActividades==1){%>selected<%}}%>>De menor a mayor</option>
                        </select>
                        <!-- FORM SELECT ICON -->
                        <svg class="form-select-icon icon-small-arrow">
                            <use xlink:href="#svg-small-arrow"></use>
                        </svg>
                        <!-- /FORM SELECT ICON -->
                    </div>
                    <!-- /FORM SELECT -->

                    <!-- BUTTON -->
                    <button type="submit" class="button secondary">Aplicar ajustes</button>
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
    <div class="grid grid-3-3-3-3 centered">
        <%if(listaActividades!=null){%>
        <%int aux=0;String color1="";String color2="";
            for(Actividad a:listaActividades){
                if(aux==0){
                    color1="#615dfa";
                    color2="#8d7aff";
                }else if(aux==1){
                    color1="#417ae1";
                    color2="#5aafff";
                }else if(aux==2){
                    color1="#2ebfef";
                    color2="#4ce4ff";
                }else if(aux==3){
                    color1="#17cada";
                    color2="#2becfe";
                }else if(aux==4){
                    color1="#64b9ff";
                    color2="#8bd7ff";
                }else if(aux==5){
                    color1="#598dff";
                    color2="#81a9ff";
                }else if(aux==6){
                    color1="#597aff";
                    color2="#8981ff";
                    aux=0;
                }%>
        <!-- PRODUCT CATEGORY BOX -->
        <a class="product-category-box category-all" href="<%=request.getContextPath()%>/ListaDeEventosServlet?idUsuario=<%=idUsuario%>&idActividad=<%=a.getIdActividad()%>" style="background: url('css/fotoVoleyActividades.png') no-repeat right top, linear-gradient(to right, <%=color1%>, <%=color2%>) <%if(a.isActividadFinalizada()){%><%=";opacity: 50%;"%><%}%> ">
            <!-- PRODUCT CATEGORY BOX TITLE -->
            <p class="product-category-box-title"><%=a.getNombre()%></p>
            <!-- /PRODUCT CATEGORY BOX TITLE -->
            <%if(a.isActividadFinalizada()){%>
            <!-- PRODUCT CATEGORY BOX TEXT -->
            <p class="product-category-box-text">FINALIZADO</p>
            <!-- /PRODUCT CATEGORY BOX TEXT -->
            <%}else{%>
            <!-- PRODUCT CATEGORY BOX TEXT -->
            <p class="product-category-box-text"><%=a.getCantPuntosPrimerLugar()%> puntos (1er lugar)</p>
            <!-- /PRODUCT CATEGORY BOX TEXT -->
            <%}%>
            <!-- PRODUCT CATEGORY BOX TAG -->
            <%String cantEventos=new DaoActividad().cantidadEventosPorActividad(a.getIdActividad());%>
            <%if(cantEventos!=null){
                if(cantEventos.equals("1")){%>
            <p class="product-category-box-tag" style="color: <%=color1%>;">1 evento</p>
            <!-- /PRODUCT CATEGORY BOX TAG -->
            <%}else{%>
            <p class="product-category-box-tag" style="color: <%=color1%>;"><%=cantEventos%> eventos</p>
            <%}}if(rolUsuario.equals("Delegado General")){%>
            <p class="product-category-box-tag"><button id="mostrarPopupEditarActividad<%=listaActividades.indexOf(a)%>" style="color: <%=color1%>;font-size: 100%;z-index: 1000">EDITAR</button></p>
            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    var botonDentroDelEnlace = document.getElementById("mostrarPopupEditarActividad<%=listaActividades.indexOf(a)%>");
                    botonDentroDelEnlace.addEventListener("click", function(e) {
                        e.preventDefault();
                    });
                });
            </script>
            <%}if(idActividadDelegatura != null){
                if(idActividadDelegatura==a.getIdActividad()){
            if(a.isActividadFinalizada()){%>
            <p class="product-category-box-tag" style="color: <%=color1%>">FINALIZADO</p>
            <%}else{%>
            <!-- PRODUCT CATEGORY BOX TAG -->
            <p class="product-category-box-tag"><button id="mostrarPopupFinalizar" style="color: <%=color1%>;font-size: 100%;z-index: 1000">FINALIZAR</button></p>
            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    var botonDentroDelEnlace = document.getElementById("mostrarPopupFinalizar");
                    botonDentroDelEnlace.addEventListener("click", function(e) {
                        e.preventDefault();
                    });
                });
            </script>
            <!-- /PRODUCT CATEGORY BOX TAG -->
            <%}}}%>
        </a>
        <!-- /PRODUCT CATEGORY BOX -->
        <%aux++;}}%>
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
<%if(rolUsuario.equals("Delegado de Actividad")){%>
<div class="overlay" id="overlayFinalizar"></div>
<div class="popup" style="width: 600px;" id="popupFinalizar">
    <svg class="cerrarPopup" id="cerrarPopupFinalizar" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <h5 style="text-align: center;">¿Está seguro de finalizar la actividad <span style="color: red"><%=new DaoActividad().nombreActividadPorID(new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(idUsuario))%></span> ?</h5>
            </div>
            <div class="col-sm-1"></div>
        </div>
    </div>
    <br>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6" style="margin-top: 5px;">
                <form method="post" action="<%=request.getContextPath()%>/ListaDeActividadesServlet?action=finalizarActividad">
                    <input type="hidden" name="idActividadFinalizar" value="<%=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(idUsuario)%>">
                    <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                    <button type="submit" class="button secondary" id="cerrarPopupFinalizar1">Finalizar</button>
                </form>
            </div>
            <div class="col-sm-6" style="margin-top: 5px;">
                <button class="button secondary" id="cerrarPopupFinalizar2" style="background-color: grey;">Cancelar</button>
            </div>
        </div>
    </div>
</div>
<%}else if(rolUsuario.equals("Delegado General")){%>
<div class="overlay" <%if(puntajeNoNumerico!=null && idActividadElegida==null){%>style="display: block"<%}%> id="overlayCrear"></div>
<div class="popup contenedorCrear" style="width: 700px; <%if(puntajeNoNumerico!=null && idActividadElegida==null){%> display: block <%}%>" id="popupCrear">
    <svg class="cerrarPopup" id="cerrarPopupCrear" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form method="post" action="<%=request.getContextPath()%>/ListaDeActividadesServlet?action=crearActividad">
        <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
        <div class="container-fluid">
            <div class="row"><div class="col"><h5 style="text-align: center;">Crear actividad</h5></div></div>
            <div class="row">
                <div class="col-sm-7">
                    <br>
                    <label for="nombreCrearActividad" style="margin-top: 25px;"><b>Nombre de la actividad:</b></label>
                    <input type="text" name="nombreCrearActividad" id="nombreCrearActividad" placeholder="Actividad" required>

                    <label for="idDelegadoActividadCrear" style="margin-top: 25px;"><b>Seleccionar delegado de actividad:</b></label>
                    <select style="height: 55px;padding-left: 20px" name="idDelegadoActividadCrear" id="idDelegadoActividadCrear" required>
                        <%for(Usuario u:listaIDyNombresDelegadosDeActividad){%>
                        <option value="<%=u.getIdUsuario()%>"><%=u.getNombre()%> <%=u.getApellido()%></option>
                        <%}%>
                    </select>

                    <label style="margin-top: 25px;" for="puntajeCrearActividad"><b>Puntaje para el 1er lugar:</b></label>
                    <input type="text" name="puntajeCrearActividad" id="puntajeCrearActividad" placeholder="###" required>
                    <%if(puntajeNoNumerico!=null && idActividadElegida==null){%>
                    <a style="color: red">Debe de ingresar un valor numérico</a>
                    <%}%>

                    <div style="display: flex; justify-content: left; margin-top: 25px;">
                        <p style="width: 32%;"><b>Ocultar actividad</b></p>
                        <input type="checkbox" name="ocultoCrearActividad" value="oculto" style="width: 10%;">
                    </div>
                </div>
                <div class="col-sm-5 contenedor2" style="top: 30px">
                    <div class="container-fluid btn btn-file1">
                        <img class="img-fluid" src="css/subirArchivo.jpg" width="80%" style="opacity: 50%;" alt="">
                        <p><b>Agregar foto de cabecera</b></p>
                        <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
                    </div>
                    <br>
                    <div class="container-fluid btn btn-file1">
                        <img class="img-fluid" src="css/subirArchivo.jpg" width="80%" style="opacity: 50%;" alt="">
                        <p><b>Agregar foto de miniatura</b></p>
                        <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="submit" style="opacity: 0.5" class="button secondary" id="cerrarPopupCrear1" disabled>Crear</button>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button class="button secondary" id="cerrarPopupCrear2" style="background-color: grey;">Cancelar</button>
                </div>
            </div>
        </div>
    </form>
</div>

<%if(listaActividades!=null){
    for(int i=0;i<listaActividades.size();i++){%>
<div class="overlay" <%if(puntajeNoNumerico!=null && idActividadElegida!=null && idActividadElegida==listaActividades.get(i).getIdActividad()){%>style="display: block"<%}%>  id="overlayEditarActividad<%=i%>"></div>
<div class="popup contenedorCrear"  style="width: 700px; <%if(puntajeNoNumerico!=null && idActividadElegida!=null && idActividadElegida==listaActividades.get(i).getIdActividad()){%> display: block<%}%>" id="popupEditarActividad<%=i%>">
    <svg class="cerrarPopup" id="cerrarPopupEditarActividad<%=i%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form method="post" action="<%=request.getContextPath()%>/ListaDeActividadesServlet?action=editarActividad">
        <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
        <input type="hidden" name="idActividadEditar" value="<%=listaActividades.get(i).getIdActividad()%>">
        <input type="hidden" name="idDelegadoActividadAnterior" value="<%=listaActividades.get(i).getDelegadoDeActividad().getIdUsuario()%>">
        <div class="container-fluid">
            <div class="row"><div class="col"><h5 style="text-align: center;">Editar actividad</h5></div></div>
            <div class="row">
                <div class="col-sm-7">
                    <br>
                    <label style="margin-top: 25px;"><b>Nombre de la actividad:</b></label>
                    <input type="text" name="nombreEditarActividad" id="nombreEditarActividad<%=i%>" value="<%=listaActividades.get(i).getNombre()%>" placeholder="Actividad" required>

                    <label for="idDelegadoActividadEditar<%=i%>" style="margin-top: 25px;"><b>Seleccionar delegado de actividad:</b></label>
                    <select style="height: 55px;padding-left: 20px" name="idDelegadoActividadEditar" id="idDelegadoActividadEditar<%=i%>" required>
                        <option value="<%=listaActividades.get(i).getDelegadoDeActividad().getIdUsuario()%>" selected><%=new DaoUsuario().nombreCompletoUsuarioPorId(listaActividades.get(i).getDelegadoDeActividad().getIdUsuario())%></option>
                        <%for(Usuario u:listaIDyNombresDelegadosDeActividad){%>
                        <option value="<%=u.getIdUsuario()%>"><%=u.getNombre()%> <%=u.getApellido()%></option>
                        <%}%>
                    </select>

                    <label style="margin-top: 25px;"><b>Puntaje para el 1er lugar:</b></label>
                    <input type="text" name="puntajeEditarActividad" id="puntajeEditarActividad<%=i%>" value="<%=listaActividades.get(i).getCantPuntosPrimerLugar()%>" placeholder="###" required>
                    <%if(puntajeNoNumerico!=null && idActividadElegida!=null && idActividadElegida==listaActividades.get(i).getIdActividad()){%>
                    <a style="color: red">Debe de ingresar un valor numérico</a>
                    <%}%>
                    <div style="display: flex; justify-content: left; margin-top: 25px;">
                        <p style="width: 32%;"><b>Ocultar actividad</b></p>
                        <input type="checkbox" name="ocultoEditarActividad" id="ocultoEditarActividad<%=i%>" <%if(listaActividades.get(i).isActividadOculta()){%>checked<%}%> style="width: 10%;">
                    </div>
                </div>
                <div class="col-sm-5 contenedor2" style="top: 30px">
                    <div class="container-fluid btn btn-file1">
                        <img class="img-fluid" src="css/telitoVoley.png" width="80%" alt="">
                        <p><b>Editar foto de cabecera</b></p>
                        <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
                    </div>
                    <br>
                    <div class="container-fluid btn btn-file1">
                        <img class="img-fluid" src="css/fotoVoleyActividades.png" width="80%" alt="">
                        <p><b>Editar foto de miniatura</b></p>
                        <input type="file" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg"></input>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="submit" class="button secondary" id="cerrarPopupEditar1Actividad<%=i%>">Editar</button>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button class="button secondary" id="cerrarPopupEditar2Actividad<%=i%>" style="background-color: grey;">Cancelar</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%}}}%>
<script>
    //document.getElementById('cerrarPopupFinalizar1').addEventListener('click',document.getElementById(String(textElement.value)).style.opacity = '50%');
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

    function verificarInput(elementos,idBoton) {
        for(let i=0;i<elementos.length;i++) {
            document.getElementById(elementos[i]).addEventListener("input", function () {
                var boton=document.getElementById(idBoton);
                boton.disabled=false;
                boton.style.opacity=1;
                for(let i=0;i<elementos.length;i++){
                    var elemento=document.getElementById(elementos[i]);
                    if(elemento.value===""){
                        boton.disabled=true;
                        boton.style.opacity=0.5;
                    }
                }
            });
        }
    }
    <%if(rolUsuario.equals("Delegado de Actividad")){%>
    popupFunc('popupFinalizar','mostrarPopupFinalizar',['cerrarPopupFinalizar','cerrarPopupFinalizar1','cerrarPopupFinalizar2'],'overlayFinalizar');
    <%}else if(rolUsuario.equals("Delegado General")){%>
    var elementos=['nombreCrearActividad','idDelegadoActividadCrear','puntajeCrearActividad'];
    verificarInput(elementos,'cerrarPopupCrear1');
    popupFunc('popupCrear','mostrarPopupCrear',['cerrarPopupCrear','cerrarPopupCrear1','cerrarPopupCrear2'],'overlayCrear');
    <%if(listaActividades!=null){
    for(int i=0;i<listaActividades.size();i++){%>
    var elementos<%=i%>=['nombreEditarActividad<%=i%>','idDelegadoActividadEditar<%=i%>','puntajeEditarActividad<%=i%>'];
    verificarInput(elementos<%=i%>,'cerrarPopupEditar1Actividad<%=i%>');
    popupFunc('popupEditarActividad<%=i%>','mostrarPopupEditarActividad<%=i%>',['cerrarPopupEditarActividad<%=i%>','cerrarPopupEditar1Actividad<%=i%>','cerrarPopupEditar2Actividad<%=i%>'],'overlayEditarActividad<%=i%>');
    <%}}}%>
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
<script src="js/utils/svg-loader.js"></script>
</body>
</html>