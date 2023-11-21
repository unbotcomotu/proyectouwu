package com.example.proyectouwu.Filters;

import com.example.proyectouwu.Beans.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "logOutFilter" , servletNames = {"AnaliticasServlet" , "EventoServlet" , "Imagen", "ImagenActividadServlet" , "ImagenEventoServlet","ImagenUsuarioServlet", "ListaDeActividadesServlet" ,"ListaDeEventosServlet", "ListaDeUsuariosServlet", "MiCuentaServlet" , "MisDonacionesServlet" , "MisEventosServlet" , "NotificacionesServlet"   })
public class logOutFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario");

        if (user == null) {
            resp.sendRedirect("InicioSesionServlet");
        } else {
            resp.setHeader("Cache-Control", "no-cache, no-store , must-revalidate");
            resp.setHeader("Pragma", "no-cache");
            resp.setDateHeader("Expires",0);

            chain.doFilter(req, resp);
        }

    }
}

