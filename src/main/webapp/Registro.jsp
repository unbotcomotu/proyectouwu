<%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 24/10/2023
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="validacion" type="com.example.proyectouwu.Beans.Validacion" scope="request" />


<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>Registro - Siempre Fibra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/checkout/">

    <link rel="stylesheet" href="css/styles_aux.css">

    <!-- Bootstrap core CSS -->
    <link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
<body>
<div class="container">
    <main>
        <div class="py-5 text-center">
            <img class="d-block mx-auto mb-4" src="css/telito.png" alt="" width="50%" height="50%">
            <h2 class = "mb-4 texto">SEMANA DE INGENIERÍA </h2>
            <p class="lead texto">Bienvenido y gracias por animarte a participar de la semana de ingeniería. Ahora solo necesitas crear una cuenta registrando tus datos</p>
        </div>

        <div class="row g-5 ">
            <div class="col-md-8 offset-md-2">
                <h4 class="mb-3 texto">Registro</h4>
                <form method = "post" class="form" action="<%=request.getContextPath()%>/RegistroServlet?action=registro">
                    <form class="needs-validation" novalidate>

                    <div class="row g-3">

                        <div class="col-sm-6">
                            <label for="firstName" class="form-label texto">Nombres</label>
                            <input type="text" class="form-control" name = "nombres" id="firstName" placeholder="" value="" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese un nombre.
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <label for="lastName" class="form-label texto">Apellidos</label>
                            <input type="text" class="form-control" id="lastName" name="apellidos" placeholder="" value="" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese sus apellidos.
                            </div>
                        </div>



                        <div class="col-12">
                          <!--for="email", decia eso dentro del label-->  <label class="form-label texto">Código <span class="text-muted"></span></label>
                            <input type="text" class="form-control" name ="codigoPucp" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese un código válido.
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="password" class="form-label texto">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese una contraseña válida.
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="password2" class="form-label texto">Repetir Contraseña</label>
                            <input type="password" class="form-control" id="password2" name="password2" required>
                            <div class="invalid-feedback texto" id="password-error">
                                Las contraseñas no coinciden.
                            </div>
                        </div>


                        <div class="mb-3">
                            <input type="hidden" class="form-control" name="idCorreoValidacion" value="<%=validacion.getIdCorreoValidacion()%>">
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


                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="estudiante" name="opciones" value="Estudiante">
                            <label class="form-check-label texto" for="estudiante">Alumno</label>
                        </div>

                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="egresado" name="opciones" value="Egresado">
                            <label class="form-check-label texto" for="egresado">Egresado</label>
                        </div>


                        <script>
                            const checkboxes = document.querySelectorAll('input[name="opciones"]');
                            checkboxes.forEach((checkbox) => {
                                checkbox.addEventListener('change', function () {
                                    checkboxes.forEach((otherCheckbox) => {
                                        if (otherCheckbox !== checkbox) {
                                            otherCheckbox.checked = false;
                                        }
                                    });
                                });
                            });
                        </script>

                        <!--<button class="w-100 btn btn-primary btn-lg" type="submit">Continuar</button>-->


                        <button id="continuarButton" class="w-100 btn btn-secondary btn-lg texto" type="submit" style ="background-color: rgb(97,93,250)" disabled> <a style="color: white;" >Continuar</a> </button>

                        <button onclick="goBack()">Atrás</button>


                        <script>
                            const checkboxe = document.querySelectorAll('input[name="opciones"]');
                            const continuarButton = document.getElementById('continuarButton');

                            checkboxe.forEach((checkbox) => {
                                checkbox.addEventListener('change', function () {
                                    checkboxe.forEach((otherCheckbox) => {
                                        if (otherCheckbox !== checkbox) {
                                            otherCheckbox.checked = false;
                                        }
                                    });

                                    // Verificar si al menos una casilla está marcada
                                    const algunaMarcada = Array.from(checkboxes).some((checkbox) => checkbox.checked);

                                    // Habilitar o deshabilitar el botón "Continuar" según si hay casillas marcadas
                                    continuarButton.disabled = !algunaMarcada;
                                });
                            });
                        </script>
                    </div>
                    </form>
                </form>
            </div>
        </div>
    </main>

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
