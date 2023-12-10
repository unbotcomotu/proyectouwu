package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

@WebServlet(name = "Imagen", value = "/Imagen")
public class Imagen extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        if(id==null){
            response.sendRedirect("PaginaNoExisteServlet");
        }else {
            Blob fotoAux = (Blob) request.getSession().getAttribute("foto" + id);
            request.getSession().removeAttribute("foto" + id);
            if (fotoAux != null) {
                try {
                    byte[] foto = fotoAux.getBytes(1, (int) fotoAux.length());
                    response.getOutputStream().write(foto);
                } catch (SQLException e) {
                    response.getOutputStream().write(0);
                }
            } else {
                String tipoDeFoto = request.getParameter("tipoDeFoto");
                if(tipoDeFoto==null){
                    response.sendRedirect("PaginaNoExisteServlet");
                }else {
                    String rutaImagenPredeterminada = "";
                    if (tipoDeFoto.equals("fotoPerfil")) {
                        rutaImagenPredeterminada = "/css/iconoPerfil.png";
                    } else if (tipoDeFoto.equals("fotoActividadMiniatura")) {
                        rutaImagenPredeterminada = "/css/fotoVoleyActividades.png";
                    } else if (tipoDeFoto.equals("fotoActividadCabecera")) {
                        rutaImagenPredeterminada = "/css/telitoVoley.png";
                    } else if (tipoDeFoto.equals("fotoCarrusel")) {
                        rutaImagenPredeterminada = "/css/fotoYarleque.png";
                    } else if (tipoDeFoto.equals("fotoSeguro")) {
                        rutaImagenPredeterminada = "/css/sinImagen.jpg";
                    } else {
                        rutaImagenPredeterminada = "/css/errorImagen.jpg";
                    }
                    InputStream input = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    byte[] foto = new byte[input.available()];
                    input.read(foto);
                    input.close();
                    response.getOutputStream().write(foto);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public boolean isImageFile(String fileName) {
        String[] extensiones = {"jpg", "jpeg", "png", "gif"};
        for (String extension : extensiones) {
            if (fileName.toLowerCase().endsWith("." + extension)) {
                return true;
            }
        }
        return false;
    }

    public boolean betweenScales(BufferedImage imagen, double escala1, double escala2){
        return (imagen.getWidth()*1.0/imagen.getHeight()>escala1&&imagen.getWidth()*1.0/imagen.getHeight()<escala2);
    }
}