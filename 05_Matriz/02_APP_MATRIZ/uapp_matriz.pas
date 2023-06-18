unit UAPP_MATRIZ;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs, Uotras_tecnicas;
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

           procedure busq_sec(ele:integer; var f,c:integer);
           procedure ord_sele();
           procedure ord_sele1();

           procedure TSizq();
           procedure TIderecha();
           procedure DSecundaria();
           function frecuencia(ele:integer):integer;
           function FrecuTSI(ele:integer):integer;
           function Ejercicio10():integer;
           function FrecuTID(ele:integer):integer;
           function Determinante3x3():integer;
           function Determinante2x2():integer;
           procedure copianula(m1:matriz;nf,nc:integer);
           procedure copia(m1:matriz);
           procedure Tranpuesta();
           procedure Adjunta(m1:matriz);
           procedure inversa(m1:matriz);
           procedure OrdTSi();
           procedure cargarf1(ca,cb,f:integer;var ele:integer);
           procedure cargarc1(fa,fb,c:integer;var ele:integer);
           procedure cargarf2(ca,cb,f:integer;var ele:integer);
           procedure cargarc2(fa,fb,c:integer;var ele:integer);
           procedure cargarEspiral(fa,ca,fb,cb:integer;var ele:integer);
           procedure cargarm1();
           function  FreTSD(ELE:Integer):integer;
           function  Ele_May_Fre_TSD():integer;
           procedure Ord_TII();
           procedure cargarTID_C();
           procedure cargarTID_C2();

           procedure segmentarPI_TID_F();
           //practico
           //#2.Multiplicación de dos Matrices
           procedure multiplicacion(m1,m2: matriz);
           //#6. Suma de un Bloque(fila y columna inicial hasta fila y columna final)
           function SumaElementos(fa,fb,ca,cb:integer):integer;
          //#8.Buscar los elementos repetidos en una matriz
           function ElementosRepetidos():string;
           //#9.Realizar un programa que reciba como parámetro un vector y me devuelva el contenido en una matriz
           procedure cargarMatriz(v:otrastecnicas);

           //retorna el numero menor de una fila
           function getMenor(fi:Integer):integer;
           //intercambia dos filas
           procedure intercambiarFilas(fa,fb:Integer);
           //ordenar la matriz por filas segun el elemento menor de cada fila.
           procedure OrdenarElementoMenorPorFila();


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

procedure Matriz.multiplicacion(m1, m2: matriz);
var f1,c1,c2:integer;
begin
  if(m1.getcols()=m2.getfils())then begin
    setcols(m2.getcols());setfils(m1.getfils());
    for f1:=1 to m1.getfils()do begin
       for c1:=1 to m2.getcols() do begin
          for c2 :=1 to m1.getcols()do begin
            elem[f1,c1]:=elem[f1,c1]+m1.elem[f1,c2]*m2.elem[c2,c1];
           end;
       end;
    end;
  end;
end;

procedure Matriz.TSizq();
var f1,c1,sum:integer;
begin
  sum:=0;
   for f1:=1 to getfils()-1do begin
       for c1:=1 to (getcols()-f1) do begin  //   2      1
                                               //(3-1) (3-2)
                                             //(col-fil)
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
       for c1:=(getcols()+2-f1) to getcols() do begin //   3      2
                                                      //(3+2-2) (3+2-3)
                                                      //(col+2-fil)
        sum:=sum+1;
         elem[f1,c1]:=sum;
        end;
       end;
end;

procedure Matriz.DSecundaria();
var f1,sum:integer;
begin
  sum:=0;
   for f1:=1 to getfils()do begin
        sum:=sum+1;
         elem[f1,getcols()+1-f1]:=sum;
          //      3+1-3= 1
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
   for f1:=2 to (getfils())do begin
       for C1:=getcols() downto (getcols()+2-f1)do begin
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

procedure Matriz.cargarm1();
var s,f1,c1:integer;
begin
 s:=0;
for c1:=1 to cols do begin
  for f1:=fils-c1+1 downto 1 do begin
       s:=s+1;
       elem[f1,c1]:=strtoint(InputBox('dato','',''));
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

procedure Matriz.cargarTID_C2();
var i,c1,f1:integer;
begin
 i:=0;         //C
  for c1:=2 to cols do begin
    for f1:=fils-c1+2   to fils do begin
          //5-5+2
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

function Matriz.SumaElementos(fa, fb, ca, cb: integer): integer;
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

function Matriz.ElementosRepetidos(): string;
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

procedure Matriz.cargarMatriz(v: otrastecnicas);
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

function Matriz.getMenor(fi: Integer): integer;
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

procedure Matriz.intercambiarFilas(fa, fb: Integer);
var c1:integer;
begin
  for c1:=1 to cols do begin
     interElem(fa,c1,fb,c1);
  end;
end;

procedure Matriz.OrdenarElementoMenorPorFila();
var f1,f2:integer;
begin
  for f1:=1 to fils-1 do begin
      for f2:=f1+1 to fils do begin
        if(getMenor(f1)>getMenor(f2))then
           intercambiarFilas(f1,f2);
      end;
  end;
end;


end.

