{
--> se requiere actualizar un archivo maestro con dos archivos detalles
--> todos los archivos están ordenados por nombre de provincia
--> en los archivos detalle pueden venir 0,1 o más reg. por provincia
}


program ejer11;
const
    valorFinal = 'ZZZZ';
type
    cad = string[50];
    rMaestro = record
        nomProvincia: cad;
        cantPerAlfabetizadas: integer;
        totalEncuestados: integer;
    end;
    maestro = file of rMaestro;

    rDetalle = record
        nomProvincia: cad;
        codLocalidad: integer;
        cantPerAlfabetizadas: integer;
        cantEncuestados: integer;
    end;
    detalle = file of rDetalle;

procedure leerDetalle (var det: detalle; var dato: rDetalle);
begin
    if(not EOF(det)) then
      read(det,dato)
    else
        dato.nomProvincia:= valorFinal;
end;

procedure buscarMinimo(var det1, det2: detalle; var min: minimo);
var

begin
    
end;

procedure actualizarMaestro();
var

begin

end;


{programa principal}
var

begin

end.