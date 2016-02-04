program WinAPIDrawEdge;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form10};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
