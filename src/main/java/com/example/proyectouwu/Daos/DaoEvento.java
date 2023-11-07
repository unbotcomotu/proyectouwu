package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Evento;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;

public class DaoEvento extends DaoPadre {
    private Connection conn;

    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto", super.getUser(), super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Evento eventoPorIDsinMiniatura(int idEvento) {
        Evento e = new Evento();
        String sql = "select idEvento,idActividad,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,eventoFinalizado,eventoOculto,resumen,resultadoEvento from Evento where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    e.setIdEvento(rs.getInt(1));
                    e.setIdActividad(rs.getInt(2));
                    e.setLugarEvento(rs.getInt(3));
                    e.setTitulo(rs.getString(4));
                    e.setFecha(rs.getDate(5));
                    e.setHora(rs.getTime(6));
                    e.setDescripcionEventoActivo(rs.getString(7));
                    e.setFraseMotivacional(rs.getString(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    String sql2 = "select c.foto from Evento e inner join FotoEventoCarrusel c on e.idEvento=c.idEvento";
                    try (ResultSet rs2 = conn.createStatement().executeQuery(sql2)) {
                        while (rs2.next()) {
                            e.getCarruselFotos().add(rs2.getBlob(1));
                        }
                    }
                    return e;
                } else {
                    return null;
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public ArrayList<Evento> listarEventos(int idActividad) {
        ArrayList<Evento> listaEventos = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idActividad);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setLugarEvento(rs.getInt(2));
                    e.setTitulo(rs.getString(3));
                    e.setFecha(rs.getDate(4));
                    e.setHora(rs.getTime(5));
                    e.setDescripcionEventoActivo(rs.getString(6));
                    e.setFraseMotivacional(rs.getString(7));
                    e.setFotoMiniatura(rs.getBlob(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    listaEventos.add(e);
                }
            }
            return listaEventos;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public String actividadDeEventoPorID(int idEvento) {
        //Busqueda de un evento
        String sql = "select a.nombre from Evento e inner join Actividad a on e.idActividad=a.idActividad where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String lugarPorEventoID(int idEvento) {
        String sql = "select l.lugar from LugarEvento l inner join Evento e on l.idLugarEvento=e.idLugarEvento where e.idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer diferenciaDiasEventoActualidad(int idEvento) {
        String sql = "select datediff(fecha,current_date()) from Evento where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer idDelegadoDeActividadPorEvento(int idEvento) {
        String sql = "select a.idDelegadoDeActividad from Actividad a inner join Evento e on e.idActividad=a.idActividad where idEvento=?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Integer> cantidadApoyosBarraEquipoPorEvento(int idEvento) {
        ArrayList<Integer> cantidadApoyos = new ArrayList<>();
        String sql = "select count(estadoApoyo) from AlumnoPorEvento where idEvento=? group by estadoApoyo having estadoApoyo='Equipo'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cantidadApoyos.add(rs.getInt(1));
                } else {
                    cantidadApoyos.add(0);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sql = "select count(estadoApoyo) from AlumnoPorEvento where idEvento=? group by estadoApoyo having estadoApoyo='Barra'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cantidadApoyos.add(rs.getInt(1));
                } else {
                    cantidadApoyos.add(0);
                }
            }
            return cantidadApoyos;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer solicitudesSinAtenderPorEvento(int idEvento) {
        String sql = "select count(idAlumnoPorEvento) from AlumnoPorEvento where idEvento=? group by estadoApoyo having estadoApoyo='Pendiente'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    return 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearEvento(int idActividad, int idLugarEvento, String titulo, Date fecha, Time hora, String descripcionEventoActivo, String fraseMotivacional, String fotoMiniatura, Boolean eventoOculto) {
        String sql = "insert into evento(idActividad,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMiniatura,eventoFinalizado,eventoOculto) values (?,?,?,?,?,?,?,?,0,?)";
        Evento e = new Evento();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idActividad);
            pstmt.setInt(2, idLugarEvento);
            pstmt.setString(3, titulo);
            pstmt.setDate(4, fecha);
            pstmt.setTime(5, hora);
            pstmt.setString(6, descripcionEventoActivo);
            pstmt.setString(7, fraseMotivacional);
            pstmt.setString(8, fotoMiniatura);
            pstmt.setBoolean(9,eventoOculto);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public void editarEvento(int idEvento, int idLugarEvento, String titulo, Date fecha, Time hora, String descripcionEventoActivo, String fraseMotivacional, String fotoMiniatura, Boolean eventoOculto) {
        String sql = "update evento set idLugarEvento=?,titulo=?,fecha=?,hora=?,descripcionEventoActivo=?,fraseMotivacional=?,fotoMiniatura=?,eventoOculto=? where idEvento=?";
        Evento e = new Evento();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idLugarEvento);
            pstmt.setString(2, titulo);
            pstmt.setDate(3, fecha);
            pstmt.setTime(4, hora);
            pstmt.setString(5, descripcionEventoActivo);
            pstmt.setString(6, fraseMotivacional);
            pstmt.setString(7, fotoMiniatura);
            pstmt.setBoolean(8,eventoOculto);
            pstmt.setInt(9,idEvento);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public void editarEvento(int idEvento, String titulo, String resumen, String resultadoEvento, Boolean eventoOculto) {
        String sql = "update evento set titulo=?,resumen=?,resultadoEvento=?,eventoOculto=? where idEvento=?";
        Evento e = new Evento();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, titulo);
            pstmt.setString(2,resumen);
            pstmt.setString(3,resultadoEvento);
            pstmt.setBoolean(4,eventoOculto);
            pstmt.setInt(5,idEvento);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public void actualizarEditarEvento(int idEvento, int idActividad, int lugarEvento, String titulo, String fecha, String hora, String descripcionEventoActivo, String fraseMotivacional, Blob fotoMiniatura, String eventoFinalizado, String eventoOculto, String resumen, String resultadoEvento) {

        String sql = "update evento set idEvento = ?,idActividad= ?,idLugarEvento= ?,titulo= ?,fecha= ?,hora= ?,descripcionEventoActivo= ?,fraseMotivacional= ?,fotoMiniatura= ?,eventoFinalizado= ?,eventoOculto= ?,resumen= ?,resultadoEvento= ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(2, lugarEvento);
            pstmt.setString(3, titulo);
            pstmt.setString(4, fecha);
            pstmt.setString(5, hora);
            pstmt.setString(6, descripcionEventoActivo);
            pstmt.setString(7, fraseMotivacional);
            pstmt.setBlob(8, fotoMiniatura);
            pstmt.setString(9, eventoFinalizado);
            pstmt.setString(10, eventoOculto);
            pstmt.setString(11, resumen);
            pstmt.setString(12, resultadoEvento);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public boolean eventoEstaFinalizado(int idEvento){ //validar si el evento está o no finalizado
        String sql = "select eventoFinalizado from evento where idEvento = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                rs.next();
                if(rs.getBoolean(1)==true){
                    return true;
                }else{
                    return false;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void finalizarEvento(int idEvento, String resumen, String resultado){ //finaliza evento
        String sql = "update evento set eventoFinalizado=1, resumen = ?, resultadoEvento = ? where idEvento=?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if(!eventoEstaFinalizado(idEvento)){
                pstmt.setString(1,resumen);
                pstmt.setString(2,resultado);
                pstmt.setInt( 3,idEvento);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int idEventoPorNombre(String nombre){
        String sql="select idEvento from evento where lower(?)=titulo";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,nombre);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Evento> buscarEventoPorNombre(String name,int idActividad){
        ArrayList<Evento> lista = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? and lower(titulo) like lower(?)";
        try(PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.setString(2,"%"+name+"%");
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setLugarEvento(rs.getInt(2));
                    e.setTitulo(rs.getString(3));
                    e.setFecha(rs.getDate(4));
                    e.setHora(rs.getTime(5));
                    e.setDescripcionEventoActivo(rs.getString(6));
                    e.setFraseMotivacional(rs.getString(7));
                    e.setFotoMiniatura(rs.getBlob(8));
                    e.setEventoFinalizado(rs.getBoolean(9));
                    e.setEventoOculto(rs.getBoolean(10));
                    e.setResumen(rs.getString(11));
                    e.setResultadoEvento(rs.getString(12));
                    lista.add(e);
                }
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Evento> filtrarEventos(ArrayList<String> parametrosEstado, ArrayList<Integer> parametrosLugar, ArrayList<String> parametrosFecha, String horaInicio, String horaFin, int idActividad){
        HashSet<Integer> idsEstado = new HashSet<Integer>();
        HashSet<Integer> idsLugar = new HashSet<Integer>();
        HashSet<Integer> idsFecha = new HashSet<Integer>();
        HashSet<Integer> idsHora = new HashSet<Integer>();
        for(String s : parametrosEstado){
            if(s.equals("Oculto")){
                String sql = "select idEvento from evento where eventoOculto=true and idActividad = ?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsEstado.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(s.equals("Finalizado")){
                String sql = "select idEvento from evento where eventoFinalizado=true and idActividad = ?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsEstado.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(s.equals("Apoyando")){
                String sql = "select e.idEvento from evento e inner join alumnoporevento ape on e.idEvento = ape.idEvento where ape.estadoApoyo != 'Pendiente' and e.idActividad = ?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsEstado.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        //el nombre fue idea de Josh Fernando Yauri Salas - 20213852
        for(Integer minaya : parametrosLugar){
            String sql = "select idEvento from evento where idActividad = ? and idLugarEvento = ?";
            try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                pstmt.setInt(2,minaya);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsLugar.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        for(String woody : parametrosFecha){
            if(woody.equals("Hoy")){
                String sql = "select idEvento from evento where datediff(date(current_date()),fecha)=0 and idActividad=?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsFecha.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(woody.equals("Manana")){
                String sql = "select idEvento from evento where datediff(fecha,date(current_date()))=1 and idActividad=?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsFecha.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(woody.equals("MasDias")){
                String sql = "select idEvento from evento where datediff(fecha,date(current_date()))>1 and idActividad=?";
                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsFecha.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        idsEstado.retainAll(idsLugar);
        idsEstado.retainAll(idsFecha);
        if(horaInicio != null) {
            String sql = "select idEvento from evento where idActividad = ? and hora between ? and ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, idActividad);
                pstmt.setString(2, horaInicio + ":00");
                pstmt.setString(3, horaFin + ":00");
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        idsHora.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            idsEstado.retainAll(idsHora);
        }
        ArrayList<Evento> lista = new ArrayList<>();
        for(Integer stuardotqm : idsEstado){
            String sql = "select idEvento,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMiniatura,eventoFinalizado,eventoOculto,resumen,resultadoEvento from evento where idEvento=?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1,stuardotqm);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if(rs.next()) {
                        Evento e = new Evento();
                        e.setIdEvento(rs.getInt(1));
                        e.setLugarEvento(rs.getInt(2));
                        e.setTitulo(rs.getString(3));
                        e.setFecha(rs.getDate(4));
                        e.setHora(rs.getTime(5));
                        e.setDescripcionEventoActivo(rs.getString(6));
                        e.setFraseMotivacional(rs.getString(7));
                        e.setFotoMiniatura(rs.getBlob(8));
                        e.setEventoFinalizado(rs.getBoolean(9));
                        e.setEventoOculto(rs.getBoolean(10));
                        e.setResumen(rs.getString(11));
                        e.setResultadoEvento(rs.getString(12));
                        lista.add(e);
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return lista;
    }
}
