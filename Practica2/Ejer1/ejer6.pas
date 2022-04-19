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
     i: integer;
     min,aux: rDetalle;
     vReg: vecRegistros;
begin
    for i:= 1 to df do begin
        reset(vDet[i]);
        leerDetalle(vDet[i], vReg[i]);     
    end;

    minimo(vDet,vReg,min);
    while (min.codLocalidad <> valorAlto) do begin
        aux.codLocalidad:= min.codLocalidad;
        aux.codCepa:= min.codCepa;
        while ((aux.codLocalidad = min.codLocalidad) and (aux.codCepa = aux.codCepa)) do begin
            aux.cantActivos := aux.cantActivos + min.cantActivos;
            aux.cantNuevos := aux.cantNuevos + min.cantNuevos;
            aux.cantRecuperados := aux.cantRecuperados + min.cantRecuperados;
            aux.cantFallecidos := aux.cantFallecidos + min.cantFallecidos;
            minimo(vDet,vReg,min);
        end;
        read(mae, rMae);
        
        while ((not EOF(mae)) and ((rMae.codLocalidad <> aux.codLocalidad) or (rMae.codCepa <> aux.codCepa))) do 
            read(mar, rMae);

        rMae.codLocalidad:= aux.codLocalidad;
        rMae.codCepa:= aux.codCepa;
        rMae.cantActivos:= aux.cantActivos;
        rMae.cantNuevos:= aux.cantNuevos;
        rMae.cantRecuperados:= aux.cantRecuperados;
        rMae.cantFallecidos:= aux.cantFallecidos;

        seek(mae, filepos(mae)-1);
        write(mae, rMae);
    end;
    close(mae); {cierro el archivo maestro}

    for i:= 1 to df do begin {cierro los archivos detalle}
        close(vDet[i]);  
    end;
end;

procedure informarLocalidades (var mae: maestro);
var
    rMae: rMaestro;
begin
    Reset(mae);
    while (not EOF(mae)) do begin
        read(mae, rMae);
        if (rMae.cantActivos > 50) then begin
            Write('La localidad: ',rMae.nomLocalidad,' con codigo ',rMae.codLocalidad,'
            ' tiene mas de 50 casos activos actualmente');
        end; 
    end;
    close(mae);
end;

{programa principal}
var
    mae: maestro;
    vDetalles: vecDetalles;
begin
    actualizarMaestro(mae, vDetalles);
    informarLocalidades(mae);
end.