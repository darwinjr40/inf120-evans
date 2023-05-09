unit prueba;

{$mode ObjFPC}{$H+}

interface


uses
  Classes, SysUtils, Dialogs, Natural;
  const  //var
     MAX_ELE=1000;
     type

       { vector }

       vector = class
         private //atributos
           elem:array[1..MAX_ELE]of integer;
           dim:integer;

         public  //metodos
            procedure cargar();  //ctrl + shift + c
       end;

implementation

{ vector }

procedure vector.cargar;
begin

end;

end.

