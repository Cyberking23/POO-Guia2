/*
Autor: Gerardo Saz
Fecha: 27/4/2025
 */
package com.ejercicio5.model;

import com.ejercicio5.classes.Automotor;
import com.ejercicio5.classes.Cliente;
import com.ejercicio5.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public static Cliente guardarCliente(Cliente cliente) {
        String sql = "INSERT INTO clientes (nombres, apellidos, vip) VALUES (?, ?, ?)";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, cliente.getNombres());
            stmt.setString(2, cliente.getApellidos());
            stmt.setBoolean(3, cliente.isVip());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int idGenerado = generatedKeys.getInt(1);
                        cliente.setId(idGenerado);
                        return cliente;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Cliente obtenerClientePorId(int id) {
        String sql = "SELECT c.*, a.id AS auto_id, a.marca, a.modelo, a.year " +
                "FROM clientes c " +
                "LEFT JOIN automotores a ON c.id = a.cliente_id " +
                "WHERE c.id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String nombres = rs.getString("nombres");
                String apellidos = rs.getString("apellidos");
                boolean vip = rs.getBoolean("vip");

                Cliente cliente = new Cliente(id, nombres, apellidos, vip);

                // Check if automovil exists
                if (rs.getObject("auto_id") != null) {
                    Automotor auto = new Automotor(
                            rs.getInt("auto_id"),
                            rs.getInt("id"),
                            rs.getString("marca"),
                            rs.getString("modelo"),
                            rs.getInt("year")
                    );
                    cliente.setAutomotor(auto);
                }

                return cliente;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Cliente> obtenerTodos() {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT c.*, a.id AS auto_id, a.marca, a.modelo, a.year " +
                "FROM clientes c " +
                "LEFT JOIN automotores a ON c.id = a.cliente_id " +
                "ORDER BY c.id";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            int currentClienteId = -1;
            Cliente currentCliente = null;

            while (rs.next()) {
                int clienteId = rs.getInt("id");

                // If this is a new cliente, create it
                if (clienteId != currentClienteId) {
                    if (currentCliente != null) {
                        clientes.add(currentCliente);
                    }

                    currentCliente = new Cliente(
                            clienteId,
                            rs.getString("nombres"),
                            rs.getString("apellidos"),
                            rs.getBoolean("vip")
                    );
                    currentClienteId = clienteId;
                }

                // Add automovil if exists
                if (rs.getObject("auto_id") != null) {
                    Automotor auto = new Automotor(
                            rs.getInt("auto_id"),
                            rs.getString("marca"),
                            rs.getString("modelo"),
                            rs.getInt("year")
                    );
                    currentCliente.setAutomotor(auto);
                }
            }

            // Add the last cliente if exists
            if (currentCliente != null) {
                clientes.add(currentCliente);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clientes;
    }
}