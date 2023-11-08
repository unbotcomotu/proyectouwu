package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoBan;
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
        String action = request.getParameter("action") == null ? "listarUsuarios" : request.getParameter("action");
        switch (action){
            case "listarUsuarios":
                request.setAttribute("listaUsuarios",dUsuario.listarUsuarios());
                request.getRequestDispatcher("listaUsuarios.jsp").forward(request,response);
                break;
            case "banear":
                int idUsuarioABanear =Integer.parseInt(request.getParameter("idUsuarioABanear"));
                new DaoBan().banearPorId(idUsuarioABanear);
                request.setAttribute("listaUsuarios",dUsuario.listarUsuarios());
                request.getRequestDispatcher("listaUsuarios.jsp").forward(request,response);
                break;
            case "buscarUsuario":
                String usuario=request.getParameter("usuario");
                request.setAttribute("listaUsuarios",new DaoUsuario().listarUsuariosTotal();
                request.setAttribute("usuario",usuario);
                if(rolUsuario.equals("Alumno")||rolUsuario.equals("Delegado General")){
                    request.getRequestDispatcher("listaUsuarios.jsp").forward(request,response);
                }
                break;
            case "filtroUsuario":
                int idFiltroActividades=Integer.parseInt(request.getParameter("idFiltroUsuarios"));
                int idOrdenarActividades=Integer.parseInt(request.getParameter("idOrdenarUsuarios"));
                request.setAttribute("listaUsuarios",new DaoUsuario().listarUsuariosTotal(idFiltroActividades,idOrdenarActividades,idUsuario));
                request.setAttribute("idFiltroUsuarios",idFiltroActividades);
                request.setAttribute("idOrdenarUsuarios",idOrdenarActividades);
                request.getRequestDispatcher("listaUsuarios.jsp").forward(request,response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch(action){
            case "ban":
        }


    }
}