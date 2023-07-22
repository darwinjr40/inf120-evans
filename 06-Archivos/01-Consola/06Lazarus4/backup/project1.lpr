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
   nom,linea:String;
begin
  nom:='texto.txt';
  assign(f,nom);
  {$I-}
  reset(f);
  {$I+}
  IF(IOResult<>0)THEN begin
    WriteLn('error apertura....');
    Exit;
  end;
   while(not eof(f))do begin
    readln(f,linea);
    writeln(linea);
   end;
   close(f);
   readln();
   readln();
end.

