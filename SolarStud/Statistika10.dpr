program Statistika10;

uses
  Forms,
  statistika1 in 'statistika1.pas' {statistikatest};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tstatistikatest, statistikatest);
  Application.Run;
end.
