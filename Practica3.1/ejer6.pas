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

procedure leer (var arch: fileMaestro; var dato: rPrenda);
begin
    if(not EOF(arch)) then
      read(arch, dato)
    else
        dato.cod := valorAlto;
end;



{programa principal}
var

begin

end.