package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoNotificacion;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.imageio.ImageIO;
import java.awt.*;
import java.io.IOException;
import java.io.InputStream;
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
                request.setAttribute("listaNotificacionesCampanita",new DaoNotificacion().listarNotificacionesDelegadoGeneral());
            }else if(rolUsuario.equals("Delegado de Actividad")){
                request.setAttribute("listaNotificacionesDelegadoDeActividad",new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
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
        DaoNotificacion dN=new DaoNotificacion();
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            Part part = null;
            Imagen io=new Imagen();
            switch(action){
                case("editarDescripcion"):
                    boolean descripcionValida = true;
                    String nuevaDescripcion = request.getParameter("nuevaDescripcion");
                    //sentencia sql para actualizar:
                    dUsuario.cambioDescripcion(nuevaDescripcion, usuario.getIdUsuario());
                    if(nuevaDescripcion==null || nuevaDescripcion.length()>1000 || nuevaDescripcion.isEmpty()){
                        descripcionValida=false;
                    }
                    if(descripcionValida){
                        //sentencia sql para actualizar:
                        dUsuario.cambioDescripcion(nuevaDescripcion, usuario.getIdUsuario());
                    }
                    response.sendRedirect("MiCuentaServlet");
                    break;
                case "editarFoto":
                    part = request.getPart("cambiarFoto");
                    if(part!=null){
                        InputStream inputPerfil=part.getInputStream();
                        String nombre= part.getSubmittedFileName();
                        if(inputPerfil.available()<10){
                        }else if(!io.isImageFile(nombre)){
                            request.getSession().setAttribute("extensionInvalidaPerfil","1");
                        }else if(!io.betweenScales(ImageIO.read(part.getInputStream()),0.5,2)) {
                            request.getSession().setAttribute("escalaInvalidaPerfil", "1");
                        }else {
                            dUsuario.cambiarFoto(usuario.getIdUsuario(),inputPerfil,true,"1");
                        }
                        inputPerfil.close();
                    }
                    break;
                case "editarSeguro":
                    part = request.getPart("cambiarSeguro");
                    if(part!=null){
                        InputStream inputSeguro=part.getInputStream();
                        String nombre= part.getSubmittedFileName();
                        if(inputSeguro.available()<10){
                        }else if(!io.isImageFile(nombre)){
                            request.getSession().setAttribute("extensionInvalidaSeguro","1");
                        }else if(!io.betweenScales(ImageIO.read(part.getInputStream()),0.25,4)) {
                            request.getSession().setAttribute("escalaInvalidaSeguro", "1");
                        }else {
                            dUsuario.cambiarFoto(usuario.getIdUsuario(),inputSeguro,true,"2");
                        }
                        inputSeguro.close();
                    }
                    break;
                case("default"):
                    //auxilio
                    break;
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
            response.sendRedirect("MiCuentaServlet");
        }
    }
}