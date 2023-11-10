package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.AlumnoPorEvento;
import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Reporte;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.Beans.Validacion;
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

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion ,idUsuario from Usuario where estadoRegistro = 'Pendiente' order by fechaHoraRegistro desc";


        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {
            while (rs.next()){
                Usuario u=new Usuario();
                u.setNombre(rs.getString(1));
                u.setApellido(rs.getString(2));
                u.setCorreo(rs.getString(3));
                u.setCodigoPUCP(rs.getString(4));
                u.setCondicion(rs.getString(5));
                u.setIdUsuario(rs.getInt(6));
                listaSolicitudes.add(u);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudes;
    }

    public ArrayList<Usuario>listarSolicitudesDeRegistro(String busqueda){
        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();
        

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion  from Usuario where estadoRegistro = 'Pendiente' and (nombre like ? or apellido like ?) order by fechaHoraRegistro desc";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
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

        

        String sql = "SELECT idUsuarioReportado, idUsuarioQueReporta, motivoReporte,fechaHora FROM reporte order by fechaHora desc";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){

            while (rs.next()) {
                Reporte report = new Reporte();
                report.getUsuarioReportado().setIdUsuario(rs.getInt(1));
                report.getUsuarioQueReporta().setIdUsuario(rs.getInt(2));
                report.setMotivoReporte(rs.getString(3));
                report.setFecha(rs.getDate(4));
                reportList.add(report);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }

    public ArrayList<Reporte> listarNotificacionesReporte(String buscar){

        ArrayList<Reporte> reportList= new ArrayList<>();

        

        String sql = "SELECT r.idUsuarioReportado, r.idUsuarioQueReporta, r.motivoReporte,r.fechaHora FROM reporte r inner join usuario u on r.idUsuarioReportado=u.idUsuario where u.nombre like ? or u.apellido like ? order by r.fechaHora desc";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+buscar+"%");
            pstmt.setString(2,"%"+buscar+"%");
            try(ResultSet rs = pstmt.executeQuery()){
                while (rs.next()) {
                    Reporte report = new Reporte();
                    report.getUsuarioReportado().setIdUsuario(rs.getInt(1));
                    report.getUsuarioQueReporta().setIdUsuario(rs.getInt(2));
                    report.setMotivoReporte(rs.getString(3));
                    report.setFecha(rs.getDate(4));
                    reportList.add(report);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }

    public ArrayList<Donacion> listarNotificacionesDonaciones( ){

        ArrayList<Donacion> donacionList= new ArrayList<>();

        

        String sql = "SELECT idDonacion, idUsuario, medioPago, monto,fechaHora,estadoDonacion FROM donacion order by if(estadoDonacion='Pendiente',0,1),fechaHora desc";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {

            while (rs.next()) {
                Donacion donacion = new Donacion();
                donacion.setIdDonacion(rs.getInt(1));
                donacion.getUsuario().setIdUsuario(rs.getInt(2));
                donacion.setMedioPago(rs.getString(3));
                donacion.setMonto(rs.getFloat(4));
                donacion.setFecha(rs.getDate(5));
                donacion.setEstadoDonacion(rs.getString(6));
                donacionList.add(donacion);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacionList;
    }

    public ArrayList<Donacion> listarNotificacionesDonaciones(String buscar){

        ArrayList<Donacion> donacionList= new ArrayList<>();

        

        String sql = "SELECT d.idDonacion, d.idUsuario, d.medioPago, d.monto,d.fechaHora,d.estadoDonacion FROM donacion d inner join usuario u on d.idUsuario=u.idUsuario where u.nombre like ? or u.apellido like ? order by if(d.estadoDonacion='Pendiente',0,1),fechaHora desc";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,"%"+buscar+"%");
            pstmt.setString(2,"%"+buscar+"%");
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    Donacion donacion = new Donacion();
                    donacion.setIdDonacion(rs.getInt(1));
                    donacion.getUsuario().setIdUsuario(rs.getInt(2));
                    donacion.setMedioPago(rs.getString(3));
                    donacion.setMonto(rs.getFloat(4));
                    donacion.setFecha(rs.getDate(5));
                    donacion.setEstadoDonacion(rs.getString(6));
                    donacionList.add(donacion);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacionList;
    }
    public ArrayList<Donacion> listarNotificacionesDonaciones(String fecha1,String fecha2){
        String fecha1aux[]=fecha1.split("/");
        String fecha1final=fecha1aux[2]+"/"+fecha1aux[1]+"/"+fecha1aux[0];
        String fecha2aux[]=fecha2.split("/");
        String fecha2final=fecha2aux[2]+"/"+fecha2aux[1]+"/"+fecha2aux[0];
        ArrayList<Donacion> donacionList= new ArrayList<>();

        

        String sql = "SELECT idDonacion, idUsuario, medioPago, monto,fechaHora,estadoDonacion FROM donacion where date(fechaHora) between ? and ? order by if(estadoDonacion='Pendiente',0,1),fechaHora desc";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,fecha1final);
            pstmt.setString(2,fecha2final);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    Donacion donacion = new Donacion();
                    donacion.setIdDonacion(rs.getInt(1));
                    donacion.getUsuario().setIdUsuario(rs.getInt(2));
                    donacion.setMedioPago(rs.getString(3));
                    donacion.setMonto(rs.getFloat(4));
                    donacion.setFecha(rs.getDate(5));
                    donacion.setEstadoDonacion(rs.getString(6));
                    donacionList.add(donacion);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacionList;
    }
    public ArrayList<Validacion> listarNotificacionesRecuperacion( ){

        ArrayList<Validacion> validacionList= new ArrayList<>();

        

        String sql = "select correo,tipo,codigoValidacion,fechaHora,idCorreoValidacion from validacion where linkEnviado = 0 order by idCorreoValidacion desc";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {

            while (rs.next()) {

                Validacion validacion = new Validacion();
                validacion.setCorreo(rs.getString(1));
                validacion.setTipo(rs.getString(2));
                validacion.setCodigoValidacion(rs.getInt(3));
                validacion.setFechaHora(rs.getDate(4));
                validacion.setIdCorreoValidacion(rs.getInt(5));
                validacionList.add(validacion);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return validacionList;
    }

    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(int idDelegadoDeActividad){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();
        String sql = "select ae.idAlumnoPorEvento, ae.idAlumno ,ae.idEvento from alumnoporevento ae inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad=a.idActividad where a.idDelegadoDeActividad=? and estadoApoyo = 'Pendiente' order by fechaHoraSolicitud desc";

        try (Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    AlumnoPorEvento alumnoPorEvento=new AlumnoPorEvento();
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.getAlumno().setIdUsuario(rs.getInt(2));
                    alumnoPorEvento.getEvento().setIdEvento(rs.getInt(3));
                    listaSolicitudesApoyo.add(alumnoPorEvento);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudesApoyo;
    }

    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(int idDelegadoDeActividad,String buscar){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();

        

        String sql = "select ae.idAlumnoPorEvento, ae.idAlumno from alumnoporevento ae inner join usuario u on ae.idAlumno = u.idUsuario inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad=a.idActividad where (u.nombre like ? or u.apellido like ?) and  estadoApoyo = 'Pendiente' and a.idDelegadoDeActividad=? order by ae.fechaHoraSolicitud desc";


        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,"%"+buscar+"%");
            pstmt.setString(2,"%"+buscar+"%");
            pstmt.setInt(3,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    AlumnoPorEvento alumnoPorEvento = new AlumnoPorEvento();
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.getAlumno().setIdUsuario(rs.getInt(2));

                    listaSolicitudesApoyo.add(alumnoPorEvento);
                }
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
        

        String sql = "SELECT fechaHora FROM donacion";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {

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
    public void actualizarEnviado(int idCorreoValidacion){

        String sql = "update validacion set linkEnviado = 1 where idCorreoValidacion=?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idCorreoValidacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void aceptarSolicitudApoyo(int idAlumnoPorEvento,String tipoDeApoyo){
        String sql="update alumnoPorEvento set estadoApoyo=? where idAlumnoPorEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,tipoDeApoyo);
            pstmt.setInt(2,idAlumnoPorEvento);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionValidacion(int idValidacion){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,idValidacion) values(now(),?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idValidacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionSolicitudDeRegistro(int idUsuario){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,idUsuario) values(now(),?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionDonacion(int idDonacion){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,idDonacion) values(now(),?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDonacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionReporte(int idReporte){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,idReporte) values(now(),?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idReporte);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
