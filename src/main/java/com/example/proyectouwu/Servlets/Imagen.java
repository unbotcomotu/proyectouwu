package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

@WebServlet(name = "Imagen", value = "/Imagen")
public class Imagen extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        Blob fotoAux=(Blob) request.getSession().getAttribute("foto"+id);
        request.getSession().removeAttribute("foto"+id);
        if(fotoAux!=null){
            try {
                byte[] foto =  fotoAux.getBytes(1,(int) fotoAux.length());
                response.getOutputStream().write(foto);
            } catch (SQLException e) {
                response.getOutputStream().write(0);
            }
        }else{
            String rutaImagenPredeterminada = "/css/sin_foto_De_perfil.png";
            InputStream input = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
            byte[] foto = new byte[input.available()];
            input.read(foto);
            input.close();
            response.getOutputStream().write(foto);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}