unit UAPP_MATRIZ;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Forms, Controls, Graphics,Dialogs,StdCtrls, Grids,UotrasTecnicas;
CONST
  MAX_FIL=1000;
  MAX_COL=1000;
  TYPE

    { Matriz }

    Matriz=class
      private
        elem:array[1..MAX_FIL,1..MAX_COL]of integer;
        fils,cols:integer;
        public
          constructor crear();
          procedure cargar();
          procedure setElem(fil,col,ele:integer);
          function getElem(fil,col:integer):integer;
          procedure setfils(fil:integer);
          function getfils():integer;
          procedure setcols(col:integer);
          function getcols():integer;
          procedure interElem(f1,c1,f2,c2:integer);
          function frecuencia(ele:integer):integer;
          function ejercicio6(fa,fb,ca,cb:integer):integer;
          function ejercicio8():string;
          procedure ejercicio9(v:OtrasTecnicas);

          function MenNumFils(fi:Integer):integer;
          procedure permutarFils(fa,fb:Integer);
          procedure Ordenar_Fil_NumPar();


    end;

implementation

{ Matriz }

constructor Matriz.crear();
var f,c:integer;
begin
   fils:=0;
   cols:=0;
   for f:=1 to MAX_FIL do
    for c:=1 to MAX_COL do
     elem[f,c]:= 0;
   end;

procedure Matriz.cargar();
Var f,c,e:integer;
begin
  setfils(StrToInt(InputBox('Matriz','Filas:','3')));
  setcols(StrToInt(InputBox('Matriz','Columnas:','3')));
  for f:=1 to getfils() do
  for c:=1 to getcols() do  begin
   //e:=StrToInt(InputBox('Matriz','M['+IntToStr(f)+','+IntToStr(c)+'] = ','0'));
   e:=Random(15);//{1..100}
   setElem(f,c,e);
  end;
end;


procedure Matriz.setElem(fil, col, ele: integer);
begin
      if(fil>=1)and(fil<=fils)and(col>=1)and(col<=cols)then
      elem[fil,col]:=ele
      else begin
      // WriteLn('Matriz.setElem: Fuera de Rango..');
       ShowMessage('La fila o la columna estan Fuera de Rango..');
      end;
end;

function Matriz.getElem(fil, col: integer): integer;
begin
   if(fil>=1)and(fil<=fils)and(col>=1)and(col<=cols)then
    result:=elem[fil,col]
   else
   begin
     result:=-999;

end;
   end;

procedure Matriz.setfils(fil: integer);
begin
   if(fil>=0)and(fil<=MAX_FIL)then
    fils:=fil
   else
   ShowMessage('La fila esta fuera de rango');
end;

function Matriz.getfils(): integer;
begin
  result:=fils;
end;

procedure Matriz.setcols(col: integer);
begin
     if(cols>=0)and(cols<=MAX_COL)then
    cols:=col
   else
   ShowMessage('La columna esta fuera de rango');
end;

function Matriz.getcols(): integer;
begin
   result:=cols;
end;

procedure Matriz.interElem(f1, c1, f2, c2: integer);
var aux:integer;
begin
 if(f1>=1)and(f1<=fils)and(c1>=1)and (c1<=cols)and (f2>=1)and (f2<=fils)and (c2>=1)and(c2<=cols)then
  begin
  aux:=elem[f1,c1];
  elem[f1,c1]:=elem[f2,c2];
  elem[f2,c2]:=aux
  end
 else
 begin
   ShowMessage('Las Filas o Columnas estan fuera de rango..');
  end;
end;

function Matriz.frecuencia(ele: integer): integer;
var f,c,sum:integer;
begin
 sum:=0;
  for f:=1 to fils do begin
      for c:=1 to cols do  begin
        if(elem[f,c]=ele)then
        sum:=sum+1
      end;
  end;
  result:=sum;
end;

function Matriz.ejercicio6(fa,fb,ca,cb:integer): integer;
var f,c,sum:integer;
begin
 sum:=0;
  for f:=fa to fb do begin
      for c:=ca to cb do  begin
      sum:=sum+getElem(f,c);
      end;
  end;
  result:=sum;
end;

function Matriz.ejercicio8(): string;
var f,c,i:integer;
        cad:String;
        b:boolean;
begin
 cad:=''; b:=true;
  for f:=1 to fils do begin
      for c:=1 to cols do  begin
         if(frecuencia(elem[f,c])>1)then begin
             for i:=1 to Length(cad) do  begin
              if(cad[i]=inttostr(getElem(f,c)))then
                  b:=false;
             end;
           if(b)then
            cad:=cad+IntToStr(getElem(f,c))+' , ';
            b:=true;
         end;
      end;
  end;
  result:=cad;

end;

procedure Matriz.ejercicio9(v: OtrasTecnicas);
var i :integer;
begin
 setfils(StrToInt(InputBox('Matriz','Filas:','3')));
 setcols(StrToInt(InputBox('Matriz','Columnas:','3')));
 for i:=0 to v.getdim()-1 do begin
     setElem((i div fils)+1,(i mod fils)+1,v.getElem(i+1));
 end;
 //[1,2,3,4,5,6,7,8]      fila                   columnas
 //i----------------
 //i=0    0 div 3=> 0 +1 => 1     0 mod 3=> 0 +1 =>  1
 //i=1    1 div 3=> 0 +1 => 1     1 mod 3=> 1 +1 =>  2
 //i=2    2 div 3=> 0 +1 => 1     2 mod 3=> 2 +1 =>  3

 //i=3    3 div 3=> 1 +1 => 2     3 mod 3=> 0 +1 =>  1
 //i=4    4 div 3=> 1 +1 => 2     4 mod 3=> 1 +1 =>  2
 //i=5    5 div 3=> 1 +1 => 2     5 mod 3=> 2 +1 =>  3

 //i=6    6 div 3=> 2 +1 => 3     6 mod 3=> 0 +1 =>  1
 //i=7    7 div 3=> 2 +1 => 3     7 mod 3=> 1 +1 =>  2
end;

function Matriz.MenNumFils(fi: Integer): integer;
var c1,r:integer;
begin
 r:=getElem(fi,1);
  for c1:=1 to cols do begin
     if(elem[fi,c1] mod 2 =0)then begin
        if(elem[fi,c1] < r)then
           r:=elem[fi,c1];
     end;
  end;
   if(r mod 2=1)then
    r:=0;
  result:=r;
end;

procedure Matriz.permutarFils(fa, fb: Integer);
var c1:integer;
begin
  for c1:=1 to cols do begin
     interElem(fa,c1,fb,c1);
  end;
end;

procedure Matriz.Ordenar_Fil_NumPar();
var f1,f2:integer;
begin
  for f1:=1 to fils-1 do begin
     for f2:=f1+1 to fils do begin
        if(MenNumFils(f1)>MenNumFils(f2))then
           permutarFils(f1,f2);
     end;
  end;
end;

end.

