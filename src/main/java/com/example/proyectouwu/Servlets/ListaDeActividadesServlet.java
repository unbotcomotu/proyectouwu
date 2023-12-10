package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoNotificacion;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoActividad;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.imageio.ImageIO;
import java.io.InputStream;
import java.io.IOException;

@WebServlet(name = "ListaDeActividadesServlet", value = "/ListaDeActividadesServlet")
@MultipartConfig(maxFileSize = 10000000)
public class ListaDeActividadesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            request.setAttribute("vistaActual","listaDeActividades");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("IDyNombreDelegadosDeActividad",dUsuario.listarIDyNombreDelegadosDeActividad());
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            switch (action){
                default:
                case "default":
                    request.setAttribute("listaActividades",new DaoActividad().listarActividades());
                    switch (usuario.getRol()) {
                        case "Alumno":
                            request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                            break;
                        case "Delegado General":
                            request.setAttribute("listaNotificacionesCampanita", new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                            request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                            break;
                        case "Delegado de Actividad":
                            Integer idActividadDelegatura = new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                            request.setAttribute("listaNotificacionesDelegadoDeActividad", new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                            request.setAttribute("idActividadDelegatura", idActividadDelegatura);
                            request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                            break;
                    }
                    break;
                case "buscarActividad":
                    String actividad=request.getParameter("actividad");
                    if(actividad!=null){
                        request.setAttribute("listaActividades",new DaoActividad().listarActividades(actividad));
                        request.setAttribute("actividad",actividad);
                        switch (usuario.getRol()) {
                            case "Alumno":
                                request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                                break;
                            case "Delegado General":
                                request.setAttribute("listaNotificacionesCampanita", new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                                request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                                break;
                            case "Delegado de Actividad":
                                Integer idActividadDelegatura = new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                                request.setAttribute("listaNotificacionesDelegadoDeActividad", new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                                request.setAttribute("idActividadDelegatura", idActividadDelegatura);
                                request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                                break;
                        }
                    }else {
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                    break;
                case "filtroActividad":
                    String idFiltroActividades=request.getParameter("idFiltroActividades");
                    String idOrdenarActividades=request.getParameter("idOrdenarActividades");
                    if(idOrdenarActividades!=null&&idFiltroActividades!=null){
                        if(!(idOrdenarActividades.equals("0") || idOrdenarActividades.equals("1"))){
                            idOrdenarActividades="0";
                        }
                        if(usuario.getRol().equals("Alumno")){
                            if(!(idFiltroActividades.equals("0") || idFiltroActividades.equals("1") || idFiltroActividades.equals("2") || idFiltroActividades.equals("3"))){
                                idFiltroActividades="0";
                            }
                        }else{
                            if(!(idFiltroActividades.equals("0") || idFiltroActividades.equals("1") || idFiltroActividades.equals("2") || idFiltroActividades.equals("3") || idFiltroActividades.equals("4"))){
                                idFiltroActividades="0";
                            }
                        }
                        request.setAttribute("listaActividades",new DaoActividad().listarActividades(idFiltroActividades,idOrdenarActividades,usuario.getIdUsuario()));
                        request.setAttribute("idFiltroActividades",idFiltroActividades);
                        request.setAttribute("idOrdenarActividades",idOrdenarActividades);
                        switch (usuario.getRol()) {
                            case "Alumno":
                                request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                                break;
                            case "Delegado General":
                                request.setAttribute("listaNotificacionesCampanita", new DaoNotificacion().listarNotificacionesDelegadoGeneral());
                                request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                                break;
                            case "Delegado de Actividad":
                                Integer idActividadDelegatura = new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                                request.setAttribute("listaNotificacionesDelegadoDeActividad", new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
                                request.setAttribute("idActividadDelegatura", idActividadDelegatura);
                                request.getRequestDispatcher("listaDeActividades.jsp").forward(request, response);
                                break;
                        }
                    }else {
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario = new DaoUsuario();
        DaoActividad dActividad = new DaoActividad();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");

            // Parámetros auxiliares para imagenes cabecera y miniatura
            Part partMin = null;
            Part partCab = null;
            String nombreMin;
            String nombreCab;
            InputStream inputMin = null;
            InputStream inputCab = null;
            boolean validarLongitudMin=false;
            boolean validarLongitudCab=false;
            Imagen io=new Imagen();
            String rutaImagenPredeterminada = "/css/fibraVShormigon.png";

            switch (action){
                case "default":
                default:
                    response.sendRedirect("ListaDeActividadesServlet");
                    break;
                case "finalizarActividad":

                    String idActividadFinalizarStr = request.getParameter("idActividadFinalizar");

                    if (idActividadFinalizarStr!=null&&idActividadFinalizarStr.matches("\\d+")){

                        if (dActividad.existeActividad(idActividadFinalizarStr)){
                            int idActividadFinalizar=Integer.parseInt(request.getParameter("idActividadFinalizar"));
                            dActividad.finalizarActividad(idActividadFinalizar);
                            response.sendRedirect("ListaDeActividadesServlet");
                        }else{
                            response.sendRedirect("ListaDeActividadesServlet");
                        }

                    }else{
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                    break;
                case "crearActividad":
                    boolean validacionCrear=true;
                    String nombreCrearActividad=request.getParameter("nombreCrearActividad");
                    if(nombreCrearActividad==null){
                        validacionCrear=false;
                    }else{
                        if(nombreCrearActividad.length()>45) {
                        request.getSession().setAttribute("nombreLargo", "1");
                        validacionCrear=false;
                        }
                        if(dActividad.verificarActividadRepetida(nombreCrearActividad,0)){
                            request.getSession().setAttribute("actividadRepetida","1");
                            validacionCrear=false;
                        }
                    }
                    String idDelegadoActividadCrear=request.getParameter("idDelegadoActividadCrear");
                    if(idDelegadoActividadCrear==null){
                        validacionCrear=false;
                    }
                    String puntajeCrearActividad=request.getParameter("puntajeCrearActividad");
                    if(puntajeCrearActividad==null){
                        validacionCrear=false;
                    }else{
                        try{
                            Integer puntajeAux=Integer.parseInt(puntajeCrearActividad);
                        }catch (NumberFormatException e)    {
                            request.getSession().setAttribute("puntajeNoNumerico","1");
                            validacionCrear=false;
                        }
                    }
                    boolean ocultoCrearActividad;
                    ocultoCrearActividad= request.getParameter("ocultoCrearActividad") != null;
                    //fotoCabecera=inputCab;
                    partCab = request.getPart("addfotoCabecera");
                    // Obtenemos el flujo de bytes
                    if(partCab != null){
                        inputCab = partCab.getInputStream();
                        nombreCab= partCab.getSubmittedFileName();
                        if(!io.isImageFile(nombreCab)){
                            request.getSession().setAttribute("extensionInvalidaCab","1");
                            validacionCrear=false;
                        }else if(!io.betweenScales(ImageIO.read(partCab.getInputStream()),0.5,2)) {
                            request.getSession().setAttribute("escalaInvalidaCab", "1");
                            validacionCrear = false;
                        }
                    }else{
                        inputCab = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }
                    validarLongitudCab = inputCab.available()>10;
                    if(!validarLongitudCab){
                        inputCab = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }


                    // fotoMiniatura==inputMin;
                    partMin = request.getPart("addfotoMiniatura");

                    // Obtenemos el flujo de bytes
                    if(partMin != null){
                        inputMin = partMin.getInputStream();
                        nombreMin= partMin.getSubmittedFileName();
                        if(!io.isImageFile(nombreMin)){
                            request.getSession().setAttribute("extensionInvalidaMin","1");
                            validacionCrear=false;
                        }else if(!io.betweenScales(ImageIO.read(partMin.getInputStream()),0.666,1.5)) {
                            request.getSession().setAttribute("escalaInvalidaMin", "1");
                            validacionCrear = false;
                        }
                    }else{
                        inputMin = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }
                    validarLongitudMin = inputMin.available()>10;
                    if(!validarLongitudMin){
                        inputMin = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }
                    if(validacionCrear){
                        dActividad.crearActividad(nombreCrearActividad,idDelegadoActividadCrear,Integer.parseInt(puntajeCrearActividad),ocultoCrearActividad,inputCab,inputMin);
                    }
                    inputMin.close();
                    inputCab.close();
                    response.sendRedirect("ListaDeActividadesServlet");
                    break;

                case "editarActividad":
                    boolean validacionEditar=true;

                    String idDelegadoActividadAnteriorStr = request.getParameter("idDelegadoActividadAnterior");

                    if(idDelegadoActividadAnteriorStr!=null){
                        if (idDelegadoActividadAnteriorStr.matches("\\d+")){

                            if (dUsuario.existeUsuario(idDelegadoActividadAnteriorStr)){

                                Integer idDelegadoActividadAnterior=Integer.parseInt(request.getParameter("idDelegadoActividadAnterior"));

                                String idActividadEditarStr = request.getParameter("idActividadEditar");

                                if (idActividadEditarStr.matches("\\d+")){

                                    if (dActividad.existeActividad(idActividadEditarStr)){
                                        Integer idActividadEditar=Integer.parseInt(request.getParameter("idActividadEditar"));
                                        String nombreEditarActividad=request.getParameter("nombreEditarActividad");
                                        if(nombreEditarActividad!=null){
                                            if(nombreEditarActividad.length()>45){
                                                request.getSession().setAttribute("nombreLargo","1");
                                                validacionEditar=false;
                                            }if(dActividad.verificarActividadRepetida(nombreEditarActividad,idActividadEditar)){
                                                request.getSession().setAttribute("actividadRepetida","1");
                                                validacionEditar=false;
                                            }
                                            String idDelegadoActividadEditarStr = request.getParameter("idDelegadoActividadEditar");
                                            if(idDelegadoActividadEditarStr!=null){
                                                if (idDelegadoActividadEditarStr.matches("\\d+") && dUsuario.existeUsuario(idDelegadoActividadEditarStr)){
                                                    Integer idDelegadoActividadEditar=Integer.parseInt(request.getParameter("idDelegadoActividadEditar"));
                                                    if(!dUsuario.usuarioEsDelegadoDeActividad(idDelegadoActividadEditar)||idDelegadoActividadEditar==idDelegadoActividadAnterior){
                                                        String puntajeEditarActividad=request.getParameter("puntajeEditarActividad");
                                                        if(puntajeEditarActividad!=null){
                                                            try{
                                                                Integer puntajeAux2=Integer.parseInt(puntajeEditarActividad);
                                                            }catch (NumberFormatException e){
                                                                request.getSession().setAttribute("puntajeNoNumerico","1");
                                                                validacionEditar=false;
                                                            }
                                                            boolean ocultoEditarActividad;
                                                            ocultoEditarActividad= request.getParameter("ocultoEditarActividad") != null;
                                                            //fotoCabeceraEditar==inputCab;
                                                            partCab = request.getPart("updateFotoCabecera");

                                                            // Obtenemos el flujo de bytes
                                                            if (partCab != null) {
                                                                inputCab = partCab.getInputStream();
                                                                validarLongitudCab = inputCab.available() > 10;
                                                                nombreCab=partCab.getSubmittedFileName();
                                                                if(!validarLongitudCab){
                                                                }else if(!io.isImageFile(nombreCab)){
                                                                    request.getSession().setAttribute("extensionInvalidaCab","1");
                                                                    validacionEditar=false;
                                                                }else if(!io.betweenScales(ImageIO.read(partCab.getInputStream()),0.5,2)) {
                                                                    request.getSession().setAttribute("escalaInvalidaCab", "1");
                                                                    validacionEditar = false;
                                                                }
                                                            }


                                                            //fotoMiniaturaEditar==inputMin;
                                                            partMin = request.getPart("updateFotoMiniatura");

                                                            // Obtenemos el flujo de bytes
                                                            if (partMin != null) {
                                                                inputMin = partMin.getInputStream();
                                                                validarLongitudMin = inputMin.available() > 10;
                                                                nombreMin= partMin.getSubmittedFileName();
                                                                if(!validarLongitudMin){
                                                                }else if(!io.isImageFile(nombreMin)){
                                                                    request.getSession().setAttribute("extensionInvalidaMin","1");
                                                                    validacionEditar=false;
                                                                }else if(!io.betweenScales(ImageIO.read(partMin.getInputStream()),0.666,1.5)) {
                                                                    request.getSession().setAttribute("escalaInvalidaMin", "1");
                                                                    validacionEditar = false;
                                                                }
                                                            }

                                                            if(validacionEditar){
                                                                dActividad.editarActividad(idActividadEditar,nombreEditarActividad,idDelegadoActividadEditar,Integer.parseInt(puntajeEditarActividad),ocultoEditarActividad,inputCab,inputMin,idDelegadoActividadAnterior,validarLongitudCab,validarLongitudMin);
                                                            }else{
                                                                request.getSession().setAttribute("idActividadElegida",idActividadEditar);
                                                            }
                                                            if (inputMin != null) {
                                                                inputMin.close();
                                                            }
                                                            if (inputCab != null) {
                                                                inputCab.close();
                                                            }
                                                            response.sendRedirect("ListaDeActividadesServlet");
                                                        }else {
                                                            response.sendRedirect("ListaDeActividadesServlet");
                                                        }
                                                    }else {
                                                        response.sendRedirect("ListaDeActividadesServlet");
                                                    }
                                                }else{
                                                    response.sendRedirect("ListaDeActividadesServlet");
                                                }
                                            }else {
                                                response.sendRedirect("ListaDeActividadesServlet");
                                            }
                                        }else {
                                            response.sendRedirect("ListaDeActividadesServlet");
                                        }
                                    }else{
                                        response.sendRedirect("ListaDeActividadesServlet");
                                    }
                                }else {
                                    response.sendRedirect("ListaDeActividadesServlet");
                                }
                            }else{
                                response.sendRedirect("ListaDeActividadesServlet");
                            }
                        }else{
                            response.sendRedirect("ListaDeActividadesServlet");
                        }
                    }else {
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}