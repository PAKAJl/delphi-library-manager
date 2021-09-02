unit AddBook;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    Image1: TImage;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button5: TButton;
    Label5: TLabel;
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation
uses MainFormAdmin, DataBas;
{$R *.dfm}

procedure TForm5.Button5Click(Sender: TObject);
begin
  if (Edit1.Text = '') or (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') then
    ShowMessage('Одно или несколько полей пусты!')
    else
    begin

      DataBas.Form2.ADOTable2.Insert;
      DataBas.Form2.ADOTable2.FieldByName('BookName').AsString:=Edit1.Text;
      DataBas.Form2.ADOTable2.FieldByName('Author').AsString:=Edit2.Text;
      DataBas.Form2.ADOTable2.FieldByName('Genre').AsString:=Edit3.Text;
      DataBas.Form2.ADOTable2.FieldByName('CountBooks').AsInteger:=strtoint(Edit4.Text);
      DataBas.Form2.ADOTable2.Post;

      Form4.Close;
      Form4.Show;
    end;

end;

end.
