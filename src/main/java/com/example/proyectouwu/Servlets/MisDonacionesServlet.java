package com.example.proyectouwu.Servlets;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Daos.DaoActividad;
import com.example.proyectouwu.Daos.DaoDonacion;
import com.example.proyectouwu.Daos.DaoUsuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
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
        int idUsuario=Integer.parseInt(request.getParameter("idUsuario"));
        String rolUsuario=dUsuario.rolUsuarioPorId(idUsuario);
        request.setAttribute("idUsuario",idUsuario);
        request.setAttribute("rolUsuario",rolUsuario);
        request.setAttribute("nombreCompletoUsuario",dUsuario.nombreCompletoUsuarioPorId(idUsuario));
        request.setAttribute("vistaActual","misDonaciones");
        request.setAttribute("correosDelegadosGenerales",dUsuario.listarCorreosDelegadosGenerales());
        request.setAttribute("listaDonaciones",dDonacion.listarDonacionesVistaUsuario(idUsuario));
        request.setAttribute("totalDonaciones",dDonacion.totalDonaciones(idUsuario));
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        switch (action){
            case "default":
                request.getRequestDispatcher("donaciones.jsp").forward(request,response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        DaoDonacion daoDonacion = new DaoDonacion();

        switch (action){
            case "registDon":
                int idDonacion = Integer.parseInt(request.getParameter("idDonacion"));
                int idUser = Integer.parseInt(request.getParameter("idUser"));
                String medioPago = request.getParameter("medioPago");
                int monto = Integer.parseInt(request.getParameter("monto"));
                //Ayuda para lo del blob en captura
                byte[] bytes = request.getParameter("captura").getBytes("UTF-8");
                try {
                    Blob captura =  new SerialBlob(bytes);
                    //Después se agrega la donación
                    daoDonacion.agregarDonacionUsuario(idDonacion,idUser,medioPago,monto,captura);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                response.sendRedirect(request.getContextPath()+"/MisDonacionesServlet");
                break;
            case "default":
                request.getRequestDispatcher("donaciones.jsp").forward(request,response);
        }
    }
}