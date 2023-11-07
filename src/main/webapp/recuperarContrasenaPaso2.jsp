<%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 24/10/2023
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<% int idCorreoValidacion =(int) request.getAttribute("idCorreoValidacion"); %>
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
    <link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">

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
    </style>


    <!-- Custom styles for this template -->
    <link href="form-validation.css" rel="stylesheet">
</head>
<body> <!--class="bg-light", no se porque dice eso-->
<div class="container">
<form method  = "post" action="<%=request.getContextPath()%>/RecuperarContrasenaSegundoCasoServlet?action=correoRecuperarContrasenaSegundoPaso" >
    <div class="py-5 text-center">
        <img class="d-block mx-auto mb-4" src="css/telito.png" alt="" width="50%" height="50%">
        <h2 class="texto"> RECUPERACIÓN DE CONTRASEÑA</h2>
        <!--<p class="lead">Bienvenido y gracias por animarte a participar de la semana de ingeniería. Ahora solo necesitas crear una cuenta regirtrando tus datos</p>-->
    </div>

    <div class="mb-3">
        <input type="hidden" class="form-control" name="idCorreoValidacion" value="<%=idCorreoValidacion%>">
    </div>


    <div class="mb-3 col-12">
        <label for="password" class="form-label texto">Ingrese su nueva contraseña</label>
        <input type="password" class="form-control" id="password" name="password" required>
        <div class="invalid-feedback texto" >
            Por favor ingrese una contraseña válida.
        </div>
    </div>

    <div class="mb-4 col-12">
        <label for="password2" class="form-label texto">Repetir Contraseña</label>
        <input type="password" class="form-control" id="password2" name="password2" required>
        <div class="invalid-feedback texto" id="password-error">
            Las contraseñas no coinciden.

        </div>
    </div>

    <script>
        document.getElementById("password2").addEventListener("input", function () {
            var password1 = document.getElementById("password").value;
            var password2 = document.getElementById("password2").value;
            var passwordError = document.getElementById("password-error");

            if (password1 !== password2) {
                passwordError.style.display = "block";
                continuarButton.disabled=true;

            } else {
                passwordError.style.display = "none";
                continuarButton.disabled=false;
            }
        });
    </script>





    <button id="continuarButton" class="w-100 btn btn-secondary btn-lg texto mb-3" type="submit" style ="background-color: rgb(97,93,250)" disabled>Aceptar</button>


    </form>
</div>
</div>


<footer class="my-5 pt-5 text-muted text-center text-small">
    <p class="mb-1">&copy; 2023 PUCP</p>
    <!--<ul class="list-inline">
      <li class="list-inline-item"><a href="#">Privacy</a></li>
      <li class="list-inline-item"><a href="#">Terms</a></li>
      <li class="list-inline-item"><a href="#">Support</a></li>
    </ul>-->
</footer>
</div>


<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

<script src="form-validation.js"></script>

<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
