unit FAPP_MATRIZ;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, Menus,
  UAPP_MATRIZ,UotrasTecnicas,Cadenas;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ELE: TEdit;
    F1: TEdit;
    F2: TEdit;
    C1: TEdit;
    C2: TEdit;
    L1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    SG: TStringGrid;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ELEChange(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
  private
    M:Matriz;
    A:OtrasTecnicas;
    Cad:cadena;
    procedure updateSG();
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button9Click(Sender: TObject);
begin
  CLOSE();
end;

procedure TForm1.ELEChange(Sender: TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
Ele.Text:=IntToStr(M.ejercicio6(strtoint(InputBox('','fa','')),strtoint(InputBox('','fb','')),strtoint(InputBox('','ca','')),strtoint(InputBox('','cb',''))));
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
 a:=OtrasTecnicas.Crear;
 a.cargar();
 m.ejercicio9(a);
 updateSG();
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
   ele.Text:=m.ejercicio8();
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  ele.Text:=IntToStr(m.MenNumFils(StrToInt(InputBox('ingrese una fila','',''))));
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
 m.permutarFils(1,2);
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  m.Ordenar_Fil_NumPar();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  M:=MAtriz.crear();
  UpdateSG();
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
   M.cargar();
   UpdateSG();
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  UpdateSG();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  M.setElem(StrToInt(F1.Text),StrToInt(C1.Text),StrToInt(ele.Text));
  C1.Text:='';
  F1.Text:='';
  ele.Text:='';
  UpdateSG();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ele.Text:=IntToStr(M.getElem(StrToInt(f1.Text),StrToInt(c1.Text)));
  c1.Text:='';
  f1.Text:='';
  updateSG();
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  M.setfils(StrToInt(ele.Text));
  ele.Text:='';
  updateSG();
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ele.Text:=IntToStr(M.getfils());
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  M.setcols(StrToInt(ele.Text));
  ele.Text:='';
  updateSG();
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  ele.Text:=IntToStr(M.getcols());
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  M.interElem(StrToInt(f1.Text),StrToInt(c1.Text),StrToInt(f2.Text),StrToInt(c2.Text));
  f1.Text:='';
  c1.Text:='';
  f2.Text:='';
  c2.Text:='';
  UpdateSG();
end;

procedure TForm1.updateSG();
var f,c:integer;
begin
   SG.colCount:=M.getcols();
   SG.RowCount:=M.getfils();
   for f:=1 to M.getfils() do
   for c:=1 to M.getcols() do
   SG.cells[c-1,f-1]:= IntToStr(M.getElem(f,c));
end;


end.

