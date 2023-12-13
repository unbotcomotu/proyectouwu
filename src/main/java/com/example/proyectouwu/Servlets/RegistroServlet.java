package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Beans.Validacion;
import com.example.proyectouwu.Daos.DaoAlumnoPorEvento;
import com.example.proyectouwu.Daos.DaoEvento;
import com.example.proyectouwu.Daos.DaoUsuario;
import com.example.proyectouwu.Daos.DaoValidacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "RegistroServlet", value = "/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setAttribute("correosDelegadosGenerales",new DaoUsuario().listarCorreosDelegadosGenerales());
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        boolean linkUsado = new DaoValidacion().getLinkUsadoxIdCorreoValidacion((int) Integer.parseInt(request.getParameter("idCorreoValidacion")));
        if( !linkUsado ) {
            switch (action) {
                case "default":
                    //Alex auxilio
                    //int codigoValidacion = Integer.parseInt(request.getParameter("codigoValidacion"));
                    Validacion validacion = new Validacion();
                    String idCorreoValidacion = request.getParameter("idCorreoValidacion") == null ? "simplebar.js" : request.getParameter("idCorreoValidacion");
                    String codigoValidacion256 = request.getParameter("codigoValidacion256") == null ? "simplebar.js" : request.getParameter("codigoValidacion256");
                    try {
                        validacion.setIdCorreoValidacion(Integer.parseInt(idCorreoValidacion));
                        if (codigoValidacion256.equals(new DaoValidacion().codigoValidacion256PorID(Integer.parseInt(idCorreoValidacion)))) {
                            request.setAttribute("validacion", validacion);
                            request.setAttribute("codigoValidacion256", codigoValidacion256);
                            request.getRequestDispatcher("Registro.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("InicioSesionServlet");
                        }
                    } catch (NumberFormatException e) {
                        response.sendRedirect("InicioSesionServlet");
                    }
                    break;
                default:
                    response.sendRedirect("InicioSesionServlet");
            }
        }else{
            response.sendRedirect("InicioSesionServlet");        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        //Para que un usuario se cree su cuenta
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            default:
            case "default":
                response.sendRedirect("InicioSesionServlet");
                break;
            case "registro":
                boolean registroValido = true;
                String idCorreoValidacion = request.getParameter("idCorreoValidacion")==null?"0":request.getParameter("idCorreoValidacion");
                String codigoValidacion256 = request.getParameter("codigoValidacion256") == null ?"0": request.getParameter("codigoValidacion256");
                String correo = new DaoValidacion().buscarCorreoPorIdCorreoValidacion(idCorreoValidacion);
                if(correo != null) {
                    String opcion = "";
                    String nombres=request.getParameter("nombres");
                    String apellidos=request.getParameter("apellidos");
                    String password=request.getParameter("password");
                    String password2=request.getParameter("password2");
                    String codigoPUCP=request.getParameter("codigoPucp");
                    String opciones1=request.getParameter("opciones1");
                    String opciones2=request.getParameter("opciones2");
                    if(nombres!=null&&apellidos!=null&&password!=null&&password2!=null&&codigoPUCP!=null){
                        if(nombres.isEmpty()){
                            request.getSession().setAttribute("nombresVacios","1");
                            registroValido=false;
                        }else if(nombres.length()>45){
                            request.getSession().setAttribute("nombresLargos","1");
                            registroValido=false;
                        }
                        if (apellidos.isEmpty()) {
                            request.getSession().setAttribute("apellidosVacios","1");
                            registroValido=false;
                        }else if(apellidos.length()>45){
                            request.getSession().setAttribute("apellidosLargos","1");
                            registroValido=false;
                        }
                        if(codigoPUCP.isEmpty()){
                            request.getSession().setAttribute("codigoPucpVacio","1");
                            registroValido=false;
                        }else{
                            try{
                                int codigoAux=Integer.parseInt(codigoPUCP);
                                if(codigoPUCP.length()!=8){
                                    request.getSession().setAttribute("codigoPucpInvalido","1");
                                    registroValido=false;
                                }
                            }catch (NumberFormatException e){
                                request.getSession().setAttribute("codigoPucpNoNumerico","1");
                                registroValido=false;
                            }
                        }
                        if(password.isEmpty()||password2.isEmpty()){
                            if(password.isEmpty()){
                                request.getSession().setAttribute("passwordVacio","1");
                                registroValido=false;
                            }else if(password.length()<8){
                                request.getSession().setAttribute("passwordCorto","1");
                                registroValido=false;
                            }
                            if (password2.isEmpty()) {
                                request.getSession().setAttribute("password2Vacio","1");
                                registroValido=false;
                            }
                        }else {
                            if(password.length()<8){
                                request.getSession().setAttribute("passwordCorto","1");
                                registroValido=false;
                            }
                            if(!password.equals(password2)){
                                request.getSession().setAttribute("passwordNoCoincide","1");
                                registroValido=false;
                            }else{
                                String regexLetra = ".*[a-zA-Z]+.*";
                                String regexNumero = ".*\\d+.*";
                                Pattern patronLetra = Pattern.compile(regexLetra);
                                Pattern patronNumero = Pattern.compile(regexNumero);
                                Matcher matcherLetra = patronLetra.matcher(password);
                                Matcher matcherNumero = patronNumero.matcher(password);
                                boolean contieneLetra = matcherLetra.matches();
                                boolean contieneNumero = matcherNumero.matches();
                                if(!(contieneLetra && contieneNumero)) {
                                    request.getSession().setAttribute("passwordNoValida","1");
                                    registroValido = false;
                                }
                            }
                        }
                        if(opciones1!= null &&opciones2!= null){
                            request.getSession().setAttribute("errorRegistro","1");
                            registroValido = false;
                        }else{
                            if(opciones1 != null){
                                if(!opciones1.equals("Estudiante")){
                                    request.getSession().setAttribute("errorRegistro","1");
                                    registroValido = false;
                                }else{
                                    opcion=opciones1;
                                }
                            }else if(opciones2 != null){
                                if(!opciones2.equals("Egresado")){
                                    request.getSession().setAttribute("errorRegistro","1");
                                    registroValido = false;
                                }else{
                                    opcion=opciones2;
                                }
                            }else{
                                request.getSession().setAttribute("condicionNoEscogida","1");
                                registroValido = false;
                            }
                        }
                    }
                    if(registroValido){
                        new DaoUsuario().registroDeAlumno(nombres,apellidos,correo,password,codigoPUCP,opcion);
                        new DaoValidacion().updateLinkUsado((int) Integer.parseInt(request.getParameter("idCorreoValidacion")));
                        //Por el momento al terminar lo hacemos saltar a la vista de inicioSesion
                        request.getSession().setAttribute("popup","5");
                        response.sendRedirect("InicioSesionServlet");
                    }else {
                        response.sendRedirect("RegistroServlet?idCorreoValidacion="+idCorreoValidacion+"&codigoValidacion256="+codigoValidacion256);
                    }
                }else {
                    response.sendRedirect("RegistroServlet?idCorreoValidacion="+idCorreoValidacion+"&codigoValidacion256="+codigoValidacion256);
                }
                break;
        }
    }
}

