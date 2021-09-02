unit SearchUsersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm6 = class(TForm)
    Image2: TImage;
    Button5: TButton;
    Image1: TImage;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
  uses MainForm, DataBas;
{$R *.dfm}

procedure TForm6.Button5Click(Sender: TObject);
var typeS, par:string;
j:Integer;
begin
  if (Edit1.Text = '') or (Combobox1.ItemIndex = -1) then
    ShowMessage('Одно или несколько полей пусты!')
    else
    begin
      if Combobox1.ItemIndex = 0 then
      begin
         typeS :='BookName';
         par:= #39+Edit1.Text+#39;
      end;

      if Combobox1.ItemIndex = 1 then
      begin
         typeS :='Author';
         par:= #39+Edit1.Text+#39;
      end;
      if Combobox1.ItemIndex = 2 then
      begin
         typeS :='Genre';
         par:= #39+Edit1.Text+#39;
      end;
      if Combobox1.ItemIndex = 3 then
      begin
         typeS :='CountBooks';
         par:= #39+Edit1.Text+#39;
      end;

            Form3.StringGrid1.RowCount := 1;

      Form2.ADOQuery2.SQL.Clear;
      Form2.ADOQuery2.SQL.Add('SELECT * FROM Books Where '+typeS+'='+par);
      Form2.ADOQuery2.Open;

      for j := 1 to Form2.ADOQuery2.RecordCount do
  begin
    Form3.StringGrid1.RowCount :=   Form3.StringGrid1.RowCount+1;
    Form3.StringGrid1.Cells[0,j] :=  Form2.ADOQuery2.FieldByName('BookName').Value;
    Form3.StringGrid1.Cells[1,j] :=  Form2.ADOQuery2.FieldByName('Author').Value;
    Form3.StringGrid1.Cells[2,j] :=  Form2.ADOQuery2.FieldByName('Genre').Value;
    Form3.StringGrid1.Cells[3,j] :=  Form2.ADOQuery2.FieldByName('CountBooks').Value;

    Form2.ADOQuery2.Next;
  end;


    end;
  Form6.Close;
end;

end.
