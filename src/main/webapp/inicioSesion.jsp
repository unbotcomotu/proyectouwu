<%--
  Created by IntelliJ IDEA.
  User: Hineill
  Date: 31/10/2023
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String popup=(String) request.getAttribute("popup");%>
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

                                    <div class="col-lg-6 text-right">

                                        <a class="small" href="<%=request.getContextPath()%>/recuperarContrasenaPrimerPaso.jsp">¿Has olvidado tu contraseña?</a>


                                    </div>
                                </div>
                            </form>
                            <div class="row d-grid">
                                <div class="col-lg-12 mt-2">
                                    <div class="text-center" style="font-size: 75%;">
                                        <hr>
                                        ¿Aún no tienes una cuenta?
                                    </div>
                                    <form method="post" action="<%=request.getContextPath()%>/InicioSesionServlet?action=registro"class = "form">
                                        <div class="form-floating my-3">
                                            <label for="miInputRegistro">Correo PUCP</label>
                                            <input type="email" class="form-control button secondary" id="miInputRegistro" name="correoPucp" onkeyup="habilitarBotonRegistro()" placeholder="telito@pucp.edu.pe" required>
                                            <input type="hidden" name="popup" value="1">
                                        </div>

                                    <div class="text-center">
                                        <!-- onclick="mostrarPopup()" todo eso va antes de class paa activar el popup -->
                                        <button  class="btn btn-lg btn-primary btn-login fw-bold mb-2" type="submit" style="background-color: #615dfa;" id="miBotonRegistro"  disabled>Registrarse</button>
                                    </div>
                                        <script>
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
                                    </form>
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
<%if(popup!=null){%>
<div class="overlay" style="display: block" id="overlay">
    <div class="popup" style="display: block;" id="popup">
        <a href="<%= request.getContextPath()%>/InicioSesionServlet">
            <svg class="cerrarPopup" id="cerrarPopup" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M11.4142 10L16.7071 4.70711C17.0976 4.31658 17.0976 3.68342 16.7071 3.29289C16.3166 2.90237 15.6834 2.90237 15.2929 3.29289L10 8.58579L4.70711 3.29289C4.31658 2.90237 3.68342 2.90237 3.29289 3.29289C2.90237 3.68342 2.90237 4.31658 3.29289 4.70711L8.58579 10L3.29289 15.2929C2.90237 15.6834 2.90237 16.3166 3.29289 16.7071C3.68342 17.0976 4.31658 17.0976 4.70711 16.7071L10 11.4142L15.2929 16.7071C15.6834 17.0976 16.3166 17.0976 16.7071 16.7071C17.0976 16.3166 17.0976 15.6834 16.7071 15.2929L11.4142 10Z" fill="black"/>
            </svg>
        </a>

        <p style="font-size: 1.125rem;font-family: 'Titillium Web' !important; font-weight: 500 !important; text-align: center;">
            <%if(popup.equals("1")){%>
            Te hemos enviado un correo electrónico con un link desde el que podrás continuar con el registro
            <%}else if(popup.equals("2")){%>
            Se le ha enviado un correo electrónico con el siguiente paso para la recuperación de su contraseña
            <%}else if(popup.equals("3")){%>
                El correo ingresado ya existe
            <%}else if(popup.equals("4")){%>
                Las credenciales no son correctas
            <%}%>
        </p>
    </div>
</div>
<%}%>
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
</body>
</html>