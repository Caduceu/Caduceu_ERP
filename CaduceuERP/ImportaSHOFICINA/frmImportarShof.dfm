object frmImportarShoficina: TfrmImportarShoficina
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Importa'#231#227'o - Shoficina'
  ClientHeight = 513
  ClientWidth = 1101
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 897
    Height = 473
    ActivePage = tbsGenesis
    TabOrder = 0
    object tbsGenesis: TTabSheet
      Caption = 'Tabelas Genesis'
      object Label1: TLabel
        Left = 201
        Top = 21
        Width = 3
        Height = 13
      end
      object Label2: TLabel
        Left = 201
        Top = 51
        Width = 3
        Height = 13
      end
      object Label3: TLabel
        Left = 201
        Top = 81
        Width = 3
        Height = 13
      end
      object Label4: TLabel
        Left = 10
        Top = 160
        Width = 55
        Height = 13
        Caption = 'Funcionario'
      end
      object Label5: TLabel
        Left = 10
        Top = 296
        Width = 41
        Height = 13
        Caption = 'Usuarios'
      end
      object Label6: TLabel
        Left = 619
        Top = 387
        Width = 3
        Height = 13
      end
      object Label7: TLabel
        Left = 619
        Top = 337
        Width = 3
        Height = 13
        Alignment = taCenter
      end
      object Button1: TButton
        Left = 3
        Top = 16
        Width = 177
        Height = 25
        Caption = 'Converter Clientes'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 3
        Top = 46
        Width = 177
        Height = 25
        Caption = 'Converter Equipamentos'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 3
        Top = 76
        Width = 177
        Height = 25
        Caption = 'Converter Situa'#231#245'es OS'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 392
        Top = 124
        Width = 177
        Height = 25
        Caption = 'Abrir tab func SH'
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 675
        Top = 124
        Width = 177
        Height = 25
        Caption = 'Abrir tab func Gen'
        TabOrder = 4
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 392
        Top = 276
        Width = 177
        Height = 25
        Caption = 'Abrir tab usu SH'
        TabOrder = 5
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 675
        Top = 276
        Width = 177
        Height = 25
        Caption = 'Abrir tab usu Gen'
        TabOrder = 6
        OnClick = Button7Click
      end
      object DBGrid2: TDBGrid
        Left = 356
        Top = 3
        Width = 262
        Height = 115
        DataSource = dmShoficina.dtsFuncionarios
        ReadOnly = True
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 161
            Visible = True
          end>
      end
      object DBGrid3: TDBGrid
        Left = 624
        Top = 3
        Width = 262
        Height = 115
        DataSource = dmMSource.dtsFuncionarios
        ReadOnly = True
        TabOrder = 8
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'FUNCIONARIO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 154
            Visible = True
          end>
      end
      object DBGrid4: TDBGrid
        Left = 356
        Top = 155
        Width = 262
        Height = 115
        DataSource = dmShoficina.dtsUsuarios
        ReadOnly = True
        TabOrder = 9
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 130
            Visible = True
          end>
      end
      object DBGrid5: TDBGrid
        Left = 619
        Top = 155
        Width = 262
        Height = 115
        DataSource = dmMSource.dtsUsuarios
        ReadOnly = True
        TabOrder = 10
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'USUARIO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Visible = True
          end>
      end
      object DBGrid6: TDBGrid
        Left = 4
        Top = 315
        Width = 262
        Height = 115
        DataSource = dmShoficina.dtsUsu
        TabOrder = 11
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_SHOFICINA'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_GENESIS'
            Visible = True
          end>
      end
      object DBGrid7: TDBGrid
        Left = 4
        Top = 179
        Width = 262
        Height = 115
        DataSource = dmShoficina.dstFun
        TabOrder = 12
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_SHOFICINA'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_GENESIS'
            Visible = True
          end>
      end
      object Button8: TButton
        Left = 277
        Top = 220
        Width = 73
        Height = 25
        Caption = 'Salvar'
        TabOrder = 13
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 277
        Top = 356
        Width = 73
        Height = 25
        Caption = 'Salvar'
        TabOrder = 14
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 533
        Top = 356
        Width = 228
        Height = 25
        Caption = 'Converter OS'
        TabOrder = 15
        OnClick = Button10Click
      end
    end
    object tbdResultados: TTabSheet
      Caption = 'Resultados'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 889
        Height = 445
        Align = alClient
        Caption = 'OS'
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 885
          Height = 428
          Align = alClient
          DataSource = dmMSource.dtsOrdemServico
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              Visible = True
            end
            item
              Expanded = False
              Visible = True
            end
            item
              Expanded = False
              Visible = True
            end
            item
              Expanded = False
              Visible = True
            end
            item
              Expanded = False
              Visible = True
            end>
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Config SH'
      ImageIndex = 2
      object Edit1: TEdit
        Left = 16
        Top = 32
        Width = 465
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Button11: TButton
        Left = 487
        Top = 30
        Width = 73
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 1
        OnClick = Button11Click
      end
    end
  end
end
