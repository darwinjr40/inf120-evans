unit FAPP_MATRIZ;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, Menus,
  UAPP_MATRIZ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
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
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    SG: TStringGrid;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
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
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    M,M1,M2:Matriz;
    procedure updateSG();
    procedure updateSG1();
    procedure updateSG2();
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

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  Ele.Text:=inttostr(m.Determinante3x3());
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  M.OrdTSi();
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  Ele.Text:=inttostr(m.Determinante2x2());
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  m1.copianula(m,StrToInt(InputBox('Fila Nula','','')),StrToInt(InputBox('columna nula','','')));
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  m1.Adjunta(m);
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
var f,c:integer;
begin
   m1.Adjunta(m);
   SG.colCount:=M1.getcols();
   SG.RowCount:=M1.getfils();
   for f:=1 to M1.getfils() do
   for c:=1 to M1.getcols() do
   SG.cells[c-1,f-1]:= FloatToStr((1/m.Determinante3x3())*(m1.getElem(f,c)));
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
Var f,c,elemento:integer;
begin
  f:=StrToInt(InputBox('Matriz','Filas:','3'));
  c:=StrToInt(InputBox('Matriz','Columnas:','3'));
  M.setfils(f);
  M.setcols(c);
  elemento:=1;
  m.cargarEspiral(1,1,f,c,elemento);
  UpdateSG();
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
 m.setfils(StrToInt(InputBox('filas','','')));
 m.setcols(StrToInt(InputBox('filas','','')));
 m.cargarm1();
 ShowMessage('Matriz dimencionada');
 updateSG();
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
var res:Integer;
begin
 res:=m.FreTSD(strtoint(InputBox('Ingrese','elemento = ','')));
 ShowMessage(inttostr(res));
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
var FRECU,ELEMENTO:Integer;
begin
 ELEMENTO:=M.Ele_May_Fre_TSD();//ELE + REPETIDO
 FRECU:=m.FreTSD(ELEMENTO);
 ShowMessage('Elemento = '+inttostr(elemento)+';   frecuencia = '+inttostr(frecu));
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  m.Ord_TII();
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
begin
   M.setfils(StrToInt(InputBox('FILAS','','')));
   M.setcols(StrToInt(InputBox('COLUMNAS','','')));
   M.cargarTID_C();
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
begin
    M.setfils(StrToInt(InputBox('FILAS','','')));
   M.setcols(StrToInt(InputBox('COLUMNAS','','')));
   M.cargarTID_C2();
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  m.segmentarPI_TID_F();
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  m.TSizq();
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  m.TIderecha();
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  m.DSecundaria();
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  ELE.Text:=IntToStr(M.FrecuTSI(StrToInt(InputBox('INGRESE UN ELEMENTO','',''))));
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  ELE.Text:=IntToStr(m.Ejercicio10());
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
   ELE.Text:=IntToStr(M.FrecuTID(StrToInt(InputBox('INGRESE UN ELEMENTO','',''))));
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  m1.Tranpuesta();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  M:=MAtriz.crear();
  M1:=MAtriz.crear();
  M2:=MAtriz.crear();
  UpdateSG();
end;

procedure TForm1.Button10Click(Sender: TObject);
Var f,c,e:integer;
begin
  f:=StrToInt(InputBox('Matriz','Filas:','3'));
  C:=StrToInt(InputBox('Matriz','Columnas:','3'));
  M.setfils(f);
  M.setcols(c);
 // updateSG();
  for f:=1 to M.getfils() do
  for c:=1 to M.getcols() do  begin
  e:=StrToInt(InputBox('Matriz','M['+IntToStr(f)+','+IntToStr(c)+'] = ','0'));
  //e:=1+Random(10);
   M.setElem(f,c,e);
  end;
  UpdateSG();
end;

procedure TForm1.Button11Click(Sender: TObject);
 var e,f,c:integer;
begin
  f:=-1;
  c:=-1;
  e:=StrToInt(ELE.Text);
  M.busq_sec(e,f,c);
  F1.Text:=IntToStr(f);
  C1.Text:=IntToStr(c);
  ELE.Text:='';
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  M.ord_sele();
  // m.ord_sele1();
   UpdateSG();
end;

procedure TForm1.Button13Click(Sender: TObject);
 Var f,c,e:integer;
 begin
   f:=StrToInt(InputBox('Matriz','Filas:','3'));
   C:=StrToInt(InputBox('Matriz','Columnas:','3'));
   M1.setfils(f);
   M1.setcols(c);
  // updateSG();
   for f:=1 to M1.getfils() do
   for c:=1 to M1.getcols() do  begin
   //e:=StrToInt(InputBox('Matriz','M['+IntToStr(f)+','+IntToStr(c)+'] = ','0'));
   e:=1+Random(10);
    M1.setElem(f,c,e);
   end;
   UpdateSG1();
 end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  UpdateSG();
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  UpdateSG1();
end;

procedure TForm1.Button16Click(Sender: TObject);
begin

end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  UpdateSG2();
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  m2.multiplicacion(m,m1);
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

procedure TForm1.updateSG1();
var f,c:integer;
begin
   SG.colCount:=M1.getcols();
   SG.RowCount:=M1.getfils();
   for f:=1 to M1.getfils() do
   for c:=1 to M1.getcols() do
   SG.cells[c-1,f-1]:= IntToStr(M1.getElem(f,c));
end;

procedure TForm1.updateSG2();
var f,c:integer;
begin
   SG.colCount:=M2.getcols();
   SG.RowCount:=M2.getfils();
   for f:=1 to M2.getfils() do
   for c:=1 to M2.getcols() do
   SG.cells[c-1,f-1]:= IntToStr(M2.getElem(f,c));
end;


end.

