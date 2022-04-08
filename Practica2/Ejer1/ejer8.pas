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

    rVentas = record
        datosCliente: rCliente;
        totalMensual: real;
        totalAnual: real;
    end;
    detalle = file of rVentas;

    rMaestro = record
        datosCliente: rCliente;
        anio: 2020..2022;
        mes: cad;
        dia: 1..31;
        montoCompra: real;
    end;

procedure leer(var mae: rMaestro; var dato: rVentas);
begin
    if (not EOF(mae)) then
      read(mae, dato)
    else
        dato.datosCliente.cod := valorAlto;
end;

procedure actualizarMaestro();
var
    dato: rMaestro;
    mesAct, codAct, anioAct: integer;
    totalMensual, totalAnual: real;
begin
    reset(det);
    reset(mae);

    leer(mae,dato);
    while (dato.datosCliente.cod <> valorAlto) do begin
        codAct := dato.datosCliente.cod;
        anioAct := dato.anio;
        
        totalAnual := 0;
        while (dato.anio = anioAct) do begin
            totalMensual:= 0;
            mesAct := dato.mes;
            while ((dato.mes = mesAct) and (dato.anio = anioAct)) do begin
                write('Mes: ', mesAct);
                totalMensual:= totalMensual + dato.montoCompra;
                leer(mae, dato);
            end;
            Write('Total mes: ', totalMensual);
            totalAnual := totalAnual + totalMensual;
        end;



    end;
end;

{programa principal}
var

begin

end.