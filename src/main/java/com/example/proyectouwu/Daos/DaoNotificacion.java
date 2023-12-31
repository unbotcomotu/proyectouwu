package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.*;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.*;
import java.util.ArrayList;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import java.util.HashSet;

public class DaoNotificacion extends DaoPadre {

    public ArrayList<Usuario>listarSolicitudesDeRegistro(){

        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion ,idUsuario,date(fechaHoraRegistro),time(fechaHoraRegistro) from usuario where estadoRegistro = 'Pendiente' order by fechaHoraRegistro desc";


        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {
            while (rs.next()){
                Usuario u=new Usuario();
                u.setNombre(rs.getString(1));
                u.setApellido(rs.getString(2));
                u.setCorreo(rs.getString(3));
                u.setCodigoPUCP(rs.getString(4));
                u.setCondicion(rs.getString(5));
                u.setIdUsuario(rs.getInt(6));
                u.setFechaRegistro(rs.getDate(7));
                u.setHoraRegistro(rs.getTime(8));
                listaSolicitudes.add(u);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudes;
    }

    public ArrayList<Usuario>listarSolicitudesDeRegistro(String busqueda){
        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion, idUsuario,date(fechaHoraRegistro),time(fechaHoraRegistro)  from usuario where estadoRegistro = 'Pendiente' and concat(nombre,' ',apellido) like ? order by fechaHoraRegistro desc";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+busqueda+"%");
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Usuario u=new Usuario();
                    u.setNombre(rs.getString(1));
                    u.setApellido(rs.getString(2));
                    u.setCorreo(rs.getString(3));
                    u.setCodigoPUCP(rs.getString(4));
                    u.setCondicion(rs.getString(5));
                    u.setIdUsuario(rs.getInt(6));
                    u.setFechaRegistro(rs.getDate(7));
                    u.setHoraRegistro(rs.getTime(8));
                    listaSolicitudes.add(u);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaSolicitudes;
    }

    public ArrayList<Usuario>listarSolicitudesDeRegistro(String busqueda, int pagina){
        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion, idUsuario,date(fechaHoraRegistro),time(fechaHoraRegistro)  from usuario where estadoRegistro = 'Pendiente' and concat(nombre,' ',apellido) like ? order by fechaHoraRegistro desc limit 12 offset ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,"%"+busqueda+"%");
            pstmt.setInt(2,pagina*12);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    Usuario u=new Usuario();
                    u.setNombre(rs.getString(1));
                    u.setApellido(rs.getString(2));
                    u.setCorreo(rs.getString(3));
                    u.setCodigoPUCP(rs.getString(4));
                    u.setCondicion(rs.getString(5));
                    u.setIdUsuario(rs.getInt(6));
                    u.setFechaRegistro(rs.getDate(7));
                    u.setHoraRegistro(rs.getTime(8));
                    listaSolicitudes.add(u);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaSolicitudes;
    }

    public ArrayList<Usuario> listarSolicitudesRegistroPorPage(int pagina){
        ArrayList<Usuario> listaSolicitudesPage = new ArrayList<>();
        String sql = "select nombre, apellido, correo ,codigoPUCP, condicion, idUsuario,date(fechaHoraRegistro),time(fechaHoraRegistro) from usuario where estadoRegistro='Pendiente' order by fechaHoraRegistro desc limit 12 offset ?";
        try(Connection conn=this.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,pagina*12);
            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();

                    usuario.setNombre(rs.getString(1));
                    usuario.setApellido(rs.getString(2));
                    usuario.setCorreo(rs.getString(3));
                    usuario.setCodigoPUCP(rs.getString(4));
                    usuario.setCondicion(rs.getString(5));
                    usuario.setIdUsuario(rs.getInt(6));
                    usuario.setFechaRegistro(rs.getDate(7));
                    usuario.setHoraRegistro(rs.getTime(8));
                    listaSolicitudesPage.add(usuario);
                }
                return listaSolicitudesPage;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



    public ArrayList<Reporte> listarNotificacionesReporte(){

        ArrayList<Reporte> reportList= new ArrayList<>();

        

        String sql = "select r.idUsuarioReportado, r.idUsuarioQueReporta, r.motivoReporte,r.fechaHora,u.fotoPerfil from reporte r inner join usuario u on r.idUsuarioReportado = u.idUsuario order by r.fechaHora desc";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){

            while (rs.next()) {
                Reporte report = new Reporte();
                report.getUsuarioReportado().setIdUsuario(rs.getInt(1));
                report.getUsuarioQueReporta().setIdUsuario(rs.getInt(2));
                report.setMotivoReporte(rs.getString(3));
                report.setFecha(rs.getDate(4));
                report.getUsuarioReportado().setFotoPerfil(rs.getBlob(5));
                reportList.add(report);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }

    public ArrayList<Reporte> listarNotificacionesReporte(String buscar){

        ArrayList<Reporte> reportList= new ArrayList<>();

        String sql = "select r.idUsuarioReportado, r.idUsuarioQueReporta, r.motivoReporte,r.fechaHora, u.fotoPerfil FROM reporte r inner join usuario u on r.idUsuarioReportado=u.idUsuario where u.nombre like ? or u.apellido like ? order by r.fechaHora desc";
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
                    report.getUsuarioReportado().setFotoPerfil(rs.getBlob(5));
                    reportList.add(report);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }

    public ArrayList<Donacion> listarNotificacionesDonaciones(){
        ArrayList<Donacion> donacionList= new ArrayList<>();
        String sql = "select idDonacion, idUsuario, medioPago, monto,fechaHora,estadoDonacion,captura from donacion order by if(estadoDonacion='Pendiente',0,1),fechaHora desc";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {

            while (rs.next()) {
                Donacion donacion = new Donacion();
                donacion.setIdDonacion(rs.getInt(1));
                donacion.getUsuario().setIdUsuario(rs.getInt(2));
                donacion.setMedioPago(rs.getString(3));
                donacion.setMonto(rs.getFloat(4));
                donacion.setFecha(rs.getDate(5));
                donacion.setEstadoDonacion(rs.getString(6));
                donacion.setCaptura(rs.getBlob(7));
                donacionList.add(donacion);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacionList;
    }



    public ArrayList<Donacion> listarNotificacionesDonaciones(int pagina){
        ArrayList<Donacion> donacionList= new ArrayList<>();
        String sql = "select idDonacion, idUsuario, medioPago, monto,fechaHora,captura,estadoDonacion,date(fechaHoraValidado),time(fechaHoraValidado) from donacion order by if(estadoDonacion='Pendiente',0,1),fechaHora desc limit 12 offset ?";
        try (Connection conn=this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,pagina*12);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    Donacion donacion = new Donacion();
                    donacion.setIdDonacion(rs.getInt(1));
                    donacion.getUsuario().setIdUsuario(rs.getInt(2));
                    donacion.setMedioPago(rs.getString(3));
                    donacion.setMonto(rs.getFloat(4));
                    donacion.setFecha(rs.getDate(5));
                    donacion.setCaptura(rs.getBlob(6));
                    donacion.setEstadoDonacion(rs.getString(7));
                    donacion.setFechaValidacion(rs.getDate(8));
                    donacion.setHoraValidacion(rs.getTime(9));
                    donacionList.add(donacion);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacionList;
    }

    public ArrayList<Donacion> listarNotificacionesDonaciones(String buscar, int pagina){
        ArrayList<Donacion> donacionList= new ArrayList<>();
        String sql = "select d.idDonacion, d.idUsuario, d.medioPago, d.monto,d.fechaHora,d.estadoDonacion FROM donacion d inner join usuario u on d.idUsuario=u.idUsuario where concat(u.nombre,' ',u.apellido) like ? order by if(d.estadoDonacion='Pendiente',0,1),fechaHora desc limit 12 offset ?";
        try (Connection conn=this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,"%"+buscar+"%");
            pstmt.setInt(2,pagina*12);
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

    public ArrayList<Donacion> listarNotificacionesDonaciones(String buscar){
        ArrayList<Donacion> donacionList= new ArrayList<>();
        String sql = "select d.idDonacion, d.idUsuario, d.medioPago, d.monto,d.fechaHora,d.estadoDonacion from donacion d inner join usuario u on d.idUsuario=u.idUsuario where u.nombre like ? or u.apellido like ? order by if(d.estadoDonacion='Pendiente',0,1),fechaHora desc";
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

    public ArrayList<Donacion> listarNotificacionesDonaciones(String fecha1,String fecha2, int pagina){
        ArrayList<Donacion> donacionList= new ArrayList<>();
        String sql = "select idDonacion, idUsuario, medioPago, monto,fechaHora,estadoDonacion from donacion where date(fechaHora) between ? and ? order by if(estadoDonacion='Pendiente',0,1),fechaHora desc limit 12 offset ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,fecha1);
            pstmt.setString(2,fecha2);
            pstmt.setInt(3,pagina*12);
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
        String sql = "select idDonacion, idUsuario, medioPago, monto,fechaHora,estadoDonacion from donacion where date(fechaHora) between ? and ? order by if(estadoDonacion='Pendiente',0,1),fechaHora desc";
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

    public ArrayList<Donacion> juntarListas(ArrayList<Donacion> lista1, ArrayList<Donacion> lista2){
        ArrayList<Donacion> listaFinal = new ArrayList<>();
        HashSet<Integer> ids1 = new HashSet<Integer>();
        HashSet<Integer> ids2 = new HashSet<Integer>();
        for(Donacion d1: lista1){
            ids1.add(d1.getIdDonacion());
        }
        for(Donacion d2: lista2){
            ids2.add(d2.getIdDonacion());
        }
        ids1.retainAll(ids2);
        for(int id : ids1){
            listaFinal.add(obtenerDonacionPorID(id));
        }
        return listaFinal;
    }

    public Donacion obtenerDonacionPorID(int idDonacion){
        Donacion donacion = new Donacion();
        String sql = "select idDonacion, idUsuario, medioPago, monto,fechaHora,estadoDonacion from donacion where idDonacion=?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idDonacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    donacion.setIdDonacion(rs.getInt(1));
                    donacion.getUsuario().setIdUsuario(rs.getInt(2));
                    donacion.setMedioPago(rs.getString(3));
                    donacion.setMonto(rs.getFloat(4));
                    donacion.setFecha(rs.getDate(5));
                    donacion.setEstadoDonacion(rs.getString(6));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return donacion;
    }

    public ArrayList<Validacion> listarNotificacionesRecuperacion(int pagina){
        ArrayList<Validacion> validacionList= new ArrayList<>();
        String sql = "select correo,tipo,codigoValidacion,fechaHora,idCorreoValidacion,linkEnviado,codigoValidacion256 from validacion where tipo!='enviarLinkACorreo' order by if(linkEnviado is false,0,1),idCorreoValidacion desc limit 12 offset ?";
        try (Connection conn=this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,pagina*12);
            try(ResultSet rs=pstmt.executeQuery()) {

                while (rs.next()) {

                    Validacion validacion = new Validacion();
                    validacion.setCorreo(rs.getString(1));
                    validacion.setTipo(rs.getString(2));
                    validacion.setCodigoValidacion(rs.getInt(3));
                    validacion.setFechaHora(rs.getDate(4));
                    validacion.setIdCorreoValidacion(rs.getInt(5));
                    validacion.setLinkEnviado(rs.getBoolean(6));
                    validacionList.add(validacion);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return validacionList;
    }

    public ArrayList<Validacion> listarNotificacionesRecuperacion(){

        ArrayList<Validacion> validacionList= new ArrayList<>();

        String sql = "select correo,tipo,codigoValidacion,fechaHora,idCorreoValidacion,linkEnviado,codigoValidacion256 from validacion where tipo!='enviarLinkACorreo' order by if(linkEnviado is false,0,1),idCorreoValidacion desc";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {

            while (rs.next()) {

                Validacion validacion = new Validacion();
                validacion.setCorreo(rs.getString(1));
                validacion.setTipo(rs.getString(2));
                validacion.setCodigoValidacion(rs.getInt(3));
                validacion.setFechaHora(rs.getDate(4));
                validacion.setIdCorreoValidacion(rs.getInt(5));
                validacion.setLinkEnviado(rs.getBoolean(6));
                validacion.setCodigoValidacion256(rs.getString(7));
                validacionList.add(validacion);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return validacionList;
    }


    public Validacion getValidacionxId(int idCorreoValidacion ){
        Validacion validacion = new Validacion();
        String sql = "select correo,tipo,codigoValidacion,fechaHora,idCorreoValidacion,linkEnviado,codigoValidacion256 from validacion where idCorreoValidacion = ? ";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idCorreoValidacion);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    validacion.setCorreo(rs.getString(1));
                    validacion.setTipo(rs.getString(2));
                    validacion.setCodigoValidacion(rs.getInt(3));
                    validacion.setFechaHora(rs.getDate(4));
                    validacion.setIdCorreoValidacion(rs.getInt(5));
                    validacion.setLinkEnviado(rs.getBoolean(6));
                    validacion.setCodigoValidacion256(rs.getString(7));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        return validacion;
    }

    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(int idDelegadoDeActividad){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();
        String sql = "select ae.idAlumnoPorEvento, ae.idAlumno ,ae.idEvento,u.fotoPerfil,u.fotoSeguro,date(ae.fechaHoraSolicitud),time(ae.fechaHoraSolicitud)  from alumnoporevento ae inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad=a.idActividad inner join usuario u on ae.idAlumno = u.idUsuario where a.idDelegadoDeActividad=? and estadoApoyo = 'Pendiente' order by fechaHoraSolicitud desc";

        try (Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    AlumnoPorEvento alumnoPorEvento=new AlumnoPorEvento();
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.getAlumno().setIdUsuario(rs.getInt(2));
                    alumnoPorEvento.getEvento().setIdEvento(rs.getInt(3));
                    alumnoPorEvento.getAlumno().setFotoPerfil(rs.getBlob(4));
                    alumnoPorEvento.getAlumno().setFotoSeguro(rs.getBlob(5));
                    alumnoPorEvento.setFechaSolicitud(rs.getDate(6));
                    alumnoPorEvento.setHoraSolicitud(rs.getTime(7));
                    listaSolicitudesApoyo.add(alumnoPorEvento);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudesApoyo;
    }


    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(int idDelegadoDeActividad,int pagina){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();
        String sql = "select ae.idAlumnoPorEvento, ae.idAlumno ,ae.idEvento,u.fotoPerfil,u.fotoSeguro,date(ae.fechaHoraSolicitud),time(ae.fechaHoraSolicitud) from alumnoporevento ae inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad=a.idActividad inner join usuario u on ae.idAlumno = u.idUsuario where a.idDelegadoDeActividad=? and estadoApoyo = 'Pendiente' order by fechaHoraSolicitud desc limit 12 offset ?";

        try (Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idDelegadoDeActividad);
            pstmt.setInt(2,pagina*12);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()){
                    AlumnoPorEvento alumnoPorEvento=new AlumnoPorEvento();
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.getAlumno().setIdUsuario(rs.getInt(2));
                    alumnoPorEvento.getEvento().setIdEvento(rs.getInt(3));
                    alumnoPorEvento.getAlumno().setFotoPerfil(rs.getBlob(4));
                    alumnoPorEvento.getAlumno().setFotoSeguro(rs.getBlob(5));
                    alumnoPorEvento.setFechaSolicitud(rs.getDate(6));
                    alumnoPorEvento.setHoraSolicitud(rs.getTime(7));
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

        

        String sql = "select ae.idAlumnoPorEvento, ae.idAlumno,ae.idEvento,u.fotoPerfil,u.fotoSeguro,date(ae.fechaHoraSolicitud),time(ae.fechaHoraSolicitud)  from alumnoporevento ae inner join usuario u on ae.idAlumno = u.idUsuario inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad=a.idActividad where (u.nombre like ? or u.apellido like ?) and  estadoApoyo = 'Pendiente' and a.idDelegadoDeActividad=? order by ae.fechaHoraSolicitud desc";


        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,"%"+buscar+"%");
            pstmt.setString(2,"%"+buscar+"%");
            pstmt.setInt(3,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    AlumnoPorEvento alumnoPorEvento = new AlumnoPorEvento();
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.getAlumno().setIdUsuario(rs.getInt(2));
                    alumnoPorEvento.getEvento().setIdEvento(rs.getInt(3));
                    alumnoPorEvento.getAlumno().setFotoPerfil(rs.getBlob(4));
                    alumnoPorEvento.getAlumno().setFotoSeguro(rs.getBlob(5));
                    alumnoPorEvento.setFechaSolicitud(rs.getDate(6));
                    alumnoPorEvento.setHoraSolicitud(rs.getTime(7));
                    listaSolicitudesApoyo.add(alumnoPorEvento);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudesApoyo;
    }

    public ArrayList<AlumnoPorEvento> listarSolicitudesDeApoyo(int idDelegadoDeActividad,String buscar,int pagina){

        ArrayList<AlumnoPorEvento> listaSolicitudesApoyo = new ArrayList<>();



        String sql = "select ae.idAlumnoPorEvento, ae.idAlumno,ae.idEvento,u.fotoPerfil,u.fotoSeguro,date(ae.fechaHoraSolicitud),time(ae.fechaHoraSolicitud)  from alumnoporevento ae inner join usuario u on ae.idAlumno = u.idUsuario inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad=a.idActividad where (u.nombre like ? or u.apellido like ?) and  estadoApoyo = 'Pendiente' and a.idDelegadoDeActividad=? order by ae.fechaHoraSolicitud desc limit 12 offset ?";


        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,"%"+buscar+"%");
            pstmt.setString(2,"%"+buscar+"%");
            pstmt.setInt(3,idDelegadoDeActividad);
            pstmt.setInt(4,pagina*12);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    AlumnoPorEvento alumnoPorEvento = new AlumnoPorEvento();
                    alumnoPorEvento.setIdAlumnoPorEvento(rs.getInt(1));
                    alumnoPorEvento.getAlumno().setIdUsuario(rs.getInt(2));
                    alumnoPorEvento.getEvento().setIdEvento(rs.getInt(3));
                    alumnoPorEvento.getAlumno().setFotoPerfil(rs.getBlob(4));
                    alumnoPorEvento.getAlumno().setFotoSeguro(rs.getBlob(5));
                    alumnoPorEvento.setFechaSolicitud(rs.getDate(6));
                    alumnoPorEvento.setHoraSolicitud(rs.getTime(7));
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
        

        String sql = "select fechaHora from donacion";
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
        String sql="update alumnoporevento set estadoApoyo=? where idAlumnoPorEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,tipoDeApoyo);
            pstmt.setInt(2,idAlumnoPorEvento);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionValidacion(int idValidacion){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,estado,idValidacion) values(now(),'No leido',?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idValidacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionSolicitudDeRegistro(int idUsuario){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,estado,idUsuario) values(now(),'No leido',?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionDonacion(int idDonacion){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,estado,idDonacion) values(now(),'No leido',?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDonacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearNotificacionReporte(int idReporte){
        String sql="insert into notificaciondelegadogeneral (fechaHoraNotificacion,estado,idReporte) values(now(),'No leido',?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idReporte);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<NotificacionDelegadoGeneral>listarNotificacionesDelegadoGeneral(){
        ArrayList<NotificacionDelegadoGeneral>listaDeNotificaciones= new ArrayList<>();
        String sql = "select idNotificacion,idReporte,idDonacion,idUsuario,idValidacion from notificaciondelegadogeneral where estado='No leido' order by fechaHoraNotificacion desc limit 8";
        try (Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)) {
            while (rs.next()) {
                NotificacionDelegadoGeneral noti=new NotificacionDelegadoGeneral();
                noti.setIdNotificacion(rs.getInt(1));
                noti.getReporte().setIdReporte(rs.getInt(2));
                noti.getDonacion().setIdDonacion(rs.getInt(3));
                noti.getUsuario().setIdUsuario(rs.getInt(4));
                noti.getValidacion().setIdCorreoValidacion(rs.getInt(5));
                listaDeNotificaciones.add(noti);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaDeNotificaciones;
    }

    public Integer[] obtenerDiferenciaEntre2FechasNotificaciones(int idNotificacion){
        Integer[] diferencia=new Integer[6];
        String sql ="select timestampdiff(year,fechaHoraNotificacion,now()),timestampdiff(month,fechaHoraNotificacion,now()),timestampdiff(day,fechaHoraNotificacion,now()),timestampdiff(hour,fechaHoraNotificacion,now()),timestampdiff(minute,fechaHoraNotificacion,now()),timestampdiff(second,fechaHoraNotificacion,now()) from notificaciondelegadogeneral where idNotificacion=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idNotificacion);
            try(ResultSet rs=pstmt.executeQuery()){
                if (rs.next()) {
                    diferencia[0]=rs.getInt(1);
                    diferencia[1]= rs.getInt(2)%12;
                    diferencia[2]=rs.getInt(3)%30;
                    diferencia[3]=rs.getInt(4)%24;
                    diferencia[4]=rs.getInt(5)%60;
                    diferencia[5]= rs.getInt(6)%60;
                    return diferencia;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer[] obtenerDiferenciaEntre2FechasNotificacionesDelegadoDeActividad(int idAlumnoPorEvento){
        Integer[] diferencia=new Integer[6];
        String sql ="select timestampdiff(year,fechaHoraSolicitud,now()),timestampdiff(month,fechaHoraSolicitud,now()),timestampdiff(day,fechaHoraSolicitud,now()),timestampdiff(hour,fechaHoraSolicitud,now()),timestampdiff(minute,fechaHoraSolicitud,now()),timestampdiff(second,fechaHoraSolicitud,now()) from alumnoporevento where idAlumnoPorEvento=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idAlumnoPorEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if (rs.next()) {
                    diferencia[0]=rs.getInt(1);
                    diferencia[1]= rs.getInt(2)%12;
                    diferencia[2]=rs.getInt(3)%30;
                    diferencia[3]=rs.getInt(4)%24;
                    diferencia[4]=rs.getInt(5)%60;
                    diferencia[5]= rs.getInt(6)%60;
                    return diferencia;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void notificacionLeida(String idNotificacion){
        String sql="update notificaciondelegadogeneral set estado='Leido' where idNotificacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idNotificacion);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String obtenerDireccionIP(){
        try {
            InetAddress direccionIP = InetAddress.getLocalHost();
            return direccionIP.getHostAddress();

        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return "";
    }

    public ArrayList<AlumnoPorEvento>listarNotificacionesDelegadoDeActividad(int idDelegadoDeActividad){
        ArrayList<AlumnoPorEvento>listaNotificaciones= new ArrayList<>();
        String sql="select ae.idAlumnoPorEvento,ae.idAlumno,ae.idEvento,ae.fechaHoraSolicitud,u.nombre,u.apellido,u.fotoPerfil,e.titulo from alumnoporevento ae inner join usuario u on ae.idAlumno=u.idUsuario inner join evento e on ae.idEvento=e.idEvento inner join actividad a on e.idActividad = a.idActividad where ae.notificacionLeida=false and a.idDelegadoDeActividad=?";
        try (Connection conn=this.getConnection();PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idDelegadoDeActividad);
            try(ResultSet rs=pstmt.executeQuery()){
                while (rs.next()) {
                    AlumnoPorEvento ae=new AlumnoPorEvento();
                    ae.setIdAlumnoPorEvento(rs.getInt(1));
                    ae.getAlumno().setIdUsuario(rs.getInt(2));
                    ae.getEvento().setIdEvento(rs.getInt(3));
                    ae.setFechaSolicitud(rs.getDate(4));
                    ae.getAlumno().setNombre(rs.getString(5));
                    ae.getAlumno().setApellido(rs.getString(6));
                    ae.getAlumno().setFotoPerfil(rs.getBlob(7));
                    ae.getEvento().setTitulo(rs.getString(8));
                    listaNotificaciones.add(ae);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaNotificaciones;
    }

    public void notificacionLeidaDelegadoDeActividad(String idAlumnoPorEvento){
        String sql="update alumnoporevento set notificacionLeida=true where idAlumnoPorEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idAlumnoPorEvento);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
