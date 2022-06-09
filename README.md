# Bases de Datos: CONSTRAINT

Definición
--------------------------------------------------------------------------------------------------------------------------------------------------------
Un CONSTRAINT es una regla que debe respetar un campo. Entre estas reglas se encuentran PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE, NULL, NOT NULL y DEFAULT.

Desarrollo
--------------------------------------------------------------------------------------------------------------------------------------------------------
Los CONSTRAINT que se van a ver son los siguiente:
- **PRIMARY KEY**: Puede ser uno o más campos, que identifiquen de manera unica a un registro. Para saber que campo va a ser nuestra PK, debe ser de la menor longitud simple (si solo vamos a tener una) o las menos posibles (si vamos a tener más de una).  
- **FOREIGN KEY**: Los valores vienen de otras tablas. Normalmente son llaves primarias de otras relaciones (tablas). 
- **CHECK**: El campo tiene un rango especifico de valores, puede ser numérico o textual.
- **UNIQUE**: Este tipo de campo es único y no debe repetirse en los demas registros. Es casi una PK, pero es diferente a una PK.
- **NULL**: De manera predeterminada, todos los campos (siempre y cuando no sean PK y FK) tienen el valor de nulo. No es necesario indicarlo al momento de crear la tabla. Una vez que se ingresan datos a la tabla, se quita el valor nulo a los campos correspondientes.
- **NOT NULL**: Al momento de insertar los valores, este campo no puede faltar.
- **DEFAULT**: El campo tiene por defecto un valor en especifico. Dicho valor se declara al momento de crear la tabla.

NOTAS
--------------------------------------------------------------------------------------------------------------------------------------------------------
**NOTA #1**: Los repositorios **Bases de Datos** están hechos con base en el curso de Bases de Datos de la Facultad de Ingeniería de la UNAM. 
