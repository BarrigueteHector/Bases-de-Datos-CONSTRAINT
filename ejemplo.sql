SQL> -- Recordemos que existen dos formas para declarar los CONSTRAINT. La primera es hacerlo al momento de crear la tabla y la segunda utilizando ALTER.
SQL> -- PRIMERA FORMA
SQL> CREATE TABLE MAESTRO(
  2  ID NUMBER(5) PRIMARY KEY,
  3  NOMBRE VARCHAR(20) NOT NULL,
  4  APPAT VARCHAR(20) NOT NULL,
  5  APMAT VARCHAR(20),
  6  INGRESO DATE NOT NULL
  7  );

Tabla creada.

SQL> 
SQL> -- En la tabla MAESTRO se declaran todos los CONSTRAINT necesarios:
SQL> -- PK: ID porque solo existira uno para cada maestro y con ese lo vamos a identificar
SQL> -- FK: No es necesaria, la tabla no necesita conocer un valor de otra tabla
SQL> -- CK: No es necesario, ningun valor debe encontrarse en un rango de valores
SQL> -- U: No es necesario, ningun valor debe ser unico para cada registro de la tabla. No confundir con PK.
SQL> -- NULL: El apellido materno no es necesario, puede omitirse al hacer la inserci�n.
SQL> -- NOT NULL: Nombre, apellico paterno y fecha de ingreso no pueden omitirse. Por ser PK, el ID tampoco puede omitirse.
SQL> 
SQL> -- La insercion de valores para MAESTRO se vera posteriormente.
SQL> 
SQL> -- SEGUNDA FORMA
SQL> CREATE TABLE ALUMNO(
  2  ID_ALU NUMBER(5),
  3  NOMBRE_ALU VARCHAR(20),
  4  APPAT_ALU VARCHAR(20),
  5  APMAT_ALU VARCHAR(20),
  6  GRADO CHAR(1),
  7  GRUPO CHAR(1)
  8  );

Tabla creada.

SQL> 
SQL> -- Como buena practica, los nombres de los CONSTRAINT deben iniciar con las iniciales de este, seguido de un guion bajo y seguido del nombre que le vayamos a dar:
SQL> -- PK: PRIMARY KEY
SQL> -- FK: FOREIGN KEY
SQL> -- CK: CHECK
SQL> -- U: UNIQUE
SQL> 
SQL> -- Declaramos la PK.
SQL> ALTER TABLE ALUMNO ADD CONSTRAINT PK_ALUMNO PRIMARY KEY (ID_ALU);

Tabla modificada.

SQL> 
SQL> -- Declaramos los CK
SQL> ALTER TABLE ALUMNO ADD CONSTRAINT CK_GRADO CHECK (GRADO IN ('1', '2', '3', '4', '5', '6'));

Tabla modificada.

SQL> -- El grado puede tomar los valores de 1, 2, 3, 4, 5 o 6
SQL> 
SQL> ALTER TABLE ALUMNO ADD CONSTRAINT CK_GRUPO CHECK (GRUPO IN ('A', 'B', 'C'));

Tabla modificada.

SQL> -- El grupo puede tomar los valores de A, B o C
SQL> 
SQL> -- Cambiamos unos campos a NOT NULL
SQL> ALTER TABLE ALUMNO MODIFY NOMBRE_ALU NOT NULL;

Tabla modificada.

SQL> ALTER TABLE ALUMNO MODIFY APPAT_ALU NOT NULL;

Tabla modificada.

SQL> ALTER TABLE ALUMNO MODIFY GRADO NOT NULL;

Tabla modificada.

SQL> ALTER TABLE ALUMNO MODIFY GRUPO NOT NULL;

Tabla modificada.

SQL> -- Los campos de GRADO y GRUPO se les agrega NOT NULL porque a pesar de tener el CHECK, eso no impide que el valor pueda ser omitido al momento de hacer la insercion.
SQL> 
SQL> -- Si vemos la estructura de la tabla, podremos ver que campos son obligatorios y cuales no.
SQL> DESCRIBE ALUMNO;
 Nombre                                                            �Nulo?   Tipo
 ----------------------------------------------------------------- -------- --------------------------------------------
 ID_ALU                                                            NOT NULL NUMBER(5)
 NOMBRE_ALU                                                        NOT NULL VARCHAR2(20)
 APPAT_ALU                                                         NOT NULL VARCHAR2(20)
 APMAT_ALU                                                                  VARCHAR2(20)
 GRADO                                                             NOT NULL CHAR(1)
 GRUPO                                                             NOT NULL CHAR(1)

SQL> 
SQL> -- Suponiendo que querramos regresar un campo a nulo (siempre que no sea PK), debemos de hacer lo siguiente:
SQL> ALTER TABLE ALUMNO MODIFY GRUPO NULL;

Tabla modificada.

SQL> DESCRIBE ALUMNO;
 Nombre                                                            �Nulo?   Tipo
 ----------------------------------------------------------------- -------- --------------------------------------------
 ID_ALU                                                            NOT NULL NUMBER(5)
 NOMBRE_ALU                                                        NOT NULL VARCHAR2(20)
 APPAT_ALU                                                         NOT NULL VARCHAR2(20)
 APMAT_ALU                                                                  VARCHAR2(20)
 GRADO                                                             NOT NULL CHAR(1)
 GRUPO                                                                      CHAR(1)

SQL> -- Pero para seguir con el ejemplo lo hacemos obligatorio de nuEvo
SQL> ALTER TABLE ALUMNO MODIFY GRUPO NOT NULL;

Tabla modificada.

SQL> DESCRIBE ALUMNO;
 Nombre                                                            �Nulo?   Tipo
 ----------------------------------------------------------------- -------- --------------------------------------------
 ID_ALU                                                            NOT NULL NUMBER(5)
 NOMBRE_ALU                                                        NOT NULL VARCHAR2(20)
 APPAT_ALU                                                         NOT NULL VARCHAR2(20)
 APMAT_ALU                                                                  VARCHAR2(20)
 GRADO                                                             NOT NULL CHAR(1)
 GRUPO                                                             NOT NULL CHAR(1)

SQL> 
SQL> -- Agregamos algunos registros:
SQL> INSERT INTO ALUMNO VALUES(1, 'Fernando', 'Quiroz', 'Rodriguez', '6', 'A');

1 fila creada.

SQL> -- Si el grado es incorrectos se manda error:
SQL> INSERT INTO ALUMNO VALUES(2, 'Karen', 'Coral', 'Juarez', '7', 'A');
INSERT INTO ALUMNO VALUES(2, 'Karen', 'Coral', 'Juarez', '7', 'A')
*
ERROR en l�nea 1:
ORA-02290: restricci�n de control (REPO.CK_GRADO) violada 


SQL> -- Si el grupo es incorrecto, se manda error
SQL> INSERT INTO ALUMNO VALUES(1, 'Karen', 'Coral', 'Juarez', '1', 'D');
INSERT INTO ALUMNO VALUES(1, 'Karen', 'Coral', 'Juarez', '1', 'D')
*
ERROR en l�nea 1:
ORA-02290: restricci�n de control (REPO.CK_GRUPO) violada 


SQL> -- Si falta informacion que no puede ser nula, se manda error:
SQL> INSERT INTO ALUMNO VALUES(2, 'Karen', '', 'Juarez', '1', 'B');
INSERT INTO ALUMNO VALUES(2, 'Karen', '', 'Juarez', '1', 'B')
                                      *
ERROR en l�nea 1:
ORA-01400: no se puede realizar una inserci�n NULL en ("REPO"."ALUMNO"."APPAT_ALU") 


SQL> -- Si se repite la PK, se manda error:
SQL> INSERT INTO ALUMNO VALUES(1, 'Karen', 'Coral', 'Juarez', '1', 'B');
INSERT INTO ALUMNO VALUES(1, 'Karen', 'Coral', 'Juarez', '1', 'B')
*
ERROR en l�nea 1:
ORA-00001: restricci�n �nica (REPO.PK_ALUMNO) violada 


SQL> 
SQL> INSERT INTO ALUMNO VALUES(2, 'Karen', 'Coral', 'Juarez', '1', 'B');

1 fila creada.

SQL> INSERT INTO ALUMNO VALUES(3, 'Karina', 'Cruz', 'Mendez', '3', 'C');

1 fila creada.

SQL> INSERT INTO ALUMNO VALUES(4, 'Fernando', 'Lopez', 'Martinez', '1', 'A');

1 fila creada.

SQL> INSERT INTO ALUMNO VALUES(5, 'Fernanda', 'Gallegos', 'Hernandez', '2', 'B');

1 fila creada.

SQL> 
SQL> -- Para eliminar un CONSTRAINT:
SQL> ALTER TABLE ALUMNO DROP CONSTRAINT PK_ALUMNO;

Tabla modificada.

SQL> ALTER TABLE ALUMNO DROP CONSTRAINT CK_GRADO;

Tabla modificada.

SQL> ALTER TABLE ALUMNO DROP CONSTRAINT CK_GRUPO;

Tabla modificada.

SQL> -- Ahora seria posible que los ID se repitan o que se inserten grados o grupos que antes no se permitian
SQL> 
SQL> -- Revisaremos los 2 que faltan (FK y U), pero necesitamos llenar la tabla MAESTRO (posteriormente se explica la razon):
SQL> INSERT INTO MAESTRO VALUES(1, 'Ulises', 'Esquivel', '', '12/05/2010');

1 fila creada.

SQL> INSERT INTO MAESTRO VALUES(2, 'Fernando', 'Velazquez', 'Cruz', '01/09/2010');

1 fila creada.

SQL> INSERT INTO MAESTRO VALUES(3, 'Carmen', 'Pedraza', 'Curiel', '12/12/2012');

1 fila creada.

SQL> INSERT INTO MAESTRO VALUES(4, 'Daniela', 'Carrera', '', '21/05/2019');

1 fila creada.

SQL> INSERT INTO MAESTRO VALUES(5, 'Manuel', 'Roman', 'Ramirez', '29/01/2020');

1 fila creada.

SQL> 
SQL> SELECT * FROM MAESTRO;

        ID NOMBRE               APPAT                APMAT                INGRESO                                       
---------- -------------------- -------------------- -------------------- --------                                      
         1 Ulises               Esquivel                                  12/05/10                                      
         2 Fernando             Velazquez            Cruz                 01/09/10                                      
         3 Carmen               Pedraza              Curiel               12/12/12                                      
         4 Daniela              Carrera                                   21/05/19                                      
         5 Manuel               Roman                Ramirez              29/01/20                                      

SQL> 
SQL> -- Creamos una nueva tabla
SQL> CREATE TABLE CLASE(
  2  ID_MAESTRO NUMBER(5) PRIMARY KEY,
  3  GRUPO CHAR(2)
  4  );

Tabla creada.

SQL> 
SQL> -- Para obtener el ID del maestro usamos de referencia la tabla maestro y el campo correspondiente
SQL> ALTER TABLE CLASE ADD CONSTRAINT FK_MAESTRO FOREIGN KEY(ID_MAESTRO) REFERENCES MAESTRO(ID);

Tabla modificada.

SQL> 
SQL> -- Para las llaves foraneas, ambos campos deben ser del mismo tipo y tama�o.
SQL> -- Las columnas pueden o no tener el mismo nombre.
SQL> 
SQL> ALTER TABLE CLASE ADD CONSTRAINT U_GRUPO UNIQUE (GRUPO);

Tabla modificada.

SQL> -- Un profesor solo le puede dar clase a un grupo de un grado.
SQL> 
SQL> -- Para poder hacer inserciones en en campos que sean FK, es necesario que el registro al que se va a hacer referencia, exista en la tabla de referencia.
SQL> -- En otras palabras, para poder insertar registros en CLASE, el ID del maestro debe existir (estar en la tabla MAESTRO).
SQL> 
SQL> INSERT INTO CLASE VALUES(8, '5A');
INSERT INTO CLASE VALUES(8, '5A')
*
ERROR en l�nea 1:
ORA-02291: restricci�n de integridad (REPO.FK_MAESTRO) violada - clave principal no encontrada 


SQL> -- Al no existir un registro en MAESTRO con el ID 8, nos manda error
SQL> 
SQL> INSERT INTO CLASE VALUES(1, '4A');

1 fila creada.

SQL> INSERT INTO CLASE VALUES(2, '5B');

1 fila creada.

SQL> INSERT INTO CLASE VALUES(3, '6C');

1 fila creada.

SQL> 
SQL> SELECT * FROM CLASE;

ID_MAESTRO GRUPO                                                                                                        
---------- ------                                                                                                       
         1 4A                                                                                                           
         2 5B                                                                                                           
         3 6C                                                                                                           

SQL> 
SQL> -- Si intentamos darle a un profesor un nuevo grupo o si a un profesor le asignamos un grupo que ya fue asignado, aparecera un error:
SQL> INSERT INTO CLASE VALUES(1, '1A');
INSERT INTO CLASE VALUES(1, '1A')
*
ERROR en l�nea 1:
ORA-00001: restricci�n �nica (REPO.SYS_C008905) violada 


SQL> INSERT INTO CLASE VALUES(4, '4A');
INSERT INTO CLASE VALUES(4, '4A')
*
ERROR en l�nea 1:
ORA-00001: restricci�n �nica (REPO.U_GRUPO) violada 


SQL> 
SQL> INSERT INTO CLASE VALUES(4, '1B');

1 fila creada.

SQL> INSERT INTO CLASE VALUES(5, '1A');

1 fila creada.

SQL> 
SQL> SELECT * FROM CLASE;

ID_MAESTRO GRUPO                                                                                                        
---------- ------                                                                                                       
         1 4A                                                                                                           
         2 5B                                                                                                           
         3 6C                                                                                                           
         4 1B                                                                                                           
         5 1A                                                                                                           

SQL> 
SQL> -- Supongamos que vamos a eliminar la tabla MAESTRO, no seria posible hacerlo por la FK, por lo que para hacerlo hay 2 caminos, podemos eliminar la tabla que tiene la FK y despues eliminamos MAESTRO o solo eliminamos la FK.
SQL> DROP TABLE MAESTRO;
DROP TABLE MAESTRO
           *
ERROR en l�nea 1:
ORA-02449: claves �nicas/primarias en la tabla referidas por claves ajenas 


SQL> ALTER TABLE CLASE DROP CONSTRAINT FK_MAESTRO;

Tabla modificada.

SQL> DROP TABLE MAESTRO;

Tabla borrada.

SQL> -- Como buena practica, es mejor eliminar la FK que eliminar ambas tablas.
SQL> 
SQL> -- Repasando:
SQL> -- Una PK solo puede aparecer una vez en la tabla y es obligatoria al momento de insertar.
SQL> -- Todo CONSTRAINT que puede ser nulo o no nulo si nosotros queremos.
SQL> -- FK toma el valor de una tabla B para la tabla A. Es necesario que el registro que se va a tomar para A ya exista en B.
SQL> -- Los CK nos ayudan a definir un rango de valores que un campo puede tener
SQL> -- Si un campo es U, el valor para el registro en dicho campo debe ser unico en toda la tabla
SQL> 
SQL> SPOOL OFF;
