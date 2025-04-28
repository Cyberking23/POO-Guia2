package com.ejercicio5.util;
import java.sql.*;

public class Conexion {

    // Método para obtener la conexión a la base de datos
    public static Connection getConnection() {
        // URL de la base de datos, usa tus propios datos aquí
        String url = "jdbc:mysql://localhost:3306/poo_ejercicio5";
        String user = "root";  // Usuario de la base de datos
        String password = "root";  // Contraseña de la base de datos

        // Intentar establecer la conexión
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException | ClassNotFoundException e) {
            // Imprimir el error si ocurre una excepción
            System.out.println("Error de conexión a la base de datos: " + e.getMessage());
            e.printStackTrace();
            return null;  // Retorna null si la conexión falla
        }
    }
}
