unit U_NovoPront�ario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TFormNovoProntuario = class(TForm)
    pnl_Container2: TPanel;
    memo_Diagnostico: TMemo;
    memo_Queixa: TMemo;
    edt_Peso: TLabeledEdit;
    edt_Altura: TLabeledEdit;
    lb_Queixa: TLabel;
    Label1: TLabel;
    pnl_Inf: TPanel;
    Image1: TImage;
    lb_Nome: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    NomePaciente : string;
  end;

var
  FormNovoProntuario: TFormNovoProntuario;

implementation

{$R *.dfm}

end.
