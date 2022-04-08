program ejer8;
const
    anioReg = 2020; 
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
        anio: anioReg;
        mes: cad;
        dia: 1..31;
        montoCompra: real;
    end;


{programa principal}
var

begin

end.