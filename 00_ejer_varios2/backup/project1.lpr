program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, UPractico01
  { you can add units after this };
var a, b, c : cardinal;
begin
  writeln('ingrese un numero a: ');
  readln(a);
  //writeln('ingrese un numero b: ');
  //readln(b);
  //Union(a,b,c);
  //writeln(c);
  DosDigsMay(a,b,c);
  writeln('digito1:', b);
  writeln('digito1:', c);
  readln;
end.

