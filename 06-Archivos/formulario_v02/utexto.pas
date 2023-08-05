unit Utexto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs,Cadenas;
 type
      { Texto }
      TEstado=Class
        public
        const
        LECTURA=0;
        ESCRITURA=1;
        CERRADO=3;
      end;

      { Texto }
      Texto=Class
      private
        f:text;
        nom:String;
        estado:byte;  //0..127  integer = - 2^32-1
      PUBLIC
        constructor create();
        constructor create(n:String);
        procedure setNom(s:String);
        function getnom():String;
        procedure crear();
        procedure abrir();
        //Escribe un caracter, primero deve crear(estado escritura"0")
        procedure escribirChar(c:char);
        //te retorna un caracter
        function leerChar():char;
        //Escribe un String y salta, primero deve crear(estado escritura"0")
        procedure escribirLinea(linea:String);
        //te retorna Un String
        function leerLinea():String;
        //devuelve True si el puntero de archivo ha llegado al final del archivo o si esta vacío
        function esfin():Boolean;
        //Cantidad de registros del archivo
         function tamano():Integer;
        //Cierra un archivo
        procedure cerrar();
        //obtener una linea en una posicion
        function get(pos:integer):String;
        procedure Inv_Pal(O:Texto);
        {PRACTICO}

        {1.- Realice un programa que me permita copiar un archivo texto llamado
        "texto.txt" a otro "copia.txt". cargar en A}

        procedure Copiar(A:texto; nombre :String);

        {2.- Realice un programa que me permite eliminar un archivo llamado
        "copia.txt".}
        procedure eliminar();

        {3.- Realice un programa que me permita copiar de forma invertida
        (es decir la última fila como primer fila, la segunda como penúltima y así.}
        procedure Invertir(A:texto);

        {4.- Realice un programa que me permite renombre un archivo llamado
        "texto.txt" a "nuevo.txt".}
        procedure cambiarNombre(nombre : String);

        {5.- Realice un programa que me permita invertir el orden las palabras
        de cada fila de un archivo llamado "texto.txt".}
         procedure invOrdenDePalabrasCadaFila();   //en el mismo archivo

        {6.- Escriba un programa que lea los números reales que hay en el fichero de texto
         'numeros.txt' y los almacene en el fichero secuencial de reales 'numeros.dat'.
         Para comprobar que funciona el programa, construya otro programa PASCAL que muestre por
         pantalla los números almacenados en el fichero 'numeros.dat'.
         Para que la información sea más legible, deberán mostrarse, mientras sea posible,
         6 números en cada línea.}
         procedure leerNumReales(a : Texto; nombre, extension: String );
         procedure Num_real(O:Texto);
         procedure Num_reall(O:Texto);
        {7.- Escriba un programa denominado 'informe.exe', que analice el fichero de texto, cuyo nombre
             se especifica interactivamente, y muestre por pantalla la siguiente información:
             a)  para cada línea del fichero:
            •El número total de caracteres y de palabras, y la longitud media de una palabra.
            •La letra con que termina la primera palabra y el número de palabras que terminan con esa letra.
            b)  para el fichero completo:
            •El número total de caracteres, palabras y líneas del fichero, y la longitud media de una palabra.
            •El número de la línea en la que hay más palabras, junto con el número de palabras en esa línea.
            •El número de la línea en la que hay más palabras que acaban como la primera, junto con el número de dichas palabras.}
        procedure informe(O:Texto);
        procedure mezclar(ta, tb :Texto);
        //examen
        procedure frecuenciaDePalabras(new : Texto);
        procedure MayorYpromedio(var promedio, mayor : real);
 end;

implementation

{ Texto }
// 2 = Error;      0 = escritura;    1 = lectura;
constructor Texto.create();
begin
  nom:='texto.txt';
  estado:=TEstado.CERRADO;
end;

constructor Texto.create(n : String);
begin
  nom:=n;
  estado:=TEstado.CERRADO;
end;

//set 'Nombre del archivo'
procedure Texto.setNom(s: String);
begin
    nom:=s;
end;

function Texto.getnom(): String;
begin
  result:=nom;
end;

//Creamos un archivo 'modo = 0' //preparado para poder escribir
procedure Texto.crear();
begin
  if self.estado <> TEstado.CERRADO then begin
   ShowMessage('crear: archivo anda abierto');
   exit;
  end;
  Assign(f, self.nom);//Asignando
  {$I-}
  Rewrite(f);    //crear archivo o re escribir
  {$I+}
  if(IOResult<>0)then begin
    ShowMessage('Texto.Crear : Error en creacion TXT.');
    exit;
  end;
  estado:= TEstado.ESCRITURA;
end;
//modo=0 'escritura' escribimos una linea o fila
procedure Texto.escribirLinea(linea: String);
begin
  if self.estado = TEstado.CERRADO then begin
   ShowMessage('Texto.escribirChar: Archivo Cerrado');
   exit;
  end;
  if self.estado = TEstado.LECTURA then begin
   ShowMessage('Texto.escribirChar: Archivo Modo Lectura');
   exit;
  end;
  writeln(f,linea);
end;
//Cerramos el archivo
procedure Texto.cerrar();
begin
  if self.estado = TEstado.CERRADO then begin
   ShowMessage('Texto.cerrar: Archivo modo Cerrado');
   exit;
  end;
  Close(f);
  self.estado:=TEstado.CERRADO;
end;
//pos empieza en 1
function Texto.get(pos: integer): String;
var cad:String;
      i:Integer;
begin
 if(pos>=1)and(pos<=tamano())then begin
   abrir();
   i:=0;
   while((not esfin())and(i<pos))do begin
       cad:=leerLinea();
       i:=i+1;
   end;
   cerrar();
   if(i=pos) then
     result:=cad;
   end else begin
   result:='No existe posicion  '+IntToStr(pos);
 end;
end;


//abre un archivo para ver que contiene ; modo=1 modo lectura
procedure Texto.abrir();
begin
 if self.estado <> TEstado.CERRADO then begin
   ShowMessage('abrir: archivo esta abierto');
   exit;
 end;
 Assign(f, self.nom);
 {$I-}
 Reset(f);          //busca abrir "nom.ext"
 {$I+}
 if(IOResult<>0)then begin
   ShowMessage('Texto.Abrir : Error en apertura de TXT.');
   exit;
 end;
 estado:=TEstado.LECTURA;
end;

procedure Texto.escribirChar(c: char);
begin
 if self.estado = TEstado.CERRADO then begin
   ShowMessage('Texto.escribirChar: Archivo Cerrado');
   exit;
 end;
 if self.estado = TEstado.LECTURA then begin
   ShowMessage('Texto.escribirChar: Archivo Modo Lectura');
   exit;
 end;
 write(f,c);
end;

function Texto.leerChar(): char;
var c:char;
begin
 if(estado=TEstado.LECTURA)then read(f,c) else c:=char(0);
 result:=c;
end;

//devuelve una linea ,//el siguiente llamado devuelva la siguiente
function Texto.leerLinea(): String;
var linea:String;
begin
 if(estado=TEstado.LECTURA)then readln(f,linea) else linea:=char(0);
 result:=linea;
end;
//devuelve True si el puntero de archivo ha llegado al final del archivo o si esta vacío
function Texto.esfin(): Boolean;
var sw: boolean;
begin
 if (estado = TEstado.CERRADO) then sw:=true else sw:=EOf(f);
 Result := sw;
end;

function Texto.tamano(): Integer;
var c:integer;
begin
 abrir();
 c:=0;
 while(not esfin())do begin
      leerLinea();
      c:=c+1;
 end;
 cerrar();
 result:=c;
end;

procedure Texto.Copiar(A: texto; nombre: String);
begin
   abrir();
   A.setNom(nombre);
   A.crear();
   while(not esfin())do begin
     A.escribirLinea(leerLinea() );
   end;
   cerrar();
   A.cerrar();
end;
procedure Texto.eliminar();
begin
  Assign(f, self.nom);
  Erase(f);
end;

procedure Texto.Invertir(A: texto);
var i,cant:integer;
    cad:String;
begin
     A.setNom(InputBox('Archivo copia','nombre = ','copia.txt'));
     A.crear();
     cant := tamano();
     for i:= cant downto 1 do begin
       cad:=get(i);           //abre y cierra el A.texto
       A.escribirLinea(cad);
     end;
       A.cerrar();
end;
//el archivo tiene que estar cerrado para poder cambiar
procedure Texto.cambiarNombre(nombre: String);
//var  aux:Texto;
begin
      Assign(f, self.nom);
      Rename(f, nombre);
end;

procedure Texto.Inv_Pal(O: Texto);
var i,cant,pos,n:Integer;
     cad,cad2:String;
begin
  setNom('darwin');
  crear();
  cant:=O.tamano(); cad2:='';
  for i:=1 to cant do begin
      cad:=O.get(i);
      n:=Length(cad);
       while(n>0)do begin
           cad:=Trim(cad);    //trim elimna espacios
           pos:=LastDelimiter(' ',cad);
           cad2:=cad2+Copy(cad,pos+1,n-pos)+' ';
           SetLength(cad,pos-1);
           n:=Length(cad);
       end;
       escribirLinea(cad2);
       cad2:='';
  end;
  cerrar();
end;

procedure Texto.invOrdenDePalabrasCadaFila();
var  a:Texto;
     cad:cadena;
begin
    cad:=cadena.crear;
    a:=Texto.create('auxiliar.txt');
    a.crear();
    abrir();
    while (not esfin()) do begin
       cad.AddPal(leerLinea());
       a.escribirLinea(cad.invertirPal());
       cad.setDim(0);
    end;
    cerrar();
    self.eliminar();
    a.cerrar();
    a.cambiarNombre(getnom()); //se convierte en el archivo original"texto.txt"
end;

procedure Texto.leerNumReales(a: Texto; nombre, extension: String);
var i : Integer;
    pal : String;
    v :cadena;
begin
     a.setNom(nombre);
     abrir();
     a.crear();
     v := cadena.crear();
     i:=1; pal:='';
     while (not esfin()) do begin
        v.AddPal(leerLinea());
        while (i <= v.getDim()) do begin
           v.leerNumReales(i, pal);
           if (pal <> '') then begin
             a.escribirLinea(pal);
           end;
        end;
        i := 1;
        v.setDim(0);
     end;
     a.cerrar();
     cerrar();
end;

procedure Texto.Num_real(O: Texto);
var i,j,cant,pos,n,c:Integer;
     pal:String;
     cad:cadena;
begin
  setNom('numeros');
  crear();
  cant:=O.tamano();
  for i:=1 to cant do begin
     cad:=cadena.crear;
     cad.AddPal(o.get(i));
     cad.selectReal();
     pos:=1; pal:='';
      while(pos<=cad.getDim())do begin
         cad.LeerPal(pos,pal);
         if(pal<>'')and(LastDelimiter('.',pal)>1)then begin
             escribirLinea(pal);
         end;
      end;
  end;
  cerrar();
end;

procedure Texto.Num_reall(O: Texto);
var i,cant,pos,n,c:Integer;
     cad,cad2:String;
begin
  setNom('numeros');
  crear();
  cant:=O.tamano(); cad2:='';
  for i:=1 to cant do begin
      cad:=O.get(i);
      n:=Length(cad);
      c:=1;
       while(c<=n)do begin
         if(cad[c]in ['1','2','3','4','5','6','7','8','9','0','.',',']) then
          cad2:=cad2+cad[c]
          else
          cad2:=cad2+' ';
         c:=c+1;
       end;
       cad:=cad2;
       cad2:='';
       n:=Length(cad);
       while(n>0)do begin
           cad:=Trim(cad);
           pos:=LastDelimiter(' ',cad);
           escribirLinea(Copy(cad,pos+1,n-pos));
           //cad2:=cad2+Copy(cad,pos+1,n-pos)+' ';
           SetLength(cad,pos-1);
           n:=Length(cad);
       end;
       cad2:='';
  end;
  cerrar();
end;
                        //archivo original
procedure Texto.informe(O: Texto);
var n,i,lres,lres2,scarac,spal,maypal,mayterm:Integer;
    cad:cadena;
    smedia:REAL;
    cadenafil,linea,carac,pal,media,cantTerm:String;
    term:char;
begin
 n:=O.tamano();
 create();
 setNom('Informe.txt');
 crear(); //CREANDO
 escribirLinea('línea  tot.car.  tot.Palabras   long.media  term.1ªPal.   igualTermin. ');
 scarac:=0;  spal:=0;  mayterm:=0;  smedia:=0.0;  maypal:=0;  mayterm:=0;
 for i:=1 to n do begin
    cad:=cadena.crear();  //REINICIA LA CADENA
    cadenafil:=o.get(i);
    cad.AddPal(cadenafil);

    linea:=IntToStr(i);
    carac:=IntToStr(cad.cantCaracteres());
    pal:=IntToStr(cad.CantPal());
    media:=FloatToStr(cad.LongMedia());
    SetLength(media,LastDelimiter(',',media)+2);
    term:=cad.Ppal_UltCaracter();          //letra con que termina la primera palabra
    cantTerm:=IntToStr(cad.cantpal_Fin(term));//número de palabras que terminan con esa letra.
    escribirLinea(linea+'          '+carac+'                 '+pal+'                  '+media+'                  '+term+'                   '+cantTerm);

    scarac:=scarac+cad.cantCaracteres();
    spal:=spal+cad.CantPal();
    smedia:=smedia+StrToFloat(media);
    if(cad.CantPal()>maypal)then begin
        maypal:=cad.CantPal();
        lres:=i;
    end;
    if(cad.cantpal_Fin(term)>mayterm)then begin
      mayterm:=cad.cantpal_Fin(term);
      lres2:=i;
    end;
 end;
 escribirLinea('Total : '+ IntToStr(n)+' Líneas, '+inttostr(scarac)+' caracteres y '+inTtostr(spal)+' palabras. Long Media palabra = '+FLOATToStr(smedia) );
 escribirLinea('linea con mas palabras : la n° '+inttostr(lres)+' con '+inttostr(maypal)+' palabras');
 escribirLinea('La Línea n° '+inttostr(lres2)+' tiene el mayor n° de palabras que terminan como la primera:  '+Inttostr(mayterm));
 cerrar();
end;

procedure Texto.mezclar(ta, tb: Texto);
VAR cad : STRING;
begin
  self.crear();
  ta.abrir();
  tb.abrir();
  while (not ta.esfin()) and (not tb.esfin()) do begin
    cad := ta.leerLinea();
    self.escribirLinea( cad);
    cad := tb.leerLinea();
    self.escribirLinea( cad);
  end;

  while (not ta.esfin())do
    self.escribirLinea( ta.leerLinea() );

  while (not tb.esfin())do
    self.escribirLinea( tb.leerLinea() );
  ta.cerrar();
  tb.cerrar();
  self.cerrar();
end;



procedure Texto.frecuenciaDePalabras(new: Texto);
var v : cadena;
    i, moda: Integer;
    pal:String;
begin
    self.abrir();
    new.crear();  //listo para escribir
    v := cadena.crear();
    //pasar el texto al objeto cadena
    while(not esfin()) do begin
      v.AddPal(leerLinea());
    end;
    //cargado la cadena con el archivo texto
    //recorremos todo la cadena
    i:=1;
    while (i <= v.getDim()) do begin
      v.LeerPal(i, pal);//cargamos la primera palabra
      if (pal <> '') then begin //se cargo una palabra
         moda := v.frecuenciaPal(pal); //moda 3
                                       //pal = maria
         new.escribirLinea(pal + '     '+ IntToStr(moda));
         v.EliminarAll(pal);
         i:=1;
      end;
    end;
    cerrar();
    new.cerrar();
end;

procedure Texto.MayorYpromedio(var promedio, mayor: real);
begin

 promedio :=5.5;
 mayor := 10;

end;






{ "Assing(f,'cadena')"
 asignamos a un text(f) un nombre
}
{    "rewrite(f)"
 crea un nuevo archivo (o sobre-escribe en uno existente) y lo abre
para procesamiento con el apuntador de registro colocado en el registro 0.
}
{     "Reset(f)"
abre un archivo existente para procesamiento y coloca el apuntador de registro
en el primer registro (0).
}
{      "Append(f);"
 ->abre un archivo con su nombre, si esta abierto lo cierra y lo vuelve abrir
   y posiciona el puntero ala ultima fila para poder hacer "writeln(f,'hola')"
    y luego procedemos a "cerrar"
}
{         "Erase(f)"
Éste procedimiento nos permite borrar un archivo, el archivo a borrar no debe
estar abierto
}
{    #Rename(f,nombre_archivo)#
Éste procedimiento renombra (cambia el nombre) un archivo externo.
}

end.

