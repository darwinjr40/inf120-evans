program t7e4;

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
   num:Integer;
   sw:boolean;
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
   //Pedir Numero Registro
   write('Digite el registro : ');
   //num:=1;
   readln(num);
   sw:=false;
   while((not EOF(f)) and(not sw))do begin
     read(f,r);
     if(num=r.Reg)then
       sw:=true;
   end;
   if(sw)then begin
     writeln('Carnet : ',r.Ci);
     writeln('registro : ',r.Reg);
     writeln('Nombre : ',r.Nom);
     writeln('Direccion : ',r.Dir);
   end else begin
     writeln('Registro no encontrado...');
   end;
   readln;
end.

