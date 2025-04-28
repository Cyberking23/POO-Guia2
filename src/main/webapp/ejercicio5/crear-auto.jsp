<%@ page import="com.ejercicio5.classes.Automotor" %>
<%@ page import="com.ejercicio5.model.AutomovilDAO" %><%--
  Created by IntelliJ IDEA.
  User: Gerardo
  Date: 27/4/2025
  Time: 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String mensaje = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Obtener los parámetros del formulario
            String marca = request.getParameter("marca");
            String modelo = request.getParameter("modelo");
            int year = Integer.parseInt(request.getParameter("year").isEmpty() ? "0" : request.getParameter("year"));
            int clienteId = Integer.parseInt(request.getParameter("clienteId"));

            // Crear un objeto Automotor
            Automotor automovil = new Automotor(clienteId, marca, modelo, year);

            // Intentar guardar el automóvil en la base de datos
            Automotor autoCreado = AutomovilDAO.guardarAutomovil(automovil);

            if (autoCreado != null) {
                // Si el automóvil se guardó correctamente, redirigir a la selección de servicio
                String redirectUrl = "seleccionarServicio.jsp?clienteId=" + clienteId + "&automovilId=" + autoCreado.getId();
                response.sendRedirect(redirectUrl);
                return; // Importante: Detener la ejecución de la página después de la redirección
            } else {
                mensaje = "Error al crear el automóvil. Intenta nuevamente.";
            }
        } catch (IllegalArgumentException e) {
            // Manejar el caso donde los parámetros numéricos no se puedan convertir
            mensaje = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            // Manejar cualquier otra excepción
            mensaje = "Ocurrió un error al procesar la solicitud: " + e.getMessage();
            e.printStackTrace(); // Para imprimir detalles del error en la consola
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Automóvil</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Contenedor principal -->
<div class="flex items-center justify-center min-h-screen">
    <div class="w-full max-w-lg bg-white p-8 rounded-lg shadow-xl">

        <!-- Título de la página -->
        <div class="text-center mb-6">
            <h1 class="text-3xl font-semibold text-gray-800">Crear Automóvil para el Cliente</h1>
            <p class="text-lg text-gray-600">Cliente ID: <span class="font-bold text-indigo-600">${param.clienteId}</span></p>
        </div>

        <% if (mensaje != "") { %>
        <div class="mb-4 p-4 bg-red-100 text-red-700 border border-red-400 rounded">
            <p><strong>Error:</strong> <%= mensaje %></p>
        </div>
        <% } %>

        <!-- Formulario para crear el automóvil -->
        <form action="" method="post">
            <!-- Campo oculto para el cliente ID -->
            <input type="hidden" name="clienteId" value="${param.clienteId}">

            <!-- Campo para la marca del automóvil -->
            <div class="mb-4">
                <label for="marca" class="block text-gray-700 font-medium">Marca del Automóvil</label>
                <input type="text" id="marca" name="marca" class="w-full p-3 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" >
            </div>

            <!-- Campo para el modelo del automóvil -->
            <div class="mb-4">
                <label for="modelo" class="block text-gray-700 font-medium">Modelo del Automóvil</label>
                <input type="text" id="modelo" name="modelo" class="w-full p-3 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" >
            </div>

            <!-- Campo para el año del automóvil -->
            <div class="mb-4">
                <label for="year" class="block text-gray-700 font-medium">Año del Automóvil</label>
                <input type="number" id="year" name="year" class="w-full p-3 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"  min="1900" max="2025">
            </div>

            <!-- Botón para enviar el formulario -->
            <button type="submit" class="w-full bg-green-500 text-white py-3 rounded-lg hover:bg-green-600 transition duration-200">Crear Automóvil</button>
        </form>

        <!-- Enlace para volver atrás -->
        <div class="mt-4 text-center">
            <a href="crear-venta.jsp" class="text-blue-500 hover:text-blue-600">Volver a la selección de Automóviles</a>
        </div>

    </div>
</div>

</body>
</html>

