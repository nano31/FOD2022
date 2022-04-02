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



{programa principal}
var

begin
  
end.