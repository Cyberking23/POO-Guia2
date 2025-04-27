package com.ejercicio1.ejercicio3;

// clase que representa un contacto
public class Contacto {
    private String nombre;
    private String telefono;
    private String correo;

    // constructor vacío
    public Contacto() {}

    // constructor con parámetros
    public Contacto(String nombre, String telefono, String correo) {
        this.nombre = nombre;
        this.telefono = telefono;
        this.correo = correo;
    }

    // obtiene el nombre
    public String getNombre() { return nombre; }

    // establece el nombre
    public void setNombre(String nombre) { this.nombre = nombre; }

    // obtiene el teléfono
    public String getTelefono() { return telefono; }

    // establece el teléfono
    public void setTelefono(String telefono) { this.telefono = telefono; }

    // obtiene el correo
    public String getCorreo() { return correo; }

    // establece el correo
    public void setCorreo(String correo) { this.correo = correo; }
}
