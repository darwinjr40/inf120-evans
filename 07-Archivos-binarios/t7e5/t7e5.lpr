program t7e5;

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
 //Modificar una fila 'Domicilio'
  var
     f:file of Alumno;
     r:Alumno; //objeto alumno
   nom:String;
   num,pos:Integer;
   sw:boolean;
begin
   nom:='../t7e1/Alumnos.dat';
   Assign(f,nom);
   {$I-}
   Reset(f);
   {$I+}
   If(IOResult<>0)then begin
     WriteLn('Error en Apertura de Archivo TIPO....');
     readln();
     Exit;
   end;
   //Pedir canet identidad
   write('Ingrese el Carnet Identidad que Remplazara : ');
   readln(num);
   pos:=0;
   sw:=false;
   while((not EOF(f)) and(not sw))do begin//busqueda
     read(f,r);
     if(num=r.Ci)then begin
       sw:=true;
       pos:=FilePos(f)-1;//devuelve la posicion donde se encuentra carnet;INDICE 0
     end;

   end;
   if(sw)then begin//Existe el Ci en el texto
     WriteLn('<-----Los datos del Registro Encontrado---->');
     writeln('Carnet   : ',r.Ci);
     writeln('registro : ',r.Reg);
     writeln('Nombre   : ',r.Nom);
     writeln('Direccion: ',r.Dir);
     writeln('Digite los datos nuevos : ');
    { write('Carnet   : ');
     ReadLn(r.Ci);;  //Modificamos el objeto r.ci
     write('registro : ');
     ReadLn(r.Reg);;
     write('Nombre   : ');
     ReadLn(r.Nom); }
     write('Direccion: ');
     ReadLn(r.Dir);
     Seek(f,pos);   //(acedemos al texto(f) en la fila 'pos')
     write(f,r); //sobreescribimos en el archivo, el objeto
   end else begin
     writeln('Carnet no encontrado...');
   end;
   close(f);
   readln;
end.

