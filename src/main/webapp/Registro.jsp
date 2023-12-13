<%@ page import="com.example.proyectouwu.Beans.Validacion" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Santiago
  Date: 24/10/2023
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%Validacion validacion=(Validacion) request.getAttribute("validacion");
String codigoValidacion256=(String) request.getAttribute("codigoValidacion256");
ArrayList<String> listaCorreosDelegadosGenerales=(ArrayList<String>)request.getAttribute("correosDelegadosGenerales");
String nombresVacios=(String) request.getSession().getAttribute("nombresVacios");
    if(nombresVacios!=null){
        request.getSession().removeAttribute("nombresVacios");
    }
    String nombresLargos=(String) request.getSession().getAttribute("nombresLargos");
    if(nombresLargos!=null){
        request.getSession().removeAttribute("nombresLargos");
    }
    String apellidosVacios=(String) request.getSession().getAttribute("apellidosVacios");
    if(apellidosVacios!=null){
        request.getSession().removeAttribute("apellidosVacios");
    }
    String apellidosLargos=(String) request.getSession().getAttribute("apellidosLargos");
    if(apellidosLargos!=null){
        request.getSession().removeAttribute("apellidosLargos");
    }
    String codigoPucpVacio=(String) request.getSession().getAttribute("codigoPucpVacio");
    if(codigoPucpVacio!=null){
        request.getSession().removeAttribute("codigoPucpVacio");
    }
    String codigoPucpInvalido=(String) request.getSession().getAttribute("codigoPucpInvalido");
    if(codigoPucpInvalido!=null){
        request.getSession().removeAttribute("codigoPucpInvalido");
    }
    String codigoPucpNoNumerico=(String) request.getSession().getAttribute("codigoPucpNoNumerico");
    if(codigoPucpNoNumerico!=null){
        request.getSession().removeAttribute("codigoPucpNoNumerico");
    }
    String passwordVacio=(String) request.getSession().getAttribute("passwordVacio");
    if(passwordVacio!=null){
        request.getSession().removeAttribute("passwordVacio");
    }
    String passwordCorto=(String) request.getSession().getAttribute("passwordCorto");
    if(passwordCorto!=null){
        request.getSession().removeAttribute("passwordCorto");
    }
    String password2Vacio=(String) request.getSession().getAttribute("password2Vacio");
    if(password2Vacio!=null){
        request.getSession().removeAttribute("password2Vacio");
    }
    String passwordNoCoincide=(String) request.getSession().getAttribute("passwordNoCoincide");
    if(passwordNoCoincide!=null){
        request.getSession().removeAttribute("passwordNoCoincide");
    }
    String passwordNoValida=(String) request.getSession().getAttribute("passwordNoValida");
    if(passwordNoValida!=null){
        request.getSession().removeAttribute("passwordNoValida");
    }
    String errorRegistro=(String) request.getSession().getAttribute("errorRegistro");
    if(errorRegistro!=null){
        request.getSession().removeAttribute("errorRegistro");
    }
    String condicionNoEscogida=(String) request.getSession().getAttribute("condicionNoEscogida");
    if(condicionNoEscogida!=null){
        request.getSession().removeAttribute("condicionNoEscogida");
    }
%>

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
    <link rel="stylesheet" href="css/vendor/bootstrap.min.css">
    <!-- styles -->
    <link rel="stylesheet" href="css/raw/stylesSanti.css">
    <!-- simplebar styles -->
    <link rel="stylesheet" href="css/vendor/simplebar.css">
    <!-- tiny-slider styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/vendor/tiny-slider.css">
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
            <img class="d-block mx-auto mb-4" src="css/telito.png" alt="" width="50%">
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
                            <label for="firstName" class="form-label texto">Nombres <a style="color: red;"><%if(nombresVacios!=null){%>Ingrese su nombre<%}else if(nombresLargos!=null){%>Ingrese un nombre más corto<%}%></a></label>
                            <input type="text" class="form-control" name = "nombres" id="firstName" placeholder="" value="" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese un nombre.
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <label for="lastName" class="form-label texto">Apellidos <a style="color: red;"><%if(apellidosVacios!=null){%>Ingrese su apellido<%}else if(apellidosLargos!=null){%>Ingrese un apellido más corto<%}%></a></label>
                            <input type="text" class="form-control" id="lastName" name="apellidos" placeholder="" value="" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese sus apellidos.
                            </div>
                        </div>



                        <div class="col-12">
                          <!--for="email", decia eso dentro del label-->  <label class="form-label texto">Código <a style="color: red;"><%if(codigoPucpVacio!=null){%>Ingrese su código PUCP<%}else if(codigoPucpNoNumerico!=null){%>El código PUCP debería de contener solo dígitos<%}else if(codigoPucpInvalido!=null){%>El código PUCP debe contener 8 dígitos<%}%></a></label>
                            <input type="text" class="form-control" name ="codigoPucp" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese un código válido.
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="password" class="form-label texto">Contraseña <a style="color: red;"><%if(passwordVacio!=null){%>Ingrese una contraseña<%}else if(passwordCorto!=null){%>Su contraseña debe de contener al menos 8 caracteres y un número<%}else if(passwordNoCoincide!=null){%>Las contraseñas no coinciden<%}%></a></label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div class="invalid-feedback texto">
                                Por favor ingrese una contraseña válida.
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="password2" class="form-label texto">Repetir Contraseña <a style="color: red;"><%if(password2Vacio!=null){%>Repita su contraseña<%}else if(passwordNoCoincide!=null){%>Las contraseñas no coinciden<%}%></a></label>
                            <input type="password" class="form-control" id="password2" name="password2" required>
                            <div class="invalid-feedback texto" id="password-error">
                                Las contraseñas no coinciden.
                            </div>
                        </div>


                        <div class="mb-3">
                            <input type="hidden" class="form-control" name="idCorreoValidacion" value="<%=validacion.getIdCorreoValidacion()%>">
                            <input type="hidden" class="form-control" name="codigoValidacion256" value="<%=codigoValidacion256%>">
                        </div>

                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="estudiante" name="opciones1" value="Estudiante">
                            <label class="form-check-label texto" for="estudiante">Alumno</label>
                        </div>

                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="egresado" name="opciones2" value="Egresado">
                            <label class="form-check-label texto" for="egresado">Egresado</label>
                        </div>


                        <%if(condicionNoEscogida!=null){%>
                        <a style="color: red;">Seleccione una condición</a>
                        <%}%>
                        <!--<button class="w-100 btn btn-primary btn-lg" type="submit">Continuar</button>-->


                        <button id="continuarButton" class="w-100 btn btn-secondary btn-lg texto" type="submit" style ="background-color: rgb(97,93,250)" disabled> <a style="color: white;" >Continuar</a> </button>
                        <%if(errorRegistro!=null){%>
                        <a class="text-center" style="color: red;font-size: 200%">Ocurrió un error desconocido durante el registro</a>
                        <%}%>

                        <script>
                            const checkboxe = document.querySelectorAll('input[type=checkbox]');
                            const continuarButton = document.getElementById('continuarButton');
                            let i=true;
                            let j=true;
                            document.getElementById("password2").addEventListener("input", function () {
                                var password1 = document.getElementById("password").value;
                                var password2 = document.getElementById("password2").value;
                                var passwordError = document.getElementById("password-error");

                                if (password1 !== password2) {
                                    passwordError.style.display = "block";
                                    i=true;
                                    if(i===true || j===true){
                                        continuarButton.disabled=true;
                                    }

                                } else {
                                    passwordError.style.display = "none";
                                    i=false;
                                    if(i===false && j===false){
                                        continuarButton.disabled=false;
                                    }
                                }
                                console.log(i);
                                console.log(j);
                            });


                            checkboxe.forEach((checkbox) => {
                                checkbox.addEventListener('change', function () {
                                    checkboxe.forEach((otherCheckbox) => {
                                        if (otherCheckbox !== checkbox) {
                                            otherCheckbox.checked = false;
                                        }
                                    });

                                    // Verificar si al menos una casilla está marcada
                                    const algunaMarcada = Array.from(checkboxe).some((checkbox) => checkbox.checked);

                                    // Habilitar o deshabilitar el botón "Continuar" según si hay casillas marcadas
                                    j=!algunaMarcada;
                                    if(i===true || j===true){
                                        continuarButton.disabled=true;
                                    }else {
                                        continuarButton.disabled=false;
                                    }
                                    console.log(i);
                                    console.log(j);
                                });
                            });


                        </script>
                    </div>
                    </form>
                </form>
            </div>
        </div>
    </main>
</div>
<footer style="font-size: 80%; margin-top: 30px">
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
<script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
<script src="form-validation.js"></script>
<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
