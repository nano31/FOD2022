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
        if (distro.nombre = nombreDistro) then
            encontre:= true;
    end;
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
            WriteLn('No hay espacio dentro del archivo');
    end
    else
        WriteLn('La distribucion ingresada ya existe en el archivo');
end;

procedure bajaDistribucion(var mae: maestro; nombreDistro: cad);
//realiza una baja en el archivo, es decir,
//elimina logicamente una distro
//pra la baja utilizo el campo cantidad de desarrolladores
var

begin

end;


 {programa principal}
 var

 begin

 end.