unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, Menus,uvector;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
        v :vector;
        VEC: array[1..5] of vector;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
begin
     for i:=1 to 5 do begin
       ComboBox1.Items.Add('Vector' + IntToStr(i));
       VEC[i] := vector.crear();
     end;
     ComboBox1.ItemIndex := 0;
     v := VEC[1];
end;

procedure TForm1.Button2Click(Sender: TObject);
var a, b : integer;
begin
  a := StrToInt(InputBox('','rango A: ','1'));
  b := StrToInt(InputBox('','rango B:','10'));
  v.CargarRnd(a, b);
  v.descargar(StringGrid1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit1.Text := v.descargar();
end;

procedure TForm1.Button4Click(Sender: TObject);
 //VAR N : integer;
begin
  //v.ord_seleccion();
  //v.CargarMult2yMul3(v2,v3);
  //v.ejercicio9();
  //ShowMessage(IntToStr(v.elementoModa()));
  //v.mezclarDesc(v1,v2);
  //v.intercalar3Vectores(v1,v2,v3)

  //v.RotarIzquierdaV2(StrToInt(InputBox('','','')));
     //CTRL + /
   //n := StrToInt(InputBox('','','')); //'12'=> 12
   //V.addAsc(n);
   //v.FusionAsc(vec[1], vec[2], vec[3],vec[4]);
   v.RotarDerecha(StrToInt(InputBox('','','')));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  v.Cargar();
  v.descargar(StringGrid1);
end;



procedure TForm1.ComboBox1Change(Sender: TObject);
var pos: integer;
begin
  pos := ComboBox1.ItemIndex;
  {comentar rapido => ctrl + / }
  ShowMessage(inttostr(pos));
  v := self.VEC[pos+1];
  v.descargar(StringGrid1);
end;




end.

