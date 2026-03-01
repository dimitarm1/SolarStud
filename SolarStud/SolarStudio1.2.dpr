program SolarStudio1_2;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
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
  Checkdatabase in 'Checkdatabase.pas',
  // PageManager infrastructure
  BasePageFrame in 'BasePageFrame.pas' {BasePageFrame: TFrame},
  PageManager in 'PageManager.pas',
  PageIndices in 'PageIndices.pas',
  PageFrames in 'PageFrames.pas',
  FrameBindings in 'FrameBindings.pas',
  // Page frames
  LogoEkranFrame in 'Pages\LogoEkranFrame.pas' {LogoEkranFrame: TFrame},
  OsnovenEkranFrame in 'Pages\OsnovenEkranFrame.pas' {OsnovenEkranFrame: TFrame},
  FirmiISluziteliFrame in 'Pages\FirmiISluziteliFrame.pas' {FirmiISluziteliFrame: TFrame},
  IzborNaPlashtaneFrame in 'Pages\IzborNaPlashtaneFrame.pas' {IzborNaPlashtaneFrame: TFrame},
  IzborNaVremeFrame in 'Pages\IzborNaVremeFrame.pas' {IzborNaVremeFrame: TFrame},
  MenuFrame in 'Pages\MenuFrame.pas' {MenuFrame: TFrame},
  SolariumiNastroikiFrame in 'Pages\SolariumiNastroikiFrame.pas' {SolariumiNastroikiFrame: TFrame},
  SolariumiInfoFrame in 'Pages\SolariumiInfoFrame.pas' {SolariumiInfoFrame: TFrame},
  SolariumiCeniFrame in 'Pages\SolariumiCeniFrame.pas' {SolariumiCeniFrame: TFrame},
  NachalnoUstanoviavaneFrame in 'Pages\NachalnoUstanoviavaneFrame.pas' {NachalnoUstanoviavaneFrame: TFrame},
  ArhiviraneFrame in 'Pages\ArhiviraneFrame.pas' {ArhiviraneFrame: TFrame},
  StatistikaFrame in 'Pages\StatistikaFrame.pas' {StatistikaFrame: TFrame},
  ProtokolFrame in 'Pages\ProtokolFrame.pas' {ProtokolFrame: TFrame},
  OsnovniNastroikiFrame in 'Pages\OsnovniNastroikiFrame.pas' {OsnovniNastroikiFrame: TFrame},
  DrugiNastroikiFrame in 'Pages\DrugiNastroikiFrame.pas' {DrugiNastroikiFrame: TFrame},
  MenuKasaFrame in 'Pages\MenuKasaFrame.pas' {MenuKasaFrame: TFrame},
  MenuStokiFrame in 'Pages\MenuStokiFrame.pas' {MenuStokiFrame: TFrame},
  KlubniKartiFrame in 'Pages\KlubniKartiFrame.pas' {KlubniKartiFrame: TFrame},
  ChipKartiFrame in 'Pages\ChipKartiFrame.pas' {ChipKartiFrame: TFrame},
  GrafikFrame in 'Pages\GrafikFrame.pas' {GrafikFrame: TFrame};

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
