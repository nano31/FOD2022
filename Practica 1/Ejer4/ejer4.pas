program ejer3;
type
	str20 = String[20];
	str8 = String[8];
	rEmpleado = record
		nombre: str20;
		apellido: str20;
		dni: str8;
		nroEmpleado: integer;
		edad: integer;
	end;
	
	archEmpleados = file of rEmpleado;

{se realiza la lectura de todos los campos de un empleado}
procedure leerEmpleado(var e: rEmpleado);
begin
	writeln('Apellido: ');
	readln(e.apellido);
	if (e.apellido <> 'fin') then begin
		writeln('Nombre: ');
		readln(e.nombre);
		writeln('Nro Empleado: ');
		readln(e.nroEmpleado);
		writeln('Edad: ');
		readln(e.edad);
		writeln('DNI: ');
		readln(e.dni);
	end;
end;
{se crea el archivo que va a guardar a todos los empleados}
procedure crearArchivo(var arch: archEmpleados);
var
	emp: rEmpleado;
	nomFile: str20;
begin
	writeln('Ingrese nombre del archivo: ');
	readln(nomFile);
	Assign(arch, nomFile);
	Rewrite(arch);
	
	leerEmpleado(emp);
	while (emp.apellido <> 'fin') do begin
		write(arch, emp);
		leerEmpleado(emp);
	end;
	close(arch);
end;
 {proceso generico encargado de listar empleados}
procedure listarEmpleado(e: rEmpleado);
begin
	writeln('Apellido: ',e.apellido,' Nombre: ',e.nombre,' Edad: ',e.edad,' DNI: ',e.dni,' Nro Empleado: ', e.nroEmpleado);
	writeln('-----------------------------------------------------------------------------------------------------------');
end;

{proceso encargado de listar a los empleados segun el nombre o apellido ingresado}
procedure listarPorNombreApellido (var arch: archEmpleados);
var
	text: str20;
	emp: rEmpleado;
begin
	writeln('Ingrese el nombre o apellido a listar: ');
	readln(text);
	reset(arch);
	writeln('------ Empleados con nombre o apellido ',text,'------');
	while not eof(arch) do begin
		read(arch, emp);
		if ((emp.nombre = text) or (emp.apellido = text)) then begin
			listarEmpleado(emp);
		end;
	end;
	close(arch);
end;

procedure listarTodos (var arch: archEmpleados);
var
	emp: rEmpleado;
begin
	writeln('------ Lista de empleados ------');
	reset(arch);
	while (not eof(arch)) do begin
		read(arch, emp);
		listarEmpleado(emp);
	end;
	close(arch);
end;

procedure listarMayores(var arch: archEmpleados);
var
	emp: rEmpleado;
begin
	writeln('------ Listado de los empleados mayores de 70 anios prontos a jubilarse ------');
	reset(arch);
	while (not eof(arch)) do begin
		read(arch, emp);
		if (emp.edad > 70) then begin
			listarEmpleado(emp);
		end;
	end;
end;

procedure agregarEmpleados(var arch: archEmpleados);
var
	emp: rEmpleado;
	nomFile: str20;
begin
	writeln('Ingrese el nombre del archivo que desea abrir');
	readln(nomFile);
	Assign(arch, nomFile);
	Reset(arch);
	
	seek(arch, filesize(arch));
	leerEmpleado(emp);
	while (emp.apellido <> 'fin') do begin
		write(arch, emp);
		leerEmpleado(emp);
	end;
	close(arch);
end;

procedure modificarEdad(var arch: archEmpleados);
var
	seguir,encontre: boolean;
	nomFile: str20;
	op: char;
	nroEmp: integer;
	emp: rEmpleado;
begin
	seguir := true;
	encontre := false;
	writeln('Ingrese el nombre del archivo que desea abrir');
	readln(nomFile);
	Assign(arch, nomFile);
	Reset(arch);

	writeln('Ingrese el nombre del empleado a buscar: ');
	readln(nroEmp);
	while ((nroEmp <> -1) and (seguir)) do begin
		while ((not eof(arch)) and (not encontre)) do begin
			read(arch, emp);
			if (emp.nroEmpleado = nroEmp) then begin
				encontre := true;
			end;
		end;
		if (encontre) then begin
			writeln('Se encontro el empleado');
			listarEmpleado(emp);
			writeln('Ingrese la nueva edad: ');
			readln(emp.edad);
			seek(arch, filePos(arch)-1);
			write(arch, emp);
		end
		else
			writeln('No se encotro el empleado');
			seek(arch,0);{resetea la pos inicial}
			encontre:= false;
			
		writeln('Quiere cambiar la edad de otro empleado? (s/n)');
		readln(op);
		case op of
			's': seguir:= true;
			'S': seguir:= true;
			'n': seguir:= false;
			'N': seguir:= false;
		end;
	end;
	close(arch);
end;

procedure exportarTxt(var arch: archEmpleados);
var
	txt: Text;
	txtName, nomFile: str20;
	emp: rEmpleado;
begin
	writeln('Ingrese el nombre del archivo que desea abrir');
	readln(nomFile);
	Assign(arch, nomFile);
	Reset(arch);
	
	writeln('Ingrese el nombre del archivo txt');
	readln(txtName);
	Assign(txt,txtName);
	Rewrite(txt);
	
	while (not eof(arch)) do begin
		read(arch, emp);
		write(txt,'Apellido: ',emp.apellido,' Nombre: ',emp.nombre);
	end;
	close(arch);
	close(txt);
	writeln('El archivo txt se creo correctamente');
end;
	
procedure crearMenu(var arch: archEmpleados);
var
	opc, seguir: char;
begin
	seguir := 's';
	while ((seguir = 's') or (seguir = 'S')) do begin
		writeln('Bienvenidx');
		writeln('Seleccione la opcion que desea ejecutar: ');
		writeln('1. Crear archivo');
		writeln('2. Listar por nombre o apellido');
		writeln('3. Listar todos los empleados');
		writeln('4. Listar empleados mayores de 70 anios');
		writeln('5. Agregar uno o mas empleados');
		writeln('6. Modificar edad de uno o mas empleados');
		writeln('7. Exportar a txt');
		writeln('8. Exportar empleados cuyo dni no fue cargado');
		writeln('9. Salir');
		
		readln(opc);
		case opc of
			'1': crearArchivo(arch);
			'2': listarPorNombreApellido(arch);
			'3': listarTodos(arch);
			'4': listarMayores(arch);
			'5': agregarEmpleados(arch);
			'6': modificarEdad(arch);
			'7': exportarTxt(arch);
			{'8': exportarDniNoCargado(arch);
			'9': halt;}
			else begin
				writeln('Opcion no valida');
			end;
		end;
		writeln('Desea realizar otra operacion? (s/n)');
		readln(seguir);
	end;
	writeln('Ha salido del sistema correctamente');
end;

{programa principal}
var
	fileEmp: archEmpleados;
begin
	crearMenu(fileEmp);
end.
