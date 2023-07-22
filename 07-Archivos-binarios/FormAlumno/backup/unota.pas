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

constructor Estudiante.Create();
begin

end;

procedure Estudiante.setNom(s: String);
begin

end;

procedure Estudiante.setExt(s: String);
begin

end;

procedure Estudiante.Crear();
begin

end;

procedure Estudiante.Abrir();
begin

end;

procedure Estudiante.EscribirTipo(r: Tipo);
begin

end;

function Estudiante.LeerTipo: Tipo;
begin

end;

function Estudiante.getNom(): String;
begin

end;

function Estudiante.getExt(): String;
begin

end;

function Estudiante.EsFin(): Boolean;
begin

end;

procedure Estudiante.Cerrar();
begin

end;

procedure Estudiante.Posicionar(pos: Integer);
begin

end;

function Estudiante.tamano(): Integer;
begin

end;

function Estudiante.getpos(): integer;
begin

end;

function Estudiante.getModo(): Integer;
begin

end;

end.

