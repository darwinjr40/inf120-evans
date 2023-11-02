unit Formulario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls, Grids,
  Conjunto,Cadenas;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
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
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    cad,cad2,cad3:cadena;  //objetos de la clase cadena
    procedure updateSG();
    procedure updateSG2();
  public

  end;

var
  Form1: TForm1;
   C:conjuntos;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
   cad:= cadena.crear(); //inicializando objeto
   updateSG();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     cad.AddPal((InputBox('Ingrese una palabra','','')));
     cad.descargar(StringGrid1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   cad.descargar(StringGrid1);
  Edit1.Text:='';
  edit2.Text:='';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cad:= cadena.crear(); //inicializando objeto
  cad2:= cadena.crear(); //inicializando objeto
  cad3:= cadena.crear(); //inicializando objeto
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  cad.ejercicio6(Edit1.Text,Edit3.Text);
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
Edit3.Text:=cad.invertirPal();//estas como hola
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
cad.ConverMayus();
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
     cad2:= cadena.crear(); //inicializando objeto
     updateSG2();
     cad2.AddPal((InputBox('Ingrese una palabra','','')));
     updateSG2();
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  updateSG2();
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
Edit1.Text:=cad.Verif_primo(StrToInt(InputBox('posicion del vector','','')));
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  cad.ejercicio10(InputBox('palabra a eliminar','',''));
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  ShowMessage(IntToStr(cad.cantCaracteres()));
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
begin
  ShowMessage(FloatToStr(cad.LongMedia()));
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  ShowMessage(cad.Ppal_UltCaracter());
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  ShowMessage(IntToStr(cad.cantpal_Fin(cad.Ppal_UltCaracter)));
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
 cad.setDim(StrToInt(InputBox('ingrese dimension','','')));
 updateSG();
end;

procedure TForm1.MenuItem24Click(Sender: TObject);
begin
  cad3:= cadena.crear(); //inicializando objeto
  cad3.AddPal((InputBox('Ingrese una palabra','','')));
  cad3.descargar(StringGrid1);
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  cad3.descargar(StringGrid1);
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  cad.ejercicio6(cad2,cad3);
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  cad.EliminarAll(InputBox('Ingrese la palabra que eliminara','',''));
  //cad.delPalabrasRepetidas();
end;

procedure TForm1.MenuItem29Click(Sender: TObject);
begin
  cad.mostrarNum();
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Edit2.Text:=IntToStr(cad.frecuenciaPal(InputBox('Ingrese la palabra que contara','','')));
end;

procedure TForm1.MenuItem30Click(Sender: TObject);
begin
  cad.InvertirCadaPalabra;
end;

procedure TForm1.MenuItem31Click(Sender: TObject);
var k : byte;
begin
  k := StrToInt(InputBox('','Ingrese el desplazamiento: ','3'));
  cad.Encriptar(k);
end;

procedure TForm1.MenuItem32Click(Sender: TObject);
var k : byte;
begin
  k := StrToInt(InputBox('','Ingrese el desplazamiento: ','3'));
  cad.Desencriptar(k);
end;

procedure TForm1.MenuItem33Click(Sender: TObject);
var cant: word;
begin
  //edit3.Text:= IntToStr(cad.Posicion(
  //  StrToInt(InputBox('','rango a','')),
  //  StrToInt(InputBox('','rango b','')),
  //  InputBox('','sub cadena: ','h')
  //));
  cant:= StrToInt(InputBox('','cantidad',''));
  self.cad.RotarIzq(cant);
end;

procedure TForm1.MenuItem34Click(Sender: TObject);
var cant: word;
begin
   cant:= StrToInt(InputBox('','cantidad',''));
  self.cad.RotarDer(cant);
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Edit2.Text:=IntToStr(cad.CantPal());
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
 edit2.Text:=IntToStr(cad.BuscPal(InputBox('Ingrese la palabra','','')));
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  cad.InserPal(StrToInt(InputBox('Posicion donde insertara','','')),InputBox('ingrese la palabra','',''));
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  cad.Eliminar(InputBox('Ingrese la palabra que eliminara','',''));
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  cad.ReemPal(InputBox('','Ingrese palabra existente',''),InputBox('','Ingrese la nueva palabra',''));
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
var pal:String;
begin
pal:=InputBox('palabra buscada','','');//'hola'
cad2:= cadena.crear(); //inicializando objeto
cad.ejercicio1(cad2,pal);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
 cad.Invertir();
end;

procedure TForm1.updateSG();
var i :integer;
begin
  StringGrid1.ColCount:=cad.getDim();
  for i:=1 to cad.getDim  do
     StringGrid1.Cells[i-1,0]:=cad.getChar(i);
                 //columna,fila
end;

procedure TForm1.updateSG2();
var i :integer;
begin
  StringGrid2.ColCount:=cad2.getDim();
  for i:=1 to cad2.getDim  do
    StringGrid2.Cells[i-1,0]:=cad2.getChar(i);
                 //columna,fila
end;

end.

