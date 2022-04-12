{3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.
}

program ejer3;
const
    valorAlto = 9999;
type
    cad = string[20];
    rNovela = record
        cod: integer;
        genero: cad;
        nombre: cad;
        duracion: integer;
        director: cad;
        precio: real;
    end;

    archNovelas = file of rNovela;

procedure leer(var fn: archNovelas; var n: rNovela);
begin
    if (not EOF(fn)) then 
        read(arch, n)
    else
        n.cod:= valorAlto;
end;

procedure generarArchivo (var fn: archNovelas); {genera el arch de novelas con la cabecera inicializada en 0}
var
    cabecera: rNovela;
begin
    cabecera.cod := 0;
    reset(fn);
    write(fn, cabecera);
    close(fn);
end;

procedure leerNovela(var n: rNovela);
begin
    WriteLn('Cod: '); ReadLn(n.cod);
    WriteLn('Genero: '); ReadLn(n.genero);
    WriteLn('Nombre: '); ReadLn(n.nombre);
    WriteLn('Duracion: '); ReadLn(n.duracion);
    WriteLn('Director: '); ReadLn(n.director);
    WriteLn('Precio: '); ReadLn(n.precio);  
end;


procedure cargarArchivo(var arch: archNovelas);
var
    dato: rNovela;
begin
    reset(arch);
    //leo en el arch para saltear el 1er registro, es decir, me salteo la cabecera
    read(arch, dato);

    leerNovela(dato);
    //leo datos mientras el codigo ingresado sea valido, el cod nunca puede ser negativo
    while (dato.cod <> -1) do begin
        write(arch, dato);
        leerNovela(dato);
    end;
    close(arch);
end;

//el procedure nuevaNovela, permite hacer un alta dentro del archivo, si es que hay espacio en el mismo
//para saber si hay espacio, se debe controlar que el cod del reg cabecera, sea distinto de cero
//si cabecera se encuentra en 0, esto quiere decir que no hay espacio sobrante dentro del archivo
//y se debe agregar el nuevo registro al final del archivo
procedure nuevaNovela(var arch: archNovelas);
var
    novela, cabecera: rNovela;
begin
    Reset(arch);
    seek(arch, 0); //se busca el reg donde se encuentra la cabecera del archivo
    read(arch,cabecera);

    leerNovela(novela);
    
    if (cabecera.cod = 0) then begin
        seek(arch, FileSize(arch));
        write(arch, novela);
    end
    else if (cabecera.cod < 0) then begin
        //desde la cabecera, busca el lugar del archivo que se encuentra libre para escribir en el
        seek(arch, cabecera.cod*-1);
        //leo en el reg cabecera la info que contiene el lugar libre del archivo
        read(arch, cabecera);
        
        //retrocedo el puntero para poder escribir la novela en el lugar indicado
        seek(arch, filePos(arch)-1);
        //agrego la nueva novela en el archivo.
        write(arch,novela);

        //guardo en la cabecera del archivo lo que contenía el reg libre del archivo
        //este puede ser la pos de otro reg libre del archivo o el valor 0
        //si posee un 0, esto indica que no quedan más espacios para ser ocupados en el archivo
        seek(arch,0);
        write(arch, cabecera);
    end;

end;

procedure modificarNovela(var arch: archNovelas);
var
    cod: integer;
    novela: rNovela;
    encontro: boolean;
begin
    Reset(arch);
    writeln('Ingrese el cod de la novela que desea modificar: '); readln(cod);

    //es necesario comprobar que el codigo leído sea mayor que 0     
    if (cod > 0) then begin
        encontro := false;
       //me salteo el reg cabecera
        read(arch, novela);

        leer(arch, novela);
        while ((novela.cod <> valorAlto) and (not encontro)) do begin

            if (novela.cod = cod) then begin
                leerNovela(novela);
                seek(arch, FilePos(arch)-1);
                Write(arch, novela);
                encontro := true;
            end;

            leer(arch, novela);
        end;    
    end;
    
    if (encontro) then
        WriteLn('El codigo fue encontrado y la novela se modifico con exito.')
    else
        WriteLn('El codigo buscado no existe dentro del archivo.');
    close(arch);
end;

{programa principal}
var
    nomArchivo: cad;
    fn: archNovelas;
    op: integer;
begin
    WriteLn('Ingrese nombre del archivo: '); ReadLn(nomArchivo);
    Assign(fn, nomArchivo);
    Rewrite(fn);

    repeat
        WriteLn('1. Dar de alta una novela');
        WriteLn('2. Modificar datos de novela');
        WriteLn('3. Eliminar una novela');
        WriteLn('4. Listar en txt');

        WriteLn('0. Salir');

        WriteLn('Seleccione una opcion: ');
        ReadLn(op);

        case (op) of
            '1': begin
                nuevaNovela(fn);
                imprimirArchivo(fn);
            end;
            '2': begin
                modificarNovela(fn);
                imprimirArchivo(fn);  
            end;

            '3':begin
                eliminarNovela(fn);
                imprimirArchivo(fn);  
            end;

            '4': exportarATxt(fn);
        end;
    until (op = 0);
end.