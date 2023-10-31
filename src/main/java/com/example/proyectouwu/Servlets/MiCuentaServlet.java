package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "MiCuentaServlet", value = "/MiCuentaServlet")
public class MiCuentaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("listaInfo",dUsuario.obtenerInfoPorId(idUsuario));
        request.setAttribute("vistaActual","miCuenta");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        request.setAttribute("IDyNombreDelegadosDeActividad",dUsuario.listarIDyNombreDelegadosDeActividad());
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                request.getRequestDispatcher("miCuenta.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario daoUsuario = new DaoUsuario();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");

        switch(action){
            case("default"):
                //auxilio
                break;
            case("editarDescripcion"):
                Integer id = Integer.parseInt(request.getParameter("idUsuario"));
                String nuevaDescripcion = request.getParameter("nuevaDescripcion");
                //sentencia sql para actualizar:
                daoUsuario.cambioDescripcion(nuevaDescripcion, id);
                response.sendRedirect(request.getContextPath() + "/MiCuentaServlet?"+"idUsuario="+id);
                break;
        }

    }
}