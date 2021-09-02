unit UserFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm8 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Edit1: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button5: TButton;
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation
  uses DataBas, Users;
{$R *.dfm}

procedure TForm8.Button5Click(Sender: TObject);
var typeS, par:string;
j:Integer;
begin
  if (Edit1.Text = '') or (Combobox1.ItemIndex = -1) then
    ShowMessage('Одно или несколько полей пусты!')
    else
    begin
      if Combobox1.ItemIndex = 0 then
      begin
         typeS :='UserName';
         par:= #39+Edit1.Text+#39;
      end;

      if Combobox1.ItemIndex = 1 then
      begin
         typeS :='Role';
         par:= #39+Edit1.Text+#39;
      end;

            Form7.StringGrid1.RowCount := 1;

      Form2.ADOQuery1.SQL.Clear;
      Form2.ADOQuery1.SQL.Add('SELECT * FROM Users Where '+typeS+'='+par);
      Form2.ADOQuery1.Open;

 for j := 1 to Form2.ADOQuery1.RecordCount do
  begin
    Form7.StringGrid1.RowCount :=   Form7.StringGrid1.RowCount+1;
    Form7.StringGrid1.Cells[0,j] :=  Form2.ADOQuery1.FieldByName('UserName').Value;
    Form7.StringGrid1.Cells[1,j] :=  Form2.ADOQuery1.FieldByName('Birthday').Value;
    Form7.StringGrid1.Cells[2,j] :=  Form2.ADOQuery1.FieldByName('Role').Value;
    Form2.ADOQuery1.Next;
  end;


    end;
  Form8.Close;
end;

end.
