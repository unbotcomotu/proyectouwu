<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="donacion" type="com.example.proyectouwu.Beans.Donacion" scope="request" />
<%int idUsuario=(int) request.getAttribute("idUsuario");%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous">
    <title>Editar un trabajo</title>
</head>
<body>
<div class='container'>
    <h1 class='mb-3'>Editar</h1>
    <form method="post" action="<%=request.getContextPath()%>/NotificacionesServlet?action=edit">
        <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
        <div class="mb-3">
            <input type="hidden" class="form-control" name="idDonacion" value="<%=donacion.getIdDonacion()%>">
        </div>
        <div class="mb-3">
            <label>Monto</label>
            <input type="text" class="form-control" name="montoDonacion" value="<%=donacion.getMonto()%>">
        </div>
        <div class="mb-3">
            <label>Estato de la donación</label>
            <input type="text" class="form-control" name="estadoDonacion" value="<%=donacion.getEstadoDonacion()%>">
        </div>
        <a href="<%=request.getContextPath()%>/NotificacionesServlet" class="btn btn-danger">Regresar</a>
        <button type="submit" class="btn btn-primary">Confirmar</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>
