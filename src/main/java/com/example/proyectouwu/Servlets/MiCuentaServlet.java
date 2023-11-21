package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoNotificacionDelegadoGeneral;
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
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            String rolUsuario=dUsuario.rolUsuarioPorId(usuario.getIdUsuario());
            request.setAttribute("listaInfo",dUsuario.obtenerInfoPorId(usuario.getIdUsuario()));
            request.setAttribute("vistaActual","miCuenta");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("IDyNombreDelegadosDeActividad",dUsuario.listarIDyNombreDelegadosDeActividad());
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            if(rolUsuario.equals("Delegado General")){
                request.setAttribute("listaNotificacionesCampanita",new DaoNotificacionDelegadoGeneral().listarNotificacionesDelegadoGeneral());
            }
            switch (action){
                case "default":
                    request.getRequestDispatcher("miCuenta.jsp").forward(request,response);
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario = new DaoUsuario();
        DaoNotificacionDelegadoGeneral dN=new DaoNotificacionDelegadoGeneral();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            Part part = null;
            InputStream input = null;
            boolean validarLongitud;

            switch(action){
                case("editarDescripcion"):
                    String nuevaDescripcion = request.getParameter("nuevaDescripcion");
                    //sentencia sql para actualizar:
                    dUsuario.cambioDescripcion(nuevaDescripcion, usuario.getIdUsuario());
                    response.sendRedirect("MiCuentaServlet");
                    break;
                case "editarFoto":
                    part = request.getPart("cambiarFoto");

                    // Obtenemos el flujo de bytes uwu
                    if(part != null){
                        input = part.getInputStream();
                    }

                    validarLongitud = input.available()>10;

                    try {
                        dUsuario.cambiarFoto(usuario.getIdUsuario(),input,validarLongitud,"1");
                    } catch (SQLException e) {
                    }

                    input.close();
                    response.sendRedirect("MiCuentaServlet");
                    int idUsuario= usuario.getIdUsuario();
                    break;
                case "editarSeguro":
                    part = request.getPart("cambiarSeguro");

                    // Obtenemos el flujo de bytes owo
                    if(part != null){
                        input = part.getInputStream();
                    }

                    validarLongitud = input.available()>0;

                    try {
                        dUsuario.cambiarFoto(usuario.getIdUsuario(),input,validarLongitud,"2");
                    } catch (SQLException e) {
                    }

                    input.close();
                    response.sendRedirect( "MiCuentaServlet");

                case("default"):
                    //auxilio
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}