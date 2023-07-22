program Archi;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
{caracter a caracter
"Texto.txt"
 1124123
 Juan Perez
 Informatica
}
var f:text;
    nom:String;
    C:CHAR;
begin
 nom:='../06Lazarus1/texto.txt';
 assign(f,nom);
 {$I-}
 Reset(f);
 {$I+}
 IF(IOResult<>0)THEN begin
   WriteLn('error en APERTURA....');
   Exit;
 end;//caracter a caracter
 WHILE(not eof(f))DO BEGIN
   readln(f,c);
   write(c);
 end;
 close(f);
 readln();
end.

