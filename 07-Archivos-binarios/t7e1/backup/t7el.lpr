program t7el;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };{"Alumnos.dat"
  Ci   Registro  Nombre              Domicilio
111   202001    Geronimo Bello      Av. Busch
222   202002    Rafel Salvatierra   Av. Centenario
333   202003    Victor Terrazas     Av. Santos Dumont
444   202004    Meliza Viderique    Av. Lujan}
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
       n:Integer; //cantidad de alumnos
       i:Integer; //puntero
begin
     writeln('Cuantos alumnos Registrara : ');
     Readln(n);
     nom:='Alumnos.dat';
     Assign(f,nom);  //Assignacion de un archivo
     {$I-}
     Rewrite(f);//remplazamos y Abrimos un archivo nuevo
     {$I+}
     If(IOResult<>0)then begin
       WriteLn('Error en Creacion de Archivo TIPO....');
       Exit;
     end;
      i:=0;
       while(i<n) do begin
        writeln('Alumno Nro. ',i+1);
        write('    Carnet Ci : ');
        ReadLn(r.Ci);
        write('    Registro : ');
        ReadLn(r.Reg);
        write('    Nombre Completo : ');
        ReadLn(r.Nom);
        write('    Direccion : ');
        ReadLn(r.Dir);
        write(f,r);
        i:=i+1;
       end;
       Close(f);//cierra el archivo
    readln;
end.

