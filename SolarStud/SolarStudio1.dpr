program SolarStudio1;

uses
  Forms,
  classes,
  Windows,
  MAIN in 'main.pas' {MainForm},
  CHILDWIN in 'CHILDWIN.PAS' {MDIChild},
  ImageWin in 'ImageWin.pas' {ImageForm},
  Password in 'Password.pas' {PasswordForm},
  Notshalter in 'Notshalter.pas' {NotshalterForm},
  QReportKlienti in 'QReportKlienti.pas' {Form1},
  QReportSolariumiNastroiki in 'QReportSolariumiNastroiki.pas' {Form2},
  QReportDneven in 'QReportDneven.pas' {Form3},
  Refill in 'Refill.pas' {RefillForm},
  Stoki in 'Stoki.pas' {Form4},
  setformdata in 'setformdata.pas' {Form6},
  SLE4442 in 'SLE4442.pas',
  MainForm2 in 'MainForm2.pas' {Main2};

{$R *.RES}


begin
  if HPrevInst = 0 then
  begin
  Application.Initialize;
  Application.Title := 'SolarStudio V1.0';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TImageForm, ImageForm);
  Application.CreateForm(TPasswordForm, PasswordForm);
  Application.CreateForm(TNotshalterForm, NotshalterForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TRefillForm, RefillForm);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TMain2, Main2);
  MainForm.Visible:=True;
  MainForm.Show;
  Application.Run;

  end
  else
  begin
    MessageBox(0, 'This application is already running',
      'Solar Studio V0.01', mb_OK);
    if SetFocus(FindWindow('Solar Studio V0.01', nil)) = 0 then
      MessageBox(0, 'The window handle is invalid',
        'Solar Studio V0.01', mb_OK);
  end;
end.


