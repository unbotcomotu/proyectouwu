package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import com.example.proyectouwu.Beans.Evento;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "EventoServlet", value = "/EventoServlet")
@MultipartConfig(maxFileSize = 10000000)
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
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        DaoFotoEventoCarrusel dF=new DaoFotoEventoCarrusel();
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
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
                case "editarCarrusel":
                    ArrayList<Integer> listaIDs= dF.idsFotosCarrusel(idEvento);
                    String borrar1=request.getParameter("borrar1");
                    String borrar2=request.getParameter("borrar2");
                    String borrar3=request.getParameter("borrar3");
                    Part partFoto1=request.getPart("foto1");
                    Part partFoto2=request.getPart("foto2");
                    Part partFoto3=request.getPart("foto3");
                    if(borrar1.equals("0")){
                        if(partFoto1!=null){
                            InputStream inputFoto1=partFoto1.getInputStream();
                            if(inputFoto1.available()>10){
                                dF.actualizarImagenCarrusel(listaIDs.get(0),inputFoto1);
                            }
                            inputFoto1.close();
                        }
                    }else {
                        InputStream inputFoto1 = getServletContext().getResourceAsStream("/css/imagenBorrada.png");
                        dF.actualizarImagenCarrusel(listaIDs.get(0),inputFoto1);
                        inputFoto1.close();
                    }
                    if(borrar2.equals("0")){
                        if(partFoto2!=null){
                            InputStream inputFoto2=partFoto2.getInputStream();
                            if(inputFoto2.available()>10){
                                dF.actualizarImagenCarrusel(listaIDs.get(1),inputFoto2);
                            }
                            inputFoto2.close();
                        }
                    }else {
                        InputStream inputFoto2 = getServletContext().getResourceAsStream("/css/imagenBorrada.png");
                        dF.actualizarImagenCarrusel(listaIDs.get(1),inputFoto2);
                        inputFoto2.close();
                    }
                    if(borrar3.equals("0")){
                        if(partFoto3!=null){
                            InputStream inputFoto3=partFoto3.getInputStream();
                            if(inputFoto3.available()>10){
                                dF.actualizarImagenCarrusel(listaIDs.get(2),inputFoto3);
                            }
                            inputFoto3.close();
                        }
                    }else {
                        InputStream inputFoto3 = getServletContext().getResourceAsStream("/css/imagenBorrada.png");
                        dF.actualizarImagenCarrusel(listaIDs.get(2),inputFoto3);
                        inputFoto3.close();
                    }
                    response.sendRedirect("EventoServlet?idEvento="+idEvento);
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}