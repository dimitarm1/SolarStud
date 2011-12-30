program testcom2;

uses
  Forms,
  testcom3 in 'testcom3.pas' {testform};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Ttestform, testform);
  Application.Run;
end.
