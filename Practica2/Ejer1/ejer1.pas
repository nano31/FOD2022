{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez}


program ejer1;
const
    valorAlto = 9999;
type
    rEmpleado = record
        cod: integer;
        nombre: string[20];
        monto: real;
    end;

    archEmpleado = file of rEmpleado; //archivo maestro
    archComisiones = file of rEmpleado; //archivo detalle

procedure leer (var fc: archComisiones; var emp: rEmpleado);
begin
    if (not EOF(arch)) then 
        read(arch, emp);
    else
        emp.cod = valorAlto;
end;


procedure compactador(var fileEmple: archEmpleado; var fileCom: archComisiones);
var
    emple, compacto: rEmpleado;
    codAct: integer;
begin
    rewrite(fileEmple);
    reset(fileCom);
    leer(fileCom,emple);
    while (emple.cod <> valorAlto) do begin
        codAct := emple.cod;
        com.montoComision:= 0;
        while (emple.cod = codAct) do begin
            compacto.monto:= compacto.monto + emple.montoComision; //acumulo los montos
            leer(fileCom,emple); //emple lo uso como lector para el registro de comisiones
        end;
        compacto.cod := codAct;
        compacto.nombre := emple.nombre;
        write(fileEmple,compacto); //escribo el dato en el maestro
    end;
    close(fileEmple);
    close(fileCom);
end;

var
    fe: archEmpleado;
    fc: archComisiones;
begin
    compactador(fe,fc);
end.