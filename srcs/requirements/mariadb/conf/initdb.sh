USE wordpress

CREATE TABLE IF NOT EXISTS prueba(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

INSERT INTO prueba (nombre) VALUES ('Hola');