unit Utexto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs,Cadenas;
 type

      { Texto }

      Texto=Class
      private
        f:text;
        nom,ext:String;
        modo:byte;  //0..127  integer = - 2^32-1
        //leer
        //escritura
        //error
      PUBLIC
        constructor create();
        constructor create(n,e:String);
        procedure setNom(s:String);
        procedure setExt(s:String);
        function getnom():String;
        function getExt():String;
        procedure crear();
        procedure abrir();
        //Escribe un caracter, primero deve crear(modo escritura"0")
        procedure escribirChar(c:char);
        //te retorna un caracter
        function leerChar():char;
        //Escribe un String y salta, primero deve crear(modo escritura"0")
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
        //Existe el archivo
        function existe(nombre,extension:String):boolean;
        function existe():boolean;
        procedure Inv_Pal(O:Texto);
        {PRACTICO}

        {1.- Realice un programa que me permita copiar un archivo texto llamado
        "texto.txt" a otro "copia.txt". cargar en A}

        procedure Copiar(A:texto; nombre,extension :String);

        {2.- Realice un programa que me permite eliminar un archivo llamado
        "copia.txt".}
        procedure eliminar();

        {3.- Realice un programa que me permita copiar de forma invertida
        (es decir la última fila como primer fila, la segunda como penúltima y así.}
        procedure Invertir(A:texto);

        {4.- Realice un programa que me permite renombre un archivo llamado
        "texto.txt" a "nuevo.txt".}
        procedure cambiarNombre(nombre, extension: String);

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

        //examen
        procedure frecuenciaDePalabras(new : Texto);
        procedure MayorYpromedio(var promedio, mayor : real);
 end;

implementation

{ Texto }
// 2 = Error;      0 = escritura;    1 = lectura;
constructor Texto.create();
begin
  nom:='texto';
  ext:='txt';
  modo:=2;
end;

constructor Texto.create(n, e: String);
begin
  nom:=n;
  ext:=e;
  modo:=2;
end;

//set 'Nombre del archivo'
procedure Texto.setNom(s: String);
begin
    nom:=s;
end;
//set 'Nombre de la extension'
procedure Texto.setExt(s: String);
begin
    ext:=s;
end;

function Texto.getnom(): String;
begin
  result:=nom;
end;

function Texto.getExt(): String;
begin
   result:=ext;
end;
//Creamos un archivo 'modo = 0' //preparado para poder escribir
procedure Texto.crear();
begin
 Assign(f,nom+'.'+ext);//Asignando
  {$I-}
  Rewrite(f);    //crear archivo o re escribir
  {$I+}
  if(IOResult<>0)then begin
    ShowMessage('Texto.Crear : Error en creacion TXT.');
  end else begin  //modo escritura
    ShowMessage('Texto.Crear : Archivo TXT creado');
    modo:=0;
  end;
end;
//modo=0 'escritura' escribimos una linea o fila
procedure Texto.escribirLinea(linea: String);
begin
 if(modo=0)then begin //modo escritura
    writeln(f,linea);
  end else begin
    ShowMessage('Texto.escribirLinea: Archivo TXT abierto en modo Lectura... ');
  end;
end;
//Cerramos el archivo
procedure Texto.cerrar();
begin
Close(f);
modo:=2;
end;
//pos empieza en 1
function Texto.get(pos: integer): String;
var cad:String;
      i:Integer;
begin
 if(pos>0)and(pos<=tamano())then begin
 abrir();i:=0;
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

function Texto.existe(nombre, extension: String): boolean;
begin
    Assign(f,nombre+'.'+extension);
    {$I-}  Reset(f);  {$I+}  //abrir archivo
    if(IOResult<>0)then begin
      //ShowMessage('El archivo '+nombre+'.'+extension+' no existe');
      result:=false;
    end else begin
      cerrar();
      result:=true;
    end;
end;

function Texto.existe(): boolean;
begin
    Assign(f,nom+'.'+ext);
    {$I-}  Reset(f);  {$I+}  //abrir archivo
    if(IOResult<>0)then begin
      ShowMessage('El archivo "'+nom+'.'+ext+'" no existe');
      result:=false;
    end else begin
      cerrar();
      result:=true;
    end;
end;

//abre un archivo para ver que contiene ; modo=1 modo lectura
procedure Texto.abrir();
begin
  Assign(f,nom+'.'+ext);
    {$I-}
    Reset(f);          //busca abrir "nom.ext"
    {$I+}
    if(IOResult<>0)then begin
      ShowMessage('Texto.Abrir : Error en apertura de TXT.');
    end else begin  //modo lectura
//      ShowMessage('Texto.Crear : Archivo TXT Abierto...');
      modo:=1;
    end;
end;

procedure Texto.escribirChar(c: char);
begin
 if(modo=0)then begin //modo escritura
   write(f,c);
 end else begin
   ShowMessage('Texto.escribirChar: Archivo TXT abierto en modo Lectura... ');
 end;
end;

function Texto.leerChar(): char;
var c:char;
begin
 if(modo=1)then begin //modo lectura
   read(f,c)
 end else begin
   c:=char(0);
 end;
   result:=c;
end;

//devuelve una linea ,//el siguiente llamado devuelva la siguiente
function Texto.leerLinea(): String;
var linea:String;
begin
 if(modo=1)then begin //modo lectura
   readln(f,linea)    //se carga esa fila en la variable "linea"
 end else begin
   linea:='';
 end;
   result:=linea;
end;
//devuelve True si el puntero de archivo ha llegado al final del archivo o si esta vacío
function Texto.esfin(): Boolean;
begin
 Result:=EOf(f);
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

procedure Texto.Copiar(A: texto; nombre, extension: String);
begin
 if(existe())then begin //existe el archivo
   abrir();
   A.setNom(nombre);
   A.setExt(extension);
   A.crear();
   while(not esfin())do begin
     A.escribirLinea(leerLinea() );
   end;
   cerrar();
   A.cerrar();
 end;
end;
procedure Texto.eliminar();
begin
 if(existe()) then begin
    Erase(f);
 end;
end;

procedure Texto.Invertir(A: texto);
var i,cant:integer;
    cad:String;
begin
  if(existe())then begin
     A.setNom(InputBox('Archivo copia','nombre = ','copia'));
     A.setExt(InputBox('archivo copia','extencion = ','txt'));
     A.crear();
     cant := tamano();
      for i:=cant downto 1 do begin
          cad:=get(i);           //abre y cierra el A.texto
          A.escribirLinea(cad);
      end;
       A.cerrar();
   end;
end;
//el archivo tiene que estar cerrado para poder cambiar
procedure Texto.cambiarNombre(nombre, extension: String);
var  aux:Texto;
begin
   if (existe()) then begin
      aux := Texto.create(nombre, extension); //objeto aux
      aux.eliminar();                         //procedemos a eliminar si es que existe archivo
      setNom(nombre); setExt(extension);
      Rename(f,getnom() + '.'+ getExt());
   end;
end;

procedure Texto.Inv_Pal(O: Texto);
var i,cant,pos,n:Integer;
     cad,cad2:String;
begin
  setNom('darwin'); setExt('txt');
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
 if(existe())then begin
    a:=Texto.create('pal','txt');
    a.crear(); //listo para escribir
    cad:=cadena.crear;
    abrir();
    while (not esfin()) do begin
       cad.AddPal(leerLinea());
       a.escribirLinea(cad.invertirPal());
       cad.setDim(0);
       //a.escribirLinea(cad.descargar());
    end;
    cerrar();
    a.cerrar();
    a.cambiarNombre(getnom(),getExt()); //se convierte en el archivo original"texto.txt"
  end;
end;

procedure Texto.leerNumReales(a: Texto; nombre, extension: String);
var i : Integer;
    pal : String;
    v :cadena;
begin
  if (existe()) then begin
     a.setNom(nombre); a.setExt(extension);
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
end;

procedure Texto.Num_real(O: Texto);
var i,j,cant,pos,n,c:Integer;
     pal:String;
     cad:cadena;
begin
  setNom('numeros'); setExt('dat');
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
  setNom('numeros'); setExt('dat');
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
 setNom('Informe'); setExt('txt');
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

procedure Texto.frecuenciaDePalabras(new: Texto);
var v : cadena;
    i, moda: Integer;
    pal:String;
begin
 if (existe()) then begin
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

