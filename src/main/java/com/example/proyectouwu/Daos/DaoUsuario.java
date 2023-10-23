package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.StreamHandler;

public class DaoUsuario {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto","root","root");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public String rolUsuarioPorId(int idUsuario){
        String sql="select rol from usuario where idUsuario=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String nombreCompletoUsuarioPorId(int idUsuario){
        String sql="select concat(nombre,' ',apellido) as 'nombreCompleto' from usuario where idUsuario=?";
        try(PreparedStatement pstmt= conn.prepareStatement(sql)){
            pstmt.setInt(1,idUsuario);
            try(ResultSet rs=pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getString(1);
                }else
                    return "";
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<String>listarCorreosDelegadosGenerales(){
        ArrayList<String>listaCorreosDelegadosGenerales=new ArrayList<>();
        String sql="select correo from usuario where rol='Delegado General'";
        try(ResultSet rs=conn.createStatement().executeQuery(sql)){
            while(rs.next()){
                listaCorreosDelegadosGenerales.add(rs.getString(1));
            }return listaCorreosDelegadosGenerales;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Usuario>listarIDyNombreDelegadosDeActividad(){
        ArrayList<Usuario>listaDelegadosDeActividad=new ArrayList<>();
        String sql="select idUsuario,nombre,apellido from usuario where rol='Delegado de Actividad'";
        try(ResultSet rs=conn.createStatement().executeQuery(sql)){
            while(rs.next()){
                Usuario u=new Usuario();
                u.setIdUsuario(rs.getInt(1));
                u.setNombre(rs.getString(2));
                u.setApellido(rs.getString(3));
                listaDelegadosDeActividad.add(u);
            }return listaDelegadosDeActividad;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
