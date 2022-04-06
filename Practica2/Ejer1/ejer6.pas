program ejer6;
const
    valorAlto = 9999;
    df = 10;
type
    cad = string[20];
    rDetalle = record
        codLocalidad: integer;
        codCepa: integer;
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;
    detalle = file of rDetalle;

    rMaestro = record
        codLocalidad: integer;
        nomLocalidad: cad;
        codCepa: integer;
        nomCepa: cad;
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;
    maestro = file of rMaestro;

    vecDetalles = array [1..df] of detalle;
    vecRegistros = array [1..df] of rDetalle;

procedure leerDetalle (var det: detalle; var dato: rDetalle);
begin
    if (not EOF(det)) then
        read(det, dato)
    else
        dato.codLocalidad := valorAlto;
end;

procedure minimo (var vDet: vecDetalles; var vReg:vecRegistros; var min:rDetalle);
var
    i, indiceMin : integer;
begin
    indiceMin:=0;
    min.codLocalidad:= valorAlto;
    min.codCepa:= valorAlto;
    for i:= 1 to df do begin
        if (vReg[i].codLocalidad < min.codLocalidad) then begin
            if (vReg[i].codCepa < min.codCepa) then begin
                min:= vReg[i];
                indiceMin := i;
            end;
        end;
    end;
    if (indiceMin <> 0) then
      leerDetalle(vDet[indiceMin], vReg[indiceMin]);
end;

procedure actualizarMaestro (var mae: maestro; var vDet: vecDetalles);
var

begin

end;

{programa principal}
var

begin
  
end.