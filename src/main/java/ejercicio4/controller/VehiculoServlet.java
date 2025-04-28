/*Autor Joaquin Fuentes
Fecha: Abril 2025*/
package ejercicio4.controller;

import ejercicio4.model.Vehiculo;
import ejercicio4.util.Estadisticas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet para manejar el registro de vehículos y cálculo de estadísticas
 */
// Esta anotación declara que esta clase es un servlet y mapea las peticiones a la URL "/ejercicio4" a este servlet.
@WebServlet(name = "VehiculoServlet", value = {"/ejercicio4"})
public class VehiculoServlet extends HttpServlet {

    // Este método se ejecuta cuando el servlet recibe una petición HTTP POST.
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros del formulario enviados en la petición.
        String nombre = request.getParameter("nombre");
        String sexo = request.getParameter("sexo");
        String marca = request.getParameter("marca");
        String añoStr = request.getParameter("anio");
        String precioStr = request.getParameter("precio");


        // Validar campos vacíos. Si alguno de los parámetros es nulo o está vacío después de eliminar espacios en blanco,
        if (nombre == null || nombre.trim().isEmpty() ||
                sexo == null || sexo.trim().isEmpty() ||
                marca == null || marca.trim().isEmpty() ||
                añoStr == null || añoStr.trim().isEmpty() ||
                precioStr == null || precioStr.trim().isEmpty()) {

            // Se establece un atributo de error en la petición con un mensaje indicando que todos los campos son obligatorios.
            request.setAttribute("error", "Todos los campos son obligatorios");
            // Se reenvía la petición y la respuesta al formulario "VehiculoForm.jsp" para mostrar el error al usuario.
            request.getRequestDispatcher("VehiculoForm.jsp").forward(request, response);
            // Se termina la ejecución del método para evitar procesamiento adicional.
            return;
        }

        // Validar que el nombre solo tenga letras y espacios, con una longitud mínima de 3 y máxima de 100 caracteres.
        if (!nombre.matches("[A-Za-zÁÉÍÓÚáéíóúÑñ ]{3,100}")) {
            // Se establece un atributo de error si el formato del nombre no es válido.
            request.setAttribute("error", "El nombre solo debe contener letras y espacios (mínimo 3 caracteres)");
            // Se reenvía la petición al formulario para mostrar el error.
            request.getRequestDispatcher("VehiculoForm.jsp").forward(request, response);
            return;
        }

        try {
            // Validar y convertir el año de String a int.
            int año = Integer.parseInt(añoStr);
            // Se verifica que el año esté dentro del rango permitido (2000-2025).
            if (año < 2000 || año > 2025) {
                // Se establece un error si el año está fuera de rango.
                request.setAttribute("error", "El año debe estar entre 2000 y 2025");
                // Se reenvía al formulario para mostrar el error.
                request.getRequestDispatcher("VehiculoForm.jsp").forward(request, response);
                return;
            }

            // Validar y convertir el precio de String a double.
            double precio = Double.parseDouble(precioStr);
            // Se verifica que el precio sea mayor que cero.
            if (precio <= 0) {
                // Se establece un error si el precio no es positivo.
                request.setAttribute("error", "El precio debe ser un número positivo mayor a 0");
                // Se reenvía al formulario.
                request.getRequestDispatcher("VehiculoForm.jsp").forward(request, response);
                return;
            }
            // Se verifica que el precio sea al menos $500.
            if (precio < 500) {
                request.setAttribute("error", "El precio debe ser al menos $500");
                request.getRequestDispatcher("VehiculoForm.jsp").forward(request, response);
                return;
            }


            // Crear una nueva instancia de la clase Vehiculo con los datos obtenidos y validados.
            Vehiculo vehiculo = new Vehiculo(nombre, sexo, marca, año, precio);

            // Obtener la sesión HTTP actual del usuario.
            HttpSession session = request.getSession();
            // Intentar obtener la lista de vehículos almacenada en la sesión bajo la clave "vehiculos".
            // El casting es necesario ya que getAttribute devuelve un Object.
            List<Vehiculo> vehiculos = (List<Vehiculo>) session.getAttribute("vehiculos");

            // Si la lista de vehículos no existe en la sesión (es la primera vez o la sesión es nueva), se crea una nueva ArrayList.
            if (vehiculos == null) {
                vehiculos = new ArrayList<>();
                // Se guarda la nueva lista de vehículos en la sesión con la clave "vehiculos".
                session.setAttribute("vehiculos", vehiculos);
            }

            // Agregar el vehículo recién creado a la lista de vehículos.
            vehiculos.add(vehiculo);

            // Mandar los atributos del vehículo a la página de resultados para su visualización.
            request.setAttribute("nombre", nombre);
            request.setAttribute("sexo", sexo);
            request.setAttribute("marca", marca);
            request.setAttribute("anio", año);
            request.setAttribute("precio", precio);

            // Reenviar la petición y la respuesta a la página "VehiculoResult.jsp" para mostrar los detalles del vehículo registrado.
            request.getRequestDispatcher("VehiculoResult.jsp").forward(request, response);


        } catch (NumberFormatException e) {
            // Captura la excepción que ocurre si la conversión de año o precio a número falla.
            // Se establece un mensaje de error indicando que los campos año y precio deben ser numéricos.
            request.setAttribute("error", "Año y precio deben ser valores numéricos válidos");
            // Se reenvía la petición al formulario para mostrar este error al usuario.
            request.getRequestDispatcher("VehiculoForm.jsp").forward(request, response);
        }
    }
}