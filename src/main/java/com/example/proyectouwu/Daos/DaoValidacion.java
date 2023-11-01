package com.example.proyectouwu.Daos;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.example.proyectouwu.Beans.Validacion;
import java.time.format.DateTimeFormatter;
import java.sql.*;
import java.util.Random;
import java.util.Date;

public class DaoValidacion extends DaoPadre {
    private Connection conn;
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto",super.getUser(),super.getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void agregarCorreoParaEnviarLink(String correo){
        String sql = "insert into validacion( correo, tipo, codigoValidacion, fechaHora, linkEnviado) values (?,?,?,?,?);";
        LocalDateTime fechaHoraActual = LocalDateTime.now();
        // Define el formato deseado
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        // Convierte la fecha y hora actual en un String formateado
        String dateStr = fechaHoraActual.format(formatter);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,correo);
            pstmt.setString(2,"enviarLinkACorreo");
            pstmt.setInt(3,new Random().nextInt(99999));
            pstmt.setString(4,dateStr);
            pstmt.setBoolean(5,false);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}