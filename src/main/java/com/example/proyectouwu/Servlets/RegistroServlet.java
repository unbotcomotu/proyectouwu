package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Beans.Validacion;
import com.example.proyectouwu.Daos.DaoAlumnoPorEvento;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.ZonedDateTime;
import java.util.Date;

@WebServlet(name = "RegistroServlet", value = "/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch(action){
            case "default" :
                //Alex auxilio
                //int codigoValidacion = Integer.parseInt(request.getParameter("codigoValidacion"));
                String idCorreoValidacion = request.getParameter("idCorreoValidacion");
                Validacion validacion= new Validacion();
                validacion.setIdCorreoValidacion(Integer.parseInt(idCorreoValidacion));
                validacion.setCodigoValidacion(new DaoValidacion().getCodigoValidacionPorIdCorreoValidacion(idCorreoValidacion));

                //request.setAttribute("codigoValidacion ",codigoValidacion);
                request.setAttribute("validacion", validacion);
                RequestDispatcher rd = request.getRequestDispatcher("Registro.jsp");
                rd.forward(request,response);
                break;
            case "registro" :
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        //Para que un usuario se cree su cuenta
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                //No hay nada aquí pero porsiacaso
                break;
            case "registro":
                String idCorreoValidacion = request.getParameter("idCorreoValidacion");
                String correo = new DaoValidacion().buscarCorreoPorIdCorreoValidacion(idCorreoValidacion);
                new DaoUsuario().registroDeAlumno(request.getParameter("nombres"),request.getParameter("apellidos"),correo,request.getParameter("password"), request.getParameter("codigoPucp"),request.getParameter("opciones"));
                //Por el momento al terminar lo hacemos saltar a la vista de inicioSesion
                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                break;
        }

    }
}

