program t7e2;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

Type
  Alumno=Record
    Ci:Integer;
    Reg:Integer;
    Nom:String[60];
    Dir:String[80];
  end;
  var
     f:file of Alumno;
     r:Alumno; //objeto alumno
   nom:String;
begin
   nom:='../t7e1/Alumnos.dat';
   Assign(f,nom);
   {$I-}
   Reset(f);
   {$I+}
   If(IOResult<>0)then begin
     WriteLn('Error en Apertura de Archivo TIPO....');
     Exit;
   end;
   //Mostrar informacion
   writeln('  Carnet   Registro  Nombre               Direccion');
   while(not eof(f))do begin
     read(f,r);
     writeln('    ',r.Ci,'     ',r.Reg,'   ',r.Nom,'     ',r.Dir);
   end;
   close(f);
   readln;
end.

