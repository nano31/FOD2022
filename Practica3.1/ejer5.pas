program ejer5;
const
    valorAlto = 999;
type
    reg_flor = record
        nombre: string[45];
        codigo: integer;
    end;

    archFlores = file of reg_flor;

procedure leer (var arch: archFlores; var flor: reg_flor);
begin
    if (not EOF(arch)) then
        read(arch, flor)
    else
        flor.codigo := valorAlto;
end;

procedure agregarFlor(var a: archFlores; nombre: string[45]; codigo: integer);
var
    indice: integer;
    cabecera,flor: reg_flor;
begin
    Reset(arch);
    flor.nombre := nombre;
    flor.codigo := codigo;
    leer(arch, cabecera); //leo el registro cabecera
    if (cabecera.codigo < 0) then begin
        seek(arch, cabecera.codigo*-1);
        read(arch, cabecera);
        seek(arch, filepos(arch)-1);
        write(arch, flor);
        seek(arch,0);
        write(arch, cabecera);
    end
    else begin
        FileSize(arch);
        write(arch, flor);
    end;
    close(arch);
end;

procedure leerFlor(var f: reg_flor);
begin
    WriteLn('Codigo: '); ReadLn(f.codigo);
    if (f.codigo <> -1) then begin
        WriteLn('Nombre: '); ReadLn(f.nombre);
    end;
end;

procedure crearArchivo(var arch: archFlores);
var
    cabecera, flor: reg_flor;
begin
    Rewrite(arch);
    cabecera.codigo:= 0; //inicializo el reg cabecera, lugar 0 del archivo
    write(arch, cabecera);

    leerFlor(flor);
    while (flor.codigo <> -1) do begin
        Write(arch, flor);
        leerFlor(flor);  
    end;
    Close(arch);
end;

procedure listarArchivo (var arch: archFlores);
var
    flor: reg_flor;
begin
    Reset(arch);
    
    leer(arch, flor);
    while (flor.codigo <> valorAlto) do begin
        if (flor.codigo > 0) then begin
            WriteLn('Codigo: ', flor.codigo);
            WriteLn('Nombre: ', flor.nombre);
        end;
        leer(arch, flor);
    end;
    close(arch);
end;

procedure eliminarFlor(var arch: archFlores; flor: reg_flor);
var
    aux, cabecera: reg_flor;
begin
    Reset(arch);
    leer(arch,aux);
    cabecera.codigo := aux.codigo;

    while ((aux.codigo <> valorAlto) and (aux.codigo <> flor.codigo)) do begin
        leer(arch, aux);
    end;
    if (aux.codigo <> valorAlto) then begin
        aux.codigo := cabecera.codigo;
        cabecera.codigo := (arch, FilePos(arch)*-1);
        write(arch, aux);
        aux.codigo := cabecera.codigo;
        Seek(arch,0);
        write(arch, aux);
    end;
    close(arch);
end;

{programa principal}
var
    arch: archFlores;
    nom: stringp[45];
    cod: integer;
    f: reg_flor;
begin
    crearArchivo(arch);
    listarArchivo(arch);

    WriteLn('Ingrese los datos de la nueva flor');
    WriteLn('Codigo: '); ReadLn(cod);
    WriteLn('Nombre: '); ReadLn(nom);

    agregarFlor(arch, nom, cod);
    listarArchivo(arch);

    WriteLn('Ingrese los datos de la flor que desea eliminar');
    WriteLn('Codigo: '); Readln(f.codigo);
    WriteLn('Nombre: '); ReadLn(f.nombre);

    eliminarFlor(arch, f);
    listarArchivo(arch);
end.