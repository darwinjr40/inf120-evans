program t7e6;

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
      r:Alumno; //Tipo alumno
      n:Integer; //cantidad de alumnos
      i:Integer; //puntero
begin
    writeln('Cuantos alumnos Registrara : ');
    Readln(n);
    Assign(f,'Notas.dat');  //Assignacion de un archivo
    {$I-}
    Rewrite(f);//remplazamos y Abrimos un archivo nuevo
    {$I+}
    If(IOResult<>0)then begin
      WriteLn('Error en Creacion de Archivo TIPO....');
      Exit;
    end;
     i:=0;
      while(i<n) do begin//Escritura en archivo
       writeln('Alumno Nro. ',i+1);
       write('Registro : ');
       ReadLn(r.Reg);
       write('INF110 : ');
       ReadLn(r.INF110);
       write('LIN100 : ');
       ReadLn(r.LIN100);
       write('MAT101 : ');
       ReadLn(r.MAT101);
       write('FIS101 : ');
       ReadLn(r.FIS101);
       write('INF119 : ');
       ReadLn(r.INF119);
       write(f,r);//Escribimos lo que tiene 'r' en archivo'f'
       i:=i+1;
      end;
      Close(f);//cierra el archivo
   readln;
end.

