program ejer3;
const
	valorAlto = 9999;
	df = 30;
type 
	str20 = String[20];
	rProd = record
		cod: integer;
		nombre: str20;
		descripcion: str20;
		stockDisp: integer;
		stockMin: integer;
		precio: real;
	end;
	
	rDetalle = record
		cod: integer;
		cantVendida: integer;
	end;
	

	
	maestro = file of rProd;
	detalle = file of rDetalle;
	
	vDetalles = array[1..df] of detalle;
	arDet = array [1..df] of rDetalle;
	
procedure leer(var det: detalle; var dato: rdetalle); //proceso para leer registros proporcionado por la cátedra
begin
	if (not EOF(det)) then 
		read(det, dato)
	else
		dato.cod := valorAlto;
end;

procedure minimo (var vDet: vDetalles; var det: arDet; var min: rDetalle);
var
	i, indMin: integer;
begin
	indMin := 0;
	for i:= 1 to df do begin
		leer(det[i],registro);
		acumulador[i] := registro;
		if (acumulador[i].cod < min.cod) then begin
			min := det[i];
			indMin := i;
		end;
	end;
	leer(det[indMin], min);
	
end;

procedure actualizarMaestro (var mae: maestro; min: rDetalle);
var

begin
	minimo();
	while (min.cod <> valorAlto) do begin
		codActual:= min.cod;
		cantVedida := 0;
		while (min.cod <> valorAlto and codActual = min.cod) do begin
			cantVendida := cantVendida + min.cantVendida;
			minimo();
		end; 

		read(mae, rMae);
		while (mae.cod <> codActual) do begin
			read(mae, rMae);
		end;
		rMae.stockDisp := rMae.stockDisp - cantVendida;

		seek(mae,filePos(mae)-1);
		write(mae,min);
	end;
end;

{programa principal}
var

begin

end.
