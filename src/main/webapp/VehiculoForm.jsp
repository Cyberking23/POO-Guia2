<!--Joaquin Fuentes
Fecha: Abril 2025 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Importadora de Vehículos</title>
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: #f2f2f2;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input:focus, select:focus {
            border-color: #4CAF50;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background: linear-gradient(135deg, #45a049, #3e8e41);
        }

        .error {
            background-color: #ffe6e6;
            border: 1px solid #ff4d4d;
            padding: 10px;
            border-radius: 6px;
            color: #d8000c;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Registro de Vehículos Vendidos</h1>

    <%-- Bloque de scriptlet de Java para obtener y mostrar un mensaje de error si existe como atributo en la petición. --%>
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
    <div class="error">
        <%-- Imprime el valor del atributo "error" dentro de un div con la clase "error" para mostrarlo al usuario. --%>
        <%= error %>
    </div>
    <% } %>

    <%-- Formulario HTML que envía los datos a la URL "com.ejercicio4" utilizando el método HTTP POST. --%>
    <form action="ejercicio4" method="post">
        <div class="form-group">
            <label for="nombre">Nombre completo del cliente:</label>
            <%-- Campo de texto para ingresar el nombre del cliente. El atributo "required" indica que este campo es obligatorio. --%>
            <input type="text" id="nombre" name="nombre" required>
        </div>

        <div class="form-group">
            <label for="sexo">Sexo del cliente:</label>
            <%-- Menú desplegable (select) para seleccionar el sexo del cliente. El atributo "required" lo hace obligatorio. --%>
            <select id="sexo" name="sexo" required>
                <%-- Opción por defecto que indica al usuario que debe seleccionar una opción. --%>
                <option value="">Seleccione...</option>
                <%-- Opciones para seleccionar el sexo masculino. --%>
                <option value="masculino">Masculino</option>
                <%-- Opción para seleccionar el sexo femenino. --%>
                <option value="femenino">Femenino</option>
            </select>
        </div>

        <div class="form-group">
            <label for="marca">Marca del vehículo:</label>
            <%-- Menú desplegable para seleccionar la marca del vehículo. También es un campo obligatorio. --%>
            <select id="marca" name="marca" required>
                <%-- Opción por defecto. --%>
                <option value="">Seleccione...</option>
                <%-- Opciones de marcas de vehículos disponibles. --%>
                <option value="Nissan">Nissan</option>
                <option value="Toyota">Toyota</option>
                <option value="Kia">Kia</option>
            </select>
        </div>

        <div class="form-group">
            <label for="anio">Año del vehículo (2000-2025):</label>
            <%-- Campo numérico para ingresar el año del vehículo. Los atributos "min" y "max" definen el rango de valores permitidos. --%>
            <input type="number" id="anio" name="anio" min="2000" max="2025" required>
        </div>

        <div class="form-group">
            <label for="precio">Precio del vehículo:</label>
            <%-- Campo numérico para ingresar el precio del vehículo. El atributo "required" indica que debe ser llenado. --%>
            <input type="number" id="precio" name="precio" required>
        </div>

        <%-- Botón de envío del formulario. Al hacer clic, los datos del formulario se envían a la URL especificada en el atributo "action" del formulario. --%>
        <button type="submit">Registrar Venta</button>
    </form>

</div>
</body>
</html>