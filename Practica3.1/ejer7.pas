program ejer7;
const
    valorFinal = 500000;
type
    cad = string[50];
    rAves = record
        cod: integer;
        nomEspecie: cad;
        familia: cad;
        descripcion: cad;
        zonaGeografica: cad;
    end;

    maestro = file of rAves; //archivo original
    nuevoArchivo = file of rAves; //archivo compactado


procedure marcarRegistros(var mae: maestro);
var
    cod: integer;
    ave: rAves;
    ok: Boolean;
begin
    Reset(mae);

    WriteLn('Codigo a dar de baja: '); ReadLn(cod);
    while (cod <> valorFinal) do begin
        ok:= false;
        while ((not EOF(mae)) and (ok)) do begin
            read(mae,ave);
            if (ave.cod = cod) then begin
                ave.cod = ave.cod * -1;
                seek(mae, filepos(mae)-1);
                write(mae,ave);
                ok := true;
            end;
        end;

        if (ok) then
            WriteLn('El ave con el codigo ingresado se elimino con exito')
        else 
            WriteLn('El codigo ingresado no se encontro dentro del archivo');

        seek(mae, 0); //vuelvo a poner el puntero al inicio del archivo

        WriteLn('Codigo a dar de baja: '); ReadLn(cod);
    end;
end;

procedure compactar (var arch: nuevoArchivo; pos: integer; var cont: integer);
var
    dato: rAves;
    posFinal: Integer;
begin
    posFinal := FileSize(mae); //marca la pos final del archivo
    seek(mae,(posFinal - cont)); //vamos la pos anterior del final
    read(mae, dato);//se lee el registro
    seek(mae, pos);//nos dirigimos a la pos donde se va a insertar
    write(mae, dato);//insertamos el reg en la pos correspondiente
    cont := cont + 1;//sumamos 1 en el contador
end;

procedure compactarArchivo(var mae: maestro; var newFile: nuevoArchivo);
var

begin
    Rewrite(newFile);
    Reset(mae);

    contador:=0;

    while (FilePos(mae) <> (FileSize(mae)-cont)) do begin
        read(mae, ave);
        if (ave.cod < 0) then begin
            compactar(newFile,(FilePos(mae)), cont);
            seek(mae, FilePos(mae)-1);
        end;
    end;
    seek(mae, (FileSize(mae)-cont));
    Truncate(mae);
    close(mae);
end;

{programa principal}
var

begin

end.