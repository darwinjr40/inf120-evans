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

constructor conjuntos.crear;
var i:integer;
begin
    dim:=0;
    for i:=1 to MAX_ELE do
    begin
      con[i]:=char(0);
    end;
end;



procedure conjuntos.setElem(pos: integer; ele: char);
begin
  if(pos>=1)AND(pos<=dim)then
       con[pos]:=ele
  else
       Writeln('Conjunto.setElem:Fuera de Rango...');
end;

function conjuntos.getElem(pos: integer): char;
begin
   if(pos>=1)AND(pos<=dim)then
       result:=con[pos]
   else
       result:=char(0);
end;

procedure conjuntos.setDim(n: integer);
begin
   if(n>=0)AND(n<=MAX_ELE)then
      dim:=n
   else
      writeln('Conjunto.setDim:Fuera de Rango...');
end;

function conjuntos.getDim(): integer;
begin
  result:=dim;
end;

function conjuntos.pertenece(ele: char): boolean;
var  i:integer;
    sw:boolean;
begin
   sw:=false;
   i:=1;
   while(i<=dim)and(NOT sw)do
  begin
    if(ele=con[i])then
       sw:=true
    else
       i:=i+1;
  end;
   result:=sw;
end;

procedure conjuntos.agregar(ele: char);
begin
  if(NOT pertenece(ele))then
  begin
    dim:=dim+1;
    con[dim]:=ele;
  end;
end;

procedure conjuntos.remover(ele: char);
var i,n : integer;
begin
if(pertenece(ele))then
 begin
   n:=dim;  dim:=0;
   for i:=1 to n do
   begin
     if(con[i]<>ele) then
      agregar(con[i]);
   end;
 end;
 end;

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

