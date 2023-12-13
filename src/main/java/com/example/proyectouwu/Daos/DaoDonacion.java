package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;
import com.example.proyectouwu.Beans.Usuario;
import com.example.proyectouwu.DTOs.TopDonador;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.io.IOException;

public class DaoDonacion extends DaoPadre  {
    public ArrayList<Donacion>listarDonacionesVistaUsuario(int idUsuario){
        ArrayList<Donacion>listaDonaciones=new ArrayList<>();
        String sql="select idDonacion,idUsuario,medioPago,monto,date(fechaHora),estadoDonacion from donacion where idUsuario=? order by fechaHora desc";
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
        String sql="select sum(monto) from donacion where idUsuario=? and estadoDonacion='Validado' group by idUsuario";
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
    public void editarDonacion(Donacion donacion){
        String sql = "update donacion set monto = ?,estadoDonacion = ?, fechaHoraValidado = now() where idDonacion = ?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setFloat(1,donacion.getMonto());
            pstmt.setString(2, donacion.getEstadoDonacion());
            pstmt.setInt(3,donacion.getIdDonacion());
            pstmt.executeUpdate();
            int idUsuario=idUsuarioPorIdDonacion(donacion.getIdDonacion());
            DaoValidacion dV=new DaoValidacion();
            DaoUsuario dU=new DaoUsuario();
            if(totalDonaciones(idUsuario)>100&&!dV.verificarYaRecibioNotificacionKit(idUsuario)&&dU.esEgresado(idUsuario)){
                dV.agregarCorreoParaElKit(idUsuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Este método se utiliza para que un usuario edite la foto o monto de donación
    public void editarDonacionUsuario(int idDonacion, float montoEditar, InputStream capturaEditar, boolean validarLongitudDonacion) throws SQLException, IOException { //Editar donacion por Id
        //Falta verificar que el estado de Donación no este en Confirmado por motivos de seguridad (otra query)


        String sqlVer = " select estadoDonacion from donacion where idDonacion = ?";
        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sqlVer)) {
            pstmt.setInt(1, idDonacion);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    if (rs.getString(1).equals("Pendiente")) {
                        String captura = "";
                        if (validarLongitudDonacion) {
                            captura = ",captura=?";
                        }

                        String sql = "update donacion set monto = ?" + captura + " where idDonacion = ?";

                        try (Connection conn1 = this.getConnection(); PreparedStatement pstmt1 = conn.prepareStatement(sql)) {
                            pstmt.setFloat(1, montoEditar);
                            if (validarLongitudDonacion) {
                                pstmt1.setBinaryStream(2, capturaEditar, capturaEditar.available());
                                pstmt1.setInt(3, idDonacion);
                            } else {
                                pstmt1.setInt(2, idDonacion);
                            }

                            pstmt1.executeUpdate();
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                    }
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        }

    }
    //Este método permite agregar el monto y foto que ha donado una persona
    public void agregarDonacionUsuario(int idUser,String medioPagado, float monto, InputStream captura){

        String sql = " insert into donacion(idUsuario, medioPago, monto,fechaHora,captura,estadoDonacion) values (?, ?, ?,now(), ?,?)";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            pstmt.setInt(1, idUser);
            pstmt.setString(2,medioPagado);
            pstmt.setFloat(3,monto);
            pstmt.setBinaryStream(4, captura,(int)captura.available());
            pstmt.setString(5,"Pendiente");
            pstmt.executeUpdate();
            ResultSet rsKeys=pstmt.getGeneratedKeys();
            if(rsKeys.next()){
                new DaoNotificacion().crearNotificacionDonacion(rsKeys.getInt(1));
            }
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }
    public void updateKitRecibe(int idUserEgresado){ //Esto funciona cuando recibioKit es boolean
        String sql = "update usuario set recibioKit = 1 where idUsuario=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idUserEgresado);
            pstmt.executeUpdate();

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
        String sql="select round(sum(d.monto),2) from donacion d inner join usuario u on u.idUsuario=d.idUsuario where u.condicion='Egresado' and datediff(now(),d.fechaHora)=? and d.estadoDonacion='Validado'";
        float[] listaDonaciones=new float[7];

        for (int i=1;i<8;i++){
            int aux=7-i;
            try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
                pstmt.setInt(1,aux);
                try(ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()){
                        listaDonaciones[i-1]=rs.getFloat(1);
                    }else{
                        listaDonaciones[i-1]=0;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } return listaDonaciones;
    }
    public float[] donacionesEstudiantesUltimaSemana(){
        String sql="select round(sum(d.monto),2) from donacion d inner join usuario u on d.idUsuario = u.idUsuario where u.condicion='Estudiante' and datediff(now(),d.fechaHora)=? and d.estadoDonacion='Validado'";
        float[] listaDonaciones=new float[7];
        for (int i=1;i<8;i++){
            int aux=7-i;
            try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
                pstmt.setInt(1,aux);
                try(ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()){
                        listaDonaciones[i-1]=rs.getFloat(1);
                    }else{
                        listaDonaciones[i-1]=0;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } return listaDonaciones;
    }

    public float donacionesHaceNdias(int n){
        String sql="select round(sum(monto),2) from donacion where datediff(now(),fechaHora)=? and estadoDonacion='Validado'";
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

    public void borrar(String idDonacion){

        String sql = "update donacion set estadoDonacion = 'Rechazado', fechaHoraValidado = now() where idDonacion = ?";

        try(Connection conn=this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1,idDonacion);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
        public float donacionesTotalesEgresados(){
        String sql="select round(sum(d.monto),2) from donacion d inner join usuario u on d.idUsuario=u.idUsuario where u.condicion='Egresado' and d.estadoDonacion='Validado'";
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
        String sql="select round(sum(d.monto),2) from donacion d inner join usuario u on d.idUsuario=u.idUsuario where u.condicion='Estudiante' and d.estadoDonacion='Validado'";
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
                return topDonador;
            }else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

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

    public Blob getFotoPerfilPorIDDonacion(int idDonacion){
        String sql = "select u.fotoPerfil from usuario u inner join donacion d on u.idUsuario = d.idUsuario where d.idDonacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idDonacion);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getBlob(1);
                }else{
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean existeDonacion(String idDonacion){
        String sql="select idDonacion from donacion where idDonacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setString(1,idDonacion);
            try(ResultSet rs=pstmt.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer idUsuarioPorIdDonacion(int idDonacion){
        String sql="select idUsuario from donacion where idDonacion=?";
        try(Connection conn=this.getConnection(); PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idDonacion);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}