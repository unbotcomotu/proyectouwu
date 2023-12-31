package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AnaliticasServlet", value = "/AnaliticasServlet")
public class AnaliticasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoActividad dActividad=new DaoActividad();
        DaoAlumnoPorEvento dAE=new DaoAlumnoPorEvento();
        DaoDonacion dDonacion=new DaoDonacion();
        DaoBan dBan=new DaoBan();
        DaoReporte dReporte=new DaoReporte();
        DaoNotificacion dN=new DaoNotificacion();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            if(!usuario.getRol().equals("Delegado General")){
                response.sendRedirect("ListaDeActividadesServlet");
            }else {
                request.setAttribute("vistaActual", "analiticas");
                request.setAttribute("correosDelegadosGenerales", dUsuario.listarCorreosDelegadosGenerales());
                request.setAttribute("listaNombresActividadesOrden", dActividad.listaNombresActividadesOrden());
                request.setAttribute("cantidadApoyosEstudiantesPorActividadOrden", dActividad.cantidadApoyosEstudiantesPorActividadOrden());
                request.setAttribute("cantidadApoyosEgresadosPorActividadOrden", dActividad.cantidadApoyosEgresadosPorActividadOrden());
                request.setAttribute("cantidadTotalApoyosEstudiantes", dAE.cantidadTotalApoyosEstudiantes());
                request.setAttribute("cantidadTotalApoyosEgresados", dAE.cantidadTotalApoyosEgresados());
                request.setAttribute("donacionesUltimaSemanaEgresados", dDonacion.donacionesEgresadosUltimaSemana());
                request.setAttribute("donacionesUltimaSemanaEstudiantes", dDonacion.donacionesEstudiantesUltimaSemana());
                request.setAttribute("cantidadTotalBaneados", dBan.cantidadTotalBaneados());
                request.setAttribute("cantidadTotalReportados", dReporte.cantidadTotalReportados());
                request.setAttribute("donacionesHoy", dDonacion.donacionesHaceNdias(0));
                request.setAttribute("donacionesAyer", dDonacion.donacionesHaceNdias(1));
                request.setAttribute("reportesHoy", dReporte.cantidadReportadosHaceNdias(0));
                request.setAttribute("reportesAyer", dReporte.cantidadReportadosHaceNdias(1));
                request.setAttribute("baneosHoy", dBan.cantidadBaneadosHaceNdias(0));
                request.setAttribute("baneosAyer", dBan.cantidadBaneadosHaceNdias(1));
                request.setAttribute("solicitudesApoyoHoy", dAE.solicitudesApoyoHaceNdias(0));
                request.setAttribute("solicitudesApoyoAyer", dAE.solicitudesApoyoHaceNdias(1));
                request.setAttribute("totalEstudiantesRegistrados", dUsuario.totalEstudiantesRegistrados());
                request.setAttribute("totalEgresadosRegistrados", dUsuario.totalEgresadosRegistrados());
                request.setAttribute("totalDonacionesEgresados", dDonacion.donacionesTotalesEgresados());
                request.setAttribute("totalDonacionesEstudiantes", dDonacion.donacionesTotalesEstudiantes());
                request.setAttribute("topDonadorTotal", dDonacion.hallarTopDonador());
                request.setAttribute("topDonadorUltimaSemana", dDonacion.hallarTopDonadorUltimaSemana());
                if (usuario.getRol().equals("Delegado General")) {
                    request.setAttribute("listaNotificacionesCampanita", new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                }
                request.setAttribute("topApoyoUltimaSemana", dAE.topApoyoUltimaSemana());
                request.setAttribute("topApoyoTotal", dAE.topApoyoTotal());
                request.setAttribute("listaNotificacionesCampanita", dN.listarNotificacionesDelegadoGeneral());
                String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
                switch (action) {
                    default:
                    case "default":
                        request.getRequestDispatcher("analiticas.jsp").forward(request, response);
                }
                request.getSession().setAttribute("usuario", dUsuario.usuarioSesion(usuario.getIdUsuario()));
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("AnaliticasServlet");
    }
}
