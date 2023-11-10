package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ImagenUsuarioServlet", value = "/ImagenUsuarioServlet")
public class ImagenUsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/jpeg");

        String idUsuario = request.getParameter("idUsuario");

        DaoUsuario daoUsuario = new DaoUsuario();

        try {
            Usuario usuario = daoUsuario.getUsuarioPorIdSinFiltro(Integer.parseInt(idUsuario));
            byte[] fotoPerfil =  usuario.getFotoPerfil().getBytes(1,(int) usuario.getFotoPerfil().length());
            ServletOutputStream output = response.getOutputStream();
            output.write(fotoPerfil);

        } catch (SQLException e) {
            ServletOutputStream output = response.getOutputStream();
            output.write(0);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
