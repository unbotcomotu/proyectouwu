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
             //Debemos guardarlo en algun lado para mandar el correo - cumplido
              //Solo se envia correo si es que este existe en la base de datos de usuarios - cumplido
              //Se debe ajustar la velocidad del salto del popUp para que el usuario tenga tiempo de ver el aviso - no cumplido
             DaoValidacion daoValidacion = new DaoValidacion();
              if(new DaoUsuario().obtenerIdPorCorreo(correo2) != 0) {
                  daoValidacion.agregarCorreoParaRecuperarContrasena(correo2);
                  response.sendRedirect(request.getContextPath() + "/InicioSesionServlet");
              }//else{ salga un mensaje de error en la vista} - no cumplido
             break;
       }
    }
}

