package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoAlumnoPorEvento;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoUsuario;
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

        //Para que un usuario se cree su cuenta
        DaoUsuario dUsuario=new DaoUsuario();
        DaoAlumnoPorEvento dAlPorEvento=new DaoAlumnoPorEvento();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        //String rolUsuario=request.getParameter("rol");
        String nombreUsuario = request.getParameter("nombre");
        String apellidoUsuario = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String codigoPUCP = request.getParameter("codigoPUCP");
        //estado del registro también está dentro del método de registrarUsuario
        //la hora y fecha no va, porque está directamente anexada en mysql, revisar metodo de registrarUsuario
        String condicion = request.getParameter("condicion");

        dUsuario.registroDeAlumno(idUsuario,nombreUsuario, apellidoUsuario, correo, contrasena, codigoPUCP,condicion );

        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                request.getRequestDispatcher("Registro.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

