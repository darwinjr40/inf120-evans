unit UTipo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Dialogs,UnitNota;
Type

  TModo = class
    public
      const
       CERRADO = 0;
       ABIERTO = 1;
       LECTURA = 2;
       ESCRITURA = 3;
  end;

   Alumno=Record
     Ci:Integer;
     Reg:Integer;
     Nom:String[60];
     Dir:String[80];
   end;

  Nota=Record  //permite grabar en un solo registro
     Reg:Integer;
     INF110:byte;
     LIN100:byte;
     MAT101:Byte;
     FIS101:Byte;
     INF119:Byte;
  end;


  Tipo=Alumno;  //Alias Tipo=Alumno

  { FileTipo }

  FileTipo=Class
     private
          f : file of Alumno; //
    nom,ext : String;        //Nombre del archivo
       modo : integer; //Lectura o Escritura
    {TENER encuenta
    - se puede escribir cuando (creamos el archivo)o(cuando este abierto"modo lectura")
    - solo podemos sacar la informacion(cuando este abierto"modo lectura")
    }
    public
       Constructor Create();
       Procedure setNom(s:String); //enviar nombre del archivo
       Procedure setExt(s:String); //cargar extencion del archico"txt"
       procedure Crear(); //Crea un archivo nuevo, Activa modo escritura(0)
       procedure Abrir(); //Abre el archivo creado,Activamos modo lectura(1)
       procedure Cerrar(); //cierra un archivo
       procedure EscribirTipo(r:Tipo); //Escribe un registro o fila
       function LeerTipo:Tipo; //devuelve El type de un registro o fila
       function getNom():String; //retorna nombre
       function getExt():String; //retorna extension
       Function EsFin():Boolean; //verifica si llegaste al final de la fila
       {---------Adicionales-------------------}
       procedure Posicionar(pos:Integer);//fijar el puntero en registro
       function tamano():Integer;//Cantidad de registros del archivo
       function getpos():integer;//en que registro me encuentro
       function getModo():Integer;//devuelve en que modo esta el archivo
       function existe():Boolean;
       procedure eliminar(nombre,extension:string);
       procedure cambiar_nom(nombre, extension: String);
       //Permite copiar la informacion de los registros en las variables que entran por "referencia"
       procedure Accesar(var c,r:Integer;var n,d:String;a:integer);
       //modifica grabar un registro en la posicio "a";
       procedure grabar(c,r:Integer;n,d:String;a:integer);
       //Intercambia dos regristros
       procedure permutar(c1, r1: Integer; n1, d1: String;a,c2, r2: Integer; n2, d2: String;b: integer);

       procedure ejerB(c1, r1: Integer; n1, d1: String); //b) Agregar los datos de un Nuevo Alumno.
       function ejerC(registro:Integer):String; //c) buscar por registro y mostrar
       procedure ejerD(CI:Integer;Dom:String);  //d)Modificar el "domicilio" del alumno con CI: 111
       procedure ejerF(registro:Integer); //Elimina un registro
       procedure copia(A:FileTipo); //Copia un registro
       //falta
       procedure ejerI(); //ordena el registro ASCENDENTEMENT por "Nombre"
       procedure ejerJ(); //ordena el registro ASCENDENTEMENT por "registro"
       procedure ejerG(archivoNota : FileNota);
  end;

implementation

{ FileTipo }
//inicializa el nombre que tendra el archivo y activa el modo
constructor FileTipo.Create();
begin
  nom := 'FileTipo';
  ext := 'dat';
  modo := -1;
  //modo := TModo.CERRADO;
end;

procedure FileTipo.setNom(s: String);
begin
  nom:=s;
end;

procedure FileTipo.setExt(s: String);
begin
  ext:=s;
end;

function FileTipo.getNom(): String;
begin
 result:=nom;
end;

function FileTipo.getExt(): String;
begin
 result:=ext;
end;
//Crea un archivo nuevo, Activa modo escritura
procedure FileTipo.Crear();
begin
 //if self.modo = TModo.CERRADO then begin
 //  ShowMessage('El archivo esta abierto');
 //  exit;
 //end;

 Assign(f,nom+'.'+ext);//Asignando un nombre a f
 {$I-}
  Rewrite(f);//Crea o sobreEscribe un nuevo texto
 {$I+}
 if(IOResult<>0)then begin
   ShowMessage('FileTipo.Crear : Error en creacion de TIPO.');
 end else begin //ShowMessage('Texto.Crear : Archivo TXT creado');
   modo:=0;   //0 -> modo escritura
 end;
end;
//abrir modo lectura
procedure FileTipo.Abrir();
begin
  Assign(f,nom+'.'+ext);//Asignando un nombre a f
  {$I-}
  Reset(f);//abre un texto con el nombre que se le asigno
  {$I+}
  if(IOResult<>0)then begin
    ShowMessage('FileTipo.Abrir : Error en apertura de TIPO.');
  end else begin //ShowMessage('Texto.Crear : Archivo TXT Abierto...');
    modo:=1;  //modo lectura
  end;
end;
//antes de usar debe 'posicionar' para saber la posicion del puntero
//Objetivo.-Escribe un registro o fila
procedure FileTipo.EscribirTipo(r: Tipo);
begin
 write(f,r); //escribe lo que tenga r=registro en el objeto.texto
  {if(modo=0)then begin //modo escritura
    write(f,r);
   end else begin
     ShowMessage('FileTipo.escribirChar: Archivo TXT abierto en modo Lectura... ');
   end; }
end;
//antes de usar debe 'posicionar' para saber la posicion del puntero
//Objetivo.-devuelve El type de un registro o fila
function FileTipo.LeerTipo: Tipo;
Var r:Tipo;
begin
  if(modo=1)then begin //modo lectura
    read(f,r)         // r = F.TEXTo[puntero];
  end else begin
    r.Ci:=-1;
    r.Reg:=-1;
    r.Nom:='';
    r.Dir:='';
  end;
    result:=r;
end;
//devuelve true si esta vacion o si llego al ultimo registro
function FileTipo.EsFin(): Boolean;
var r: boolean;
begin
  if (modo = -1)then r:=True else r:=EOf(f);
  Result:=r;
end;
//Cerramos el archivo
procedure FileTipo.Cerrar();
begin
  if (modo = -1) then raise Exception.Create('El archivo estaba CERRADO');
  Close(f);
  modo:=-1;
end;
//Establece el puntero en esa direccion pos
procedure FileTipo.Posicionar(pos: Integer);
begin
 if((pos>=0)and((pos)<=FileSize(f)))then begin
   Seek(f,pos); //texto empieza en el registro 0
 end else begin
   ShowMessage('FileTipo.posicionar: Fuera de rango...');
 end;
end;
//Cantidad de registros empieza en 1
function FileTipo.tamano(): Integer;
begin
result:=FileSize(f);
end;
//filepos inicia en 0, devuelve donde se encuentra el puntero
function FileTipo.getpos(): integer;
begin
 result:=FilePos(f)+1;
end;

function FileTipo.getModo(): Integer;
begin
  result:=modo;
end;

function FileTipo.existe: Boolean;
begin
 Assign(f,self.nom+'.'+self.ext);//Asignando un nombre a f
 {$I-}  Reset(f);  {$I+}  //abrir archivo
 if(IOResult<>0)then begin
   result:=false;
 end else begin
   cerrar();
   result:=true;
 end;
end;

procedure FileTipo.eliminar(nombre, extension: string);
begin
 if(existe())then begin
  Erase(f);
 end else begin
  // ShowMessage('El archivo '+nombre+'.'+extension+' no existe');
 end;
end;

procedure FileTipo.cambiar_nom(nombre, extension: String);
begin
   eliminar(nombre,extension); //elimina, si existe el archivo nombre.extension
   if(existe())then begin //existe "alumnos.dat"
       setNom(nombre); setExt(extension);  //cambiamos nombres del objeto
       Rename(f,nombre+'.'+extension);     //cambiar nombre "alumnos.dat"-->"nuevo.txt"
   end else begin
      ShowMessage('El archivo '+getNom()+'.'+getExt()+' no existe');
   end;
end;

//Variables de referencia para almacenar datos de un registro
procedure FileTipo.Accesar(var c, r: Integer; var n, d: String; a: integer);
var T:Tipo;
begin
 Posicionar(a);//posiciones el puntero;
 T:=LeerTipo();//leemos el tipo
c:=t.Ci;
r:=t.Reg;
n:=t.Nom;
d:=t.Dir;
end;
//inserta datos en el registro en a =puntero
procedure FileTipo.grabar(c, r: Integer; n, d: String;a: integer);
var T:Tipo;
begin
Posicionar(a);//posicionas el puntero
//copiamos loas datos al T:Tipo
T.Ci:=C;
T.Reg:=R;
T.Nom:=N;
T.Dir:=D;
//Escribimos el Tipo
EscribirTipo(T);
end;



procedure FileTipo.ejerB(c1, r1: Integer; n1, d1: String);
var pos:integer;
begin
   if(existe())then begin
      Abrir();
      pos:=tamano()+1;
      grabar(c1,r1,n1,d1,pos);
      Cerrar();
   end else begin
      ShowMessage('El archivo '+getNom()+'.'+getExt()+' no existe');
   end;
end;

function FileTipo.ejerC(registro: Integer): String;
var     c,r,i:integer;
     n,d:String;
begin
 if(existe())then begin
      Abrir();
      i:=1; c:=0;r:=0;n:='';d:='';
      Accesar(c,r,n,d,i);
      while (i<= tamano())and(r<>registro) do begin //busca el ci
        i:=i+1;
        if(i<=tamano())then
           Accesar(c,r,n,d,i);
      end;
      IF(i<=tamano()) then begin//el "ci" existe
          Result:=('Ci = '+IntToStr(c)+#13)+('Registro = '+IntToStr(r)+#10)+('Nombre = '+n+#10)+('Direccion = '+d);
      end else begin
          result:='No existe el registro = '+IntToStr(registro);
      end;
      Cerrar();
  end else begin
      ShowMessage('El archivo '+getNom()+'.'+getExt()+' no existe');
  end;


end;

procedure FileTipo.ejerD(CI: Integer; Dom: String);
var c,r,i:integer;
      n,d:String;
begin
 Abrir();
 i:=1; c:=0;r:=0;n:='';d:='';
  Accesar(c,r,n,d,i);
 while (i<= tamano())and(c<>Ci) do begin //busca el ci
        i:=i+1;
        if(i<=tamano())then
        Accesar(c,r,n,d,i);
 end;
   IF(i<=tamano()) then begin//el "ci" existe
   grabar(c,r,n,Dom,i);
   end else begin
   ShowMessage('No existe el registro con CI = '+IntToStr(Ci));
   end;
   Cerrar();
end;

procedure FileTipo.ejerF(registro: Integer);
var c,r,i,pos:integer;
     n,d:String;
     A:FileTipo;
begin
Abrir();
A:=FileTipo.Create();//'nombre.extencion'
A.Crear(); // sobre escribe un archivo, Activa modo escritura
c:=0;r:=0;n:='';d:='';pos:=0;
for i:=1 to tamano()do begin//grabamos lo que queremos al text nuevo A
     Accesar(c,r,n,d,i);
   if(r<>registro)then begin
     pos:=pos+1;
     A.grabar(c,r,n,d,pos);
   end;
end;
  A.Cerrar();   Cerrar(); //cerramos los archivos que estaban abierto o estabamos escribiendo
  if(pos<>i)then begin  //encontramos el registro
     A.cambiar_nom(getNom(),getExt());
  end else begin
     ShowMessage('No existe el registro = '+IntToStr(registro));
     a.eliminar(a.getNom(),a.getExt());   //eliminamos el objeto a, por que no sirve
  end;
end;

procedure FileTipo.copia(A: FileTipo);
var     c,r,i:integer;
          n,d:String;
begin
A.Abrir();
setNom(getNom());   setExt(getExt());
Crear(); // sobre escribe un archivo, Activa modo escritura
c:=0;r:=0;n:='';d:='';
for i:=1 to A.tamano() do begin
     A.Accesar(c,r,n,d,i);
     grabar(c,r,n,d,i);
end;
A.Cerrar();
Cerrar();
end;

procedure FileTipo.ejerG(archivoNota: FileNota);
var e: Alumno;
    n: UnitNota.Nota;
    nuevo:FileTipo;
begin
  nuevo :=FileTipo.Create();
  nuevo.setNom('AlumnosProgramacion');
  nuevo.Crear();
  archivoNota.Abrir();
  Abrir();

  while(not EsFin())do begin
       e := LeerTipo;
       n := archivoNota.LeerTipo;
       if (n.INF110 > 50) then begin
           nuevo.EscribirTipo(e);
       end;
  end;
  Cerrar();
  archivoNota.Cerrar();
  nuevo.Cerrar();
end;

//ordenar por 'nombre' el archivo
procedure FileTipo.ejerI();
var          i,j:integer;
     c1,r1,c2,r2:Integer;
     n1,d1,n2,d2:String;
begin
 Abrir();
 c1:=0;r1:=0;n1:='';d1:='';
 c2:=0;r2:=0;n2:='';d2:='';
 //Ordenamiento burbuja
for i:=1 to (tamano()-1)do begin
 Accesar(c1,r1,n1,d1,i);
    for j:=i+1 to tamano()do begin
    Accesar(c2,r2,n2,d2,j);
      if(n1>n2)then begin
        permutar(c1,r1,n1,d1,i,c2,r2,n2,d2,j);
        Accesar(c1,r1,n1,d1,i);
      end;
   end;
end;
Cerrar();
end;

procedure FileTipo.ejerJ();
var          i,j:integer; //PUNTEROS
     c1,r1,c2,r2:Integer;
     n1,d1,n2,d2:String;
begin
 Abrir();
 c1:=0;r1:=0;n1:='';d1:='';
 c2:=0;r2:=0;n2:='';d2:='';
 for i:=1 to (tamano()-1)do begin
 Accesar(c1,r1,n1,d1,i);
    for j:=i+1 to tamano()do begin
    Accesar(c2,r2,n2,d2,j);
      if(r1>r2)then begin
        permutar(c1,r1,n1,d1,i,c2,r2,n2,d2,j);
        Accesar(c1,r1,n1,d1,i);
        end;
    end;
 end;
 Cerrar();
end;

//Intercambiamos dos posiciones de un mismo registro punteros->(a)^(b)
procedure FileTipo.permutar(c1, r1: Integer; n1, d1: String; a,
                            c2, r2: Integer; n2, d2: String; b: integer);
begin
  grabar(c1,r1,n1,d1,b);
  grabar(c2,r2,n2,d2,a);
end;

end.

