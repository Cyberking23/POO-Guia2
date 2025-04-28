<%--
  Created by IntelliJ IDEA.
  User: Gerardo
  Date: 27/4/2025
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seleccionar Tipo de Servicio</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Contenedor principal -->
<div class="flex items-center justify-center min-h-screen">
    <div class="w-full max-w-lg bg-white p-8 rounded-lg shadow-xl">

        <!-- Título de la página -->
        <div class="text-center mb-6">
            <h1 class="text-3xl font-semibold text-gray-800">Seleccionar Tipo de Servicio</h1>
            <p class="text-lg text-gray-600">Cliente ID: <span class="font-bold text-indigo-600">${param.clienteId}</span></p>
            <p class="text-lg text-gray-600">Automóvil ID: <span class="font-bold text-indigo-600">${param.automovilId}</span></p>
        </div>

        <form action="confirmarServicio.jsp" method="post">
            <!-- Campos ocultos con los parámetros clienteId y automovilId -->
            <input type="hidden" name="clienteId" value="${param.clienteId}">
            <input type="hidden" name="automovilId" value="${param.automovilId}">

            <!-- Selección del tipo de servicio -->
            <div class="mb-4">
                <label for="tipoServicio" class="block text-gray-700 font-medium">Selecciona el Tipo de Servicio</label>
                <select id="tipoServicio" name="tipoServicio" class="w-full p-3 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <option value="Motocicleta">Motocicleta</option>
                    <option value="Sedan">Sedan</option>
                    <option value="Camioneta">Camioneta</option>
                    <option value="Microbús">Microbús</option>
                    <option value="Autobús">Autobús</option>
                </select>
            </div>

            <!-- Botón de confirmación -->
            <button type="submit" class="w-full bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 transition duration-200 mt-6">Confirmar Servicio</button>
        </form>

        <!-- Enlace para volver -->
        <div class="mt-4 text-center">
            <a href="crear-venta.jsp" class="text-blue-500 hover:text-blue-600">Volver a seleccionar cliente</a>
        </div>

    </div>
</div>

</body>
</html>
