package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoDonacion;
import com.example.proyectouwu.Daos.DaoUsuario;
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
public class MisDonacionesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        DaoUsuario dUsuario=new DaoUsuario();
        DaoDonacion dDonacion=new DaoDonacion();
        Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");


        if(usuario==null){
            response.sendRedirect("InicioSesionServlet");
        }else{
            request.setAttribute("vistaActual","misDonaciones");
            request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
            request.setAttribute("listaDonaciones",dDonacion.listarDonacionesVistaUsuario(usuario.getIdUsuario()));
            request.setAttribute("totalDonaciones",dDonacion.totalDonaciones(usuario.getIdUsuario()));
            String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
            if(request.getParameter("confirmacion")!=null){
                request.setAttribute("confirmacion","1");
            }
            switch (action){
                case "default":
                    request.getRequestDispatcher("donaciones.jsp").forward(request,response);
            }
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

        InputStream inputY = null;
        InputStream inputP = null;

        switch (action){
            case "registDon":
                Usuario usuario=(Usuario) request.getSession().getAttribute("usuario");
                String medioPago = request.getParameter("medio");
                float monto = Float.parseFloat(request.getParameter("monto"));

                // Foto Donacion
                partY = request.getPart("addFotoYape");
                partP = request.getPart("addFotoPlin");

                // Obtenemos el flujo de bytes
                inputY = partY.getInputStream();
                inputP = partP.getInputStream();

                try {
                    if(inputY!=null && inputY.available()>10){
                        daoDonacion.agregarDonacionUsuario(usuario.getIdUsuario(),medioPago,monto,inputY);
                    }
                    if(inputP!=null && inputP.available()>10){
                        daoDonacion.agregarDonacionUsuario(usuario.getIdUsuario(),medioPago,monto,inputP);
                    }

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                inputY.close();
                inputP.close();
                request.getSession().setAttribute("confirmacion","1");
                response.sendRedirect("MisDonacionesServlet");
                break;
            case "default":
                request.getRequestDispatcher("donaciones.jsp").forward(request,response);
        }
    }
}