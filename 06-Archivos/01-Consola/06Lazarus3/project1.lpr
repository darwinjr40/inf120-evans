program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
{Linea a linea}
var f:text;
     nom:String;
begin
  nom:='texto.txt';
  assign(f,nom);
  {$I-}
  rewrite(f);
  {$I+}
  IF(IOResult<>0)THEN begin
    WriteLn('error en creacion....');
    Exit;
  end;//caracter a caracter
   Writeln(f,'1124123');
    Writeln(f,'Juan perez');
     Writeln(f,'informatica');
     Close(f);
     writeln('Archivo creado');
     readln;
     readln;
end.

