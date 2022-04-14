
program ej2;
const

type
    cad = string[20];
    rAsistente = record
        nroAsist: integer;
        apellido: cad;
        nombre: cad;
        email: cad;
        telefono: cad;
        dni: cad;
    end;
    archAsistentes = file of rAsistente;

procedure generarArchivo(var arch: archAsistentes);
    procedure leerAsistente (var a: rAsistente);
    begin
        writeln('Nro de asistente: '); readln(a.nroAsist);
        if (a.nroAsist <> -1) then begin
            writeln('Apellido: '); readln(a.apellido);
            writeln('Nombre: '); readln(a.nombre);
            writeln('Email: '); readln(a.email);
            writeln('Telefono: '); readln(a.telefono);
            writeln('DNI: '); readln(a.dni);
        end;
    end;

var
    asist: rAsistente;
begin
    Assign(arch, 'asistentes.txt');
    Rewrite(arch);
    leerAsistente(asist);
    while (asist.nroAsist <> -1) do begin
        write(arch, asist);
        leerAsistente(asist);
    end;
    close(arch);
end;

procedure bajaLogicaDelArchivo (var arch: archAsistentes);
var
    asist,sim: rAsistente;
begin
    sim.nroAsist:= 0;
    sim.apellido:= '***';
    sim.nombre:= '***';
    sim.email:= '***';
    sim.telefono:= '***';
    sim.dni:= '***';
    Reset(arch);
    while (not EOF(arch)) do begin
        read(arch, asist);
        if (asist.nroAsist < 1000) then begin
            asist := sim;
        end;
        seek(arch, filePos(arch)-1);
        write(arch, asist);
    end;
    close(arch);
end;

{programa principal}
var

begin
  
end.