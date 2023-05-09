unit uvector;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,grids,Natural;
   const  //var
     MAX_ELE=1024;
     type

       { vector }

       vector=class
         private
           elem:array[1..MAX_ELE]of integer; //elem [ 1 | 2 | 1000 | 1000000 |.....| 2147483647 |] 2^31 -1
           dim:integer;                      //dim    1    2    3       4     .........1024

         public                      //puntero
               constructor crear();
               procedure cargar();
               procedure CargarRnd(a,b:Integer);
               procedure descargar(v:TStringGrid);
               function descargar(): String;
               procedure setDim(n:integer);
               function  getDim():integer;
               function  getElem(pos:integer):integer;
               procedure addElem(ele:integer);       //adiciona un elemento al final
               procedure insElem(pos,ele:integer);   //Inserta elemento en un posicion y recorre el resto
               procedure RemElem(pos:integer);    //Elimina una "posicion"
               procedure InteElem(pos1,pos2:integer);  //Intercambia dos posiciones
               procedure invertir();  //invierte todo el vector
               procedure rotar(cantidad:integer);   //rota el vector dependiendo de las cantidad de veces
               //---------busqueda de elementos--------
               function  busq_sec(ele:integer):integer;
               function  busq_bi(ele:integer):integer;
               //--------Modos de ordenamiento ascendente----------
               procedure ord_intercambio();
               procedure ord_intercambio(a,b:integer);
               procedure ord_seleccion();
               procedure ord_seleccion(a,b:integer);
               procedure ord_burbuja();
               procedure ord_burbuja(a,b:integer);
               procedure ord_inserc();
               procedure ord_insercion();
               //ordena segun la "cantidad de divisores" ascendente
               procedure ord_CantDiv();

               //retorna la frecuencia de un elemento en todo el vector
               function  frec(ele:integer):Integer;
               //retorna la frecuencia de un elemento en rango (A..B)
               function  frecRan(a,b,ele:integer):Integer;
               //Segmentar en el mismo vector primos y No primos
               procedure SegPri_Nopri();
               //Segmentar segun la frecuencia
               procedure Seg_frecuencia();
               //Elimima los nros repetidos dejando unicos
               procedure ElimRep();
               //Elimina todos los nros repetidos
               procedure ElimAllRep();
               procedure ElimAllRep2(); //mas eficiente
               //elimina un "elemento" en todo el vector
               procedure ElimAll(ele:integer);
               ////elimina un "elemento" solo 1 vez en todo el vector
               procedure ElimOne(ele:integer);
               //elimina un posicion
               procedure ElimPos(pos:integer);
               //Eliminar los numeros primos del vector
               procedure ElimPri();
               //retorna el elemento menor entra rango (A..B)
               function  Men(a,b:integer):integer;
               //carga en v1[unicos] & v2[repetidos]
               procedure DivRepNoRep(v1,v2:vector);
               //funcionar 4 vectores ordenados en un quinto ordenado sin usar sort’s
               procedure Mezcla_A_ordenar1(v1, v2, v3, v4:vector);
   //-------------------UOTRAS TECNICAS--------------------------

               //muestra la cantidad de cortes de control   #1#
               procedure CorteControlN1();
               //V1=Elemento    V2=Frecuencia  dentro del corte de control    #3#
               procedure Dispersion1(v1,v2:vector);
               //Mezcla dos vectores ordenados ascendente-mente,cargar en el  objeto ascendentemente #4#
               procedure Mezcla_A_ordenar(v1,v2:vector);
               //Mezcla dos vectores ordenados descendente-mente,cargar en el  objeto ascendentemente #5#
               procedure Inter_ordenar(v1,v2:vector);
               //Dividir el vector en 2 v1=[primos]  v2=[no primos]    #7#
               procedure ejercicio7(B:vector);
               //primero "ordena" luego elimina numero repetidos dejando unicos #9#
               procedure ejercicio9();
               //cargar en vector --> A[pares]   B[Impares]
               procedure SegmenarParImpar(a,b:vector);
               //cargar de manera intercala en el vector, "A,B" cargados
               procedure intercalar(A,B:vector);

               //Intercalar A,B,C en el objeto
               procedure ejercicio6(A,B,C:vector);
               //retorna el numero menor;
               function  ElemMenor():integer;
               //elimina un "elemento" de todo el vector
               PROCEDURE ELIMINAR(elemento:integer);
               //Intercalar A,B de manera ordenado ascendente en el vector
               procedure ejercicio5(A,B:vector);
               {---------EXAMEN-----------------------------}
               //#2021_1. divide el vector en ,pares,multiplos de 3 y palindrome
               procedure Divide3(A,B,C:vector);

               function  May(a,b:integer):integer;
               //Mezcla dos vectores ordenados descendente-mente,cargar en el  objeto descendentemente
               procedure Mezcla_Desc_ordenar(v1,v2:vector);


               //#2021_1. Retorna el elemeno mas repetido (moda)
               function elementoModa():integer;

               procedure intercalar3Vectores(v1,v2,v3:vector);


       end;

implementation

{ vector }

constructor vector.crear();
var i:integer;
begin
 dim:=0;
 for i:=1 to MAX_ELE do;
    elem[i]:=0;
end;

procedure vector.cargar();//f7 paso a paso,
var i:Integer;            //f8 proceso por proceso
begin                  //('','','')
  dim:=StrToInt(InputBox('','cantidad de elementos','')); //readln(dim)
  for i:=1 to dim do begin
    elem[i]:=StrToInt(InputBox('Elemento','v ['+IntToStr(i)+'] =',''));
  end;
end;

procedure vector.CargarRnd(a, b: Integer);
var i:integer;
begin
dim:=StrToInt(InputBox('cantidad de elementos','dim',''));
//a:=StrToInt(InputBox('rango A','A',''));
//b:=StrToInt(InputBox('rango B','B',''));
  for i:=1 to dim do begin
    elem[i] := a+Random(b-a+1);  //   v(i) = a + Rnd() * (b - a)
  end;                         //ramdon(100)  //[1..10]
end;

procedure vector.descargar(v: TStringGrid);
var i:integer;
begin
   v.ColCount:=dim;
   for i:=1 to getDim() do
     begin
      //[columna, fila]
       v.Cells[i-1,0]:= IntToStr(Elem[i]);
     end;
end;

function vector.descargar: String;
var x : String;
  i : integer;
begin
   x := '';
   for i:=1 to self.dim do begin
      x := x + IntToStr(self.elem[i]) + ',';
   end;
  result := x;
end;


procedure vector.setDim(n: integer);
begin
  dim:=n;
end;

function vector.getDim(): integer;
begin
  result:=dim;
end;

procedure vector.addElem(ele: integer);
begin
 if(dim < MAX_ELE)then //puntero < 1024
   begin //5+1
     dim:=dim+1;      //incrementamos la dimencion
     elem[dim]:=ele;   //adicionamos un elemento
   end
   else
   ShowMessage('Almacenamiento lleno...');
end;

function vector.getElem(pos: integer): integer;
begin
    result:=elem[pos];
end;
//insertar en una posicion y mover
//elem[4 | 3 | 2 | 1]    "(pos=3,ele=10)"-->   =>elem[4 | 3 | 10 | 2 | 1]
procedure vector.insElem(pos, ele: integer);
var i:integer;
begin
    i:=1;
    if(pos >0)and (pos<=dim)then begin
        for i:=dim downto pos do
        begin
          elem[i+1]:=elem[i];
        end;
        elem[pos]:=ele;
        dim:=dim+1;
    end else begin
        ShowMessage('Fuera de rango...');
    end;
end;
//Elimina posicion
//elem[4 | 3 | 2 | 1]  "(pos=3)" => elem[4 | 3 | 1]
procedure vector.RemElem(pos: integer);
var i:integer;
begin
 i:=1;
    if(pos >0)and (pos<=dim)then
    begin
      while (i=pos)and(i=dim-1) do
        begin
          elem[i]:=elem[i+1];
        end;
      dim:=dim-1;
     end
    else
    begin
        ShowMessage('Fuera de rango...');
    end;

end;
//intercambiar dos posiciones
//elem[4 | 3 | 2 | 1]  "(pos1=3,pos1=1)" => elem[2 | 3 | 4 | 1]
procedure vector.InteElem(pos1, pos2: integer);
var aux:integer;
begin
 aux:=0;
    if (pos1>0) and (pos1<=dim) and (pos2>0) and (pos2<=dim)then
    begin
        aux:=elem[pos1];
        elem[pos1]:=elem[pos2];
        elem[pos2]:=aux;
    end
    else
     begin
    ShowMessage('Fuera de rango..');
     end;
end;
//elem[4 | 3 | 2 | 1]  "(pos1=3,pos1=1)" => elem[1 | 2 | 3 | 4]
procedure vector.invertir();
var i,aux:integer;
begin
  for i:=1 to (dim div 2) do begin
    aux:=elem[dim-i+1];        //ultimo elemento - 1
    elem[dim-i+1]:=elem[i];
    elem[i]:=aux;
  end;
end;

procedure vector.rotar(cantidad: integer);
var i,j,elemento:integer;
begin
  for j:=1 to cantidad do begin
      elemento:=elem[1];
      for i:=1 to dim-1 do begin
        elem[i]:=elem[i+1];
      end;
      elem[dim]:=elemento;
  end;
end;

//Busca un elemento      (ele=2)
//elem[4 | 3 | 2 | 1] -->result=> 3(posicion)
function vector.busq_sec(ele: integer): integer;
var  sw:boolean;
     i:integer;
begin
{  sw:=false ;   i:=1;
  while(i<=dim)and(not sw)do begin
      if (elem[i]=ele)then
        sw:=true
      else
        i:=i+1;
  end;
  if(sw = true)then
   result:=i
  else
   result:=-1;    }
  {---------------otra forma mas eficaz-------------------}
  i:=1;
  while(i <= dim)and(elem[i] <> ele)do begin
      i:=i+1;
  end;
    if(i <= dim)then
      result:=i
    else
      result:=-1;
  {--------------------------------------------}


end;
//elem[ 1 | 4 | 8 | 10 ] -->result=> 3(posicion)
//Busca un elemento (ojo.-vector ordenado ascendentemente) (ele=8)
function vector.busq_bi(ele: integer): integer;
var
ini,fim,m:integer;
begin
  ord_intercambio();     //requisito tiene que estar ordenado
  ini:=1;  fim:= dim; m:=0;
 while(ini<=fim)do begin
   m:=(ini+fim) div 2;
    if(ele = elem[m])then begin
        result:= m;
        ini:=dim+1; //uso para salir del ciclo
    end else begin
       if(ele<elem[m])then
         fim:= m-1
       else
         ini:= m+1;
    end;
 end;
  result:= -1;
end;
//Ordena por intercambio
////elem[4 | 3 | 2 | 1]   => elem[1 | 2 | 3 | 4]
procedure vector.ord_intercambio();
var i,j:integer;
begin
  for i:=1 to dim-1 do begin
    for j:=i+1 to dim do begin
      if(elem[i] > elem[j] )then
        InteElem(j,i);
    end;
  end;
end;

procedure vector.ord_intercambio(a, b: integer);
var p1,d:integer;
begin
  for p1:=a to b-1 do begin
    for d:=p1+1 to b do begin
      if( elem[d] < elem[p1])then
        InteElem(d,p1);
    end;
  end;
end;

//Ordena por seleccion   ---------------ojo-----------------
////elem[1 | 3 | 2 | 4]   => elem[1 | 2 | 3 | 4]
procedure vector.ord_seleccion();
var s,p1,d:integer;
begin
  for p1:=1 to dim-1 do  begin
    s:=p1;
    for d:= s+1 to dim do  begin
      if(elem[d] > elem[s]) then//d=5
       s:= d;                   //s=4
    end;
    if (s<> p1)then begin
       InteElem(s,p1);
    end;
  end;
end;

procedure vector.ord_seleccion(a, b: integer);
var s,p1,d:integer;
begin
  for p1:=a to B-1 do  begin
    s:=p1;
    for d:= s+1 to b do  begin
      if(elem[d] < elem[s]) then
       s:= d;
    end;
    if (s<> p1)then begin
       InteElem(s,p1);
    end;
  end;
end;

//Ordenamiento burbuja
////elem[4 | 3 | 2 | 1]   => elem[1 | 2 | 3 | 4]
procedure vector.ord_burbuja();
var p1,d:integer;
begin
  for p1:= dim downto 2  do begin
    for d:= 1 to p1-1  do begin
      if( elem[d]> elem[d+1])then
       InteElem(d,d+1);
    end;
  end;
end;

procedure vector.ord_burbuja(a, b: integer);
var p1,d:integer;
begin
  for p1:= b downto 2  do begin
    for d:= a to p1-1  do begin
      if( elem[d]> elem[d+1])then
       InteElem(d,d+1);
    end;
  end;
end;
//Ordenamiento por insercion directa
procedure vector.ord_inserc();
var i,j:integer;
begin
  for i:=2 to dim do begin
    for j:= i downto 2 do begin
      IF (elem[j] < elem[j-1]  )then // elem[j-1] > elem[j]
        InteElem(j,j-1);
    end;
  end;
end;

procedure vector.ord_insercion();
var i,j,aux:integer;
begin
  for i:=2 to dim do begin
     aux:=elem[i];
     j:=i-1;
      while((elem[j]>aux)and(j>=1)) do begin
          elem[j+1]:=elem[j];
          j:=j-1;
      end;
      elem[j+1]:=aux;
  end;
end;

//ordenar segun la cantidad de divisores
procedure vector.ord_CantDiv();
var i,j:integer;
       n,n2:UNatural;
begin
  n:=UNatural.Crear();
  n2:=UNatural.Crear();
  for i:=1 to dim-1 do begin
    for j:=i+1 to dim do begin
      n.setValor(elem[i]); n2.setValor(elem[j]);
      if(n.CantDiv() > n2.CantDiv())or   //comparamos cantDivisores
      ((n.CantDiv() = n2.CantDiv()) and (n.getValor()>n2.getValor()))then
        InteElem(i,j);     //6=(4)    8=(4)
    end;
  end;
end;

function vector.elementoModa(): integer;
var i, m,ele,frecuenciaElemento:integer;
begin
  m:=0;
  for i:=1 to dim do begin
    frecuenciaElemento:=frec(elem[i]);
    if( frecuenciaElemento > m)then begin
       m:=frecuenciaElemento;
       ele:=elem[i]
    end;
  end;
  Result:=ele;
end;

//segmentar en primos y no primos
procedure vector.SegPri_Nopri();
var i,j:integer;
       n,n2:UNatural;
begin
  n:=UNatural.Crear();
  n2:=UNatural.Crear();
  for i:=1 to dim-1 do begin
    for j:=i+1 to dim do begin
      n.setValor(elem[i]); n2.setValor(elem[j]);
      if(not n.verifPrimo() and  n2.verifPrimo())or
        (n.verifPrimo() and n2.verifPrimo() and(n.getValor()>n2.getValor()))or
      (not n.verifPrimo() and not n2.verifPrimo() and(n.getValor()>n2.getValor())) then
        InteElem(i,j);
    end;
  end;
end;
//frecuencia de un elemento
function vector.frec(ele: integer): Integer;
var c,i:Integer;
begin
   c:=0;
  for i:=1 to dim do begin
    if(elem[i]=ele)then
      c:=c+1;
  end;
  Result:=c;
end;
//frecuencia de un elemento entre rangos
function vector.frecRan(a, b, ele: integer): Integer;
var c,i:Integer;
begin
   c:=0;
  for i:=a to b do begin
    if(elem[i]=ele)then
    c:=c+1;
  end;
  Result:=c;
end;
//segmentar segun la frecuencia
procedure vector.Seg_frecuencia();
var i,j:integer;
begin
  for i:=1 to dim-1 do begin
    for j:=i+1 to dim do begin
        //  frec(2)=3      frec(2)=3
      if(frec(elem[i]) < frec(elem[j])) or    //f o f = f
        (frec(elem[i]) = frec(elem[j])) and   //v ^ v = v
        (elem[i] > elem[j])then

        InteElem(i,j);
        //int   aux=v[i];
        //      elem[i]=elem[j]
        //      elem[j])aux
    end;
  end;
end;
//Elimina los repetidos quedando con los elementos unicos
procedure vector.ElimRep();
var aux,i:integer;
begin
 aux:=dim;    setDim(0);  //elem[1,1,2,2]
 for i:=1 to aux do begin //dim=0
   if(frec(elem[i])=0)then //fre(2)
     addElem(elem[i]);     //[1,2]
 end;
end;
//Elimina todos los elementos repetidos
procedure vector.ElimAllRep();
var aux,i,f:integer;
begin
 aux:=dim;    setDim(0);
 for i:=1 to aux do begin   // elem[1,2,1,3]
   f:=frecRan(1,aux,elem[i]); //f=freran(a,b,1) =2
   if(f=1)then
   addElem(elem[i]);  //elem[2]
 end;                 //     1
end;

procedure vector.ElimAllRep2();
var i,j:integer;
begin
 j:=0;
 for i:=1 to dim do begin   // elem[2,3,1,1]
   if(frec(elem[i]) = 1)then begin
     j:=j+1;
     InteElem(i,j);
   end;
 end;
 dim:=j;//     1
end;

//elimina un elemento en todo el vector
procedure vector.ElimAll(ele: integer);
var aux,i:integer;
begin
 aux:=dim;    setDim(0);
 for i:=1 to aux do begin
   if(elem[i]<>ele)then
   addElem(elem[i]);
 end;
end;

procedure vector.ElimOne(ele: integer);
var pos:integer;
begin
  pos:=busq_sec(ele);
  ElimPos(pos);
end;

procedure vector.ElimPos(pos: integer);
var i:integer;
begin
  if(pos>0)and (pos<=dim) then begin
     for i:=pos to (dim-1) do begin
        elem[i]:=elem[i+1];
     end;
     dim:=dim-1;
  end else begin
    ShowMessage('Posicion fuera de rango');
  end;
end;

//ELIMINA TODOS LOS NUMEROS PRIMOS
procedure vector.ElimPri();
var aux,i:integer;
       n:UNatural;
begin                    //DIM=4
 n:=UNatural.Crear();    //elem[ 4 | 3 | 2 | 6 ]
 aux:=dim;               // aux = 4
 dim := 0; //setdim(0)   //DIM = 0
 for i:=1 to aux do begin  //while (i <= aux)begin  i = i + 1  end
   n.setValor(elem[i]);  //n.cargar(6)  n=6
   if(not n.verifPrimo())then //dim=dim+1
      addElem(elem[i]);    //elem[ 4 | 6 ]
 end;                      //dim = 1+1 =2
end;
//devuelve el elemento menor entre dos rangos
function vector.Men(a, b: integer): integer;
var me,i:integer;
begin
 if(a<=b) then begin
   me:=elem[a];
   for i:=a to b do begin
     if(elem[i]<me)then
     me:=elem[i];
   end;
  result:=me;
 end else begin
  result:=0;
 end;

end;

procedure vector.Inter_ordenar(v1, v2: vector);
var i,j,m1,m2:integer;
begin
  i:=v1.getDim(); j:=v2.getDim();
  while(dim <(v1.dim+v2.Dim))do begin
     m1:=v1.Men(1,i);  //[9,7] -->1
     m2:=v2.Men(1,j);  //[6,3] -->3
     if((m1<m2)and(m1>0))or(m2=0)then begin
         addElem(m1);
         i:=i-1;
     end else begin
         addElem(m2);
         j:=j-1;
     end;
  end;
end;
//dividir el vector en elementos unicos y repetidos
procedure vector.DivRepNoRep(v1, v2: vector);
var i:integer;
begin
  for i:=1 to dim do begin
    if (frec(elem[i])>1) then
      v1.addElem(elem[i])    //elementos repetidos
    else
      v2.addElem(elem[i]);   //elementos unicos
  end;
end;



procedure vector.Dispersion1(v1,v2:vector);
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
   //writeln(ele,' => {',cc,'}');
   v1.addElem(ele);
   v2.addElem(cc);
 end;
end;

procedure vector.Mezcla_A_ordenar1(v1, v2, v3, v4: vector);
var i, j, l,m ,n1, n2, n3, n4, k :Integer;
begin
 i:=v1.dim;  //v1
 j:=v2.dim;  //v2
 l:=v3.dim;  //v2
 m:=v4.dim;  //v2
 k:= v1.dim +v2.dim + v3.dim +v4.dim;// newDim= k = 2 + 3 = 5
  //v1->[ 1 | 7 ]      v2->[ 1 | 3 | 4 ]
   //i=0                   j=0
   dim:=k;
   while( k > 0)do begin
     if (i>0)then
        n1:=v1.Elem[i]     //n1= 1
     else
        n1:=-1;

     if (j>0)then
        n2:=v2.Elem[j]     //n2= -1
     else
        n2:=-1;

     if (l>0)then
        n3:=v3.Elem[l]     //n3= -1
     else
        n3:=-1;

     if (m > 0)then
        n4:=v4.Elem[m]     //n4= -1
     else
        n4:=-1;

     if(n1 >= n2) and (n1>=n3)and(n1>=n4)then begin
         elem[k] := n1;
         i:=i-1;
     end else begin
         if (n2 >= n1)and (n2>=n3)and(n1>=n4)  then begin
          elem[k] := n2;
          j:=j-1;
         end else begin
               if (n3 >= n1)and (n3>=n2)and(n3>=n4)  then begin
                 elem[k] := n3;
                 l:=l-1;
               end else begin
                  elem[k] := n4;
                  m:=m-1;
               end;
         end;
     end;
     k:=k-1;
   end;
end;

procedure vector.Mezcla_A_ordenar(v1, v2: vector);
var i,j,n1,n2:integer;
begin
   i:=1; j:=1;
   //v1->[ 1 | 7 ]      v2->[ 1 | 3 | 6 ]
   // i                4         j            4
  while( (i <= v1.Dim) and (j <= v2.getDim()) )do begin
     n1:=v1.Elem[i];     //n1= 7
     n2:=v2.getElem(j);  //n2= 6
     if(n1 < n2)then begin
         addElem(n1);
         i:=i+1;
     end else begin
         addElem(n2);
         j:=j+1;
  end; //v->[ 1 | 1 | 3 | 6 | 7 | 9 ]
   end;

  while( (i <= v1.getDim()))do begin
     n1:=v1.getElem(i);
     addElem(n1);
     i:=i+1;
   end;

  while( (j <= v2.getDim()))do begin
     n2:=v1.getElem(j);
     addElem(n2);
     j:=j+1;
   end;
end;

{procedure vector.Dispersion();
begin

end;}

procedure vector.SegmenarParImpar(a, b: vector);
var i:integer;
begin
  for i:=1 to dim do begin
    if((elem[i]mod 2)=0)then
     a.AddElem(elem[i])
    else
     b.AddElem(elem[i]);
  end;
end;

procedure vector.intercalar(A, B: vector);
var i,j:integer;
begin
  i:=1;  j:=1;  dim:=0;
  while (i<=A.getDim())AND(j<=B.getDim())do begin
     addElem(A.getElem(i));
     i:=i+1;
     addElem(B.getElem(j));
     j:=j+1;
  end;
  while(i<=A.getDim())do begin
      addElem(A.getElem(i));
      i:=i+1;
  end;
  while(j<=B.getDim())do begin
      addElem(B.getElem(j));
      j:=j+1;
  end;
end;

procedure vector.ejercicio6(A, B, C: vector);
var n,i,x,y,z:integer;    //[1,2,3] [4,5,6] [7,8,9]
begin                     //[1,4,7,2,5,8,3,6,9]
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

procedure vector.ejercicio9();
var i,aux:integer;
begin
 ord_burbuja();
 aux:=dim; dim:=0;
 for i:=1 to (aux-1) do begin
      if(elem[i]<>elem[i+1])Then
         AddElem(getElem(i));
 end;
 AddElem(getElem(aux));
end;

function vector.ElemMenor(): integer;
VAR I,aux:integer;
begin
  aux:=elem[1];
  for i:=2 to (dim) do begin
     if(aux>elem[i])then
        aux:=elem[i];
  end;
  RESULT:=AUX;
end;

procedure vector.ELIMINAR(elemento: integer);
var i,aux:integer;
begin
   aux:=dim; dim:=0;
   for i:=1 to (aux) do begin
     if(elem[i]<>elemento)then
        AddElem(elem[i]);
  end;
end;

procedure vector.ejercicio5(A, B: vector);
var n,i:integer;
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

procedure vector.Divide3(A, B, C: vector);
var n:UNatural;
    i:Integer;
begin
 n:=UNatural.Crear();
 for i:=1 to dim do begin
   n.setValor(elem[i]);

   if(n.getValor() mod 2 = 0)then
      A.addElem(n.getValor());//dim = dim + 1;  [12]

   if(n.getValor() mod 3 = 0)then
      B.addElem(n.getValor());

   if(n.capicua())then
      C.addElem(n.getValor());
 end;
end;

function vector.May(a, b: integer): integer;
var me,i:integer;
begin
 if(a<=b) then begin
   me:=0;
   for i:=a to b do begin
     if(elem[i]>me)then
     me:=elem[i];
   end;
  result:=me;
 end else begin
  result:=0;
 end;

end;

procedure vector.Mezcla_Desc_ordenar(v1, v2: vector);
var i,j,m1,m2:integer;
begin
  i:=1; j:=1;
  while(dim <(v1.dim+v2.Dim))do begin
     m1:=v1.May(i,v1.getDim());  //[9,7] -->1
     m2:=v2.May(j,v2.getDim());  //[6,3] -->3
     if((m1>m2)and(m1>0))or(m2=0)then begin
         addElem(m1);
         i:=i+1;
     end else begin
         addElem(m2);
         j:=j+1;
     end;
  end;
end;

procedure vector.intercalar3Vectores(v1, v2, v3: vector);
var i,i1,i2,i3,n:Integer;
begin //3,1,2
i:= 1;
i1:= 1;
i2:= 1;
i3:= 1;
n:= v1.dim+v2.dim+v3.dim;
while (i<=n) do begin
 if(i3<=v3.dim) then begin
   addElem(v3.elem[i3]);
   i3:=i3+1;
   i:=i+1;
 end;

 if(i1<=v1.dim) then begin
   addElem(v1.elem[i1]);
   i1:=i1+1;
   i:=i+1;
 end;

 if(i2<=v2.dim) then begin
   addElem(v2.elem[i2]);
   i2:=i2+1;
   i:=i+1;
 end;
end;

end;



procedure vector.ejercicio7(B: vector);
var i,aux:integer;
        n:UNatural;
begin
  n:=UNatural.Crear();
  for i:=1 to dim do begin
    n.setValor(elem[i]);
    if(not n.verifPrimo())then   //(ELEM[I]MOD 2==0) MULTIPLOS DE 2
     B.AddElem(n.getValor());    //Insertar no primos
   end;
   aux:=dim;    dim:=0;
  for i:=1 to aux do begin
    n.setValor(elem[i]);
    if( n.verifPrimo())then  //(ELEM[I]MOD 3==0) MULTIPLOS DE 3
     AddElem(n.getValor());  //Insertar  primos
   end;
end;

procedure vector.CorteControlN1();
var i,cc:integer;
begin
 cc:=0; i:=1;
 while(i<=(dim-1)) do begin
   if(elem[i]<> elem[i+1])then
    cc:=cc+1;
  i:=i+1;
 end;
 ShowMessage('Existen <'+inttostr(cc)+'>cortes de conrol de nivel 1');
end;

end.

