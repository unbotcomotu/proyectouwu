package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoLugarEvento;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;

@WebServlet(name = "ListaDeEventosServlet", value = "/ListaDeEventosServlet")
public class ListaDeEventosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoEvento dEvento=new DaoEvento();
        DaoActividad dActividad=new DaoActividad();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        int idActividad=Integer.parseInt(request.getParameter("idActividad"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("vistaActual","listaDeActividades");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        request.setAttribute("listaEventos",dEvento.listarEventos(idActividad));
        request.setAttribute("nombreActividad",dActividad.nombreActividadPorID(idActividad));
        request.setAttribute("delegadoDeEstaActividadID",dActividad.idDelegadoDeActividadPorActividad(idActividad));
        request.setAttribute("listaLugares",new DaoLugarEvento().listarLugares());
        request.setAttribute("cantidadEventosFinalizados",dActividad.cantidadEventosFinalizadosPorActividad(idActividad));
        request.setAttribute("cantidadEventosOcultos",dActividad.cantidadEventosOcultosPorActividad(idActividad));
        request.setAttribute("cantidadEventosApoyando",dActividad.cantidadEventosApoyandoPorActividad(idActividad,idUsuario));
        request.setAttribute("listaLugaresCantidad",dActividad.lugaresConMayorCantidadDeEventos_cantidad_idLugarEvento(idActividad));
        request.setAttribute("cantidadEventosHoy",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,0));
        request.setAttribute("cantidadEventosManana",dActividad.cantidadEventosEnNdiasPorActividad(idActividad,1));
        request.setAttribute("cantidadEventos2DiasMas", dActividad.cantidadEventosEn2DiasAMasPorActividad(idActividad));
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                request.getRequestDispatcher("listaDeEventos.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");


        switch (action) {
            case "searchView":
                String recv = request.getParameter("searchEventoID");
                if (!recv.isEmpty()) {
                    request.setAttribute("EventoXActividadFoundSearch", new DaoEvento().actividadDeEventoPorID(Integer.parseInt(recv)));
                    request.getRequestDispatcher("listaDeEventos.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/ListaDeEventosServlet");
                    break;
                }
            case "addConfirm":
                int addEventoID = Integer.parseInt(request.getParameter("addEventoID"));
                //el id de la Actividad no puede ser cambiado
                int addActividadID = Integer.parseInt(request.getParameter("addActividadID"));
                int addLugarID = Integer.parseInt(request.getParameter("addLugarID"));
                String addTitulo = request.getParameter("addTitulo");
                String addFecha = request.getParameter("addFecha"); //cambiar a date
                String addHora = request.getParameter("addHora"); //cambiar a time
                String addDescripcionEventoActivo = request.getParameter("addDescripcionEventoActivo");
                String addFraseMotivacional = request.getParameter("addFraseMotivacional");
                //fotoMinuatura
                String addfotoMiniatura = request.getParameter("addfotoMiniatura");

                new DaoEvento().crearEvento(addEventoID,addActividadID,addLugarID,addTitulo,addFecha,addHora,addDescripcionEventoActivo,addFraseMotivacional,addfotoMiniatura);
                response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet");
                break;
            case "updateConfirm":
                int updateLugarID = Integer.parseInt(request.getParameter("updateLugarID"));
                String updateTitulo = request.getParameter("updateTitulo");
                String updateFecha = request.getParameter("updateFecha"); //cambiar a date
                String updateHora = request.getParameter("updateHora"); //cambiar a time
                String updateDescripcionEventoActivo = request.getParameter("updateDescripcionEventoActivo");
                String updateFraseMotivacional = request.getParameter("updateFraseMotivacional");
                //fotoMinuatura
                String updatefotoMiniatura = request.getParameter("updatefotoMiniatura");



                //mañana sigo uu
                response.sendRedirect(request.getContextPath()+ "/ListaDeEventosServlet");
                break;
        }
    }
}