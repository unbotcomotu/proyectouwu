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

</body>
</html>
