unit U_Noti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormNoti = class(TForm)
    Image2: TImage;
    lb_noti: TLabel;
    btn_Sim: TPanel;
    btn_n: TPanel;
    Timer1: TTimer;
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNoti: TFormNoti;

implementation

{$R *.dfm}

procedure TFormNoti.Image2Click(Sender: TObject);
begin
  self.Close;
end;

procedure TFormNoti.Timer1Timer(Sender: TObject);
begin
  Self.Close;

end;

end.
