<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 9/12/2023
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="css/murcielago.ico">
    <title>Inicio</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
        }

        .carrusel {
            position: relative;
            width: 100%;
            height: 100vh;
            overflow: hidden;
        }

        .imagen {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-position: center center;
            background-size: cover;
            transition: opacity 1s ease-in-out;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);
            opacity: 0; /* Inicialmente oculta todas las imágenes */
        }

        .imagen.active {
            opacity: 1;
        }

        .imagen::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.636); /* Fondo oscuro */
        }

        .ov-btn-container {
            position: absolute;
            text-align: center;
            width: 100%;
            top: 50%;
            transform: translateY(-50%);
        }

        .ov-btn-slide-left {
            background: #14030357; /* color de fondo */
            color: #4642be; /* color de fuente */
            border: 2px solid #4741d7; /* tamaño y color de borde */
            padding: 16px 20px;
            border-radius: 3px; /* redondear bordes */
            position: relative;
            z-index: 1;
            overflow: hidden;
            display: inline-block;
            text-decoration: none; /* Quita el subrayado */
            transition: color 0.35s, background 0.35s;
        }

        .ov-btn-slide-left:hover {
            color: #fdfdfd; /* color de fuente hover */
            background: #4741d7; /* color de fondo hover */
        }

        .ov-btn-slide-left::after {
            content: "";
            background: #4741d7; /* color de fondo hover */
            position: absolute;
            z-index: -1;
            padding: 16px 20px;
            display: block;
            top: 0;
            bottom: 0;
            left: -100%;
            right: 100%;
            transition: all 0.35s;
        }

        .ov-btn-slide-left:hover::after {
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }
    </style>
</head>
<body>
<div class="carrusel">
    <div class="imagen active" style="background-image: url('images/fibra10.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra2.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra3.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra4.jpeg');">
    </div>

    <div class="imagen" style="background-image: url('images/fibra6.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra7.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra8.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra9.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra5.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra10.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra11.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra12.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra13.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra14.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra15.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra16.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra17.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra18.jpeg');">
    </div>
    <div class="imagen" style="background-image: url('images/fibra19.jpeg');">
    </div>
    <div class="ov-btn-container">
        <a href="<%=request.getContextPath()%>/InicioSesionServlet" class="ov-btn-slide-left"> INICIAR </a>
    </div>
</div>

<script>
    function iniciar() {
        alert('¡Inicio!');
    }
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var imagenes = document.querySelectorAll(".imagen");
        var index = 0;
        function cambiarImagen() {
            imagenes[index].classList.remove("active");
            index = (index + 1) % imagenes.length;
            imagenes[index].classList.add("active");
        }
        setInterval(cambiarImagen, 5000);
    });
</script>
</body>
</html>