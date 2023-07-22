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
 //03_Realice un programa que me permita ADICIONAR un registro dentro de un archivo
  var
     f:file of Alumno;
     r:Alumno; //objeto alumno
   nom:String;
   cant:Integer;
begin
   nom:='../t7e1/Alumnos.dat';
   Assign(f,nom); //Asignando un nombre al "archivo Texto"
   {$I-}
   Reset(f);  //abre un texto con el nombre que se le asigno"modo lectura"
   {$I+}
   If(IOResult<>0)then begin
     WriteLn('Error en Apertura de Archivo TIPO....');
     Exit;
   end;
   cant:=FileSize(f);//cuantos registro tiene el archivo
   writeln('El archivo tiene : ',cant,' Registros.');
   seek(f,cant); //posicionar el puntero de archivo en el final
   writeln('Adicionando Alumno : ');
   //guardamos informacion en el "tipo"
   write('Carnet : ');
   ReadLn(r.Ci);
   write('Registro : ');
   ReadLn(r.Reg);
   write('Nombre : ');
   ReadLn(r.Nom);
   write('Direccion : ');
   ReadLn(r.Dir);
   //Escribimos la informacion tipo "alumno" en el "archivo Texto"
   write(f,r);
   close(f);
   readln;
end.
