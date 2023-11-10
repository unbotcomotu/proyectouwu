package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.sql.Blob;
import java.sql.SQLException;

@WebServlet(name = "ImagenEventoServlet", value = "/ImagenEventoServlet")
public class ImagenEventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/jpeg");

        String idEvento = request.getParameter("idEvento");

        DaoEvento daoEvento = new DaoEvento();

        try {

            Blob fotoBytes = daoEvento.getFotoEventoPorID(Integer.parseInt(idEvento));
            int longitud = (int) fotoBytes.length();
            byte[] fotoMiniatura = null;

            if(longitud<=100){
                InputStream input = getServletContext().getResourceAsStream("/css/fibraVShormigon.png");
                fotoMiniatura = new byte[input.available()];
                input.read(fotoMiniatura);
                input.close();
            }else{
                fotoMiniatura = fotoBytes.getBytes(1,(int) fotoBytes.length());
            }

            ServletOutputStream output = response.getOutputStream();
            output.write(fotoMiniatura);

        } catch (SQLException e) {
            ServletOutputStream output = response.getOutputStream();
            output.write(0);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
