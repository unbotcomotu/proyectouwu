<%--
  Created by IntelliJ IDEA.
  User: Hineill
  Date: 31/10/2023
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style_aux.css" type="text/css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <title>Inicio de sesión - Siempre Fibra</title>
</head>

<body class="overflow-x-hidden" style="font-size: 150%; font-family: 'Titillium Web',sans-serif;">
<div class="container-fluid">
    <div class="row g-0">
        <div class="col-md-4 col-lg-7 imagen"></div>
        <div class="col-md-8 col-lg-5">
            <div class="login d-flex align-items-center py-5">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-9 mx-auto">
                            <h1 class="login-heading mb-4" style="font-size: 150%">Bienvenido a la Semana de Ingeniería</h1>
                            <form method="post" action="<%=request.getContextPath()%>/InicioSesionServlet?action=logIn" class="form">
                                <div class="form-floating mb-3">
                                    <label for="miInputInicioSesion">Correo PUCP</label>
                                    <input type="email" class="form-control" id="miInputInicioSesion" name="correoPucp" onkeyup="habilitarBotonInicioSesion()" placeholder="telito@pucp.edu.pe" required>
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingPassword">Contraseña</label>
                                    <input type="password" class="form-control" id="floatingPassword" name = "contrasena" placeholder="Contraseña" required>
                                </div>
                                <div class="row d-grid">
                                    <div class="col-lg-6 text-left">
                                        <button class="btn btn-lg btn-primary btn-login fw-bold mb-2" style="background-color: #615dfa" id="miBotonInicioSesion" type="submit" disabled>Iniciar sesión</button>
                                    </div>
                            </form>
                                    <div class="col-lg-6 text-right">
                                        <a class="small" href="<%=request.getContextPath()%>/InicioSesionServlet?action=recuperarContrasena">¿Has olvidado tu contraseña?</a>
                                    </div>
                                </div>

                            <div class="row d-grid">
                                <div class="col-lg-12 mt-2">
                                    <div class="text-center" style="font-size: 75%;">
                                        <hr>
                                        ¿Aún no tienes una cuenta?
                                    </div>
                                    <form method="post" action="<%=request.getContextPath()%>/InicioSesionServlet?action=signUp" class="form">
                                    <div class="form-floating my-3">
                                        <label for="miInputRegistro">Correo PUCP</label>
                                        <input type="email" class="form-control button secondary" id="miInputRegistro" name="correoPucp" onkeyup="habilitarBotonRegistro()" placeholder="telito@pucp.edu.pe" required>
                                    </div>
                                        </form>
                                    <div class="text-center">
                                        <button onclick="mostrarPopup()" class="btn btn-lg btn-primary btn-login fw-bold mb-2" style="background-color: #615dfa;" id="miBotonRegistro" disabled>Registrarse</button>
                                        <!-- Overlay de fondo oscuro -->
                                        <div class="overlay" id="overlay"></div>
                                        <!-- Contenido del popup -->
                                        <div class="popup" id="popup">
                                            <span class="close-button" onclick="cerrarPopup()">&#10005;</span>
                                            <div>
                                                Te hemos enviado un correo electrónico con un link desde el que podrás continuar con el registro
                                            </div>
                                            <script>
                                                // Función para mostrar el popup
                                                function mostrarPopup() {
                                                    document.getElementById("miBotonRegistro").disabled=true;
                                                    document.getElementById("overlay").style.display = "block";
                                                    document.getElementById("popup").style.display = "block";
                                                }
                                                // Función para cerrar el popup
                                                function cerrarPopup() {
                                                    document.getElementById("overlay").style.display = "none";
                                                    document.getElementById("popup").style.display = "none";
                                                }
                                                // Función para habilitar el boton de Inicio de Sesión
                                                function habilitarBotonInicioSesion() {
                                                    var input = document.getElementById("miInputInicioSesion");
                                                    var boton = document.getElementById("miBotonInicioSesion");

                                                    if (input.checkValidity() && input.value.endsWith("@pucp.edu.pe")) { // Verificar el campo de entrada
                                                        boton.disabled = false; // Habilitar el botón
                                                    } else {
                                                        boton.disabled = true; // Deshabilitar el botón
                                                    }
                                                }
                                                // Función para habilitar el boton de Registro
                                                function habilitarBotonRegistro() {
                                                    var input = document.getElementById("miInputRegistro");
                                                    var boton = document.getElementById("miBotonRegistro");

                                                    if (input.checkValidity() && input.value.endsWith("@pucp.edu.pe")) { // Verificar el campo de entrada
                                                        boton.disabled = false; // Habilitar el botón
                                                    } else {
                                                        boton.disabled = true; // Deshabilitar el botón
                                                    }
                                                }
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <footer class="my-1 pt-4 text-muted text-center text-small" style="font-size: 70%;">
                                <p>&copy; 2023 Fibra Tóxica</p>
                            </footer>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
