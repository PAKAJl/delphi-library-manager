unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    Label5: TLabel;
    DateTimePicker1: TDateTimePicker;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  id: integer;
implementation

uses DataBas, MainForm, MainFormAdmin;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DataBas.Form2.ADOQuery2.SQL.Clear;
  DataBas.Form2.ADOQuery2.SQL.Add('SELECT * FROM Users WHERE UserName='+#39+Edit1.Text+#39+';');
  DataBas.Form2.ADOQuery2.Open;
  if DataBas.Form2.ADOQuery2.FieldByName('Password').Value = Edit2.Text then
     begin
     Form2.ADOQuery1.SQL.Clear;
  Form2.ADOQuery1.SQL.Add('SELECT Role FROM Users Where UserName='+#39+Edit1.Text+#39);
  Form2.ADOQuery1.Open;
  if DataBas.Form2.ADOQuery1.FieldByName('Role').Value = 'Admin' then
        begin
          Form4.Show;
          MainFormAdmin.user :=  Edit1.Text;
          Form1.Hide;

        end
        else
        begin
          Form3.Show;
          MainForm.user :=  Edit1.Text;
          Form1.Hide;
        end;
     end
  else
  begin
   ShowMessage('Неверный пароль!');
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if (Edit1.Text ='') or (Edit2.Text = '') or ((Edit1.Text = '') and (Edit2.Text = '')) then
    begin
      ShowMessage('Одно или несколько полей пусты!');
      exit;
    end;
  DataBas.Form2.ADOQuery1.SQL.Clear;
  DataBas.Form2.ADOQuery1.SQL.Add('SELECT UserName FROM Users Where UserName='+#39+Edit1.Text+#39);
  DataBas.Form2.ADOQuery1.Open;
  if DataBas.Form2.ADOQuery1.FieldValues['UserName'] = null then
    begin
      DataBas.Form2.ADOTable1.Insert;
      DataBas.Form2.ADOTable1.FieldByName('UserName').AsString:=Edit1.Text;
      DataBas.Form2.ADOTable1.FieldByName('Password').AsString:=Edit2.Text;
      if Edit3.Text = '1452' then
        DataBas.Form2.ADOTable1.FieldByName('Role').AsString:= 'Admin'
      else
        DataBas.Form2.ADOTable1.FieldByName('Role').AsString:= 'User';
      DataBas.Form2.ADOTable1.FieldByName('Birthday').AsString:= DateToStr(DateTimePicker1.DateTime);
      DataBas.Form2.ADOTable1.Post;

      DataBas.Form2.ADOQuery1.SQL.Clear;
      DataBas.Form2.ADOQuery1.SQL.Add('SELECT Id FROM Users Where UserName='+#39+Edit1.Text+#39);
      DataBas.Form2.ADOQuery1.Open;


      DataBas.Form2.ADOTable3.Insert;
      DataBas.Form2.ADOTable3.FieldByName('UserId').AsInteger := DataBas.Form2.ADOQuery1.FieldByName('Id').Value;
      DataBas.Form2.ADOTable3.FieldByName('DateInLibrary').AsDateTime := Date;
      DataBas.Form2.ADOTable3.Post;
      ShowMessage('Вы зарегистрированы!!!');
      Edit1.Text:='';
      Edit2.Text:='';
      Edit3.Text:='';
    end
  else
    ShowMessage('Такой пользователь зарегитсрирован');
end;

end.
