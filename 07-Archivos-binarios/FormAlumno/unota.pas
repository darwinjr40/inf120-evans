unit UNota;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
  Type
   Alumno=Record
     Ci:Integer;
     Reg:Integer;
     Nom:String[60];
     Dir:String[80];
     INF110:byte;
     LIN100:byte;
     MAT101:Byte;
     FIS101:Byte;
     INF119:Byte;
   end;

   { Estudiante }

   Estudiante=class
          f:file of Alumno; //
    nom,ext:String;        //Nombre del archivo
       modo:integer;

    public


   end;

implementation

{ Estudiante }



end.

