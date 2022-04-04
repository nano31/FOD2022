program ejer5;
const
    valorAlto = 9999;
    df = 2;
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

    {nacimientos y fallecimientos seran los archivos detalles}
    nacimientos = file of rNacimiento;
    fallecimientos = file of rFallecimiento;



    rMaestro = record
        infoNacimientos: rNacimiento;
        infoFallecimientos: rFallecimiento;
    end;

    maestro = file of rMaestro;

    detNacimientos = array [1..df] of nacimientos;
    detFallecimientos = array [1..df] of fallecimientos;

    vecNacimientos = array [1..df] of rNacimiento;
    vecFallecimientos = array [1..df] of rFallecimiento;

procedure leerNacimientos(var nac: nacimientos; var regNac: rNacimiento);
begin
    if (not EOF(nac)) then
        read(nac, regNac)
    else
        regNac.nroPartidaNacimiento := valorAlto;
end;

procedure leerFallecimientos(var fa: fallecimientos; var regFa: rFallecimiento);
begin
    if (not EOF(fa)) then
        read(fa, regFa)
    else
        regFa.nroPartidaNacimiento := valorAlto;
end;

procedure minimoNacimiento ();
var

begin

end;

procedure minimoFallecimiento();
var

begin

end;

//programa principal
var

begin

end.