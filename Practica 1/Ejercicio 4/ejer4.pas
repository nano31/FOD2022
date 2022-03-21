{
   ejer4.pas
   
   Copyright 2022 zompi <zompi@DESKTOP-SJ40988>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


program ejer4;
type
	rEmpleado = record
		nombre: String[20];
		apellido: String[20];
		dni: String[8];
		edad: integer;
		nroEmpleado: integer;
	end;
	
	fileEmp = file of rEmpleado;
	
procedure leerEmpleado (var e: rEmpleado);
begin
	writeln('Apellido: ');
	readln(e.apellido);
	if (e.apellido <> 'fin') then begin
		writeln('Nombre: '); readln(e.nombre);
		writeln('Nro Empleado: '); readln(e.nroEmpleado);
		writeln('Edad: '); readln(e.edad);
		writeln('DNI: '); readln(e.dni);
	end;
end;

procedure newFile (var fEmp: fileEmp);
var
	emp: rEmpleado;
	fileName: string[20];
begin
	writeln('Ingrese el nombre del archivo: '); readln(fileName);
	Assign(fEmp, fileName);
	Rewrite(fEmp);
	leerEmpleado(emp);
	while (emp.apellido <> 'fin') do begin
		write(fEmp, emp);
		leerEmpleado(emp);
	end;
	close(fEmp);
end;

{muestra todos los empleados en pantalla}
procedure listarEmpleados(var fe: fileEmp);
var
	e: rEmpleado;
begin
	Reset(fe);
	while (not eof(fe)) do begin
		read(fe, e);
		writeln(' Apellido: ', e.apellido,' Nombre: ',e.nombre,' Edad: ', e.edad,' Dni: ',e.dni,' Nro Empleado: ',e.nroEmpleado);
		writeln('------------------------------------------------------------------------------------------------------------');
	end;
	close(fe);
end;

{agrega empleados al archivo}
procedure addEmpleados (var fEmp: fileEmp);
var
	emp: rEmpleado;
	fName: string[20];
begin
	writeln('Ingrese el nombre del archivo que desea abrir: '); readln(fName);
	Assign(fEmp, fName);
	Reset(fEmp);
	seek(fEmp, FileSize(fEmp));
	leerEmpleado(emp);
	while(emp.apellido <> 'fin') do begin
		write(fEmp, emp);
		leerEmpleado(emp);
	end;
	close(fEmp);
	readln();
end;

{modifica la edad de los empleados deseados}
procedure modificarEdad (var fEmp: fileEmp);
var
	emp: rEmpleado;
	opt: char;
	nroBuscado,nuevaEdad: integer;
	fileName: string[20];
	seguir: boolean;
begin
	seguir:= true;
	writeln('Ingrese el nombre del archivo que desea abrir: '); readln(fileName);
	Assign(fEmp, fileName);
	Reset(fEmp);
	
	while (seguir) do begin
		writeln('Ingrese el nro de empleado al cual desea modificarle la edad: '); readln(nroBuscado);
		while ((not eof(fEmp)) and (not encontre)) do begin
			read(fEmp, emp);
			if (emp.nroEmpleado = nroBuscado) then
				encontre := true;
			end;
			if (encontre) then begin
				writeln('Ingrese la nueva edad: ');
				readln(nuevaEdad);
				emp.edad := nuevaEdad;
				seek(fEmp, filePos(fEmp)-1);
				write(fEmp, emp);
				writeln('La edad del empleado nro ',nroBuscado,' se modifico correctamente');
			end
			else
				writeln('El nro de empleado ',nroBuscado,' no fue encontrado dentro del archivo');
					
		writeln('Quiere modificar la edad de otro empleado? '); readln(opt);
		case opt of
			's': seguir:= true;
			'S': seguir:= true;
			'n': seguir:= false;
			'N': seguir:= false;
		end;
	end;
	close(fEmp);
end;

{exporta el archivo a un documento txt}
procedure exportToTxt (var fEmp: fileEmp);
var
	txt: Text;
	txtName, fileName: string[20];
	emp: rEmpleado;
begin
	writeln('Ingrese el nombre del archivo de texto: '); readln(txtName);
	Assign(txt, txtName);
	Rewrite(txt);
	
	writeln('Ingrese el nombre del archivo a exportar: '); readln(fileName);
	Assign(fEmp, fileName);
	Reset(fEmp);
	
	while (not eof(fEmp)) do begin
		read(fEmp, emp);
		write(txt, 'Apellido: ',emp.apellido,' Nombre: ',emp.nombre,' Edad: ',emp.edad,' Dni: ',emp.dni,' Nro Empleado: ',emp.nroEmpleado);
		writeln();
	end;
	close(fEmp);
	close(txt);
end;

procedure exportarSinDNI(var fe: fileEmple);
var
	txt: Text;
	nomTxt, fileName: string[20];
	e: rEmpleado;
begin
	writeln('Ingrese nombre del nuevo archivo: '); readln(nomTxt);
	Assign(txt, nomTxt);
	Rewrite(txt);
	
	writeln('Ingrese el nombre del archivo que dese abrir: '); readln(fileName);
	Assign(fe, fileName);
	Reset(fe);
	
	while (not eof(fe)) do begin
		read(fe, e);
		if (e.dni = 00) then begin
			write(txt, 'Apellido: ',e.apellido,' Nombre: ',e.nombre,' Edad: ',e.edad,' Dni: ',e.dni,' Nro Empleado: ',e.nroEmpleado);
		end;
	end;
	close(fe);
	close(txt);
end;


{programa principal}
var
	fileEmpleados: fileEmp;
begin
	newFile(fileEmpleados);
	addEmpleados(fileEmpleados);
	listarEmpleados(fileEmpleados);
	modificarEdad(fileEmpleados);
	listarEmpleados(fileEmpleados);
	exportToTxt(fileEmpleados);
end.

