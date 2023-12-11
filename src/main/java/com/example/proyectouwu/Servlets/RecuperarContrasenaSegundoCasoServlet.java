
package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Validacion;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "RecuperarContrasenaSegundoCasoServlet", value = "/RecuperarContrasenaSegundoCasoServlet")
public class RecuperarContrasenaSegundoCasoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action) {
            default:
            case "default":
//                request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                String idCorreoValidacion = request.getParameter("idCorreoValidacion");
                String codigoValidacion256 = request.getParameter("codigoValidacion256");
                try{
                    if(codigoValidacion256.equals(new DaoValidacion().codigoValidacion256PorID(Integer.parseInt(idCorreoValidacion)))){
                        request.setAttribute("idCorreoValidacion",Integer.parseInt(idCorreoValidacion));
                        RequestDispatcher rd = request.getRequestDispatcher("recuperarContrasenaPaso2.jsp");
                        //Se manda a la vista con un parametro id que lo reconocerá más adelante
                        rd.forward(request,response);
                    }else{
                        response.sendRedirect("InicioSesionServlet");
                    }
                }catch (NumberFormatException e){
                    response.sendRedirect("InicioSesionServlet");
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            default:
            case "default":
                break;
            case "correoRecuperarContrasenaSegundoPaso":
                boolean cambioValido = true;
                String idCorreoValidacion = request.getParameter("idCorreoValidacion")==null?"0":request.getParameter("idCorreoValidacion");

                String correo = new DaoValidacion().buscarCorreoPorIdCorreoValidacion2(idCorreoValidacion);
                if(correo == null){
                    cambioValido = false;
                }

                String password = request.getParameter("password");

                if(password==null){
                    cambioValido = false;
                }else{
                    if(password.isEmpty()){
                        cambioValido = false;
                    }
                    if(!request.getParameter("password").equals(request.getParameter("password2"))){
                        cambioValido = false;
                    }else{
                        if(request.getParameter("password").length() < 8){
                            cambioValido = false;
                        }else{
                            String regexLetra = ".*[a-zA-Z]+.*";
                            String regexNumero = ".*\\d+.*";
                            Pattern patronLetra = Pattern.compile(regexLetra);
                            Pattern patronNumero = Pattern.compile(regexNumero);
                            Matcher matcherLetra = patronLetra.matcher(request.getParameter("password"));
                            Matcher matcherNumero = patronNumero.matcher(request.getParameter("password"));
                            boolean contieneLetra = matcherLetra.matches();
                            boolean contieneNumero = matcherNumero.matches();
                            if(!(contieneLetra && contieneNumero)) {
                                cambioValido = false;
                            }
                        }
                    }
                }
                if(cambioValido){
                    new DaoUsuario().actualizarContrasena(Integer.parseInt(idCorreoValidacion),password);
                    response.sendRedirect(request.getContextPath());
                }else if(correo!=null){
                    request.setAttribute("idCorreoValidacion",Integer.parseInt(idCorreoValidacion));
                    request.getRequestDispatcher("recuperarContrasenaPaso2.jsp").forward(request,response);
                }else{
                    response.sendRedirect("InicioSesionServlet");
                }
                break;
        }
    }
}
