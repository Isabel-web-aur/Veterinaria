CREATE TABLE dueno (
id_dueno INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (100),
direccion VARCHAR (200),
telefono VARCHAR (20)
);

CREATE TABLE mascota (
id_mascota INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (50) ,
tipo_mascota VARCHAR(50) NOT NULL,
fecha_nacimiento DATE NOT NULL,
id_dueno INT,
FOREIGN KEY (id_dueno) REFERENCES dueno (id_dueno) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE profesional(
id_profesional INT PRIMARY KEY ,
nombre VARCHAR (50) NOT NULL,
especialidad VARCHAR (100) NOT NULL
);


CREATE TABLE atencion (
id_atencion INT PRIMARY KEY AUTO_INCREMENT,
Fecha_atencion DATE NOT NULL,
descripcion TEXT NOT NULL,
id_mascota INT,
id_profesional INT,
FOREIGN KEY (id_mascota) REFERENCES mascota (id_mascota) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (id_profesional) REFERENCES profesional (id_profesional) ON UPDATE CASCADE ON DELETE RESTRICT
);
/*modificaciones en tablas,agregando tipos de datos */

ALTER TABLE dueno 
MODIFY COLUMN nombre VARCHAR (100) NOT NULL,
MODIFY COLUMN direccion VARCHAR (200) NOT NULL,
MODIFY COLUMN telefono  VARCHAR (20) NOT NULL;

/* agregando datos a cada columna de sus tables repectivas */

INSERT INTO dueno (id_dueno,nombre,direccion,telefono)
VALUES 
(1,'Juan Pérez','calle falsa','123-555-1234'),
(2,'Ana Goméz', 'avenida siempre viva' ,'456-555-5678'),
(3,'Carlos Ruiz' , 'calle 8 de octubre', '789-555-8765');

INSERT INTO mascota (id_mascota,nombre,tipo_mascota,fecha_nacimiento,id_dueno)
VALUES
(1,'REX','perro','2020-05-10,',1),
(2,'Luna','gato','2019-02-20',2),
(3,'Fido','perro','2011-03-15',3);

SELECT * FROM mascota;

INSERT INTO profesional (id_profesional,nombre,especialidad)
VALUES 
(1,'DR.Manriquez','veterinario'),
(2,'Dr:Pérez','especialista en dermatologia'),
(3,'Dr:Lopez','cardiologo animal');

INSERT INTO atencion (id_atencion,fecha_atencion,descripcion,id_mascota,id_profesional)
VALUES
(1,'2025-03-01','Chequeo general',1,1),
(2,'2025-03-05', 'Tratamiento dermatologico',2,2),
(3,'2025-03-07','Consulta cardiológica', 3,3);

SELECT * FROM atencion;

/*consultas*/

SELECT dueno.id_dueno,
		dueno.nombre AS Nombre_Dueno, 
		mascota.nombre AS Nombre_Mascota 
FROM mascota 
INNER JOIN dueno ON dueno.id_dueno = mascota.id_dueno;


SELECT 
    mascota.nombre AS Nombre_Animal, 
    profesional.nombre AS Nombre_Medico,
    atencion.fecha_atencion,
    atencion.descripcion AS procedimiento
FROM atencion
JOIN mascota ON atencion.id_mascota = mascota.id_mascota
JOIN profesional ON atencion.id_profesional = profesional.id_profesional;

/*cambio de direccion*/

UPDATE dueno
SET direccion = 'Quilpue 2930'
Where id_dueno= 2;

/* Eliminar una atención */

DELETE 
FROM atencion WHERE id_atencion= 1;

/* corroborar que hice lo correcto*/

SELECT * FROM atencion;

START TRANSACTION;

/* Agregar datos*/
INSERT INTO mascota (nombre, tipo_mascota, fecha_nacimiento, id_dueno) 
VALUES ('Sparky', 'perro', '2023-01-10', 4);

/* agregar datos */
/* Usamos LAST_INSERT_ID() para decirle "la mascota que acabo de anotar arriba"*/
INSERT INTO atencion (fecha_atencion, descripcion, id_mascota, id_profesional)
VALUES (CURDATE(), 'Chequeo inicial', LAST_INSERT_ID(), 2);



COMMIT; 



 