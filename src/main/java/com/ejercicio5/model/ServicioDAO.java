package com.ejercicio5.model;

import com.ejercicio5.classes.Automotor;
import com.ejercicio5.classes.Cliente;
import com.ejercicio5.classes.Servicio;
import com.ejercicio5.util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicioDAO {
    public static int guardarServicio(Servicio servicio) {
        try(Connection conn = Conexion.getConnection()){
            String sql = "INSERT INTO servicios (cliente_id, tipo, precio) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, servicio.getClienteId());
                ps.setString(2, servicio.getTipo());
                ps.setDouble(3, servicio.getPrecio());
                return ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                return 0; // Error al guardar
            }
        }catch (SQLException e) {
            e.printStackTrace();
            return 0; // Error al guardar
        }
    }

    public static List<Cliente> obtenerServiciosConClienteYAutomovil() {
        List<Cliente> clientesServicios = new ArrayList<>();
        String sql = "SELECT " +
                "    s.id AS servicio_id, " +
                "    s.tipo AS servicio_tipo, " +
                "    s.precio AS servicio_precio, " +
                "    c.id AS cliente_id, " +
                "    c.nombres AS cliente_nombres, " +
                "    c.apellidos AS cliente_apellidos, " +
                "    c.vip AS cliente_vip, " +
                "    a.id AS automovil_id, " +
                "    a.marca AS automovil_marca, " +
                "    a.modelo AS automovil_modelo, " +
                "    a.year AS automovil_year " +
                "FROM servicios s " +
                "JOIN clientes c ON s.cliente_id = c.id " +
                "JOIN automotores a ON c.id = a.cliente_id";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Servicio information
                int servicioId = rs.getInt("servicio_id");
                String tipo = rs.getString("servicio_tipo");
                double precio = rs.getDouble("servicio_precio");

                // Cliente information
                int clienteId = rs.getInt("cliente_id");
                String clienteNombres = rs.getString("cliente_nombres");
                String clienteApellidos = rs.getString("cliente_apellidos");
                boolean clienteVip = rs.getBoolean("cliente_vip");

                // Automotor information
                int automovilId = rs.getInt("automovil_id");
                String automovilMarca = rs.getString("automovil_marca");
                String automovilModelo = rs.getString("automovil_modelo");
                int automovilYear = rs.getInt("automovil_year");

                // Create Cliente object
                Cliente cliente = new Cliente(clienteId, clienteNombres, clienteApellidos, clienteVip);

                // Create Automotor object
                Automotor automotor = new Automotor(automovilId, clienteId, automovilMarca, automovilModelo, automovilYear);

                // Create Servicio object and associate cliente and automotor
                Servicio servicio = new Servicio(servicioId, cliente.getId(), tipo, precio);
                cliente.setAutomotor(automotor);
                cliente.setServicio(servicio);

                // Add to the result list
                clientesServicios.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
        return clientesServicios;
    }


}

