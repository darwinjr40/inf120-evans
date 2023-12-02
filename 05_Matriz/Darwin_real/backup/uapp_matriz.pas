unit UAPP_MATRIZ;

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
        elem:array[1..MAX_FIL,1..MAX_COL]of real;
        fils,cols:integer;
        public
          //--------------En Clase------------
          constructor crear();
          procedure CargarMRnd(a,b:integer);
          procedure CargarM();
          procedure descargarM(v : TStringGrid);
          procedure setElem(fil,col,ele:integer);
          function getElem(fil,col:integer):real;
          procedure setfils(fil:integer);
          function getfils():integer;
          procedure setcols(col:integer);
          function getcols():integer;
          procedure interElem(f1,c1,f2,c2:integer);
          procedure busq_sec(ele:integer; var f,c:integer);
          procedure ord_sele();
          procedure ord_sele1();

          procedure InversaGauss(m: Matriz);

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
                        // 1,10
procedure Matriz.CargarMRnd(a, b: integer);
var f1,c1:integer;
begin
   fils:=StrToInt(InputBox('cantidad de filas','filas',''));
   cols:=StrToInt(InputBox('cantidad de columnas','columnas',''));
    for f1:=1 to fils do begin
       for c1:=1 to cols do begin
                 //           10-1 = 9->(0..9)+1
          elem[f1,c1]:= Random(b-a+1)+a;
       end;
    end;
end;

procedure Matriz.CargarM();
var f1,c1:integer;
begin
   fils:=StrToInt(InputBox('cantidad de filas','filas',''));
   cols:=StrToInt(InputBox('cantidad de columnas','columnas',''));
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
   v.cells[c-1,f-1]:= floattostr(getElem(f,c));
end;

procedure Matriz.setElem(fil, col, ele: integer);
begin
      if(fil>=1)and(fil<=fils)and(col>=1)and(col<=cols)then
      elem[fil,col]:=ele
      else
       begin
      // WriteLn('Matriz.setElem: Fuera de Rango..');
       ShowMessage('La fila o la columna estan Fuera de Rango..');
      end;
end;

function Matriz.getElem(fil, col: integer): real;
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
var aux:real;
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
 begin
   ShowMessage('Las Filas o Columnas estan fuera de rango..');
  end;
end;

procedure Matriz.busq_sec(ele: integer; var f, c: integer);
var sw:Boolean;
    p,dim:integer;
begin
 sw:=false;
 p:=1;
 dim:=fils*cols;
    while(p<=dim)AND (NOT sw)do begin
       f:=((p-1) div cols)+1;
       c:=((p-1) mod cols)+1;
      if (ele=elem[f,c]) then
          sw:=true;
          p:=p+1;
      end;
      if(sw=false)then begin
          f:=-1;
          c:=-1;
      end;
    end;

procedure Matriz.ord_sele();
var
    p,d,dim,fd,cd,fp,cp:integer;
begin
 dim:=fils*cols;

  for p:=1 to dim-1 do
    for d:=p+1 to dim do
     begin
      fd:=((d-1) DIV cols)+1;
      cd:=((d-1) MOD cols)+1;
      fp:=((p-1) DIV cols)+1;
      cp:=((p-1) MOD cols)+1;

       if (elem[fd,cd])< (elem[fp,cp]) then
           interElem(fd,cd,fp,cp);
       end;
    end;

procedure Matriz.ord_sele1();
var f1,c1,f2,c2,i:integer;
begin
  for f1:=1 to fils do begin
     for c1:=1 to cols do begin
        for f2:=f1 to fils do begin
           if(f1=f2)then  begin
            i:=c1
            end else begin
            i:=1;
            end;
           for c2:=i to cols do begin
              if (elem[f1,c1]) > (elem[f2,c2]) then
               interElem(f1,c1,f2,c2);
           end;
        end;
     end;
  end;
end;

procedure Matriz.InversaGauss(m: Matriz);
var i,j,k, n : integer;
       piv, fac : real;
begin
  if((self.cols <> self.fils) or (self = m)) then begin
   raise Exception.Create('no se puede procesar la inversa');
  end;
  n := cols;
  m.setfils(n);
  m.setcols(n);
  for i:=1 to n do begin
      m.elem[i,i] := 1;
  end;
  // Aplicar el método de Gauss-Jordan
  for i:=1 to n do begin
      piv := elem[i,i];
      //dividir fila por el pivote
      for j:=1 to n do begin
         elem[i,j] := elem[i,j] / piv;
         m.elem[i,j]  := m.elem[i,j]  / piv;
      end;
      //restar las filas para obtener ceros por debajo del pivote
      for k := 1 to n do begin
         if k<>i then
         begin
           fac := elem[k, i];
           for j := 1 to n do begin
             elem[k,j] := elem[k,j] - fac * elem[i,j];
             m.elem[k,j]  := m.elem[k,j]  - fac * m.elem[i,j];
           end;
         end;
      end;
  end;
end;




end.

