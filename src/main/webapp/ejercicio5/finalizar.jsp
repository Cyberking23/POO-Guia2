<%--
  Created by IntelliJ IDEA.
  User: Gerardo
  Date: 27/4/2025
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Venta Realizada</title>
    <!-- Tailwind CSS (a través de CDN) -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Contenedor principal -->
<div class="flex items-center justify-center min-h-screen">
    <div class="w-full max-w-lg bg-white p-8 rounded-lg shadow-xl">

        <!-- Título de la página -->
        <div class="text-center mb-6">
            <h1 class="text-3xl font-semibold text-green-600">Venta Realizada con Éxito</h1>
            <p class="text-lg text-gray-600 mt-4">La venta se ha completado exitosamente. ¡Gracias por tu compra!</p>
        </div>

        <!-- Botón para volver al inicio -->
        <a href="index.jsp" class="w-full block text-center bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 transition duration-200 mt-6">
            Volver al Inicio
        </a>

    </div>
</div>

</body>
</html>

