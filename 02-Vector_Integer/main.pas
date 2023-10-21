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
    Button5: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
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
        v, v1, v2, v3, v4, v5 :vector;
        VEC: array[0..5] of vector;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
begin
     v1 := vector.crear();
     v2 := vector.crear();
     v3 := vector.crear();
     v4 := vector.crear();
     v5 := vector.crear();
     v := v1;
     VEC[0] := SELF.v;
     VEC[1] := SELF.v1;
     VEC[2] := SELF.v2;
     VEC[3] := SELF.v3;
     VEC[4] := SELF.v4;
     VEC[5] := SELF.v5;
     for i:=1 to 5 do begin
       ComboBox1.Items.Add('Vector' + IntToStr(i));
     end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  v.CargarRnd(
    StrToInt(InputBox('','rango A: ','1')),
    StrToInt(InputBox('','rango B:','10'))
  );
  v.descargar(StringGrid1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit1.Text := v.descargar();
end;

procedure TForm1.Button4Click(Sender: TObject);
 VAR N : integer;
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
   v5.FusionAsc(v1,v2,v3,v4);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  v.RotarDerecha(StrToInt(InputBox('','','')));
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
  v := self.VEC[pos];
  v.descargar(StringGrid1);
end;




end.

