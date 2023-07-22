program T7e8;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

Type
   Alumno=Record
     Reg:Integer;
     INF110:byte;
     LIN100:byte;
     MAT101:Byte;
     FIS101:Byte;
     INF119:Byte;
   end;
   var
      f:file of Alumno;
      r:Alumno; //objeto alumno
      n:Integer; //cantidad de alumnos
begin
    Assign(f,'../t7e6/Notas.dat');  //Assignacion de un archivo
    {$I-}
    Reset(f);// Abrimos un archivo
    {$I+}
    If(IOResult<>0)then begin
      Write('Error en Creacion de Archivo TIPO....');
      read;
      Exit;
    end;
     n:=0;
    while(not EOF(f)) do begin
        read(f,r);
        n:=n+r.INF110;
    end;
    Write(n/(FileSize(f)));
    readln();
end.

