unit Uotras_tecnicas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
const MAX_E=1000;
type tipodatovector = integer;
type vector = array [1..MAX_E] of tipodatovector;
   type

     { otrastecnicas }

     otrastecnicas=class
       private
           elem:array[1..MAX_E] of integer;
           dim:integer;
         public
           constructor crear();
           function getDim():integer;
           function getElem(pos:integer):integer;
           procedure cargar();
           procedure mostrar();
           procedure addElem(ele:integer);
           procedure corteControlNl();
           procedure dispersion();
           procedure segmentarParImpar(A,B:otrastecnicas);
           procedure intercalar(A,B:otrastecnicas);
           function esPrimo(num:integer):Boolean;
           procedure OrdBurbuja();
           procedure ejercicio1();
           procedure ejercicio2();
           procedure ejercicio3();
           {procedure ejercicio4(A,B:otrastecnicas);
           procedure ejercicio5(A,B:otrastecnicas);}
           procedure ejercicio6(A,B,C:otrastecnicas);
           procedure ejercicio7(A,B:otrastecnicas);
           procedure ejercicio9();


     end;

implementation

{ otrastecnicas }

constructor otrastecnicas.crear();
var i:integer;
begin
   dim:=0;
   for i:=1 to MAX_E do
   begin
     Elem[i]:=0;
   end;
end;

function otrastecnicas.getDim(): integer;
begin
  result:=dim;
end;

function otrastecnicas.getElem(pos: integer): integer;
begin
    result:=elem[pos];
end;

procedure otrastecnicas.cargar();
var i:integer;
begin
   write('Cuantos elementos : ');
   readLn(dim);
   for i:=1 to dim do
   begin
     write('Elem[',i,'] : ');
     readln(Elem[i]);
   end;
end;

procedure otrastecnicas.mostrar();
var i:integer;
begin
   write('[');
   for i:=1 to dim do
   begin
     write(Elem[i],',');
   end;
   writeln(']');
end;

procedure otrastecnicas.addElem(ele: integer);
begin
  dim:=dim+1;
  elem[dim]:=ele;
end;

procedure otrastecnicas.corteControlNl();
var i,cc:integer;
begin
  cc:=0;
  i:=1;
   while(i<=dim-1)do
   begin
      if (Elem[i]<>Elem[i+1])then
      cc:=cc+1;
   i:=i+1;
   end;
   writeln('Existen <',cc,'> Cortes de control de Nivel 1...');
end;

procedure otrastecnicas.dispersion();
var i,ce:integer;
begin
writeln('La dispersion es : ');
  i:=1;
  ce:=1;
   while(i<=dim-1)do
   begin
      if (Elem[i]<>Elem[i+1])then
      begin
        writeLn(elem[i],'=>{',ce,'}');
        ce:=1;
      end
      else
      ce:=ce+1;
   i:=i+1;
   end;
   writeLn(elem[i],'=>{',ce,'}');
end;

procedure otrastecnicas.segmentarParImpar(A, B: otrastecnicas);
var
  i:integer;
begin
  for i:=1 to dim do
  begin
  if(elem[i] mod 2 = 0) then
   A.addElem(elem[i])
   else
     B.addElem(elem[i]);
  end;
end;

procedure otrastecnicas.intercalar(A, B: otrastecnicas);
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

function otrastecnicas.esPrimo(num: integer): Boolean;
var i,cont:Integer;
begin
i:=1;cont:=0;
 if (num>1) then
 begin
  while (i<=num) do
  begin
    if (num mod i = 0) then
      cont:=cont+1;
    i:=i+1;
  end;
  if (cont <= 2) then
    esPrimo:=true
  else
    esPrimo:=false;
 end
 else begin
   esPrimo:=false
 end;
end;

procedure otrastecnicas.OrdBurbuja();
var i,j,aux:integer;
begin
 for i:=1 to(dim-1) do
 begin
    for j:=i+1 to dim do
    begin
       if(elem[i]>elem[j])then begin
          aux:=elem[i];
          elem[i]:=elem[j];
          elem[j]:=aux;
       end;
    end;
 end;
end;

procedure otrastecnicas.ejercicio1();
var i,cc:integer;
begin
  cc:=0;
  i:=1;
   while(i<=dim-1)do
   begin
      if (Elem[i]<>Elem[i+1])then
      cc:=cc+1;
   i:=i+1;
   end;
   writeln('Existen <',cc,'> Cortes de control de Nivel 1...');
end;

procedure otrastecnicas.ejercicio2();
var i,cc:integer;
begin
  cc:=0;
  i:=1;
  OrdBurbuja();
   while(i<=dim-1)do
   begin
      if (Elem[i]<>Elem[i+1])then
      cc:=cc+1;
   i:=i+1;
   end;
   writeln('Existen <',cc,'> Cortes de control de Nivel 1...Ordenados');
end;

procedure otrastecnicas.ejercicio3();
var i,ce:integer;
begin
writeln('La dispersion es : ');
  i:=1;
  ce:=1;
   while(i<=dim-1)do
   begin
      if (Elem[i]<>Elem[i+1])then
      begin
        writeLn(elem[i],'=>{',ce,'}');
        ce:=1;
      end
      else
      ce:=ce+1;
   i:=i+1;
   end;
   writeLn(elem[i],'=>{',ce,'}');
end;
{Realice la mezcla de dos vectores ordenados ascendente,
en un tercer ordenado ascendente (sin usar ordenamientos).}
{ otrastecnicas.ejercicio4(A, B: otrastecnicas);
var
  i,j,k:integer;
begin
  i:=1;
  j:=1;
  k:=1;
  dim:=0;

end;
{5.- Realice la mezcla de dos vectores ordenados Descendente-mente,
en un tercer ordenado Ascendente-mente (sin usar ordenamientos).}
procedure otrastecnicas.ejercicio5(A, B: otrastecnicas);
var i,j,k,l,aux,aux2:integer;
begin
 dim:=A.getDim()+B.getDim();

  for l:=1 to dim do
  begin
   for i:=1 to (A.getDim()+1) do begin
       if A.getElem(i)>A.getElem(i+1)then begin
         aux:=A.getElem(i);
            for k:=i  to A.dim  do
               begin
                 A.getElem(i):=A.getElem(i+1);
               end;
            pos:=pos-1;
       end;
    end;

   for j:=1 to (B.getDim()+1) do begin
         if (B.getElem(j>B.getElem(j+1))and (B.getElem(j)<>0) then
         begin
           aux2:=B.getElem(j);
           eliminar(B.elem,B.getDim(),j);
         end;
    end;
   if aux<aux2 then begin
     elem[k]:=aux;
     k:=k+1;
     elem[k]:=aux2;
     end;
  end;
end; }

procedure otrastecnicas.ejercicio6(A,B,C:otrastecnicas);
var n,i,x,y,z:integer;
begin
  n:=A.getDim()+B.getDim()+C.getDim();
  i:=1;x:=1;y:=1;z:=1;
  while (i<=n) do begin
   if(A.getElem(x)>0)then begin
     AddElem(A.getElem(x));
     x:=x+1; i:=i+1;
   end;
   if(B.getElem(y)>0)then Begin
     AddElem(B.getElem(y));
     y:=y+1; i:=i+1;
   end;
   if(C.getElem(z)>0)then Begin
     AddElem(C.getElem(z));
     z:=z+1; i:=i+1;
   end;
  end;
end;

procedure otrastecnicas.ejercicio7(A, B: otrastecnicas);
var
  i:integer;
begin
  for i:=1 to dim do
  begin
  if(esPrimo(elem[i]) = true) then
   A.addElem(elem[i])
   else
     B.addElem(elem[i]);
  end;
end;

procedure otrastecnicas.ejercicio9();
var i,aux:integer;
begin
   ordBurbuja();
   aux:=dim;
   dim:=0;
   for i:=1 to (aux-1) do begin
    if(elem[i]<>elem[i+1])then
    AddElem(getElem(i));
   end;
   AddElem(getElem(aux));
end;

end.

