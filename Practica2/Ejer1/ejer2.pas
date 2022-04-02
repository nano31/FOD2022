program ejer2;
const
    valorAlto = 9999;
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

procedure actualizarMaestro (var fm: maestro; var fd: detalle);
var
    alum: rAlumno;
    mat: rDetalle;
    codAct: integer;
begin
    reset(fm);
    reset(fd);

    leer(fd,mat);
    while (mat.cod <> valorAlto) do begin
        codAct := mat.cod;
        cantFinales:=0;
        cantCursadas:=0;
        while (codAct = mat.cod) do begin
            if ((mat.codicion = 'c') or (mat.condicion = 'C')) then 
                cantCursadas := cantCursadas + 1;
            if ((mat.condicio = 'f') or (mat.codicion = 'F')) then
                cantFinales := cantFinales + 1;
        end;
        read(fm,alum);
        while (alum.cod <> codAct) do begin
            read(fm,alum);
        end;
        alum.cantCursadasA := cantCursadas;
        alumn.cantFinalesA := cantFinales;
        write(fm,alum);
    end;
    close(fm);
    close(fd);
end;

procedure pasarATxt(var mae: maestro);
var
    txt: Text;
    alum: rAlumno;
begin
    rewrite(txt);
    while (not EOF(mae)) do begin
        read(mae,alum);
        if (mae.cantCursadasA = mae.cantFinalesA) then begin
            write(txt,alum);
        end; 
    end;
end;


{programa principal}
var
    mae: maestro;
    det: detalle;
begin
    actualizarMaestro(fm,fd);
    pasarATxt(mae);
end.