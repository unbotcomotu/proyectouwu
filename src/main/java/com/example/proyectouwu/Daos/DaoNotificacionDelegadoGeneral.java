package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.AlumnoPorEvento;
import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Reporte;
import com.example.proyectouwu.Beans.Usuario;
import java.sql.*;
import java.util.ArrayList;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import java.time.Period;
import java.time.LocalDate;
public class DaoNotificacionDelegadoGeneral extends DaoPadre {


    public ArrayList<Usuario>listarSolicitudesDeRegistro(){

        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = super.getUser();
        String password = super.getPassword(); //Cambiar segun tu contraseña

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion  from Usuario where estadoRegistro = 'Pendiente'";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()){
                Usuario u=new Usuario();
                u.setNombre(rs.getString(1));
                u.setApellido(rs.getString(2));
                u.setCorreo(rs.getString(3));
                u.setCodigoPUCP(rs.getString(4));
                u.setCondicion(rs.getString(5));
                listaSolicitudes.add(u);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudes;
    }

    public ArrayList<Usuario>listarSolicitudesDeRegistro(String busqueda){
        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = super.getUser();
        String password = super.getPassword(); //Cambiar segun tu contraseña

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion  from Usuario where estadoRegistro = 'Pendiente' and (nombre like ? or apellido like ?)";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+busqueda+"%");
            pstmt.setString(2,"%"+busqueda+"%");
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Usuario u=new Usuario();
                    u.setNombre(rs.getString(1));
                    u.setApellido(rs.getString(2));
                    u.setCorreo(rs.getString(3));
                    u.setCodigoPUCP(rs.getString(4));
                    u.setCondicion(rs.getString(5));
                    listaSolicitudes.add(u);
                }
            }
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
        String username = super.getUser();
        String password = super.getPassword();

        String sql = "SELECT idUsuarioReportado, idUsuarioQueReporta, motivoReporte,fechaHora FROM reporte";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Reporte report = new Reporte();
                report.setIdUsuarioReportado(rs.getInt(1));
                report.setIdUsuarioQueReporta(rs.getInt(2));
                report.setMotivoReporte(rs.getString(3));
                report.setFecha(rs.getDate(4));
                reportList.add(report);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }


    public ArrayList<Donacion> listarNotificacionesDonaciones( ){

        ArrayList<Donacion> donacionList= new ArrayList<>();

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = super.getUser();
        String password = super.getPassword();

        String sql = "SELECT idUsuario, medioPago, monto,fechaHora,estadoDonacion FROM donacion";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Donacion donacion = new Donacion();
                donacion.setIdUsuario(rs.getInt(1));
                donacion.setMedioPago(rs.getString(2));
                donacion.setMonto(rs.getFloat(3));
                donacion.setFecha(rs.getDate(4));
                donacion.setEstadoDonacion(rs.getString(5));
                donacionList.add(donacion);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacionList;
    }

    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = super.getUser();
        String password = super.getPassword(); //Cambiar segun tu contraseña

        String sql = "select idAlumno from alumnoporevento where estadoApoyo = 'En espera'";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()){
                AlumnoPorEvento alumnoPorEvento=new AlumnoPorEvento();
                alumnoPorEvento.setIdAlumno(rs.getInt(1));

                listaSolicitudesApoyo.add(alumnoPorEvento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudesApoyo;
    }

    public ArrayList<Integer> diferenciaFechaActualReporte(){
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date dateNow = Calendar.getInstance().getTime();
        ArrayList<Integer> listaSegundoMinutoHoraDiaMes= new ArrayList<>();
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = super.getUser();
        String password = super.getPassword();

        String sql = "SELECT fechaHora FROM donacion";
        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                Date fechaReporte = rs.getDate(1);
                String stringFechaReporte = dateFormat.format(rs.getDate(1));
                String stringDateNow = dateFormat.format(dateNow);

                //Separa la parte de hora minuto segundo con año, mes y día
                String[] partsFReport = stringFechaReporte.split(" ");
                String[] partsDateNow = stringDateNow.split(" ");

                //Hora minuto y segundo para reporte y Tiempo actual
                String[] horaMinutoSegundoReport = partsFReport[1].split(":");
                String[] horaMinutoSegundoNow = partsFReport[1].split(":");

                listaSegundoMinutoHoraDiaMes.add(Integer.parseInt(horaMinutoSegundoNow[2])-Integer.parseInt(horaMinutoSegundoReport[2]));//segundo
                listaSegundoMinutoHoraDiaMes.add(Integer.parseInt(horaMinutoSegundoNow[1])-Integer.parseInt(horaMinutoSegundoReport[1]));//minuto
                listaSegundoMinutoHoraDiaMes.add(Integer.parseInt(horaMinutoSegundoNow[0])-Integer.parseInt(horaMinutoSegundoReport[0]));//hora

                //Año mes y día para reporte y Tiempo actual;
                String[] anioMesDiaReport = partsFReport[0].split("/");
                String[] anioMesDiaNow = partsDateNow[0].split("/");

                listaSegundoMinutoHoraDiaMes.add(Integer.parseInt(anioMesDiaNow[2])-Integer.parseInt(anioMesDiaReport[2]));//dia
                listaSegundoMinutoHoraDiaMes.add(Integer.parseInt(anioMesDiaNow[1])-Integer.parseInt(anioMesDiaReport[1]));//mes
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaSegundoMinutoHoraDiaMes; //Devuelve la diferencia en segundo, minuto, hora, dia y mes
    }

}
