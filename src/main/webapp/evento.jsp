<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.*" %>
<%@ page import="com.example.proyectouwu.Daos.*" %>
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
        Evento e=(Evento)request.getAttribute("evento");
        String actividadEvento=(String)request.getAttribute("actividad");
        String estadoApoyo=(String)request.getAttribute("estadoApoyoAlumnoEvento");
        String lugar=(String)request.getAttribute("lugar");
        ArrayList<Integer>cantidadApoyos=(ArrayList<Integer>) request.getAttribute("cantidadApoyos");
        Integer solicitudesApoyoPendientes=(Integer) request.getAttribute("solicitudesApoyoPendientes");
        int delegadoDeEstaActividadID=(Integer) request.getAttribute("delegadoDeEstaActividadID");
        String servletActual="EventoServlet";
        ArrayList<NotificacionDelegadoGeneral>listaNotificacionesCampanita=(ArrayList<NotificacionDelegadoGeneral>) request.getAttribute("listaNotificacionesCampanita");
        ArrayList<AlumnoPorEvento>listaNotificacionesDelegadoDeActividad=(ArrayList<AlumnoPorEvento>) request.getAttribute("listaNotificacionesDelegadoDeActividad");
        String colorRol;
        String reporteLargo=(String) request.getSession().getAttribute("reporteLargo");
        if(reporteLargo!=null){
            request.getSession().removeAttribute("reporteLargo");
        }
        if(rolUsuario.equals("Alumno")){
            colorRol="";
        }else if(rolUsuario.equals("Delegado de Actividad")){
            colorRol="green";
        }else{
            colorRol="orange";
        }

        ArrayList<MensajeChat>listaDeMensajes=(ArrayList<MensajeChat>) request.getAttribute("listaDeMensajes");
        String mensajeLargo=(String) request.getSession().getAttribute("mensajeLargo");
        if(mensajeLargo!=null){
            request.getSession().removeAttribute("mensajeLargo");
        }
        String abrirChat=(String) request.getSession().getAttribute("abrirChat");
        if(abrirChat!=null){
            request.getSession().removeAttribute("abrirChat");
        }
        ArrayList<String>extensionInvalida=new ArrayList<>();
        ArrayList<String>escalaInvalida=new ArrayList<>();
        //asumiendo 3 imágenes por carrusel
        for(int i=0;i<3;i++){
            extensionInvalida.add((String) request.getSession().getAttribute("extensionInvalida"+(i+1)));
            if(extensionInvalida.get(i)!=null){
                request.getSession().removeAttribute("extensionInvalida"+(i+1));
            }
            escalaInvalida.add((String) request.getSession().getAttribute("escalaInvalida"+(i+1)));
            if(escalaInvalida.get(i)!=null){
                request.getSession().removeAttribute("escalaInvalida"+(i+1));
            }
        }
        String mensaje=(String) request.getAttribute("mensaje");
    %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- bootstrap 4.3.1 -->
    <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
    <!-- styles -->
    <link rel="stylesheet" href="css/raw/styles.css">
    <!-- favicon -->
    <link rel="icon" href="img/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>Actividades - Siempre Fibra</title>
    <style>
        [data-simplebar] {
            position: relative;
            flex-direction: column;
            flex-wrap: wrap;
            justify-content: flex-start;
            align-content: flex-start;
            align-items: flex-start;
        }

        .simplebar-wrapper {
            overflow: hidden;
            width: inherit;
            height: inherit;
            max-width: inherit;
            max-height: inherit;
        }

        .simplebar-mask {
            direction: inherit;
            position: absolute;
            overflow: hidden;
            padding: 0;
            margin: 0;
            left: 0;
            top: 0;
            bottom: 0;
            right: 0;
            width: auto !important;
            height: auto !important;
            z-index: 0;
        }

        .simplebar-offset {
            direction: inherit !important;
            box-sizing: inherit !important;
            resize: none !important;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            padding: 0;
            margin: 0;
            -webkit-overflow-scrolling: touch;
        }

        .simplebar-content-wrapper {
            direction: inherit;
            box-sizing: border-box !important;
            position: relative;
            display: block;
            height: 100%; /* Required for horizontal native scrollbar to not appear if parent is taller than natural height */
            width: auto;
            /* visibility: visible; */
            max-width: 100%; /* Not required for horizontal scroll to trigger */
            max-height: 100%; /* Needed for vertical scroll to trigger */
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        .simplebar-content-wrapper::-webkit-scrollbar,
        .simplebar-hide-scrollbar::-webkit-scrollbar {
            width: 0;
            height: 0;
        }

        .simplebar-content:before,
        .simplebar-content:after {
            content: ' ';
            display: table;
        }

        .simplebar-placeholder {
            max-height: 100%;
            max-width: 100%;
            width: 100%;
            pointer-events: none;
        }

        .simplebar-height-auto-observer-wrapper {
            box-sizing: inherit !important;
            height: 100%;
            width: 100%;
            max-width: 1px;
            position: relative;
            float: left;
            max-height: 1px;
            overflow: hidden;
            z-index: -1;
            padding: 0;
            margin: 0;
            pointer-events: none;
            flex-grow: inherit;
            flex-shrink: 0;
            flex-basis: 0;
        }

        .simplebar-height-auto-observer {
            box-sizing: inherit;
            display: block;
            opacity: 0;
            position: absolute;
            top: 0;
            left: 0;
            height: 1000%;
            width: 1000%;
            min-height: 1px;
            min-width: 1px;
            overflow: hidden;
            pointer-events: none;
            z-index: -1;
        }

        .simplebar-track {
            z-index: 1;
            position: absolute;
            right: 0;
            bottom: 0;
            pointer-events: none;
            overflow: hidden;
        }

        [data-simplebar].simplebar-dragging .simplebar-content {
            pointer-events: none;
            user-select: none;
            -webkit-user-select: none;
        }

        [data-simplebar].simplebar-dragging .simplebar-track {
            pointer-events: all;
        }

        .simplebar-scrollbar {
            position: absolute;
            right: 2px;
            width: 4px;
            min-height: 10px;
        }

        .simplebar-scrollbar:before {
            position: absolute;
            content: '';
            background: #adafca;
            border-radius: 7px;
            left: 0;
            right: 0;
            opacity: 0;
            transition: opacity 0.2s linear;
        }

        .simplebar-scrollbar.simplebar-visible:before {
            /* When hovered, remove all transitions from drag handle */
            opacity: .4;
            transition: opacity 0s linear;
        }

        .simplebar-track.simplebar-vertical {
            top: 0;
            width: 11px;
        }

        .simplebar-track.simplebar-vertical .simplebar-scrollbar:before {
            top: 2px;
            bottom: 2px;
        }

        .simplebar-track.simplebar-horizontal {
            left: 0;
            height: 11px;
        }

        .simplebar-track.simplebar-horizontal .simplebar-scrollbar:before {
            height: 100%;
            left: 2px;
            right: 2px;
        }

        .simplebar-track.simplebar-horizontal .simplebar-scrollbar {
            right: auto;
            left: 0;
            top: 2px;
            height: 7px;
            min-height: 0;
            min-width: 10px;
            width: auto;
        }

        /* Rtl support */
        [data-simplebar-direction='rtl'] .simplebar-track.simplebar-vertical {
            right: auto;
            left: 0;
        }

        .hs-dummy-scrollbar-size {
            direction: rtl;
            position: fixed;
            opacity: 0;
            visibility: hidden;
            height: 500px;
            width: 500px;
            overflow-y: hidden;
            overflow-x: scroll;
        }

        .simplebar-hide-scrollbar {
            position: fixed;
            left: 0;
            visibility: hidden;
            overflow-y: scroll;
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        /*--------------------
            CUSTOM STYLES
        --------------------*/
        [data-simplebar].navigation-widget {
            position: fixed;
        }

        [data-simplebar].navigation-widget .simplebar-scrollbar {
            right: 4px;
        }
    </style>
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
                            <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
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
                        <form id="notificacionLeidaCampanita<%=listaNotificacionesCampanita.indexOf(noti)%>" method="post" action="PaginaNoExisteServlet?action=notificacionLeidaCampanita">
                            <input type="hidden" name="idNotificacion" value="<%=noti.getIdNotificacion()%>">
                            <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
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
                                    <p class="user-status-title"><a class="bold"><%=r.getUsuarioReportado().getNombre()%> <%=r.getUsuarioReportado().getApellido()%></a> ha sido <a class="highlighted">reportado</a> por el delegado de actividad <a class="bold" style="color: #491217;"><%=r.getUsuarioQueReporta().getNombre()%> <%=r.getUsuarioQueReporta().getApellido()%></a></p>
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

<!-- CHAT WIDGET -->
<aside id="chat-widget-messages" class="chat-widget <%if(mensajeLargo==null&&abrirChat==null){%>closed<%}%> sidebar right">
    <!-- CHAT WIDGET MESSAGES -->
    <div class="chat-widget-messages" data-simplebar>
        <!-- CHAT WIDGET CONVERSATION -->
        <div class="chat-widget-conversation" id="chat" data-simplebar>
            <%if(listaDeMensajes.isEmpty()){%>
            <a style="color: #6c757d;text-align: center">Ningún mensaje por aquí <br> ¡Sé quien inicie la conversación!</a>
            <%}else for(int i=0;i<listaDeMensajes.size();i++){
            if(listaDeMensajes.get(i).getUsuario().getIdUsuario()!=usuarioActual.getIdUsuario()){%>
            <!-- CHAT WIDGET SPEAKER -->
            <div class="chat-widget-speaker left">
                <!-- CHAT WIDGET SPEAKER AVATAR -->
                <div class="chat-widget-speaker-avatar">
                    <!-- USER AVATAR -->
                    <div class="user-avatar tiny no-border">
                        <!-- USER AVATAR CONTENT -->
                        <div class="user-avatar-content">
                            <!-- HEXAGON -->
                            <%request.getSession().setAttribute("fotoMensaje"+i,listaDeMensajes.get(i).getUsuario().getFotoPerfil());%>
                            <div class="hexagon-image-24-26" data-src="Imagen?tipoDeFoto=fotoPerfil&id=Mensaje<%=i%>"></div>
                            <!-- /HEXAGON -->
                        </div>
                        <!-- /USER AVATAR CONTENT -->
                    </div>
                    <!-- /USER AVATAR -->
                </div>
                <!-- /CHAT WIDGET SPEAKER AVATAR -->
                <%String rolUsuarioMensaje=new DaoUsuario().rolUsuarioPorId(listaDeMensajes.get(i).getUsuario().getIdUsuario());
                    String tipoDeApoyo=new DaoAlumnoPorEvento().verificarApoyo(e.getIdEvento(),listaDeMensajes.get(i).getUsuario().getIdUsuario());%>
                <!-- CHAT WIDGET SPEAKER MESSAGE -->
                <p class="chat-widget-speaker-timestamp"><%=listaDeMensajes.get(i).getUsuario().getNombre()%> <%=listaDeMensajes.get(i).getUsuario().getApellido()%> - <%if(new DaoEvento().verificarDelegadoDeActividadPorIdEvento(listaDeMensajes.get(i).getUsuario().getIdUsuario(),e.getIdEvento())){%><a style="color: green">D. Actividad</a><%}else if(rolUsuarioMensaje.equals("Delegado General")){%><a style="color: orange;">D. General</a><%}else if(tipoDeApoyo!=null&&tipoDeApoyo.equals("Pendiente")){%><a style="color: steelblue;">Apoyo</a><%}else{%><a>Alumno</a><%}%></p>
                <p class="chat-widget-speaker-message"><%=listaDeMensajes.get(i).getMensaje()%></p>
                <%while(true){
                    if(i+1<listaDeMensajes.size()&&listaDeMensajes.get(i).getUsuario().getIdUsuario()==listaDeMensajes.get(i+1).getUsuario().getIdUsuario()){
                        i++;%>
                <p class="chat-widget-speaker-message"><%=listaDeMensajes.get(i).getMensaje()%></p>
                <%}else{
                    break;
                }}%>
                <!-- /CHAT WIDGET SPEAKER MESSAGE -->
                <%Integer diferenciaFechasChat[]=new DaoEvento().obtenerDiferenciaEntre2FechasMensaje(listaDeMensajes.get(i).getIdMensajeChat());
                    if(diferenciaFechasChat[0]>1){%>
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;"><%=listaDeMensajes.get(i).getFecha()%> a las <%=listaDeMensajes.get(i).getHora()%></p>
                <%}else if(diferenciaFechasChat[0]==1){%>
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Ayer a las <%=listaDeMensajes.get(i).getHora()%> <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <%}else if(diferenciaFechasChat[1]>0){
                    if(diferenciaFechasChat[1]==1){%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace 1 hora <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace <%=diferenciaFechasChat[1]%> horas <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}%>
                <%}else if(diferenciaFechasChat[2]>0){
                    if(diferenciaFechasChat[2]==1){%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace 1 minuto <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace <%=diferenciaFechasChat[2]%> minutos <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}%>
                <%}else if(diferenciaFechasChat[3]>=0){
                    if(diferenciaFechasChat[3]==0){%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Ahora mismo <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace <%=diferenciaFechasChat[3]%> segundos <%if(idUsuario==delegadoDeEstaActividadID&&!rolUsuarioMensaje.equals("Delegado General")){%><a id="mostrarPopupReportar<%=i%>" class="chat-widget-speaker-timestamp" style="color: red;cursor: pointer">Reportar</a><%}%></p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}}%>
            </div>
            <!-- /CHAT WIDGET SPEAKER -->
            <%}else{%>
            <!-- CHAT WIDGET SPEAKER -->
            <div class="chat-widget-speaker right">
                <!-- CHAT WIDGET SPEAKER MESSAGE -->
                <p class="chat-widget-speaker-message"><%=listaDeMensajes.get(i).getMensaje()%></p>
                <%while(true){
                    if(i+1<listaDeMensajes.size()&&listaDeMensajes.get(i).getUsuario().getIdUsuario()==listaDeMensajes.get(i+1).getUsuario().getIdUsuario()){
                        i++;%>
                <p class="chat-widget-speaker-message"><%=listaDeMensajes.get(i).getMensaje()%></p>
                <%}else{
                    break;
                }}%>
                <!-- /CHAT WIDGET SPEAKER MESSAGE -->
                <%Integer diferenciaFechasChat[]=new DaoEvento().obtenerDiferenciaEntre2FechasMensaje(listaDeMensajes.get(i).getIdMensajeChat());
                    if(diferenciaFechasChat[0]>1){%>
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;"><%=listaDeMensajes.get(i).getFecha()%> a las <%=listaDeMensajes.get(i).getHora()%></p>
                <%}else if(diferenciaFechasChat[0]==1){%>
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Ayer a las <%=listaDeMensajes.get(i).getHora()%></p>
                <%}else if(diferenciaFechasChat[1]>0){
                    if(diferenciaFechasChat[1]==1){%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace 1 hora</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace <%=diferenciaFechasChat[1]%> horas</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}%>
                <%}else if(diferenciaFechasChat[2]>0){
                    if(diferenciaFechasChat[2]==1){%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace 1 minuto</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace <%=diferenciaFechasChat[2]%> minutos</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}%>
                <%}else if(diferenciaFechasChat[3]>0){
                    if(diferenciaFechasChat[3]==1){%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace 1 segundo</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Hace <%=diferenciaFechasChat[3]%> segundos</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}%>
                <%}else{%>
                <!-- USER STATUS TIMESTAMP -->
                <p class="chat-widget-speaker-timestamp" style="font-size: 60%;">Ahora mismo</p>
                <!-- /USER STATUS TIMESTAMP -->
                <%}%>
            </div>
            <!-- /CHAT WIDGET SPEAKER -->
            <%}%>
            <br>
            <%}%>
        </div>
        <!-- /CHAT WIDGET CONVERSATION -->
        <!-- /CHAT WIDGET HEADER -->
    </div>
    <!-- CHAT WIDGET HEADER -->



    <!-- CHAT WIDGET FORM -->
    <form method="post" action="?action=enviarMensaje" class="chat-widget-form">
        <!-- INTERACTIVE INPUT -->
        <div class="interactive-input small">
            <input id="escribirMensaje" type="text" name="mensaje" placeholder="Escribe un mensaje..." <%if(mensaje!=null){%>value="<%=mensaje%>"<%}%>>
            <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
            <!-- INTERACTIVE INPUT ICON WRAP -->
            <button type="submit" style="background: none;border:0;color: inherit" class="interactive-input-icon-wrap">
                <!-- INTERACTIVE INPUT ICON -->
                <svg class="interactive-input-icon icon-send-message">
                    <use xlink:href="#svg-send-message"></use>
                </svg>
                <!-- /INTERACTIVE INPUT ICON -->
            </button>
            <!-- /INTERACTIVE INPUT ICON WRAP -->
            <!-- INTERACTIVE INPUT ACTION -->
            <div class="interactive-input-action">
                <!-- INTERACTIVE INPUT ACTION ICON -->
                <svg class="interactive-input-action-icon icon-cross-thin">
                    <use xlink:href="#svg-cross-thin"></use>
                </svg>
                <!-- /INTERACTIVE INPUT ACTION ICON -->
            </div>
            <!-- /INTERACTIVE INPUT ACTION -->
        </div>
        <!-- /INTERACTIVE INPUT -->
        <%if(mensajeLargo!=null){%><a style="color: red;">Escriba un mensaje más corto</a><%}%>
    </form>
    <!-- /CHAT WIDGET FORM -->



    <!-- CHAT WIDGET BUTTON -->
    <div class="chat-widget-button">
        <!-- CHAT WIDGET BUTTON ICON -->
        <div class="chat-widget-button-icon">
            <img src="css/chatWhiteIcon.png" width="28px" alt="">
        </div>
        <!-- /CHAT WIDGET BUTTON ICON -->

        <!-- CHAT WIDGET BUTTON TEXT -->
        <p class="chat-widget-button-text" style="font-size: 140%;">Foro del evento</p>
        <!-- /CHAT WIDGET BUTTON TEXT -->
    </div>
    <!-- /CHAT WIDGET BUTTON -->
</aside>
<!-- /CHAT WIDGET -->

<!-- CONTENT GRID -->
<div class="content-grid">
    <div class="section-banner" style="padding: 0 0 0 0 !important;">
        <!-- SECTION BANNER ICON -->
        <%DaoActividad daoActividad = new DaoActividad(); Actividad actividad = daoActividad.listarActividades(actividadEvento).get(0);%>
        <%request.getSession().setAttribute("fotoActividadCabecera"+actividad.getIdActividad(),actividad.getFotoCabecera());%>

        <div class="section-banner" style="background: url('Imagen?tipoDeFoto=fotoActividadCabecera&id=ActividadCabecera<%=actividad.getIdActividad()%>') no-repeat left !important;background-size: 15% 100% !important;height: 100% !important;">
            <!-- SECTION BANNER TITLE -->
            <p class="section-banner-title">Fibra Tóxica VS <%=e.getTitulo()%></p>
            <!-- /SECTION BANNER TITLE -->
            <!-- SECTION BANNER TEXT -->
            <p class="section-banner-text "><%=actividadEvento%></p>
            <!-- /SECTION BANNER TEXT -->
        </div>

    </div>
    <!-- GRID -->
    <div class="grid grid-3-9">
        <!-- GRID COLUMN -->
        <div class="grid-column">
            <form method="get" action="<%=request.getContextPath()%>/ListaDeEventosServlet">
                <input type="hidden" name="idActividad" value="<%=actividad.getIdActividad()%>">
                <button class="btn-primary py-2" type="submit" style="background-color: #23d2e2; font-size: 120% !important;">Regresar a la lista de eventos</button>
            </form>

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
                    <%if(e.isEventoFinalizado()){%>
                    <!-- USER STATS -->
                    <div class="user-stats">
                        <!-- USER STAT -->
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <img src="css/solicitudesPendientes.png" width="50%">
                            <!-- /USER STAT TITLE -->
                            <p class="user-stat-text" style="font-size: 100%;"><%=cantidadApoyos.get(0)+cantidadApoyos.get(1)%></p>
                            <!-- USER STAT TEXT -->
                            <p class="user-stat-text" style="font-size: 100%;">Total de apoyos</p>
                            <!-- /USER STAT TEXT -->
                        </div>
                        <!-- /USER STAT -->
                    </div>
                    <!-- /USER STATS -->
                    <%}else{%>
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
                    <%}%>
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
                    <%if(!e.isEventoFinalizado()){%>
                    <form method="post" action="<%=request.getContextPath()%>/EventoServlet?action=apoyoEvento">
                        <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
                        <button style="background: transparent;height: 0px" type="submit"><a class="button small twitch" style="color: white;">Apoyar al evento</a></button>
                    </form>
                    <%}else{%>
                    <button style="background: transparent;height: 0px" type="button"><a class="button small twitch" style="color: white;opacity: 0.5">Evento finalizado</a></button>
                    <%}%>
                    <!-- BUTTON -->
                    <!-- /BUTTON -->
                </div>
                <%}else{%>
                <div class="streamer-box-info">
                    <!-- STREAMER BOX TITLE -->
                    <p class="streamer-box-title" style="font-size: 150%;">GRACIAS POR APOYAR</p>
                    <!-- /STREAMER BOX TITLE -->
                    <%if(estadoApoyo.equals("Pendiente")){%>
                    <!-- STREAMER BOX STATUS -->
                    <p class="mt-4" style="font-size: 150%">¡Espere hasta que el delegado de actividad revise tu solicitud y te asigne a pertenecer a la barra a al equipo!</p>
                    <!-- /STREAMER BOX STATUS -->
                    <div class="user-stats">
                        <div class="user-stat">
                            <!-- USER STAT TITLE -->
                            <img src="css/esperarSolicitud.png" width="100%">
                            <!-- /USER STAT TITLE -->
                        </div>
                    </div>
                    <%}else{%>
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
                    <%}%>
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
                <%ArrayList<Blob>carrusel=e.getCarruselFotos();%>
                <div class="carousel">
                    <div class="carousel-inner">
                        <%for(int i=0;i<carrusel.size();i++){%>
                        <div class="carousel-item <%if(i==0){%>active<%}%>">
                            <%request.getSession().setAttribute("fotoCarrusel"+i,carrusel.get(i));%>
                            <img class="img-fluid" src="Imagen?tipoDeFoto=fotoCarrusel&id=Carrusel<%=i%>" alt="Imagen <%=i+1%>" style="max-width: 1092px; max-height: 560px">
                        </div>
                        <%}%>
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
                <%if(delegadoDeEstaActividadID==idUsuario){%>
                <div style="position: relative;bottom: 75px;height: 0;width: 0">
                    <img src="css/ajustesEvento.png" id="mostrarPopupImagenes" style="cursor: pointer;" width="75px" alt="">
                </div>
                <%}%>
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
                <%if(e.isEventoFinalizado()){%>
                <!-- STREAM BOX INFO -->
                <div class="stream-box-info">
                    <%if(e.getResultadoEvento().equals("Victoria")){%>
                    <!-- STREAM BOX TITLE -->
                    <p class="stream-box-title" style="color: green;font-size: 300%">Victoria</p>
                    <!-- /STREAM BOX TITLE -->
                    <!-- STREAM BOX CATEGORY -->
                    <p class="stream-box-category mt-3"><%=e.getResumen()%></p>
                    <!-- /STREAM BOX CATEGORY -->
                    <!-- STREAM BOX VIEWS -->
                    <p class="stream-box-views">¡La fibra adelante!</p>
                    <!-- /STREAM BOX VIEWS -->
                    <%}else if(e.getResultadoEvento().equals("Derrota")){%>
                    <!-- STREAM BOX TITLE -->
                    <p class="stream-box-title" style="color: red;font-size: 300%">Derrota</p>
                    <!-- /STREAM BOX TITLE -->
                    <!-- STREAM BOX CATEGORY -->
                    <p class="stream-box-category mt-3"><%=e.getResumen()%></p>
                    <!-- /STREAM BOX CATEGORY -->
                    <!-- STREAM BOX VIEWS -->
                    <p class="stream-box-views">¡En las buenas y en las malas con la Fibra!</p>
                    <!-- /STREAM BOX VIEWS -->
                    <%}%>
                </div>
                <!-- /STREAM BOX INFO -->
                <%}else{%>
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
                <%}%>
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
<%if(!rolUsuario.equals("Delegado General")&&delegadoDeEstaActividadID!=idUsuario){%>
<div class="overlay" id="overlayApoyar">
    <div class="popup" id="popupApoyar">
        <svg class="cerrarPopup" id="cerrarPopupApoyar" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
        </svg>
        <p style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 500 !important; text-align: center;">Se ha enviado al Delegado de Actividad una solicitud para apoyar.</p>
    </div>
</div>
<%}if(delegadoDeEstaActividadID==idUsuario){
boolean extensionInvalidaAux=false;
for(String ex:extensionInvalida){if(ex!=null){extensionInvalidaAux=true;}}
boolean escalaInvalidaAux=false;
for(String es:escalaInvalida){if(es!=null){escalaInvalidaAux=true;}}%>
<div class="overlay" id="overlayEditarImagenes" <%if(extensionInvalidaAux||escalaInvalidaAux){%>style="display: block!important;"<%}%>></div>
<div class="popup" style="max-width: 100%;width: 80%!important;<%if(extensionInvalidaAux||escalaInvalidaAux){%>display: block!important<%}%>" id="popupImagenes">
    <form method="post" action="EventoServlet?action=editarCarrusel" enctype='multipart/form-data'>
    <svg class="cerrarPopup" id="cerrarPopupImagenes" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
        <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
        <div class="row d-flex align-items-center justify-content-center">
            <%for(int i=0;i<carrusel.size();i++){%>
            <div onclick="activarSeleccion('inputImagen<%=i+1%>')" id="containerImagen<%=i+1%>" class="col-sm-4 text-center">
                <div id="auxBorrar<%=i+1%>" class="bloque-izquierda btn-file1 d-flex align-items-center justify-content-center" style="position: absolute;">
                    <a style="font-size: 200%; cursor: pointer;">Cambiar</a>
                    <input id="inputImagen<%=i+1%>" type="file" onchange="mostrarImagen('imagen<%=i+1%>','containerImagen<%=i+1%>','inputImagen<%=i+1%>')" name="foto<%=i+1%>" style="display: none;" accept="image/png, .jpeg, .jpg">
                </div>
                <%request.getSession().setAttribute("fotoCarrusel"+(i+3),carrusel.get(i));%>
                <input id="borrar<%=i+1%>" type="hidden" name="borrar<%=i+1%>" value="0">
                <a onclick="borrarImagen(['imagen<%=i+1%>','inputImagen<%=i+1%>','borrarImagen<%=i+1%>','auxBorrar<%=i+1%>'],'imagenBorrar<%=i+1%>','borrar<%=i+1%>')" class="bloque-derecha d-flex align-items-center justify-content-center" id="borrarImagen<%=i+1%>" style="font-size: 200%; cursor: pointer;">Borrar</a>
                <img id="imagenBorrar<%=i+1%>" src="/css/imagenBorrada.png" style="display: none;max-height: 600px" alt="">
                <img src="Imagen?tipoDeFoto=fotoCarrusel&id=Carrusel<%=i+3%>" style="max-height: 600px" id="imagen<%=i+1%>" width="100%" height="auto">
                <%if(extensionInvalida.get(i)!=null){%><a class="text-center" style="color: red">Ingrese un formato e imagen correctos</a><%}else if(escalaInvalida.get(i)!=null){%><a class="text-center" style="color: red;">Ingrese una escala apropiada</a><%}%>
            </div>
            <%}%>
        </div>

    <div class="row d-flex justify-content-center" style="margin-top: 10px;">
        <div class="col-sm-6" style="margin-top: 5px;">
            <button type="submit" class="button secondary" id="cerrarPopupImagenes1">Confirmar cambios</button>
        </div>
        <div class="col-sm-6" style="margin-top: 5px;">
            <button type="button" class="button secondary" id="cerrarPopupImagenes2" style="background-color: grey;">Cancelar</button>
        </div>
    </div>
    </form>
</div>
<%}%>
<%for(int i=0;i<listaDeMensajes.size();i++){
    while(true){
        if(i+1<listaDeMensajes.size()&&listaDeMensajes.get(i).getUsuario().getIdUsuario()==listaDeMensajes.get(i+1).getUsuario().getIdUsuario()){
            i++;
        }else{
            break;
        }
    }
    String rolUsuarioMensaje=new DaoUsuario().rolUsuarioPorId(listaDeMensajes.get(i).getUsuario().getIdUsuario());
    if(rolUsuario.equals("Delegado de Actividad")&&!rolUsuarioMensaje.equals("Delegado General")&&listaDeMensajes.get(i).getUsuario().getIdUsuario()!=usuarioActual.getIdUsuario()){%>
<div class="overlay" <%if(reporteLargo!=null){%>style="display: block"<%}%> id="overlayReportar<%=i%>"></div>
<div class="popup" style="width: 50%;<%if(reporteLargo!=null){%>display: block<%}%>" id="popupReportar<%=i%>">
    <svg class="cerrar-btn" id="cerrarPopupReportar<%=i%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
    </svg>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <h5 style="text-align: center;">Escribe el motivo de reporte al usuario: <%if(reporteLargo!=null){%><a style="color: red;">Ingrese un motivo más corto</a><%}%></h5>
            </div>
            <div class="col-sm-1"></div>
        </div>
    </div>
    <br>
    <form method="post" action="?action=reportar">
        <div class="row">
            <div class="col-sm-1">
            </div>
            <div class="col-sm-10">
                <textarea name="motivoReporte" cols="15" rows="6"></textarea>
            </div>
            <div class="col-sm-1">
            </div>
        </div>
        <div style="margin-top: 3%" class="container-fluid">
            <div class="row">
                <div class="col-sm-6" style="margin-top: 5px;">
                    <input type="hidden" name="idEvento" value="<%=e.getIdEvento()%>">
                    <input type="hidden" name="idUsuarioReportado" value="<%=listaDeMensajes.get(i).getUsuario().getIdUsuario()%>">
                    <a> <button type="submit" class="button secondary" id="cerrarPopupReportar1<%=i%>">Reportar</button></a>
                </div>
                <div class="col-sm-6" style="margin-top: 5px;">
                    <button type="button" class="button secondary" id="cerrarPopupReportar2<%=i%>" style="background-color: grey;">Cancelar</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%}}%>
<script>
    function activarSeleccion(idInput) {
        // Simular un clic en el input de tipo "file"
        document.getElementById(idInput).click();
    }
    function borrarImagen(IDsBorrar,idImagenBorrada,idParametroExtra){
        var imagenBorrada = document.getElementById(idImagenBorrada);
        imagenBorrada.style.display='block';
        var parametroExtra=document.getElementById(idParametroExtra);
        parametroExtra.value='1';
        for(let i=0;i<IDsBorrar.length;i++){
            let aux=document.getElementById(IDsBorrar[i]);
            aux.style.display='none';
            aux.disabled=true;
        }
    }

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
    function enviarFormulario(idForm) {
        var formulario = document.getElementById(idForm);
        formulario.submit();
    }
    function chatAux(){
        bajarScrollChat();
        document.getElementById('escribirMensaje').focus();
    }

    window.onload = function() {
        chatAux();
    };
    const bajarScrollChat = function (){
        var elementosConClase = document.getElementsByClassName('simplebar-content-wrapper');
        console.log(elementosConClase);
        if (elementosConClase.length > 0) {
            var miDiv = elementosConClase[elementosConClase.length-2];
            miDiv.scrollTop = miDiv.scrollHeight;
            miDiv=elementosConClase[elementosConClase.length-3];
            miDiv.scrollTop = miDiv.scrollHeight;
        }
    }
    var miDiv = document.getElementById('chat-widget-messages');
    var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (!miDiv.classList.contains('closed')) {
                setTimeout(function (){
                    chatAux();
                },10);
            }
        });
    });
    var config = { attributes: true, attributeFilter: ['class'] };
    observer.observe(miDiv, config);
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
    <%if(!(rolUsuario.equals("Delegado General")||delegadoDeEstaActividadID==idUsuario)){%>
    popupFunc('popupApoyar','mostrarPopupApoyar',['cerrarPopupApoyar'],'overlayApoyar');
    <%}if(delegadoDeEstaActividadID==idUsuario){%>
    popupFunc('popupImagenes','mostrarPopupImagenes',['cerrarPopupImagenes','cerrarPopupImagenes1','cerrarPopupImagenes2'],'overlayEditarImagenes');
    <%}%>
    <%for(int i=0;i<listaDeMensajes.size();i++){
     while(true){
            if(i+1<listaDeMensajes.size()&&listaDeMensajes.get(i).getUsuario().getIdUsuario()==listaDeMensajes.get(i+1).getUsuario().getIdUsuario()){
                i++;
            }else{
                break;
            }
        }
    String rolUsuarioMensaje=new DaoUsuario().rolUsuarioPorId(listaDeMensajes.get(i).getUsuario().getIdUsuario());
    if(rolUsuario.equals("Delegado de Actividad")&&!rolUsuarioMensaje.equals("Delegado General")&&listaDeMensajes.get(i).getUsuario().getIdUsuario()!=usuarioActual.getIdUsuario()){%>
    popupFunc('popupReportar<%=i%>','mostrarPopupReportar<%=i%>',['cerrarPopupReportar<%=i%>','cerrarPopupReportar1<%=i%>','cerrarPopupReportar2<%=i%>'],'overlayReportar<%=i%>');
    <%}}%>
</script>
<!-- app -->
<script src="js/utils/app.js"></script>
<!-- page loader -->
<script src="js/utils/page-loader.js"></script>
<!-- simplebar -->
<script src="js/vendor/simplebar.js"></script>
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