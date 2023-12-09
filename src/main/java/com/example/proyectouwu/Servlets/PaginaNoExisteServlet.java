package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoNotificacion;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "PaginaNoExisteServlet", value = "/PaginaNoExisteServlet")
public class PaginaNoExisteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            request.setAttribute("vistaActual","listaDeActividades");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("IDyNombreDelegadosDeActividad",dUsuario.listarIDyNombreDelegadosDeActividad());
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            switch (action) {
                case "default":
                    if(usuario.getRol().equals("Alumno")){
                        request.getRequestDispatcher("paginaNoExiste.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado General")){
                        request.setAttribute("listaNotificacionesCampanita",new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                        request.getRequestDispatcher("paginaNoExiste.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado de Actividad")){
                        Integer idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                        request.setAttribute("listaNotificacionesDelegadoDeActividad",new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                        request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                        request.getRequestDispatcher("paginaNoExiste.jsp").forward(request,response);
                    }
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoNotificacion dN=new DaoNotificacion();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            switch(action){
                case "notificacionLeidaCampanita":
                    dN.notificacionLeida(request.getParameter("idNotificacion"));
                    break;
                case "notificacionLeidaCampanitaDelegadoDeActividad":
                    dN.notificacionLeidaDelegadoDeActividad(request.getParameter("idAlumnoPorEvento"));
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
            String servletActual=request.getParameter("servletActual");
            if(servletActual==null){
                response.sendRedirect(request.getContextPath());
            }else if(servletActual.equals("ListaDeEventosServlet")){
                response.sendRedirect(servletActual+"?idActividad="+request.getParameter("idActividad"));
            }else if(servletActual.equals("EventoServlet")){
                response.sendRedirect(servletActual+"?idEvento="+request.getParameter("idEvento"));
            }else {
                response.sendRedirect(servletActual);
            }
        }

    }
}