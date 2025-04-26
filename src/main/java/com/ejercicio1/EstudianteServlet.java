// Autor: Victor Guevara
// Fecha: Abril 2025
package com.ejercicio1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;


@WebServlet("/procesarEstudiante")
public class EstudianteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carnet = request.getParameter("carnet");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String fechaNacimiento = request.getParameter("fechaNacimiento");

        StringBuilder errores = new StringBuilder();

        try {
            // Validaciones de los datos ingresados
            if (carnet == null || !carnet.matches("^[A-Za-z]{2}\\d{4}$")) {
                errores.append("Carnet inválido. Formato: dos letras y cuatro números.<br>");
            }
            if (nombres == null || !nombres.matches("^[A-Za-zÁÉÍÓÚáéíóúÑñ\\s]{1,25}$")) {
                errores.append("Nombres inválidos. Solo letras y espacios, máximo 25 caracteres.<br>");
            }
            if (apellidos == null || !apellidos.matches("^[A-Za-zÁÉÍÓÚáéíóúÑñ\\s]{1,25}$")) {
                errores.append("Apellidos inválidos. Solo letras y espacios, máximo 25 caracteres.<br>");
            }
            if (direccion == null || direccion.length() > 255) {
                errores.append("Dirección inválida. Máximo 255 caracteres.<br>");
            }
            if (telefono == null || !telefono.matches("^\\d{4}-\\d{4}$")) {
                errores.append("Teléfono inválido. Formato 0000-0000.<br>");
            }
            if (email == null || !email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
                errores.append("Email inválido.<br>");
            }

            if (fechaNacimiento == null || !fechaNacimiento.matches("^\\d{2}/\\d{2}/\\d{4}$")) {
                errores.append("Fecha inválida. Formato DD/MM/YYYY.<br>");
            } else {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    sdf.setLenient(false); // esto impide que acepte fechas como 32/13/2025
                    Date fecha = sdf.parse(fechaNacimiento); // si es inválida, lanza ParseException
                } catch (ParseException e) {
                    errores.append("Fecha inválida. No corresponde a una fecha real.<br>");
                }
            }

            // Revisar si hay errores
            if (errores.length() > 0) {
                request.setAttribute("errores", errores.toString());
                request.getRequestDispatcher("resultado.jsp").forward(request, response);
                return;
            }

            // Crear objeto estudiante
            Estudiante e = new Estudiante();
            e.setCarnet(carnet);
            e.setNombres(nombres);
            e.setApellidos(apellidos);
            e.setDireccion(direccion);
            e.setTelefono(telefono);
            e.setEmail(email);
            e.setFechaNacimiento(fechaNacimiento);

            // Pasar objeto estudiante a la vista
            request.setAttribute("estudiante", e);
            request.getRequestDispatcher("resultado.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace(); // Para depuración en consola
            request.setAttribute("errores", "Error inesperado al procesar los datos: " + ex.getMessage());
            request.getRequestDispatcher("resultado.jsp").forward(request, response);
        }
    }
}