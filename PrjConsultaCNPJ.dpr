program PrjConsultaCNPJ;



uses
  Vcl.Forms,
  uNewConsultaCNPJ in 'uNewConsultaCNPJ.pas' {frmNewConsultaCNPJ};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmNewConsultaCNPJ, frmNewConsultaCNPJ);
  Application.Run;
end.
