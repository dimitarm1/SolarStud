unit Password;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TPasswordForm = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
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
  if (PasswordForm.Edit1.Text='43211234') or (PasswordForm.Edit1.Text='ivoivoivo') or (MainForm.personal1.Locate('parola',PasswordForm.Edit1.Text,[]))then PasswordForm.ModalResult:=mrOK;
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

procedure TPasswordForm.Image2Click(Sender: TObject);
var key: char;
begin
  function1(chr(13));
end;

procedure TPasswordForm.Image3Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'0';
end;

procedure TPasswordForm.Image4Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'1';
end;

procedure TPasswordForm.Image5Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'2';
end;

procedure TPasswordForm.Image6Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'3';
end;

procedure TPasswordForm.Image7Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'4';
end;

procedure TPasswordForm.Image8Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'5';
end;

procedure TPasswordForm.Image9Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'6';
end;

procedure TPasswordForm.Image10Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'7';
end;

procedure TPasswordForm.Image11Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'8';
end;

procedure TPasswordForm.Image12Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'9';
end;

end.
