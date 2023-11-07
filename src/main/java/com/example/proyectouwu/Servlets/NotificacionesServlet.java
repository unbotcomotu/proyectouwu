package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.AlumnoPorEvento;
import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Reporte;
import com.example.proyectouwu.Beans.Usuario;
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
        int idUsuario= (int) Integer.parseInt(request.getParameter("idUsuario"));


        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("vistaActual","---");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                if (rolUsuario.equals("Delegado General")){

                    String vistaActualNueva = request.getParameter("vistaActualNueva");
                    request.setAttribute("vistaActualNueva",vistaActualNueva);
                    //saca del modelo
                    DaoNotificacionDelegadoGeneral daoNotificacionDelegadoGeneral = new DaoNotificacionDelegadoGeneral();
                    ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                    ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();
                    //mandar la lista a la vista
                            request.setAttribute("listaSolicitudes",listaSolicitudes);
                            request.setAttribute("reportList", reportList);
                            request.setAttribute("donacionList",donacionList);
                            request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                }else if (rolUsuario.equals("Delegado de Actividad")){
                        DaoNotificacionDelegadoGeneral daoNotificacionesDeleActividad = new DaoNotificacionDelegadoGeneral();
                        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = daoNotificacionesDeleActividad.listarSolicitudesDeApoyo();

                        request.setAttribute("listaSolicitudesApoyo",listaSolicitudesApoyo);
                        request.getRequestDispatcher("NotificacionesDelActividad.jsp").forward(request,response);
                }else{
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                }
                break;

            case "edit":
                String id = request.getParameter("id");
                Donacion donacion = daoDonacion.buscarPorId(id);

                if(donacion != null){
                    request.setAttribute("donacion",donacion);
                    request.getRequestDispatcher("/donacion_edit.jsp").forward(request,response);
                }else{
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                }
                break;
            case "aceptarRegistro":
                String idUserMaster = request.getParameter("idUsuario");
                String idUsuarioARegistrar = request.getParameter("idUsuarioARegistrar");
                new DaoUsuario().aceptarRegistro((int)Integer.parseInt(idUsuarioARegistrar));
                response.sendRedirect(request.getContextPath() + "/NotificacionesServlet?idUsuario="+ idUserMaster);
                break;
            case "rechazarRegistro":
                String idUserMaster1 = request.getParameter("idUsuario");
                String idUsuarioARegistrar1 = request.getParameter("idUsuarioARegistrar");
                new DaoUsuario().rechazarRegistro((int)Integer.parseInt(idUsuarioARegistrar1));
                response.sendRedirect(request.getContextPath() + "/NotificacionesServlet?idUsuario="+ idUserMaster1);
                break;
            case "delete":

                String idd = request.getParameter("id");
                Donacion donacion1 = daoDonacion.buscarPorId(idd);

                if(donacion1 != null){
                    try {
                        daoDonacion.borrar(idd);
                    } catch (SQLException e) {
                        System.out.println("Log: excepcion: " + e.getMessage());
                    }
                }
                request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);


                break;

        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("vistaActual","---");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        DaoDonacion daoDonacion = new DaoDonacion();

        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "buscarUsuario":
                if (rolUsuario.equals("Delegado General")){
                    String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                    DaoNotificacionDelegadoGeneral daoNotificacionDelegadoGeneral = new DaoNotificacionDelegadoGeneral();
                    ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro(busquedaSolicitudes);
                    ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();

                            request.setAttribute("busquedaSolicitudes",busquedaSolicitudes);
                            request.setAttribute("listaSolicitudes",listaSolicitudes);
                            request.setAttribute("reportList", reportList);
                            request.setAttribute("donacionList",donacionList);
                            request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);


                }else if (rolUsuario.equals("Delegado de Actividad")){
                    DaoNotificacionDelegadoGeneral daoNotificacionesDeleActividad = new DaoNotificacionDelegadoGeneral();
                    ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = daoNotificacionesDeleActividad.listarSolicitudesDeApoyo();
                    request.setAttribute("listaSolicitudesApoyo",listaSolicitudesApoyo);
                    request.getRequestDispatcher("NotificacionesDelActividad.jsp").forward(request,response);
                }else{
                    response.sendRedirect(request.getContextPath());
                }
                break;

            case "edit":


                String donacionId = request.getParameter("idDonacion");
                String montoDonacion = request.getParameter("montoDonacion");
                String estadoDonacion = request.getParameter("estadoDonacion");

                int donacionId_int = Integer.parseInt(donacionId);
                float monto = Float.parseFloat(montoDonacion);

                if(estadoDonacion.length()<11){

                    DaoNotificacionDelegadoGeneral daoNotificacionDelegadoGeneral = new DaoNotificacionDelegadoGeneral();
                    ArrayList<Usuario> listaSolicitudes = daoNotificacionDelegadoGeneral.listarSolicitudesDeRegistro();
                    ArrayList<Reporte> reportList = daoNotificacionDelegadoGeneral.listarNotificacionesReporte();
                    ArrayList<Donacion> donacionList = daoNotificacionDelegadoGeneral.listarNotificacionesDonaciones();


                    request.setAttribute("listaSolicitudes",listaSolicitudes);
                    request.setAttribute("reportList", reportList);
                    request.setAttribute("donacionList",donacionList);

                    Donacion donacion = new Donacion();
                    donacion.setIdDonacion(donacionId_int);
                    donacion.setMonto(monto);
                    donacion.setEstadoDonacion(estadoDonacion);

                    daoDonacion.editarDonacion(donacion);
                    response.sendRedirect(request.getContextPath()+  "/NotificacionesServlet?idUsuario="+idUsuario + "&vistaActualNueva=Donaciones");
                }else{
                    request.setAttribute("donacion",daoDonacion.buscarPorId(donacionId));
                    request.getRequestDispatcher("donacion_edit.jsp").forward(request,response);
                }
                break;



            case "filtrarFechaDelegadoGeneral":
                break;

        }
    }
}