package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Actividad;
import com.example.proyectouwu.Daos.DaoGeneral;
import com.example.proyectouwu.Daos.ListaDeActividadesDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ListaDeActividadesServlet", value = "/ListaDeActividadesServlet")
public class ListaDeActividadesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=new DaoGeneral().rolUsuarioPorId(idUsuario);
        int idActividadDelegatura=-1;
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",new DaoGeneral().nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("listaActividades",new ListaDeActividadesDao().listarActividades());
        request.setAttribute("estadoActual","listaDeActividades");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                if(rolUsuario.equals("Alumno")||rolUsuario.equals("Delegado General")){
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado de Actividad")){
                    idActividadDelegatura=new ListaDeActividadesDao().idDelegaturaPorIdDelegadoDeActividad(idUsuario);
                    request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
    }
}