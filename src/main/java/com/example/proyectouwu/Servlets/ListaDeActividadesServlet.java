package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoActividad;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.sql.SQLException;
import java.io.InputStream;
import java.io.IOException;
import java.io.PrintWriter;

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
                case "default":
                    request.setAttribute("listaActividades",new DaoActividad().listarActividades());
                    String idActividadAux=request.getParameter("idActividadElegida");
                    if(idActividadAux!=null){
                        request.setAttribute("idActividadElegida",Integer.parseInt(idActividadAux));
                    }
                    request.setAttribute("puntajeNoNumerico",request.getParameter("puntajeNoNumerico"));
                    if(usuario.getRol().equals("Alumno")){
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado General")){
                        request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado de Actividad")){
                        Integer idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                        request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }
                    break;
                case "buscarActividad":
                    String actividad=request.getParameter("actividad");
                    request.setAttribute("listaActividades",new DaoActividad().listarActividades(actividad));
                    request.setAttribute("actividad",actividad);
                    if(usuario.getRol().equals("Alumno")){
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado General")){
                        request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado de Actividad")){
                        Integer idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                        request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }
                    break;
                case "filtroActividad":
                    int idFiltroActividades=Integer.parseInt(request.getParameter("idFiltroActividades"));
                    int idOrdenarActividades=Integer.parseInt(request.getParameter("idOrdenarActividades"));
                    request.setAttribute("listaActividades",new DaoActividad().listarActividades(idFiltroActividades,idOrdenarActividades,usuario.getIdUsuario()));
                    request.setAttribute("idFiltroActividades",idFiltroActividades);
                    request.setAttribute("idOrdenarActividades",idOrdenarActividades);
                    if(usuario.getRol().equals("Alumno")){
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado General")){
                        request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                    }else if(usuario.getRol().equals("Delegado de Actividad")){
                        Integer idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(usuario.getIdUsuario());
                        request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                        request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
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
            DaoNotificacionDelegadoGeneral dN = new DaoNotificacionDelegadoGeneral();
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");

            // Parámetros auxiliares para imagenes cabecera y miniatura
            Part partMin = null;
            Part partCab = null;
            InputStream inputMin = null;
            InputStream inputCab = null;
            boolean validarLongitudMin;
            boolean validarLongitudCab;
            String rutaImagenPredeterminada = "/css/fibraVShormigon.png";

            switch (action){
                case "finalizarActividad":
                    Integer idActividadFinalizar=Integer.parseInt(request.getParameter("idActividadFinalizar"));
                    dActividad.finalizarActividad(idActividadFinalizar);
                    response.sendRedirect("ListaDeActividadesServlet");
                    break;
                case "crearActividad":
                    boolean validacionCrear=true;
                    String nombreCrearActividad=request.getParameter("nombreCrearActividad");
                    if(nombreCrearActividad.length()>45) {
                        request.getSession().setAttribute("nombreLargo", "1");
                        validacionCrear=false;
                    }
                    if(dActividad.verificarActividadRepetida(nombreCrearActividad,0)){
                        request.getSession().setAttribute("actividadRepetida","1");
                        validacionCrear=false;
                    }
                    Integer idDelegadoActividadCrear=Integer.parseInt(request.getParameter("idDelegadoActividadCrear"));
                    String puntajeCrearActividad=request.getParameter("puntajeCrearActividad");
                    try{
                        Integer puntajeAux=Integer.parseInt(puntajeCrearActividad);
                    }catch (NumberFormatException e){
                        request.getSession().setAttribute("puntajeNoNumerico","1");
                        validacionCrear=false;
                    }

                    boolean ocultoCrearActividad;
                    if(request.getParameter("ocultoCrearActividad")!=null){
                        ocultoCrearActividad=true;
                    }else{
                        ocultoCrearActividad=false;
                    }
                    //fotoCabecera=inputCab;
                    partCab = request.getPart("addfotoCabecera");
                    // Obtenemos el flujo de bytes
                    if(partCab != null){
                        inputCab = partCab.getInputStream();
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
                    }else{
                        inputMin = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }
                    validarLongitudMin = inputMin.available()>10;
                    if(!validarLongitudMin){
                        inputMin = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    }
                    if(validacionCrear){
                        try{
                            dActividad.crearActividad(nombreCrearActividad,idDelegadoActividadCrear,Integer.parseInt(puntajeCrearActividad),ocultoCrearActividad,inputCab,inputMin);
                        }catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                    }
                    inputMin.close();
                    inputCab.close();
                    response.sendRedirect("ListaDeActividadesServlet");
                    break;

                case "editarActividad":
                    boolean validacionEditar=true;
                    Integer idDelegadoActividadAnterior=Integer.parseInt(request.getParameter("idDelegadoActividadAnterior"));
                    Integer idActividadEditar=Integer.parseInt(request.getParameter("idActividadEditar"));
                    String nombreEditarActividad=request.getParameter("nombreEditarActividad");
                    if(nombreEditarActividad.length()>45){
                        request.getSession().setAttribute("nombreLargo","1");
                        validacionEditar=false;
                    }
                    if(dActividad.verificarActividadRepetida(nombreEditarActividad,idActividadEditar)){
                        request.getSession().setAttribute("actividadRepetida","1");
                        validacionEditar=false;
                    }
                    Integer idDelegadoActividadEditar=Integer.parseInt(request.getParameter("idDelegadoActividadEditar"));
                    String puntajeEditarActividad=request.getParameter("puntajeEditarActividad");
                    try{
                        Integer puntajeAux2=Integer.parseInt(puntajeEditarActividad);
                    }catch (NumberFormatException e){
                        request.getSession().setAttribute("puntajeNoNumerico","1");
                        validacionEditar=false;
                    }
                    boolean ocultoEditarActividad;
                    if(request.getParameter("ocultoEditarActividad")!=null){
                        ocultoEditarActividad=true;
                    }else{
                        ocultoEditarActividad=false;
                    }
                    //fotoCabeceraEditar==inputCab;
                    partCab = request.getPart("updateFotoCabecera");

                    // Obtenemos el flujo de bytes
                    if (partCab != null) {
                        inputCab = partCab.getInputStream();
                    }

                    validarLongitudCab = inputCab.available() > 10;


                    //fotoMiniaturaEditar==inputMin;
                    partMin = request.getPart("updateFotoMiniatura");

                    // Obtenemos el flujo de bytes
                    if (partMin != null) {
                        inputMin = partMin.getInputStream();
                    }

                    validarLongitudMin = inputMin.available() > 10;
                    if(validacionEditar){
                        try {
                            dActividad.editarActividad(idActividadEditar,nombreEditarActividad,idDelegadoActividadEditar,Integer.parseInt(puntajeEditarActividad),ocultoEditarActividad,inputCab,inputMin,idDelegadoActividadAnterior,validarLongitudCab,validarLongitudMin);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
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
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}