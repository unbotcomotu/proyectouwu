
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
                        request.setAttribute("codigoValidacion256",codigoValidacion256);
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
                response.sendRedirect("InicioSesionServlet");
                break;
            case "correoRecuperarContrasenaSegundoPaso":
                boolean cambioValido = true;
                String idCorreoValidacion = request.getParameter("idCorreoValidacion")==null?"0":request.getParameter("idCorreoValidacion");
                String codigoValidacion256= request.getParameter("codigoValidacion256")==null?"0":request.getParameter("codigoValidacion256");
                String correo = new DaoValidacion().buscarCorreoPorIdCorreoValidacion2(idCorreoValidacion);
                String password=request.getParameter("password");
                String password2=request.getParameter("password2");
                if(correo != null){
                    if(password!=null&&password2!=null) {
                        if (password.isEmpty() || password2.isEmpty()) {
                            if (password.isEmpty()) {
                                request.getSession().setAttribute("passwordVacio", "1");
                                cambioValido = false;
                            } else if (password.length() < 8) {
                                request.getSession().setAttribute("passwordCorto", "1");
                                cambioValido = false;
                            }
                            if (password2.isEmpty()) {
                                request.getSession().setAttribute("password2Vacio", "1");
                                cambioValido = false;
                            }
                        } else {
                            if (password.length() < 8) {
                                request.getSession().setAttribute("passwordCorto", "1");
                                cambioValido = false;
                            }
                            if (!password.equals(password2)) {
                                request.getSession().setAttribute("passwordNoCoincide", "1");
                                cambioValido = false;
                            } else {
                                String regexLetra = ".*[a-zA-Z]+.*";
                                String regexNumero = ".*\\d+.*";
                                Pattern patronLetra = Pattern.compile(regexLetra);
                                Pattern patronNumero = Pattern.compile(regexNumero);
                                Matcher matcherLetra = patronLetra.matcher(password);
                                Matcher matcherNumero = patronNumero.matcher(password);
                                boolean contieneLetra = matcherLetra.matches();
                                boolean contieneNumero = matcherNumero.matches();
                                if (!(contieneLetra && contieneNumero)) {
                                    request.getSession().setAttribute("passwordNoValida", "1");
                                    cambioValido = false;
                                }
                            }
                        }
                        if(cambioValido){
                            new DaoUsuario().actualizarContrasena(Integer.parseInt(idCorreoValidacion),password);
                            request.getSession().setAttribute("popup","7");
                            response.sendRedirect("InicioSesionServlet");
                        }else {
                            response.sendRedirect("RecuperarContrasenaSegundoCasoServlet?idCorreoValidacion="+idCorreoValidacion+"&codigoValidacion256="+codigoValidacion256);
                        }
                    }else {
                        request.getSession().setAttribute("errorDesconocido","1");
                        response.sendRedirect("RecuperarContrasenaSegundoCasoServlet?idCorreoValidacion="+idCorreoValidacion+"&codigoValidacion256="+codigoValidacion256);
                    }
                }else {
                    response.sendRedirect("InicioSesionServlet");
                }
                break;
        }
    }
}
