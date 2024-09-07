program project1;

uses UNatural;
var obj: Natural;
    nro, aux, a, b: cardinal;
begin
  writeln('ingrese un numero');
  readln(nro);
  obj := Natural.Crear();
  obj.setN(nro);
  //writeln('cantidad de digitos ----------------------------------');
  //writeln(obj.CantDig());
  //
  //writeln('Nro1 ----------------------------------');
  //writeln(obj.GetNaturales());
  //
  //writeln('Nro7 ----------------------------------');
  //writeln('ingrese un numero');
  //readln(aux);
  //writeln(obj.GetDivisionSucesiva7(aux));

  writeln('ejercicio Union ----------------------------------');
  writeln('ingrese un numeroA');
  readln(a);
  writeln('ingrese un numeroB');
  readln(b);
  obj.Union2(a,b);
  writeln(obj.GetN());
  writeln(Natural.Pot(10,6));
  writeln(Natural.CantDig());
  readln;
end.

