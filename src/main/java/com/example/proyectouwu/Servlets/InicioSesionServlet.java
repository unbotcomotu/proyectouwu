package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Ban;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

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
                if(correo!=null&&contrasena!=null){
                    Ban b= new DaoUsuario().logIn(correo,contrasena);
                    if(b==null) {
                        request.getSession().setAttribute("popup","4");
                        response.sendRedirect(request.getContextPath());
                    }else if(b.getMotivoBan()!=null){
                        request.setAttribute("motivoBan",b.getMotivoBan());
                        request.setAttribute("correosDelegadosGenerales",new DaoUsuario().listarCorreosDelegadosGenerales());
                        request.getSession().setAttribute("popup","6");
                        request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                    }else{
                        request.getSession().setAttribute("usuario",new DaoUsuario().usuarioSesion(b.getUsuario().getIdUsuario()));
                        request.getSession().setAttribute("pSolicitudesDeApoyo","1");
                        request.getSession().setMaxInactiveInterval(600);
                        response.sendRedirect("ListaDeActividadesServlet");
                    }
                }else {
                    response.sendRedirect(request.getContextPath());
                }
                break;
            case "registro":
                boolean correoValido = true;
                String correo2 = request.getParameter("correoPucp");
                if(correo2==null){
                    correoValido=false;
                }else{
                    if(correo2.isEmpty()){
                        correoValido=false;
                    }
                    if(correo2.length()>45){
                        correoValido=false;
                    }
                }

                if(correoValido){
                    //Debemos guardarlo en algun lado para mandar el correo
                    //Debemos asegurarnos que el correo no tenga una cuenta ya asociada y en caso tenga que mande un mensaje de error al usuario
                    if(new DaoUsuario().obtenerIdRegistradoPorCorreo(correo2) != 0) {
                        //
                        request.getSession().setAttribute("popup","3");
                    }else{
                    if(  new DaoValidacion().cantidadValidacionXCorreoTipo(correo2, "enviarLinkACorreo") == 0 ) {


                        DaoValidacion daoValidacion = new DaoValidacion();
                        daoValidacion.agregarCorreoParaEnviarLink(correo2);
                            //AQUI VA EL METODO PARA ENVIAR CORREO
                            new Usuario().enviarCorreo("" + new DaoValidacion().obtenerValidacionPorCorreo(correo2).getIdCorreoValidacion());
                            new DaoValidacion().linkEnviado((int) new DaoValidacion().obtenerValidacionPorCorreo(correo2).getIdCorreoValidacion());
                            String popup = request.getParameter("popup");
                            if (popup != null) {
                                request.getSession().setAttribute("popup", popup);
                            }
                        }else{
                            String popup = request.getParameter("popup");
                            if (popup != null) {
                                request.getSession().setAttribute("popup", popup);
                            }
                    }
                    }
                }
                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                break;
            case "logOut":
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath());
                break;
        }
    }
}


