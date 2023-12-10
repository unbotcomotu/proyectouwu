package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoEvento;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.swing.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

@WebServlet(name = "ImagenActividadServlet", value = "/ImagenActividadServlet")
public class ImagenActividadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/png");

        String idActividad = request.getParameter("idActividad");
        if(idActividad==null){
            response.sendRedirect("PaginaNoExisteServlet");
        }else {
            DaoActividad dActividad = new DaoActividad();
            String rutaImagenPredeterminada = "/css/fibraVShormigon.png";

            try {
                Blob fotoBytesMiniatura = dActividad.obtenerFotoMiniaturaXIdActividad(Integer.parseInt(idActividad));
                Blob fotoBytesCabecera = dActividad.obtenerFotoCabeceraXIdActividad(Integer.parseInt(idActividad));

                int longitudMiniatura = (int) fotoBytesMiniatura.length();
                int longitudCabecera = (int) fotoBytesCabecera.length();

                byte[] fotoMiniatura = null;
                byte[] fotoCabecera = null;

                if (longitudMiniatura <= 100) {
                    InputStream inputMini = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    fotoMiniatura = new byte[inputMini.available()];
                    inputMini.read(fotoMiniatura);
                    inputMini.close();
                } else {
                    fotoMiniatura = fotoBytesMiniatura.getBytes(1, (int) fotoBytesMiniatura.length());
                }

                ServletOutputStream outputMini = response.getOutputStream();
                outputMini.write(fotoMiniatura);

                if (longitudCabecera <= 100) {
                    InputStream inputCabecera = getServletContext().getResourceAsStream(rutaImagenPredeterminada);
                    fotoCabecera = new byte[inputCabecera.available()];
                    inputCabecera.read(fotoCabecera);
                    inputCabecera.close();
                } else {
                    fotoCabecera = fotoBytesCabecera.getBytes(1, (int) fotoBytesCabecera.length());
                }

                ServletOutputStream outputCabecera = response.getOutputStream();
                outputCabecera.write(fotoCabecera);

            } catch (SQLException e) {
                ServletOutputStream output = response.getOutputStream();
                output.write(0);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
