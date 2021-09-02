unit MainFormAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TForm4 = class(TForm)
    Image1: TImage;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Image2: TImage;
    dayBirth: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    akType: TLabel;
    NameUser: TLabel;
    Label1: TLabel;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure ClearBooks();
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Reprint();
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure UpdateAk();
    procedure Button1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
   user: string;
   ACol, ARow: Integer;
implementation
          uses DataBas, AddBook, Search, Main, Users;
{$R *.dfm}

procedure TForm4.Button3Click(Sender: TObject);
var name: string;
begin

 if ARow <> -1 then begin
   name := StringGrid1.Cells[0, ARow];
      Form2.ADOQuery1.SQL.Clear;
     Form2.ADOQuery1.SQL.Add('DELETE FROM Books WHERE BookName='+#39+name+#39);
     Form2.ADOQuery1.ExecSQL;
     Reprint();
 end
 else ShowMessage('Ничего не выбрано');
     ARow := -1;
end;

procedure TForm4.Button4Click(Sender: TObject);
var name: string;
c:Integer;
begin
  if ARow = -1 then
     ShowMessage('Ничего не выбрано') else
     begin
     name := StringGrid1.Cells[0, ARow];
     c := strtoint(StringGrid1.Cells[3, ARow])-1;
     if c = 0 then
      begin
       Form2.ADOQuery1.SQL.Clear;
     Form2.ADOQuery1.SQL.Add('DELETE FROM Books WHERE BookName='+#39+name+#39);
     Form2.ADOQuery1.ExecSQL;
     Reprint();
     end else
     begin
     Form2.ADOQuery1.SQL.Clear;
     Form2.ADOQuery1.SQL.Add('UPDATE Books SET CountBooks='+inttostr(c)+' WHERE BookName='''+name+'''');
     Form2.ADOQuery1.ExecSQL;
     end;

     Reprint();
      end;
  ARow := -1;
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  Form10.Show;
end;

procedure TForm4.Button6Click(Sender: TObject);
begin
 Reprint();
end;

procedure TForm4.Reprint();
var i,j : integer;
begin
    StringGrid1.RowCount := 1;
     StringGrid1.Cells[0,0] := 'Название книжного издания';
  StringGrid1.Cells[1,0] := 'Автор';
  StringGrid1.Cells[2,0] := 'Жанр';
  StringGrid1.Cells[3,0] := 'Количество';

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Books');
  Form2.ADOQuery1.Open;


  for j := 1 to Form2.ADOQuery1.RecordCount do
  begin
    StringGrid1.RowCount :=   StringGrid1.RowCount+1;
    StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('BookName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Author').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Genre').Value;
    StringGrid1.Cells[3,j] :=  Form2.ADOQuery1.FieldByName('CountBooks').Value;

    Form2.ADOQuery1.Next;
  end;
  Form2.ADOQuery1.SQL.Clear;
end;

procedure TForm4.ClearBooks();
var i,j : integer;
begin
    StringGrid1.RowCount :=1;
end;

procedure TForm4.FormShow(Sender: TObject);
var j: integer;
begin

  StringGrid1.RowCount := 20;
StringGrid1.Cells[0,0] := 'Название книжного издания';
  StringGrid1.Cells[1,0] := 'Автор';
  StringGrid1.Cells[2,0] := 'Жанр';
  StringGrid1.Cells[3,0] := 'Количество';

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Books;');
  Form2.ADOQuery1.Open;

  for j := 1 to Form2.ADOQuery1.RecordCount do
  begin
    StringGrid1.RowCount :=   StringGrid1.RowCount+1;
    StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('BookName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Author').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Genre').Value;
    StringGrid1.Cells[3,j] :=  Form2.ADOQuery1.FieldByName('CountBooks').Value;

    Form2.ADOQuery1.Next;

  end;
  Form2.ADOQuery1.SQL.Clear;
  UpdateAk();
end;
procedure TForm4.Image3Click(Sender: TObject);
begin
 Form1.Show;
 Form4.Close;
end;

procedure TForm4.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
StringGrid1.MouseToCell(X, Y, ACol, ARow);//Получаем индексы ячейки ACol и ARow
  //Перемещаем фокус в ячейку с этими индексами:
  StringGrid1.Col:=ACol;
  StringGrid1.Row:=ARow;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
 Form7.Show;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
 Form5.Show;
end;

procedure TForm4.UpdateAk();
var i,j : integer;
begin

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Users WHERE UserName='''+Main.Form1.Edit1.Text+'''');
  Form2.ADOQuery1.Open;
  i :=    Form2.ADOQuery1.FieldByName('Id').Value;
    NameUser.Caption := Main.Form1.Edit1.Text;
    dayBirth.Caption := Form2.ADOQuery1.FieldByName('Birthday').Value;
    akType.Caption := Form2.ADOQuery1.FieldByName('Role').Value;
end;

  end.
