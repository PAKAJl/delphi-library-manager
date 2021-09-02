unit bForm4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm6 = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
              uses MainFormAdmin;
{$R *.dfm}

procedure TForm6.FormShow(Sender: TObject);
begin
  Form4.Close;
  Form4.Show
  Form6.Close;
end;

end.
