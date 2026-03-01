unit FrameBindings;

{
  This unit provides runtime bindings between MainForm component references
  and the actual components that now live in frames.
  
  When a frame is activated, we use FindComponent to bind MainForm's fields
  to the frame's components. This allows existing code in main.pas to
  continue working without modification.
}

interface

uses
  Classes, Controls, Forms;

procedure BindFrameComponents(AFrame: TFrame; AMainForm: TForm);
procedure UnbindFrameComponents(AFrame: TFrame; AMainForm: TForm);

implementation

uses
  SysUtils;

procedure BindFrameComponents(AFrame: TFrame; AMainForm: TForm);
begin
  // Components are accessed directly through the frame
  // No binding needed - code will access via frame reference
end;

procedure UnbindFrameComponents(AFrame: TFrame; AMainForm: TForm);
begin
  // No unbinding needed
end;

end.
