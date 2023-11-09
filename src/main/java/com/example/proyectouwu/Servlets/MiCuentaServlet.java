package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.sql.rowset.serial.SerialBlob;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;

@WebServlet(name = "MiCuentaServlet", value = "/MiCuentaServlet")
@MultipartConfig(maxFileSize = 10000000)
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

        // Variables inicializadas
        Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario"));;
        Part part = null;
        InputStream input = null;
        boolean validarLongitud;

        switch(action){
            case("editarDescripcion"):
                String nuevaDescripcion = request.getParameter("nuevaDescripcion");
                //sentencia sql para actualizar:
                daoUsuario.cambioDescripcion(nuevaDescripcion, idUsuario);
                response.sendRedirect(request.getContextPath() + "/MiCuentaServlet?"+"idUsuario="+idUsuario);
                break;
            case "editarFoto":
                part = request.getPart("cambiarFoto");

                // Obtenemos el flujo de bytes
                if(part != null){
                    input = part.getInputStream();
                }

                validarLongitud = input.available()>0;

                try {
                    daoUsuario.cambiarFoto(idUsuario,input,validarLongitud);
                } catch (SQLException e) {
                }

                response.sendRedirect(request.getContextPath() + "/MiCuentaServlet?"+"idUsuario="+idUsuario);
                break;
            case "editarSeguro":
                part = request.getPart("cambiarSeguro");

                // Obtenemos el flujo de bytes
                if(part != null){
                    input = part.getInputStream();
                }

                validarLongitud = input.available()>0;

                try {
                    daoUsuario.cambiarSeguro(idUsuario,input,validarLongitud);
                } catch (SQLException e) {
                }

                response.sendRedirect(request.getContextPath() + "/MiCuentaServlet?"+"idUsuario="+idUsuario);


            case("default"):
                //auxilio
                break;
        }

    }
}