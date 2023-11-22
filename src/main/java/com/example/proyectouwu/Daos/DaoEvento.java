package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Evento;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;

public class DaoEvento extends DaoPadre {
    public Evento eventoPorIDsinMiniatura(int idEvento) {
        Evento e = new Evento();
        String sql = "select idEvento,idActividad,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,eventoFinalizado,eventoOculto,resumen,resultadoEvento from Evento where idEvento=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
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
                    String sql2 = "select idFotoEventoCarrusel,foto from FotoEventoCarrusel where idEvento=?";
                    try (PreparedStatement pstmt2=conn.prepareStatement(sql2)) {
                        pstmt2.setInt(1,idEvento);
                        try(ResultSet rs2=pstmt2.executeQuery()){
                            while (rs2.next()) {
                                e.getCarruselFotos().add(rs2.getBlob(2));
                            }
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idActividad);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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

    public ArrayList<Evento> listarEventos(int idActividad, int pagina) {
        ArrayList<Evento> listaEventos = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? limit 8 offset ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idActividad);
            pstmt.setInt(2,pagina*8);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        String sql = "select datediff(fecha,now()) from Evento where idEvento=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

    public void crearEvento(int idActividad, int idLugarEvento, String titulo, Date fecha, Time hora, String descripcionEventoActivo, String fraseMotivacional, InputStream fotoMiniatura, Boolean eventoOculto, ServletContext sc) throws SQLException, IOException{
        String sql = "insert into evento(idActividad,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMiniatura,eventoFinalizado,eventoOculto) values (?,?,?,?,?,?,?,?,0,?)";
        Evento e = new Evento();
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, idActividad);
            pstmt.setInt(2, idLugarEvento);
            pstmt.setString(3, titulo);
            pstmt.setDate(4, fecha);
            pstmt.setTime(5, hora);
            pstmt.setString(6, descripcionEventoActivo);
            pstmt.setString(7, fraseMotivacional);
            pstmt.setBinaryStream(8, fotoMiniatura,(int)fotoMiniatura.available());
            pstmt.setBoolean(9,eventoOculto);
            pstmt.executeUpdate();

            ResultSet rs = pstmt.getGeneratedKeys();

            //Se adicionan imágenes placeholder para el carrusel:

            int idEvento=0;

            if(rs.next()){
                idEvento = rs.getInt(1);
            }

            sql = "insert into fotoeventocarrusel(idEvento,foto) values (?,?)";

            String ruta1 = "/css/fotoYarleque.png";
            String ruta2 = "/css/fotoYarleque2.jpg";
            String ruta3 = "/css/fotoYarleque3.jpg";

            ArrayList<String> rutaArray = new ArrayList<>();
            rutaArray.add(ruta1);
            rutaArray.add(ruta2);
            rutaArray.add(ruta3);

            InputStream input = null;

            for(String ruta: rutaArray){
                try(PreparedStatement ps = conn.prepareStatement(sql);){
                    input = sc.getResourceAsStream(ruta);
                    ps.setInt(1,idEvento);
                    ps.setBinaryStream(2,input,(int)input.available());
                    ps.executeUpdate();
                }
            }
            input.close();
        }catch (SQLException ee){
            throw new RuntimeException(ee);
        }
    }

    public void editarEvento(int idEvento, int idLugarEvento, String titulo, Date fecha, Time hora, String descripcionEventoActivo, String fraseMotivacional, InputStream fotoMiniatura, Boolean eventoOculto,boolean validarLongitud) throws SQLException, IOException {

        String secFoto = "";
        if(validarLongitud){
            secFoto = ",fotoMiniatura=?";
        }

        String sql = "update evento set idLugarEvento=?,titulo=?,fecha=?,hora=?,descripcionEventoActivo=?,fraseMotivacional=?,eventoOculto=?"+secFoto+" where idEvento=?";
        Evento e = new Evento();
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idLugarEvento);
            pstmt.setString(2, titulo);
            pstmt.setDate(3, fecha);
            pstmt.setTime(4, hora);
            pstmt.setString(5, descripcionEventoActivo);
            pstmt.setString(6, fraseMotivacional);
            pstmt.setBoolean(7,eventoOculto);
            if(validarLongitud){
                pstmt.setBinaryStream(8,fotoMiniatura,fotoMiniatura.available());
                pstmt.setInt(9,idEvento);
            }else{
                pstmt.setInt(8,idEvento);
            }

            pstmt.executeUpdate();
        }
    }

    public void editarEvento(int idEvento, String titulo, String resumen, String resultadoEvento, Boolean eventoOculto) {
        String sql = "update evento set titulo=?,resumen=?,resultadoEvento=?,eventoOculto=? where idEvento=?";
        Evento e = new Evento();
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

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
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idEvento);
            try (ResultSet rs = pstmt.executeQuery()) {
                rs.next();
                if(rs.getBoolean(1)){
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

        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
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
        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.setString(2,"%"+name+"%");
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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

    public ArrayList<Evento> buscarEventoPorNombre(String name,int idActividad, int pagina){
        ArrayList<Evento> lista = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? and lower(titulo) like lower(?) limit 8 offset ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idActividad);
            pstmt.setString(2,"%"+name+"%");
            pstmt.setInt(3,pagina*8);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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

    public ArrayList<Evento> filtrarEventos(ArrayList<String> parametrosEstado, ArrayList<Integer> parametrosLugar, ArrayList<String> parametrosFecha, String horaInicio, String horaFin, int idActividad, int idUsuario){
        HashSet<Integer> idsEvento = new HashSet<>();
        String sqlEvento = "select idEvento from evento where idActividad = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sqlEvento)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs = pstmt.executeQuery()){
                while(rs.next()){
                    idsEvento.add(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        HashSet<Integer> idsOculto = new HashSet<Integer>();
        HashSet<Integer> idsFinalizado = new HashSet<Integer>();
        HashSet<Integer> idsApoyando = new HashSet<Integer>();
        HashSet<Integer> idsLugar = new HashSet<Integer>();
        HashSet<Integer> idsHoy = new HashSet<Integer>();
        HashSet<Integer> idsManana = new HashSet<Integer>();
        HashSet<Integer> idsMasDias = new HashSet<Integer>();
        HashSet<Integer> idsHora = new HashSet<Integer>();

            if(parametrosEstado.contains("Oculto")){
                String sql = "select idEvento from evento where eventoOculto=true and idActividad = ?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsOculto.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }else {
                String sql = "select idEvento from evento where idActividad = ?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsOculto.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(parametrosEstado.contains("Finalizado")){
                String sql = "select idEvento from evento where eventoFinalizado=true and idActividad = ?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsFinalizado.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }else {
                String sql = "select idEvento from evento where idActividad = ?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsFinalizado.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

            if(parametrosEstado.contains("Apoyando")){
                String sql = "select e.idEvento from evento e inner join alumnoporevento ape on e.idEvento = ape.idEvento inner join usuario u on u.idUsuario = ape.idAlumno where ape.estadoApoyo != 'Pendiente' and e.idActividad = ? and u.idUsuario = ?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    pstmt.setInt(2,idUsuario);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsApoyando.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }else{
                String sql = "select idEvento from evento where idActividad = ?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsApoyando.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        idsEvento.retainAll(idsOculto);
        idsEvento.retainAll(idsApoyando);
        idsEvento.retainAll(idsFinalizado);

        //el nombre fue idea de Josh Fernando Yauri Salas - 20213852
        for(Integer minaya : parametrosLugar){
            String sql = "select idEvento from evento where idActividad = ? and idLugarEvento = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                pstmt.setInt(2,minaya);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        System.out.println(rs.getInt(1));
                        idsLugar.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if(!parametrosLugar.isEmpty()){
            idsEvento.retainAll(idsLugar);
        }

            if(parametrosFecha.contains("Hoy")){
                String sql = "select idEvento from evento where datediff(date(now()),fecha)=0 and idActividad=?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsHoy.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }else {
                String sql = "select idEvento from evento where idActividad=?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsHoy.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(parametrosFecha.contains("Manana")){
                String sql = "select idEvento from evento where datediff(fecha,date(now()))=1 and idActividad=?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsManana.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }else{
                String sql = "select idEvento from evento where idActividad=?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsManana.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(parametrosFecha.contains("MasDias")){
                String sql = "select idEvento from evento where datediff(fecha,date(now()))>1 and idActividad=?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsMasDias.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }else{
                String sql = "select idEvento from evento where idActividad=?";
                try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setInt(1,idActividad);
                    try(ResultSet rs = pstmt.executeQuery()){
                        while(rs.next()){
                            idsMasDias.add(rs.getInt(1));
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        idsEvento.retainAll(idsHoy);
        idsEvento.retainAll(idsManana);
        idsEvento.retainAll(idsMasDias);

        if(horaInicio != "") {
            String sql = "select idEvento from evento where idActividad = ? and hora between ? and ?";
            try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
            idsEvento.retainAll(idsHora);
        }
        ArrayList<Evento> lista = new ArrayList<>();
        for(Integer stuardotqm : idsEvento){
            String sql = "select idEvento,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMiniatura,eventoFinalizado,eventoOculto,resumen,resultadoEvento from evento where idEvento=?";
            try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1,stuardotqm);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if(rs.next()) {
                        Evento e = new Evento();
                        e.setIdEvento(rs.getInt(1));
                        e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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

    public ArrayList<Evento> filtrarEventos(ArrayList<String> parametrosEstado, ArrayList<Integer> parametrosLugar, ArrayList<String> parametrosFecha, String horaInicio, String horaFin, int idActividad, int idUsuario, int pagina){
        //Se saca todos los ids de los eventos de la actividad
        HashSet<Integer> idsEvento = new HashSet<>();
        String sqlEvento = "select idEvento from evento where idActividad = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sqlEvento)){
            pstmt.setInt(1,idActividad);
            try(ResultSet rs = pstmt.executeQuery()){
                while(rs.next()){
                    idsEvento.add(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Se crean los HashSet que contendrán los ids de cada tipo de filtro de categoría
        HashSet<Integer> idsOculto = new HashSet<Integer>();
        HashSet<Integer> idsFinalizado = new HashSet<Integer>();
        HashSet<Integer> idsApoyando = new HashSet<Integer>();
        HashSet<Integer> idsLugar = new HashSet<Integer>();
        HashSet<Integer> idsHoy = new HashSet<Integer>();
        HashSet<Integer> idsManana = new HashSet<Integer>();
        HashSet<Integer> idsMasDias = new HashSet<Integer>();
        HashSet<Integer> idsHora = new HashSet<Integer>();

        //Se sacan los ids de la categoría Oculto
        if(parametrosEstado.contains("Oculto")){
            String sql = "select idEvento from evento where eventoOculto=true and idActividad = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsOculto.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else {
            String sql = "select idEvento from evento where idActividad = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsOculto.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //Se sacan los ids de la categoría Finalizado
        if(parametrosEstado.contains("Finalizado")){
            String sql = "select idEvento from evento where eventoFinalizado=true and idActividad = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsFinalizado.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else {
            String sql = "select idEvento from evento where idActividad = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsFinalizado.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //Se sacan los ids de la categoría Apoyando
        if(parametrosEstado.contains("Apoyando")){
            String sql = "select e.idEvento from evento e inner join alumnoporevento ape on e.idEvento = ape.idEvento inner join usuario u on u.idUsuario = ape.idAlumno where ape.estadoApoyo != 'Pendiente' and e.idActividad = ? and u.idUsuario = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                pstmt.setInt(2,idUsuario);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsApoyando.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else{
            String sql = "select idEvento from evento where idActividad = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsApoyando.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //Se intersecan los HashSet, de tal manera que se obtiene un solo Hashset con los ids que los tres tienen en común
        //De esta manera se obtienen los ids de la categoría Estado (Oculto, Apoyando y Finalizado)
        idsEvento.retainAll(idsOculto);
        idsEvento.retainAll(idsApoyando);
        idsEvento.retainAll(idsFinalizado);

        //Se sacan los ids de la categoría Lugar
        for(Integer minaya : parametrosLugar){
            String sql = "select idEvento from evento where idActividad = ? and idLugarEvento = ?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                pstmt.setInt(2,minaya);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        System.out.println(rs.getInt(1));
                        idsLugar.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //En caso no se haya marcado ninguna opción en la categoría Lugar, no se intersecan los ids con los de Estado
        if(!parametrosLugar.isEmpty()){
            idsEvento.retainAll(idsLugar);
        }

        //Se sacan los ids de la categoría Fecha: Hoy
        if(parametrosFecha.contains("Hoy")){
            String sql = "select idEvento from evento where datediff(date(now()),fecha)=0 and idActividad=?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsHoy.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else {
            String sql = "select idEvento from evento where idActividad=?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsHoy.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //Se sacan los ids de la categoría Fecha: Mañana
        if(parametrosFecha.contains("Manana")){
            String sql = "select idEvento from evento where datediff(fecha,date(now()))=1 and idActividad=?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsManana.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else{
            String sql = "select idEvento from evento where idActividad=?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsManana.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //Se sacan los ids de la categoría Fecha: 2 o más días
        if(parametrosFecha.contains("MasDias")){
            String sql = "select idEvento from evento where datediff(fecha,date(now()))>1 and idActividad=?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsMasDias.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }else{
            String sql = "select idEvento from evento where idActividad=?";
            try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){
                pstmt.setInt(1,idActividad);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        idsMasDias.add(rs.getInt(1));
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        //Se intersecan los HashSet, de tal manera que se obtiene un solo Hashset con los ids que todas las categorías tienen en común
        idsEvento.retainAll(idsHoy);
        idsEvento.retainAll(idsManana);
        idsEvento.retainAll(idsMasDias);

        //Se sacan los ids de la categoría Hora inicio y Hora fin solo en caso se haya ingresado un valor en el campo
        if(horaInicio != "") {
            String sql = "select idEvento from evento where idActividad = ? and hora between ? and ?";
            try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
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
            //Se intersecan los ids con los de las anteriores categorías
            idsEvento.retainAll(idsHora);
        }

        //Se obtiene la lista total de Eventos filtrados
        ArrayList<Evento> lista = new ArrayList<>();
        for(Integer stuardotqm : idsEvento){
            String sql = "select idEvento,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMiniatura,eventoFinalizado,eventoOculto,resumen,resultadoEvento from evento where idEvento=? limit 8 offset ?";
            try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1,stuardotqm);
                pstmt.setInt(2,pagina*8);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if(rs.next()) {
                        Evento e = new Evento();
                        e.setIdEvento(rs.getInt(1));
                        e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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

    public ArrayList<Evento> juntarListas(ArrayList<Evento> lista1, ArrayList<Evento> lista2){
        ArrayList<Evento> lista = new ArrayList<>();

        //Se crean los HashSet que contendrán los ids de los Eventos de cada lista
        HashSet<Integer> ids1 = new HashSet<Integer>();
        HashSet<Integer> ids2 = new HashSet<Integer>();

        //Se obtienen los ids de los Eventos de la primera lista
        for(Evento e1: lista1){
            ids1.add(e1.getIdEvento());
        }

        //Se obtienen los ids de los Eventos de la segunda lista
        for(Evento e2: lista2){
            ids2.add(e2.getIdEvento());
        }

        //Se intersecan los HashSet de tal manera que se obtienen los ids en común de ambas listas
        ids1.retainAll(ids2);

        //Se crea la nueva lista con los ids en común
        for(int id : ids1){
            lista.add(obtenerEventoPorId(id));
        }
        return lista;
    }

    public Evento obtenerEventoPorId(int idEvento){
        Evento evento = new Evento();
        String sql = "select idEvento,idLugarEvento,titulo,fecha,hora,descripcionEventoActivo,fraseMotivacional,fotoMiniatura,eventoFinalizado,eventoOculto,resumen,resultadoEvento from evento where idEvento=?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    evento.setIdEvento(rs.getInt(1));
                    evento.getLugarEvento().setIdLugarEvento(rs.getInt(2));
                    evento.setTitulo(rs.getString(3));
                    evento.setFecha(rs.getDate(4));
                    evento.setHora(rs.getTime(5));
                    evento.setDescripcionEventoActivo(rs.getString(6));
                    evento.setFraseMotivacional(rs.getString(7));
                    evento.setFotoMiniatura(rs.getBlob(8));
                    evento.setEventoFinalizado(rs.getBoolean(9));
                    evento.setEventoOculto(rs.getBoolean(10));
                    evento.setResumen(rs.getString(11));
                    evento.setResultadoEvento(rs.getString(12));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return evento;
    }

    public ArrayList<Evento> ordenarListaEventos(ArrayList<Evento> listaEventos, String orden, String sentido, int pagina, int idActividad){
        ArrayList<Evento> lista = new ArrayList<>();

        //Se crea una lista ordenada con todos los Eventos
        ArrayList<Evento> listaOrdenada = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? order by";
        if(orden.equals("0")){
            sql+=" CONCAT(fecha,' ',hora)";
        }else{
            sql+=" titulo";
        }
        if(sentido.equals("1")){
            sql+=" desc";
        }
        //sql += " limit 8 offset ?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1,idActividad);
            //pstmt.setInt(2,pagina*8);
            try (ResultSet rs = pstmt.executeQuery()) {
                while(rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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
                    listaOrdenada.add(e);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Doble barrido para ordenar la lista
        for(Evento evento: listaOrdenada){
            for(Evento evento1: listaEventos){
                if(evento1.getIdEvento()==evento.getIdEvento()){
                    lista.add(evento1);
                }
            }
        }

        ArrayList<Evento> listaFinal = new ArrayList<>();
        int limSup = (pagina*8) + 8;
        if((pagina*8)+8>lista.size()){
            limSup=lista.size();
        }
        for(int i=pagina*8;i<limSup;i++){
            listaFinal.add(lista.get(i));
        }
        return listaFinal;
    }

    public ArrayList<Evento> ordenarEvento(String orden, String sentido,int idActividad){
        ArrayList<Evento> lista = new ArrayList<>();
        String sql = "select e.idEvento,e.idLugarEvento,e.titulo,e.fecha,e.hora,e.descripcionEventoActivo,e.fraseMotivacional,e.fotoMiniatura,e.eventoFinalizado,e.eventoOculto,e.resumen,e.resultadoEvento from Evento e inner join Actividad a on e.idActividad=a.idActividad where a.idActividad=? order by";
        if(orden.equals("0")){
            sql+=" CONCAT(fecha,' ',hora)";
        }else{
            sql+=" titulo";
        }
        if(sentido.equals("1")){
            sql+=" desc";
        }
        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1,idActividad);
            try (ResultSet rs = pstmt.executeQuery()) {
                while(rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.getLugarEvento().setIdLugarEvento(rs.getInt(2));
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
        return lista;
    }
    public String  nombreEventoPorID(int idEvento){
        String sql="select titulo from evento where idEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Blob getFotoEventoPorID(int idEvento){
        String sql="select fotoMiniatura from evento where idEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getBlob(1);
                }else
                    return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean existeEvento(String idEvento){
        String sql="select idEvento from evento where idEvento=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idEvento);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer[] obtenerDiferenciaEntre2FechasMensaje(int idMensajeChat){
        Integer[] diferencia=new Integer[4];
        String sql ="select timestampdiff(day,fechaHora,now()),timestampdiff(hour,fechaHora,now()),timestampdiff(minute,fechaHora,now()),timestampdiff(second,fechaHora,now()) from mensajechat where idMensajeChat=?";
        try (Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)) {
            pstmt.setInt(1,idMensajeChat);
            try(ResultSet rs=pstmt.executeQuery()){
                if (rs.next()) {
                    diferencia[0]=rs.getInt(3)%30;
                    diferencia[1]=rs.getInt(4)%24;
                    diferencia[2]=rs.getInt(5)%60;
                    diferencia[3]= rs.getInt(6)%60;
                    return diferencia;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
