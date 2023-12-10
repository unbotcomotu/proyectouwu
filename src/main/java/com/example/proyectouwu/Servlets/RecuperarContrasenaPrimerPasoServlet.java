package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RecuperarContrasenaPrimerPasoServlet", value = "/RecuperarContrasenaPrimerPasoServlet")
public class RecuperarContrasenaPrimerPasoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("recuperarContrasenaPrimerPaso.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.setContentType("text/html");
       String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
       switch (action){
          default:
          case "default":
             break;
          case "correoRecuperarContrasena":
             String correo2 = request.getParameter("correoPucp");
             if(correo2!=null){
                 DaoValidacion daoValidacion = new DaoValidacion();
                 if(new DaoUsuario().obtenerIdPorCorreo(correo2) != 0) {
                     daoValidacion.agregarCorreoParaRecuperarContrasena(correo2);
                     request.getSession().setAttribute("popup","2");
                     response.sendRedirect("InicioSesionServlet");
                 }else{
                     request.getSession().setAttribute("correoNoExiste","1");
                     response.sendRedirect("RecuperarContrasenaPrimerPasoServlet");
                 }
             }else {
                 response.sendRedirect(request.getContextPath());
             }
              break;
       }
    }
}

