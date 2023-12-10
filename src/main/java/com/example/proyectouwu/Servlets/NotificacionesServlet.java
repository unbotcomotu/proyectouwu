package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.*;
import com.example.proyectouwu.Daos.DaoDonacion;
import com.example.proyectouwu.Daos.DaoNotificacion;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
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
        DaoNotificacion daoNotificacion = new DaoNotificacion();
        request.setAttribute("vistaActual","---");
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            if(usuario.getRol().equals("Delegado General")){
                request.setAttribute("listaNotificacionesCampanita",new DaoNotificacion().listarNotificacionesDelegadoGeneral());
            }else if(usuario.getRol().equals("Delegado de Actividad")){
                request.setAttribute("listaNotificacionesDelegadoDeActividad",new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
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
            request.setAttribute("ip", daoNotificacion.obtenerDireccionIP());
            switch (action){
                case "default":
                    if (usuario.getRol().equals("Delegado General")){
                        String vistaActualNueva = request.getParameter("vistaActualNueva");
                        request.setAttribute("vistaActualNueva",vistaActualNueva);
                        //saca del modelo
                        page = request.getParameter("p")==null? "1" : request.getParameter("p");

                        if (page.matches("\\d+")){
                            pagina = Integer.parseInt(page);

                        }else{
                            pagina = 1;
                        }


                        pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");

                        if (pageD.matches("\\d+")){
                            paginaD = Integer.parseInt(pageD);

                        }else{
                            paginaD = 1;
                        }


                        pageV = request.getParameter("pv")==null? "1" : request.getParameter("pv");

                        if (pageV.matches("\\d+")){
                            paginaV = Integer.parseInt(pageV);

                        }else{
                            paginaV = 1;
                        }

                        ArrayList<Usuario> listaSolicitudes = daoNotificacion.listarSolicitudesRegistroPorPage(pagina-1);
                        ArrayList<Reporte> reportList = daoNotificacion.listarNotificacionesReporte();
                        ArrayList<Donacion> donacionList = daoNotificacion.listarNotificacionesDonaciones(paginaD-1);
                        ArrayList<Validacion> recuperacionList = daoNotificacion.listarNotificacionesRecuperacion(paginaV-1);
                        //mandar la lista a la vista
                        request.setAttribute("pagActual", pagina);
                        request.setAttribute("pagActualD",paginaD);
                        request.setAttribute("pagActualV",paginaV);
                        request.setAttribute("listaSolicitudes",listaSolicitudes);
                        request.setAttribute("cantidadTotalSolicitudes", daoNotificacion.listarSolicitudesDeRegistro().size());
                        request.setAttribute("reportList", reportList);
                        request.setAttribute("donacionList",donacionList);
                        request.setAttribute("cantidadTotalDonaciones", daoNotificacion.listarNotificacionesDonaciones().size());
                        request.setAttribute("cantidadTotalValidaciones", daoNotificacion.listarNotificacionesRecuperacion().size());
                        request.setAttribute("recuperacionList",recuperacionList);
                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                    }else if (usuario.getRol().equals("Delegado de Actividad")){
                        page = request.getParameter("p");
                        if(page!=null){
                            request.getSession().removeAttribute("pSolicitudesDeApoyo");
                            request.getSession().setAttribute("pSolicitudesDeApoyo",page);
                        }
                        int pSolicitudesDeApoyo =Integer.parseInt((String) request.getSession().getAttribute("pSolicitudesDeApoyo"));
                        DaoNotificacion daoNotificacionesDeleActividad = new DaoNotificacion();
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

                        if (page.matches("\\d+")){
                            pagina = Integer.parseInt(page);

                        }else{
                            pagina = 1;
                        }

                        pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");

                        if (pageD.matches("\\d+")){
                            paginaD = Integer.parseInt(pageD);

                        }else{
                            paginaD = 1;
                        }


                        String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                        ArrayList<Usuario> listaSolicitudes = daoNotificacion.listarSolicitudesDeRegistro(busquedaSolicitudes,pagina-1);
                        ArrayList<Reporte> reportList = daoNotificacion.listarNotificacionesReporte();
                        ArrayList<Donacion> donacionList = daoNotificacion.listarNotificacionesDonaciones(paginaD-1);
                        ArrayList<Validacion> recuperacionList = daoNotificacion.listarNotificacionesRecuperacion();

                        request.setAttribute("cantidadTotalSolicitudes", daoNotificacion.listarSolicitudesDeRegistro(busquedaSolicitudes).size());
                        request.setAttribute("action", action);
                        request.setAttribute("pagActual", pagina);
                        request.setAttribute("pagActualD",paginaD);
                        request.setAttribute("pagActualV",paginaV);
                        request.setAttribute("busquedaSolicitudes",busquedaSolicitudes);
                        request.setAttribute("listaSolicitudes",listaSolicitudes);
                        request.setAttribute("reportList", reportList);
                        request.setAttribute("donacionList",donacionList);
                        request.setAttribute("recuperacionList",recuperacionList);
                        request.setAttribute("alerta","monto");

                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);

                    }else if (usuario.getRol().equals("Delegado de Actividad")){
                        String busquedaSolicitudes=request.getParameter("busquedaSolicitudes");
                        DaoNotificacion daoNotificacionesDeleActividad = new DaoNotificacion();
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

                    if (page.matches("\\d+")){
                        pagina = Integer.parseInt(page);

                    }else{
                        pagina = 1;
                    }



                    pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");
                    if (pageD.matches("\\d+")){
                        paginaD = Integer.parseInt(pageD);

                    }else{
                        paginaD = 1;
                    }



                    request.setAttribute("alerta","monto");

                    ArrayList<Usuario> listaSolicitudes = daoNotificacion.listarSolicitudesRegistroPorPage(pagina-1);
                    ArrayList<Reporte> reportList = daoNotificacion.listarNotificacionesReporte();
                    ArrayList<Validacion> recuperacionList = daoNotificacion.listarNotificacionesRecuperacion();
                    request.setAttribute("buscar",buscar);
                    request.setAttribute("fecha1",fecha1);
                    request.setAttribute("fecha2",fecha2);
                    request.setAttribute("pagActual", pagina);
                    request.setAttribute("pagActualD",paginaD);
                    request.setAttribute("cantidadTotalSolicitudes", daoNotificacion.listarSolicitudesDeRegistro().size());
                    request.setAttribute("action", action);
                    request.setAttribute("listaSolicitudes",listaSolicitudes);
                    request.setAttribute("cantidadTotalDonaciones", daoNotificacion.listarNotificacionesDonaciones(buscar).size());
                    request.setAttribute("reportList", reportList);
                    request.setAttribute("donacionList", daoNotificacion.juntarListas(daoNotificacion.listarNotificacionesDonaciones(buscar,paginaD-1), daoNotificacion.listarNotificacionesDonaciones(fecha1,fecha2,paginaD-1)));
                    request.setAttribute("recuperacionList",recuperacionList);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    break;

                case "filtrarDonaciones":
                    request.setAttribute("vistaActualNueva","Donaciones");
                    buscar = request.getParameter("buscar");
                    fecha1=request.getParameter("fecha1");
                    fecha2=request.getParameter("fecha2");

                    page = request.getParameter("p")==null? "1" : request.getParameter("p");

                    if (page.matches("\\d+")){
                        pagina = Integer.parseInt(page);

                    }else{
                        pagina = 1;
                    }


                    pageD = request.getParameter("pd") == null ? "1" : request.getParameter("pd");
                    if (pageD.matches("\\d+")){
                        paginaD = Integer.parseInt(pageD);

                    }else{
                        paginaD = 1;
                    }


                    ArrayList<Usuario> listaSolicitudes1 = daoNotificacion.listarSolicitudesRegistroPorPage(pagina-1);
                    ArrayList<Reporte> reportList1 = daoNotificacion.listarNotificacionesReporte();
                    ArrayList<Validacion> recuperacionList1 = daoNotificacion.listarNotificacionesRecuperacion();
                    request.setAttribute("fecha1",fecha1);
                    request.setAttribute("action", action);
                    request.setAttribute("cantidadTotalSolicitudes", daoNotificacion.listarSolicitudesDeRegistro().size());
                    request.setAttribute("fecha2",fecha2);
                    request.setAttribute("buscar",buscar);
                    request.setAttribute("pagActual", pagina);
                    request.setAttribute("pagActualD",paginaD);
                    request.setAttribute("listaSolicitudes",listaSolicitudes1);
                    request.setAttribute("reportList", reportList1);
                    request.setAttribute("donacionList", daoNotificacion.juntarListas(daoNotificacion.listarNotificacionesDonaciones(buscar,paginaD-1), daoNotificacion.listarNotificacionesDonaciones(fecha1,fecha2,paginaD-1)));
                    request.setAttribute("recuperacionList",recuperacionList1);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    break;
                case "buscarReportes":
                    request.setAttribute("vistaActualNueva","Reportes");
                    String buscarReportes=request.getParameter("buscarReportes");
                    ArrayList<Usuario> listaSolicitudes2 = daoNotificacion.listarSolicitudesDeRegistro();
                    ArrayList<Reporte> reportList2 = daoNotificacion.listarNotificacionesReporte(buscarReportes);
                    ArrayList<Donacion> donacionList2 = daoNotificacion.listarNotificacionesDonaciones();
                    ArrayList<Validacion> recuperacionList2 = daoNotificacion.listarNotificacionesRecuperacion();
                    request.setAttribute("buscarReportes",buscarReportes);
                    request.setAttribute("listaSolicitudes",listaSolicitudes2);
                    request.setAttribute("reportList", reportList2);
                    request.setAttribute("donacionList",donacionList2);
                    request.setAttribute("recuperacionList",recuperacionList2);
                    request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoDonacion daoDonacion = new DaoDonacion();
        DaoNotificacion dN=new DaoNotificacion();
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

                    if (donacionId!=null && estadoDonacion!=null){

                        if (donacionId.matches("\\d+") && (estadoDonacion.equals("Validado")|| estadoDonacion.equals("Pendiente"))&& daoDonacion.existeDonacion(donacionId)){
                            if (montoDonacion == null || montoDonacion.trim().isEmpty()) {
                                // Manejar el caso en que el montoDonacion es nulo o está vacío
                                request.setAttribute("alerta", "monto");
                                request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request, response);
                                return; // Salir del método para evitar continuar con el flujo normal
                            }

                            try{


                                int donacionId_int = Integer.parseInt(donacionId);
                                float monto = Float.parseFloat(montoDonacion);

                                DaoNotificacion daoNotificacion = new DaoNotificacion();
                                ArrayList<Usuario> listaSolicitudes = daoNotificacion.listarSolicitudesDeRegistro();
                                ArrayList<Reporte> reportList = daoNotificacion.listarNotificacionesReporte();
                                ArrayList<Donacion> donacionList = daoNotificacion.listarNotificacionesDonaciones();
                                ArrayList<Validacion> recuperacionList = daoNotificacion.listarNotificacionesRecuperacion();

                                request.setAttribute("listaSolicitudes",listaSolicitudes);
                                request.setAttribute("reportList", reportList);
                                request.setAttribute("donacionList",donacionList);
                                request.setAttribute("alerta","monto");
                                request.setAttribute("recuperacionList",recuperacionList);

                                Donacion donacion = new Donacion();
                                donacion.setIdDonacion(donacionId_int);
                                donacion.setMonto(monto);
                                donacion.setEstadoDonacion(estadoDonacion);

                                daoDonacion.editarDonacion(donacion);

                                response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");

                            }catch (NumberFormatException e){
                                request.setAttribute("alerta","monto");
                                request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                                response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");
                            }
                        }else{
                            response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");
                        }

                    }else{
                        response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");

                    }


                    break;
                case "editDonacion":
                    String id = request.getParameter("id");
                    Donacion donacion = daoDonacion.buscarPorId(id);

                    if(donacion != null){
                        request.setAttribute("donacion2",donacion);
                        request.getRequestDispatcher("/donacion_edit.jsp").forward(request,response);
                    }else{
                        request.getRequestDispatcher("notificacionesDelGeneral.jsp").forward(request,response);
                    }
                    break;
                case "deleteDonacion":

                    String idd = request.getParameter("id");

                    if (idd!=null){

                        if (idd.matches("\\d+") && daoDonacion.existeDonacion(idd)){
                            Donacion donacion1 = daoDonacion.buscarPorId(idd);

                            if(donacion1 != null){
                                try {
                                    daoDonacion.borrar(idd);
                                } catch (SQLException e) {
                                    System.out.println("Log: excepcion: " + e.getMessage());
                                }
                            }
                            response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");
                        }else{
                            response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");

                        }

                    }else{
                        response.sendRedirect("NotificacionesServlet?vistaActualNueva=Donaciones");

                    }

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
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}