<!-- Autor: Victor Guevara
Fecha: Abril 2025 -->
<%@ page import="com.ejercicio1.Estudiante" %>
<%
    String errores = (String) request.getAttribute("errores");
    Estudiante e = (Estudiante) request.getAttribute("estudiante");
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <link rel="stylesheet" type="text/css" href="css/resultados.css">
    <title>Resultado</title>
</head>
<body>
<div class="container">
    <h1>Resultado del Estudiante</h1>

    <% if (errores != null) { %>
    <div class="errores">
        <h3>Errores:</h3>
        <p><%= errores %></p>
        <a href="estudianteForm.jsp" class="button">Volver</a>
    </div>
    <% } else if (e != null) { %>
    <h2>Datos del Estudiante:</h2>
    <div class="datos-estudiante">
        <p><strong>Carnet:</strong> <%= e.getCarnet() %></p>
        <p><strong>Nombres:</strong> <%= e.getNombres() %></p>
        <p><strong>Apellidos:</strong> <%= e.getApellidos() %></p>
        <p><strong>Direccion:</strong> <%= e.getDireccion() %></p>
        <p><strong>Telefono:</strong> <%= e.getTelefono() %></p>
        <p><strong>Email:</strong> <%= e.getEmail() %></p>
        <p><strong>Fecha de Nacimiento:</strong> <%= e.getFechaNacimiento() %></p>
    </div>
    <% } %>
    <div class="link-container">
        <a href="index.jsp" class="button">Regresar al index</a>
    </div>
</div>
</body>
</html>