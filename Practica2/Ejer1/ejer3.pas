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

procedure minimo();
var

begin

end;

{programa principal}
var

begin
  
end.