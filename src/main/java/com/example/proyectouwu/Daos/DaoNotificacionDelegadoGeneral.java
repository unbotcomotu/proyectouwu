package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Reporte;
import com.example.proyectouwu.Beans.Usuario;
import java.sql.*;
import java.util.ArrayList;

public class DaoNotificacionDelegadoGeneral {

    public ArrayList<Usuario>listarSolicitudesDeRegistro(){

        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = "root";
        String password = "root"; //Cambiar segun tu contraseña

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion  from Usuario where estadoRegistro = 'Pendiente'";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {



        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudes;
    }

    public ArrayList<Reporte> listarNotificacionesReporte( ){

        ArrayList<Reporte> reportList= new ArrayList<>();

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = "root";
        String password = "root";

        String sql = "select  concat(ur.nombre, ' ', ur.apellido) as 'Reportado',concat(uqr.nombre, ' ', uqr.apellido) as 'Reportante', r.motivoReporte, r.fechaHora from reporte r inner join usuario ur on ur.idUsuario = r.idUsuarioReportado inner join usuario uqr on uqr.idUsuario = r.idUsuarioQueReporta ORDER BY ur.nombre;";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Reporte report = new Reporte();
                report.setNombreReportado(rs.getString(1));
                report.setNombreReportante(rs.getString(2));
                report.setMotivoReporte(rs.getString(3));
                report.setFecha(rs.getDate(4));
                reportList.add(report);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }
}
