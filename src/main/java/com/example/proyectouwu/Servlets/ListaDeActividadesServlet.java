package com.example.proyectouwu.Servlets;

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
                if(rolUsuario.equals("Alumno")||rolUsuario.equals("Delegado General")){
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
                if(rolUsuario.equals("Alumno")||rolUsuario.equals("Delegado General")){
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
                request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoActividad dActividad=new DaoActividad();
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
                Integer puntajeCrearActividad=Integer.parseInt(request.getParameter("puntajeCrearActividad"));
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
                break;
        }
    }
}