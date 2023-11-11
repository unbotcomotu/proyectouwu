package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoActividad;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ListaDeActividadesServlet", value = "/ListaDeActividadesServlet")
public class ListaDeActividadesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
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
                if(rolUsuario.equals("Alumno")){
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado General")){
                    request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado de Actividad")){
                    int idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(idUsuario);
                    request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }
                break;
            case "buscarActividad":
                String actividad=request.getParameter("actividad");
                request.setAttribute("listaActividades",new DaoActividad().listarActividades(actividad));
                request.setAttribute("actividad",actividad);
                if(rolUsuario.equals("Alumno")){
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado General")){
                    request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado de Actividad")){
                    int idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(idUsuario);
                    request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }
                break;
            case "filtroActividad":
                int idFiltroActividades=Integer.parseInt(request.getParameter("idFiltroActividades"));
                int idOrdenarActividades=Integer.parseInt(request.getParameter("idOrdenarActividades"));
                request.setAttribute("listaActividades",new DaoActividad().listarActividades(idFiltroActividades,idOrdenarActividades,idUsuario));
                request.setAttribute("idFiltroActividades",idFiltroActividades);
                request.setAttribute("idOrdenarActividades",idOrdenarActividades);
                if(rolUsuario.equals("Alumno")){
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado General")){
                    request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }else if(rolUsuario.equals("Delegado de Actividad")){
                    int idActividadDelegatura=new DaoActividad().idDelegaturaPorIdDelegadoDeActividad(idUsuario);
                    request.setAttribute("idActividadDelegatura",idActividadDelegatura);
                    request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoActividad dActividad=new DaoActividad();
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        request.setAttribute("idUsuario",idUsuario);
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "finalizarActividad":
                Integer idActividadFinalizar=Integer.parseInt(request.getParameter("idActividadFinalizar"));
                dActividad.finalizarActividad(idActividadFinalizar);
                response.sendRedirect(request.getContextPath()+"/ListaDeActividadesServlet?idUsuario="+idUsuario);
                break;
            case "crearActividad":
                String nombreCrearActividad=request.getParameter("nombreCrearActividad");
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
                    String fotoCabecera="ola";
                    String fotoMiniatura="ola";
                    dActividad.crearActividad(nombreCrearActividad,idDelegadoActividadCrear,puntajeCrearActividad,ocultoCrearActividad,fotoCabecera,fotoMiniatura);
                    response.sendRedirect(request.getContextPath()+"/ListaDeActividadesServlet?idUsuario="+idUsuario);
                }catch (NumberFormatException e){
                    response.sendRedirect(request.getContextPath()+"/ListaDeActividadesServlet?idUsuario="+idUsuario+"&puntajeNoNumerico=1");
                }
                break;
            case "editarActividad":
                Integer idDelegadoActividadAnterior=Integer.parseInt(request.getParameter("idDelegadoActividadAnterior"));
                Integer idActividadEditar=Integer.parseInt(request.getParameter("idActividadEditar"));
                String nombreEditarActividad=request.getParameter("nombreEditarActividad");
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
                    String fotoCabeceraEditar="ola";
                    String fotoMiniaturaEditar="ola";
                    dActividad.editarActividad(idActividadEditar,nombreEditarActividad,idDelegadoActividadEditar,puntajeEditarActividad,ocultoEditarActividad,fotoCabeceraEditar,fotoMiniaturaEditar,idDelegadoActividadAnterior);
                    response.sendRedirect(request.getContextPath()+"/ListaDeActividadesServlet?idUsuario="+idUsuario);
                }catch (NumberFormatException e){
                    response.sendRedirect(request.getContextPath()+"/ListaDeActividadesServlet?idUsuario="+idUsuario+"&idActividadElegida="+idActividadEditar+"&puntajeNoNumerico=1");
                }

                break;
            case "notificacionLeidaCampanita":
                dN.notificacionLeida(Integer.parseInt(request.getParameter("idNotificacion")));
                response.sendRedirect(request.getContextPath()+"/ListaDeActividadesServlet?idUsuario="+idUsuario);
                break;
        }
    }
}