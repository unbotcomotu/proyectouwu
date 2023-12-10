package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.imageio.ImageIO;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

@WebServlet(name = "EventoServlet", value = "/EventoServlet")
@MultipartConfig(maxFileSize = 10000000)
public class EventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoEvento dEvento=new DaoEvento();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            String idEventoAux=request.getParameter("idEvento");
            if(dEvento.existeEvento(idEventoAux)){
                int idEvento=Integer.parseInt(request.getParameter("idEvento"));
                String rolUsuario=dUsuario.rolUsuarioPorId(usuario.getIdUsuario());
                request.setAttribute("rolUsuario",rolUsuario);
                request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(usuario.getIdUsuario()));
                request.setAttribute("vistaActual","listaDeActividades");
                request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
                request.setAttribute("evento",dEvento.eventoPorIDsinMiniatura(idEvento));
                request.setAttribute("actividad",dEvento.actividadDeEventoPorID(idEvento));
                request.setAttribute("estadoApoyoAlumnoEvento",new DaoAlumnoPorEvento().verificarApoyo(idEvento,usuario.getIdUsuario()));
                request.setAttribute("lugar",dEvento.lugarPorEventoID(idEvento));
                request.setAttribute("delegadoDeEstaActividadID",dEvento.idDelegadoDeActividadPorEvento(idEvento));
                request.setAttribute("cantidadApoyos",dEvento.cantidadApoyosBarraEquipoPorEvento(idEvento));
                request.setAttribute("solicitudesApoyoPendientes",dEvento.solicitudesSinAtenderPorEvento(idEvento));
                request.setAttribute("listaDeMensajes",dEvento.listarMensajes(idEvento));
                if(rolUsuario.equals("Delegado General")){
                    request.setAttribute("listaNotificacionesCampanita",new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                } else if (rolUsuario.equals("Delegado de Actividad")) {
                    request.setAttribute("listaNotificacionesDelegadoDeActividad",new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                }
                String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
                switch (action){
                    case "default":
                        request.getRequestDispatcher("evento.jsp").forward(request,response);
                }
            }else{
                response.sendRedirect("PaginaNoExisteServlet");
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        DaoFotoEventoCarrusel dF=new DaoFotoEventoCarrusel();
        DaoEvento dE=new DaoEvento();
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            String idEventoStr=request.getParameter("idEvento");
            if(idEventoStr!=null){
                try{
                    int idEvento = Integer.parseInt(idEventoStr);
                    DaoNotificacion dN=new DaoNotificacion();
                    DaoReporte dR=new DaoReporte();
                    Imagen io=new Imagen();
                    String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
                    switch (action){
                        default:
                        case "default":
                            response.sendRedirect("PaginaNoExisteServlet");
                            break;
                        case "apoyoEvento":
                            new DaoAlumnoPorEvento().usuarioApoyaEvento(usuario.getIdUsuario(),idEvento);
                            //<a href="/proyectouwu_war_exploded/EventoServlet?idEvento=6&amp;idUsuario=17">
                            //http://localhost:8080/proyectouwu_war_exploded/EventoServlet?idEvento=6&idUsuario=17
                            response.sendRedirect(request.getContextPath()+"/EventoServlet?idEvento="+idEvento);
                            break;
                        case "editarCarrusel":
                            ArrayList<Integer> listaIDs= dF.idsFotosCarrusel(idEvento);
                            //asumiendo solo 3 imágenes por carrusel
                            for(int i=0;i<3;i++){
                                String borrar=request.getParameter("borrar"+(i+1));
                                if(borrar!=null){
                                    Part partFoto=request.getPart("foto"+(i+1));
                                    if(borrar.equals("0")){
                                        if(partFoto!=null){
                                            InputStream inputFoto=partFoto.getInputStream();
                                            String nombre= partFoto.getSubmittedFileName();
                                            if(inputFoto.available()<10){

                                            }else if(!io.isImageFile(nombre)){
                                                request.getSession().setAttribute("extensionInvalida"+(i+1),"1");
                                            }else if(!io.betweenScales(ImageIO.read(inputFoto),1.2,1.9)) {
                                                request.getSession().setAttribute("escalaInvalida"+(i+1), "1");
                                            }else {
                                                dF.actualizarImagenCarrusel(listaIDs.get(i),partFoto.getInputStream());
                                            }
                                            inputFoto.close();
                                        }
                                    }else {
                                        InputStream inputFoto = getServletContext().getResourceAsStream("/css/imagenBorrada.png");
                                        dF.actualizarImagenCarrusel(listaIDs.get(i),inputFoto);
                                        inputFoto.close();
                                    }
                                }else {
                                    break;
                                }
                            }
                            response.sendRedirect("EventoServlet?idEvento="+idEvento);
                            break;
                        case "enviarMensaje":
                            String mensaje=request.getParameter("mensaje");
                            if(mensaje!=null){
                                boolean validacion=true;
                                if(mensaje.length()>1000){
                                    request.getSession().setAttribute("mensajeLargo","1");
                                    validacion=false;
                                }
                                if(validacion){
                                    dE.enviarMensaje(usuario.getIdUsuario(),idEvento,mensaje);
                                }
                                request.getSession().setAttribute("abrirChat","1");
                            }
                            response.sendRedirect("EventoServlet?idEvento="+idEvento);
                            break;
                        case "reportar":
                            String motivo=request.getParameter("motivoReporte");
                            if(motivo!=null){
                                boolean validacionReportar=true;
                                if(motivo.length()>1000){
                                    request.getSession().setAttribute("reporteLargo","1");
                                    validacionReportar=false;
                                }
                                String idUsuarioAReportar=request.getParameter("idUsuarioReportado");
                                if(idUsuarioAReportar!=null&&validacionReportar){
                                    dR.reportarUsuario(idUsuarioAReportar,usuario.getIdUsuario(),motivo);
                                }
                            }
                            response.sendRedirect("EventoServlet?idEvento="+idEvento);
                            break;
                    }
                }catch (NumberFormatException e){
                    response.sendRedirect("PaginaNoExisteServlet");
                }
            }else {
                response.sendRedirect("PaginaNoExisteServlet");
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}