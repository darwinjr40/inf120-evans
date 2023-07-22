unit Ftexto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,Utexto,Cadenas;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu2: TMainMenu;
    M: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem9: TMenuItem;
    OD: TOpenDialog;
    SD: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure MChange(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);

  private
   T,T1:Texto;
  public
     procedure abrirArchivo(a :Texto);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormCreate(Sender: TObject);
begin
 T:=Texto.create();
 T1:=Texto.create();
end;

procedure TForm1.MChange(Sender: TObject);
begin

end;
//creamos archivo nuevo(listo para escribir)
procedure TForm1.MenuItem13Click(Sender: TObject);
begin
 //T.crear();
 Caption:='Mi Block de Notas : '+T.getnom()+'.'+t.getExt();
 M.Clear();
end;
//Abrimos un archivo y lo inserta en el MEMO para visualizar
procedure TForm1.MenuItem14Click(Sender: TObject);
VAR ext,nom,linea:String;
          i:integer;
begin
  if(OD.Execute)then begin //Abrimos ventana OpenDialog 'para buscar el archivo'
    nom:='';
    i:=1; //puntero del Opendialog empiezan en 1
    while(OD.FileName[i]<>'.')do begin//
      nom:=nom+od.FileName[i];//concatenamos character * character hasta un '.'
      i:=i+1;
    end;
    T.setNom(nom);//Set 'nombre' del archivo
    i:=i+1;
    ext:='';
    while(OD.FileName[i]<>'.')do begin
      ext:=ext+od.FileName[i];
      i:=i+1;
    end;
    T.setExt(ext);//set 'nombre' de extencion'txt'
    T.abrir();    //Abrimos el objeto de "Texto"
     {m.Lines.Add(t.getnom());  //muestra la direccion y el nombre hasta un '.'}
    //m.Lines.LoadFromFile(OD.FileName);//LEYENDO MEMO
    M.Clear();
    while(not t.esfin())do begin
      linea:=T.leerLinea(); //Le pasamos una linea y luego la siguiente
      m.Lines.Add(linea);  //Adicionas Una linea al 'Memo''textbox'
    end;
     T.cerrar();//Cerramos el objeto text
     Caption:='Mi Block de Notas : '+T.getnom()+'.'+t.getExt();
  end;
end;
//Sobre escribimos el objeto,Copiamos lo del memo al objeto
procedure TForm1.MenuItem15Click(Sender: TObject);
var i:integer;
begin
 T.crear();
 i:=0;
 while(i < M.Lines.Count)do begin //0 < (cantidad de filas))Memo
  T.escribirLinea(m.Lines[i]);    //Set 'Linea' fila 1 (Memo)
  i:=i+1;
 end;
  T.cerrar();
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
VAR ext,nom:String;
          i:integer;
begin
 if(SD.Execute)then begin //ABRE LA VENTA SaveDialog 'GUARDAR COMO'
  //Caption:=SD.FileName; //Verificamos si guarda direccion del archivo
   nom:='';
   i:=1;
   while(SD.FileName[i]<>'.')do begin
   nom:=nom+Sd.FileName[i];
   i:=i+1;
   end;
   T.setNom(nom);
   i:=i+1;
   ext:='';
   while(Sd.FileName[i]<>'.')do begin
   ext:=ext+SD.FileName[i];
   i:=i+1;
   end;
   T.setExt(ext);
   T.crear();
   {m.Lines.Add(t.getnom());  //muestra la direccion y el nombre hasta un '.'}
   //m.Lines.LoadFromFile(OD.FileName);//LEYENDO MEMO
   i:=0;
   while(i < M.Lines.Count)do begin
    T.escribirLinea(m.Lines[i]); //Escribimos lo del memo al objeto
    i:=i+1;
   end;
   T.cerrar();
   Caption:='Mi Block de Notas : '+T.getnom()+'.'+t.getExt();//caption del formulario 'TForm1'
 end;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
begin
  abrirArchivo(T);
  T.Copiar(T1, 'copia', 'txt');
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem21Click(Sender: TObject);
var nombre,extension:String;
begin
  //nombre:=InputBox('Ingrese el Archivo a eliminar','Nombre','');
  //extension:=InputBox('Ingrese el Archivo a eliminar ','Extensión','');
  abrirArchivo(T);
  T.eliminar();
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
 //T .-->Archivo original
  abrirArchivo(T);
  T.Invertir(T1);
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  ShowMessage(IntToStr(t.tamano()));
end;

procedure TForm1.MenuItem24Click(Sender: TObject);
var pos:Integer;
begin
  pos:=StrToInt(InputBox('ingrese una Posicion','',''));
  ShowMessage(t.get(pos));
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
var nombre,extension:String;
begin
  abrirArchivo(T);
  nombre:=InputBox('Ingrese nuevo Nombre del Archivo','Nombre','');
  extension:=InputBox('Ingrese nueva Extension para el Archivo','Extensión','');
  T.cambiarNombre(nombre, extension);
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
begin
  abrirArchivo(T);
  T.invOrdenDePalabrasCadaFila();
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  abrirArchivo(T);
  T.leerNumReales(t1,'numeros','txt');
  //T1.Num_real(T);
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
 //t.setNom('nuevo'); t.setExt('txt');
 T1.informe(T);
end;

procedure TForm1.MenuItem29Click(Sender: TObject);
var cad:cadena;
begin
 cad:=cadena.crear();
 cad.AddPal(InputBox('','cadena = ',''));
 cad.selectReal();
 ShowMessage(cad.descargar());
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  abrirArchivo(T);//OpenDialog : CARGAR NOMBRE Y EXTENSION AL OBJETO
  self.T1.setNom('salida');
  self.T1.setExt('txt');
  T.frecuenciaDePalabras(T1);
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
var p, may : real;
begin
  t.MayorYpromedio(p, m);
  ShowMessage('promedio: ' + FloatToStr(p));
  ShowMessage('mayor: ' + FloatToStr(may));
end;

procedure TForm1.abrirArchivo(a: Texto);
VAR ext,nom,linea:String;
          i:integer;
begin
  ShowMessage('Seleccionar el archivo principal');
  if(OD.Execute)then begin //Abrimos ventana OpenDialog 'para buscar el archivo'
    nom:='';
    i:=1; //puntero del Opendialog empiezan en 1
    while(OD.FileName[i]<>'.')do begin//
      nom:=nom+od.FileName[i];//concatenamos character * character hasta un '.'
      i:=i+1;
    end;
    nom := Copy(nom,LastDelimiter('\',nom)+1,Length(nom) - LastDelimiter('\',nom));
    a.setNom(nom);//Set 'nombre' del archivo
    i:=i+1;
    ext:='';
    while(OD.FileName[i]<>'.')do begin
      ext:=ext+od.FileName[i];
      i:=i+1;
    end;
    a.setExt(ext);//set 'extencion' del archivo'txt'
    Caption:='Mi Block de Notas : '+a.getnom()+'.'+a.getExt();
  end;
end;




end.

