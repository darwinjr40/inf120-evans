program project1;

uses UNatural;
var obj: Natural;
    nro, aux: cardinal;
begin
  writeln('ingrese un numero');
  readln(nro);
  obj := Natural.Crear();
  obj.setN(nro);
  //Nro1 ----------------------------------
  writeln(obj.GetNaturales());
  //Nro7 ----------------------------------
  writeln('ingrese un numero');
  readln(aux);
  writeln(obj.GetDivisionSucesiva7(aux));
  readln;
end.

