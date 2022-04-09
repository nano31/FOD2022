program ejer9;
const
    valorAlto = 99999;
type
    rElecciones = record
        codProvincia: integer;
        codLocalidad: Integer;
        nroMesa: integer;
        cantVotos: integer;
    end;
    {la info se encuentra ordenada por codProvincia y codLocalidad}
    archivo = file of rElecciones;

procedure leerArchivo (var arch: archivo; var dato: rElecciones);
begin
    if (not EOF(arch)) then
      read(arch, dato)
    else
        dato.codProvincia := valorAlto;
end;

procedure imprimirEnPantalla(var arch: archivo);
var
    codProvAct, codLocAct: Integer;
    totalLoc, totalProv, totalElecciones: integer;
    dato: rElecciones;
begin
    reset(arch);
    
    leer(arch, dato);
    totalElecciones:= 0;
    while (dato.codProvincia <> valorAlto) do begin
        codProvAct := dato.codProvincia;
        totalProv:= 0;
        while (codProvAct = dato.codProvincia) do begin
            codLocAct := dato.codLocalidad;
            WriteLn('Codigo de provincia: ',codProvAct);
            totalLoc:= 0;
            while ((codProvAct = dato.codProvincia) and (codLocAct = dato.codLocalidad)) do begin
                totalLoc:= totalLoc + dato.cantVotos;
                leerArchivo(arch, dato);
            end;
            Writeln('Codigo de Localidad:', codLocAct,' Total Votos: ', totalLoc);
            totalProv:= totalProv + totalLoc;
        end;
        WriteLn('Total votos Provincia: ', totalProv);
        totalElecciones := totalElecciones + totalProv;
    end;
    Writeln('Total de votos en las elecciones: ', totalElecciones);
    close(arch);
end;

{programa principal}
var
    arch: archivo;
begin
    imprimirEnPantalla(arch);
end.