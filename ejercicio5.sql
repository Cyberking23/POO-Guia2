DROP DATABASE IF EXISTS `poo_ejercicio5`;

CREATE DATABASE `poo_ejercicio5`;

USE `poo_ejercicio5`;

CREATE TABLE `clientes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nombres` VARCHAR(255) NOT NULL,
    `apellidos` VARCHAR(255) NOT NULL,
    `vip` BOOLEAN DEFAULT FALSE 
);

CREATE TABLE `automotores` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `cliente_id` INT NOT NULL UNIQUE ,
    `marca` VARCHAR(255) NOT NULL,
    `modelo` VARCHAR(255) NOT NULL,
    `year` INT,
    FOREIGN KEY (`cliente_id`) REFERENCES `clientes`(`id`) ON DELETE CASCADE 
);

CREATE TABLE `servicios` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `cliente_id` INT NOT NULL,
    `fecha_hora` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `tipo` VARCHAR(255) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (`cliente_id`) REFERENCES `clientes`(`id`) ON DELETE CASCADE
);