program ejer8;
const
    anioReg = 2020; 
    valorAlto = 9999;
type
    cad = String[20];
    rCliente = record
        cod: integer;
        nombre: cad;
        apellido: cad;
    end;
    rMaestro = record
        datosCliente: rCliente;
        anio: 2020..2022;
        mes: cad;
        dia: 1..31;
        montoCompra: real;
    end;
    maestro = file of rMaestro;

procedure leer(var mae: rMaestro; var dato: rVentas);
begin
    if (not EOF(mae)) then
      read(mae, dato)
    else
        dato.datosCliente.cod := valorAlto;
end;

procedure actualizarMaestro(var mae: maestro);
var
    dato: rMaestro;
    mesAct, codAct, anioAct: integer;
    totalMensual, totalAnual,total: real;
begin
    reset(mae);

    leer(mae,dato);
    while (dato.datosCliente.cod <> valorAlto) do begin
        codAct := dato.datosCliente.cod;
        anioAct := dato.anio;
        
        totalAnual := 0;
        while (dato.anio = anioAct) do begin
            totalMensual:= 0;
            mesAct := dato.mes;
            while ((dato.datosCliente.cod = codAct) and (dato.mes = mesAct) and (dato.anio = anioAct)) do begin
                write('Mes: ', mesAct);
                totalMensual:= totalMensual + dato.montoCompra;
                leer(mae, dato);
            end;
            Write('Total mes: ', totalMensual:2:2);
            totalAnual := totalAnual + totalMensual;
        end;
        writeln('Total anio: ', totalAnual:2:2);
        total := total + totalAnual;
    end;
    WriteLn('Total de la empresa: ', total);
    close(mae);
end;

{programa principal}
var
    mae: maestro;
begin
    actualizarMaestro(mae);
end.