<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="ejercicio3.Contacto, java.util.List" %>

<html>
<head>
  <title>Lista de Contactos</title>
  <!-- Fuente y estilos -->
  <style>
    /* Fuente */
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap');

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #89f7fe, #66a6ff);
      margin: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .container {
      width: 100%;
      max-width: 700px;
      background: #ffffff;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
      text-align: center;
    }

    h1 {
      margin-bottom: 30px;
      color: #333;
    }

    .listado {
      text-align: left;
      margin-top: 20px;
    }

    .listado ul {
      list-style: none;
      padding: 0;
    }

    .listado li {
      background: #e0f7fa;
      padding: 15px;
      margin-bottom: 10px;
      border-radius: 10px;
      font-size: 16px;
    }

    .no-contactos {
      background: #ffe6e6;
      padding: 15px;
      border-radius: 10px;
      color: #c62828;
      font-weight: bold;
    }

    a {
      display: inline-block;
      margin-top: 20px;
      background-color: #66a6ff;
      color: white;
      padding: 12px 24px;
      border-radius: 10px;
      text-decoration: none;
      font-weight: bold;
      transition: background 0.3s ease;
    }

    a:hover {
      background-color: #4a90e2;
    }
  </style>
</head>

<body>

<div class="container">
  <h1>Lista de Contactos</h1>

  <%
    //comprueba que no esté vacío
    List<Contacto> lista = (List<Contacto>) request.getAttribute("contactos");
    if (lista == null || lista.isEmpty()) {
  %>
  <div class="no-contactos">
    No hay contactos registrados.
  </div>
  <% } else { %>
  <div class="listado">
    <ul>
      <% for (Contacto c : lista) {
        //itera hasta donde se encuentre%>
      <li>
        <strong>Nombre:</strong> <%= c.getNombre() %> |
        <strong>Teléfono:</strong> <%= c.getTelefono() %> |
        <strong>Correo:</strong> <%= c.getCorreo() %>
      </li>
      <% } %>
    </ul>
  </div>
  <% } %>

  <a href="Ejercicio3.jsp">Regresar</a>
</div>

</body>
</html>
