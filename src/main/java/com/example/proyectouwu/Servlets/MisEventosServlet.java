package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.ZonedDateTime;

@WebServlet(name = "MisEventosServlet", value = "/MisEventosServlet")
public class MisEventosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoAlumnoPorEvento dAlPorEvento=new DaoAlumnoPorEvento();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            if(usuario.getRol().equals("Delegado General")){
                response.sendRedirect("ListaDeActividadesServlet");
            }else {
                request.setAttribute("vistaActual", "misEventos");
                request.setAttribute("correosDelegadosGenerales", dUsuario.listarCorreosDelegadosGenerales());
                String fechaActual[] = ZonedDateTime.now().toString().split("T")[0].split("-");
                request.setAttribute("diaActual", fechaActual[2]);
                request.setAttribute("mesActual", fechaActual[1]);
                request.setAttribute("listaEventos", dAlPorEvento.listarEventosPorUsuario(usuario.getIdUsuario()));
                if (usuario.getRol().equals("Delegado de Actividad")) {
                    request.setAttribute("listaNotificacionesDelegadoDeActividad", new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                }
                String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
                switch (action) {
                    case "default":
                        request.getRequestDispatcher("misEventos.jsp").forward(request, response);
                }
                request.getSession().setAttribute("usuario", dUsuario.usuarioSesion(usuario.getIdUsuario()));
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("MisEventosServlet");
    }
}