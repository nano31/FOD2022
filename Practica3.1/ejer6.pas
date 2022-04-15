//precondicones --> se tiene un archivo maestro No ordenado
//las prendas a eliminar, debem tener stock en un valor negativo

program ejer6;
const  
    valorAlto = 9999;
type
    cad = string[50];
    rPrenda = record
        cod: integer;
        descripcion: cad;
        color: cad;
        tipo: cad;
        stock: integer;
        precioUnitario: real;
    end;

    maestro = file of rPrenda; //archivo original
    detalle = file of integer; //archivo con los codigos para actualizar el maestro
    nuevoArchivo = file of rPrenda; //archivo compactado

procedure leerMaestro (var arch: maestro; var dato: rPrenda);
begin
    if(not EOF(arch)) then
      read(arch, dato)
    else
        dato.cod := valorAlto;
end;

procedure leerDetalle (var det: detalle; var cod: integer);
begin
    if (not EOF(det)) then
        read(det,cod)
    else
        cod := valorAlto;
end;

procedure eliminarPrendas(var mae:maestro; var det: detalle);
var
    dato: rPrenda;
    cod: integer;
begin
    Reset(mae);
    Reset(det);
    
    leerDetalle(det,cod);
    while (cod <> valorAlto) do begin
        leerMaestro(mae, dato);
        while((dato.cod <> valorAlto) and (dato.cod <> cod)) do begin
            leerMaestro(mae, dato);
        end;
        if(dato.cod = cod) then begin
            dato.stock = dato.stock * -1;
            seek(mae, filepos(mae)-1);
            write(mae, dato);
        end;
        leerDetalle(det, cod);
    end;
    close(mae);
    close(det);
end;



{programa principal}
var

begin

end.