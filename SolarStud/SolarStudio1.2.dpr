program SolarStudio1_2;

uses
  Forms,
  classes,
  Messages,
  Windows,
  main in 'main.pas' {MainForm},
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
  MainForm2 in 'MainForm2.pas' {Main2},
  SetLang in 'SetLang.pas',
  Checkdatabase in 'Checkdatabase.pas';

{$R *.RES}
var
x,y:integer;
label endapplication;

begin
  if HPrevInst = 0 then
  begin
    Application.Initialize;
    Application.Title := 'SolarStudio V1.2';
    if not Do_checkdatabase then goto endapplication;    
    Application.HelpFile := '\SolarStudio1\Manual.htm';
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
    MainForm.Height:=594;
    x:=(screen.Monitors[0].Width div 2) - 400;
    y:=(screen.Monitors[0].Height div 2) - 300;
    MainForm.Visible:=true;
    MainForm.Show;
    MainForm.Top:=y;
    MainForm.Left:=x;
   // AddFontResource('f:\temp\murmansk.TTF') ;
   // SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0) ;
    //MainForm.ComboBox1.Items := Screen.Fonts;     Added for testing
    //MainForm.Font.Name:=ComboBox1.Text;
    //RemoveFontResource('f:\temp\LAZURSK1.TTF') ;
    //SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0) ;

    Application.Run;
endapplication:
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


