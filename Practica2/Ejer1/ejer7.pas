program ejer7;
const

type
    cad = string[20];
    rMaestro = record
        cod: integer;
        nomComercial: cad;
        precio: real;
        stockAct: integer;
        stockMin : integer;
    end;
    maestro = file of rMaestro;

    rDetalle = record
        cod: integer;
        cantVendida: integer;
    end;
    detalle = file of rDetalle;

{programa principal}
var

begin
  
end.