package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.rowset.serial.SerialBlob;//castear string a blob

@WebServlet(name = "MisDonacionesServlet", value = "/MisDonacionesServlet")
@MultipartConfig(maxFileSize = 10000000)
public class MisDonacionesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoDonacion dDonacion=new DaoDonacion();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        DaoValidacion dV=new DaoValidacion();

        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            request.setAttribute("vistaActual","misDonaciones");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("listaDonaciones",dDonacion.listarDonacionesVistaUsuario(usuario.getIdUsuario()));
            request.setAttribute("totalDonaciones",dDonacion.totalDonaciones(usuario.getIdUsuario()));


            if (dDonacion.totalDonaciones(usuario.getIdUsuario()) > 100&& !dV.verificarYaRecibioNotificacionKit(usuario.getIdUsuario())){
                dV.agregarCorreoParaElKit(dUsuario.correoUsuarioPorId(usuario.getIdUsuario()));
            }


            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            if(request.getParameter("confirmacion")!=null){
                request.setAttribute("confirmacion","1");
            }
            if(usuario.getRol().equals("Delegado de Actividad")){
                request.setAttribute("listaNotificacionesDelegadoDeActividad",new DaoNotificacion().listarNotificacionesDelegadoDeActividad(usuario.getIdUsuario()));
            }
            switch (action){
                case "default":
                    request.getRequestDispatcher("donaciones.jsp").forward(request,response);
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        DaoDonacion daoDonacion = new DaoDonacion();
        //Parametros utilizados para la foto de donación
        // Y: Yape; P: Plin
        Part partY = null;
        Part partP = null;
        DaoUsuario dUsuario=new DaoUsuario();
        InputStream inputY = null;
        InputStream inputP = null;
        DaoValidacion daoValidacion = new DaoValidacion();

        float monto=0;
        boolean validacionMonto=true;
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else {
            switch (action){
                case "registDon":
                    String medioPago = request.getParameter("medio");
                    String montoAux=request.getParameter("monto");
                    try{
                        monto = Float.parseFloat(montoAux);
                        if(monto<0){
                            validacionMonto=false;
                        }
                    }catch (NumberFormatException e){
                        validacionMonto=false;
                    }
                    if(validacionMonto){
                        partY = request.getPart("addFotoYape");
                        partP = request.getPart("addFotoPlin");
                        if(partY!=null){
                            inputY = partY.getInputStream();
                            System.out.println(inputY.available());
                            if(inputY.available()>10){
                                try {
                                    daoDonacion.agregarDonacionUsuario(usuario.getIdUsuario(),medioPago,monto,inputY);
                                    inputY.close();
                                } catch (SQLException e) {
                                    throw new RuntimeException(e);
                                }
                            }
                        }
                        if(partP!=null){
                            inputP = partP.getInputStream();
                            if(inputP.available()>10){
                                try {
                                    daoDonacion.agregarDonacionUsuario(usuario.getIdUsuario(),medioPago,monto,inputP);
                                    inputP.close();
                                } catch (SQLException e) {
                                    throw new RuntimeException(e);
                                }
                            }
                        }
                        request.getSession().setAttribute("confirmacion","1");
                    }else {
                        request.getSession().setAttribute("errorMonto","1");
                        request.getSession().setAttribute("medio",medioPago);
                    }
                    response.sendRedirect("MisDonacionesServlet");
                    break;
                case "default":
                    request.getRequestDispatcher("donaciones.jsp").forward(request,response);
            }
            request.getSession().setAttribute("usuario",dUsuario.usuarioSesion(usuario.getIdUsuario()));
        }
    }
}