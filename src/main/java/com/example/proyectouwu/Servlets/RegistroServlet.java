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
        switch(action){
            case "default" :
                //Alex auxilio
                //int codigoValidacion = Integer.parseInt(request.getParameter("codigoValidacion"));
                Validacion validacion= new Validacion();
                String idCorreoValidacion = request.getParameter("idCorreoValidacion") == null ? "simplebar.js" : request.getParameter("idCorreoValidacion");
                String codigoValidacion256 = request.getParameter("codigoValidacion256") == null ? "simplebar.js" : request.getParameter("codigoValidacion256");
                try{
                    validacion.setIdCorreoValidacion(Integer.parseInt(idCorreoValidacion));
                    if(codigoValidacion256.equals(new DaoValidacion().codigoValidacion256PorID(Integer.parseInt(idCorreoValidacion)))){
                        request.setAttribute("validacion",validacion);
                        request.getRequestDispatcher("Registro.jsp").forward(request,response);
                    }else{
                        response.sendRedirect("InicioSesionServlet");
                    }
                }catch (NumberFormatException e){
                    response.sendRedirect("InicioSesionServlet");
                }
                break;
            case "registro" :
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        //Para que un usuario se cree su cuenta
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                //No hay nada aquí pero porsiacaso
                break;
            case "registro":
                boolean registroValido = true;
                String errorNombre="";
                String errorApellido="";
                String errorCodigo="";
                String errorContrasena="";

                String idCorreoValidacion = request.getParameter("idCorreoValidacion")==null?"0":request.getParameter("idCorreoValidacion");
                String correo = new DaoValidacion().buscarCorreoPorIdCorreoValidacion(idCorreoValidacion);
                if(correo == null){
                    registroValido = false;
                }
                String opcion = "";
                if(request.getParameter("nombres").isEmpty() || request.getParameter("apellidos").isEmpty() || request.getParameter("password").isEmpty() || request.getParameter("password2").isEmpty() || request.getParameter("codigoPucp").isEmpty()){
                    registroValido = false;
                }

                if(request.getParameter("nombres").length()>45 || request.getParameter("apellidos").length()>45 || request.getParameter("codigoPucp").length()!=8){
                    registroValido = false;
                }

                try{
                    int codigoPucp = Integer.parseInt(request.getParameter("codigoPucp"));
                }catch (NumberFormatException e){
                    registroValido = false;
                }

                if(!request.getParameter("password").equals(request.getParameter("password2"))){
                    registroValido = false;
                }else{
                    if(request.getParameter("password").length() < 8){
                        registroValido = false;
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
                            registroValido = false;
                        }
                    }
                }
                if(request.getParameter("opciones1") != null && request.getParameter("opciones2") != null){
                    registroValido = false;
                }else{
                    if(request.getParameter("opciones1") != null){
                        if(!request.getParameter("opciones1").equals("Estudiante")){
                            registroValido = false;
                        }else{
                            opcion=request.getParameter("opciones1");
                        }
                    }else if(request.getParameter("opciones2") != null){
                        if(!request.getParameter("opciones2").equals("Egresado")){
                            registroValido = false;
                        }else{
                            opcion=request.getParameter("opciones2");
                        }
                    }else{
                        registroValido = false;
                    }
                }

                if(registroValido){
                    new DaoUsuario().registroDeAlumno(request.getParameter("nombres"),request.getParameter("apellidos"),correo,request.getParameter("password"), request.getParameter("codigoPucp"),opcion);
                    //Por el momento al terminar lo hacemos saltar a la vista de inicioSesion
                    request.setAttribute("popup","5");
                    request.getRequestDispatcher("inicioSesion.jsp").forward(request,response);
                }else{
                    DaoValidacion daoValidacion = new DaoValidacion();
                    Validacion validacion = daoValidacion.obtenerValidacionPorCorreo(correo);
                    request.setAttribute("correosDelegadosGenerales",new DaoUsuario().listarCorreosDelegadosGenerales());
                    request.setAttribute("validacion",validacion);
                    request.getRequestDispatcher("Registro.jsp").forward(request,response);
                }
                break;
        }

    }
}

