{
  
}


program ejer1;
const
	valorAlto = 9999;
type
	rEmple = record
		cod: integer;
		nombre: string[20];
		monto: real;
	end;
	{los archivos creados deben estar ordenados por cod de empleado}
	
	archComisiones = file of rEmple; 
	
procedure imprimirArchivo(var arch: archComisiones);
var
	emple: rEmple;
begin
	while (not EOF(arch)) do begin
		read(arch, emple);
		writeln('Codigo: ', emple.cod,' Nombre: ', emple.nombre,' Monto: ', emple.monto);
	end;
end;

{sirve para controlar el final de archivo detalle y así que no quede ningún registro sin ser leído}
procedure leer(var arch: archComisiones; var e: rEmple);
begin
	if (not EOF(arch)) then begin
		read(arch, e);
	end
	else
		e.cod := valorAlto;
end;

procedure compactar(var fMaestro: archComisiones; var fDetalle: archComisiones);
var
	emple, actEmple: rEmple;
begin
	Assign(fDetalle, 'Archivo-Comisiones');
	Assign(fMaestro, 'Archivo-Compactado');
	Rewrite(fMaestro);
	Reset(fDetalle);
	
	leer(fDetalle, emple);
	while (emple.cod <> valorAlto) do begin
		actEmple.cod := emple.cod;
		actEmple.monto := 0;
		actEmple.nombre := emple.cod;
		while (actEmple.cod = emple.cod ) do begin
			actEmple.monto := actEmple.monto + emple.monto;
			leer(fDetalle, emple);
		end; 
		write(fMaestro, actEmple);
	end;
	close(fDetalle);
	close(fMaestro);
end;

{programa principal}
var
	fc: archComisiones;
	fileName: string[20];
	fMaestro: archComisiones;
BEGIN
	compactar(fMaestro, fc);
	writeln('Archivo no compactado: ');
	imprimirArchivo(fc);
	writeln('Archivo compactado: ');
	imprimirArchivo(fMaestro);
END.

