/*
Autor: Gerardo Saz
Fecha: 27/4/2025
 */
package com.ejercicio5.model;

import com.ejercicio5.classes.Automotor;
import com.ejercicio5.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AutomovilDAO {

    // Método para guardar el automóvil en la base de datos y devolver el objeto Automotor con el ID asignado
    public static Automotor guardarAutomovil(Automotor automovil) {
        // Lógica para insertar el automóvil en la base de datos
        try (Connection connection = Conexion.getConnection()) {
            String sql = "INSERT INTO automotores (cliente_id, marca, modelo, year) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, automovil.getClienteId());
                stmt.setString(2, automovil.getMarca());
                stmt.setString(3, automovil.getModelo());
                stmt.setInt(4, automovil.getYear());

                // Ejecutar la actualización
                int rowsAffected = stmt.executeUpdate();

                // Verificar si se insertó el automóvil
                if (rowsAffected > 0) {
                    // Obtener el ID generado automáticamente
                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int generatedId = generatedKeys.getInt(1);
                        automovil.setId(generatedId);  // Asignar el ID generado al objeto Automotor
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;  // En caso de error, retornamos null
        }

        return automovil;  // Devolvemos el objeto Automotor con su ID
    }

    // Método para obtener un automóvil por su ID
    public static Automotor obtenerAutomovilPorId(int automovilId) {
        Automotor automovil = null;

        try (Connection connection = Conexion.getConnection()) {
            // Crear la consulta SQL para obtener el automóvil por ID
            String sql = "SELECT * FROM automotores WHERE id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, automovilId);
                ResultSet rs = stmt.executeQuery();

                // Verificar si el automóvil fue encontrado
                if (rs.next()) {
                    String marca = rs.getString("marca");
                    String modelo = rs.getString("modelo");
                    int year = rs.getInt("year");

                    // Crear un nuevo objeto Automotor con los datos obtenidos
                    automovil = new Automotor(automovilId, marca, modelo, year);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return automovil;
    }

    // Método para obtener todos los automóviles
    public static List<Automotor> obtenerAutomovilPorCliente(int id_cliente) {
        List<Automotor> automoviles = new ArrayList<>();
        String sql = "SELECT * FROM automotores WHERE cliente_id = ?";

        try (Connection connection = Conexion.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id_cliente);  // Esta línea debe ir aquí, no en el try

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int clienteId = rs.getInt("cliente_id");
                    String marca = rs.getString("marca");
                    String modelo = rs.getString("modelo");
                    int year = rs.getInt("year");

                    Automotor automovil = new Automotor(id, clienteId, marca, modelo, year);
                    automoviles.add(automovil);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return automoviles;
    }
}
