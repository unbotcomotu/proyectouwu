<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.Actividad" %>
<%@ page import="com.example.proyectouwu.Daos.DaoEvento" %>
<%@ page import="com.example.proyectouwu.Beans.Evento" %>
<%@ page import="com.example.proyectouwu.Daos.DaoLugarEvento" %>
<%@ page import="com.example.proyectouwu.Daos.DaoAlumnoPorEvento" %>
<%@ page import="com.example.proyectouwu.Daos.DaoUsuario" %>
<%@ page import="com.example.proyectouwu.Beans.Usuario" %>
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
    int diaActual=(int) request.getAttribute("diaActual");
    ArrayList<Evento>listaEventos=(ArrayList<Evento>)request.getAttribute("listaEventos");
    String colorPorActividad[]={"#23d2e2","#615dfa","blue","pink","#0c5460","#0b2e13","#00e194","#1df377","#4e4ac8","#4f8dff","#2e2e47","#1e7e34","#2ebfef","#8fd19e","#122d5c","#b1dfbb","#491217"};
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <!-- favicon -->
    <link rel="icon" href="img/favicon.ico">
    <title>Actividades - Siempre Fibra</title>
    <style>
        /* Estilo para el overlay del popup */
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
            z-index: 10001;
            width: 90%;
            max-width: 584px;
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

        .popupAux-event-cover {
            width: 100%;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }

        .popupAux-event-info {
            padding: 32px 28px;
            position: relative;
        }

        .popupAux-event-info .user-avatar-list {
            margin-top: 18px;
        }

        .popupAux-event-title {
            font-size: 1.5rem;
            font-weight: 700;
        }

        .popupAux-event-subtitle {
            margin-top: 32px;
            font-size: 1rem;
            font-weight: 700;
        }

        .popupAux-event-text {
            margin-top: 16px;
            font-size: 0.875rem;
            line-height: 1.7142857143em;
            font-weight: 500;
            color: #3e3f5e;
        }

        .decorated-feature-list {
            margin-top: 14px;
        }

        .popupAux-event-button {
            width: 200px;
            position: absolute;
            top: -30px;
            right: 28px;
        }

        /*---------------------------------
            48. popupAux CLOSE BUTTON
        ---------------------------------*/
        .popupAux-close-button {
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

        .popupAux-close-button:hover {
            background-color: #23d2e2;
        }

        .popupAux-close-button .popupAux-close-button-icon {
            pointer-events: none;

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
            .eventosAux{
                padding-bottom: 18px !important;
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
        <a href="IndexServlet"><p class="navigation-widget-info-button button small secondary">Cerrar sesión</p></a>
        <!-- /NAVIGATION WIDGET BUTTON -->
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
            <form id="cerrarSesion3" method="post" action="InicioSesionServlet?action=logOut">
                <a onclick="enviarFormulario('cerrarSesion3')"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
            </form>
            <script></script>
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
                <form id="cerrarSesion2" method="post" action="InicioSesionServlet?action=logOut">
                    <a onclick="enviarFormulario('cerrarSesion2')"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
                </form>
                <script></script>
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

<!-- CONTENT GRID -->

<div class="content-grid">
    <!-- SECTION BANNER -->
    <div class="section-banner">
        <!-- SECTION BANNER ICON -->
        <img class="section-banner-icon" src="img/banner/events-icon.png" alt="events-icon">
        <!-- /SECTION BANNER ICON -->

        <!-- SECTION BANNER TITLE -->
        <p class="section-banner-title">Mis eventos</p>
        <!-- /SECTION BANNER TITLE -->

        <!-- SECTION BANNER TEXT -->
        <p class="section-banner-text">Organiza tus semanas y revisa qué eventos se acercan</p>
        <!-- /SECTION BANNER TEXT -->
    </div>
    <!-- /SECTION BANNER -->

    <!-- SECTION HEADER -->
    <div class="section-header">
        <!-- SECTION HEADER INFO -->
        <div class="section-header-info">
            <!-- SECTION PRETITLE -->
            <p class="section-pretitle">Echa un vistazo rápido</p>
            <!-- /SECTION PRETITLE -->

            <!-- SECTION TITLE -->
            <h2 class="section-title">Calendario de eventos</h2>
            <!-- /SECTION TITLE -->
        </div>
        <!-- /SECTION HEADER INFO -->
    </div>
    <!-- /SECTION HEADER -->


    <!-- CALENDAR WIDGET -->
    <div class="calendar-widget">
        <!-- CALENDAR WIDGET HEADER -->
        <div class="calendar-widget-header">
            <!-- CALENDAR WIDGET HEADER ACTIONS -->
            <div class="calendar-widget-header-actions d-flex justify-content-around" style="width: 100%;">
                <!-- CALENDAR WIDGET TITLE -->
                <div class="col-auto">
                    <p class="calendar-widget-title">Octubre 2023</p>
                </div>
                <div class="col-auto" >

                    <p class="calendar-widget-title" style="font-size: 75%;">Actividades:
                        <%ArrayList<Integer>IDsActividadesContadas=new ArrayList<Integer>();
                            aux:for(Evento e:listaEventos){
                                for(Integer i:IDsActividadesContadas){
                                    if(e.getActividad().getIdActividad()==i){
                                        continue aux;
                                    }
                                }%><a style="color: <%=colorPorActividad[e.getActividad().getIdActividad()]%>"><%=new DaoEvento().actividadDeEventoPorID(e.getIdEvento())%></a>
                                    <%IDsActividadesContadas.add(e.getActividad().getIdActividad());%>
                            <%}%>
                    </p>
                </div>
                <!-- /CALENDAR WIDGET TITLE -->
            </div>
            <!-- /CALENDAR WIDGET HEADER ACTIONS -->
        </div>
        <!-- /CALENDAR WIDGET HEADER -->

        <!-- CALENDAR -->
        <div class="calendar full eventosAux">
            <!-- CALENDAR WEEK -->
            <div class="calendar-week">
                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Dom</span><span class="week-day-long">Domingo</span></p>
                <!-- /CALENDAR WEEK DAY -->

                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Lun</span><span class="week-day-long">Lunes</span></p>
                <!-- /CALENDAR WEEK DAY -->

                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Mar</span><span class="week-day-long">Martes</span></p>
                <!-- /CALENDAR WEEK DAY -->

                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Mie</span><span class="week-day-long">Miércoles</span></p>
                <!-- /CALENDAR WEEK DAY -->

                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Jue</span><span class="week-day-long">Jueves</span></p>
                <!-- /CALENDAR WEEK DAY -->

                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Vie</span><span class="week-day-long">Viernes</span></p>
                <!-- /CALENDAR WEEK DAY -->

                <!-- CALENDAR WEEK DAY -->
                <p class="calendar-week-day"><span class="week-day-short">Sab</span><span class="week-day-long">Sábado</span></p>
                <!-- /CALENDAR WEEK DAY -->
            </div>
            <!-- /CALENDAR WEEK -->

            <!-- CALENDAR DAYS -->
            <div class="calendar-days">
                <%for(int j=0;j<5;j++){%>
                <!-- CALENDAR DAY ROW -->
                <div class="calendar-day-row">
                    <%for(int i=1;i<=7;i++){
                        int dia=7*j+i;
                    %>
                    <div class="calendar-day
                    <%if(dia>31){
                        dia-=31;
                        %> inactive<%}%>">
                        <%if(diaActual==dia){%>
                        <p class="calendar-day-number" style="color: red"><%=dia%> (Hoy)</p>
                        <%}else{%>
                        <p class="calendar-day-number"><%=dia%></p>
                        <%}%>
                        <!-- /CALENDAR DAY NUMBER -->
                        <%boolean aux=true;
                            String titulo;
                            for(Evento e:listaEventos){
                                if(Integer.parseInt(e.getFecha().toString().split("-")[2])==dia){
                                    if(aux){%>
                        <div class="calendar-day-events">
                            <%aux=false;
                            }String tituloAux[]=e.getTitulo().split(" ");
                                titulo="";
                                for(int k=3;k<tituloAux.length;k++){
                                    titulo+=tituloAux[k]+" ";
                                }
                            %>
                            <p class="calendar-day-event popup-event-information-trigger" style="background-color: <%=colorPorActividad[e.getActividad().getIdActividad()]%> <%if(e.isEventoFinalizado()){%>;opacity: 0.5<%}%>" id="mostrarPopupEvento<%=listaEventos.indexOf(e)%>"><span class="calendar-day-event-text">⚔️<%=titulo%></span></p>
                        <!-- /CALENDAR DAY -->
                        <%}}if(!aux){%>
                        </div>
                            <%aux=true;
                            }%>
                    </div>
                    <%}%>
                </div>
                <%}%>
            </div>
        </div>
            <!-- /CALENDAR DAYS -->
    </div>
        <!-- /CALENDAR -->
</div>
    <!-- /CALENDAR WIDGET -->



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
<%for(Evento e:listaEventos){%>
<div class="overlay" id="overlayEvento<%=listaEventos.indexOf(e)%>"></div>
<div class="popup" id="popupEvento<%=listaEventos.indexOf(e)%>">
    <svg class="cerrarPopup" id="cerrarPopupEvento<%=listaEventos.indexOf(e)%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div>
        <!-- POPUP EVENT COVER -->
        <figure class="popupAux-event-cover liquid">
            <img src="css/fibraVShormigonLargo.png" alt="cover-33">
        </figure>
        <!-- /POPUP EVENT COVER -->

        <!-- POPUP EVENT INFO -->
        <div class="popupAux-event-info">
            <!-- POPUP EVENT TITLE -->
            <p class="popupAux-event-title" style="font-size: 180%"><%=e.getTitulo()%>
                <%if(e.isEventoFinalizado()){
                if(e.getResultadoEvento().equals("Victoria")){%>
                <span style="color: green"> (Victoria)</span>
                <%}else{%>
                <span style="color: red"> (Derrota)</span>
                <%}}%>
            </p>
            <!-- /POPUP EVENT TITLE -->

            <!-- DECORATED FEATURE LIST -->
            <div class="decorated-feature-list">
                <!-- DECORATED FEATURE -->
                <div class="decorated-feature">
                    <!-- DECORATED FEATURE ICON -->
                    <svg class="decorated-feature-icon icon-events">
                        <use xlink:href="#svg-events"></use>
                    </svg>
                    <!-- /DECORATED FEATURE ICON -->

                    <!-- DECORATED FEATURE INFO -->
                    <div class="decorated-feature-info">
                        <%if(e.isEventoFinalizado()){%>
                        <p class="decorated-feature-title" style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre</p>
                        <%}else{%>
                        <%int diasQueFaltanParaElEvento=new DaoEvento().diferenciaDiasEventoActualidad(e.getIdEvento());
                        if(diasQueFaltanParaElEvento==0){%>
                        <p class="decorated-feature-title" style="color: red;">Hoy</p>
                        <%}else if(diasQueFaltanParaElEvento==1){%>
                        <p class="decorated-feature-title" style="color: orangered;">Mañana</p>
                        <%}else if(diasQueFaltanParaElEvento==2){%>
                        <p class="decorated-feature-title" style="color: orange;">En 2 días</p>
                        <%}else{%>
                        <p class="decorated-feature-title" style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de Octubre</p>
                        <%}}%>
                        <!-- DECORATED FEATURE TEXT -->
                        <%String aux[]=e.getHora().toString().split(":");%>
                        <p class="decorated-feature-text"><%=Integer.parseInt(aux[0])+":"+aux[1]%></p>
                        <!-- /DECORATED FEATURE TEXT -->
                    </div>
                    <!-- /DECORATED FEATURE INFO -->
                </div>
                <!-- /DECORATED FEATURE -->

                <!-- DECORATED FEATURE -->
                <div class="decorated-feature">
                    <!-- DECORATED FEATURE ICON -->
                    <svg class="decorated-feature-icon icon-pin">
                        <use xlink:href="#svg-pin"></use>
                    </svg>
                    <!-- /DECORATED FEATURE ICON -->

                    <!-- DECORATED FEATURE INFO -->
                    <div class="decorated-feature-info">
                        <!-- DECORATED FEATURE TITLE -->
                        <p class="decorated-feature-title"><%=new DaoLugarEvento().lugarPorID(e.getLugarEvento().getIdLugarEvento())%></p>
                        <!-- /DECORATED FEATURE TITLE -->

                        <!-- DECORATED FEATURE TEXT -->
                        <p class="decorated-feature-text">Ubicación</p>
                        <!-- /DECORATED FEATURE TEXT -->
                    </div>
                    <!-- /DECORATED FEATURE INFO -->
                </div>
                <!-- /DECORATED FEATURE -->

                <!-- DECORATED FEATURE -->
                <div class="decorated-feature">
                    <!-- DECORATED FEATURE ICON -->
                    <img src="css/apoyoIconoCeleste.png" height="20px" alt="">
                    <!-- /DECORATED FEATURE ICON -->
                    <!-- DECORATED FEATURE INFO -->
                    <div class="decorated-feature-info">
                        <!-- DECORATED FEATURE TITLE -->
                        <p class="decorated-feature-title"><%=new DaoAlumnoPorEvento().verificarApoyo(e.getIdEvento(),idUsuario)%></p>
                        <!-- /DECORATED FEATURE TITLE -->

                        <!-- DECORATED FEATURE TEXT -->
                        <p class="decorated-feature-text">Apoyo</p>
                        <!-- /DECORATED FEATURE TEXT -->
                    </div>
                    <!-- /DECORATED FEATURE INFO -->
                </div>
                <!-- /DECORATED FEATURE -->

                <!-- DECORATED FEATURE -->
                <div class="decorated-feature">
                    <!-- DECORATED FEATURE ICON -->
                    <img src="css/actividadIcono.png" height="20px" alt="">
                    <!-- /DECORATED FEATURE ICON -->

                    <!-- DECORATED FEATURE INFO -->
                    <div class="decorated-feature-info">
                        <!-- DECORATED FEATURE TITLE -->
                        <p class="decorated-feature-title"><%=new DaoEvento().actividadDeEventoPorID(e.getIdEvento())%></p>
                        <!-- /DECORATED FEATURE TITLE -->

                        <!-- DECORATED FEATURE TEXT -->
                        <p class="decorated-feature-text">Actividad</p>
                        <!-- /DECORATED FEATURE TEXT -->
                    </div>
                    <!-- /DECORATED FEATURE INFO -->
                </div>
                <!-- /DECORATED FEATURE -->


            </div>
            <!-- /DECORATED FEATURE LIST -->
            <%if(e.isEventoFinalizado()){%>
            <!-- POPUP EVENT SUBTITLE -->
            <p class="popupAux-event-subtitle">Resumen</p>
            <!-- /POPUP EVENT SUBTITLE -->

            <!-- POPUP EVENT TEXT -->
            <p class="popupAux-event-text"><%=e.getResumen()%></p>
            <!-- /POPUP EVENT TEXT -->
            <%}else{%>
            <!-- POPUP EVENT SUBTITLE -->
            <p class="popupAux-event-subtitle">Descripción</p>
            <!-- /POPUP EVENT SUBTITLE -->

            <!-- POPUP EVENT TEXT -->
            <p class="popupAux-event-text">"<%=e.getFraseMotivacional()%>" <%=e.getDescripcionEventoActivo()%></p>
            <!-- /POPUP EVENT TEXT -->
            <%}%>

            <!-- POPUP EVENT BUTTON -->
            <a href="<%=request.getContextPath()%>/EventoServlet?idUsuario=<%=idUsuario%>&idEvento=<%=e.getIdEvento()%>"><p class="popupAux-event-button button cerrar-btn">Ingresar a la página del evento</p></a>
            <!-- /POPUP EVENT BUTTON -->
        </div>
        <!-- /POPUP EVENT INFO -->

        <p class="popupAux-event-subtitle" style="margin-left: 27px;">Último mensaje en el foro</p>

        <!-- POST COMMENT -->
        <div class="post-comment">

            <!-- USER AVATAR -->
            <a class="user-avatar small no-outline">
                <!-- USER AVATAR CONTENT -->
                <div class="user-avatar-content">
                    <!-- HEXAGON -->
                    <div class="hexagon-image-30-32" data-src="css/prudencio.png"></div>
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
                    <p class="user-avatar-badge-text">19</p>
                    <!-- /USER AVATAR BADGE TEXT -->
                </div>
                <!-- /USER AVATAR BADGE -->
            </a>
            <!-- /USER AVATAR -->

            <!-- POST COMMENT TEXT -->
            <p class="post-comment-text"><a class="post-comment-text-author">Rodrigo Prudencio</a>TelecozZz</p>
            <!-- /POST COMMENT TEXT -->
        </div>
        <!-- /POST COMMENT LIST -->
    </div>
    <br>

</div>
<%}%>
<script>
    function popupFunc(popupId,abrirId,cerrarId,overlayId){
        const showPopup=document.getElementById(abrirId);
        const overlay=document.getElementById(overlayId);
        const popup=document.getElementById(popupId);
        const closePopup=document.getElementById(cerrarId);
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
            // Reactivar el scroll
            document.body.style.overflow = 'auto';
        };
        closePopup.addEventListener('click', cerrarPopup);
        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) {
                cerrarPopup();
            }
        });

        // Cerrar el popup al presionar Escape
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                cerrarPopup();
            }
        });
    }
    <%for(int i=0;i<listaEventos.size();i++){%>
    popupFunc('popupEvento<%=i%>','mostrarPopupEvento<%=i%>','cerrarPopupEvento<%=i%>','overlayEvento<%=i%>');
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
<script src="js/utils/svg-loader.js"></script>
</body>
</html>