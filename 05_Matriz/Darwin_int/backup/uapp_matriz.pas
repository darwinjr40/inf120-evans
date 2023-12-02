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
           //inversa de una matriz
           function Determinante3x3():integer;
           function Determinante2x2():integer;
           procedure copianula(m1:matriz;nf,nc:integer);
           procedure copia(m1:matriz);
           procedure Tranpuesta();
           procedure Adjunta(m1:matriz);
           procedure inversa(m1:matriz);

           {------------cargada espiral de una matriz----------}
           // cargar de rango ca,cb y fila  -->
           procedure cargarf1(ca,cb,f:integer;var ele:integer);
           // cargar de rango fa,fb y columna  "v" abajo
           procedure cargarc1(fa,fb,c:integer;var ele:integer);
           // cargar de rango ca,cb y fila  <--
           procedure cargarf2(ca,cb,f:integer;var ele:integer);
           // cargar de rango fa,fb y columna  "^" arriva
           procedure cargarc2(fa,fb,c:integer;var ele:integer);
           //llamada del cargado espiral
           procedure cargarEspiral(fa,ca,fb,cb:integer;var ele:integer);
           {--------------------------------------------------------}
           //ordena la TSI sin la "DS"
           procedure OrdTSi();
           //ordena la "TII"
           procedure Ord_TII();
           //Segmentar Par e impares "TID"
           procedure segmentarPI_TID_F();

          //retorna la suma un bloque de una matriz
          function ejercicio6(fa,fb,ca,cb:integer):integer;
          //Retorna los elementos repetidos de una matriz
          function ejercicio8():string;
        //  procedure ejercicio9(v:OtrasTecnicas);
          //retorna el "Menor numero par" de una fila
          function MenNumFils(fi:Integer):integer;
          //intercambiar dos filas
          procedure permutarFils(fa,fb:Integer);
          //ordena la matriz segun las filas con "el menor numero par"
          procedure Ordenar_Fil_NumPar();

          //Frecuencia de un elemento por fila
          function FreF(ele,fila:integer):integer;
          //Elemento mas repetido y su frecuencia al final
          procedure Mejor();
          function EcuacionMatriz(): string;
          {EXAMEN---------------------}
          //Ordena la TII sin "DP"
          procedure ordTII();
          //Ordena la TSD sin "DP"
          procedure ordTSD();
          procedure  ordTID();
          //MULTIPLICA 2 MATRICES
          procedure multiplica(m1,m2:matriz);
          procedure TranpuestaTII1();
          procedure TranpuestaTSD1();
          procedure TransponerTriangSinTp();
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

function Matriz.Determinante3x3(): integer;
var s:integer;
begin
   s:=0;
   if(getcols()=3)and(getfils()=3) then begin
        s:=(elem[1,1])*(elem[2,2])*(elem[3,3]) +
           (elem[1,2])*(elem[2,3])*(elem[3,1]) +
           (elem[1,3])*(elem[2,1])*(elem[3,2]) -
           (elem[3,1])*(elem[2,2])*(elem[1,3]) -
	   (elem[2,1])*(elem[1,2])*(elem[3,3]) -
	   (elem[1,1])*(elem[3,2])*(elem[2,3])
   end;
   result:=s;
end;

function Matriz.Determinante2x2(): integer;
var pos,neg,aux,i:integer;
begin
  pos:=1; neg:=1; aux:=1;
  if(getfils()=2) and (getcols()=2) then begin
     for i:=1 to getfils()do begin
        pos:=pos*getElem(i,i);
        neg:=neg*getElem(i,i+aux);
        aux:=-1;
     end;
  end else begin
   ShowMessage('Error inserte una matriz de 2x2');
  end;
  result:=pos-neg;
end;

procedure Matriz.copianula(m1: matriz; nf, nc: integer);
var f1,c1,i:integer;
begin
   i:=0; setcols(m1.getcols()-1); setfils(m1.getfils()-1);
   for f1:=1 to (m1.getfils())do begin
     for c1:=1 to (m1.getcols()) do begin
         if(f1<>nf)and(c1<>nc)then begin
           setElem((i div fils)+1,(i mod fils)+1,m1.getElem(f1,c1));
           i:=i+1;
           end;
     end;
  end;
end;

procedure Matriz.copia(m1: matriz);
var f1,c1:integer;
begin
 setfils(m1.getfils());  setcols(m1.getcols());
 for f1:=1 to (m1.getfils())do begin
     for c1:=1 to (m1.getcols()) do begin
       setElem(f1,c1,m1.getElem(f1,c1));
     end;
 end;

end;



procedure Matriz.Tranpuesta();
var f1,c1:integer;
    m:matriz;
begin
   m:=MAtriz.crear();
   m.setcols(getfils());
   m.setfils(getcols());
  for f1:=1 to (getfils())do begin
     for c1:=1 to (getcols()) do begin
       m.setElem(c1,f1,getElem(f1,c1));
       //elem[c1,f1]:=m1.getElem(f1,c1);
     end;
  end;
  copia(m);

end;

procedure Matriz.Adjunta(m1: matriz);
 var m:matriz;
     f1,c1:integer;
begin
 m:=MAtriz.crear(); setfils(m1.getfils());  setcols(m1.getcols());
 for f1:=1 to (m1.getfils())do begin
     for c1:=1 to (m1.getcols()) do begin
          m.copianula(m1,f1,c1);//creo la matriz 2*2
          if((f1+c1)mod 2=0)then
           setElem(f1,c1,m.Determinante2x2())
          else
           setElem(f1,c1,-m.Determinante2x2());
     end;
 end;
 Tranpuesta();
end;

procedure Matriz.inversa(m1: matriz);
begin
end;



procedure Matriz.OrdTSi();
var f1,c1,i,f2,c2:integer;
begin

   for f1:=1 to (getfils()-1)do begin
     for c1:=1 to (getcols()-f1) do begin
           for f2:=f1 to getfils()-1do begin
                if(f1=f2)then
                 i:=c1
                 else
                 i:=1;
             for c2:=i to (getcols()-f2) do begin
                  if(elem[f1,c1]>elem[f2,c2])then
                   interElem(f1,c1,f2,c2);
             end;
           end;
     end;
   end;
end;

procedure Matriz.cargarf1(ca, cb, f: integer; var ele: integer);
var c1:integer;
begin
  for c1:=ca to cb do begin
    setElem(f,c1,ele);
    ele:=ele+1;
  end;
end;

procedure Matriz.cargarc1(fa, fb, c: integer; var ele: integer);
var f1:integer;
begin
  for f1:=fa to fb do begin
    setElem(f1,c,ele);
    ele:=ele+1;
  end;
end;

procedure Matriz.cargarf2(ca, cb, f: integer; var ele: integer);
var c1:integer;
begin
  for c1:=cb downto ca do begin
    setElem(f,c1,ele);
    ele:=ele+1;
  end;
end;

procedure Matriz.cargarc2(fa, fb, c: integer; var ele: integer);
var f1:integer;
begin
  for f1:=fb downto fa do begin
    setElem(f1,c,ele);
    ele:=ele+1;
  end;
end;

procedure Matriz.cargarEspiral(fa, ca, fb, cb: integer; var ele: integer);
begin
    while (ca<cb) do begin
       cargarf1(ca,cb-1,fa,ele);
       cargarc1(fa,fb-1,cb,ele);
       cargarf2(ca+1,cb,fb,ele);
       cargarc2(fa+1,fb,ca,ele);
       ca:=ca+1;
       cb:=cb-1;
       fa:=fa+1;
       fb:=fb-1;
    end;
   if(ca=cb)then
   setElem(fa,ca,ele);
end;

procedure Matriz.cargaTSI();
var s,f1,c1:integer;
begin
  s:=0;
  for c1:=1 to cols do begin
    for f1:=fils-c1+1 downto 1 do begin
         s:=s+1;
         elem[f1,c1]:= s
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

procedure Matriz.Ord_TII();
var f1,c1,i,f2,c2:integer;
begin
  for f1:=1 to (fils) do begin
    for c1:=1  to (f1) do begin
      for f2:=f1 to (fils) do begin
         if(f1=f2)then
          i:=c1
         else
          i:=1;
        for c2:=i  to (f2) do begin
           if(elem[f1,c1]>elem[f2,c2])then
            interElem(f1,c1,f2,c2);
        end;
     end;
  end;
 end;
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

procedure Matriz.segmentarPI_TID_F();
var i,c1,f1,f2,c2:integer;
begin         //C
  for f1:=1 to fils do begin
    for c1:=cols-f1+1   to cols do begin
        for f2:=f1 to fils do begin
           if(f2=f1)then begin
             i:=c1;
           end else begin
             i:=cols-f2+1;
           end;
           for c2:=i to cols do begin
              if((elem[f1,c1]mod 2=1) and (elem[f2,c2]mod 2=0)) or
              ((elem[f1,c1]mod 2=0) and (elem[f2,c2]mod 2=0) and (elem[f1,c1] > elem[f2,c2]))or
              ((elem[f1,c1]mod 2=1) and (elem[f2,c2]mod 2=1)and(elem[f1,c1]>elem[f2,c2]))then
                 interElem(f1,c1,f2,c2);
           end;
        end;
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

function Matriz.ejercicio6(fa, fb, ca, cb: integer): integer;
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

{procedure Matriz.ejercicio9(v: OtrasTecnicas);
begin

end;}

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
   if(r mod 2=1)then  begin
    r:=0;
   end;
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

function Matriz.FreF(ele, fila: integer): integer;
var c1,s:integer;
begin   s:=0;
 for c1:=1 to cols do begin
    if(elem[fila,c1]=ele)then begin
       s:=s+1;
    end;
 end;
 result:=s;
end;

procedure Matriz.Mejor();
var ele,fr,f1,c1,frecu:integer;
begin
  for f1:=1 to fils do begin
     ele:=0; fr:=0;
      for c1:=1 to cols do begin
          frecu:=FreF(elem[f1,c1],f1);
         if(frecu> fr)then begin
            fr:=frecu;
            ele:=elem[f1,c1];
         end;
      end;
      elem[f1,cols+1]:=ele;
      elem[f1,cols+2]:=fr;
  end;
  setcols(cols+2);
end;
//revisar el div, tiene que ser para numeros reales
function Matriz.EcuacionMatriz(): string;
const  N = 3; // Número de filas y columnas de la matriz
var
  A: array[1..N, 1..N+1] of real; // Matriz aumentada del sistema
  X: array[1..N] of real; // Solución del sistema
  i, j, k: integer;
  factor: real;
  res: string;
begin
   //copiar la matriz objeto a la mtriz A
   for i := 1 to self.fils do begin
       for j := 1 to self.cols do  begin
         A[i,j]:= self.elem[i,j];
       end;
   end;
   // Aplicar eliminación gaussiana
  for k := 1 to N-1 do begin
    for i := k+1 to N do begin
      factor := A[i,k] / A[k,k];
      for j := k+1 to N+1 do  begin
        A[i,j] := A[i,j] - factor * A[k,j];
      end;
      A[i,k] := 0;
    end;
  end;
  // Resolver el sistema por sustitución hacia atrás
  X[N] := A[N,N+1] / A[N,N];
  for i := N-1 downto 1 do begin
    X[i] := A[i,N+1];
    for j := i+1 to N do begin
      X[i] := X[i] - A[i,j] * X[j];
    end;
    X[i] := X[i] / A[i,i];
  end;
  // Mostrar la solución
  res := '';
  for i := 1 to N do begin
    res := 'x'+ inttostr(i)+ ' = ' + floattostr(X[i])+ #10 + res;
  end;
  result := res;
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

procedure Matriz.ordTID();
var f1,c1,i,f2,c2:integer;
begin
  for c1:=cols downto 2 do begin
    for f1:=fils - c1 + 2  to fils do begin
      for c2:=c1 downto 2 do begin
         if(c1=c2)then
          i:=f1
         else
          i:=fils - c2 + 2;
        for f2:=i  to (fils) do begin
           if(elem[f1,c1]>elem[f2,c2])then
            interElem(f1,c1,f2,c2);
        end;
     end;
  end;
 end;
end;

procedure Matriz.multiplica(m1, m2: matriz);
var f1,c1,i:integer;
begin
  if(m1.getcols() <> m2.getfils()) then
    //raise Exception.create('El número de columnas de la primera matriz debe ser igual al número de filas de la segunda matriz')
    ShowMessage('El número de columnas de la primera matriz debe ser igual al número de filas de la segunda matriz')
  else begin
    self.fils := m1.fils; // self.setfils(m1.getfils());
    self.cols:= m2.cols; //self.setcols(m2.getcols());
    for f1:=1 to m1.fils do begin
      for c1:=1 to m2.cols do begin
         elem[f1,c1] := 0;
         for i:=1 to m1.cols do
           elem[f1,c1] := elem[f1,c1] + (m1.elem[f1,i] * m2.elem[i,c1]);
       end;
    end;
  end;
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

procedure Matriz.TransponerTriangSinTp;
var i,j: integer;
begin
  for i:=1 to (self.fils div 2 ) do begin
    for j:=1 to self.cols-1 do begin
      if(i<j)then begin //tsd
         self.interElem(i,j, self.fils-j+1,self.cols-i+1);
         self.interElem(j,i, self.cols-i+1, self.fils-j+1);
      end;
    end;
  end;
end;
end.

