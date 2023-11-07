<%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 24/10/2023
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html> <!-- lang="en"  , no se poque estaba eso dentro del html-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>Recuperar contraseña - Siempre Fibra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/checkout/">

    <link rel="stylesheet" href="css/styles_aux.css">

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
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
            padding: 30px;
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

    </style>


    <!-- Custom styles for this template -->
    <link href="form-validation.css" rel="stylesheet">
</head>
<body>

<div class="container">


    <div class="py-5 text-center">
        <img class="d-block mx-auto mb-4" src="css/telito.png" alt="" width="50%" height="50%">
        <h2 class="texto"> RECUPERACIÓN DE CONTRASEÑA</h2>
        <!--<p class="lead">Bienvenido y gracias por animarte a participar de la semana de ingeniería. Ahora solo necesitas crear una cuenta regirtrando tus datos</p>-->
    </div>
<form  method = "post" action="<%=request.getContextPath()%>/RecuperarContrasenaPrimerPasoServlet?action=correoRecuperarContrasena" class="form">

    <div class="mb-5 col-12">
        <label for="email" class="form-label texto">Ingrese su correo electrónico</label>
        <input type="email" class="form-control" name = "correoPucp" id="email" placeholder="EjemploASeguir@pucp.edu.pe" required>
        <div class="invalid-feedback texto">
            Por favor ingrese un correo electrónico válido.
        </div>
    </div>

    <button id="continuarButton" class=  "w-100 btn btn-primary btn-lg texto mb-3" type="submit" style ="background-color: rgb(97,93,250)" disabled><a id="abrirPopup">Continuar</a></button>
</form>

    <button><a href="<%=request.getContextPath()%>/InicioSesionServlet">Atrás</a></button>


    <!---"w-100 btn btn-primary btn-lg texto"-->

    <script>
        // Obtén una referencia al campo de entrada de correo electrónico y al botón Continuar
        const emailInput = document.getElementById("email");
        const continuarButton = document.getElementById("continuarButton");

        // Agrega un evento de escucha para el evento "input" en el campo de entrada de correo electrónico
        emailInput.addEventListener("input", function () {
            // Verifica si el valor del campo de entrada es un correo electrónico válido
            if (isValidEmail(emailInput.value)) {
                // Habilita el botón Continuar si el correo electrónico es válido
                continuarButton.removeAttribute("disabled");
            } else {
                // Deshabilita el botón Continuar si el correo electrónico no es válido
                continuarButton.setAttribute("disabled", "true");
            }
        });

        // Función para verificar si una cadena es un correo electrónico válido (simplificado)
        function isValidEmail(email) {
            // Puedes implementar una lógica más sofisticada para verificar correos electrónicos válidos aquí
            // Esta es una verificación simple para demostración
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailPattern.test(email);
        }
    </script>




        </form>
    </div>
    </div>
</main>

<footer class="my-5 pt-5 text-muted text-center text-small">
    <p class="mb-1">&copy; 2023 PUCP</p>
    <!--<ul class="list-inline">
      <li class="list-inline-item"><a href="#">Privacy</a></li>
      <li class="list-inline-item"><a href="#">Terms</a></li>
      <li class="list-inline-item"><a href="#">Support</a></li>
    </ul>-->
</footer>
</div>
<div class="overlay" id="overlay">
    <div class="popup" id="popup">
        <a href="<%= request.getContextPath()%>/InicioSesionServlet">
            <svg class="cerrarPopup" id="cerrarPopup" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
            </svg>
        </a>

        <p style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 500 !important; text-align: center;">Se le ha enviado un correo electrónico con el siguiente paso para la recuperación de su contraseña.</p>
    </div>

</div>
<script>

    function popupFunc(popupId,abrirId,cerrarId){
        const showPopup=document.getElementById(abrirId);
        const overlay=document.getElementById('overlay');
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
    popupFunc('popup','abrirPopup','cerrarPopup');




    function goBack() {
        window.history.back();
    }
</script>
<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

<script src="form-validation.js"></script>

</body>
</html>
