package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Donacion;

import java.awt.image.BufferedImage;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class DaoDonacion extends DaoPadre  {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Donacion>listarDonacionesVistaUsuario(int idUsuario){
        ArrayList<Donacion>listaDonaciones=new ArrayList<>();
        String sql="select idDonacion,idUsuario,medioPago,monto,date(fechaHora) from Donacion where idUsuario=? and estadoDonacion='Validado' order by fechaHora desc";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                while(rs.next()){
                    Donacion d=new Donacion();
                    d.setIdDonacion(rs.getInt(1));
                    d.setIdUsuario(rs.getInt(2));
                    d.setMedioPago(rs.getString(3));
                    d.setMonto(rs.getFloat(4));
                    d.setFecha(Date.valueOf(rs.getString(5)));
                    listaDonaciones.add(d);
                }return listaDonaciones;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public float totalDonaciones(int idUsuario){
        String sql="select sum(monto) from Donacion where idUsuario=? and estadoDonacion='Validado' group by idUsuario";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
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
    public void editarDonacion(int idDonacion,String estadoDonacion,Integer donacionCorrecta){ //Editar donacion por Id
        String sql = "update donacion set monto = ?,estadoDonacion = ?, fechaHoraValido = now() where idDonacion = ?";

        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,donacionCorrecta);
            pstmt.setString(2, estadoDonacion);
            pstmt.setInt(3,idDonacion);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    //Este método permite agregar el monto y foto que ha donado una persona
    public void agregarDonacionUsuario(int idDonacion,int idUser,String medioPago, int monto, Blob captura){
        String sql = " insert into donacion(idDonacion, idUsuario, medioPago, monto,fechaHora,captura,estadoDonacion) values (?,?, ?, ?,now(), ?,?)";
        try(PreparedStatement pstmt=conn.prepareStatement(sql)){
            pstmt.setInt(1,idDonacion);
            pstmt.setInt(2, idUser);
            pstmt.setString(3,medioPago);
            pstmt.setInt(4,monto);
            pstmt.setBlob(6,captura);
            pstmt.setString(7,"En espera");//Toda donación siempre se agrega como en espera

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}