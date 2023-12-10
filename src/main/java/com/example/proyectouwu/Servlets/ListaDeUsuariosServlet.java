package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoBan;
import com.example.proyectouwu.Daos.DaoNotificacion;
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
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            if(!usuario.getRol().equals("Delegado General")){
                response.sendRedirect("ListaDeActividadesServlet");
            }else {
                request.setAttribute("vistaActual", "listaDeUsuarios");
                request.setAttribute("correosDelegadosGenerales", dUsuario.listarCorreosDelegadosGenerales());
                request.setAttribute("listaNotificacionesCampanita", new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                String action = request.getParameter("action") == null ? "listarUsuarios" : request.getParameter("action");
                String pagina;
                String paginaPrevia = request.getParameter("p") == null ? "1" : request.getParameter("p");

                if (paginaPrevia != null && paginaPrevia.matches("\\d+")) {
                    // Si es un número, asigna ese valor a la variable 'pagina'
                    pagina = paginaPrevia;
                } else {
                    // Si no es un número, asigna el valor predeterminado '1' a 'pagina'
                    pagina = "1";
                }


                String filtro = request.getParameter("idFiltroUsuario") != null ? request.getParameter("idFiltroUsuario") : "";
                switch (action) {
                    case "listarUsuarios":
                        if (filtro.isEmpty()) {
                            request.setAttribute("listaUsuarios", dUsuario.listarUsuarios(Integer.parseInt(pagina) - 1));
                            request.setAttribute("cantidadUsuariosTotal", dUsuario.listarUsuarios().size());
                            request.setAttribute("pagActual", Integer.parseInt(pagina));
                            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                        } else {
                            String idOrdenarUsuario = request.getParameter("idOrdenarUsuario");
                            request.setAttribute("listaUsuarios", dUsuario.listarUsuariosFiltro(filtro, idOrdenarUsuario, Integer.parseInt(pagina) - 1));
                            request.setAttribute("cantidadUsuariosTotal", dUsuario.listarUsuarios().size());
                            request.setAttribute("idFiltroUsuario", filtro);//cambio aqui
                            request.setAttribute("idOrdenarUsuario", idOrdenarUsuario);
                            request.setAttribute("pagActual", Integer.parseInt(pagina));
                            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                        }
                        break;
                    case "buscarUsuario":
                        if (filtro.isEmpty()) {
                            String usuario2 = request.getParameter("usuario");
                            request.setAttribute("listaUsuarios", new DaoUsuario().listarUsuarioXnombre(usuario2, Integer.parseInt(pagina) - 1));
                            request.setAttribute("cantidadUsuariosTotal", new DaoUsuario().listarUsuarioXnombre(usuario2).size());
                            request.setAttribute("action", action);
                            request.setAttribute("usuario", usuario2);
                            request.setAttribute("pagActual", Integer.parseInt(pagina));
                            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                        } else {
                            String usuario2 = request.getParameter("usuario");
                            String idOrdenarUsuario = request.getParameter("idOrdenarUsuario");
                            request.setAttribute("listaUsuarios", dUsuario.listarUsuarioXnombre(usuario2, Integer.parseInt(pagina) - 1, filtro, idOrdenarUsuario));
                            request.setAttribute("cantidadUsuariosTotal", new DaoUsuario().listarUsuarioXnombre(usuario2).size());
                            request.setAttribute("idFiltroUsuario", filtro);//cambio aqui
                            request.setAttribute("idOrdenarUsuario", idOrdenarUsuario);
                            request.setAttribute("action", action);
                            request.setAttribute("usuario", usuario2);
                            request.setAttribute("pagActual", Integer.parseInt(pagina));
                            request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
                        }
                        break;
                }
                request.getSession().setAttribute("usuario", dUsuario.usuarioSesion(usuario.getIdUsuario()));
            }
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
                case "banear":
                    String idUsuarioABanear=request.getParameter("idUsuarioABanear");
                    if(idUsuarioABanear!=null){
                        String motivoBan=request.getParameter("motivoBan");
                        if(motivoBan!=null&&!motivoBan.isEmpty()){
                            new DaoBan().banearPorId(idUsuarioABanear,motivoBan);
                        }
                    }
                    response.sendRedirect("ListaDeUsuariosServlet");
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}