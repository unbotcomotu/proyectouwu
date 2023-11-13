package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Ban;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.swing.*;
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
                Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
                if(usuario!=null){
                    response.sendRedirect("ListaDeActividadesServlet");
                }else{
                    request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                }
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
                //ArrayList <Usuario> listaUsuario = new DaoUsuario().listarUsuariosTotal();
                Ban b= new DaoUsuario().logIn(correo,contrasena);
                //int usuarioId = 0;
                //boolean existeUsuario=  false;
                //bucleUsuarios:
                //for(Usuario user: listaUsuario){
                //    if(correo.equals(user.getCorreo()) && contrasena.equals(user.getContrasena())){
                 //       usuarioId = user.getIdUsuario();
                 //       existeUsuario= true;
                 //       break bucleUsuarios;
                  //  }
                //}
                if(b==null) {
                    request.getSession().setAttribute("popup","4");
                    request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                }else if(b.getMotivoBan()!=null){
                    request.setAttribute("motivoBan",b.getMotivoBan());
                    request.setAttribute("correosDelegadosGenerales",new DaoUsuario().listarCorreosDelegadosGenerales());
                    request.getSession().setAttribute("popup","6");
                    request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                }else{
                    request.getSession().setAttribute("usuario",new DaoUsuario().usuarioSesion(b.getUsuario().getIdUsuario()));
                    request.getSession().setMaxInactiveInterval(60);
                    response.sendRedirect("ListaDeActividadesServlet");
                }
                break;
            case "registro":
                String correo2 = request.getParameter("correoPucp");
                //Debemos guardarlo en algun lado para mandar el correo
                //Debemos asegurarnos que el correo no tenga una cuenta ya asociada y en caso tenga que mande un mensaje de error al usuario
                if(new DaoUsuario().obtenerIdPorCorreo(correo2) != 0) {
                    request.getSession().setAttribute("popup","3");
                }else{
                    DaoValidacion daoValidacion = new DaoValidacion();
                    daoValidacion.agregarCorreoParaEnviarLink(correo2);
                    String popup=request.getParameter("popup");
                    if(popup!=null) {
                        request.getSession().setAttribute("popup", popup);
                    }
                }
                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                break;
            case "logOut":
                request.getSession().invalidate();
                response.sendRedirect("InicioSesionServlet");
                break;
        }
    }
}

