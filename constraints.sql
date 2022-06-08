-- CONSTRAINT

-- Recordatorio:
-- 1. PRIMARY KEY: campo que identifica de manera unica a un registro.
-- 2. UNIQUE: campo que no puede ser duplicado en otro registro (es diferente a la PK).
-- 3. NOT NULL: campo que no puede ser nulo.
-- 4. DEFAULT: campo con un valor por defecto.
-- 5. CHECK: campo que tiene una condicion (su valor se encuentra en un rango de valores).
-- 6. FOREIGN KEY: campo que proviene de otra tabla.

-- Existen dos formas de declarar un CONSTRAINT:

-- 1. Con un ALTER (Esta forma se encuentra en el repositorio de DDL).

-- 2. Al momento de crear la tabla
CREATE TABLE <NAME>(
    <COLUMN> <TYPE>(<SIZE>) PRIMARY KEY, -- Esta forma se usa solo cuando tenemos una PK 
    <COLUMN> <TYPE>(<SIZE>) UNIQUE, -- Esta es una forma para indicar que el campo será unico.
    <COLUMN> >TYPE>(<SIZE>) NOT NULL, 
    <COLUMN> >TYPE>(<SIZE>) DEFAULT <VALUE>,
    CONSTRAINT PK_<NAME> PRIMARY KEY (<COLUMN>), --Esta es otra forma, se puede usar cuando tengamos una o más PK. Si se tienen más de una, el nombre de las columnas se separa por comas
    CONSTRAINT U_<NAME> UNIQUE(<COLUMN>),
    CONSTRAINT CK_<TYPE> <NAME> CHECK (<COLUMN> <OPERATOR> <VALUE>),
    CONSTRAINT FK_<NAME> FOREIGN KEY (<COLUMN>) REFERENCES <TABLE_REFERENCE>(<COLUMN_REFERENCE>)
);

-- Como buena práctica, para el nombre que se le va a dar a un CONSTRAINT, se colocan sus iniciales, un guion bajo y el nombre que le queramos asignar.

-- Declaramos los CONSTRAINT con nombre por si necesitamos eliminar uno de ellos (para eliminar uno se usa DROP).