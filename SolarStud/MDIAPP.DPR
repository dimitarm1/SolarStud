program Mdiapp;

uses
  Forms,
  MAIN in 'main.pas' {MainForm},
  CHILDWIN in 'CHILDWIN.PAS' {MDIChild},
  about in 'about.pas' {AboutBox},
  frames1 in 'frames1.pas' {Frame1: TFrame},
  ImageWin in 'ImageWin.pas' {ImageForm},
  Password in 'Password.pas' {PasswordForm},
  Notshalter in 'Notshalter.pas' {NotshalterForm},
  Scan in 'Scan.pas' {ScanForm},
  QReportKlienti in 'QReportKlienti.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TImageForm, ImageForm);
  Application.CreateForm(TPasswordForm, PasswordForm);
  Application.CreateForm(TNotshalterForm, NotshalterForm);
  Application.CreateForm(TScanForm, ScanForm);
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
