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
        elem:array[1..MAX_FIL,1..MAX_COL]of integer;
        fils,cols:integer;
        public
          //--------------En Clase------------
          constructor crear();
          procedure CargarMRnd(a,b:integer);
          procedure CargarM();
          procedure descargarM(v : TStringGrid);
          procedure setElem(fil,col,ele:integer);
          function getElem(fil,col:integer):integer;
          procedure setfils(fil:integer);
          function getfils():integer;
          procedure setcols(col:integer);
          function getcols():integer;
          procedure interElem(f1,c1,f2,c2:integer);
          procedure busq_sec(ele:integer; var f,c:integer);
          procedure ord_sele();
          procedure ord_sele1();
          //-----------Practico--------------
          //Suma 2 matrices
           procedure suma(m1,m2: matriz);
           //carga la matriz "TSI"
           procedure cargaTSI();
           //carga la matriz "TSD"
           procedure cargaTSD();
           //carga la matriz "TID"
           procedure cargarTID_C();
           //carga la matriz "TII"
           procedure cargarTII();
           //carga la matriz "TSI" sin la "DS"
           procedure TSizq();
           //carga la matriz "TID" sin la "DS"
           procedure TIderecha();
           //carga la matriz por columna"TID" sin la "DS"
           procedure cargarTID_C2();
           //cargar la matriz SOLO "DS"
           procedure DSecundaria();
           //Frecuencia en un elemento de la "TSI" sin la "DS"
           function FrecuTSI(ele:integer):integer;
           //Frecuencia en un elemento de la "TSD" sin la "DP"
           function  FreTSD(ELE:Integer):integer;
           //Frecuencia en un elemento de la "TID" sin la "DS"
           function FrecuTID(ele:integer):integer;
           //Frecuencia en un elemento en toda la matriz
            function frecuencia(ele:integer):integer;
           //retorna el elemento con mayor recuencia "TSI" sin la "DS"
           function Ejercicio10():integer;
           //retorna el elemento con mayor Frecuencia y mayor de "TSD" sin la "DP"
           function  Ele_May_Fre_TSD():integer;





          {EXAMEN---------------------}
          procedure ordTII();
          procedure ordTSD();
          //------------------------
          procedure Tranpuesta();
          procedure TranpuestaTSD1();
          procedure TranpuestaTII1();
          procedure transponer();
          //---------------------------------
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
          elem[f1,c1]:=Random(b-a+1)+a;
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
   v.cells[c-1,f-1]:= IntToStr(getElem(f,c));
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
//Suma dos matrices
procedure Matriz.suma(m1, m2: matriz);
var f1,c1,c2:integer;
begin
  if(m1.getcols()=m2.getfils())then begin
    setcols(m2.getcols());setfils(m1.getfils());
    for f1:=1 to m1.getfils()do begin
       for c1:=1 to m2.getcols() do begin
          for c2 :=1 to m1.getcols()do begin
            elem[f1,c1]:=elem[f1,c1]+m1.elem[f1,c2]*m2.elem[c2,c1];
                        //                 m1[1,3] *m2[3,1]
           end;
       end;
    end;
  end;
end;

procedure Matriz.TSizq();
var f1,c1,sum:integer;
begin
  sum:=0;
   for f1:=1 to fils-1do begin
       for c1:=1 to cols-f1 do begin
        sum:=sum+1;
         elem[f1,c1]:=sum;
        end;
       end;
end;

procedure Matriz.TIderecha();
var f1,c1,sum:integer;
begin
  sum:=0;
   for f1:=2 to getfils()do begin
       for c1:=(getcols()+2-f1) to getcols() do begin
         sum:=sum+1;
         elem[f1,c1]:=sum;
        end;
       end;
end;

procedure Matriz.DSecundaria();
var f1,c1,sum:integer;
begin
  sum:=0;
   for f1:=1 to getfils()do begin
        sum:=sum+1;
         elem[f1,getcols()+1-f1]:=sum;
          //      3+1-3= 1
       end;
end;

function Matriz.FrecuTSI(ele: integer): integer;
var f1,c1,s:integer;
begin
    s:=0;
    for f1:=1 to (getfils()-1)do begin
       for c1:=1 to (getcols()-f1) DO begin
           if(elem[f1,c1]=ele)then
             s:=s+1;
       end;
    end;
    Result:=s ;
end;

function Matriz.Ejercicio10(): integer;
var f1,c1,elemento,frecu:integer;
begin
  elemento:=0;  frecu:=0;
  for f1:=1 to (getfils()-1)do begin
       for c1:=1 to (getcols()-f1) DO begin
           if(FrecuTSI(elem[f1,c1])>frecu)then
            begin
              frecu:=FrecuTSI(elem[f1,c1]);
              elemento:=elem[f1,c1];
            end;
       end;
    end;
  result:=elemento;
end;

function Matriz.FrecuTID(ele: integer): integer;
var f1,c1,s:integer;
begin
 s:=0;
   for f1:=2 to (fils)do begin
       for C1:=cols downto (cols+2-f1)do begin
        if(elem[f1,c1]=ele)then
             s:=s+1;
   end;
       result:=s;
   end;
end;





procedure Matriz.cargaTSI();
var s,f1,c1:integer;
begin
 s:=0;
for c1:=1 to cols do begin
  for f1:=fils-c1+1 downto 1 do begin
       s:=s+1;
       elem[f1,c1]:=s//strtoint(InputBox('dato','',''));
  end;
end;
end;

procedure Matriz.cargaTSD();
var s,f1,c1:integer;
begin
 s:=0;
for f1:=1 to fils do begin
  for c1:=f1 to cols do begin
       s:=s+1;
       elem[f1,c1]:=s//strtoint(InputBox('dato','',''));
  end;
end;
end;

//FRECUENCIA DE UN ELEMENTO
function Matriz.FreTSD(ELE: Integer): integer;
var f1,c1,c:integer;
begin
  c:=0;
  for f1:=1 to (fils-1) do begin
    for c1:=cols  downto (f1+1) do begin
         if(elem[f1,c1]=ele)then
            c:=c+1;
    end;
  end;
  result:=c;
end;
//ELEMENTO CON MAYOR "FRECUENCIAS"
function Matriz.Ele_May_Fre_TSD(): integer;
var f1,c1,ele,fr,frecu:integer;
begin
  ele:=elem[1,cols];//5
  fr:=FreTSD(ele);  //1
  for f1:=1 to (fils-1) do begin
    for c1:=cols  downto (f1+1) do begin
         frecu:=FreTSD(elem[f1,c1]);
                         //3  < 8
         if(frecu > fr)or ((frecu=fr)and(ele<elem[f1,c1]))then  begin   //elem menor si son =frecuencias
          ele:=elem[f1,c1];
          fr:=frecu;
         end;
    end;
  end;
  result:=ele;
end;


procedure Matriz.cargarTID_C();
var i,c1,f1:integer;
begin
 i:=0;         //C
  for c1:=1 to cols do begin
    for f1:=fils-c1+1   to fils do begin
      i:=i+1;
      elem[f1,c1]:=i;
    end;
  end;
end;

procedure Matriz.cargarTII();
var i,c1,f1:integer;
begin
 i:=0;         //C
  for f1:=1 to fils do begin
    for c1:=1   to f1 do begin
      i:=i+1;
      elem[f1,c1]:=i;
    end;
  end;
end;

procedure Matriz.cargarTID_C2();
var i,c1,f1:integer;
begin
 i:=0;         //C
  for c1:=2 to cols do begin
    for f1:=fils-c1+2   to fils do begin
      i:=i+1;
      elem[f1,c1]:=i;
    end;
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





procedure Matriz.ordTII();
var f1,c1,i,f2,c2:integer;
begin
  for f1:=2 to (fils) do begin
    for c1:=1  to (f1-1) do begin
      for f2:=f1 to (fils) do begin
         if(f1=f2)then
          i:=c1
         else
          i:=1;
        for c2:=i  to (f2-1) do begin
           if(elem[f1,c1]>elem[f2,c2])then
            interElem(f1,c1,f2,c2);
        end;
     end;
  end;
 end;
end;

procedure Matriz.ordTSD();
var f1,c1,i,f2,c2:integer;
begin
  for f1:=1 to (fils-1) do begin
    for c1:=f1+1  to (cols) do begin
      for f2:=f1 to (fils-1) do begin
         if(f1=f2)then
          i:=c1
         else
          i:=f2+1;
        for c2:=i  to (cols) do begin
           if(elem[f1,c1]>elem[f2,c2])then
            interElem(f1,c1,f2,c2);
        end;
     end;
  end;
 end;
end;

procedure Matriz.Tranpuesta();
begin
   TranpuestaTII1();
   TranpuestaTSD1();
end;

procedure Matriz.TranpuestaTSD1();
var f1,c1:integer;
begin
 for f1:=1 to (fils div 2) do begin
    for c1:=f1+1  to (cols-1) do begin
        interElem(f1,c1,fils-c1+1,cols-f1+1);
     end;
  end;
 end;


procedure Matriz.TranpuestaTII1();
var f1,c1,i,f2,c2:integer;
begin
 i:=0;
 for c1:=1  to (coLS DIV 2) do begin
  for f1:=c1+1 to (fils-c1) do begin
      i:=I+1;
     interElem(f1,c1,fils+1-C1,FILS+1-F1);
      //  ELEM[F1,C1]:= I
     end;
  end;
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

