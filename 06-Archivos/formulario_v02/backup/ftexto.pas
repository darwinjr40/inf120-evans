unit Ftexto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,Utexto,Cadenas;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
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
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
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
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);

  private
   T, T1, T2:Texto;
  public
     procedure SeleccionarArchivoV1(a :Texto);
     procedure SeleccionarArchivoV2(archivo: texto );
     procedure GuardarArchivoComo(archivo: texto );
     procedure GuardarMemoToFile(archivo:texto);
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
 T2:=Texto.create();
end;

procedure TForm1.MChange(Sender: TObject);
begin

end;
//creamos archivo nuevo(listo para escribir)
procedure TForm1.MenuItem13Click(Sender: TObject);
begin
 M.Clear();
end;
//Abrimos un archivo y lo inserta en el MEMO para visualizar
procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  if(OD.Execute)then begin //Abrimos ventana OpenDialog 'para buscar el archivo'
    T.setNom(OD.FileName);
    T.abrir();
    M.Clear();
    while(not t.esfin())do begin
      m.Lines.Add( T.leerLinea() );
    end;
     T.cerrar();//Cerramos el objeto text
     Caption:='Mi Block de Notas : '+T.getnom();
  end;
end;
//Sobre escribimos el objeto,Copiamos lo del memo al objeto
procedure TForm1.MenuItem15Click(Sender: TObject);
begin
 self.GuardarMemoToFile(self.t);
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
VAR i : integer;
begin
 if(SD.Execute)then begin //ABRE LA VENTA SaveDialog 'GUARDAR COMO'
   t.setNom(sd.FileName);
   self.GuardarMemoToFile(self.t);
 end;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
begin
  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    T.Copiar(T1, 'copia.txt');
  end;
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    T.eliminar();
  end;
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin

  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    T.Invertir(T1);
  end;
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
var nombre:String;
begin
  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    nombre:=InputBox('Ingrese nuevo Nombre del Archivo','Nombre','nuevo.txt');
    T.cambiarNombre(nombre);
  end;
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
begin
  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    T.invOrdenDePalabrasCadaFila();
  end;
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    T.leerNumReales(t1,'numeros','txt');
  end;
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  if(OD.Execute)then begin
    T.setNom(OD.FileName);
    T1.informe(T);
  end;
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
  SeleccionarArchivoV2(T);//OpenDialog : CARGAR NOMBRE Y EXTENSION AL OBJETO
  T.frecuenciaDePalabras('salida-frec-palabras.txt');
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
var p, may : real;
begin
  t.MayorYpromedio(p, may);
  ShowMessage('promedio: ' + FloatToStr(p));
  ShowMessage('mayor: ' + FloatToStr(may));
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
 ShowMessage('SELECCIONA EL ARCHIVO N1');
 self.SeleccionarArchivoV2(self.T1);
 //ShowMessage(t1.getnom() + '.'+t1.getExt());
 ShowMessage('SELECCIONA EL ARCHIVO N2');
 self.SeleccionarArchivoV2(self.T2);

 //ShowMessage(t2.getnom() + '.'+t2.getExt());
 ShowMessage('NOMBRE DEL ARCHIVO A GUARDAR:');
 self.GuardarArchivoComo(T); //guardamos el nom y ext
 self.T.mezclar(self.t1, self.t2);
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
var cad: Cadena;
begin
  cad := Cadena.crear();
  cad.AddPal('La PROgramacion');
  cad.cifradoInvertidoVocales();
  Cadena.CifrarVocal('a');
  ShowMessage(cad.descargar());
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  SeleccionarArchivoV2(T);
  T.CifrarVocales('salida-cifrar-vocales.txt');
end;

procedure TForm1.SeleccionarArchivoV1(a: Texto);
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
    nom := Copy(nom,LastDelimiter('\',nom)+1,Length(nom) - LastDelimiter('\',nom));
    a.setNom(nom);//Set 'nombre' del archivo
    i:=i+1;
    ext:='';
    while(OD.FileName[i]<>'.')do begin
      ext:=ext+od.FileName[i];
      i:=i+1;
    end;
    Caption:='Mi Block de Notas : '+a.getnom();
  end;
end;

procedure TForm1.SeleccionarArchivoV2(archivo: texto);
VAR select: boolean;
begin
  select := OD.Execute();
  if(select)then begin
   archivo.setNom(od.FileName);
  end;
  //if(OD.Execute)then begin
  //  nom:='';
  //  ext:='';
  //  i:=1;
  //  while(OD.FileName[i]<>'.')do begin//
  //    nom:=nom+od.FileName[i];
  //    i:=i+1;
  //  end;
  //  i:=i+1;
  //  while(OD.FileName[i]<>'.')do begin
  //    ext:=ext+od.FileName[i];
  //    i:=i+1;
  //  end;
  //  archivo.setNom(nom);
  //end;
end;

procedure TForm1.GuardarArchivoComo(archivo: texto);
VAR ext,nom:String;
          i:integer;
    sw: boolean;
begin
 sw := SD.Execute; //ABRE LA VENTA SaveDialog 'GUARDAR COMO'
 if(not sw)then begin
   raise Exception.Create('No se puede dividir por cero');
 end;

 nom:='';
 i:=1;
 while(SD.FileName[i]<>'.')do begin
 nom:=nom+Sd.FileName[i];
 i:=i+1;
 end;
 archivo.setNom(nom);
 i:=i+1;
 ext:='';
 while(Sd.FileName[i]<>'.')do begin
 ext:=ext+SD.FileName[i];
 i:=i+1;
 end;

end;

procedure TForm1.GuardarMemoToFile(archivo: texto);
var i : word;
begin
 t.crear();
 i:=0;
 while(i < M.Lines.Count)do begin
   T.escribirLinea(m.Lines[i]);
   i:=i+1;
 end;
 T.cerrar();
end;






end.

