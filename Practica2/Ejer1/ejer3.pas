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

{programa principal}
var

begin
  
end.