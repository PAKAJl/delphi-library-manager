unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TForm3 = class(TForm)
    Image1: TImage;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    NameUser: TLabel;
    Label2: TLabel;
    dayBirth: TLabel;
    Label4: TLabel;
    akType: TLabel;
    Label6: TLabel;
    booksCount: TLabel;
    Button6: TButton;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure ClearBooks();
    procedure AllBooks();
    procedure MyBooks();
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
      procedure Reprint();
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure UpdateAk();
    procedure Button6Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  user: string;
  ARow, ACol : integer;

implementation
uses DataBas, SearchUsersForm, Main;
{$R *.dfm}

procedure TForm3.FormShow(Sender: TObject);
var
  i, j: Integer;
begin
  StringGrid1.Cells[0,0] := 'Название книжного издания';
  StringGrid1.Cells[1,0] := 'Автор';
  StringGrid1.Cells[2,0] := 'Жанр';
  StringGrid1.Cells[3,0] := 'Количество';

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Books;');
  Form2.ADOQuery1.Open;

  for j := 1 to Form2.ADOTable2.RecordCount do
  begin
  StringGrid1.RowCount :=   StringGrid1.RowCount+1;
    StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('BookName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Author').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Genre').Value;
    StringGrid1.Cells[3,j] :=  Form2.ADOQuery1.FieldByName('CountBooks').Value;

    Form2.ADOQuery1.Next;
  end;

  UpdateAk();
end;

procedure TForm3.Image3Click(Sender: TObject);
begin
Form1.Show;
 Form3.Close;
end;

procedure TForm3.AllBooks();
var j:integer;
begin
    ClearBooks();

    Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Books;');
  Form2.ADOQuery1.Open;

  for j := 1 to Form2.ADOTable2.RecordCount do
  begin
  StringGrid1.RowCount :=   StringGrid1.RowCount+1;
    StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('BookName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Author').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Genre').Value;
    StringGrid1.Cells[3,j] :=  Form2.ADOQuery1.FieldByName('CountBooks').Value;

    Form2.ADOQuery1.Next;
  end;
end;

procedure TForm3.MyBooks();
var j, id: integer;
var idCart, BookId, UserId, bn: string;
var list:string;
begin
    ClearBooks();
     StringGrid1.ColCount :=  3;
     Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT Id FROM Users WHERE UserName='''+user+'''');
    Form2.ADOQuery1.Open;
    UserId  := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);

Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM Cards WHERE UserId='+UserId);
    Form2.ADOQuery1.Open;
    idCart := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);

    Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM BooksOrder Where CardId='+idCart);
    Form2.ADOQuery1.Open;


    for j := 1 to Form2.ADOQuery1.RecordCount do
  begin
     StringGrid1.RowCount :=  StringGrid1.RowCount+1;


    Form2.ADOQuery2.SQL.Clear;
    Form2.ADOQuery2.SQL.Add('SELECT * FROM Books Where Id='+inttostr(Form2.ADOQuery1.FieldByName('BookId').Value));
    Form2.ADOQuery2.Open;

    StringGrid1.Cells[0,j] :=  Form2.ADOQuery2.FieldByName('BookName').Value;
    StringGrid1.Cells[1,j] :=  Form2.ADOQuery2.FieldByName('Author').Value;
    StringGrid1.Cells[2,j] :=  Form2.ADOQuery2.FieldByName('Genre').Value;

    Form2.ADOQuery1.Next;
  end;
end;

procedure TForm3.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
StringGrid1.MouseToCell(X, Y, ACol, ARow);//Получаем индексы ячейки ACol и ARow
  //Перемещаем фокус в ячейку с этими индексами:
  StringGrid1.Col:=ACol;
  StringGrid1.Row:=ARow;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
 AllBooks();
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
 MyBooks();
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  Form6.Show;
end;

procedure TForm3.Button4Click(Sender: TObject);
var idCart, BookId, UserId, bn: string;
c:integer;
begin
Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT Id FROM Users WHERE UserName='''+user+'''');
    Form2.ADOQuery1.Open;
    UserId  := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);

Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM Cards WHERE UserId='+UserId);
    Form2.ADOQuery1.Open;
    idCart := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);
 bn:=StringGrid1.Cells[0, ARow];
Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM Books WHERE BookName='''+bn+'''');
    Form2.ADOQuery1.Open;

    BookId := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);
    Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM BooksOrder WHERE BookId='+BookId+' AND CardId = '+idCart);
    Form2.ADOQuery1.Open;

    if Form2.ADOQuery1.RecordCount = 0 then
    begin
         Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('INSERT INTO BooksOrder(CardId, BookId) VALUES ('+idCart+','+BookId+')');
    Form2.ADOQuery1.ExecSQL;

      begin
     name := StringGrid1.Cells[0, ARow];
     c := strtoint(StringGrid1.Cells[3, ARow])-1;
     if c = 0 then
      begin
     end else
     begin
     Form2.ADOQuery1.SQL.Clear;
     Form2.ADOQuery1.SQL.Add('UPDATE Books SET CountBooks='+inttostr(c)+' WHERE BookName='''+name+'''');
     Form2.ADOQuery1.ExecSQL;
     end;

     Reprint();
      end;
    end else
    ShowMessage('Такая книга уже взята');



end;

procedure TForm3.Button5Click(Sender: TObject);
var idCart, BookId, UserId, bn: string;
c:integer;
begin
  Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT Id FROM Users WHERE UserName='''+user+'''');
    Form2.ADOQuery1.Open;
    UserId  := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);

Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM Cards WHERE UserId='+UserId);
    Form2.ADOQuery1.Open;
    idCart := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);
 bn:=StringGrid1.Cells[0, ARow];
Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM Books WHERE BookName='''+bn+'''');
    Form2.ADOQuery1.Open;

    c:= Form2.ADOQuery1.FieldByName('CountBooks').Value+1;

    BookId := inttostr(Form2.ADOQuery1.FieldByName('Id').Value);
    Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM BooksOrder WHERE BookId='+BookId+' AND CardId = '+idCart);
    Form2.ADOQuery1.Open;


         Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('DELETE FROM BooksOrder WHERE CardId='+idCart+' AND BookId='+BookId);
    Form2.ADOQuery1.ExecSQL;

     name := StringGrid1.Cells[0, ARow];
     if c = 0 then
      begin
     end else
     begin
     Form2.ADOQuery1.SQL.Clear;
     Form2.ADOQuery1.SQL.Add('UPDATE Books SET CountBooks='+inttostr(c)+' WHERE BookName='''+name+'''');
     Form2.ADOQuery1.ExecSQL;
     end;
     ShowMessage('Книга возвращена');
     Reprint();

end;

procedure TForm3.Button6Click(Sender: TObject);
begin
 Reprint();
end;

procedure TForm3.Reprint();
var i,j : integer;
begin
ClearBooks();
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

  UpdateAk()
end;

procedure TForm3.ClearBooks();
var i,j : integer;
begin
    StringGrid1.RowCount :=1;
    StringGrid1.ColCount :=4;
end;

procedure TForm3.UpdateAk();
var i,j : integer;
begin

  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT * FROM Users WHERE UserName='''+Main.Form1.Edit1.Text+'''');
  Form2.ADOQuery1.Open;
  i :=    Form2.ADOQuery1.FieldByName('Id').Value;
    NameUser.Caption := Main.Form1.Edit1.Text;
    dayBirth.Caption := Form2.ADOQuery1.FieldByName('Birthday').Value;
    akType.Caption := Form2.ADOQuery1.FieldByName('Role').Value;
  Form2.ADOQuery1.SQL.Clear;
    Form2.ADOQuery1.SQL.Add('SELECT * FROM Cards WHERE UserId='+inttostr(i));
    Form2.ADOQuery1.Open;
    j := Form2.ADOQuery1.FieldByName('Id').Value;


  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT COUNT(*) AS b1 FROM BooksOrder WHERE CardId='+inttostr(j));
  Form2.ADOQuery1.Open;
  booksCount.Caption:= Form2.ADOQuery1.FieldByName('b1').Value
end;

end.
