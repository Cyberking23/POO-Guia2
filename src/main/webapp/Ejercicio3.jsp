<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="com.ejercicio1.ejercicio3.Contacto, java.util.List" %>

<!--
autor: rodrigo daniel pineda ardón
fecha: 26/04/2025
descripción: página jsp que permite agregar, listar o buscar contactos en un solo formulario
-->

<html>
<head>
  <title>Agenda de contactos</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
  <link rel="stylesheet" type="text/css" href="./css/ejercicio3/index.css">
</head>
<body>

<div class="container">

  <h1>Agenda de contactos</h1>

  <!-- formulario principal para todas las acciones -->
  <div class="formulario">
    <form action="AgendaServlet" method="post" id="formularioPrincipal">
      <h2>Gestión de Contactos</h2>

      <select name="accion" id="accion" class="select-estilizado" required>
        <option value="">Selecciona una opción</option>
        <option value="agregar">Agregar nuevo contacto</option>
        <option value="ver">Ver lista de contactos</option>
        <option value="buscar">Buscar contacto por nombre</option>
      </select>

      <div id="camposAgregar" style="display:none; margin-top: 15px;">
        <input type="text" name="nombre" placeholder="Nombre completo">
        <input type="text" name="telefono" placeholder="Número de teléfono">
        <input type="email" name="correo" placeholder="Correo electrónico">
      </div>

      <div id="campoBuscar" style="display:none; margin-top: 15px;">
        <input type="text" name="nombreBuscar" placeholder="Nombre a buscar">
      </div>

      <input type="submit" value="Enviar" style="margin-top: 20px;">
    </form>
  </div>

  <!-- sección para mostrar errores -->
  <% if (request.getAttribute("error") != null) { %>
  <p class="error"><%= request.getAttribute("error") %></p>
  <% } %>

  <!-- sección para listar todos los contactos -->
  <%
    List<Contacto> lista = (List<Contacto>) request.getAttribute("contactos");
    if (lista != null && !lista.isEmpty()) {
  %>
  <div class="listado">
    <h2>Lista de contactos</h2>
    <ul>
      <% for (Contacto c : lista) { %>
      <li><strong>Nombre:</strong> <%= c.getNombre() %> |
        <strong>Teléfono:</strong> <%= c.getTelefono() %> |
        <strong>Correo:</strong> <%= c.getCorreo() %></li>
      <% } %>
    </ul>
  </div>
  <% } %>

  <!-- sección para mostrar resultados de búsqueda -->
  <%
    List<Contacto> resultados = (List<Contacto>) request.getAttribute("resultados");
    if (resultados != null && !resultados.isEmpty()) {
  %>
  <div class="listado">
    <h2>Resultados de búsqueda</h2>
    <ul>
      <% for (Contacto c : resultados) { %>
      <li><strong>Nombre:</strong> <%= c.getNombre() %> |
        <strong>Teléfono:</strong> <%= c.getTelefono() %> |
        <strong>Correo:</strong> <%= c.getCorreo() %></li>
      <% } %>
    </ul>
  </div>
  <% } %>

</div>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const accion = document.getElementById("accion");
    const camposAgregar = document.getElementById("camposAgregar");
    const campoBuscar = document.getElementById("campoBuscar");

    accion.addEventListener("change", function() {
      if (accion.value === "agregar") {
        camposAgregar.style.display = "block";
        campoBuscar.style.display = "none";
      } else if (accion.value === "buscar") {
        camposAgregar.style.display = "none";
        campoBuscar.style.display = "block";
      } else {
        camposAgregar.style.display = "none";
        campoBuscar.style.display = "none";
      }
    });
  });
</script>



</body>
</html>
