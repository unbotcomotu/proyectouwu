package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoGeneral;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ListaDeActividadesServlet", value = "/ListaDeActividadesServlet")
public class ListaDeActividadesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        int idRolUsuario=new DaoGeneral().idRolUsuarioPorId(idUsuario);
        request.setAttribute("idRolUsuario",idRolUsuario);
        request.getRequestDispatcher().forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
    }
}