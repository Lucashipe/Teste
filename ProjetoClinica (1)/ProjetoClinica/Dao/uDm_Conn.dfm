object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
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
    VendorHome = 'F:\downloads\ProjetoClinica\ProjetoClinica\Win32\Debug'
    Left = 120
    Top = 16
  end
end
