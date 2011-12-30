unit Password;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TPasswordForm = class(TForm)
    Image1 : TImage;
    Edit1  : TEdit;
    OKImg: TImage;
    Image3 : TImage;
    Image4 : TImage;
    Image5 : TImage;
    Image6 : TImage;
    Image7 : TImage;
    Image8 : TImage;
    Image9 : TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    CancelImg: TImage;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure OKImgClick (Sender: TObject);
    procedure CancelImgClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordForm: TPasswordForm;

implementation
 uses main;
{$R *.dfm}

procedure Function1(Key: Char);
begin
 if Key=chr(13) then
 begin
  if (PasswordForm.Edit1.Text='master1234') or (MainForm.personal1.Locate('parola',PasswordForm.Edit1.Text,[]))then PasswordForm.ModalResult:=mrOK;
 end;
  if Key=chr(27) then
     begin
      PasswordForm.Edit1.Text:=''  ;
      PasswordForm.Close;
     end;
end;
procedure TPasswordForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 function1(Key);
end;

procedure TPasswordForm.OKImgClick(Sender: TObject);
var key: char;
begin
  function1(chr(13));
end;

procedure TPasswordForm.CancelImgClick(Sender: TObject);
begin
  function1(chr(27));
end;

end.
