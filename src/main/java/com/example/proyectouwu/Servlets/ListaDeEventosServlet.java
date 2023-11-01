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
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Time;

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
        request.setAttribute("idActividad",idActividad);
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

        DaoEvento daoEvento = new DaoEvento();

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

                // Parámetros:
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                int addActividadID = Integer.parseInt(request.getParameter("addActividadID"));
                String addLugar = request.getParameter("addLugar");
                String addTitulo = request.getParameter("addTitulo");
                String addFechaStr = request.getParameter("addFecha");
                String addHoraStr = request.getParameter("addHora");
                String addDescripcionEventoActivo = request.getParameter("addDescripcionEventoActivo");
                String addFraseMotivacional = request.getParameter("addFraseMotivacional");
                String addEventoOcultoStr = request.getParameter("addEventoOculto");

                // Conversión al tipo de variables de la tabla:
                Boolean addEventoOculto = false;
                if(!(addEventoOcultoStr == null)){
                    addEventoOculto = true;
                }
                Date addFecha = Date.valueOf("2023-10-"+addFechaStr);
                Time addHora = Time.valueOf(addHoraStr+":00");

                // Verificar lugar:
                DaoLugarEvento dLugarEvento = new DaoLugarEvento();
                int addLugarId = dLugarEvento.idLugarPorNombre(addLugar);
                // En caso no exista el lugar, se crea uno nuevo
                if(addLugarId==0){
                    addLugarId = dLugarEvento.crearLugar(addLugar); // Id del nuevo lugar
                }

                // Crear evento:
                new DaoEvento().crearEvento(addActividadID,addLugarId,addTitulo,addFecha,addHora,addDescripcionEventoActivo,addFraseMotivacional,"uwu",addEventoOculto);
                response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet?idUsuario="+idUsuario+"&idActividad="+addActividadID);
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
            case "finConfirm":
                int finEventoId = Integer.parseInt(request.getParameter("finEventoID"));
                String finResumen = request.getParameter("finResumen");
                String resultado = request.getParameter("resultado");

                daoEvento.finalizarEvento(finEventoId,finResumen,resultado);
                response.sendRedirect(request.getContextPath()+"/ListaDeEventosServlet");
                break;
        }
    }
}