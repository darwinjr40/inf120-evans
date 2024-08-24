unit FMatriz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Menus, StdCtrls,
  UAPP_MATRIZ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private
    m,m1,m2,m3,m4:Matriz;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     m1 := Matriz.crear();
     m2 := Matriz.crear();
     m3 := Matriz.crear();
     m4 := Matriz.crear();
     self.m := m1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   m.CargarMRnd(1,10);
   m.descargarm(StringGrid1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   m.CargarM();
   m.descargarm(StringGrid1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  m.descargarM(StringGrid2);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
     case(ComboBox1.ItemIndex) of //
     0: {nada};//mostrar vector
     1: m := m1;
     2: m := m2;
     3: m := m3;
     4: m := m4;
     else ShowMessage('ERROR');
    end;
    m.descargarM(StringGrid1);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
   m.setfils(StrToInt(InputBox('Cantidad ','Filas:','')));
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
   m.setcols(StrToInt(InputBox('Cantidad ','Columnas:','')));
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
   m1.descargarM(StringGrid1);
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
VAR ELE:INTEGER;
begin
  //m.DSecundaria();
   //ELE:=StrToInt(InputBox('','ELEMENTO',''));
   //ShowMessage(IntToStr(M.FrecuTSI(ELE)));
   //ShowMessage(IntToStr(M.Ejercicio10()));
   //m.OrdTSi(); updateSG1();
   //ShowMessage(IntToStr(m.FreTSD(ELE)));
   //ShowMessage(IntToStr(m.Ele_May_Fre_TSD()));
  // M.Ord_TII();   updateSG1();
   // m.Ordenar_Fil_NumPar();  updateSG1();
   //m.cargaTsd(); updateSG1();
   //m1.Mejor(); m2.descargarM(StringGrid1);
   //m.TransponerTriangSinTp();
   m.TransponerSinTriprincipal();
   //m1.TranpuestaTII1();

  //try
  //  //m4.multiplica(m1,m2);
  //  m1.setfils(3);
  //  m1.setcols(4);
  //
  //  m1.setElem(1,1, 2);
  //  m1.setElem(1,2, 4);
  //  m1.setElem(1,3, 6);
  //  m1.setElem(1,4, 18);
  //
  //  m1.setElem(2,1,4);
  //  m1.setElem(2,2, 5);
  //  m1.setElem(2,3, 6);
  //  m1.setElem(2,4, 24);
  //
  //  m1.setElem(3,1,3 );
  //  m1.setElem(3,2, 1);
  //  m1.setElem(3,3, -2);
  //  m1.setElem(3,4, 4);
  //  ShowMessage(m1.EcuacionMatriz());
  //except
  //  on E:Exception do
  //    ShowMessage('Se ha producido un error: ' + E.Message);
  //end;

  //m.cargaTSI();
end;





end.

