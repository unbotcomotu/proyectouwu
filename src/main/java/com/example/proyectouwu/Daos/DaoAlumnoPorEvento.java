package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Evento;
import com.example.proyectouwu.DTOs.TopApoyo;

import java.sql.*;
import java.util.ArrayList;

public class DaoAlumnoPorEvento extends DaoPadre {
    public String verificarApoyo(int idEvento,int idUsuario){
        String sql="select estadoApoyo from AlumnoPorEvento where idAlumno=? and idEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            pstmt.setInt(2,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<Evento> listarEventosPorUsuario(int idUsuario){
        ArrayList<Evento>listaEventos=new ArrayList<>();
        String sql="select e.idEvento,e.idActividad,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento,e.fotoMiniatura from AlumnoPorEvento ae inner join Evento e on ae.idEvento=e.idEvento where idAlumno=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Evento e=new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getActividad().setIdActividad(rs.getInt(2));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(3));
                    e.setTitulo(rs.getString(4));
                    e.setFecha(rs.getDate(5));
                    e.setHora(rs.getTime(6));
                    e.setDescripcionEventoActivo(rs.getString(7));
                    e.setFraseMotivacional(rs.getString(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    e.setFotoMiniatura(rs.getBlob(13));
                    listaEventos.add(e);
                }return listaEventos;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadTotalApoyosEstudiantes(){
        String sql="select count(ae.idAlumnoPorEvento) from AlumnoPorEvento ae inner join Usuario u on ae.idAlumno=u.idUsuario where ae.estadoApoyo!='Pendiente' and u.condicion='Estudiante'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql);) {
            if(rs.next()){
                return rs.getInt(1);
            }else {
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer cantidadTotalApoyosEgresados(){
        String sql="select count(ae.idAlumnoPorEvento) from AlumnoPorEvento ae inner join Usuario u on ae.idAlumno=u.idUsuario where ae.estadoApoyo!='Pendiente' and u.condicion='Egresado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql);) {
            if(rs.next()){
                return rs.getInt(1);
            }else {
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Integer solicitudesApoyoHaceNdias(int n){
        String sql = "select count(idAlumnoPorEvento) from AlumnoPorEvento where day(now())-day(fechaHoraSolicitud)=? group by day(fechaHoraSolicitud)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,n);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()) {
                    return rs.getInt(1);
                }else{
                    return 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void usuarioApoyaEvento(int idUsuario,int idEvento){
        String sql = "insert into alumnoporevento (  idAlumno, idEvento , estadoApoyo, fechaHoraSolicitud,notificacionLeida) values (?, ?, ? , now(),false)";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            //pstmt.setInt(1,idUser);
            pstmt.setInt(1,idUsuario); //nuevos usuarios se registran como alumnos
            pstmt.setInt(2,idEvento);
            pstmt.setString(3,"Pendiente");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public TopApoyo topApoyoUltimaSemana(){
        String sql = "select u.nombre,u.apellido,u.fotoPerfil,aux.cantidadApoyos from usuario u inner join (select uAux.idUsuario as 'id',count(ae.idAlumnoPorEvento) as 'cantidadApoyos' from alumnoporevento ae inner join usuario uAux on uAux.idUsuario=ae.idAlumno and datediff(now(),ae.fechaHoraSolicitud)<=7 group by ae.idAlumno order by count(ae.idAlumnoPorEvento) desc,max(fechaHoraSolicitud) desc limit 1) aux on u.idUsuario=aux.id";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            if(rs.next()) {
                TopApoyo t=new TopApoyo();
                t.getUsuario().setNombre(rs.getString(1));
                t.getUsuario().setApellido(rs.getString(2));
                t.getUsuario().setFotoPerfil(rs.getBlob(3));
                t.setCantidadEventosApoyados(rs.getInt(4));
                return t;
            }else{
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public TopApoyo topApoyoTotal(){
        String sql = "select u.nombre,u.apellido,u.fotoPerfil,aux.cantidadApoyos from usuario u inner join (select uAux.idUsuario as 'id',count(ae.idAlumnoPorEvento) as 'cantidadApoyos' from alumnoporevento ae inner join usuario uAux on uAux.idUsuario=ae.idAlumno group by ae.idAlumno order by count(ae.idAlumnoPorEvento) desc,max(fechaHoraSolicitud) desc limit 1) aux on u.idUsuario=aux.id";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            if(rs.next()) {
                TopApoyo t=new TopApoyo();
                t.getUsuario().setNombre(rs.getString(1));
                t.getUsuario().setApellido(rs.getString(2));
                t.getUsuario().setFotoPerfil(rs.getBlob(3));
                t.setCantidadEventosApoyados(rs.getInt(4));
                return t;
            }else{
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
