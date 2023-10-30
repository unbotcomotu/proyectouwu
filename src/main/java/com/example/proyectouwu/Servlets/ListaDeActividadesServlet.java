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
        request.setAttribute("listaActividades",new DaoActividad().listarActividades());
        request.setAttribute("vistaActual","listaDeActividades");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        request.setAttribute("IDyNombreDelegadosDeActividad",dUsuario.listarIDyNombreDelegadosDeActividad());
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                if(rolUsuario.equals("Alumno")||rolUsuario.equals("Delegado General")){
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
            case "buscarActividad":
                String actividad=request.getParameter("actividad");
                request.setAttribute("listaActividades",new DaoActividad().listarActividades(actividad));
                request.setAttribute("actividad",actividad);
                request.getRequestDispatcher("listaDeActividades.jsp").forward(request,response);
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
}