program ejer3;
const
    valorAlto = 9999;
    df = 30;
type
    producto = record
        cod: integer;
        nombre: string[20];
        descripcion: string[20];
        stockDisp: integer;
        stockMin: integer;
        precio: real;
    end;

    sucursal = record
        cod: integer;
        cantVendida: integer; //se le resta al stock disponible
    end;

    maestro = file of producto;
    detalle = file of sucursa;

    vecDet = array [1..df] of detalle;
    vecReg = array [1..df] of sucrusal;

procedure leer (var det: detalle; var regDet: sucursal);
begin
    if (not EOF(det)) then 
        read(det, regDet)
    else
        regDet.cod := valorAlto;
end;

procedure minimo(var vDet: vecDet; vReg: vecReg; var min: sucursal);
var
    i, indiceMin: integer;
begin
    indiceMin:= 0;
    min.cod:= valorAlto;

    //recorro los registros detalle
    for i:= 1 to df do begin
      if (vReg[i].cod < min.cod) then begin
        indiceMin:= i;
        min:= vReg[i];
      end;
    end;

    if (indiceMin <> 0) then
        leer(vDet[indiceMin],vReg[indiceMin]); 
end;

procedure generarTxt(var mae: maestro);
var
    txt: Text;
begin
    reset(mae);
    Rewrite(txt);
    
    while (not EOF(mae)) do begin
        read(mae, regMae);
        if (regMae.stockDisp < regMae.stockMin) then begin
            write(txt,'Codigo: ', regMae.cod,' Descripcion: ', regMae.descripcion,
            'Stock Disponible: ', regMae.stockDisp, ' Stock Minimo: ', regMae.stockMin);
        end;
    end;
end;

{programa principal}
var
    mae: maestro;
    regMae: producto;
    vDet: vecDet;
    vReg: vecReg;
    cantVendido,codAct: integer;
begin
  
    for i:= 1 to df do begin
        assign(vDet[i], 'detalle'+IntToStr(i));
        reset(vDet[i]);

        {guarda el primer registro de cada detalle en la i-esima pos del vector de ventas} 
        leer(vDet[i], vReg[i]);
    end;

    minimo(vDet, vReg, min);
    if (min.cod <> valorAlto) then begin
        read(mae, regMae);
    end;
    while (min.cod <> valorAlto) do begin
        codAct:= min.cod;
        cantVendido:= 0;

        while (codAct = min.cod) do begin
            cantVendido := cantVendido + min.cantVendida;
            minimo(vDet,vReg,min);
        end;

        while (mae.cod <> codAct) do begin
            read(mae,regMae);
        end;
        regMae.stockDisp := regMae.stockDisp - cantVendido;
        seek(mae, filepos(mae)-1);
        write(mae,regMae);

        if (not EOF(mae)) then begin
            read(mae, regMae);
        end;
    end;
    close(mae);
    for i:= 1 to df do begin
        close(vDet[i]);d
    end;

    generarTxt(mae);
end.