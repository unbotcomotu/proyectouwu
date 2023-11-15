package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoBan;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ListaDeUsuariosServlet", value = "/ListaDeUsuariosServlet")
public class ListaDeUsuariosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            request.setAttribute("vistaActual","listaDeUsuarios");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
            String action = request.getParameter("action") == null ? "listarUsuarios" : request.getParameter("action");
            String pagina = request.getParameter("p") == null ? "1" : request.getParameter("p");
            String filtro = request.getParameter("idFiltroUsuario") != null ? request.getParameter("idFiltroUsuario") : "";
            switch (action) {
                case "listarUsuarios":
                    if(filtro.isEmpty()){
                        request.setAttribute("listaUsuarios", dUsuario.listarUsuarios(Integer.parseInt(pagina)-1));
                        request.setAttribute("cantidadUsuariosTotal", dUsuario.listarUsuarios().size());
                        request.setAttribute("pagActual", Integer.parseInt(pagina));
                        request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                    }else{
                        int idOrdenarUsuario=Integer.parseInt(request.getParameter("idOrdenarUsuario"));
                        request.setAttribute("listaUsuarios", dUsuario.listarUsuariosFiltro(Integer.parseInt(filtro),idOrdenarUsuario,Integer.parseInt(pagina)-1));
                        request.setAttribute("cantidadUsuariosTotal", dUsuario.listarUsuarios().size());
                        request.setAttribute("idFiltroUsuario",Integer.parseInt(filtro));
                        request.setAttribute("idOrdenarUsuario",idOrdenarUsuario);
                        request.setAttribute("pagActual", Integer.parseInt(pagina));
                        request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                    }
                    break;
                case "buscarUsuario":
                    if(filtro.isEmpty()) {
                        String usuario2 = request.getParameter("usuario");
                        request.setAttribute("listaUsuarios", new DaoUsuario().listarUsuarioXnombre(usuario2, Integer.parseInt(pagina) - 1));
                        request.setAttribute("cantidadUsuariosTotal", new DaoUsuario().listarUsuarioXnombre(usuario2).size());
                        request.setAttribute("action", action);
                        request.setAttribute("usuario", usuario2);
                        request.setAttribute("pagActual", Integer.parseInt(pagina));
                        request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                    }else{
                        String usuario2 = request.getParameter("usuario");
                        int idOrdenarUsuario=Integer.parseInt(request.getParameter("idOrdenarUsuario"));
                        request.setAttribute("listaUsuarios", dUsuario.listarUsuarioXnombre(usuario2, Integer.parseInt(pagina) - 1,Integer.parseInt(filtro),idOrdenarUsuario));
                        request.setAttribute("cantidadUsuariosTotal", new DaoUsuario().listarUsuarioXnombre(usuario2).size());
                        request.setAttribute("idFiltroUsuario",Integer.parseInt(filtro));
                        request.setAttribute("idOrdenarUsuario",idOrdenarUsuario);
                        request.setAttribute("action", action);
                        request.setAttribute("usuario", usuario2);
                        request.setAttribute("pagActual", Integer.parseInt(pagina));
                        request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                    }
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            switch(action){
                case "banear":
                    int idUsuarioABanear =Integer.parseInt(request.getParameter("idUsuarioABanear"));
                    new DaoBan().banearPorId(idUsuarioABanear);
                    response.sendRedirect("ListaDeUsuariosServlet");
                    break;
                case "notificacionLeidaCampanita":
                    dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                    response.sendRedirect("ListaDeUsuariosServlet");
                    break;
            }
        }
    }
}