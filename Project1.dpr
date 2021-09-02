program Project1;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  DataBas in 'DataBas.pas' {Form2},
  MainForm in 'MainForm.pas' {Form3},
  MainFormAdmin in 'MainFormAdmin.pas' {Form4},
  AddBook in 'AddBook.pas' {Form5},
  SearchUsersForm in 'SearchUsersForm.pas' {Form6},
  Users in 'Users.pas' {Form7},
  UserFilter in 'UserFilter.pas' {Form8},
  UserCange in 'UserCange.pas' {Form9},
  Search in 'Search.pas' {Form10};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
