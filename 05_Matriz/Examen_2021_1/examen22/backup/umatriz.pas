unit UMatriz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs,Grids;
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
          procedure CargarMRnd(a,b:integer);
          procedure CargarM();
          procedure descargarM(v : TStringGrid);
          procedure setElem(fil,col,ele:integer);
          procedure setcols(col:integer);
          procedure setfils(fil:integer);
          procedure interElem(f1,c1,f2,c2:integer);
          function getElem(fil,col:integer):integer;
          function getfils():integer;
          function getcols():integer;

          procedure transponerTriangulares();
          procedure TranpuestaTSD1();
          procedure TranpuestaTII1();

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

procedure Matriz.CargarMRnd(a, b: integer);
var f1,c1, n :integer;
begin
   n := StrToInt(InputBox('dimension de la matriz','N',''));
   fils:=n;
   cols:=n;
   if (fils >= 1) and(cols >= 1) then
    for f1:=1 to fils do begin
       for c1:=1 to cols do begin
          elem[f1,c1]:=Random(b-a+1)+a;
       end;
    end;
end;

procedure Matriz.CargarM();
var f1,c1, n :integer;
begin
   n := StrToInt(InputBox('dimension de la matriz','N',''));
   fils:=n;
   cols:=n;
    for f1:=1 to fils do begin
       for c1:=1 to cols do begin
          elem[f1,c1]:=StrToInt(InputBox('integer','m['+IntToStr(f1)+','+IntToStr(c1)+'] = ',''));
       end;
    end;
end;

procedure Matriz.descargarM(v: TStringGrid);
var f,c:integer;
begin
   v.colCount:= getcols();
   v.RowCount:= getfils();
   for f:=1 to getfils() do
   for c:=1 to getcols() do
   v.cells[c-1,f-1]:= IntToStr(getElem(f,c));
end;

procedure Matriz.setElem(fil, col, ele: integer);
begin
      if(fil>=1)and(fil<=fils)and(col>=1)and(col<=cols)then
      elem[fil,col]:=ele
      else
       begin
       ShowMessage('La fila o la columna estan Fuera de Rango..');
      end;
end;

procedure Matriz.setcols(col: integer);
begin
   if(cols>=0)and(cols<=MAX_COL)then
     cols:=col
   else
     ShowMessage('La columna esta fuera de rango');
end;

procedure Matriz.setfils(fil: integer);
begin
   if(fil>=0)and(fil<=MAX_FIL)then
    fils:=fil
   else
    ShowMessage('La fila esta fuera de rango');
end;

procedure Matriz.interElem(f1, c1, f2, c2: integer);
var aux:integer;
begin
 if(f1>=1)and(f1<=fils)and
   (c1>=1)and (c1<=cols)and
   (f2>=1)and (f2<=fils)and
   (c2>=1)and(c2<=cols)then
  begin
    aux:=elem[f1,c1];
    elem[f1,c1]:=elem[f2,c2];
    elem[f2,c2]:=aux
  end
 else
   ShowMessage('Las Filas o Columnas estan fuera de rango..');
end;

function Matriz.getElem(fil, col: integer): integer;
begin
   if(fil>=1)and(fil<=fils)and(col>=1)and(col<=cols)then
    result:=elem[fil,col]
   else
    result:=-1;
end;

function Matriz.getfils(): integer;
begin
  result:=fils;
end;

function Matriz.getcols(): integer;
begin
   result:=cols;
end;

procedure Matriz.transponer();
var f1, c1:Integer;
begin
   //solo para matrices cuadradas
 for f1:=1 to (fils )do
    for c1:=1  to (cols)do begin

        if (f1 < c1 ) and (f1+c1 <= fils) then begin
          interElem(f1, c1, fils-c1+1, fils-f1+1 );
        end;

        if(f1 > c1)and (f1+c1 <= fils) then begin
           interElem(f1, c1, fils-c1+1, fils-f1+1 );
        end;

    end;
end;

end.

