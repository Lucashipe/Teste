object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=apr_lucas_siqueira'
      'User_Name=aprendiz'
      'Password=12345'
      'Server=bdteste.rpinfo.com.br'
      'DriverID=PG')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    DriverID = 'PG'
    VendorHome = 
      'C:\Users\Auditorio\Downloads\ProjetoClinica (3)\ProjetoClinica\W' +
      'in32\Debug'
    Left = 120
    Top = 16
  end
end
