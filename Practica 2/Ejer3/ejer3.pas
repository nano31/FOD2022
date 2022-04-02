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
	min.cod:= valorAlto;
	
	for i:= 1 to df do begin
		if (vDet[i].cod <> valorAlto) then begin			
			if (vDet[i].cod < min.cod) then begin
				min := vDet[i];
				indMin := i;
			end;
		end;
	end;
	if (vDet[i].cod <> 0) then begin
		leer(det[indMin], min);
	end;
	
end;

procedure actualizarMaestro (var mae: maestro; min: rDetalle);
var

begin
	while (min.cod <> valorAlto) do begin
		codActual:= min.cod;
		cantVedida := 0;
		while (min.cod <> valorAlto and codActual = min.cod) do begin
			cantVendida := cantVendida + min.cantVendida;
			minimo();
		end; 
		//read(detalle, min);
		while (mae.cod <> codActual) do begin
			read(mae, rMar);
		end;
		write(mae,min);
	end;
end;

{programa principal}
var

begin

end.
