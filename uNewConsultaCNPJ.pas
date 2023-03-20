unit uNewConsultaCNPJ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, ACBrBase, ACBrSocket, ACBrConsultaCNPJ;

{$IFDEF CONDITIONALEXPRESSIONS}
   {$IF CompilerVersion >= 20.0}
     {$DEFINE DELPHI2009_UP}
   {$IFEND}
{$ENDIF}

// Remova o Ponto do DEFINE abaixo, se seu Delphi suporta PNG.
//    - Se não suportar (D7),
//  	- Acesse: https://sourceforge.net/projects/pngdelphi/
//      - Instale o projeto e depois remova o Ponto da Linha abaixo

{$DEFINE SUPPORT_PNG}

{$IFDEF DELPHI2009_UP}
  {$DEFINE SUPPORT_PNG}
{$ENDIF}

type
  TfrmNewConsultaCNPJ = class(TForm)
    ACBrConsultaCNPJ: TACBrConsultaCNPJ;
    Timer1: TTimer;
    Panel2: TPanel;
    edtTipoEmp: TEdit;
    edtRazaoSocial: TEdit;
    edtAbertura: TEdit;
    edtEndereco: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtCEP: TEdit;
    edtSituacao: TEdit;
    edtFantasia: TEdit;
    listCNAE2: TListBox;
    edtCNAE1: TEdit;
    edtEmail: TEdit;
    edtTelefone: TEdit;
    edtPorte: TEdit;
    Panel1: TPanel;
    edtCaptcha: TEdit;
    btnConsultar: TSpeedButton;
    lblTipoEmpresa: TLabel;
    lblAbertura: TLabel;
    lblRazaoSocial: TLabel;
    lblFantasia: TLabel;
    lblPorte: TLabel;
    lblCNAE1: TLabel;
    lblCNAE2: TLabel;
    lblEndereco: TLabel;
    lblNumero: TLabel;
    lblComplemento: TLabel;
    edtCNPJ: TMaskEdit;
    Label2: TLabel;
    Label1: TLabel;
    lblCEP: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblUF: TLabel;
    lblAtualizarCaptcha: TLabel;
    btnConfirmar: TSpeedButton;
    Panel3: TPanel;
    Image1: TImage;
    lblSituacao: TLabel;
    lblEmail: TLabel;
    lblTelefone: TLabel;
    lblNatJur: TLabel;
    edtNatJur: TEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure lblAtualizarCaptchaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtTipoEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewConsultaCNPJ: TfrmNewConsultaCNPJ;

implementation

uses
  JPEG
{$IFDEF SUPPORT_PNG}
  , pngimage
{$ENDIF}
   ;

{$R *.dfm}

procedure TfrmNewConsultaCNPJ.btnConfirmarClick(Sender: TObject);
var
   vTelForne: String;
begin
{
   try
      if Assigned(frmCadEmpresa) then
      begin
         with frmCadEmpresa do
         begin
            TBEMPRESASdata_arquivo.AsString   := edtAbertura.Text;
            TBEMPRESASd_xnatestab.AsString    := TiraMascara(edtNatJur.Text);
            TBEMPRESAScgc.AsString            := TiraMascara(edtCNPJ.Text);
            TBEMPRESASnome_empresa.AsString   := edtRazaoSocial.Text;
            TBEMPRESASxnome_fantasia.AsString := edtFantasia.Text;
            TBEMPRESASd_xcnae.AsString        := TiraMascara(edtCNAE1.Text);
            TBEMPRESASendereco.AsString       := edtEndereco.Text;
            TBEMPRESASnumero.AsString         := edtNumero.Text;
            TBEMPRESAScomplemento.AsString    := edtComplemento.Text;
            TBEMPRESAScep.AsString            := edtCEP.Text;
            TBEMPRESASbairro.AsString         := edtBairro.Text;
            //a cidade nao estava levando direto do edit, entao foi feito desta forma
            if Copy(ACBrConsultaCNPJ.Cidade,1,1) <> '*' then
               TBEMPRESAScidade.AsString      := ACBrConsultaCNPJ.Cidade;
            TBEMPRESASestado.AsString         := edtUF.Text;
            TBEMPRESASxemail_resp.AsString    := edtEmail.Text;
            TBEMPRESAStelddd.AsString         := Copy(edtTelefone.Text,2,2);
            TBEMPRESAStelnum.AsString         := Trim(Copy(TiraMascara(edtTelefone.Text),5,9));
            //aba Pessoal / Inf. Contrib. Sindical/RAIS
            TBEMPRESASd_xativprinc.AsString   := TiraMascara(edtCNAE1.Text);
         end;
      end;

      if Assigned(frmManutFornecedores) then
      begin
         vTelForne := Copy(edtTelefone.Text,2,2) + Trim(Copy(TiraMascara(edtTelefone.Text),5,9));

         with frmManutFornecedores do
         begin
            TBFORNEcgc.AsString            := TiraMascara(edtCNPJ.Text);
            TBFORNExnome_fantasia.AsString := edtFantasia.Text;
            TBFORNErazao.AsString          := edtRazaoSocial.Text;
            TBFORNExende.AsString          := edtEndereco.Text;
            TBFORNExnumero.AsString        := edtNumero.Text;
            TBFORNExcep.AsString           := edtCEP.Text;
            TBFORNExbairro.AsString        := edtBairro.Text;
            TBFORNExcidade.AsString        := edtCidade.Text;
            TBFORNEuf.AsString             := edtUF.Text;
            TBFORNExemail.AsString         := edtEmail.Text;
            TBFORNExtel.AsString           := vTelForne;
         end;
      end;
   finally
      Close;
   end;
   }
end;

procedure TfrmNewConsultaCNPJ.btnConsultarClick(Sender: TObject);
var
  vI: Integer;
begin
  if edtCaptcha.Text <> '' then
  begin
     if ACBrConsultaCNPJ.Consulta(edtCNPJ.Text,edtCaptcha.Text,false) then
     begin
        edtTipoEmp.Text     := ACBrConsultaCNPJ.EmpresaTipo;
        edtAbertura.Text    := DateToStr(ACBrConsultaCNPJ.Abertura);
        edtNatJur.Text      := ACBrConsultaCNPJ.NaturezaJuridica;
        edtRazaoSocial.Text := ACBrConsultaCNPJ.RazaoSocial;
        edtFantasia.Text    := ACBrConsultaCNPJ.Fantasia;
        edtPorte.Text       := ACBrConsultaCNPJ.Porte;
        edtCNAE1.Text       := ACBrConsultaCNPJ.CNAE1;
        edtEndereco.Text    := ACBrConsultaCNPJ.Endereco;
        edtNumero.Text      := ACBrConsultaCNPJ.Numero;
        edtComplemento.Text := ACBrConsultaCNPJ.Complemento;
        edtBairro.Text      := ACBrConsultaCNPJ.Bairro;
        edtCidade.Text      := ACBrConsultaCNPJ.Cidade;
        edtUF.Text          := ACBrConsultaCNPJ.UF;
        edtCEP.Text         := ACBrConsultaCNPJ.CEP;
        edtSituacao.Text    := ACBrConsultaCNPJ.Situacao;
        edtEmail.Text       := ACBrConsultaCNPJ.EndEletronico;
        edtTelefone.Text    := ACBrConsultaCNPJ.Telefone;

        ListCNAE2.Clear;
        for vI := 0 to ACBrConsultaCNPJ.CNAE2.Count - 1 do
           ListCNAE2.Items.Add(ACBrConsultaCNPJ.CNAE2[vI]);

        //não levar * pro campo caso seja assim
        for vI := 0 to frmNewConsultaCNPJ.ComponentCount - 1  do
        begin
           if (frmNewConsultaCNPJ.Components[vI] is TEdit) then
              if Copy((frmNewConsultaCNPJ.Components[vI] as TEdit).Text,1,1) = '*' then
                 (frmNewConsultaCNPJ.Components[vI] as TEdit).Text := EmptyStr;
        end;

        //btnConfirmar.Visible := true;
     end;
  end
  else
  begin
     MessageBox(Handle,pchar('É necessário digitar o captcha!'),pchar('Aviso'),48);
     edtCaptcha.SetFocus;
  end;
end;

procedure TfrmNewConsultaCNPJ.edtTipoEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
   Key := #0;
end;

procedure TfrmNewConsultaCNPJ.FormShow(Sender: TObject);
begin
   Timer1.Enabled := true;
end;

procedure TfrmNewConsultaCNPJ.lblAtualizarCaptchaClick(Sender: TObject);
var
  Stream: TMemoryStream;
//  Jpg: TJPEGImage;
{$IFDEF DELPHI2009_UP}
  png: TPngImage;
{$ELSE}
  ImgArq: String;
{$ENDIF}
begin
   if btnConfirmar.Visible then
      btnConfirmar.Visible := false;

  {$IFNDEF SUPPORT_PNG}
    //ShowMessage('Atenção: Seu Delphi não dá suporte nativo a imagens PNG. Queira verificar o código fonte deste exemplo para saber como proceder.');
    Exit;
    // COMO PROCEDER:
    //
    // 1) Caso o site da receita esteja utilizando uma imagem do tipo JPG, você pode utilizar o código comentado abaixo.
    //    * Comente ou apague o código que trabalha com PNG, incluindo o IFDEF/ENDIF;
    //    * descomente a declaração da variável jpg
    //    * descomente o código abaixo;
    // 2) Caso o site da receita esteja utilizando uma imagem do tipo PNG, você terá que utilizar uma biblioteca de terceiros para
    //conseguir trabalhar com imagens PNG.
    //  Neste caso, recomendamos verificar o manual da biblioteca em como fazer a implementação. Algumas sugestões:
    //    * Procure no Fórum do ACBr sobre os erros que estiver recebendo. Uma das maneiras mais simples está no link abaixo:
    //      - http://www.projetoacbr.com.br/forum/topic/20087-imagem-png-delphi-7/
    //    * O exemplo acima utiliza a biblioteca GraphicEX. Mas existem outras bibliotecas, caso prefira:
    //      - http://synopse.info/forum/viewtopic.php?id=115
    //      - http://graphics32.org/wiki/
    //      - http://cc.embarcadero.com/Item/25631
    //      - Várias outras: http://torry.net/quicksearchd.php?String=png&Title=Yes
  {$ENDIF}

  Stream:= TMemoryStream.Create;
  try
    ACBrConsultaCNPJ.Captcha(Stream);

   {$IFDEF DELPHI2009_UP}
    //Use esse código quando a imagem do site for do tipo PNG
    png:= TPngImage.Create;
    try
      png.LoadFromStream(Stream);
      Image1.Picture.Assign(png);
    finally
      png.Free;
    end;
    { //Use esse código quando a imagem do site for do tipo JPG
      Jpg:= TJPEGImage.Create;
      try
        Jpg.LoadFromStream(Stream);
        Image1.Picture.Assign(Jpg);
      finally
        Jpg.Free;
      end;
    }
   {$ELSE}
    ImgArq := ExtractFilePath(ParamStr(0))+PathDelim+'captch.png';
    Stream.SaveToFile( ImgArq );
    Image1.Picture.LoadFromFile( ImgArq );
   {$ENDIF}

    edtCaptcha.Clear;
    edtCaptcha.SetFocus;
  finally
    Stream.Free;
  end;
end;

procedure TfrmNewConsultaCNPJ.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled  := false;
  lblAtualizarCaptchaClick(lblAtualizarCaptcha);
  edtCNPJ.SetFocus;
end;

end.
