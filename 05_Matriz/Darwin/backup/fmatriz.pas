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
    m1,m2,m3,m4:Matriz;
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
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   case(ComboBox1.ItemIndex) of
     0: ShowMessage('seleccione un Vector');
     1: begin
             m1.CargarMRnd(1,10);
             m1.descargarm(StringGrid1);
        end;
     2: begin
             m2.CargarMRnd(1,10);
             m2.descargarm(StringGrid1);
        end;
     3: begin
             m3.CargarMRnd(1,10);
             m3.descargarm(StringGrid1);
        end;
     4: begin
             m4.CargarMRnd(1,10);
             m4.descargarm(StringGrid1);
        end;
     else ShowMessage('ERROR');
    end;
  ComboBox1.ItemIndex:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     case(ComboBox1.ItemIndex) of
     0: ShowMessage('seleccione un Vector');
     1: begin
             m1.CargarM();
             m1.descargarm(StringGrid1);
        end;
     2: begin
             m2.CargarM();
             m2.descargarm(StringGrid1);
        end;
     3: begin
             m3.CargarM();
             m3.descargarm(StringGrid1);
        end;
     4: begin
             m4.CargarM();
             m4.descargarm(StringGrid1);
        end;
     else ShowMessage('ERROR');
    end;
  ComboBox1.ItemIndex:=0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  m1.descargarM(StringGrid2);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
     case(ComboBox1.ItemIndex) of //
     0: {nada};//mostrar vector
     1: m1.descargarM(StringGrid1);
     2: m2.descargarM(StringGrid1);
     3: m3.descargarM(StringGrid1);
     4: m4.descargarM(StringGrid1);
     else ShowMessage('ERROR');
    end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
VAR a,b:Integer;
begin
   m1:=Matriz.crear();
   m1.setfils(StrToInt(InputBox('Cantidad ','Filas','')));
   m1.setcols(StrToInt(InputBox('Cantidad ','Columnas','')));
   a:=StrToInt(InputBox('Rango','A',''));
   b:=StrToInt(InputBox('Rango','B',''));
   m1.CargarMRnd(a,b);
   m1.descargarM(StringGrid1);
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
   m1:=Matriz.crear();
   m1.setfils(StrToInt(InputBox('Cantidad ','Filas','')));
   m1.setcols(StrToInt(InputBox('Cantidad ','Columnas','')));
   m1.CargarM();
   m1.descargarM(StringGrid1);
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
   //m1.TransponerTriangSinTp();
   //m1.TranpuestaTII1();


  try
    m4.multiplica(m1,m2);
  except
    on E:Exception do
      ShowMessage('Se ha producido un error: ' + E.Message);
  end;
end;





end.

