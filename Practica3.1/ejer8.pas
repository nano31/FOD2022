 program ejer8;
 const

 type
    cad = String[50];
    rDistro = record
        nombre: cad;
        anioLanzamiento: integer;
        nroVersionKernel: cad;
        cantDesarrolladores: integer;
        descripcion: cad;
    end;

    maestro = file of rDistro;


function existeDistribucion(nombreDistro: cad; var arch: maestro): boolean; 
//devuelve true o false dependiendo si la distro 
//buscada existe o no
var
    distro: rDistro;
    encontre: Boolean;
begin
    Reset(arch);
    encontre:= false;

    while (not EOF(arch) and not encontre) do begin
        leer(arch, distro);
        if ((distro.cantDesarrolladores > 0)and (distro.nombre = nombreDistro)) then
            encontre:= true;
    end;
    existeDistribucion:= encontre;
end;


procedure leerDistro(var distro: rDistro);
begin
    WriteLn('Cant Desrrolladores: '); ReadLn(distro.cantDesarrolladores);
    if (distro.cantDesarrolladores <> 0) then begin
        WriteLn('Nombre: '); ReadLn(distro.nombre);
        WriteLn('Anio Lanzamiento: '); ReadLn(distro.anioLanzamiento);
        WriteLn('Nro Version de Kernel: '); ReadLn(distro.nroVersionKernel);
        WriteLn('Descripcion: '); ReadLn(distro.descripcion);
    end;
end;

procedure generarArchivo(var mae: maestro);
var
    distro: rDistro;
begin
    Rewrite(mae);
    leerDistro(distro);
    while (not existeDistribucion(distro.nombre) and distro.cantDesarrolladores <> 0) do begin
        Write(mae, distro);
        leerDistro(distro);
    end;
    Close(mae);
end;

procedure altaDistribucion(var mae: maestro);
//realiza un alta en el archivo, es decir,
//agrega una nueva distribucion al mismo
var
    nuevaDistro, cabecera: rDistro;
begin
    Reset(mae);
    leerDistro(nuevaDistro);

    if(not existeDistribucion) then begin
        leerArch(arch, cabecera);
        if (cabecera.cantDesarrolladores < 0) then begin
            seek(arch, cabecera.cantDesarrolladores*-1);
            read(arch, cabecera);
            seek(arch, filePos(arch)-1);
            write(arch,nuevaDistro);
            seek(arch,0);
            write(arch,cabecera);
        end
        else
            WriteLn('No hay espacio, se agrega al final del archivo');
            Seek(arch, FileSize(arch));
            write(arch, nuevaDistro);
    end
    else
        WriteLn('La distribucion ingresada ya existe en el archivo');
end;

procedure bajaDistribucion(var mae: maestro; nombreDistro: cad);
//realiza una baja en el archivo, es decir,
//elimina logicamente una distro
//pra la baja utilizo el campo cantidad de desarrolladores
var
    encontre: boolean;
begin
    Reset(mae);
    read(mae, cabecera);
    read(mae, distro);
    if (existeDistribucion(nombreDistro)) then begin
        while(not EOF(mae) and (distro.nombre <> nombreDistro)) do begin
            read(mae, distro);
        end;
        if (distro.nombre = nombreDistro) then begin
            distro.cantDesarrolladores:= distro.cantDesarrolladores*-1;
            seek(mae, FilePos(arch)-1);
            write(mae,cabecera);
            seek(mae, 0);
            write(mae, distro);
        end;
    end
    else
        WriteLn('La distro buscada no se encutra en el archivo');
end;

{programa principal}
var
    fileMaster: maestro;
    nombreDistribucion: cad;
begin
    generarArchivo(fileMaster);
    altaDistribucion(fileMaster);
    WriteLn('Ingrese el nombre de la distribucion que desea eliminar: ');
    ReadLn(nombreDistribucion);
    bajaDistribucion(fileMaster, nombreDistribucion);

end.