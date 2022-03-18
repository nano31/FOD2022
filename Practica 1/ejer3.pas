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
		writeln('5. Salir');
		
		readln(opc);
		case opc of
			'1': crearArchivo(arch);
			'2': listarPorNombreApellido(arch);
			'3': listarTodos(arch);
			'4': listarMayores(arch);
			'5': halt;
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
