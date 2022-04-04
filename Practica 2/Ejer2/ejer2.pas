{
2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).

Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:

a. Actualizar el archivo maestro de la siguiente manera:

i. Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.

ii. Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.

b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.

NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
}

program ejer2;
const
	valorAlto = 9999;
type
	rAlumno = record
		cod: integer;
		apellido: string[20];
		nombre: string[20];
		cantMateriasAprobadas: integer;
		cantFinalesAprobados: integer;
	end;
	
	rDetalle = record
		cod: integer;
		aprobo: char; {c: si aprobo cursada; f: si aprobo final}
	end;
	
	maestro = file of rAlumno;
	detalle = file of rDetalle;

procedure leer(var arch: detalle);	
var
	regDetalle: rDetalle;
begin
	if (not EOF(arch)) then begin
		read(detalle, regDetalle);
	end
	else
		regDetalle.cod:= valorAlto;
end;	
procedure actualizarMaestro(var mae: maestro; var det: detalle);	
var
	alumno,aux : rAlumno;
	alumnAct: rDetalle;
begin
	Reset(mae);
	Reset(det);
	
	read(mae, alumno);
	leer(det, alumnAct);
	while (alumnAct.cod <> valorAlto) do begin
		aux.cod := alumnAct.cod;
		while (alumnAct.cod = aux) do begin
			if ((alumnAct.aprobo = 'C') or (alumnAct.aprobo = 'c')) then 
				aux.cantMateriasAprobadas := aux.cantMateriasAprobadas + 1
			else if ((alumnAct.aprobo = 'F') or (alumnAct.aprobo = 'f')) then begin
				aux.cantFinalesAprobados := aux.cantFinalesAprobados + 1;
			leer(det, alumnAct);
		end;
		while (alumno.cod <> aux ) do begin
			read(mae, alumno);
		end;
		write(mae, aux);
	end;
	close(det);
	close(mae);
end;

procedure masDeCuatroAprobadasTxt(var arch: maestro);
var
	alum: rAlumno;
	txt: Text;
begin
	Assign(txt, 'Mas-de-cuatro-aprobadas');
	while (not EOF(arch)) do begin
		read(arch, alum);
		if ((alum.cantMateriasAprobadas >= 4)and (alumn.cantMateriasAprobadas = alumn.cantFinalesAprobados)) then begin
					write(txt,'Codigo: ',alum.cod,' Apellido: ',alum.apellido,' Nombre: ', alum.nombre,
			' C Aprobadas: ', alum.cantMateriasAprobadas,' F Aprobados: ', alum.cantFinalesAprobados);
		end;
	end;
end;

{programa principal}
var
	fMae: maestro;
	fDet: detalle;
BEGIN
	actualizarMaestro(fMae, fDet);
	masDeCuatroAprobadasTxt(fMae);
END.

