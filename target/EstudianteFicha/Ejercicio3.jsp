<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="ejercicio3.Contacto, java.util.List" %>

<html>
<head>
  <title>agenda de contactos</title>
  <!-- importar fuentes y css externo -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
  <link rel="stylesheet" type="text/css" href="./css/ejercicio3/index.css">

  <!-- estilos adicionales para mensajes y errores -->
  <style>
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

  <!-- mostrar mensaje de éxito si existe -->
  <% if (request.getAttribute("mensaje") != null) { %>
  <div class="mensaje"><%= request.getAttribute("mensaje") %></div>
  <% } %>

  <!-- mostrar mensaje de error si existe -->
  <% if (request.getAttribute("error") != null) { %>
  <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>

  <div class="formulario">
    <form action="AgendaServlet" method="post" id="formularioPrincipal">
      <h2>Gestión de contactos</h2>

      <% String accionActual = (String) request.getAttribute("accionActual"); %>
      <!-- selector de acción -->
      <select name="accion" id="accion" class="select-estilizado" required>
        <option value="">Selecciona una opción</option>
        <option value="agregar" <%= "agregar".equals(accionActual) ? "selected" : "" %>>Agregar nuevo contacto</option>
        <option value="ver" <%= "ver".equals(accionActual) ? "selected" : "" %>>Ver lista de contactos</option>
        <option value="buscar" <%= "buscar".equals(accionActual) ? "selected" : "" %>>Buscar contacto por nombre</option>
      </select>

      <!-- campos para agregar contacto -->
      <div id="camposAgregar" style="display:none; margin-top: 15px;">
        <input type="text" name="nombre" placeholder="Nombre completo" pattern="[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+" maxlength="50" title="el nombre no debe contener números ni caracteres especiales">
        <input type="text" name="telefono"
               placeholder="Número de teléfono"
               pattern="\d{4}-\d{4}"
               title="Debe ser en formato 7033-5678 (4 números, guion, 4 números)"
               maxlength="9">
        <input type="email" name="correo" placeholder="Correo electrónico">
      </div>

      <!-- campo para buscar contacto -->
      <div id="campoBuscar" style="display:none; margin-top: 15px;">
        <input type="text" name="nombreBuscar" placeholder="Nombre a buscar">
      </div>

      <!-- botón de enviar -->
      <input type="submit" value="enviar" style="margin-top: 20px;">
    </form>
  </div>
</div>

<script>
  // esperar a que cargue el documento
  document.addEventListener("DOMContentLoaded", function() {
    const accion = document.getElementById("accion");
    const camposAgregar = document.getElementById("camposAgregar");
    const campoBuscar = document.getElementById("campoBuscar");
    const formulario = document.getElementById("formularioPrincipal");

    // mostrar campos según la acción seleccionada
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

    // validar el formulario antes de enviarlo
    formulario.addEventListener("submit", function(event) {
      const accionSeleccionada = accion.value;

      if (accionSeleccionada === "agregar") {
        const nombre = document.querySelector('input[name="nombre"]').value;
        const telefono = document.querySelector('input[name="telefono"]').value;
        const correo = document.querySelector('input[name="correo"]').value;

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

        if (!/^\d{4}-\d{4}$/.test(telefono)) {
          alert("El número de teléfono debe estar en el formato 0000-0000.");
          event.preventDefault();
          return;
        }

        if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(correo)) {
          alert("El correo electrónico no es válido.");
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

    // ocultar mensajes de éxito o error automáticamente después de 5 segundos
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
