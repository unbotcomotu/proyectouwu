package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.DTOs.TopDonador;

import java.awt.image.BufferedImage;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class DaoDonacion extends DaoPadre  {
    public ArrayList<Donacion>listarDonacionesVistaUsuario(int idUsuario){
        ArrayList<Donacion>listaDonaciones=new ArrayList<>();
        String sql="select idDonacion,idUsuario,medioPago,monto,date(fechaHora),estadoDonacion from Donacion where idUsuario=? order by fechaHora desc";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Donacion d=new Donacion();
                    d.setIdDonacion(rs.getInt(1));
                    d.getUsuario().setIdUsuario(rs.getInt(2));
                    d.setMedioPago(rs.getString(3));
                    d.setMonto(rs.getFloat(4));
                    d.setFecha(Date.valueOf(rs.getString(5)));
                    d.setEstadoDonacion(rs.getString(6));
                    listaDonaciones.add(d);
                }return listaDonaciones;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public float totalDonaciones(int idUsuario){
        String sql="select sum(monto) from Donacion where idUsuario=? and estadoDonacion='Validado' group by idUsuario";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getFloat(1);
                }else
                    return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    //Este método se utiliza para el boton de editar donación en la vista de delegado general
    public void editarDonacion(Donacion donacion){ //Editar donacion por Id


        String sql = "update donacion set monto = ?,estadoDonacion = ?, fechaHoraValidado = now() where idDonacion = ?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setFloat(1,donacion.getMonto());
            pstmt.setString(2, donacion.getEstadoDonacion());
            pstmt.setInt(3,donacion.getIdDonacion());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    //Este método permite agregar el monto y foto que ha donado una persona
    public void agregarDonacionUsuario(int idUser,String medioPago, float monto, String captura){
        String sql = " insert into donacion(idUsuario, medioPago, monto,fechaHora,captura,estadoDonacion) values (?, ?, ?,now(), ?,?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            pstmt.setInt(1, idUser);
            pstmt.setString(2,medioPago);
            pstmt.setFloat(3,monto);
            pstmt.setString(4,captura);
            pstmt.setString(5,"Pendiente");
            pstmt.executeUpdate();
            ResultSet rsKeys=pstmt.getGeneratedKeys();
            if(rsKeys.next()){
                new DaoNotificacionDelegadoGeneral().crearNotificacionDonacion(rsKeys.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /*public Integer sumarMontoDonadoPorEgresado(){
        int montoEgresado = 0;
        int montoCopia = 0;
        //String sql = "select sum(monto) from donacion where idUser = ?";
        
        DaoUsuario daoUsuario = new DaoUsuario();
        ArrayList<Integer> egresadosIds = daoUsuario.listaIdEgresados();
        
        for (Integer id:egresadosIds){
            try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
                pstmt.setInt(1,id);
                try(ResultSet rs = pstmt.executeQuery()){
                    while(rs.next()){
                        montoCopia = rs.getInt(1);
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } 
            montoEgresado += montoCopia;
        }
        return montoEgresado;
    }
    */

    public Donacion buscarPorId(String id){

        Donacion donacion = null;
        String sql = "select * from donacion where idDonacion = ?";


        try (Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,id);

            try(ResultSet rs = pstmt.executeQuery()){
                while (rs.next()) {
                    donacion = new Donacion();
                    donacion.setIdDonacion(rs.getInt(1));
                    donacion.getUsuario().setIdUsuario(rs.getInt(2));
                    donacion.setMedioPago(rs.getString(3));
                    donacion.setMonto(rs.getFloat(4));
                    donacion.setEstadoDonacion(rs.getString(7));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return donacion;
    }
    public float[] donacionesEgresadosUltimaSemana(){
        String sql="select sum(d.monto) from donacion d inner join usuario u where u.condicion='Egresado' and datediff(now(),d.fechaHora)=?";
        float[] listaDonaciones=new float[7];
        for (int i=0;i<7;i++){
            int aux=7-i;
            try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
                pstmt.setInt(1,aux);
                try(ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()){
                        listaDonaciones[i]=rs.getFloat(1);
                    }else{
                        listaDonaciones[i]=0;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } return listaDonaciones;
    }
    public float[] donacionesEstudiantesUltimaSemana(){
        String sql="select sum(d.monto) from donacion d inner join usuario u where u.condicion='Estudiante' and datediff(now(),d.fechaHora)=?";
        float[] listaDonaciones=new float[7];
        for (int i=0;i<7;i++){
            int aux=7-i;
            try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
                pstmt.setInt(1,aux);
                try(ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()){
                        listaDonaciones[i]=rs.getFloat(1);
                    }else{
                        listaDonaciones[i]=0;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } return listaDonaciones;
    }

    public float donacionesHaceNdias(int n){
        String sql="select sum(monto) from donacion where datediff(now(),fechaHora)=? and estadoDonacion='Validado'";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)) {
            pstmt.setInt(1,n);
            try(ResultSet rs=pstmt.executeQuery()) {
                if(rs.next()){
                    return rs.getFloat(1);
                }else{
                    return 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void borrar(String idDonacion) throws SQLException {

        String sql = "update donacion set estadoDonacion = 'Rechazado', fechaHoraValidado = now() where idDonacion = ?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1,idDonacion);
            pstmt.executeUpdate();

        }
    }




    public float donacionesTotalesEgresados(){
        String sql="select sum(d.monto) from donacion d inner join usuario u on d.idUsuario=u.idUsuario where u.condicion='Egresado' and d.estadoDonacion='Validado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            if(rs.next()){
                return rs.getFloat(1);
            }else{
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public float donacionesTotalesEstudiantes(){
        String sql="select sum(d.monto) from donacion d inner join usuario u on d.idUsuario=u.idUsuario where u.condicion='Estudiante' and d.estadoDonacion='Validado'";
        try(Connection conn=this.getConnection(); ResultSet rs=conn.createStatement().executeQuery(sql)){
            if(rs.next()){
                return rs.getFloat(1);
            }else{
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Donacion donacionPorIDNotificacion(int idDonacion){
        String sql="select u.idUsuario,u.nombre,u.apellido,u.fotoPerfil,d.monto from donacion d inner join usuario u on d.idUsuario=u.idUsuario where d.idDonacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)) {
            pstmt.setInt(1,idDonacion);
            try(ResultSet rs=pstmt.executeQuery()) {
                if(rs.next()){
                    Donacion d=new Donacion();
                    d.getUsuario().setIdUsuario(rs.getInt(1));
                    d.getUsuario().setNombre(rs.getString(2));
                    d.getUsuario().setApellido(rs.getString(3));
                    d.getUsuario().setFotoPerfil(rs.getBlob(4));
                    d.setMonto(rs.getFloat(5));
                    return d;
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public TopDonador hallarTopDonador(){
        TopDonador topDonador = new TopDonador();
        String sql = "select u.nombre, u.apellido, u.fotoPerfil, subQuery.montoTotal from usuario u inner join (select idUsuario, round(sum(monto),2) as `montoTotal`, max(fechaHora) as `fecha` from donacion where estadoDonacion='Validado' group by idUsuario having max(fechaHora) order by montoTotal desc,fecha desc limit 1) subQuery on (u.idUsuario = subQuery.idUsuario)";
        try(Connection conn = getConnection();
            ResultSet rs = conn.prepareStatement(sql).executeQuery()){
            if(rs.next()){
                Usuario usuario = new Usuario();
                usuario.setNombre(rs.getString(1));
                usuario.setApellido(rs.getString(2));
                usuario.setFotoPerfil(rs.getBlob(3));
                topDonador.setUsuario(usuario);
                topDonador.setMontoTotal(rs.getFloat(4));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return topDonador;
    }

    public TopDonador hallarTopDonadorUltimaSemana(){
        TopDonador topDonador = new TopDonador();
        String sql = "select u.nombre, u.apellido, u.fotoPerfil, subQuery.montoTotal from usuario u inner join (select idUsuario, round(sum(monto),2) as `montoTotal`, max(fechaHora) as `fecha` from donacion where estadoDonacion='Validado' and datediff(now(),fechaHora)<=7 group by idUsuario having max(fechaHora) order by montoTotal desc,fecha desc limit 1) subQuery on (u.idUsuario = subQuery.idUsuario)";
        try(Connection conn = getConnection();
            ResultSet rs = conn.prepareStatement(sql).executeQuery()){
            if(rs.next()){
                Usuario usuario = new Usuario();
                usuario.setNombre(rs.getString(1));
                usuario.setApellido(rs.getString(2));
                usuario.setFotoPerfil(rs.getBlob(3));
                topDonador.setUsuario(usuario);
                topDonador.setMontoTotal(rs.getFloat(4));
                return topDonador;
            }else{
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}