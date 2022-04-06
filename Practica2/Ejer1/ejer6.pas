program ejer6;
const
    valorAlto = 9999;
    df = 10;
type
    cad = string[20];
    rDetalle = record
        codLocalidad: integer;
        codCepa: integer;
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;
    detalle = file of rDetalle;

    rMaestro = record
        codLocalidad: integer;
        nomLocalidad: cad;
        codCepa: integer;
        nomCepa: cad;
        cantActivos: integer;
        cantNuevos: integer;
        cantRecuperados: integer;
        cantFallecidos: integer;
    end;
    maestro = file of rMaestro;

    


{programa principal}
var

begin
  
end.