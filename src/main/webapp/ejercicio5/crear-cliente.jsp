<%--
  Autor: Gerardo Saz
  Fecha: 27/4/2025
--%>
<%@ page import="com.ejercicio5.classes.Cliente" %>
<%@ page import="com.ejercicio5.model.ClienteDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    String message = "";
// Comprobar si el formulario fue enviado (si se hizo un POST)
    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            // Obtener los valores del formulario
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            boolean vip = Boolean.parseBoolean(request.getParameter("vip"));

            // Crear el objeto Cliente con los datos obtenidos del formulario
            Cliente cliente = new Cliente(nombre, apellido, vip);

            // Intentar guardar el cliente en la base de datos usando ClienteDAO
            Cliente clienteCreado = ClienteDAO.guardarCliente(cliente);

            // Verificar si la inserción fue exitosa
            if (clienteCreado != null) {
                response.sendRedirect("crearOrSeleccionarAutomovil.jsp?clienteId=" + clienteCreado.getId());
            } else {
                message = "Error al crear el cliente. Intenta nuevamente.";
            }
        } catch (Exception e) {
            // Manejo de excepciones, en caso de que ocurra algún error
            message = "Ocurrió un error al procesar la solicitud: " + e.getMessage();
            e.printStackTrace();  // Para imprimir detalles del error en la consola
        }
    }
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Cliente - CRM Car Clean</title>
    <script src="https://cdn.tailwindcss.com"></script> <!-- Importando TailwindCSS desde CDN -->
    <style>
        /* Estilo adicional para ajustar el fondo y bordes */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
    </style>
</head>

<body class="bg-gray-100 font-sans leading-normal tracking-normal">

<!-- Contenedor principal -->
<div class="container bg-white shadow-lg rounded-lg p-8 mt-8">
    <!-- Título principal -->
    <h1 class="text-3xl font-bold text-center text-indigo-600 mb-6">Crear Nuevo Cliente</h1>

    <% if (message != "") { %>
    <div class="mb-4 p-4 bg-red-100 text-red-700 border border-red-400 rounded">
        <p><strong>Error:</strong> <%= message %></p>
    </div>
    <% } %>

    <!-- Descripción -->
    <p class="text-lg text-gray-700 mb-4 text-center">
        Ingresa los datos del nuevo cliente para continuar con la creación de la venta.
    </p>

    <!-- Formulario para crear cliente -->
    <form action="" method="POST" class="space-y-6">
        <!-- Nombre -->
        <div>
            <label for="nombre" class="block text-sm font-medium text-gray-700">Nombre</label>
            <input type="text" id="nombre" name="nombre"  class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- Apellido -->
        <div>
            <label for="apellido" class="block text-sm font-medium text-gray-700">Apellido</label>
            <input type="text" id="apellido" name="apellido"  class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- VIP -->
        <div class="flex items-center space-x-4">
            <div>
                <input type="radio" id="vip-sí" name="vip" value="true" class="h-5 w-5 text-indigo-600 border-gray-300 focus:ring-indigo-500" />
                <label for="vip-sí" class="text-sm font-medium text-gray-700">VIP</label>
            </div>
            <div>
                <input type="radio" id="vip-no" name="vip" value="false" class="h-5 w-5 text-indigo-600 border-gray-300 focus:ring-indigo-500" checked />
                <label for="vip-no" class="text-sm font-medium text-gray-700">No VIP</label>
            </div>
        </div>

        <!-- Botón de guardar -->
        <div class="flex justify-center">
            <button type="submit" class="w-full sm:w-auto px-8 py-3 bg-indigo-600 text-white text-lg font-semibold rounded-lg hover:bg-indigo-700">
                Guardar Cliente
            </button>
        </div>
    </form>

    <!-- Botón para regresar -->
    <div class="text-center mt-6">
        <a href="crear-venta.jsp" class="text-indigo-600 hover:text-indigo-700 text-sm">Volver al inicio</a>
    </div>
</div>
</body>
</html>
