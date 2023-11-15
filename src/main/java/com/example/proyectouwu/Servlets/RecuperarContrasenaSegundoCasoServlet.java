
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
                String idCorreoValidacion = request.getParameter("idCorreoValidacion");
                String codigoValidacion256 = request.getParameter("codigoValidacion256");
                try{
                    if(codigoValidacion256.equals(new DaoValidacion().codigoValidacion256PorID(Integer.parseInt(idCorreoValidacion)))){
                        request.setAttribute("idCorreoValidacion",Integer.parseInt(idCorreoValidacion));
                        RequestDispatcher rd = request.getRequestDispatcher("recuperarContrasenaPaso2.jsp");
                        //Se manda a la vista con un parametro id que lo reconocerá más adelante
                        rd.forward(request,response);
                    }else{
                        response.sendRedirect("InicioSesionServlet");
                    }
                }catch (NumberFormatException e){
                    response.sendRedirect("InicioSesionServlet");
                }
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
                new DaoUsuario().actualizarContrasena(Integer.parseInt(idCorreoValidacion),password);
                response.sendRedirect(request.getContextPath());
                //else{ salga un mensaje de error en la vista} - no cumplido
                break;
        }
    }
}
