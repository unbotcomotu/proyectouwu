
package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RecuperarContrasenaSegundoCasoServlet", value = "/RecuperarContrasenaSegundoCasoServlet")
public class RecuperarContrasenaSegundoCasoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action) {
            case "default":
//                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                Integer idCorreoValidacion = Integer.parseInt(request.getParameter("idCorreoValidacion"));
                Integer codigoValidacion = Integer.parseInt(request.getParameter("codigoValidacion"));
                //Nos aseguramos de que exista dicha persona y que su idCorreoValidacion le corresponda a su codigo de validacion
                if(idCorreoValidacion == new DaoValidacion().getIdPorcodigoValidacion(codigoValidacion) ){
                    request.setAttribute("idCorreoValidacion",idCorreoValidacion);
                    RequestDispatcher rd = request.getRequestDispatcher("recuperarContrasenaPaso2.jsp");
                    //Se manda a la vista con un parametro id que lo reconocerá más adelante
                    rd.forward(request,response);
                }//else { Mandar una vista q muestre error de autenticación}
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                break;
            case "correoRecuperarContrasenaSegundoPaso":
                String idCorreoValidacion = request.getParameter("idCorreoValidacion");
                String password = request.getParameter("password");
                //Actualizar contrasena
                DaoValidacion daoValidacion = new DaoValidacion();
                if(new DaoUsuario().obtenerIdPorCorreo(correo2) != 0) {
                    daoValidacion.agregarCorreoParaRecuperarContrasena(correo2);
                    response.sendRedirect(request.getContextPath() + "/InicioSesionServlet");
                }//else{ salga un mensaje de error en la vista} - no cumplido
                break;
        }
    }
}
