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

procedure crearMaestro(var mae: maestro; var vDet: vDetalles);
var
    regMae: rMaestro;
    regDet,min: rMaquinas;
    vReg: vRegistros;
    codActual: integer;
    cantTiempo: real;
begin
    Rewrite(mae); {creo el archivo maestro}

    for i:= 1 to pc do begin
        Reset(vDet[i]); {abro los archivos detalle}
        leer(vDet[i],vReg[i]);
    end;

    minimo(vDet, vReg, min);
    while (min.cod <> valorAlto) do begin
        codActual:= min.cod;
        cantTiempo:= 0;
        while (codActual = min.cod) do begin
            cantTiempo:= cantTiempo + min.tiempoSesion;
            minimo(vDet, vReg, min);
        end;

        if (not EOF(mae)) then 
            read(mae, regMae);
        while (regMae.cod <> codActual) do begin
            read(mae,regMae);
        end;
        regMae.tiempoTotalSesiones := regMae.tiempoTotalSesiones + min.tiempoSesion;
        seek(mae, filepos(mae)-1);
        Write(mae, regMae);
    end;
end;


{programa principal}
var
    mae: maestro;
    vDet: vDetalles;
begin
    crearMaestro(mae,vDet);
end.