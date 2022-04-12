program ejer10;
const
    valorAlto = 9999;
type

    montos = array [1..15] of real; {monto por categorias}
    rEmpleado = record
        departamento: integer;
        division: integer;
        nroEmpleado: integer;
        categoria: integer; 
        monto: montos;
        cantHorasExtras: integer;
    end;

    archEmpleados = file of rEmpleado;


procedure leerEmpleado (var arch: archEmpleados; var dato: rEmpleado);
begin
    if (not EOF(arch)) then
      read(arch,dato)
    else
        dato.departamento := valorAlto;
end;

{archivo ordenado por: departamento, division, codEmpleado}
procedure imprimirEmpleados (var arhcEmple: archEmpleados);
var
    dato: rEmpleado;
    depAtc,divAct,codAct : integer;
    totalCantHoras, totalHorasDivision,cantHorasDepa: integer;
    montoTotalPorDiv,montoTotalEmp, montoDepar: real;
begin
    reset(archEmple);

    leerEmpleado(arhcEmple, dato);
    while (dato.departamento <> valorAlto) do begin
        depAtc:= dato.departamento;
        montoDepar:= 0;
        cantHorasDepa:=0;
        while (depAtc = dato.departamento) do begin
            divAct := dato.division;
            totalHorasDivision := 0;
            montoTotalPorDiv:= 0;
            WriteLn('Nro de Departamento: ', depAtc);
            while ((depAtc = dato.departamento) and (divAct = dato.division)) do begin
                totalCantHoras:= 0;
                codAct := dato.nroEmpleado;
                montoTotalEmp:= 0;
                WriteLn('Nro de Divisio: ', divAct);
                while ((depAtc = dato.departamento) and (divAct = dato.division) and (codAct = dato.nroEmpleado)) do begin
                    totalCantHoras := totalCantHoras + dato.cantHorasExtras;
                    montoTotalEmp := montoTotalEmp + dato.categoria;
                end;
                WriteLn('Nro de Empleado: ', codAct,' Horas Extras Realizadas: ', totalCantHoras);
                totalHorasDivision := totalHorasDivision + totalCantHoras;
                montoTotalPorDiv:= montoTotalPorDiv + montoTotalEmp;
            end;
            cantHorasDepa:= cantHorasDepa + totalHorasDivision;
            montoDepar := montoDepar + montoTotalPorDiv;
            WriteLn('Total horas hechas por la division ',divAct,' = ',totalHorasDivision);
            WriteLn('Monto total de la division ',divAct, ' = ',montoTotalPorDiv);
        end;
        WriteLn('Horas hechas por el departamento ',depAtc, ' = ', cantHorasDepa);
        WriteLn('Monto total del departamento: ',depAtc, ' = ',montoDepar);
    end;
end;

{programa principal}
var

begin

end.