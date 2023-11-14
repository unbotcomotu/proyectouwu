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
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario = new DaoUsuario();
        DaoActividad dActividad = new DaoActividad();
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
                String nombreCrearActividad=request.getParameter("nombreCrearActividad");
                if(dActividad.verificarActividadRepetida(nombreCrearActividad)){
                    request.getSession().setAttribute("actividadRepetida","1");
                    response.sendRedirect("ListaDeActividadesServlet");
                }else {
                    Integer idDelegadoActividadCrear=Integer.parseInt(request.getParameter("idDelegadoActividadCrear"));
                    String puntajeAux=request.getParameter("puntajeCrearActividad");
                    try{
                        Integer puntajeCrearActividad=Integer.parseInt(puntajeAux);
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

                        try{
                            dActividad.crearActividad(nombreCrearActividad,idDelegadoActividadCrear,puntajeCrearActividad,ocultoCrearActividad,inputCab,inputMin);
                        }catch (SQLException e) {
                            throw new RuntimeException(e);
                        }

                        //response.sendRedirect("ListaDeActividadesServlet");
                        inputMin.close();
                        inputCab.close();
                    }catch (NumberFormatException e){
                        request.getSession().setAttribute("puntajeNoNumerico","1");
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                }
                break;
            case "editarActividad":
                Integer idDelegadoActividadAnterior=Integer.parseInt(request.getParameter("idDelegadoActividadAnterior"));
                Integer idActividadEditar=Integer.parseInt(request.getParameter("idActividadEditar"));
                String nombreEditarActividad=request.getParameter("nombreEditarActividad");
                if(dActividad.verificarActividadRepetida(nombreEditarActividad)){
                    request.getSession().setAttribute("actividadRepetida","1");
                    request.getSession().setAttribute("idActividadElegida",idActividadEditar);
                    response.sendRedirect("ListaDeActividadesServlet");
                }else {
                    Integer idDelegadoActividadEditar=Integer.parseInt(request.getParameter("idDelegadoActividadEditar"));
                    String puntajeAux2=request.getParameter("puntajeEditarActividad");
                    try{
                        Integer puntajeEditarActividad=Integer.parseInt(puntajeAux2);
                        boolean ocultoEditarActividad;
                        if(request.getParameter("ocultoEditarActividad")!=null){
                            ocultoEditarActividad=true;
                        }else{
                            ocultoEditarActividad=false;
                        }
                        //String fotoCabeceraEditar==inputCab;
                        partCab = request.getPart("updateFotoCabecera");

                        // Obtenemos el flujo de bytes
                        if (partCab != null) {
                            inputCab = partCab.getInputStream();
                        }

                        validarLongitudCab = inputCab.available() > 10;


                        //String fotoMiniaturaEditar==inputMin;
                        partMin = request.getPart("updateFotoMiniatura");

                        // Obtenemos el flujo de bytes
                        if (partMin != null) {
                            inputMin = partMin.getInputStream();
                        }

                        validarLongitudMin = inputMin.available() > 10;

                        try {
                            dActividad.editarActividad(idActividadEditar,nombreEditarActividad,idDelegadoActividadEditar,puntajeEditarActividad,ocultoEditarActividad,inputCab,inputMin,idDelegadoActividadAnterior,validarLongitudCab,validarLongitudMin);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        response.sendRedirect("ListaDeActividadesServlet");
                    }catch (NumberFormatException e){
                        request.getSession().setAttribute("puntajeNoNumerico","1");
                        request.getSession().setAttribute("idActividadElegida",idActividadEditar);
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                }
                break;
            case "notificacionLeidaCampanita":
                dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                response.sendRedirect("ListaDeActividadesServlet");
                break;
        }
    }
}