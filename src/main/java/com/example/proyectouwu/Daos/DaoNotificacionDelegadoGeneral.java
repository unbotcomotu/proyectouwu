package com.example.proyectouwu.Daos;

import com.example.proyectouwu.Beans.NotificacionDelegadoGeneral;
import com.example.proyectouwu.Beans.Usuario;
import java.sql.*;
import java.util.ArrayList;

public class DaoNotificacionDelegadoGeneral {

    public ArrayList<Usuario>listarSolicitudesDeRegistro(){

        ArrayList<Usuario> listaSolicitudes = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/proyecto";
        String username = "root";
        String password = "root"; //Cambiar segun tu contraseña

        String sql = "select nombre, apellido, correo, codigoPUCP, condicion  from Usuario where estadoRegistro = 'Pendiente'";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Usuario usuarioPendiente = new Usuario();
                usuarioPendiente.setNombre(rs.getString(1));
                usuarioPendiente.setApellido(rs.getString(2));
                usuarioPendiente.setCorreo(rs.getString(3));
                usuarioPendiente.setCodigoPUCP(rs.getString(4));
                usuarioPendiente.setCondicion(rs.getString(5));
                listaSolicitudes.add(usuarioPendiente);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return listaSolicitudes;
    }

}
