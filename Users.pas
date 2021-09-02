unit Users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Image1: TImage;
    StringGrid1: TStringGrid;
    Button5: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ClearBooks();
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  ACol, ARow: Integer;

implementation
   uses DataBas, UserCange, UserFilter;
{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
 if ARow = -1 then
  ShowMessage('Ничего не выбрано') else
  begin
    Form9.Show;

    Form9.Edit1.Text := StringGrid1.Cells[0,ARow];
    Form9.DateTimePicker1.DateTime :=StrTODate(StringGrid1.Cells[1,ARow]);
    UserCange.NameUser := StringGrid1.Cells[0,ARow];
    if StringGrid1.Cells[2,ARow] = 'Admin' then
    Form9.ComboBox1.ItemIndex := 0 else Form9.ComboBox1.ItemIndex := 1;

  end;
end;

procedure TForm7.Button2Click(Sender: TObject);
var j:integer;
begin
ClearBooks();
   StringGrid1.Cells[0,0] := 'Имя аккаунта';
  StringGrid1.Cells[1,0] := 'День рождения';
  StringGrid1.Cells[2,0] := 'Тип аккаунта';

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Users');
  Form2.ADOQuery1.Open;


  for j := 1 to Form2.ADOQuery1.RecordCount do
  begin
    StringGrid1.RowCount :=   StringGrid1.RowCount+1;
    StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('UserName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Birthday').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Role').Value;
    Form2.ADOQuery1.Next;
  end;
end;

procedure TForm7.Button5Click(Sender: TObject);
begin
    Form8.Show;
end;

procedure TForm7.FormShow(Sender: TObject);
var j:integer;
begin
ARow:=-1;
ClearBooks();
 StringGrid1.Cells[0,0] := 'Имя аккаунта';
  StringGrid1.Cells[1,0] := 'День рождения';
  StringGrid1.Cells[2,0] := 'Тип аккаунта';

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Users');
  Form2.ADOQuery1.Open;


  for j := 1 to Form2.ADOQuery1.RecordCount do
  begin
    StringGrid1.RowCount :=   StringGrid1.RowCount+1;
    StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('UserName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Birthday').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Role').Value;
    Form2.ADOQuery1.Next;
  end;
end;
procedure TForm7.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
StringGrid1.MouseToCell(X, Y, ACol, ARow);//Получаем индексы ячейки ACol и ARow
  //Перемещаем фокус в ячейку с этими индексами:
  StringGrid1.Col:=ACol;
  StringGrid1.Row:=ARow;
end;

procedure TForm7.ClearBooks();
var i,j : integer;
begin
    StringGrid1.RowCount :=1;
end;
end.
