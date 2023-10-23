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
<!-- Page Loader -->


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

     </header>

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

        <div class= "oculto" id="solicitudesContenido">

            <div class="section-filters-bar v1">
                <!-- SECTION FILTERS BAR ACTIONS -->
                <div class="section-filters-bar-actions">
                    <!-- FORM -->
                    <form class="form">
                        <!-- FORM INPUT -->
                        <div class="form-input small with-button">
                            <label for="friends-search">Buscar usuarios</label>
                            <input type="text" id="friends-search" name="friends_search">
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
                            <label for="friends-filter-category">Filter By</label>
                            <select id="friends-filter-category" name="friends_filter_category">
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
                            <p class="user-short-description-title" style="color: rgb(22, 143, 143);">Alex David Segovia Ancajima</p>
                            <!-- /USER SHORT DESCRIPTION TITLE -->

                            <!-- USER SHORT DESCRIPTION TEXT -->
                            <p class="user-short-description-text" style="text-transform: lowercase;">a20213849@pucp.edu.pe</p>
                            <!-- /USER SHORT DESCRIPTION TEXT -->
                        </div>
                        <!-- /USER SHORT DESCRIPTION -->

                        <!-- USER PREVIEW STATS SLIDES -->
                        <div id="user-preview-stats-slides-01" class="user-preview-stats-slides">
                            <!-- USER PREVIEW STATS SLIDE -->
                            <div class="user-preview-stats-slide">

                                <div class="container-fluid">

                                    <div class="row">

                                        <div class="col-sm-6 px-5" style="text-align: center;">

                                            <p style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;" >Código: 20213849</p>

                                        </div>

                                        <div class="col-sm-6 px-5" style="text-align: center;">

                                            <p style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;" >Condición: Estudiante</p>

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
                                        <button class="button-accept">Aceptar</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <button class="button-reject">Rechazar</button>
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
</body>
</html>
