package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoBan;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ListaDeUsuariosServlet", value = "/ListaDeUsuariosServlet")
public class ListaDeUsuariosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("vistaActual","listaDeUsuarios");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        if(rolUsuario.equals("Delegado General")){
            request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
        }
        String action = request.getParameter("action") == null ? "listarUsuarios" : request.getParameter("action");
        String pagina = request.getParameter("p") == null ? "1" : request.getParameter("p");
        switch (action) {
            case "listarUsuarios":
                request.setAttribute("listaUsuarios", dUsuario.listarUsuarios(Integer.parseInt(pagina)-1));
                request.setAttribute("cantidadUsuariosTotal", dUsuario.listarUsuarios().size());
                request.setAttribute("pagActual", Integer.parseInt(pagina));
                request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                break;
            case "buscarUsuario":
                String usuario=request.getParameter("usuario");
                request.setAttribute("listaUsuarios",new DaoUsuario().listarUsuarioXnombre(usuario));
                request.setAttribute("usuario",usuario);
                if(rolUsuario.equals("Alumno")||rolUsuario.equals("Delegado General")){
                    request.getRequestDispatcher("listaUsuarios.jsp").forward(request,response);
                }
                break;
            case "filtroUsuario":
                int idFiltroUsuario=Integer.parseInt(request.getParameter("idFiltroUsuario"));
                int idOrdenarUsuario=Integer.parseInt(request.getParameter("idOrdenarUsuario"));
                //request.setAttribute("listaUsuario",new DaoUsuario().listarUsuariosTotal(idFiltroActividades,idOrdenarActividades,idUsuario));
                request.setAttribute("listaUsuarios",new DaoUsuario().listarUsuariosFiltro(idFiltroUsuario,idOrdenarUsuario));
                request.setAttribute("idFiltroUsuario",idFiltroUsuario);
                request.setAttribute("idOrdenarUsuario",idOrdenarUsuario);
                request.getRequestDispatcher("listaUsuarios.jsp").forward(request,response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch(action){
            case "banear":
                int idUsuarioABanear =Integer.parseInt(request.getParameter("idUsuarioABanear"));
                new DaoBan().banearPorId(idUsuarioABanear);
                response.sendRedirect(request.getContextPath()+"/ListaDeUsuariosServlet?idUsuario="+idUsuario);
                break;
            case "notificacionLeidaCampanita":
                dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                response.sendRedirect(request.getContextPath()+"/ListaDeUsuariosServlet?idUsuario="+idUsuario);
                break;
        }
    }
}