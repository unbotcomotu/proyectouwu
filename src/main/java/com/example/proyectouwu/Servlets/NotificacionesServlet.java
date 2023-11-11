package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.*;
import com.example.proyectouwu.Daos.DaoDonacion;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
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
        int idUsuario= Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        if(rolUsuario.equals("Delegado General")){
            request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
        }
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                if (rolUsuario.equals("Delegado General")){

                    String vistaActualNueva = request.getParameter("vistaActualNueva");
                    request.setAttribute("vistaActualNueva",vistaActualNueva);
                    //saca del modelo
                    ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                    ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();
                    ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();
                    //mandar la lista a la vista
                            request.setAttribute("listaSolicitudes",listaSolicitudes);
                            request.setAttribute("reportList", reportList);
                            request.setAttribute("donacionList",donacionList);
                            request.setAttribute("recuperacionList",recuperacionList);
                            request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                }else if (rolUsuario.equals("Delegado de Actividad")){
                        DaoNotificacionDelegadoGeneral daoNotificacionesDeleActividad = new DaoNotificacionDelegadoGeneral();
                        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = daoNotificacionesDeleActividad.listarSolicitudesDeApoyo(idUsuario);

                        request.setAttribute("listaSolicitudesApoyo",listaSolicitudesApoyo);
                        request.getRequestDispatcher("NotificacionesDelActividad.jsp").forward(request,response);
                }else{
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                }
                break;
            case "buscarUsuario":
                request.setAttribute("vistaActualNueva","Solicitudes");
                if (rolUsuario.equals("Delegado General")){
                    String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                    ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro(busquedaSolicitudes);
                    ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();
                    ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();

                    request.setAttribute("busquedaSolicitudes",busquedaSolicitudes);
                    request.setAttribute("listaSolicitudes",listaSolicitudes);
                    request.setAttribute("reportList", reportList);
                    request.setAttribute("donacionList",donacionList);
                    request.setAttribute("recuperacionList",recuperacionList);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                }else if (rolUsuario.equals("Delegado de Actividad")){
                    String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                    DaoNotificacionDelegadoGeneral daoNotificacionesDeleActividad = new DaoNotificacionDelegadoGeneral();
                    ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = daoNotificacionesDeleActividad.listarSolicitudesDeApoyo(idUsuario,busquedaSolicitudes);
                    request.setAttribute("listaSolicitudesApoyo",listaSolicitudesApoyo);
                    request.getRequestDispatcher("NotificacionesDelActividad.jsp").forward(request,response);
                }else{
                    response.sendRedirect(request.getContextPath());
                }
                break;
            case "buscarDonaciones":
                request.setAttribute("vistaActualNueva","Donaciones");
                String buscar=request.getParameter("buscar");
                ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(buscar);
                ArrayList<Validacion> recuperacionList = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();
                request.setAttribute("buscar",buscar);
                request.setAttribute("listaSolicitudes",listaSolicitudes);
                request.setAttribute("reportList", reportList);
                request.setAttribute("donacionList",donacionList);
                request.setAttribute("recuperacionList",recuperacionList);
                request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                break;
            case "filtrarDonaciones":
                request.setAttribute("vistaActualNueva","Donaciones");
                String fecha1=request.getParameter("fecha1");
                String fecha2=request.getParameter("fecha2");
                ArrayList<Usuario> listaSolicitudes1 = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                ArrayList<Reporte> reportList1 = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                ArrayList<Donacion> donacionList1 = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones(fecha1,fecha2);
                ArrayList<Validacion> recuperacionList1 = daoNotificacionDelegadoGeneral.listarNotificacionesRecuperacion();
                request.setAttribute("fecha1",fecha1);
                request.setAttribute("fecha2",fecha2);
                request.setAttribute("listaSolicitudes",listaSolicitudes1);
                request.setAttribute("reportList", reportList1);
                request.setAttribute("donacionList",donacionList1);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        request.setAttribute("idUsuario",idUsuario);
        DaoDonacion daoDonacion = new DaoDonacion();
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
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
                    response.sendRedirect(request.getContextPath()+  "/NotificacionesServlet?idUsuario="+idUsuario + "&vistaActualNueva=Donaciones");
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
                response.sendRedirect(request.getContextPath()+"/NotificacionesServlet?idUsuario="+idUsuario+"&vistaActualNueva=Donaciones");

                break;
            case "enviar":
                //cómo hago para que envíe link?
                break;
            case "aceptarRegistro":
                String idUserMaster = request.getParameter("idUsuario");
                String idUsuarioARegistrar = request.getParameter("idUsuarioARegistrar");
                new DaoUsuario().aceptarRegistro(Integer.parseInt(idUsuarioARegistrar));
                response.sendRedirect(request.getContextPath() + "/NotificacionesServlet?idUsuario="+ idUserMaster);
                break;
            case "rechazarRegistro":
                String idUserMaster1 = request.getParameter("idUsuario");
                String idUsuarioARegistrar1 = request.getParameter("idUsuarioARegistrar");
                new DaoUsuario().rechazarRegistro(Integer.parseInt(idUsuarioARegistrar1));
                response.sendRedirect(request.getContextPath() + "/NotificacionesServlet?idUsuario="+ idUserMaster1);
                break;
            case "filtrarFechaDelegadoGeneral":
                break;
            case "aceptarSolicitudApoyo":
                int idAlumnoPorEvento=Integer.parseInt(request.getParameter("idAlumnoPorEvento"));
                String tipoDeApoyo=request.getParameter("tipoDeApoyo");
                dN.aceptarSolicitudApoyo(idAlumnoPorEvento,tipoDeApoyo);
                response.sendRedirect(request.getContextPath()+"/NotificacionesServlet?idUsuario="+idUsuario);
                break;
            case "notificacionLeidaCampanita":
                dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                response.sendRedirect(request.getContextPath()+"/EventoServlet?idUsuario="+idUsuario);
                break;
        }
    }
}