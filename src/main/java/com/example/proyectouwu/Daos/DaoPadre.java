package com.example.proyectouwu.Daos;

import com.mysql.cj.jdbc.Driver;

import javax.swing.*;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DaoPadre {
    public Connection getConnection() throws SQLException{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://localhost:3306/proyecto";
        String  user = "root";
        String password = "root";
        return DriverManager.getConnection(url,user,password);
    }
}
