unit Conjunto;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils;
//---------------Codigo empieza aqui----------------------------------
  const  MAX_ELE=1200;
  type   conjuntos = class
      private
        con :array[1..MAX_ELE]of char;
        dim:integer;
        public
          constructor crear ;
          procedure setElem(pos:integer;ele:char);
          function getElem(pos:integer):char;
          procedure setDim(n:integer);
          function getDim():integer;
          function pertenece(ele:char):boolean;
          procedure agregar(ele:char);
          procedure remover(ele:char);
          function descargar():String;


   end;
//-----------------Acaba aca---------------------------------


implementation

{ conjuntos }
//Inicializar atributos
constructor conjuntos.crear;
var i:integer;
begin
    dim:=0;
    for i:=1 to MAX_ELE do
    begin
      con[i]:=char(0);
    end;
end;

//enviamos un elemento a una posicion
procedure conjuntos.setElem(pos: integer; ele: char);
begin
  if(pos>=1)AND(pos<=dim)then
       con[pos]:=ele
  else
       Writeln('Conjunto.setElem:Fuera de Rango...');
end;

//retorna el elemento de esa posicion
function conjuntos.getElem(pos: integer): char;
begin
   if(pos>=1)AND(pos<=dim)then
       result:=con[pos]
   else
       result:=char(0);
end;
//redimensionamos el atributo dim=dimencion
procedure conjuntos.setDim(n: integer);
begin
   if(n>=0)AND(n<=MAX_ELE)then
      dim:=n
   else
      writeln('Conjunto.setDim:Fuera de Rango...');
end;
//retorna la dimension del vector
function conjuntos.getDim(): integer;
begin
  result:=dim;
end;

//Elemento pertenece a al conjunto
// [a, e, i, o, u]   (z)
//dim = 5
function conjuntos.pertenece(ele: char): boolean;
var  i:integer;
    sw:boolean;
begin
   sw:=false;
   i:=1;
   while(i<=dim) and (NOT sw)do
   begin //i=3
     if(ele=con[i])then
        sw:=true
     else
       i:=i+1;
   end;
   result:=sw;
end;
//agregamos un elemento al final
procedure conjuntos.agregar(ele: char);
begin
  if(NOT pertenece(ele))then
  begin
    dim:=dim+1;
    con[dim]:=ele;
  end;
end;
//eliminamos ese elemento de todo el conjunto
// [a, e, i, o, u] ==[ e | i | o | u ]
//dim = 5                    (a)
procedure conjuntos.remover(ele: char);
var i,n : integer;
begin
if(pertenece(ele))then
 begin
   n:=dim;  dim:=0;
   for i:=1 to n do  begin
     //i=3
     if(con[i]<>ele) then
      agregar(con[i]);
   end;
 end;
 end;
//muestra lo que almacene en el conjunto
function conjuntos.descargar(): String;
var s:String;
    i:integer;
begin
 s:='';
 for i:=1 to dim do
  begin
  s:=s+con[i]+ ' | ' ;
  end;
 result:=s;
end;

end.

