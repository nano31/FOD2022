program ejer7;
const
    valorAlto = 9999;
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

procedure leer (var det: detalle;var dato: rDetalle);
begin
    if (not EOF(det)) then
        read(det,dato)
    else
        dato.cod:= valorAlto;
end;

procedure actualizarMaestro (var mae: maestro; var det: detalle);
var
    aux, rDet: rDetalle;
begin
    Reset(mae);
    Reset(det);
    leer(det, rDet);
    while (rDet.cod <> valorAlto) do begin
        aux.cod := rDet.cod;
        aux.cantVendida := 0;
        while (rDet.cod = aux.cod) do begin
            aux.cantVendida := aux.cantVendida + rDet.cantVendida;
            leer(det,rDet);
        end;
        read(mae, rMae);
        while (rMae.cod <> aux.cod) do 
            read(mae,rMae);
        rMae.stockAct := rMae.stockAct - aux.cantVendida;
    end;
end;

{programa principal}
var

begin
  
end.