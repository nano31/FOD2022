program ejer5;
const
    valorAlto = 9999;
    df = 50;
type
    cad = string[20];

    rDireccion = record
        calle: cad;
        nro: integer;
        piso: integer;
        dpto: cad;
        ciudad: cad;
    end;

    rMadre = record
        nombre: cad;
        apellido: cad;
        dni: cad;
    end;

    rPadre = record
        nombre: cad;
        apellido: cad;
        dni: cad;
    end;

    rNacimiento = record
        nroPartidaNacimiento: integer;
        nombre_apellido: cad;
        dir: rDireccion;
        nroMatriculaMed: integer;
        madre: rMadre;
        padre: rPadre;
    end;

    rFallecimiento = record
        nroPartidaNacimiento: integer;
        nombre_apellido: cad;
        dir: rDireccion;
        nroMatriculaMed: integer;
        fechaDeceso: cad;
        horaDeceso: Integer;
    end;



//programa principal
var

begin

end.