program ejer2;
const

type
    rAlumno = record
        cod: integer;
        nombre: string[20];
        apellido: string[20];
        cantCursadasA: integer;
        cantFinalesA: integer;
    end;

    rDetalle = record
        cod: integer;
        condicion: char;
    end;

    maestro = file of rAlumno;
    detalle = file of rDetalle;

procedure leer(var det: detalle; var alum: rDetalle);
begin
    if (not EOF(det)) then
        read(det,alum);
    else
        alum.cod := valorAlto;
end;

{programa principal}
var

begin

end.