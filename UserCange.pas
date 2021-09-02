unit UserCange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm9 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Edit1: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Button5: TButton;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;
  var NameUser: string;
implementation
       uses DataBas, Users;
{$R *.dfm}

procedure TForm9.Button5Click(Sender: TObject);
var t: string;
begin
if Edit1.Text = '' then
begin
  ShowMessage('Имя не введено');
  Exit;
end;
;



if Combobox1.ItemIndex = -1 then
begin
ShowMessage('Не выбран тип');
Exit;
end;



if Combobox1.ItemIndex = 0 then
  t := 'Admin';

  if Combobox1.ItemIndex = 1 then
  t := 'User';


  Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('UPDATE Users SET UserName='''+Edit1.Text+''', Birthday='''+DateToStr(DateTimePicker1.DateTime)+''' WHERE UserName='''+NameUser+'''');
  Form2.ADOQuery1.ExecSQL;

  Form7.Close;
  Form7.Show;
  Form9.Close;
end;

end.
