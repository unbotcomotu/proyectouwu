<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyectouwu.Beans.Usuario" %>
<%@ page import="com.example.proyectouwu.Daos.DaoBan" %>
<%@ page import="com.example.proyectouwu.Daos.DaoUsuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%int idUsuario=(int) request.getAttribute("idUsuario");
    String rolUsuario=(String) request.getAttribute("rolUsuario");
    String nombreCompletoUsuario=(String) request.getAttribute("nombreCompletoUsuario");
    ArrayList<Usuario>listaUsuarios=(ArrayList<Usuario>) request.getAttribute("listaUsuarios");
    String vistaActual=(String) request.getAttribute("vistaActual");
    ArrayList<String> listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
  %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <!-- bootstrap 4.3.1 -->
  <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
  <!-- styles -->
  <link rel="stylesheet" href="css/raw/stylesAlex2.css">
  <!-- simplebar styles -->
  <link rel="stylesheet" href="css/vendor/simplebar.css">
  <!-- tiny-slider styles -->
  <link rel="stylesheet" href="css/vendor/tiny-slider.css">
  <!-- favicon -->
  <link rel="icon" href="img/favicon.ico">
  <title>Usuarios - Siempre Fibra</title>
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
      background-color: white;
      padding: 20px;
      z-index: 10001;
    }

    /* Estilo para el botón de cerrar */
    .cerrar-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      cursor: pointer;
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
    <!-- /MENU ITEM -->
    <li class="menu-item <%if(vistaActual.equals("listaDeActividades")){%>active<%}%>">
      <!-- MENU ITEM LINK -->
      <a class="menu-item-link text-tooltip-tfr" href="<%=request.getContextPath()%>/ListaDeActividadesServlet?idUsuario=<%=idUsuario%>" data-title="Actividades">
        <!-- MENU ITEM LINK ICON -->
        <img src="css/actividadIconoGris.png" class="menu-item-link-icon icon-members" alt="">
        <!-- /MENU ITEM LINK ICON -->
      </a>
      <!-- /MENU ITEM LINK -->
    </li>
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
    <!-- /MENU ITEM -->
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
    <p class="user-short-description-text"><a style="color: orange"><%=rolUsuario%></a></p>
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
      <img src="css/actividadIconoGris.png" width="7%" alt="">
      <!-- /MENU ITEM LINK ICON -->
      Actividades
    </a>
    <!-- /MENU ITEM LINK -->
  </li>
  <!-- /MENU ITEM -->
  <br>
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
      <p class="navigation-widget-info-text" style="color: orange;"><%=rolUsuario%></p>
      <!-- /NAVIGATION WIDGET INFO TEXT -->
    </div>
    <!-- /NAVIGATION WIDGET INFO -->

    <!-- NAVIGATION WIDGET BUTTON -->
    <a href="<%=request.getContextPath()%>" class="navigation-widget-info-button button small secondary">Cerrar sesión</a>
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
    <p class="navigation-widget-section-title">Funciones de rol</p>
    <!-- /NAVIGATION WIDGET SECTION TITLE -->

    <!-- NAVIGATION WIDGET SECTION LINK -->
    <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/ListaDeActividadesServlet?idUsuario=<%=idUsuario%>">Actividades</a>
    <!-- /NAVIGATION WIDGET SECTION LINK -->

    <!-- NAVIGATION WIDGET SECTION LINK -->
    <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/AnaliticasServlet?idUsuario=<%=idUsuario%>">Analíticas</a>
    <!-- /NAVIGATION WIDGET SECTION LINK -->

    <!-- NAVIGATION WIDGET SECTION LINK -->
    <a class="navigation-widget-section-link" href="<%=request.getContextPath()%>/ListaDeUsuariosServlet?idUsuario=<%=idUsuario%>">Usuarios</a>
    <!-- /NAVIGATION WIDGET SECTION LINK -->
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

  <!-- HEADER ACTIONS -->
  <div class="header-actions">

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

      <!-- PROGRESS STAT BAR -->
      <!-- /PROGRESS STAT BAR -->
    </div>
    <!-- /PROGRESS STAT -->
  </div>
  <!-- /HEADER ACTIONS -->

  <!-- NO BORRAR ESTO-->

  <!-- HEADER ACTIONS -->
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
        <a href="<%=request.getContextPath()%>/inicioSesion.jsp"><img src="css/logOut.png" width="30%" style="margin-left: 25px;" alt=""></a>
        <!-- /ACTION ITEM ICON -->
      </div>
      <!-- /ACTION ITEM -->

      <!-- DROPDOWN NAVIGATION -->

    </div>
    <!-- /ACTION ITEM WRAP -->
  </div>
  <!-- /HEADER ACTIONS -->
</header>
<!-- /HEADER -->


<!-- CONTENT GRID -->
<div class="content-grid">
  <!-- SECTION BANNER -->
  <div class="section-banner">
    <!-- SECTION BANNER ICON -->
    <img class="section-banner-icon" src="css/telitoNerd.png" width="14%" alt="">
    <!-- /SECTION BANNER ICON -->

    <!-- SECTION BANNER TITLE -->
    <p class="section-banner-title">Usuarios</p>
    <!-- /SECTION BANNER TITLE -->

    <!-- SECTION BANNER TEXT -->
    <p class="section-banner-text">Aquí puedes encontrar toda la información sobre los usuarios registrados en la plataforma</p>
    <!-- /SECTION BANNER TEXT -->
  </div>
  <!-- /SECTION BANNER -->

  <!-- SECTION FILTERS BAR -->
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
            <label for="items-search">Buscar usuario</label>
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
            <label for="items-filter-category">Filtrar por</label>
            <select id="items-filter-category" name="items_filter_category">
              <option value="0">Orden alfabético</option>
              <option value="1">Código PUCP</option>
              <option value="2">Condición</option>
              <option value="3">Baneado</option>
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
            <label for="items-filter-order">Ordenar por</label>
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
  <div class="grid grid-4-4-4 centered">
    <%int k=0;%>
    <% for(Usuario usuario: listaUsuarios) { %>

    <!-- USER PREVIEW -->
    <div class="user-preview">
      <!-- USER PREVIEW COVER -->
      <figure class="user-preview-cover liquid" style="background: no-repeat linear-gradient(to right,#094293,#615dfa);"></figure>
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
              <div class="hexagon-image-82-90" data-src="css/sin_foto_De_perfil.png"></div>
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
          <p class="user-short-description-title"><%=usuario.getNombre() + " " + usuario.getApellido()%></p>
          <!-- /USER SHORT DESCRIPTION TITLE -->

          <!-- USER SHORT DESCRIPTION TEXT -->
          <% if(new DaoUsuario().usuarioEsDelegadoDeActividad(usuario.getIdUsuario())){ %>
          <p class="user-short-description-text"><%=usuario.getRol() + ": " + new DaoUsuario().obtenerDelegaturaPorId(usuario.getIdUsuario())%></p>
          <%}else{%>
          <p class="user-short-description-text"><%=usuario.getRol()%></p>
          <%}%>
          <!-- /USER SHORT DESCRIPTION TEXT -->
        </div>
        <!-- /USER SHORT DESCRIPTION -->

        <!-- USER PREVIEW STATS SLIDES -->
        <div id="user-preview-stats-slides-<%if(listaUsuarios.indexOf(usuario)<9){%>0<%=listaUsuarios.indexOf(usuario)+1%><%}else{%><%=listaUsuarios.indexOf(usuario)+1%><%}%>" class="user-preview-stats-slides">
          <!-- USER PREVIEW STATS SLIDE -->
          <div class="container-fluid">
            <!-- USER STATS -->
            <div class="row">
              <!-- USER STAT -->
              <div class="col-sm-6 text-center ms-5 px-5" style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;">
                <!-- USER STAT TITLE -->
                <p>Código: <%=usuario.getCodigoPUCP()%></p>
                <!-- /USER STAT TITLE -->
              </div>
              <!-- /USER STAT -->
              <!-- USER STAT -->
              <div class="col-sm-6 text-center px-5" style="font-family: 'Rajdhani', sans-serif; text-transform: uppercase; font-weight: 700; font-size: 0.875rem;">
                <!-- USER STAT TITLE -->
                <p>Condición: <%=usuario.getCondicion()%></p>
                <!-- /USER STAT TITLE -->
              </div>
              <!-- /USER STAT -->
            </div>
            <!-- /USER STATS -->
          </div>
          <!-- /USER PREVIEW STATS SLIDE -->

          <!-- USER PREVIEW STATS SLIDE -->
          <div class="user-preview-stats-slide">
            <!-- USER PREVIEW TEXT -->
            <%if(new DaoBan().usuarioBaneadoPorId(usuario.getIdUsuario())){%>
            <p class="user-preview-text">Este usuario ha sido baneado debido a que <%=new DaoBan().obtenerMotivoBanPorId(usuario.getIdUsuario()).toLowerCase()%></p>
            <%}else{%>
            <p class="user-preview-text"><%=usuario.getDescripcionPerfil()%></p>
            <%}%>
            <!-- /USER PREVIEW TEXT -->
          </div>
          <!-- /USER PREVIEW STATS SLIDE -->
        </div>
        <!-- /USER PREVIEW STATS SLIDES -->

        <!-- USER PREVIEW STATS ROSTER -->
        <div id="user-preview-stats-roster-<%if(listaUsuarios.indexOf(usuario)<9){%>0<%=listaUsuarios.indexOf(usuario)+1%><%}else{%><%=listaUsuarios.indexOf(usuario)+1%><%}%>" class="user-preview-stats-roster slider-roster">
          <!-- SLIDER ROSTER ITEM -->
          <div class="slider-roster-item"></div>
          <!-- /SLIDER ROSTER ITEM -->

          <!-- SLIDER ROSTER ITEM -->
          <div class="slider-roster-item"></div>
          <!-- /SLIDER ROSTER ITEM -->
        </div>
        <!-- /USER PREVIEW STATS ROSTER -->

        <!-- USER PREVIEW ACTIONS -->
        <div class="user-preview-actions">
          <!-- BUTTON -->
          <%if(new DaoBan().usuarioBaneadoPorId(usuario.getIdUsuario())){%>
          <button class="button secondary" id="boton" style="background-color: #615dfa; opacity: 60%;">Baneado</button>
          <%}else{%>
          <button class="button secondary" id="mostrarPopup<%=k%>">Banear</button>
          <%k++;}%>
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
  <p class="section-results-text">Mostrando 4 de 282 usuarios</p>
  <!-- /SECTION RESULTS TEXT -->
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
<%int l = 0;
  for(Usuario u : listaUsuarios){if(new DaoUsuario().estaBaneadoporId(u.getIdUsuario())){%>
<div class="overlay" id="overlay<%=l%>"></div>
<div class="popup" id="popup<%=l%>">
  <svg class="cerrar-btn" id="cerrar-btn<%=l%>" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
  </svg>
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-1"></div>
      <div class="col-sm-10">
        <h5 style="text-align: center;">¿Estás seguro de banear a este usuario?</h5>
      </div>
      <div class="col-sm-1"></div>
    </div>
  </div>
  <br>
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-6" style="margin-top: 5px;">
        <form method="post" action="<%=request.getContextPath()%>/ListaDeUsuariosServlet?action=banear">
          <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
          <input type="hidden" name="idUsuarioABanear" value="<%=u.getIdUsuario()%>">
          <a> <button type="submit" class="button secondary" id="cerrarPopup1<%=l%>">Banear</button></a>
        </form>
      </div>
      <div class="col-sm-6" style="margin-top: 5px;">
        <button class="button secondary" id="cerrarPopup2<%=l%>" style="background-color: grey;">Cancelar</button>
      </div>
    </div>
  </div>
</div>

<%l++;}}%>

<script>
  function popupFunc(popup,overlay,mostrar,cerrar){
    const mostrarPopupBtn = document.getElementById(mostrar);
    const overlayConst = document.getElementById(overlay);
    const popupConst = document.getElementById(popup);
    const mostrarPopup = () => {
      overlayConst.style.display = 'block';
      popupConst.style.display = 'block';
      // Desactivar el scroll
      document.body.style.overflow = 'hidden';
    };
    mostrarPopupBtn.addEventListener('click', mostrarPopup);
    // Función para cerrar el popup
    const cerrarPopup = () => {
      overlayConst.style.display = 'none';
      popupConst.style.display = 'none';
      // Reactivar el scroll
      document.body.style.overflow = 'auto';
    };
    for(let i=0;i<cerrar.length;i++){
      document.getElementById(cerrar[i]).addEventListener('click', cerrarPopup);
    }
    overlayConst.addEventListener('click', (e) => {
      if (e.target === overlayConst) {
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
  <%for(int i=0;i<listaUsuarios.size();i++){%>
  popupFunc('popup<%=i%>','overlay<%=i%>','mostrarPopup<%=i%>',['cerrar-btn<%=i%>','cerrarPopup1<%=i%>','cerrarPopup2<%=i%>']);
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
</body>
</html>
