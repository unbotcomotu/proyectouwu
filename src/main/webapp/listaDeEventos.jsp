<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>
<%@ page import="com.example.proyectouwu.Beans.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%Usuario usuarioActual=(Usuario) request.getSession().getAttribute("usuario");
        String action = request.getSession().getAttribute("action") != null ? (String) request.getSession().getAttribute("action") : "";
        int idUsuario=usuarioActual.getIdUsuario();
        String rolUsuario=usuarioActual.getRol();
        String nombreCompletoUsuario=usuarioActual.getNombre()+" "+usuarioActual.getApellido();
        int idActividad = (int) request.getAttribute("idActividad");
        String vistaActual=(String) request.getAttribute("vistaActual");
        ArrayList<String>listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
        ArrayList<Evento>listaEventos=(ArrayList<Evento>)request.getAttribute("listaEventos");
        String nombreActividad=(String)request.getAttribute("nombreActividad");
        ArrayList<LugarEvento>listaLugares=(ArrayList<LugarEvento>) request.getAttribute("listaLugares");
        int delegadoDeEstaActividadID=(int)request.getAttribute("delegadoDeEstaActividadID");
        String servletActual="ListaDeEventosServlet";
        int cantidadTotalEventos = request.getAttribute("cantidadEventosTotal")!=null? (int)Math.ceil((int)request.getAttribute("cantidadEventosTotal")/12.0):0;
        Integer pagActual = request.getSession().getAttribute("pagActual") != null ? (Integer) request.getSession().getAttribute("pagActual") : 1;
        //String busqueda=(String) request.getAttribute("evento");

        Integer eventoOculto = (Integer) request.getSession().getAttribute("eventoOculto");
        Integer eventoFinalizado = (Integer) request.getSession().getAttribute("eventoFinalizado");
        Integer eventoApoyado = (Integer) request.getSession().getAttribute("eventoApoyando");
        Integer eventoHoy = (Integer) request.getSession().getAttribute("eventosHoy");
        Integer eventoManana = (Integer) request.getSession().getAttribute("eventosManana");
        Integer eventoMasDias = (Integer) request.getSession().getAttribute("eventosMasDias");

        ArrayList<NotificacionDelegadoGeneral>listaNotificacionesCampanita=(ArrayList<NotificacionDelegadoGeneral>) request.getAttribute("listaNotificacionesCampanita");
        ArrayList<AlumnoPorEvento>listaNotificacionesDelegadoDeActividad=(ArrayList<AlumnoPorEvento>) request.getAttribute("listaNotificacionesDelegadoDeActividad");
        String colorRol;
        if(rolUsuario.equals("Alumno")){
            colorRol="";
        }else if(rolUsuario.equals("Delegado de Actividad")){
            colorRol="green";
        }else{
            colorRol="orange";
        }
        String descripcionLarga=(String) request.getSession().getAttribute("descripcionLarga");
        if(descripcionLarga!=null){
            request.getSession().removeAttribute("descripcionLarga");
        }
        String fraseLarga=(String) request.getSession().getAttribute("fraseLarga");
        if(fraseLarga!=null){
            request.getSession().removeAttribute("fraseLarga");
        }
        String resumenLargo=(String) request.getSession().getAttribute("resumenLargo");
        if(resumenLargo!=null){
            request.getSession().removeAttribute("resumenLargo");
        }
        Integer eventoElegido=(Integer) request.getSession().getAttribute("eventoElegido");
        if(eventoElegido!=null){
            request.getSession().removeAttribute("eventoElegido");
        }
        String extensionInvalida=(String) request.getSession().getAttribute("extensionInvalida");
        if(extensionInvalida!=null){
            request.getSession().removeAttribute("extensionInvalida");
        }
        String escalaInvalida=(String) request.getSession().getAttribute("escalaInvalida");
        if(escalaInvalida!=null){
            request.getSession().removeAttribute("escalaInvalida");
        }
        String fechaInvalida = (String) request.getSession().getAttribute("fechaInvalida");
        if(fechaInvalida!=null){
            request.getSession().removeAttribute("fechaInvalida");
        }
        ArrayList<Integer[]>listaLugaresCantidad=(ArrayList<Integer[]>) request.getSession().getAttribute("listaLugaresCantidad");
        ArrayList<Integer> listaLugaresFiltro = new ArrayList<>();
        for(int i=0;i<listaLugaresCantidad.size();i++){
            listaLugaresFiltro.add((Integer) request.getSession().getAttribute("lugar"+i));
        }
        int cantidadLugares = 0;
        String parametrosURL = "";
    %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- bootstrap 4.3.1 -->
    <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
    <!-- styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/raw/styles.css">
    <!-- simplebar styles -->
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <!-- favicon -->
    <link rel="icon" href="css/murcielago.ico">
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
        @media screen and (max-width: 680px) {
            .auxResponsive{
                max-height: 150px!important;
            }
            .contenedor2{
                margin-top: 0!important;
                margin-bottom: 5px!important;
            }
        }
        @media screen and (max-width: 777px) {
            .recuadroTexto {
                margin-bottom: 15px;
            }

            .contenedorCrear {
                width: 80% !important;
            }
            .auxOption{
                font-size: 75%;
            }
        }
        .campanita{
            width: 500px;
        }
        @media screen and (max-width: 576px) {
            .auxResponsiveUwu{
                display: none;
            }
            .auxResponsive{
                max-height: 75px!important;
            }
            .popup{
                max-width: 500px!important;
            }
            .auxLabel{
                margin-top: 10px!important;
            }
            .campanita{
                width: 345px;
            }
            .contenedor2{
                top:20px !important;
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
                        <%for(AlumnoPorEvento noti:listaNotificacionesDelegadoDeActividad){%>
                        <form id="notificacionLeidaDelegadoDeActividad<%=listaNotificacionesDelegadoDeActividad.indexOf(noti)%>" method="post" action="PaginaNoExisteServlet?action=notificacionLeidaCampanitaDelegadoDeActividad">
                            <input type="hidden" name="idAlumnoPorEvento" value="<%=noti.getIdAlumnoPorEvento()%>">
                            <input type="hidden" name="idActividad" value="<%=idActividad%>">
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
                            <input type="hidden" name="idActividad" value="<%=idActividad%>">
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
    <%}%>
    <!-- /HEADER ACTIONS -->
</header>
<!-- /HEADER -->

<!-- CONTENT GRID -->

<div class="content-grid">

    <!-- SECTION BANNER -->
    <div class="section-banner" style="padding: 0 0 0 0 !important;">
        <!-- SECTION BANNER ICON -->
        <%DaoActividad daoActividad = new DaoActividad();%>
        <%request.getSession().setAttribute("fotoActividadCabecera"+idActividad,daoActividad.obtenerFotoCabeceraXIdActividad(idActividad));%>

        <div class="section-banner" style="background: url('Imagen?tipoDeFoto=fotoActividadCabecera&id=ActividadCabecera<%=idActividad%>') no-repeat left !important;background-size: 15% 100% !important;height: 100% !important;">
            <!-- SECTION BANNER TITLE -->
            <p class="section-banner-title"><%=nombreActividad%></p>
            <!-- /SECTION BANNER TITLE -->
            <p class="section-banner-text"><b>Delegado de Actividad: <%=new DaoUsuario().nombreCompletoUsuarioPorId(delegadoDeEstaActividadID)%></b></p>
            <!-- SECTION BANNER TEXT -->
            <p class="section-banner-text">Encuentra todos los eventos dentro de <%=nombreActividad%></p>
            <!-- /SECTION BANNER TEXT -->
        </div>

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
                    <button onclick="popupFunc('popupCrear',['cerrarPopupCrear','cerrarPopupCrear1','cerrarPopupCrear2'],'overlayCrear')" class="button secondary popup-event-creation-trigger botones" style="width: 100%;">Crear evento</button>
                    <!-- /BUTTON -->
                </div>
                <%}%>
            </div>
        </div>
    </div>
    <!-- /SECTION HEADER -->
    <form method="get" class="form" action="ListaDeEventosServlet">
    <!-- SECTION FILTERS BAR -->
        <div class="section-filters-bar v4">
            <!-- SECTION FILTERS BAR ACTIONS -->

            <div class="section-filters-bar-actions">
                <!-- FORM -->

                    <!-- FORM ITEM -->
                    <div class="form-item split">
                        <!-- FORM INPUT -->
                        <div class="form-input small">
                            <label for="items-search">Buscar evento</label>
                            <!-- Se mandan todos los atributos -->
                            <input type="text" id="items-search" name="nombreEvento" value="<%=request.getSession().getAttribute("nombreEvento") != null ? request.getSession().getAttribute("nombreEvento") : ""%>">
                            <input type="hidden" name="idActividad" value="<%=idActividad%>">
                            <input type="hidden" name="p" value="<%=pagActual%>">
                            <input type="hidden" name="action" value="superFiltro">
                            <input type="hidden" name="vieneDelJspDeListaDeEventos" value="1">
                            <!-- Parametros para la URL -->
                            <%parametrosURL +="&nombreEvento="+(request.getSession().getAttribute("nombreEvento") != null ? request.getSession().getAttribute("nombreEvento") : "");%>
                            <%parametrosURL +="&idOrdenarEventos="+(request.getSession().getAttribute("idOrdenarEventos")!=null?request.getSession().getAttribute("idOrdenarEventos"):0);%>
                            <%parametrosURL +="&idSentidoEventos="+(request.getSession().getAttribute("idSentidoEventos")!=null?request.getSession().getAttribute("idSentidoEventos"):0);%>
                            <%if(eventoFinalizado != null && eventoFinalizado==1){
                                parametrosURL +="&eventoFinalizado=1";}%>
                            <%parametrosURL +="&cantidadLugares="+cantidadLugares;%>
                            <%if(eventoHoy != null){
                                parametrosURL +="&eventosHoy=1";}%>
                            <%if(eventoManana != null){
                                parametrosURL +="&eventosManana=1";}%>
                            <%if(eventoMasDias != null){
                                parametrosURL +="&eventosMasDias=1";}%>
                            <%parametrosURL +="&horaInicio="+(request.getSession().getAttribute("horaInicio") != null ? request.getSession().getAttribute("horaInicio") : "");%>
                            <%parametrosURL +="&horaFin="+(request.getSession().getAttribute("horaFin") != null ? request.getSession().getAttribute("horaFin") : "");%>
                        <!-- /FORM INPUT -->
                        </div>
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

                <!-- /FORM -->
            </div>
            <!-- /SECTION FILTERS BAR ACTIONS -->

            <!-- SECTION FILTERS BAR ACTIONS -->
            <div class="section-filters-bar-actions">
                <!-- FORM -->
                    <!-- FORM ITEM -->
                    <div class="form-item split medium">
                        <%String idOrdenarEventos=(String) request.getSession().getAttribute("idOrdenarEventos");%>
                        <!-- FORM SELECT -->
                        <div class="form-select small">
                            <label for="items-filter-category">Ordenar por</label>
                            <select id="items-filter-category" name="idOrdenarEventos">
                                <option value="0" <%if(idOrdenarEventos!=null && idOrdenarEventos.equals("0")){%>selected<%}%>>Más reciente</option>
                                <option value="1" <%if(idOrdenarEventos!=null && idOrdenarEventos.equals("1")){%>selected<%}%>>Orden alfabético</option>
                            </select>
                            <!-- FORM SELECT ICON -->
                            <svg class="form-select-icon icon-small-arrow">
                                <use xlink:href="#svg-small-arrow"></use>
                            </svg>
                            <!-- /FORM SELECT ICON -->
                        </div>
                        <!-- /FORM SELECT -->
                        <%String idSentidoEventos=(String) request.getSession().getAttribute("idSentidoEventos");%>
                        <!-- FORM SELECT -->
                        <div class="form-select small">
                            <label for="items-filter-order">Sentido</label>
                            <select id="items-filter-order" name="idSentidoEventos">
                                <option value="0" <%if(idSentidoEventos!=null){if(idSentidoEventos.equals("0")){%>selected<%}}%>>Primero -> Último</option>
                                <option value="1" <%if(idSentidoEventos!=null){if(idSentidoEventos.equals("1")){%>selected<%}}%>>Último -> Primero</option>
                            </select>
                            <!-- FORM SELECT ICON -->
                            <svg class="form-select-icon icon-small-arrow">
                                <use xlink:href="#svg-small-arrow"></use>
                            </svg>
                            <!-- /FORM SELECT ICON -->
                        </div>
                        <!-- /FORM SELECT -->

                        <!-- BUTTON -->
                        <button type="submit" class="button secondary">Aplicar filtros</button>
                        <!-- /BUTTON -->
                    </div>
                    <!-- /FORM ITEM -->
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
                                    <input type="checkbox" id="category-logos-and-badges" name="eventoFinalizado" value="1" <%if(eventoFinalizado != null && eventoFinalizado==1){%>checked<%}%>>
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
                            <%if(!rolUsuario.equals("Delegado General") && delegadoDeEstaActividadID!=idUsuario){%>
                            <!-- CHECKBOX LINE -->
                            <div class="checkbox-line">
                                <!-- CHECKBOX WRAP -->
                                <div class="checkbox-wrap">
                                    <input type="checkbox" id="category-sketch" name="eventoApoyando" value="1" <%if(eventoApoyado != null && eventoApoyado==1){%>checked<%}%>>
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
                                    <input type="checkbox" id="ola" name="eventoOculto" value="1" <%if(eventoOculto != null && eventoOculto==1){%>checked<%}%>>
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
                            <%cantidadLugares = 0;
                            for(Integer[] par:listaLugaresCantidad){%>
                            <div class="checkbox-line">
                                <!-- CHECKBOX WRAP -->
                                <div class="checkbox-wrap">
                                    <input type="checkbox" id="category-<%=listaLugaresCantidad.indexOf(par)%>" name="lugar<%=listaLugaresCantidad.indexOf(par)%>" value="<%=par[0]%>" <%if(listaLugaresFiltro.get(cantidadLugares) != null){%>checked<%}%>>
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
                            <%
                                    parametrosURL +="&lugar"+listaLugaresCantidad.indexOf(par)+"="+par[0];
                            cantidadLugares++;}%>
                            <input type="hidden" name="cantidadLugares" value="<%=cantidadLugares%>">
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
                                    <input type="checkbox" id="category-photoshop" name="eventosHoy" value="1" <%if(eventoHoy != null){%>checked<%}%>>
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
                                    <input type="checkbox" id="category-illustrator" name="eventosManana" value="1" <%if(eventoManana != null){%>checked<%}%>>
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
                                    <input type="checkbox" id="category-html-css" name="eventosMasDias" value="1" <%if(eventoMasDias != null){%>checked<%}%>>
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
                                    <input type="text" id="price-from" name="horaInicio" value="<%=request.getSession().getAttribute("horaInicio") != null ? request.getSession().getAttribute("horaInicio") : ""%>">
                                </div>
                                <!-- /FORM INPUT -->

                                <!-- FORM INPUT -->
                                <div class="form-input small active always-active">
                                    <label for="price-to">Hasta</label>
                                    <input type="text" id="price-to" name="horaFin" value="<%=request.getSession().getAttribute("horaFin") != null ? request.getSession().getAttribute("horaFin") : ""%>">
                                </div>
                                <!-- /FORM INPUT -->
                            </div>
                            <!-- /FORM ITEM -->
                        </div>
                        <!-- /SIDEBAR BOX ITEMS -->

                        <!-- BUTTON -->
                        <button type="submit" class="button small primary">Aplicar filtros de categoría</button>
                        <!-- /BUTTON -->

                </div>
                <!-- /SIDEBAR BOX -->
            </div>
            <!-- /MARKETPLACE SIDEBAR -->

            <!-- MARKETPLACE CONTENT -->
            <div class="marketplace-content">
            <!-- GRID -->
            <div class="grid grid-3-3-3 centered">
                <%if(listaEventos!=null){
                    for(Evento e:listaEventos){
                        String mes="";
                        String fechaAux=e.getFecha().toString().split("-")[1];
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
                                break;
                        }%>
                <!-- PRODUCT PREVIEW -->
                <%if(delegadoDeEstaActividadID==idUsuario||rolUsuario.equals("Delegado General")){%>
                <div class="product-preview" style="<%if(e.isEventoFinalizado()){%>opacity: 0.5<%}%>">
                    <!-- PRODUCT PREVIEW IMAGE -->
                    <figure class="product-preview-image liquid" style="position: relative">
                        <a href="<%=request.getContextPath()%>/EventoServlet?idEvento=<%=e.getIdEvento()%>">
                            <img src="ImagenEventoServlet?idEvento=<%=e.getIdEvento()%>" style="position: absolute; z-index: 0" height="100%" width="100%" alt="item-01">
                        </a>
                        <%if(delegadoDeEstaActividadID==idUsuario){%>
                        <a onclick="popupFunc('popupEditarEvento<%=listaEventos.indexOf(e)%>',['cerrarPopupEditarEvento<%=listaEventos.indexOf(e)%>','cerrarPopupEditar1Evento<%=listaEventos.indexOf(e)%>','cerrarPopupEditar2Evento<%=listaEventos.indexOf(e)%>'],'overlayEditarEvento<%=listaEventos.indexOf(e)%>')">
                            <img src="css/ajustesEvento.png" class="mt-2" style="position: absolute;right: 2%; z-index: 100;height: 50px;width: 50px;cursor: pointer" alt="">
                        </a>
                        <a onclick="popupFunc('popupFinalizarEvento<%=listaEventos.indexOf(e)%>',['cerrarPopupFinalizarEvento<%=listaEventos.indexOf(e)%>','cerrarPopupFinalizar1Evento<%=listaEventos.indexOf(e)%>','cerrarPopupFinalizar2Evento<%=listaEventos.indexOf(e)%>'],'overlayFinalizarEvento<%=listaEventos.indexOf(e)%>')">
                            <img src="css/iconoFinalizar.png" class="mt-2" style="position: absolute;left: 3%; z-index: 100;height: 50px;width: 47px;cursor: pointer" alt="">
                        </a>
                        <%}%>
                    </figure>
                    <!-- /PRODUCT PREVIEW IMAGE -->

                    <!-- PRODUCT PREVIEW INFO -->
                    <div class="product-preview-info">
                        <!-- TEXT STICKER -->
                        <p class="text-sticker" style="right: 180px;">
                            <%if(e.isEventoOculto()){%>
                            <span style="color: brown;">Oculto</span>
                            <%}else{%>
                            <span style="color: green;">No oculto</span><%}%>
                        </p>
                        <p class="text-sticker"><span class="highlighted">Fecha: </span>
                            <%if(e.isEventoFinalizado()){%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de <%=mes%></span>
                            <%}else{%>
                            <%int diasQueFaltanParaElEvento=new DaoEvento().diferenciaDiasEventoActualidad(e.getIdEvento());
                                if(diasQueFaltanParaElEvento==0){%>
                            <span style="color: red;">Hoy</span>
                            <%}else if(diasQueFaltanParaElEvento==1){%>
                            <span style="color: orangered;">Mañana</span>
                            <%}else if(diasQueFaltanParaElEvento==2){%>
                            <span style="color: orange;">En 2 días</span>
                            <%}else{%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de <%=mes%></span>
                            <%}}%>
                        </p>
                        <!-- /TEXT STICKER -->
                        <!-- PRODUCT PREVIEW TITLE -->
                        <%int tamanoLetraTitulo=0;
                            if(e.getTitulo().length()>20){
                                tamanoLetraTitulo=90;
                            }else if (e.getTitulo().length()>17){
                                tamanoLetraTitulo=95;
                            }else if(e.getTitulo().length()>14){
                                tamanoLetraTitulo=100;
                            }else{
                                tamanoLetraTitulo=110;
                            }%>
                        <p class="product-preview-title d-flex justify-content-center"><a style="font-size: <%=tamanoLetraTitulo%>%">Fibra Tóxica VS <%=e.getTitulo()%></a></p>
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
                                    <%String lugar=new DaoEvento().lugarPorEventoID(e.getIdEvento());
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
                <div class="product-preview" style="<%if(e.isEventoFinalizado()){%>opacity: 0.5<%}%>">
                    <!-- PRODUCT PREVIEW IMAGE -->
                    <a href="<%=request.getContextPath()%>/EventoServlet?idEvento=<%=e.getIdEvento()%>">
                        <figure class="product-preview-image liquid">
                            <img src="ImagenEventoServlet?idEvento=<%=e.getIdEvento()%>" alt="item-01">
                        </figure>
                    </a>
                    <!-- /PRODUCT PREVIEW IMAGE -->

                    <!-- PRODUCT PREVIEW INFO -->
                    <div class="product-preview-info">
                        <%String tipoDeApoyo=new DaoAlumnoPorEvento().verificarApoyo(e.getIdEvento(),idUsuario);%>
                        <!-- TEXT STICKER -->
                        <%if(tipoDeApoyo!=null&&!tipoDeApoyo.equals("Pendiente")){%>
                        <p class="text-sticker" style="right: 180px;"><span style="color: green;">Apoyando</span></p>
                        <%}else if(tipoDeApoyo!=null&&tipoDeApoyo.equals("Pendiente")){%>
                        <p class="text-sticker" style="right: 180px;"><span style="color: steelblue;">Pendiente</span></p>
                        <%}else{%>
                        <p class="text-sticker" style="right: 170px;"><span style="color: brown;">No apoyando</span></p>
                        <%}%>
                        <p class="text-sticker"><span class="highlighted">Fecha: </span>
                            <%if(e.isEventoFinalizado()){%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de <%=mes%></span>
                            <%}else{%>
                            <%int diasQueFaltanParaElEvento=new DaoEvento().diferenciaDiasEventoActualidad(e.getIdEvento());
                                if(diasQueFaltanParaElEvento==0){%>
                            <span style="color: red;">Hoy</span>
                            <%}else if(diasQueFaltanParaElEvento==1){%>
                            <span style="color: orangered;">Mañana</span>
                            <%}else if(diasQueFaltanParaElEvento==2){%>
                            <span style="color: orange;">En 2 días</span>
                            <%}else{%>
                            <span style="color: purple;"><%=Integer.parseInt(e.getFecha().toString().split("-")[2])%> de <%=mes%></span>
                            <%}}%>
                        </p>
                        <!-- /TEXT STICKER -->
                        <%int tamanoLetraTitulo=0;
                            if(e.getTitulo().length()>20){
                                tamanoLetraTitulo=90;
                            }else if (e.getTitulo().length()>17){
                                tamanoLetraTitulo=95;
                            }else if(e.getTitulo().length()>14){
                                tamanoLetraTitulo=100;
                            }else{
                                tamanoLetraTitulo=110;
                            }%>
                        <p class="product-preview-title d-flex justify-content-center"><a style="font-size: <%=tamanoLetraTitulo%>%">Fibra Tóxica VS <%=e.getTitulo()%></a></p>

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
                                    <%String lugar=new DaoEvento().lugarPorEventoID(e.getIdEvento());
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
            <!-- SECTION PAGER BAR -->
                <!-- SECTION PAGER BAR WRAP -->
                <div class="section-pager-bar-wrap align-center">
                    <!-- SECTION PAGER BAR -->
                        <div class="section-pager-bar " >
                            <!-- SECTION PAGER -->
                            <div class="section-pager">
                                <!-- SECTION PAGER ITEM -->
                                <%for(int p=0;p<cantidadTotalEventos; p++){%>
                                <div class="section-pager-item <%if(pagActual==p+1){%>active<%}%>">
                                    <!-- SECTION PAGER ITEM TEXT -->
                                        <%if(p<9){%>
                                            <a class="section-pager-item-text" href="ListaDeEventosServlet?action=<%=action%>&idActividad=<%=idActividad%>&p=<%=p+1%><%=parametrosURL%>">0<%=p+1%></a>                            <!-- /SECTION PAGER ITEM TEXT -->
                                        <%}else{%>
                                            <a class="section-pager-item-text" href="ListaDeEventosServlet?action=<%=action%>&idActividad=<%=idActividad%>&p=<%=p+1%><%=parametrosURL%>"><%=p+1%></a>
                                        <%}%>
                                </div>
                                <%}%>
                                <!-- /SECTION PAGER ITEM -->

                                <!-- SECTION PAGER ITEM -->

                                <!-- /SECTION PAGER ITEM -->

                                <!-- SECTION PAGER ITEM -->

                                <!-- /SECTION PAGER ITEM -->
                            </div>
                        <!-- /SECTION PAGER -->

                    </div>
                    <!-- /SECTION PAGER BAR -->
                </div>
                <!-- /SECTION PAGER BAR WRAP -->
            </div>
            <!-- /MARKETPLACE CONTENT -->

        </div>
        <!-- /GRID -->
    </form>
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
<%if(delegadoDeEstaActividadID==idUsuario){%>
<div class="overlay" <%if((descripcionLarga!=null||fraseLarga!=null||extensionInvalida!=null||escalaInvalida!=null || fechaInvalida!=null)&&eventoElegido==null){%>style="display: block;"<%}%> id="overlayCrear"></div>
<div class="popup contenedorCrear" style="width: 700px;<%if((descripcionLarga!=null||fraseLarga!=null||extensionInvalida!=null||escalaInvalida!=null || fechaInvalida!=null)&&eventoElegido==null){%>display: block;<%}%>" id="popupCrear">
    <svg class="cerrarPopup" id="cerrarPopupCrear" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form  method="post" action="<%=request.getContextPath()%>/ListaDeEventosServlet?action=addConfirm" enctype="multipart/form-data">
        <div class="container-fluid">
        <div class="row"><div class="col"><h5 style="text-align: center;">Crear evento</h5></div></div>
        <div class="row">
            <div class="col-sm-7">
                <br>
                <input hidden name="idUsuario" value=<%=idUsuario%>>
                <input hidden name="idActividad" value=<%=idActividad%>>
                <label class="auxLabel" for="nombreCrearEvento" style="margin-top: 25px;"><b>Nombre del evento:</b></label>
                <div class="row">
                    <div class="col-5">
                        <input style="font-size: 80%" type="text" value="Fibra Tóxica VS" disabled>
                    </div>
                    <div class="col-7">
                        <select class="auxOption" name="addTitulo" style="height: 55px;padding-left: 20px" id="nombreCrearEvento" required>
                            <option class="auxOption" value="Descontrol Automático">Descontrol Automático</option>
                            <option class="auxOption" value="Electroshock">Electroshock</option>
                            <option class="auxOption" value="Hormigón Armado">Hormigón Armado</option>
                            <option class="auxOption" value="Huascaminas">Huascaminas</option>
                            <option class="auxOption" value="Maphia Cuántica">Maphia Cuántica</option>
                            <option class="auxOption" value="Memoria Caché">Memoria Caché</option>
                            <option class="auxOption" value="Naranja Mecánica">Naranja Mecánica</option>
                            <option class="auxOption" value="PXO Industrial">PXO Industrial</option>
                            <option class="auxOption" value="Todos">Todos</option>
                        </select>
                    </div>
                </div>
                <label class="auxLabel" style="margin-top: 25px;" ><b>Frase motivacional: <%if(fraseLarga!=null&&eventoElegido==null){%><a style="color: red;">Ingrese una frase más corta</a><%}%></b></label>
                <input type="text" id="fraseMotivacionalCrearEvento" name="addFraseMotivacional" placeholder="Frase motivacional" required>
                <label class="auxLabel" style="margin-top: 25px;"><b>Descripción del evento: <%if(descripcionLarga!=null&&eventoElegido==null){%><a style="color: red;">Ingrese una descripción más corta</a><%}%></b></label>
                <textarea type="text" id="descripcionCrearEvento" name="addDescripcionEventoActivo" placeholder="Descripción" maxlength="1000"></textarea>
                <div class="row auxLabel" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="horaCrearEvento"><b>Hora:</b></label>
                        <input style="height: 55px;padding-left: 20px" type="time" id="horaCrearEvento" name="addHora" required>
                    </div>
                    <div class="col-6">
                        <label for="lugarCrearEvento"><b>Lugar:</b></label>
                        <select style="height: 55px;padding-left: 20px" name="addLugar" id="lugarCrearEvento" required>
                            <%for(LugarEvento l:listaLugares){%>
                            <option value="<%=l.getLugar()%>"><%=l.getLugar()%></option>
                            <%}%>
                        </select>
                    </div>
                </div>
                <div class="row auxLabel" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="fechaCrearEvento"><b>Fecha (día):</b></label>
                        <input style="height: 55px;padding-left: 20px" type="date" id="fechaCrearEvento" name="addFecha" multiple required>
                    </div>
                    <%if (fechaInvalida!=null&&eventoElegido==null){%>
                    <label for="inputCrear"><a style="color: red;">Ingrese una fecha válida</a></label>
                    <%}%>
                    <div class="col-6">
                        <p style="width: 100%;"><b>Ocultar evento:</b></p>
                        <input type="checkbox" name="addEventoOculto" style="width: 30%; position: relative; top: 15px; left: 60px;">
                    </div>
                </div>
            </div>
            <div class="col-sm-5 contenedor2 my-5 d-flex align-items-center">
                <div class="container-fluid btn btn-file1">
                    <div id="contenedorImagenCrear" class="auxResponsive">
                        <img id="imagenActualCrear" class="img-fluid auxResponsive" src="css/subirArchivo.jpg" style="opacity: 50%;max-height: 600px" alt="">
                    </div>
                    <p style="margin-top: 10px"><b>Agregar foto miniatura</b></p>
                    <%if(extensionInvalida!=null&&eventoElegido==null){%><label for="inputCrear"><a style="color: red;">Ingrese un formato e imagen correctos</a></label><%}else if(escalaInvalida!=null&&eventoElegido==null){%><label for="inputCrear"><a style="color: red;">Ingrese una escala apropiada</a></label><%}%>
                    <input type="file" id="inputCrear" name="addfotoMiniatura" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg" onchange="mostrarImagen('imagenActualCrear','contenedorImagenCrear','inputCrear')"></input>
                </div>
            </div>
        </div>
    </div>
    <br>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="submit" class="button secondary" style="opacity: 0.5" id="cerrarPopupCrear1" disabled>Crear</button>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="button" class="button secondary" id="cerrarPopupCrear2" style="background-color: grey;">Cancelar</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%if(listaEventos!=null&&!listaEventos.isEmpty()){
    for(Evento e:listaEventos){%>
<div class="overlay" id="overlayFinalizarEvento<%=listaEventos.indexOf(e)%>"></div>
<div class="popup" style="width: 500px;" id="popupFinalizarEvento<%=listaEventos.indexOf(e)%>">
    <svg class="cerrarPopup" id="cerrarPopupFinalizarEvento<%=listaEventos.indexOf(e)%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <%if(e.isEventoFinalizado()){%>
    <div id="cerrarPopupFinalizar1Evento<%=listaEventos.indexOf(e)%>"></div>
    <div id="cerrarPopupFinalizar2Evento<%=listaEventos.indexOf(e)%>"></div>
    <div class="container-fluid">
        <div class="text-center" style="margin-bottom: 10px">
            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-exclamation-circle-fill" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
            </svg>
        </div>
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <h5 style="text-align: center;">El evento ya se encuentra finalizado</h5>
            </div>
            <div class="col-sm-1"></div>
        </div>
    </div>
    <%}else{%>
    <form method="post" action="<%=request.getContextPath()%>/ListaDeEventosServlet?action=finConfirm" >
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <input type="hidden" name="idActividad" value=<%=idActividad%>>
                    <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
                    <a class="text-center"><h5>Finalizar el evento <span style="color: steelblue;">Fibra Tóxica VS </span><span style="color: #0b2e13;"><%=e.getTitulo()%></span></h5></a>
                    <label class="auxLabel" for="resumenEvento<%=listaEventos.indexOf(e)%>" style="margin-top: 25px;"><b>Resumen:</b></label>
                    <textarea id="resumenEvento<%=listaEventos.indexOf(e)%>" name="finResumen" placeholder="Resumen" required></textarea>
                    <label class="auxLabel" for="resultado2Evento<%=listaEventos.indexOf(e)%>" style="margin-top: 25px;"><b>Resultado:</b></label>
                    <select style="padding: 12.5px" name="resultado" id="resultado2Evento<%=listaEventos.indexOf(e)%>" required>
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
                    <button class="button secondary" type="submit" style="opacity: 50%;" id="cerrarPopupFinalizar1Evento<%=listaEventos.indexOf(e)%>" disabled="true">Finalizar</button>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="button" class="button secondary" id="cerrarPopupFinalizar2Evento<%=listaEventos.indexOf(e)%>" style="background-color: grey;">Cancelar</button>
                </div>
            </div>
        </div>
    </form>
    <%}%>
</div>

<div class="overlay" <%if((resumenLargo!=null||descripcionLarga!=null||fraseLarga!=null||extensionInvalida!=null||escalaInvalida!=null)&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%>style="display: block;"<%}%> id="overlayEditarEvento<%=listaEventos.indexOf(e)%>"></div>
<div class="popup contenedorCrear" style="width: 700px;<%if((resumenLargo!=null||descripcionLarga!=null||fraseLarga!=null||extensionInvalida!=null||escalaInvalida!=null)&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%>display: block;<%}%>" id="popupEditarEvento<%=listaEventos.indexOf(e)%>">
    <svg class="cerrarPopup" id="cerrarPopupEditarEvento<%=listaEventos.indexOf(e)%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <form  method="post" action="<%=request.getContextPath()%>/ListaDeEventosServlet?action=updateConfirm" enctype="multipart/form-data">
        <div class="container-fluid">
        <div class="row"><div class="col"><h5 style="text-align: center;">Editar evento</h5></div></div>
        <div class="row">
            <div class="col-sm-7">
                <br>
                <input hidden name="idActividad" value=<%=idActividad%>>
                <input hidden name="idEvento" value=<%=e.getIdEvento()%>>
                <input hidden name="estadoEvento" value=<%=e.isEventoFinalizado()%>>
                <label class="auxLabel" for="editarNombreEvento<%=listaEventos.indexOf(e)%>" style="margin-top: 25px;"><b>Nombre del evento:</b></label>
                <div class="row">
                    <div class="col-5">
                        <input style="font-size: 80%" type="text" value="Fibra Tóxica VS" disabled>
                    </div>
                    <div class="col-7">
                        <select class="auxOption" style="height: 55px;padding-left: 20px" name="updateTitulo" id="editarNombreEvento<%=listaEventos.indexOf(e)%>" required>
                            <option class="auxOption" value="Descontrol Automático" <%if(e.getTitulo().equals("Descontrol Automático")){%>selected<%}%>>Descontrol Automático</option>
                            <option class="auxOption" value="Electroshock" <%if(e.getTitulo().equals("Electroshock")){%>selected<%}%>>Electroshock</option>
                            <option class="auxOption" value="Hormigón Armado" <%if(e.getTitulo().equals("Hormigón Armado")){%>selected<%}%>>Hormigón Armado</option>
                            <option class="auxOption" value="Huascaminas" <%if(e.getTitulo().equals("Huascaminas")){%>selected<%}%>>Huascaminas</option>
                            <option class="auxOption" value="Maphia Cuántica" <%if(e.getTitulo().equals("Maphia Cuántica")){%>selected<%}%>>Maphia Cuántica</option>
                            <option class="auxOption" value="Memoria Caché" <%if(e.getTitulo().equals("Memoria Caché")){%>selected<%}%>>Memoria Caché</option>
                            <option class="auxOption" value="Naranja Mecánica" <%if(e.getTitulo().equals("Naranja Mecánica")){%>selected<%}%>>Naranja Mecánica</option>
                            <option class="auxOption" value="PXO Industrial" <%if(e.getTitulo().equals("PXO Industrial")){%>selected<%}%>>PXO Industrial</option>
                            <option class="auxOption" value="Todos" <%if(e.getTitulo().equals("Todos")){%>selected<%}%>>Todos</option>
                        </select>
                    </div>
                </div>
                <%if(e.isEventoFinalizado()){%>
                <label class="auxLabel" style="margin-top: 25px;" ><b>Resumen: <%if(resumenLargo!=null&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%><a style="color: red;">Ingrese un resumen más corto</a><%}%></b></label>
                <input type="text" id="editarResumenEvento<%=listaEventos.indexOf(e)%>" name="updateResumen" placeholder="Resumen" value="<%=e.getResumen()%>" required>
                <label class="auxLabel" for="resultado" style="margin-top: 25px;" ><b>Resultado:</b></label>
                <select style="padding: 12.5px" name="updateResultado" id="resultado" required>
                    <%if(e.getResultadoEvento().equals("Derrota")){%>
                    <option value="Derrota">Derrota</option>
                    <option value="Victoria">Victoria</option>
                    <%}else{%>
                    <option value="Victoria">Victoria</option>
                    <option value="Derrota">Derrota</option>
                    <%}%>
                </select>
                <p style="width: 100%; margin-top: 25px;"><b>Ocultar evento:</b></p>
                <input type="checkbox" name="updateEventoOcultoAlt" style="width: 30%; position: relative; top: 15px; left: 120px;" <%if(e.isEventoOculto()){%>checked<%}%>>
                <%}else{%>
                <label class="auxLabel" style="margin-top: 25px;" ><b>Frase motivacional: <%if(fraseLarga!=null&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%><a style="color: red;">Ingrese una frase más corta</a><%}%></b></label>
                <input type="text" id="editarFraseMotivacionalEvento<%=listaEventos.indexOf(e)%>" name="updateFraseMotivacional" placeholder="Frase motivacional" value="<%=e.getFraseMotivacional()%>" required>
                <label class="auxLabel" style="margin-top: 25px;"><b>Descripción del evento: <%if(descripcionLarga!=null&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%><a style="color: red;">Ingrese una descripción más corta</a><%}%></b></label>
                <textarea type="text" id="editarDescripcionEvento<%=listaEventos.indexOf(e)%>" name="updateDescripcionEventoActivo" placeholder="Descripción" ><%=e.getDescripcionEventoActivo()%></textarea>
                <div class="row auxLabel" style="margin-top: 25px;">
                    <div class="col-6">
                        <label for="editarHoraEvento<%=listaEventos.indexOf(e)%>"><b>Hora:</b></label>
                        <input style="height: 55px;padding-left: 20px;font-size: 0.875rem;line-height: 1.7142857143em;font-weight: 500;" type="time" id="editarHoraEvento<%=listaEventos.indexOf(e)%>" name="updateHora" value="<%=e.getHora().toString().split(":")[0]+":"+e.getHora().toString().split(":")[1]%>" maxlength="1000" required>
                    </div>
                    <div class="col-6">
                        <label for="editarLugarEvento<%=listaEventos.indexOf(e)%>"><b>Lugar:</b></label>
                        <select style="height: 55px;padding-left: 20px" name="updateLugar" id="editarLugarEvento<%=listaEventos.indexOf(e)%>" required>
                            <%for(LugarEvento l:listaLugares){%>
                            <option value="<%=l.getLugar()%>"><%=l.getLugar()%></option>
                            <%}%>
                        </select>
                    </div>
                </div>
                <div class="row auxLabel" style="margin-top: 25px;">
                    <div class="col-6">
                        <label><b>Fecha (día):</b></label>
                        <input style="height: 55px;padding-left: 20px;font-size: 0.875rem;line-height: 1.7142857143em;font-weight: 500;" type="date" name="updateFecha" multiple id="editarFechaEvento<%=listaEventos.indexOf(e)%>" value="<%=e.getFecha()%>" required>
                    </div>
                    <div class="col-6">
                        <p style="width: 100%;"><b>Ocultar evento:</b></p>
                        <input type="checkbox" name="updateEventoOculto" style="width: 30%; position: relative; top: 15px; left: 60px;" <%if(e.isEventoOculto()){%>checked<%}%>>
                    </div>
                </div>
                <%}%>
            </div> <!-- UWUWUWUWUWUW -->
            <div class="col-sm-5 contenedor2 my-5 d-flex align-items-center">
                <div class="container-fluid btn btn-file1">
                    <div id="contenedorImagenEditar<%=listaEventos.indexOf(e)%>">
                        <img id="imagenActualEditar<%=listaEventos.indexOf(e)%>" style="max-height: 600px" class="img-fluid auxResponsive" src="ImagenEventoServlet?idEvento=<%=e.getIdEvento()%>" alt="">
                    </div>
                    <p style="margin-top: 10px"><b>Editar foto miniatura</b></p>
                    <%if(extensionInvalida!=null&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%><label for="inputEditar<%=listaEventos.indexOf(e)%>"><a style="color: red;">Ingrese un formato e imagen correctos</a></label><%}else if(escalaInvalida!=null&&eventoElegido!=null&&eventoElegido==e.getIdEvento()){%><label for="inputEditar<%=listaEventos.indexOf(e)%>"><a style="color: red;">Ingrese una escala apropiada</a></label><%}%>
                    <input type="file" id="inputEditar<%=listaEventos.indexOf(e)%>" style="background-color: white; margin-top: 25px;" accept="image/png, .jpeg, .jpg" name="updateFotoMiniatura" onchange="mostrarImagen('imagenActualEditar<%=listaEventos.indexOf(e)%>','contenedorImagenEditar<%=listaEventos.indexOf(e)%>','inputEditar<%=listaEventos.indexOf(e)%>')">
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
<%}}}%>

<script>
    function mostrarImagen(idImagen, idImagenContainer, idInputArchivo) {
        var imagenContainer = document.getElementById(idImagenContainer);
        var imagen = document.getElementById(idImagen);
        var inputArchivo = document.getElementById(idInputArchivo);

        if (inputArchivo.files && inputArchivo.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                // Cambiar la imagen por la q recien se subió mediante el input
                imagen.src = e.target.result;
            };
            reader.readAsDataURL(inputArchivo.files[0]);
            imagenContainer.style.display = 'block';
        } else {
            imagenContainer.style.display = 'none';
        }
    }
</script>

<!-- Función para mostrar la imagen antes de enviarla -->
<script type="text/javascript">
    function previewImage(event,idS) {
        var input = event.target;
        var image = document.getElementById(idS);
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                image.src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
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
    <%if(delegadoDeEstaActividadID==idUsuario){%>
    <%if((resumenLargo!=null||descripcionLarga!=null||fraseLarga!=null||extensionInvalida!=null||escalaInvalida!=null)&&eventoElegido==null){%>
    popupFunc('popupCrear',['cerrarPopupCrear','cerrarPopupCrear1','cerrarPopupCrear2'],'overlayCrear');
    <%}%>
    var elementos=['nombreCrearEvento','fraseMotivacionalCrearEvento','descripcionCrearEvento','horaCrearEvento','lugarCrearEvento','fechaCrearEvento','inputCrear'];
    verificarInput(elementos,'cerrarPopupCrear1');
    <%if(listaEventos!=null){
    for(int i=0;i<listaEventos.size();i++){%>
    <%if((resumenLargo!=null||descripcionLarga!=null||fraseLarga!=null||extensionInvalida!=null||escalaInvalida!=null)&&eventoElegido!=null&&eventoElegido==listaEventos.get(i).getIdEvento()){%>
    popupFunc('popupEditarEvento<%=i%>',['cerrarPopupEditarEvento<%=i%>','cerrarPopupEditar1Evento<%=i%>','cerrarPopupEditar2Evento<%=i%>'],'overlayEditarEvento<%=i%>');
    <%}%>
    <%if(listaEventos.get(i).isEventoFinalizado()){%>
    var elementos<%=i%>=['editarNombreEvento<%=i%>','editarResumenEvento<%=i%>'];
    verificarInput(elementos<%=i%>,'cerrarPopupEditar1Evento<%=i%>');
    <%}else{%>
    var elementos<%=i%>=['editarNombreEvento<%=i%>','editarFraseMotivacionalEvento<%=i%>','editarDescripcionEvento<%=i%>','editarHoraEvento<%=i%>','editarLugarEvento<%=i%>','editarFechaEvento<%=i%>'];
    verificarInput(elementos<%=i%>,'cerrarPopupEditar1Evento<%=i%>');
    <%}%>
    <%if(!listaEventos.get(i).isEventoFinalizado()){%>

    var elementosFinalizar<%=i%>=['resultado2Evento<%=i%>','resumenEvento<%=i%>'];
    verificarInput(elementosFinalizar<%=i%>,'cerrarPopupFinalizar1Evento<%=i%>');
    <%}}}}%>
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
<!-- owo -->
</html>