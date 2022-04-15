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

function existeDistribucion(nombreDistro: cad): boolean; 
//devuelve true o false dependiendo si la distro 
//buscada existe o no
var

begin

end;

procedure altaDistribucion(var mae: maestro);
//realiza un alta en el archivo, es decir,
//agrega una nueva distribucion al mismo
var

begin

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