unit UotrasTecnicas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Forms, Controls, Graphics,Dialogs;
  Const Max=1000;
  type

    { OtrasTecnicas }

    OtrasTecnicas=class
    public
      elem:array[1..Max]of integer;
      dim :integer;
    public
      constructor Crear;
      procedure cargar();
      procedure Mostrar();
      function getdim():integer;
      function getElem(pos:integer):integer;
      procedure CorteControlN1();
      procedure Dispersion();
      procedure Dispersion1();
      procedure OrdBurbuja();
      procedure AddElem(ele:integer);
      procedure SegmenarParImpar(a,b:OtrasTecnicas);
      procedure Ejercicio4(a,b:OtrasTecnicas);
      procedure intercalar(A,B:OtrasTecnicas);
      procedure ejercicio6(A,B,C:OtrasTecnicas);
      function  VerifPrimo(nro:integer):boolean;
      procedure ejercicio7(B:OtrasTecnicas);
      procedure ejercicio9();
      function  ElemMenor():integer;
      PROCEDURE ELIMINAR(elemento:integer);
      procedure ejercicio5(A,B:OtrasTecnicas);


    end;
implementation

{ OtrasTecnicas }

constructor OtrasTecnicas.Crear;
var i :Integer;
begin
 dim:=0;
 for i:=1 to MAX DO
  elem[i]:=0;
end;


procedure OtrasTecnicas.cargar();
var i:integer;
begin
 dim:=StrToInt(InputBox('vector','elementos',''));
 for i:=1 to dim do begin
  //elem[i]:=1+Random(10);
    elem[i]:=StrToInt(InputBox('','v['+inttostr(i)+']',''));
 end;
end;

procedure OtrasTecnicas.Mostrar();
var i:integer;
begin
 write('elem => [');
 for i:=1 to dim do begin
   write(elem[i],', ');
 end;
 writeln(']');
end;

function OtrasTecnicas.getdim(): integer;
begin
   result:=dim;
end;

function OtrasTecnicas.getElem(pos: integer): integer;
begin
  result:=elem[pos];
end;

//muestra cuantos elemenos diferenes hay en un vector ordenado
procedure OtrasTecnicas.CorteControlN1();
var i,cc:integer;
begin
 cc:=0; i:=1;
 while(i<=(dim-1)) do begin
   if(elem[i]<> elem[i+1])then
    cc:=cc+1;
  i:=i+1;
 end;
 writeln('Existen <',cc,'>cortes de conrol de nivel 1');
end;

procedure OtrasTecnicas.Dispersion();
var i,ce:integer;
begin
 writeln('La dispersion es : ');
 ce:=1; i:=1;
 while(i<=(dim-1)) do begin
    if(elem[i]<> elem[i+1])then begin
      writeln(elem[i],' => {',ce,'}');
      ce:=1;
    end else
      ce:=ce+1;
 i:=i+1;
 end;
   writeln(elem[i],' => {',ce,'}');
end;

procedure OtrasTecnicas.Dispersion1();
var i,cc,ele:integer;
begin
 cc:=0; i:=1;
 while(i<=dim) do begin
   ele:=elem[i]; //ele=1
   cc:=0;
   while(ele= elem[i])do begin
    cc:=cc+1; //1
    i:=i+1;   //[2]
   end;
   writeln(ele,' => {',cc,'}');
 end;
end;

procedure OtrasTecnicas.OrdBurbuja();
var i,j,aux:integer;
begin
  for i:=1 to (dim-1) do begin
    for j:=i+1 to dim do begin
         if(elem[i]>elem[j])then begin
            aux:=elem[i];
            elem[i]:=elem[j];
            elem[j]:=aux;
         end;
    end;
  end;
end;

procedure OtrasTecnicas.AddElem(ele: integer);
begin
  dim:=dim+1;
  elem[dim]:=ele;
end;

procedure OtrasTecnicas.SegmenarParImpar(a, b: OtrasTecnicas);
var i:integer;
begin
  for i:=1 to dim do begin
    if((elem[i]mod 2)=0)then
     a.AddElem(elem[i])
    else
     b.AddElem(elem[i]);
  end;
end;

procedure OtrasTecnicas.intercalar(A, B: OtrasTecnicas);
var
  i,j:integer;
begin
  i:=1;
  j:=1;
  dim:=0;
  while (i<=A.getDim())AND(j<=B.getDim())do
  begin
     addElem(A.getElem(i));
     i:=i+1;
     addElem(B.getElem(j));
     j:=j+1;
  end;
  while(i<=A.getDim())do
  begin
      addElem(A.getElem(i));
      i:=i+1;
  end;
  while(j<=B.getDim())do
  begin
      addElem(B.getElem(j));
      j:=j+1;
  end;
end;
{Realice la mezcla de tres vectores ordenados ascendente en un cuarto
ordenado ascendente (sin usar ordenamientos, ni procesos auxiliares)}
procedure OtrasTecnicas.ejercicio6(A, B, C: OtrasTecnicas);
var n,i,x,y,z:integer;
begin
 n:=A.getdim()+B.getdim()+C.getdim();//9
 i:=1;x:=1; y:=1; z:=1;
 while(i<=n)do begin
   if(A.getElem(x)>0)then begin
     AddElem(A.getElem(x));
     x:=x+1; i:=i+1;
   end;

   if(B.getElem(y)>0)then begin
     AddElem(B.getElem(y));
     y:=y+1; i:=i+1;
   end;

   if(C.getElem(z)>0)then begin
     AddElem(C.getElem(z));
     z:=z+1; i:=i+1;
   end;
 end;
end;

function OtrasTecnicas.VerifPrimo(nro: integer): boolean;
var i,c:integer;
begin
  c:=0;
   for i:=1 to nro do
    begin
       if(nro mod i=0)THEN
         c:=c+1;
    end;
   result:=(c=2)
end;

procedure OtrasTecnicas.ejercicio7( B: OtrasTecnicas);
var i,aux:integer;
begin
  for i:=1 to dim do begin
    if(not VerifPrimo(elem[i]))then
     B.AddElem(elem[i])
   end;
   aux:=dim;    dim:=0;
  for i:=1 to aux do begin
    if( VerifPrimo(elem[i]))then
     AddElem(elem[i])
   end;
end;

procedure OtrasTecnicas.ejercicio9();
var i,aux:integer;
begin
 OrdBurbuja();
 aux:=dim; dim:=0;
 for i:=1 to (aux-1) do begin
      if(elem[i]<>elem[i+1])Then
         AddElem(getElem(i));
 end;
 AddElem(getElem(aux));
end;

function OtrasTecnicas.ElemMenor(): integer;
VAR I,J,aux:integer;
begin
  aux:=elem[1];
  for i:=2 to (dim) do begin
     if(aux>elem[i])then
        aux:=elem[i];
  end;
  RESULT:=AUX;
end;
                                  //3
procedure OtrasTecnicas.ELIMINAR(elemento: integer);
var i,aux:integer;
begin
   aux:=dim; dim:=0;
   for i:=1 to (aux) do begin
     if(elem[i]<>elemento)then
        AddElem(elem[i]);
  end;
end;

procedure OtrasTecnicas.ejercicio5(A, B: OtrasTecnicas);
var n,i,x,y,z:integer;
begin
 n:=A.getdim()+B.getdim();//2+4=6
 i:=1;
 while(i<=n)do begin
   if(A.ElemMenor()>0)THEN begin
       AddElem(A.ElemMenor());
       A.ELIMINAR(A.ElemMenor());
   end else begin
      AddElem(B.ElemMenor());
      B.ELIMINAR(B.ElemMenor());
   end;
   i:=i+1;
   end;
 end;

procedure OtrasTecnicas.Ejercicio4(a, b: OtrasTecnicas);
begin

end;



end.

