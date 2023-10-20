<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style_aux.css" type="text/css">
    <title>Semana de Ingeniería</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body class="overflow-x-hidden" style="font-size: 150%; font-family: 'Titillium Web',sans-serif;">
<div class="container-fluid">
    <div class="row">
        <div class="col-md-4 col-lg-7 imagen"></div>
        <div class="col-md-8 col-lg-5">
            <div class="login d-flex align-items-center py-5">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-9 mx-auto">
                            <h1 class="login-heading mb-5" style="font-size: 150%">Bienvenido a la Semana de Ingeniería</h1>
                            <div class="text-center my-4"><a class="btn btn-primary" href="ListaDeActividadesServlet?id=u">Vista de Usuario</a></div>
                            <div class="text-center my-4"><a class="btn btn-primary" href="ListaDeActividadesServlet?id=da">Vista de Delegado de Actividad</a></div>
                            <div class="text-center my-4"><a class="btn btn-primary" href="ListaDeActividadesServlet?id=dg">Vista de Delegado General</a></div>
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