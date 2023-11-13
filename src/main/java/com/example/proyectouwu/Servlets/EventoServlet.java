package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoAlumnoPorEvento;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import com.example.proyectouwu.Beans.Evento;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "EventoServlet", value = "/EventoServlet")
public class EventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoEvento dEvento=new DaoEvento();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            int idEvento=Integer.parseInt(request.getParameter("idEvento"));
            String rolUsuario=dUsuario.rolUsuarioPorId(usuario.getIdUsuario());
            request.setAttribute("rolUsuario",rolUsuario);
            request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(usuario.getIdUsuario()));
            request.setAttribute("vistaActual","listaDeActividades");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("evento",dEvento.eventoPorIDsinMiniatura(idEvento));
            request.setAttribute("actividad",dEvento.actividadDeEventoPorID(idEvento));
            request.setAttribute("estadoApoyoAlumnoEvento",new DaoAlumnoPorEvento().verificarApoyo(idEvento,usuario.getIdUsuario()));
            request.setAttribute("lugar",dEvento.lugarPorEventoID(idEvento));
            request.setAttribute("delegadoDeEstaActividadID",dEvento.idDelegadoDeActividadPorEvento(idEvento));
            request.setAttribute("cantidadApoyos",dEvento.cantidadApoyosBarraEquipoPorEvento(idEvento));
            request.setAttribute("solicitudesApoyoPendientes",dEvento.solicitudesSinAtenderPorEvento(idEvento));
            if(rolUsuario.equals("Delegado General")){
                request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
            }
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            switch (action){
                case "default":
                    request.getRequestDispatcher("evento.jsp").forward(request,response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        int idEvento = Integer.parseInt(request.getParameter("idEvento"));
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                //request.getRequestDispatcher("evento.jsp").forward(request,response);
            case "apoyoEvento":
                new DaoAlumnoPorEvento().usuarioApoyaEvento(usuario.getIdUsuario(),idEvento);
                //<a href="/proyectouwu_war_exploded/EventoServlet?idEvento=6&amp;idUsuario=17">
                //http://localhost:8080/proyectouwu_war_exploded/EventoServlet?idEvento=6&idUsuario=17
                response.sendRedirect(request.getContextPath()+"/EventoServlet?idEvento="+idEvento);
                break;
            case "notificacionLeidaCampanita":
                dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                response.sendRedirect(request.getContextPath()+"/EventoServlet?idEvento="+idEvento);
                break;
        }
    }
}