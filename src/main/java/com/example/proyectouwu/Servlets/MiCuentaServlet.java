package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.sql.rowset.serial.SerialBlob;
import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;

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
            case("editarDescripcion"):
                Integer idUser = Integer.parseInt(request.getParameter("idUsuario"));
                String nuevaDescripcion = request.getParameter("nuevaDescripcion");
                //sentencia sql para actualizar:
                daoUsuario.cambioDescripcion(nuevaDescripcion, idUser);
                response.sendRedirect(request.getContextPath() + "/MiCuentaServlet?"+"idUsuario="+idUser);
                break;
            case "editarFoto":
                Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                byte[] bytes = request.getParameter("cambiarFoto").getBytes("UTF-8");
                try {
                    Blob cambiarFoto =  new SerialBlob(bytes);
                    //Aquí va el método
                    daoUsuario.cambiarFoto(idUsuario,cambiarFoto);
                    response.sendRedirect(request.getContextPath() + "/MiCuentaServlet?"+"idUsuario="+idUsuario);

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

            case("default"):
                //auxilio
                break;
        }

    }
}