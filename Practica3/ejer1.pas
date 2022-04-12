{2. Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}

program ejer1;
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
    sim: cad;
    asist: rAsistente;
begin
    sim = "****";
    Reset(arch);
    while (not EOF(arch)) do begin
        read(arch, asist);
        if (asist.nroAsist < 1000) then begin
            
        end;
    end;
end;

{programa principal}
var

begin
  
end.