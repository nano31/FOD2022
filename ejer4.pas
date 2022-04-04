program ejer4;
const
    valorAlto = 9999;
    pc = 5;
type
    cad = string[20];
    rMaquinas = record
        cod: integer;
        fecha: cad;
        tiempoSesion: real;
    end;
    rMaestro = record
        cod: integer;
        fecha: cad;
        tiempoTotalSesiones: real;
    end;

    maestro = file of rMaestro;
    detalle = file of rMaquinas;

    vDetalles = array [1..pc] of detalle;
    vRegistros = array [1..pc] of rMaquinas;


procedure leer (var det: detalle; var rDet: rMaquinas);
begin
    if (not EOF(det)) then 
        read(det, rDet)
    else
        rDet.cod := valorAlto;
end;


procedure minimo (var vDet: vDetalles; vReg: vRegistros; var min: rMaquinas);
var
    i, indiceMin: integer;
begin
    indiceMin = 0;
    min.cod:= valorAlto;

    for i:= 1 to pc do begin
        if (vReg[i].cod < min.cod) then begin
            min := vReg[i];
            indiceMin:= i;
        end;
    end;

    if (indiceMin <> 0) then begin
        leer(vDet[indiceMin],vReg[i]);
    end;
end;

procedure crearMaestro();
var

begin

end;


{programa principal}
var

begin
  
end.