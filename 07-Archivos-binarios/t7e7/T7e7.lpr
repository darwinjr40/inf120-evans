program T7e7;

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
     INF119:Byte;  //00..127
   end;
   var
      f:file of Alumno;
      r:Alumno; //objeto alumno

begin
    Assign(f,'../t7e6/Notas.dat');  //Assignacion de un archivo
    {$I-}
    Reset(f);// Abrimos un archivo Existente
    {$I+}
    If(IOResult<>0)then begin
      WriteLn('Error en Creacion de Archivo TIPO....');
      readln();
      Exit;
    end;
       writeln('  Registro INF110  LIN100  MAT101   FIS101   INF119');
      while(NOT EOF(F)) do begin//Escritura en archivo
       Read(f,r);  //cargar r de informacion
       WriteLn('  ',r.Reg,'    ',r.INF110,'      ',r.LIN100,'      ',r.MAT101,'       ',r.FIS101,'       ',r.INF119);//Escribimos lo que tiene 'r' en archivo'f'
      end;
      Close(f);//cierra el archivo
      readln;
end.


