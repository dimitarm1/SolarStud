program uart1;

uses
  Forms,
  uart_pas in 'uart_pas.pas',
  uartform in 'uartform.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
