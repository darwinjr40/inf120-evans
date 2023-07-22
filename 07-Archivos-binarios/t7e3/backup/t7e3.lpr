program t7e3;

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
 //Adicionar una fila al ultimo
  var
     f:file of Alumno;
     r:Alumno; //objeto alumno
   nom:String;
   cant:Integer;
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
   cant:=FileSize(f);//cuantos registro tiene el archivo
   writeln('El archivo tiene : ',cant,' Registros.');
   //posicionar el puntero de archivo en el final
   seek(f,cant);
   writeln('Adicionando Alumno : ');
   write('Carnet : ');
   ReadLn(r.Ci);
   write('Registro : ');
   ReadLn(r.Reg);
   write('Nombre : ');
   ReadLn(r.Nom);
   write('Direccion : ');
   ReadLn(r.Dir);
   write(f,r);
   close(f);
   readln;
end.
