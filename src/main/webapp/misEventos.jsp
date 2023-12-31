<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.Evento" %>
<%@ page import="com.example.proyectouwu.Beans.Usuario" %>
<%@ page import="com.example.proyectouwu.Beans.AlumnoPorEvento" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>
<%@ page import="com.example.proyectouwu.Beans.MensajeChat" %>
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
    String diaActual=(String) request.getAttribute("diaActual");
    String mesActual=(String) request.getAttribute("mesActual");
    ArrayList<Evento>listaEventos=(ArrayList<Evento>)request.getAttribute("listaEventos");
    String servletActual="NotificacionesServlet";
    String colorPorActividad[]={"#23d2e2","#615dfa","blue","pink","#0c5460","#0b2e13","#00e194","#1df377","#4e4ac8","#4f8dff","#2e2e47","#1e7e34","#2ebfef","#8fd19e","#122d5c","#b1dfbb","#491217"};
    ArrayList<AlumnoPorEvento>listaNotificacionesDelegadoDeActividad=(ArrayList<AlumnoPorEvento>) request.getAttribute("listaNotificacionesDelegadoDeActividad");
    String colorRol;
    String mes="";
    String fechaAux="";
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
    <link rel="icon" href="css/murcielago.ico">
    <title>Mis eventos - Siempre Fibra</title>
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
                    <select id="calendarioMes" style="padding: 10px" class="calendar-widget-title">
                        <option value="1" <%if(mesActual.equals("1")){%>selected<%}%>>Enero de 2023</option>
                        <option value="2" <%if(mesActual.equals("2")){%>selected<%}%>>Febrero de 2023</option>
                        <option value="3" <%if(mesActual.equals("3")){%>selected<%}%>>Marzo de 2023</option>
                        <option value="4" <%if(mesActual.equals("4")){%>selected<%}%>>Abril de 2023</option>
                        <option value="5" <%if(mesActual.equals("5")){%>selected<%}%>>Mayo de 2023</option>
                        <option value="6" <%if(mesActual.equals("6")){%>selected<%}%>>Junio de 2023</option>
                        <option value="7" <%if(mesActual.equals("7")){%>selected<%}%>>Julio de 2023</option>
                        <option value="8" <%if(mesActual.equals("8")){%>selected<%}%>>Agosto de 2023</option>
                        <option value="9" <%if(mesActual.equals("9")){%>selected<%}%>>Septiembre de 2023</option>
                        <option value="10" <%if(mesActual.equals("10")){%>selected<%}%>>Octubre de 2023</option>
                        <option value="11" <%if(mesActual.equals("11")){%>selected<%}%>>Noviembre de 2023</option>
                        <option value="12" <%if(mesActual.equals("12")){%>selected<%}%>>Diciembre de 2023</option>
                    </select>
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
            <%for(Integer mesAux=0;mesAux<12;mesAux++){
                int primeraFechaCalendario=0;
                int cantidadDiasAnteriorMesRestantes=0;
                int cantidadDiasMesActual=0;
                int maxFilas=0;
            if(mesAux+1==1){
                primeraFechaCalendario=1;
                cantidadDiasAnteriorMesRestantes=0;
                cantidadDiasMesActual=31;
                maxFilas=5;
            }else if(mesAux+1==2){
                primeraFechaCalendario=29;
                cantidadDiasAnteriorMesRestantes=3;
                cantidadDiasMesActual=28;
                maxFilas=5;
            }else if(mesAux+1==3){
                primeraFechaCalendario=26;
                cantidadDiasAnteriorMesRestantes=3;
                cantidadDiasMesActual=31;
                maxFilas=5;
            }else if(mesAux+1==4){
                primeraFechaCalendario=26;
                cantidadDiasAnteriorMesRestantes=6;
                cantidadDiasMesActual=30;
                maxFilas=6;
            }else if(mesAux+1==5){
                primeraFechaCalendario=30;
                cantidadDiasAnteriorMesRestantes=1;
                cantidadDiasMesActual=31;
                maxFilas=5;
            }else if(mesAux+1==6){
                primeraFechaCalendario=28;
                cantidadDiasAnteriorMesRestantes=4;
                cantidadDiasMesActual=30;
                maxFilas=5;
            }else if(mesAux+1==7){
                primeraFechaCalendario=25;
                cantidadDiasAnteriorMesRestantes=6;
                cantidadDiasMesActual=31;
                maxFilas=6;
            }else if(mesAux+1==8){
                primeraFechaCalendario=30;
                cantidadDiasAnteriorMesRestantes=2;
                cantidadDiasMesActual=31;
                maxFilas=5;
            }else if(mesAux+1==9){
                primeraFechaCalendario=27;
                cantidadDiasAnteriorMesRestantes=5;
                cantidadDiasMesActual=30;
                maxFilas=5;
            }else if(mesAux+1==10){
                primeraFechaCalendario=1;
                cantidadDiasAnteriorMesRestantes=0;
                cantidadDiasMesActual=31;
                maxFilas=5;
            }else if(mesAux+1==11){
                primeraFechaCalendario=29;
                cantidadDiasAnteriorMesRestantes=3;
                cantidadDiasMesActual=30;
                maxFilas=5;
            }else{
                primeraFechaCalendario=26;
                cantidadDiasAnteriorMesRestantes=5;
                cantidadDiasMesActual=31;
                maxFilas=6;
            }
            %>
            <!-- CALENDAR DAYS -->
            <div id="mes<%=mesAux+1%>" style="display: none" class="calendar-days">
                <%for(int j=0;j<maxFilas;j++){%>
                <!-- CALENDAR DAY ROW -->
                <div class="calendar-day-row">
                    <%for(int i=1;i<=7;i++){
                        Integer dia=7*j+i-cantidadDiasAnteriorMesRestantes;
                    %>
                    <div class="calendar-day<%if(dia>cantidadDiasMesActual||dia<=0){%> inactive<%}%>">
                    <%if(dia<=0){%>
                        <%if(Integer.parseInt(diaActual)==dia&&Integer.parseInt(mesActual)==mesAux){%>
                        <p class="calendar-day-number" style="color: red"><%=dia%> (Hoy)</p>
                        <%}else{%>
                        <p class="calendar-day-number"><%=dia+primeraFechaCalendario+cantidadDiasAnteriorMesRestantes-1%></p>
                        <%}%>
                        <%boolean aux=true;
                            for(Evento e:listaEventos){
                                String fechaEventoAux[]=e.getFecha().toString().split("-");
                                if(Integer.parseInt(fechaEventoAux[2])==dia&&Integer.parseInt(fechaEventoAux[1])==mesAux){
                                    if(aux){%>
                        <div class="calendar-day-events">
                            <%aux=false;
                            }%>
                            <p class="calendar-day-event popup-event-information-trigger" style="background-color: <%=colorPorActividad[e.getActividad().getIdActividad()]%> <%if(e.isEventoFinalizado()){%>;opacity: 0.5<%}%>" id="mostrarPopupEvento<%=listaEventos.indexOf(e)%>"><span class="calendar-day-event-text">⚔️<%=e.getTitulo()%></span></p>
                            <%}}if(!aux){%>
                        </div>
                        <%}%>
                    <%}else if(dia>cantidadDiasMesActual){%>
                        <%if(Integer.parseInt(diaActual)==dia&&Integer.parseInt(mesActual)==(mesAux+2)){%>
                        <p class="calendar-day-number" style="color: red"><%=dia%> (Hoy)</p>
                        <%}else{%>
                        <p class="calendar-day-number"><%=dia-cantidadDiasMesActual%></p>
                        <%}%>
                        <%boolean aux=true;
                            for(Evento e:listaEventos){
                                String fechaEventoAux[]=e.getFecha().toString().split("-");
                                if(fechaEventoAux[2].equals(dia.toString())&&Integer.parseInt(fechaEventoAux[1])==(mesAux+2)){
                                    if(aux){%>
                        <div class="calendar-day-events">
                            <%aux=false;
                            }%>
                            <p class="calendar-day-event popup-event-information-trigger" style="background-color: <%=colorPorActividad[e.getActividad().getIdActividad()]%> <%if(e.isEventoFinalizado()){%>;opacity: 0.5<%}%>" id="mostrarPopupEvento<%=listaEventos.indexOf(e)%>"><span class="calendar-day-event-text">⚔️<%=e.getTitulo()%></span></p>
                            <%}}if(!aux){%>
                        </div>
                        <%}%>
                    <%}else{%>
                        <%if(Integer.parseInt(diaActual)==dia&&Integer.parseInt(mesActual)==(mesAux+1)){%>
                        <p class="calendar-day-number" style="color: red"><%=dia%> (Hoy)</p>
                        <%}else{%>
                        <p class="calendar-day-number"><%=dia%></p>
                        <%}%>
                        <%boolean aux=true;
                            for(Evento e:listaEventos){
                                String fechaEventoAux[]=e.getFecha().toString().split("-");
                                if(Integer.parseInt(fechaEventoAux[2])==dia&&Integer.parseInt(fechaEventoAux[1])==(mesAux+1)){
                                    if(aux){%>
                        <div class="calendar-day-events">
                            <%aux=false;
                            }%>
                            <p class="calendar-day-event popup-event-information-trigger" style="background-color: <%=colorPorActividad[e.getActividad().getIdActividad()]%> <%if(e.isEventoFinalizado()){%>;opacity: 0.5<%}%>" id="mostrarPopupEvento<%=listaEventos.indexOf(e)%>"><span class="calendar-day-event-text">⚔️<%=e.getTitulo()%></span></p>
                            <%}}if(!aux){%>
                        </div>
                            <%}}%>
                    </div>
                    <%}%>
                </div>
                <%}%>
            </div>
            <%}%>
        </div>
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
<%for(Evento e:listaEventos){
    mes="";
    fechaAux=e.getFecha().toString().split("-")[1];
        switch (fechaAux){
        case "01":
            mes="Enero";
            break;
        case "02":
            mes="Febrero";
            break;
        case "03":
            mes="Marzo";
            break;
        case "04":
            mes="Abril";
            break;
        case "05":
            mes="Mayo";
            break;
        case "06":
            mes="Junio";
            break;
        case "07":
            mes="Julio";
            break;
        case "08":
            mes="Agosto";
            break;
        case "09":
            mes="Septiembre";
            break;
        case "10":
            mes= "Octubre";
            break;
        case "11":
            mes="Noviembre";
            break;
        case "12":
            mes="Diciembre";
            break;}%>
<div class="overlay" id="overlayEvento<%=listaEventos.indexOf(e)%>"></div>
<div class="popup" id="popupEvento<%=listaEventos.indexOf(e)%>">
    <svg class="cerrarPopup" id="cerrarPopupEvento<%=listaEventos.indexOf(e)%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div>
        <!-- POPUP EVENT COVER -->
        <figure class="popupAux-event-cover liquid">
            <%request.getSession().setAttribute("fotoMiniatura"+listaEventos.indexOf(e),e.getFotoMiniatura());%>
            <img src="Imagen?tipoDeFoto=fotoMiniatura&id=Miniatura<%=listaEventos.indexOf(e)%>" style="max-height: 400px" alt="cover-33">
        </figure>
        <!-- /POPUP EVENT COVER -->

        <!-- POPUP EVENT INFO -->
        <div class="popupAux-event-info">
            <!-- POPUP EVENT TITLE -->
            <p class="popupAux-event-title" style="font-size: 180%">Fibra Tóxica VS <%=e.getTitulo()%>
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
                        <p class="decorated-feature-title" style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de <%=mes%></p>
                        <%}else{%>
                        <%int diasQueFaltanParaElEvento=new DaoEvento().diferenciaDiasEventoActualidad(e.getIdEvento());
                        if(diasQueFaltanParaElEvento==0){%>
                        <p class="decorated-feature-title" style="color: red;">Hoy</p>
                        <%}else if(diasQueFaltanParaElEvento==1){%>
                        <p class="decorated-feature-title" style="color: orangered;">Mañana</p>
                        <%}else if(diasQueFaltanParaElEvento==2){%>
                        <p class="decorated-feature-title" style="color: orange;">En 2 días</p>
                        <%}else{%>
                        <p class="decorated-feature-title" style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de <%=mes%></p>
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
            <a href="<%=request.getContextPath()%>/EventoServlet?idEvento=<%=e.getIdEvento()%>"><p class="popupAux-event-button button cerrar-btn">Ingresar a la página del evento</p></a>
            <!-- /POPUP EVENT BUTTON -->
        </div>
        <!-- /POPUP EVENT INFO -->

        <p class="popupAux-event-subtitle" style="margin-left: 27px;">Último mensaje en el foro</p>
        <%MensajeChat m=new DaoMensajeChat().obtenerUltimoMensajeChat(e.getIdEvento());
        if(m!=null){
        Integer[] diferenciaTiempoUltimoMensaje=new DaoEvento().obtenerDiferenciaEntre2FechasMensaje(m.getIdMensajeChat());%>
        <!-- POST COMMENT -->
        <div class="post-comment">
            <!-- USER AVATAR -->
            <a class="user-avatar small no-outline">
                <!-- USER AVATAR CONTENT -->
                <div class="user-avatar-content">
                    <!-- HEXAGON -->
                    <%request.getSession().setAttribute("fotoPerfil"+listaEventos.indexOf(e),m.getUsuario().getFotoPerfil());%>
                    <div class="hexagon-image-30-32" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Perfil<%=listaEventos.indexOf(e)%>"></div>
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
            <%String mensajeAux="";
                if(m.getMensaje().length()>=50){
                    char[]mensajeChar=m.getMensaje().toCharArray();
                    for(int i=0;i<50;i++){
                        mensajeAux+=mensajeChar[i];
                    }mensajeAux+="...";
                }else {
                    mensajeAux=m.getMensaje();
                }
            %>
            <!-- POST COMMENT TEXT -->
            <p class="post-comment-text"><a class="post-comment-text-author"><%if(m.getUsuario().getIdUsuario()==usuarioActual.getIdUsuario()){%>Tú<%}else{%><%=m.getUsuario().getNombre()%> <%=m.getUsuario().getApellido()%><%}%></a><%=mensajeAux%></p>
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500"></p>
            <%if(diferenciaTiempoUltimoMensaje[0]>1){%>
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500"><%=m.getFecha()%> a las <%=m.getHora()%></p>
            <%}else if(diferenciaTiempoUltimoMensaje[0]==1){%>
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Ayer a las <%=m.getHora()%></p>
            <%}else if(diferenciaTiempoUltimoMensaje[1]>0){
                if(diferenciaTiempoUltimoMensaje[1]==1){%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Hace 1 hora</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}else{%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Hace <%=diferenciaTiempoUltimoMensaje[1]%> horas</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}%>
            <%}else if(diferenciaTiempoUltimoMensaje[2]>0){
                if(diferenciaTiempoUltimoMensaje[2]==1){%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Hace 1 minuto</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}else{%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Hace <%=diferenciaTiempoUltimoMensaje[2]%> minutos</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}%>
            <%}else if(diferenciaTiempoUltimoMensaje[3]>0){
                if(diferenciaTiempoUltimoMensaje[3]==1){%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Hace 1 segundo</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}else{%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Hace <%=diferenciaTiempoUltimoMensaje[3]%> segundos</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}}else{%>
            <!-- USER STATUS TIMESTAMP -->
            <p style="margin-top: 6px;color: #adafca;font-size: 0.75rem;font-weight: 500">Ahora mismo</p>
            <!-- /USER STATUS TIMESTAMP -->
            <%}%>
        </div>
        <!-- /POST COMMENT LIST -->
        <%}else{%>
        <div class="post-comment">
            <a style="color: #6c757d;">No hay ningún mensaje dentro del foro del evento</a>
        </div>
        <%}%>
    </div>
    <br>
</div>
<%}%>
<script>
    function enviarFormulario(idForm) {
        var formulario = document.getElementById(idForm);
        formulario.submit();
    }
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
    function cambiarCalendarioMes(idSelect){
        let mesEscogido=document.getElementById(idSelect);
        mesEscogido.addEventListener("change",function (){
            console.log("ola")
            <%for(int i=1;i<=12;i++){%>
            document.getElementById('mes<%=i%>').style.display="none";
            <%}%>
           switch (mesEscogido.value){
               <%for(int i=1;i<=12;i++){%>
               case "<%=i%>":
                   document.getElementById('mes<%=i%>').style.display="block";
                   break;
               <%}%>
           }
        });
    }
    document.getElementById('mes<%=mesActual%>').style.display="block";
    cambiarCalendarioMes('calendarioMes');
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