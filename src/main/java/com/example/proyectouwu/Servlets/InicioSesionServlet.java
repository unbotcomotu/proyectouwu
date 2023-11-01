package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "InicioSesionServlet", value = "/InicioSesionServlet")
public class InicioSesionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action) {
            case "default":
                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                break;
            case "ola":
                //No se que poner
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":

                break;
            case "logIn":
                String correo = request.getParameter("correoPucp");
                String contrasena = request.getParameter("contrasena");
                ArrayList <Usuario> listaUsuario = new DaoUsuario().listarUsuariosTotal();
                int usuarioId = 0;
                boolean existeUsuario=  false;
                bucleUsuarios:
                for(Usuario user: listaUsuario){
                    if(correo.equals(user.getCorreo()) && contrasena.equals(user.getContrasena())){
                        usuarioId = user.getIdUsuario();
                        existeUsuario= true;
                        break bucleUsuarios;
                    }
                }
                if(existeUsuario && new DaoUsuario().getEstadoDeResgitroPorId(usuarioId).equals("Registrado") && new DaoUsuario().estaBaneadoporId(usuarioId)) {
                    response.sendRedirect(request.getContextPath() + "/ListaDeActividadesServlet?idUsuario="+usuarioId);
                    //request.setAttribute("idUsuario", Integer.toString(usuarioId));
                    //ListaDeActividadesServlet?idUsuario=1
                    //request.getRequestDispatcher("ListaDeActividadesServlet").forward(request, response);
                }else{
                    request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                }
                break;
            case "registro":
                String correo2 = request.getParameter("correoPucp");
                //Debemos guardarlo en algun lado para mandar el correo
                DaoValidacion daoValidacion = new DaoValidacion();
                daoValidacion.agregarCorreoParaEnviarLink(correo2);
                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                break;
        }





    }
}

