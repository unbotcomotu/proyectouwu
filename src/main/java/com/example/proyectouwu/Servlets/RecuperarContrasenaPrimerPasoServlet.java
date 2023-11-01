package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RecuperarContrasenaPrimerPasoServlet", value = "/RecuperarContrasenaPrimerPasoServlet")
public class RecuperarContrasenaPrimerPasoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.setContentType("text/html");

       String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
       switch (action){
          case "default":
             break;
          case "correoRecuperarContrasena":
             String correo2 = request.getParameter("correoPucp");
             //Debemos guardarlo en algun lado para mandar el correo
             DaoValidacion daoValidacion = new DaoValidacion();
             daoValidacion.agregarCorreoParaRecuperarContrasena(correo2);
             response.sendRedirect(request.getContextPath() + "/InicioSesionServlet");
             break;
       }
    }
}

