<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="ejercicio3.Contacto, java.util.List" %>

<!-- autor: rodrigo daniel pineda ardón fecha: 26/04/2025
descripción: página jsp que permite agregar, listar o buscar contactos en un solo formulario -->

<html>
<head>
  <title>Agenda de contactos</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
  <link rel="stylesheet" type="text/css" href="./css/ejercicio3/index.css">
  <style>
    /* Estilos para mensajes de confirmación y error */
    .mensaje {
      background-color: #d4edda;
      color: #155724;
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 5px;
      border: 1px solid #c3e6cb;
    }

    .error {
      background-color: #f8d7da;
      color: #721c24;
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 5px;
      border: 1px solid #f5c6cb;
    }
  </style>
</head>
<body>

<div class="container">
  <h1>Agenda de contactos</h1>

  <!-- Sección para mostrar mensajes -->
  <% if (request.getAttribute("mensaje") != null) { %>
  <div class="mensaje"><%= request.getAttribute("mensaje") %></div>
  <% } %>

  <% if (request.getAttribute("error") != null) { %>
  <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>

  <!-- Formulario principal para todas las acciones -->
  <div class="formulario">
    <form action="AgendaServlet" method="post" id="formularioPrincipal">
      <h2>Gestión de Contactos</h2>

      <% String accionActual = (String)request.getAttribute("accionActual"); %>
      <select name="accion" id="accion" class="select-estilizado" required>
        <option value="">Selecciona una opción</option>
        <option value="agregar" <%= "agregar".equals(accionActual) ? "selected" : "" %>>Agregar nuevo contacto</option>
        <option value="ver" <%= "ver".equals(accionActual) ? "selected" : "" %>>Ver lista de contactos</option>
        <option value="buscar" <%= "buscar".equals(accionActual) ? "selected" : "" %>>Buscar contacto por nombre</option>
      </select>

      <div id="camposAgregar" style="display:none; margin-top: 15px;">
        <input type="text" name="nombre" placeholder="Nombre completo" pattern="[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+" maxlength="50" title="El nombre no debe contener números u otros caracteres especiales">
        <input type="text" name="telefono" placeholder="Número de teléfono" pattern="\d{8}" title="El teléfono debe contener exactamente 8 dígitos">
        <input type="email" name="correo" placeholder="Correo electrónico">
      </div>

      <div id="campoBuscar" style="display:none; margin-top: 15px;">
        <input type="text" name="nombreBuscar" placeholder="Nombre a buscar">
      </div>

      <input type="submit" value="Enviar" style="margin-top: 20px;">
    </form>
  </div>

  <!-- Sección para listar todos los contactos (solo se muestra cuando explícitamente se selecciona "ver") -->
  <%
    Boolean mostrarLista = (Boolean) request.getAttribute("mostrarLista");
    List<Contacto> lista = (List<Contacto>) request.getAttribute("contactos");
    if (mostrarLista != null && mostrarLista && lista != null) {
  %>
  <div class="listado">
    <h2>Lista de contactos</h2>
    <% if (lista.isEmpty()) { %>
    <p>No hay contactos registrados.</p>
    <% } else { %>
    <ul>
      <% for (Contacto c : lista) { %>
      <li><strong>Nombre:</strong> <%= c.getNombre() %> |
        <strong>Teléfono:</strong> <%= c.getTelefono() %> |
        <strong>Correo:</strong> <%= c.getCorreo() %></li>
      <% } %>
    </ul>
    <% } %>
  </div>
  <% } %>

  <!-- Sección para mostrar resultados de búsqueda (solo cuando se realiza una búsqueda) -->
  <%
    List<Contacto> resultados = (List<Contacto>) request.getAttribute("resultados");
    if ("buscar".equals(accionActual) && resultados != null) {
  %>
  <div class="listado">
    <h2>Resultados de búsqueda</h2>
    <% if (resultados.isEmpty()) { %>
    <p>No se encontraron contactos que coincidan con la búsqueda.</p>
    <% } else { %>
    <ul>
      <% for (Contacto c : resultados) { %>
      <li><strong>Nombre:</strong> <%= c.getNombre() %> |
        <strong>Teléfono:</strong> <%= c.getTelefono() %> |
        <strong>Correo:</strong> <%= c.getCorreo() %></li>
      <% } %>
    </ul>
    <% } %>
  </div>
  <% } %>

</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const accion = document.getElementById("accion");
    const camposAgregar = document.getElementById("camposAgregar");
    const campoBuscar = document.getElementById("campoBuscar");
    const formulario = document.getElementById("formularioPrincipal");

    // Mostrar los campos correctos según la acción seleccionada inicialmente
    mostrarCamposPorAccion();

    accion.addEventListener("change", mostrarCamposPorAccion);

    function mostrarCamposPorAccion() {
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
    }

    // Validación del formulario
    formulario.addEventListener("submit", function(event) {
      const accionSeleccionada = accion.value;

      if (accionSeleccionada === "agregar") {
        const nombre = document.querySelector('input[name="nombre"]').value;
        const telefono = document.querySelector('input[name="telefono"]').value;
        const correo = document.querySelector('input[name="correo"]').value;

        // Validar nombre (sin números y con límite)
        if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/.test(nombre)) {
          alert("El nombre no debe contener números u otros caracteres especiales.");
          event.preventDefault();
          return;
        }

        if (nombre.length > 50) {
          alert("El nombre no puede exceder los 50 caracteres.");
          event.preventDefault();
          return;
        }

        // Validar teléfono (8 dígitos)
        if (!/^\d{8}$/.test(telefono)) {
          alert("El número de teléfono debe contener exactamente 8 dígitos.");
          event.preventDefault();
          return;
        }

        // Validar email
        if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(correo)) {
          alert("El formato del correo electrónico no es válido.");
          event.preventDefault();
          return;
        }
      } else if (accionSeleccionada === "buscar") {
        const nombreBuscar = document.querySelector('input[name="nombreBuscar"]').value;
        if (!nombreBuscar.trim()) {
          alert("Ingrese un nombre para buscar.");
          event.preventDefault();
          return;
        }
      }
    });

    // Ocultar mensajes después de 5 segundos
    setTimeout(function() {
      const mensajes = document.querySelectorAll('.mensaje, .error');
      mensajes.forEach(function(mensaje) {
        mensaje.style.display = 'none';
      });
    }, 5000);
  });
</script>

</body>
</html>