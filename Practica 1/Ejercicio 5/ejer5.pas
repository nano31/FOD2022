program ejercicio5;
type
	rCelulares = record
		codigo: integer;
		nombre: string[20];
		descripcion: string[20];
		marca: string[20];
		precio: real;
		stockMinimo: integer;
		stockDisponible: integer;
	end;
	
	archCelulares = file of rCelulares;

{Crear nuevo archivo}
procedure crearArchivo(var fc: archCelulares);
var
	txt: Text;
	c: rCelulares;
begin
	Assign(txt, 'celulares.txt');
	Reset(txt);
	Rewrite(fc);
	
	while (not eof(txt)) do begin
		readln(txt,c.codigo, c.precio,c.marca);
		readln(txt,c.stockDisponible, c.stockMinimo,c.descripcion);
		readln(txt,c.nombre);
		write(fc, c);
	end;
	
	close(txt);
	close(fc);
end;

procedure imprimir (c: rCelulares);
begin
	writeln('Nombre:', c.nombre);
	writeln('Marca:', c.marca);
	writeln('Descripcion:', c.descripcion);
	writeln('Precio:', c.precio:0:2);
	writeln('Stock Minimo:', c.stockMinimo);
	writeln('Stock Disponible:', c.stockDisponible);
end;

{listar los celulares que tienen un stock disponible menor que el stock minimo}
procedure listarStockMinimo(var fileCel: archCelulares);
var
	c: rCelulares;
begin
	Reset(fileCel);
	while (not eof(fileCel)) do begin
		read(fileCel, c);
		if (c.stockDisponible < c.stockMinimo) then begin
			imprimir(c);
		end;
	end;
	close(fileCel);
end;

procedure listarPorDescripcion(var fileCel: archCelulares);
var
	c: rCelulares;
	descripcion: string[20];
	encontro: boolean;
begin
	Reset(fileCel);
	encontro:= false;
	writeln('Ingrese la descripcion a buscar: '); readln(descripcion);
	
	writeln('Resultados que coinciden con la busqueda: ');
	while (not eof(fileCel)) do begin
		read(fileCel, c);
		if (pos(descripcion, c.descripcion) <> 0) then begin
			imprimir(c);
			if (not encontro) then
				encontro := true;
		end;
	end;
	if (not encontro) then
		writeln('La descripcion proporcionada, no fue encontrada en el archivo');
	close(fileCel);
end;

{exportar a txt el archivo ya cargado}
procedure exportarAtxt(var fc: archCelulares);
var
	c: rCelulares;
	newFile: Text;
	
begin
	Reset(fc);
	Assign(newFile, 'celulares.txt');
	Rewrite(newFile);
	
	while (not eof(fc)) do begin
		read(fc, c);
		writeln(newFile, 'Codigo: ',c.codigo,' Precio: ', c.precio:0:2,' Marca: ',c.marca);
		writeln(newFile, 'Stock Disponible: ',c.stockDisponible,' Stock Minimo: ', c.stockMinimo,' Descripcion: ',c.descripcion);
		writeln(newFile, 'Nombre: ',c.nombre);
	end;
	
	close(fc);
	close(newFile);
end;

procedure printMenu(var fc: archCelulares);
var
	opt, select: char;
	seguir: boolean;
begin
	seguir:= true;
	writeln('Bienvenido');
	writeln('Seleccione la operacion deseada: ');
	writeln('1. Crear archivo');
	writeln('2. Listar stock minimo');
	writeln('3. Listar por descripcion');
	writeln('4. Exportar a txt');
	writeln('5. Salir');
	while (seguir) do begin
		readln(opt);
		case opt of
			'1': crearArchivo(fc);
			'2': listarStockMinimo(fc);
			'3': listarPorDescripcion(fc);
			'4': exportarAtxt(fc);
			'5': halt;
		end;
		
		writeln('Desea realizar otra operacion? (s/n)'); readln(select);
		case select of
			's': seguir:= true;
			'S': seguir:= true;
			'n': seguir:= false;
			'N': seguir:= false;
		end;
	end;	
end;


{programa principal}
var
	fileCelulares: archCelulares;
	fileName: string[20];
begin
	writeln('Ingrese el nombre del archivo: '); readln(fileName);
	Assign(fileCelulares, fileName);
	printMenu(fileCelulares);
end.
