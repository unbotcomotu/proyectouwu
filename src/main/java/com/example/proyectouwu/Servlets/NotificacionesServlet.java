package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.*;
import com.example.proyectouwu.Daos.DaoDonacion;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "NotificacionesServlet", value = "/NotificacionesServlet")
public class NotificacionesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoDonacion daoDonacion  = new DaoDonacion();
        DaoNotificacionDelegadoGeneral daoNotificacionDelegadoGeneral = new DaoNotificacionDelegadoGeneral();
        request.setAttribute("vistaActual","---");
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            if(usuario.getRol().equals("Delegado General")){
                request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
            }
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            String actionSession=(String) request.getSession().getAttribute("actionNotificacionesServlet");
            if(action.equals("default")&&actionSession!=null){
                action=actionSession;
            }
            String buscar="";
            String fecha1="";
            String fecha2="";
            String page="";
            String pageD="";
            String pageV="";
            int pagina=0;
            int paginaD=0;
            int paginaV=0;
            switch (action){
                case "default":
                    if (usuario.getRol().equals("Delegado General")){
                        String vistaActualNueva = request.getParameter("vistaActualNueva");
                        request.setAttribute("vistaActualNueva",vistaActualNueva);
                        //saca del modelo
                        page = request.getParameter("p")==null? "1" : request.getParameter("p");
                        pagina = Integer.parseInt(page);
                        pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");
                        paginaD = Integer.parseInt(pageD);
                        pageV = request.getParameter("pv")==null? "1" : request.getParameter("pv");
                        paginaV = Integer.parseInt(pageV);
                        ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesRegistroPorPage(pagina-1);
                        ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                        ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(paginaD-1);
                        ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion(paginaV-1);
                        //mandar la lista a la vista
                        request.setAttribute("pagActual", Integer.parseInt(page));
                        request.setAttribute("pagActualD",Integer.parseInt(pageD));
                        request.setAttribute("listaSolicitudes",listaSolicitudes);
                        request.setAttribute("cantidadTotalSolicitudes", daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro().size());
                        request.setAttribute("reportList", reportList);
                        request.setAttribute("donacionList",donacionList);
                        request.setAttribute("cantidadTotalDonaciones",daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones().size());
                        request.setAttribute("cantidadTotalValidaciones",daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion().size());
                        request.setAttribute("recuperacionList",recuperacionList);
                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                    }else if (usuario.getRol().equals("Delegado de Actividad")){
                        page = request.getParameter("p");
                        if(page!=null){
                            request.getSession().removeAttribute("pSolicitudesDeApoyo");
                            request.getSession().setAttribute("pSolicitudesDeApoyo",page);
                        }
                        int pSolicitudesDeApoyo =Integer.parseInt((String) request.getSession().getAttribute("pSolicitudesDeApoyo"));
                        DaoNotificacionDelegadoGeneral daoNotificacionesDeleActividad = new DaoNotificacionDelegadoGeneral();
                        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = daoNotificacionesDeleActividad.listarSolicitudesDeApoyo(usuario.getIdUsuario(),pSolicitudesDeApoyo-1);
                        request.setAttribute("listaSolicitudesApoyo",listaSolicitudesApoyo);
                        request.setAttribute("cantidadTotalSolicitudesApoyo",daoNotificacionesDeleActividad.listarSolicitudesDeApoyo(usuario.getIdUsuario()).size());
                        request.getRequestDispatcher("NotificacionesDelActividad.jsp").forward(request,response);
                    }else{
                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    }
                    break;
                case "buscarUsuario":
                    request.setAttribute("vistaActualNueva","Solicitudes");
                    if (usuario.getRol().equals("Delegado General")){
                        page = request.getParameter("p")==null? "1" : request.getParameter("p");
                        pagina = Integer.parseInt(page);
                        pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");
                        paginaD = Integer.parseInt(pageD);
                        String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                        ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro(busquedaSolicitudes,pagina-1);
                        ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                        ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(paginaD-1);
                        ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();

                        request.setAttribute("cantidadTotalSolicitudes", daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro(busquedaSolicitudes).size());
                        request.setAttribute("action", action);
                        request.setAttribute("pagActual", Integer.parseInt(page));
                        request.setAttribute("pagActualD",Integer.parseInt(pageD));
                        request.setAttribute("busquedaSolicitudes",busquedaSolicitudes);
                        request.setAttribute("listaSolicitudes",listaSolicitudes);
                        request.setAttribute("reportList", reportList);
                        request.setAttribute("donacionList",donacionList);
                        request.setAttribute("recuperacionList",recuperacionList);
                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                    }else if (usuario.getRol().equals("Delegado de Actividad")){
                        String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                        DaoNotificacionDelegadoGeneral daoNotificacionesDeleActividad = new DaoNotificacionDelegadoGeneral();
                        request.getSession().removeAttribute("actionNotificacionesServlet");
                        request.getSession().setAttribute("actionNotificacionesServlet","buscarUsuario");
                        page = request.getParameter("p");
                        if(page!=null){
                            request.getSession().removeAttribute("pSolicitudesDeApoyo");
                            request.getSession().setAttribute("pSolicitudesDeApoyo",page);
                        }
                        int pSolicitudesDeApoyo =Integer.parseInt((String) request.getSession().getAttribute("pSolicitudesDeApoyo"));
                        if(busquedaSolicitudes!=null){
                            request.getSession().removeAttribute("busquedaSolicitudesApoyo");
                            request.getSession().setAttribute("busquedaSolicitudesApoyo",busquedaSolicitudes);
                        }
                        String busquedaAux=(String) request.getSession().getAttribute("busquedaSolicitudesApoyo");
                        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = daoNotificacionesDeleActividad.listarSolicitudesDeApoyo(usuario.getIdUsuario(),busquedaAux,pSolicitudesDeApoyo-1);
                        request.setAttribute("listaSolicitudesApoyo",listaSolicitudesApoyo);
                        request.setAttribute("cantidadTotalSolicitudesApoyo",daoNotificacionesDeleActividad.listarSolicitudesDeApoyo(usuario.getIdUsuario(),busquedaAux).size());
                        request.getRequestDispatcher("NotificacionesDelActividad.jsp").forward(request,response);
                    }else{
                        response.sendRedirect(request.getContextPath());
                    }
                    break;
                case "buscarDonaciones":
                    request.setAttribute("vistaActualNueva","Donaciones");
                    buscar = request.getParameter("buscar");
                    fecha1 = request.getParameter("fecha1").isEmpty() ? "0001/01/01" : request.getParameter("fecha1");
                    fecha2 = request.getParameter("fecha2").isEmpty() ? "4000/12/31" : request.getParameter("fecha2");
                    page = request.getParameter("p")==null? "1" : request.getParameter("p");
                    pagina = Integer.parseInt(page);
                    pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");
                    paginaD = Integer.parseInt(pageD);
                    ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesRegistroPorPage(pagina-1);
                    ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();
                    request.setAttribute("buscar",buscar);
                    request.setAttribute("fecha1",fecha1);
                    request.setAttribute("fecha2",fecha2);
                    request.setAttribute("pagActual", Integer.parseInt(page));
                    request.setAttribute("pagActualD",Integer.parseInt(pageD));
                    request.setAttribute("cantidadTotalSolicitudes", daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro().size());
                    request.setAttribute("action", action);
                    request.setAttribute("listaSolicitudes",listaSolicitudes);
                    request.setAttribute("cantidadTotalDonaciones",daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(buscar).size());
                    request.setAttribute("reportList", reportList);
                    request.setAttribute("donacionList",daoNotificacionDelegadoGeneral.juntarListas(daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(buscar,paginaD-1),daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(fecha1,fecha2,paginaD-1)));
                    request.setAttribute("recuperacionList",recuperacionList);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    break;
                case "filtrarDonaciones":
                    request.setAttribute("vistaActualNueva","Donaciones");
                    buscar = request.getParameter("buscar");
                    fecha1=request.getParameter("fecha1");
                    fecha2=request.getParameter("fecha2");
                    page = request.getParameter("p")==null? "1" : request.getParameter("p");
                    pagina = Integer.parseInt(page);
                    pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");
                    paginaD = Integer.parseInt(pageD);
                    ArrayList<Usuario> listaSolicitudes1 = daoNotificacionDelegadoGeneral.listarSolicitudesRegistroPorPage(pagina-1);
                    ArrayList<Reporte> reportList1 = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Validacion> recuperacionList1 = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();
                    request.setAttribute("fecha1",fecha1);
                    request.setAttribute("action", action);
                    request.setAttribute("cantidadTotalSolicitudes", daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro().size());
                    request.setAttribute("fecha2",fecha2);
                    request.setAttribute("buscar",buscar);
                    request.setAttribute("pagActual", Integer.parseInt(page));
                    request.setAttribute("pagActualD",Integer.parseInt(pageD));
                    request.setAttribute("listaSolicitudes",listaSolicitudes1);
                    request.setAttribute("reportList", reportList1);
                    request.setAttribute("donacionList",daoNotificacionDelegadoGeneral.juntarListas(daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(buscar,paginaD-1),daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(fecha1,fecha2,paginaD-1)));
                    request.setAttribute("recuperacionList",recuperacionList1);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    break;
                case "buscarReportes":
                    request.setAttribute("vistaActualNueva","Reportes");
                    String buscarReportes=request.getParameter("buscarReportes");
                    ArrayList<Usuario> listaSolicitudes2 = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                    ArrayList<Reporte> reportList2 = daoNotificacionDelegadoGeneral.listarNotificacionesReporte(buscarReportes);
                    ArrayList<Donacion> donacionList2 = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();
                    ArrayList<Validacion> recuperacionList2 = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();
                    request.setAttribute("buscarReportes",buscarReportes);
                    request.setAttribute("listaSolicitudes",listaSolicitudes2);
                    request.setAttribute("reportList", reportList2);
                    request.setAttribute("donacionList",donacionList2);
                    request.setAttribute("recuperacionList",recuperacionList2);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoDonacion daoDonacion = new DaoDonacion();
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            switch (action){
                case "edit":
                    String donacionId = request.getParameter("idDonacion");
                    String montoDonacion = request.getParameter("montoDonacion");
                    String estadoDonacion = request.getParameter("estadoDonacion");
                    try{
                        int donacionId_int = Integer.parseInt(donacionId);
                        float monto = Float.parseFloat(montoDonacion);
                        DaoNotificacionDelegadoGeneral daoNotificacionDelegadoGeneral = new DaoNotificacionDelegadoGeneral();
                        ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                        ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                        ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();
                        ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();

                        request.setAttribute("listaSolicitudes",listaSolicitudes);
                        request.setAttribute("reportList", reportList);
                        request.setAttribute("donacionList",donacionList);
                        request.setAttribute("recuperacionList",recuperacionList);

                        Donacion donacion = new Donacion();
                        donacion.setIdDonacion(donacionId_int);
                        donacion.setMonto(monto);
                        donacion.setEstadoDonacion(estadoDonacion);

                        daoDonacion.editarDonacion(donacion);
                        response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");
                    }catch (NumberFormatException e){
                        request.setAttribute("donacion",daoDonacion.buscarPorId(donacionId));
                        request.setAttribute("alerta","monto");
                        request.getRequestDispatcher("donacion_edit.jsp").forward(request,response);
                    }
                    break;
                case "editDonacion":
                    String id = request.getParameter("id");
                    Donacion donacion = daoDonacion.buscarPorId(id);

                    if(donacion != null){
                        request.setAttribute("donacion",donacion);
                        request.getRequestDispatcher("/donacion_edit.jsp").forward(request,response);
                    }else{
                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    }
                    break;
                case "deleteDonacion":

                    String idd = request.getParameter("id");
                    Donacion donacion1 = daoDonacion.buscarPorId(idd);

                    if(donacion1 != null){
                        try {
                            daoDonacion.borrar(idd);
                        } catch (SQLException e) {
                            System.out.println("Log: excepcion: " + e.getMessage());
                        }
                    }
                    response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");

                    break;
                case "enviar":
                    new DaoValidacion().linkEnviado(Integer.parseInt(request.getParameter("idCorreoValidacion")));
                    response.sendRedirect("NotificacionesServlet?vistaActualNueva=Recuperacion");
                    break;
                case "aceptarRegistro":
                    String idUsuarioARegistrar = request.getParameter("idUsuarioARegistrar");
                    new DaoUsuario().aceptarRegistro(Integer.parseInt(idUsuarioARegistrar));
                    response.sendRedirect( "NotificacionesServlet");
                    break;
                case "rechazarRegistro":
                    String idUsuarioARegistrar1 = request.getParameter("idUsuarioARegistrar");
                    new DaoUsuario().rechazarRegistro(Integer.parseInt(idUsuarioARegistrar1));
                    response.sendRedirect("NotificacionesServlet");
                    break;
                case "filtrarFechaDelegadoGeneral":
                    break;
                case "aceptarSolicitudApoyo":
                    int idAlumnoPorEvento=Integer.parseInt(request.getParameter("idAlumnoPorEvento"));
                    String tipoDeApoyo=request.getParameter("tipoDeApoyo");
                    dN.aceptarSolicitudApoyo(idAlumnoPorEvento,tipoDeApoyo);
                    response.sendRedirect("NotificacionesServlet");
                    break;
                case "notificacionLeidaCampanita":
                    dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                    response.sendRedirect("NotificacionesServlet");
                    break;
            }
        }
    }
}