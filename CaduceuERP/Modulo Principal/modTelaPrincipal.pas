unit modTelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ButtonGroup,
  Vcl.CategoryButtons, Vcl.ComCtrls, AdvSmoothDock, Vcl.Tabs, Vcl.DockTabSet,
  Vcl.Imaging.jpeg, ShellApi, Vcl.Imaging.pngimage, Data.Db, System.Notification,
  Vcl.Menus, Vcl.ToolWin;

type
  TfrmTelaPrincipal = class(TForm)
    actMaster: TActionManager;
    actSair: TAction;
    actEstados: TAction;
    actCidades: TAction;
    actFiliais: TAction;
    actFuncionarios: TAction;
    actUsuarios: TAction;
    actFornecedores: TAction;
    actGrupos: TAction;
    actSubGrupo: TAction;
    actSecoes: TAction;
    actSetorBalanca: TAction;
    actInfNutricional: TAction;
    actProducao: TAction;
    actRentabilidade: TAction;
    actAliquotas: TAction;
    actProdutos: TAction;
    actCfop: TAction;
    actFPagamento: TAction;
    actNbmNcm: TAction;
    actBancos: TAction;
    actContasMovimento: TAction;
    actPlContas: TAction;
    actAdmCartCred: TAction;
    actLancamentos: TAction;
    actCPA: TAction;
    actCRE: TAction;
    actChqRec: TAction;
    actChqPagar: TAction;
    actCtrlCart: TAction;
    actFlCaixa: TAction;
    actOrdemCompra: TAction;
    actNFEntrada: TAction;
    actNFSaida: TAction;
    actSaldo: TAction;
    actInventario: TAction;
    actPrecos: TAction;
    actPermissoes: TAction;
    actEtiquetas: TAction;
    actSuporteChat: TAction;
    actSuporteRemoto: TAction;
    actFechaVenda: TAction;
    actMRECF: TAction;
    actSintegraGeraArq: TAction;
    actTabComissao: TAction;
    actRelatorios: TAction;
    actConfiguracoes: TAction;
    actAutomacao: TAction;
    actIntegracao: TAction;
    actClientes: TAction;
    actRegistro61: TAction;
    actNFModelo02: TAction;
    actServico: TAction;
    actReg60MA: TAction;
    actRefFornecedor: TAction;
    actDanfe: TAction;
    actLivroEntradas: TAction;
    actLivroSaidas: TAction;
    actApuracaoICMS: TAction;
    actPromocoes: TAction;
    actCST_CSOSN: TAction;
    actSimilar: TAction;
    actPaises: TAction;
    actSituacoesOS: TAction;
    actEquipamentos: TAction;
    actAlmoxarifado: TAction;
    actObservecoes: TAction;
    actAjuda: TAction;
    actOrdemServico: TAction;
    actPerdas: TAction;
    tmrInatividade: TTimer;
    icoUpdate: TTrayIcon;
    tmrUpdate: TTimer;
    tmrDataHora: TTimer;
    pnlCopiaAtualizacao: TPanel;
    pgbProgressoCopia: TProgressBar;
    imgFundo: TImage;
    stbPrincipal: TStatusBar;
    actUnidMedida: TAction;
    actOrdemDeProducao: TAction;
    NotificationCenter1: TNotificationCenter;
    tmrCopiaXMLPdf_Repositorio: TTimer;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Financeiro1: TMenuItem;
    Estoque1: TMenuItem;
    Utilitrios1: TMenuItem;
    Administrao1: TMenuItem;
    Contbil1: TMenuItem;
    Auxiliar1: TMenuItem;
    Sair1: TMenuItem;
    ControledeNoptas1: TMenuItem;
    Relatrios1: TMenuItem;
    Configurae1: TMenuItem;
    Automao1: TMenuItem;
    Integrao1: TMenuItem;
    Ajuda1: TMenuItem;
    actCtrlNotas: TAction;
    Livrosfiscais1: TMenuItem;
    Entradas1: TMenuItem;
    Sadas1: TMenuItem;
    ApuraoICMS1: TMenuItem;
    Fechamentodevenda1: TMenuItem;
    MaparesumodeECF1: TMenuItem;
    Sintegra1: TMenuItem;
    Registro60MestreAnaltico1: TMenuItem;
    abeladecomisses1: TMenuItem;
    ObservaesInfocomplementares1: TMenuItem;
    Preos1: TMenuItem;
    Permisses1: TMenuItem;
    Etiquetastrmicas1: TMenuItem;
    Ordemdecompras1: TMenuItem;
    NotasFiscais1: TMenuItem;
    Notafiscaldeentrada1: TMenuItem;
    Notafiscaldesada1: TMenuItem;
    Notafiscalmodelo21: TMenuItem;
    Danfe1: TMenuItem;
    Saldro1: TMenuItem;
    Invetrio1: TMenuItem;
    ControledeAlmoxarifado1: TMenuItem;
    Controledeperdas1: TMenuItem;
    Ordemdeproduo1: TMenuItem;
    CentrodeCustos1: TMenuItem;
    Bancos1: TMenuItem;
    ContasdeMovimento1: TMenuItem;
    PlanodeContas1: TMenuItem;
    AdministradorasdecartesdeCrditos1: TMenuItem;
    Lanamentos1: TMenuItem;
    ContasapagarCPA1: TMenuItem;
    ContasareceberCRE1: TMenuItem;
    Cheques1: TMenuItem;
    Chequesareceber1: TMenuItem;
    Chequesapagar1: TMenuItem;
    ControledeCartesetickets1: TMenuItem;
    FluxodeCaixa1: TMenuItem;
    Estado1: TMenuItem;
    Cidades1: TMenuItem;
    Filiais1: TMenuItem;
    Funcionarios1: TMenuItem;
    Usuarios1: TMenuItem;
    Fornecedores1: TMenuItem;
    Clientes1: TMenuItem;
    Famlia1: TMenuItem;
    Grupos1: TMenuItem;
    SubGrupos1: TMenuItem;
    Sees1: TMenuItem;
    Setordebalana1: TMenuItem;
    InformaesNutricionais1: TMenuItem;
    Prodsutos1: TMenuItem;
    Unidadedemedida1: TMenuItem;
    Produtos1: TMenuItem;
    Promoes1: TMenuItem;
    Similar1: TMenuItem;
    Alquotas1: TMenuItem;
    Produo1: TMenuItem;
    Rentabilidade1: TMenuItem;
    CFOP1: TMenuItem;
    Paises1: TMenuItem;
    SituaesOS1: TMenuItem;
    Equipamentos1: TMenuItem;
    OrdemdeServico1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    tbrPrincipal: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure tmrDataHoraTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure stbPrincipalDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure tmrInatividadeTimer(Sender: TObject);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure actEstadosExecute(Sender: TObject);
    procedure actCidadesExecute(Sender: TObject);
    procedure actFiliaisExecute(Sender: TObject);
    procedure actFuncionariosExecute(Sender: TObject);
    procedure actUsuariosExecute(Sender: TObject);
    procedure actFornecedoresExecute(Sender: TObject);
    procedure actGruposExecute(Sender: TObject);
    procedure actSubGrupoExecute(Sender: TObject);
    procedure actSecoesExecute(Sender: TObject);
    procedure actSetorBalancaExecute(Sender: TObject);
    procedure actInfNutricionalExecute(Sender: TObject);
    procedure actProducaoExecute(Sender: TObject);
    procedure actRentabilidadeExecute(Sender: TObject);
    procedure actAliquotasExecute(Sender: TObject);
    procedure actProdutosExecute(Sender: TObject);
    procedure actCfopExecute(Sender: TObject);
    procedure actFPagamentoExecute(Sender: TObject);
    procedure actNbmNcmExecute(Sender: TObject);
    procedure actBancosExecute(Sender: TObject);
    procedure actContasMovimentoExecute(Sender: TObject);
    procedure actPlContasExecute(Sender: TObject);
    procedure actAdmCartCredExecute(Sender: TObject);
    procedure actLancamentosExecute(Sender: TObject);
    procedure actCPAExecute(Sender: TObject);
    procedure actCREExecute(Sender: TObject);
    procedure actChqRecExecute(Sender: TObject);
    procedure actChqPagarExecute(Sender: TObject);
    procedure actCtrlCartExecute(Sender: TObject);
    procedure actFlCaixaExecute(Sender: TObject);
    procedure actOrdemCompraExecute(Sender: TObject);
    procedure actNFEntradaExecute(Sender: TObject);
    procedure actNFSaidaExecute(Sender: TObject);
    procedure actSaldoExecute(Sender: TObject);
    procedure actInventarioExecute(Sender: TObject);
    procedure actPrecosExecute(Sender: TObject);
    procedure actPermissoesExecute(Sender: TObject);
    procedure actEtiquetasExecute(Sender: TObject);
    procedure actSuporteChatExecute(Sender: TObject);
    procedure actSuporteRemotoExecute(Sender: TObject);
    procedure actFechaVendaExecute(Sender: TObject);
    procedure actMRECFExecute(Sender: TObject);
    procedure actSintegraGeraArqExecute(Sender: TObject);
    procedure actTabComissaoExecute(Sender: TObject);
    procedure actRelatoriosExecute(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
    procedure actAutomacaoExecute(Sender: TObject);
    procedure actIntegracaoExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actRegistro61Execute(Sender: TObject);
    procedure actNFModelo02Execute(Sender: TObject);
    procedure actServicoExecute(Sender: TObject);
    procedure actReg60MAExecute(Sender: TObject);
    procedure actRefFornecedorExecute(Sender: TObject);
    procedure actDanfeExecute(Sender: TObject);
    procedure actLivroEntradasExecute(Sender: TObject);
    procedure actLivroSaidasExecute(Sender: TObject);
    procedure actApuracaoICMSExecute(Sender: TObject);
    procedure actPromocoesExecute(Sender: TObject);
    procedure actCST_CSOSNExecute(Sender: TObject);
    procedure actSimilarExecute(Sender: TObject);
    procedure actPaisesExecute(Sender: TObject);
    procedure actSituacoesOSExecute(Sender: TObject);
    procedure actEquipamentosExecute(Sender: TObject);
    procedure actAlmoxarifadoExecute(Sender: TObject);
    procedure actAjudaExecute(Sender: TObject);
    procedure actOrdemServicoExecute(Sender: TObject);
    procedure actPerdasExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actUnidMedidaExecute(Sender: TObject);
    procedure actOrdemDeProducaoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrCopiaXMLPdf_RepositorioTimer(Sender: TObject);
    procedure actCtrlNotasExecute(Sender: TObject);
  private
    { Private declarations }
    bEm_Atualizacao, bSolicitacao_fechar, bCopiando:boolean;
    sSenha:string;
    procedure Live_Update;
    procedure CopiarXMLPDF_Repositorio;
    function CopiaArquivo(Origem, Destino: String): Boolean;
    procedure ModuloNaoHabilitado;
    procedure ModuloNaoConfigurado;
    procedure ModuloEmDesenvolvimento;
  public
    { Public declarations }
  end;

var
  frmTelaPrincipal: TfrmTelaPrincipal;
  HWnd:Integer;
  sLinha : string;

implementation

{$R *.dfm}

uses dataDBEXMaster, dataMProvider, uConstantes_Padrao, uFuncoes, uFuncoes_BD;

procedure TfrmTelaPrincipal.actAdmCartCredExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Adm.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pAdmCartao),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Administradoras de cart�es e tickets');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Adm.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }


      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actAliquotasExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Aliquota.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pAliquota),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Al�quotas de ICMS');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Aliquota.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actAutomacaoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Automacao.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pAutomacao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Integra��o entre aplica��es');

    if Hwnd = 0 then
    begin


      sLinha := ExtractFilePath(Application.ExeName)
        + 'Automacao.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);
      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actBancosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Bancos.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pBanco),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Bancos');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Bancos.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actCfopExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'CFOP_CFPS.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCfop),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de CFOP - CFPS');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'CFOP_CFPS.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actChqPagarExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'ChqPre.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pChqPagar),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Cheques Pr�-datados');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'ChqPre.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actChqRecExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'ChqRec.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pChqRec),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Cheques a Receber');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'ChqRec.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actCidadesExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Cidades.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCidade),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Cidades');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Cidades.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;
end;

procedure TfrmTelaPrincipal.actClientesExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Cliente.exe') then
  begin
    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCliente),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Clientes');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Cliente.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actConfiguracoesExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Config.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pConfiguracao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Configura��es');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Config.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actContasMovimentoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'CCorrente.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pContaMov),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Contas Corrente');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'CCorrente.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actCPAExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Cpa.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCpa),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Contas a Pagar');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Cpa.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actCREExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Cre.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCre),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Contas a Receber');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Cre.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actCtrlCartExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'CtrlCT.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCtrlCartao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Controle de Cart�es e Ticket');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'CtrlCT.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actCtrlNotasExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'CtrlNotas.exe') then
  begin


    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pCtrlNotas),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Controle de Notas');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'CtrlNotas.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actEstadosExecute(Sender: TObject);
begin

  {

    verifica se o arquivo existe

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Estados.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pEstado),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Estados');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Estados.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + dmDBEXMaster.sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actEtiquetasExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'IEtiquetas.exe') then
  begin


    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin
      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pEtiqueta),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Emiss�o de Etiquetas');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'IEtiquetas.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actFechaVendaExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

{  if FileExists(ExtractFilePath(Application.ExeName)+'FechaVenda.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pFechaVenda),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Fechamento de Venda');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'FechaVenda.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);


      CriarProcessoSimples(sLinha);

    end
    else
      SetForeGroundWindow(HWnd);
  end
  else}

    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actFiliaisExecute(Sender: TObject);
begin
         {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Filiais.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pFilial),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Filiais');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Filiais.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actFlCaixaExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'FCaixa.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pFluxoCaixa),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Fluxo de caixa');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'FCaixa.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actFornecedoresExecute(Sender: TObject);
begin
     {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Fornecedor.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pFornecedor),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Fornecedores');


    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Fornecedor.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actFPagamentoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'FPagto.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pFPagto),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Formas de Pagamento');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'FPagto.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actFuncionariosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Funcionario.exe') then
  begin


    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pFuncionario),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Funcion�rios');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Funcionario.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actGruposExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Grupos.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pGrupo),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Grupos de Produtos');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Grupos.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actInfNutricionalExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'InfNutricional.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pInfNutricional),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Informa��o Nutricional');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'InfNutricional.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actIntegracaoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Integracao_Fiscal.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pIntegracao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Integra��o de lojas');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Integracao_Fiscal.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actInventarioExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'MInventario.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Invent�rio');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'MInventario.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actLancamentosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Lancamento.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pLancamento),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Tipo de Lan�amento');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Lancamento.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actMRECFExecute(Sender: TObject);
begin

{  if FileExists(ExtractFilePath(Application.ExeName)+'MREcf.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pMRECF),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Mapa Resumo de ECF');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'MREcf.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      CriarProcessoSimples(sLinha);

    end
    else

      SetForeGroundWindow(HWnd);
  end
  else}
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actNbmNcmExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'NbmNcm.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pNbm_Ncm),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de NBM / NCM');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'NbmNcm.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actNFEntradaExecute(Sender: TObject);
begin
   {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'NFEntrada.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pNFEntrada),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Notas Fiscais de Entrada');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'NFEntrada.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actNFModelo02Execute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'NFModelo2.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;
{      if not ValidarPermissao(Ord(pNFModelo02),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;}
    end
    else
      sSenha := dmDBEXMaster.sSenha;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Nota Fiscal modelo 02');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'NFModelo2.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actNFSaidaExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'NFSaida.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pNFSaida),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Nota Fiscal de Sa�da');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'NFSaida.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actOrdemCompraExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'OCompra.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pOCompra),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Ordem de Compra');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'OCompra.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actPermissoesExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Permissao.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pPermissao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de permiss�es de usu�rios');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Permissao.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actPlContasExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'PlContas.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pPlConta),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o do Plano de Contas');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'PlContas.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actPrecosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Preco.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pPreco),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de pre�os');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Preco.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actProducaoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'FichaTecnica.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pProducao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de itens Ficha T�cnica / ingredientes receitas');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'FichaTecnica.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actProdutosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Produtos.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pProduto),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Produtos');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Produtos.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

      Hwnd := FindWindow('TApplication', 'Manuten��o de Produtos');

      SetForeGroundWindow(HWnd);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actRegistro61Execute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'NFModelo02.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pNbm_Ncm),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actRelatoriosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', deseja utilizar novo gerador de relat�rios?'),
                'Aten��o!', mb_IconQuestion + mb_DefButton2 + mb_YesNo)  = idYes then
  begin

    if FileExists(ExtractFilePath(Application.ExeName)+'nv_Relatorios.exe') then
    begin

      {

        valida permiss�o do usu�rio

      }
      if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
      begin

        sSenha := dmDBEXMaster.sSenha;

        if not ValidarPermissao(Ord(pRelatorio),dmDBEXMaster.iIdUsuario,'C') then
        begin

          MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                      + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                        'Informa��o', mb_ok + MB_IconWarning);
          exit;

        end;

      end;

      Hwnd := FindWindow('TApplication', 'Relat�rios');

      if Hwnd = 0 then
      begin

        sLinha := ExtractFilePath(Application.ExeName)
          + 'nv_Relatorios.exe '
          + dmDBEXMaster.sNomeUsuario + ' '
          + sSenha + ' '
          + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
          + IntToStr(dmDBEXMaster.iIdFilial)+' 0';

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

      end
      else
        {

          Esta funcao traz para frente (da o foco) para a janela
          da aplicacao que ja esta rodando

        }
        SetForeGroundWindow(HWnd);
    end
    else
      ModuloNaoHabilitado;

  end
  else
  begin


    if FileExists(ExtractFilePath(Application.ExeName)+'Relatorios.exe') then
    begin

      {

        valida permiss�o do usu�rio

      }
      if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
      begin

        sSenha := dmDBEXMaster.sSenha;

        if not ValidarPermissao(Ord(pRelatorio),dmDBEXMaster.iIdUsuario,'C') then
        begin

          MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                      + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                        'Informa��o', mb_ok + MB_IconWarning);
          exit;

        end;

      end;

      Hwnd := FindWindow('TApplication', 'Relat�rios');

      if Hwnd = 0 then
      begin

        sLinha := ExtractFilePath(Application.ExeName)
          + 'Relatorios.exe '
          + dmDBEXMaster.sNomeUsuario + ' '
          + sSenha + ' '
          + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
          + IntToStr(dmDBEXMaster.iIdFilial)+' 0';

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

      end
      else
        {

          Esta funcao traz para frente (da o foco) para a janela
          da aplicacao que ja esta rodando

        }
        SetForeGroundWindow(HWnd);
    end
    else
      ModuloNaoHabilitado;

  end;

end;

procedure TfrmTelaPrincipal.actRentabilidadeExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Rentabilidade.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pRentabilidade),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Rentabilidade Animal');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Rentabilidade.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSairExecute(Sender: TObject);
begin

  Close;

end;

procedure TfrmTelaPrincipal.actSaldoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'MSaldo.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pSaldo),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Saldo de Produtos');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'MSaldo.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSecoesExecute(Sender: TObject);
begin
        {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Secoes.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pSecao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Se��es');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Secoes.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actServicoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Servicos.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

{      if not ValidarPermissao(Ord(pServico),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;
}

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Cadastro de servi�os');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Servicos.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actSetorBalancaExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'SetorBalanca.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pSetorBalanca),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Setor de Balan�a');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'SetorBalanca.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSintegraGeraArqExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'GSintegra.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pGeraArqSintegra),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Sintegra - Sistema Integrado de informa��es');
    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'GSintegra.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSubGrupoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'SubGrupos.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pSubGrupo),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de SubGrupos');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'SubGrupos.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSuporteChatExecute(Sender: TObject);
begin

  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'GenesisChat.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pChat),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Suporte atrav�s de chat on-line');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'GenesisChat.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSuporteRemotoExecute(Sender: TObject);
var
  MajorVersion, MinorVersion, Build: DWORD;
begin

  GetOSVersion(MajorVersion, MinorVersion, Build);

  if ((MajorVersion = 5) and (MinorVersion = 0)) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto.exe '
  else if ((MajorVersion = 5) and (MinorVersion = 1)) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto.exe '
  else if ((MajorVersion = 6) and (MinorVersion = 0)) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto.exe '
  else if ((MajorVersion = 6) and (MinorVersion = 1)) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto.exe '
  else if ((MajorVersion = 6) and (MinorVersion = 2)) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto2.exe '
  else if ((MajorVersion = 6) and (MinorVersion = 3)) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto2.exe '
  else if (MajorVersion = 10) then
    sLinha := ExtractFilePath(Application.ExeName) + 'Remoto2.exe ';

  if FileExists(ExtractFilePath(Application.ExeName)+'Remoto.exe') or (FileExists(ExtractFilePath(Application.ExeName)+'Remoto2.exe')) then
    CriarProcessoSimples(sLinha)
  else
    ModuloNaoHabilitado;

  {if Pos('WINDOWS 7',UpperCase(ObterVersaoWindows)) > 0 then
  begin


    if FileExists(ExtractFilePath(Application.ExeName)+'Remoto.exe') then
    begin

        sLinha := ExtractFilePath(Application.ExeName) + 'Remoto.exe ';

        CriarProcessoSimples(sLinha);

    end
    else
      ModuloNaoHabilitado;

  end
  else
  begin

    if FileExists(ExtractFilePath(Application.ExeName)+'Remoto2.exe') then
    begin

        sLinha := ExtractFilePath(Application.ExeName) + 'Remoto2.exe ';

        CriarProcessoSimples(sLinha);

    end
    else
      ModuloNaoHabilitado;

  end;
}
end;

procedure TfrmTelaPrincipal.actTabComissaoExecute(Sender: TObject);
begin

{  if FileExists(ExtractFilePath(Application.ExeName)+'MComissao.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pTabComissao),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de comiss�o de funcion�rios');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'MComissao.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);


      CriarProcessoSimples(sLinha);

    end
    else
      SetForeGroundWindow(HWnd);
  end
  else}
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actAjudaExecute(Sender: TObject);
var
  sArquivo:string;
begin

  sArquivo := ExtractFilePath(Application.ExeName)+'Genesisac.chm';

  ShellExecute(0,nil,PChar(sArquivo),nil, nil, SW_SHOWMAXIMIZED);

end;

procedure TfrmTelaPrincipal.actApuracaoICMSExecute(Sender: TObject);
begin

  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'ApuracaoICMS.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
{    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin
      sSenha := dmDBEXMaster.sSenha;
      if not ValidarPermissao(Ord(pChat),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
    end;
}
    Hwnd := FindWindow('TApplication', 'Apura��o - ICMS');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'ApuracaoICMS.exe '
        + 'SYSDBA masterkey 999999 1';

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actCST_CSOSNExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Adm.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

{    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin
      sSenha := dmDBEXMaster.sSenha;
      if not ValidarPermissao(Ord(pAdmCartao),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
    end;
}
    Hwnd := FindWindow('TApplication', 'Manuten��o de CST/CSOSN-C�d. da Sit. Trib./C�d. de Sit. da Oper. no S. Nacional');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Cst.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actDanfeExecute(Sender: TObject);
begin

  if dmMProvider.cdsConfiguracoesMODELO.Value = '55' then
  begin

    {

      verifica se o arquivo existe
      futuramente ser� utilizado bpl

    }

    if FileExists(ExtractFilePath(Application.ExeName)+'Danfe.exe') then
    begin

      {

        valida permiss�o do usu�rio

      }

      if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
      begin

        sSenha := dmDBEXMaster.sSenha;
  {      if not ValidarPermissao(Ord(pCidade),dmDBEXMaster.iIdUsuario,'C') then
        begin
          MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                      + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                        'Informa��o', mb_ok + MB_IconWarning);
          exit;
        end;}

      end;

      Hwnd := FindWindow('TApplication', 'Manuten��o de Danfe');

      if Hwnd = 0 then
      begin

        sLinha := ExtractFilePath(Application.ExeName)
          + 'Danfe.exe '
          + dmDBEXMaster.sNomeUsuario + ' '
          + sSenha + ' '
          + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
          + IntToStr(dmDBEXMaster.iIdFilial);

          {
            cria um processo para chamaar a tela
            de manuten��o de estados
          }

          CriarProcessoSimples(sLinha);

      end
      else
        {

          Esta funcao traz para frente (da o foco) para a janela
          da aplicacao que ja esta rodando

        }
        SetForeGroundWindow(HWnd);
    end
    else
      ModuloNaoHabilitado;

  end
  else
    ModuloNaoConfigurado;

end;

procedure TfrmTelaPrincipal.actEquipamentosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Equipamentos.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;
{      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Equipamentos');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Equipamentos.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloEmDesenvolvimento;

end;

procedure TfrmTelaPrincipal.actLivroEntradasExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'LivroFiscalEntradas.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
{    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin
      sSenha := dmDBEXMaster.sSenha;
      if not ValidarPermissao(Ord(pChat),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
    end;
}
    Hwnd := FindWindow('TApplication', 'Manuten��o do Livro de Entrada');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'LivroFiscalEntradas.exe '
        + 'SYSDBA masterkey 999999 1';

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);
    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actLivroSaidasExecute(Sender: TObject);
begin

  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'LivroFiscalSaidas.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }
{    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin
      sSenha := dmDBEXMaster.sSenha;
      if not ValidarPermissao(Ord(pChat),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
    end;
}
    Hwnd := FindWindow('TApplication', 'Manuten��o do Livro de Sa�da');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'LivroFiscalSaidas.exe '
        + 'SYSDBA masterkey 999999 1';

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;



end;

procedure TfrmTelaPrincipal.actOrdemDeProducaoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'OrdemProducao.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;
{      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Ordem de produ��o');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'OrdemProducao.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloEmDesenvolvimento;

end;

procedure TfrmTelaPrincipal.actOrdemServicoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'OrdemServico.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;
{      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Ordem de Servi�o');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'OrdemServico.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actPaisesExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Pais.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      {if not ValidarPermissao(Ord(pNFModelo02),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Pa�ses');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Pais.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actPerdasExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Perdas.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;
{      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de perdas de estoque');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Perdas.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloEmDesenvolvimento;

end;

procedure TfrmTelaPrincipal.actPromocoesExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Promocoes.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      {if not ValidarPermissao(Ord(pNFModelo02),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;}

    end;

    Hwnd := FindWindow('TApplication', 'Cadastro de promo��o');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Promocoes.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actRefFornecedorExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'CodComumForn.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      {if not ValidarPermissao(Ord(pNFModelo02),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;}

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de C�digos Comuns de Fornecedor');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'CodComumForn.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actReg60MAExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Registro60M_A.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      {if not ValidarPermissao(Ord(pNFModelo02),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;}

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o do Regitro 60 mestre e anal�tico');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Registro60M_A.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;


end;

procedure TfrmTelaPrincipal.actSimilarExecute(Sender: TObject);
begin
 {
    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Similares.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      {if not ValidarPermissao(Ord(pNFModelo02),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de c�digos similares');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Similares.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actSituacoesOSExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'SituacoesOS.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

{      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
}
    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Situa��es - OS');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'SituacoesOS.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;



end;

procedure TfrmTelaPrincipal.actUnidMedidaExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'UndMedida.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

{    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pProduto),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;
}
    Hwnd := FindWindow('TApplication', 'Manuten��o de Unidade de Medida');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'UndMedida.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);

      Hwnd := FindWindow('TApplication', 'Manuten��o de Unidade de Medida');

      SetForeGroundWindow(HWnd);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloEmDesenvolvimento;


end;

procedure TfrmTelaPrincipal.actAlmoxarifadoExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Almoxarifado.exe') then
  begin

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin
      sSenha := dmDBEXMaster.sSenha;
{      if not ValidarPermissao(Ord(pInventario),dmDBEXMaster.iIdUsuario,'C') then
      begin
        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;
      end;
}
    end;

    Hwnd := FindWindow('TApplication', 'Controle de Almoxarifado');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Almoxarifado.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

      {
        cria um processo para chamaar a tela
        de manuten��o de estados
      }

      CriarProcessoSimples(sLinha);
    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

procedure TfrmTelaPrincipal.actUsuariosExecute(Sender: TObject);
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'Usuarios.exe') then
  begin


    {

      valida permiss�o do usu�rio

    }

    if dmDBEXMaster.sNomeUsuario <> 'SYSDBA' then
    begin

      sSenha := dmDBEXMaster.sSenha;

      if not ValidarPermissao(Ord(pUsuario),dmDBEXMaster.iIdUsuario,'C') then
      begin

        MessageBox(Application.Handle, PChar(dmDBEXMaster.sNomeUsuario+#13
                    + 'Voc� n�o possui permiss�o para acessar este m�dulo!'),
                      'Informa��o', mb_ok + MB_IconWarning);
        exit;

      end;

    end;

    Hwnd := FindWindow('TApplication', 'Manuten��o de Usu�rios');

    if Hwnd = 0 then
    begin

      sLinha := ExtractFilePath(Application.ExeName)
        + 'Usuarios.exe '
        + dmDBEXMaster.sNomeUsuario + ' '
        + sSenha + ' '
        + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
        + IntToStr(dmDBEXMaster.iIdFilial);

        {
          cria um processo para chamaar a tela
          de manuten��o de estados
        }

        CriarProcessoSimples(sLinha);

    end
    else
      {

        Esta funcao traz para frente (da o foco) para a janela
        da aplicacao que ja esta rodando

      }
      SetForeGroundWindow(HWnd);
  end
  else
    ModuloNaoHabilitado;

end;

function TfrmTelaPrincipal.CopiaArquivo(Origem, Destino: String): Boolean;
const
  TamanhoBuffer = 50000;
var
  ArqOrigem,ArqDestino: TFileStream;
  pBuf: Pointer;
  cnt: Integer;
  totCnt, TamanhoOrigem: Int64;
begin

  Result := True;
  totCnt := 0;

  try

    ArqOrigem := TFileStream.Create(Origem, fmOpenRead or fmShareDenyWrite);

  except

    on E: Exception do
    begin

      Result := False;
      Exit;

    end;

  end;

  TamanhoOrigem := ArqOrigem.size;

  with pgbProgressoCopia do
  begin

    Position := 0;

  end;


  try

    try

      ArqDestino := TFileStream.Create(Destino, fmCreate or fmShareExclusive);

    except
      on E: Exception do
      begin

        Result := False;
        Exit;

      end;

    end;

    try

      GetMem(pBuf, TamanhoBuffer);

      try

        cnt := ArqOrigem.Read(pBuf^, TamanhoBuffer);
        cnt := ArqDestino.Write(pBuf^, cnt);
        totCnt := totCnt + cnt;

        while (cnt > 0) do
        begin

          cnt                         := ArqOrigem.Read(pBuf^, TamanhoBuffer);
          cnt                         := ArqDestino.Write(pBuf^, cnt);
          totcnt                      := totcnt + cnt;
          pgbProgressoCopia.Position  := Round((totCnt / TamanhoOrigem) * 100);
          Application.ProcessMessages;

        end;

      finally

        FreeMem(pBuf, TamanhoBuffer);

      end;

    finally

      ArqDestino.Free;

    end;

  finally

    ArqOrigem.Free;

  end;

end;

procedure TfrmTelaPrincipal.CopiarXMLPDF_Repositorio;
var
  TempNome, sPasta: string;
  F: TSearchRec;
  Ret: Integer;
begin

  bCopiando := True;

  if (dmMProvider.cdsParametros_NFECRIAR_PASTAS_MENSALMENTE.Value = 1) then
    sPasta := dmMProvider.cdsParametros_NFEPASTA_ARQS_NFE.AsString + FormatDateTime('yyyymm',Date) + '\'
  else
    sPasta := dmMProvider.cdsParametros_NFEPASTA_ARQS_NFE.AsString;  //pega todos os arquivos xml


  Ret   := FindFirst(sPasta + '*.xml', faAnyFile, F);

  try

    while Ret = 0 do
    begin

      TempNome := F.Name;

      if Length(Trim(dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString)) > 0 then
      begin

        if not FileExists(dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString + TempNome) then
        begin

          if not CopyFile(PWideChar(sPasta + TempNome) ,
                   PWideChar(dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString + TempNome),True) then
            exit

        end;

      end;

      Ret := FindNext(F);

    end;

  finally

    FindClose(F);

  end;

  sPasta  := dmMProvider.cdsConfiguracoesPATH_SALVAR_PDF.Value;
  Ret     := FindFirst(sPasta + '*.pdf', faAnyFile, F);

  try

    while Ret = 0 do
    begin

      TempNome := F.Name;

      if Length(Trim(dmMProvider.cdsParametros_NFEREPOSITORIO_PDF.AsString)) > 0 then
      begin

        if not FileExists(dmMProvider.cdsParametros_NFEREPOSITORIO_PDF.AsString + TempNome) then
        begin

          if not CopyFile(PWideChar(sPasta + TempNome) ,
                   PWideChar(dmMProvider.cdsParametros_NFEREPOSITORIO_PDF.AsString + TempNome),True) then
            exit

        end;

      end;

      Ret := FindNext(F);

    end;

  finally

    FindClose(F);

  end;

  bCopiando := False;

end;

procedure TfrmTelaPrincipal.FormActivate(Sender: TObject);
begin

  icoUpdate.ShowBalloonHint;

end;

procedure TfrmTelaPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{
    procedure verifica se tem m�dulos do sistema aberto
    e fecha
  }
  FecharJanelasAbertas;

end;

procedure TfrmTelaPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {

    Pergunta ao us�rio se deseja realmente encerrar o sistema

  }
  if bEm_Atualizacao then
  begin

    Application.MessageBox(pchar(dmDBEXMaster.sNomeUsuario
                + ', existe um processo de atualiza��o em andamento.' + #13 + #13
                + 'Assim que for conclu�do, o sistema ser� encerrado.' + #13
                + 'N�o interrompa esse procedimento pois pode causar corrup��o de alguns arquivos!'),
                'Aten��o!', MB_ICONWARNING + mb_Ok);
    pnlCopiaAtualizacao.Visible := true;
    bSolicitacao_fechar         := pnlCopiaAtualizacao.Visible;
    CanClose := False;

  end
  else
    CanClose := Application.MessageBox(pchar(dmDBEXMaster.sNomeUsuario
                + ', confirma encerramento do sistema?' + #13 + #13
                + 'Salve todas as altera��es, caso contr�rio' + #13
                + 'as mesmas ser�o canceladas pelo sistema!'),
                'Aten��o!', mb_IconQuestion + mb_DefButton2 +mb_YesNo) = idYes;
end;

procedure TfrmTelaPrincipal.FormCreate(Sender: TObject);
var
  ms: TMemoryStream;
begin

  bSolicitacao_fechar := false;
  bEm_Atualizacao     := false;

  //encerra a tela de login
  PostMessage(FindWindow(nil, 'Caduceu - ERP'), WM_CLOSE, 0, 0);

  DesabilitarBotaoFecharForm(self.handle);

  dmDBEXMaster.sNomeUsuario       := ParamStr(1);
  dmDBEXMaster.sSenha             := paramstr(2);
  dmDBEXMaster.iIdUsuario         := StrToInt(ParamStr(3));
  dmDBEXMaster.iIdFilial          := StrToInt(ParamStr(4));

  AbrirTabelas;

  imgFundo.Width                          := Self.Width;
  imgFundo.Height                         := Self.Height;

  dmDBEXMaster.sIP_Servidor               := RetornarIP;

  Caption                                 := Application.Title + ' / ' + dmDBEXMaster.sIP_Servidor + ' * C�PIA REGISTRADA PARA: ' + dmMProvider.cdsFilialRAZAOSOCIAL.Value + ' * ';

  sSenha                                  := dmDBEXMaster.sSenha;

  dmMProvider.cdsMenuAtalhos.Open;
  dmMProvider.cdsMenuAtalhos.ProviderName := '';


 {


  definir cadastro de bot�es de m�dulo mais utilizados para o menu prinicpal


  while not dmMProvider.cdsMenuAtalhos.Eof do
  begin

    tbrPrincipal.ButtonWidth  := tbrPrincipal.Height -1;
    tbrPrincipal.ButtonHeight := tbrPrincipal.ButtonWidth;

    with TToolbutton.Create(tbrPrincipal) do
    begin

      Hint    := dmMProvider.cdsMenuAtalhosTITULO.Value;
      Parent  := tbrPrincipal;
      Name    := 'btn' + frmTelaPrincipal.Name +IntToStr(dmMProvider.cdsMenuAtalhos.RecNo) ;
      Cursor  := crHandPoint;

    end;

    dmMProvider.cdsMenuAtalhos.Next;

  end;
 }
  CriarPastasAplicacao;

end;

procedure TfrmTelaPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = vk_f11 then
  begin

    if FileExists(ExtractFilePath(ParamStr(0)) + 'capicom.exe') then
    begin

      sLinha := ExtractFilePath(ParamStr(0)) + 'capicom.exe';

      CriarProcessoSimples(sLinha);

    end;

  end;

end;

procedure TfrmTelaPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {

    Encerra o sistema caso o usu�rio pressione ESC

  }
  if key = #27  then
    Close;
end;

procedure TfrmTelaPrincipal.FormShow(Sender: TObject);
var
  R : TRect;
begin
  {

    Coloca a aplica��o em tela cheia

  }

  SystemParametersInfo(SPI_GETWORKAREA, 0, @R,0);
  SetBounds(R.Left, R.Top, R.Right-R.Left, R.Bottom-R.Top);

end;

procedure TfrmTelaPrincipal.Live_Update;
var
  TempNome, sVersao: string;
  F: TSearchRec;
  FHandle, Ret: Integer;
begin

  dmMProvider.cdsLiveUpdate.Close;
  dmMProvider.cdsLiveUpdate.CreateDataSet;
  dmMProvider.cdsLiveUpdate.Open;

  //pega todos os arquivos executaveis da pasta Live Update
  Ret   := FindFirst(dmMProvider.cdsConfig_iniPATH_ATUALIZACAO.AsString + 'GenesisAC2010.exe', faAnyFile, F);

  try

    while Ret = 0 do
    begin

      TempNome := F.Name;

      {
        Grava atualiza nomes e vers�es dos execut�veis
      }

      sVersao := VersaoExe(dmMProvider.cdsConfig_iniPATH_ATUALIZACAO.AsString + TempNome);

      FHandle := FileOpen(F.Name, 1);

      dmMProvider.cdsLiveUpdate.Append;
      dmMProvider.cdsLiveUpdateARQUIVO.AsString  := F.Name;
      dmMProvider.cdsLiveUpdateVERSAO.AsString   := sVersao;
      dmMProvider.cdsLiveUpdate.Post;

      FileClose(FHandle);

      Ret := FindNext(F);

    end;

  finally

    FindClose(F);

  end;


  dmMProvider.cdsLiveUpdate.First;

  dmMProvider.cdsVersaoAtual.Close;
  dmMProvider.cdsVersaoAtual.CreateDataSet;
  dmMProvider.cdsVersaoAtual.Open;

  //pega todos os arquivos executaveis da pasta Live Update
  Ret   := FindFirst(ExtractFilePath(Application.ExeName) + 'GenesisAC2010.exe', faAnyFile, F);

  try

    while Ret = 0 do
    begin

      TempNome := F.Name;

      {
        Grava atualiza nomes e vers�es dos execut�veis
      }

      sVersao := VersaoExe(ExtractFilePath(Application.ExeName) + TempNome);

      FHandle := FileOpen(F.Name, 1);

      dmMProvider.cdsVersaoAtual.Append;
      dmMProvider.cdsVersaoAtualARQUIVO.AsString  := F.Name;
      dmMProvider.cdsVersaoAtualVERSAO.AsString   := sVersao;
      dmMProvider.cdsVersaoAtual.Post;

      FileClose(FHandle);

      Ret := FindNext(F);

    end;


  finally
    FindClose(F);

  end;

  dmMProvider.cdsVersaoAtual.First;

  while not dmMProvider.cdsLiveUpdate.Eof do
  begin

    if dmMProvider.cdsVersaoAtual.Locate('arquivo',dmMProvider.cdsLiveUpdateARQUIVO.Value,[]) then
    begin

      if dmMProvider.cdsLiveUpdateVERSAO.Value <> dmMProvider.cdsVersaoAtualVERSAO.Value then
        CopiaArquivo(dmMProvider.cdsConfig_iniPATH_ATUALIZACAO.AsString +  dmMProvider.cdsLiveUpdateARQUIVO.AsString, ExtractFilePath(Application.ExeName) + dmMProvider.cdsLiveUpdateARQUIVO.AsString);

    end;

    dmMProvider.cdsLiveUpdate.Next;

  end;

end;

procedure TfrmTelaPrincipal.ModuloEmDesenvolvimento;
begin

  Application.MessageBox(pchar(dmDBEXMaster.sNomeUsuario
    + ', m�dulo em desenvolvimento!' + #13 + #13
    + 'Avisaremos quando conclu�do'),'Aten��o!', mb_IconWarning +mb_Ok);

end;

procedure TfrmTelaPrincipal.ModuloNaoConfigurado;
begin

  Application.MessageBox(pchar(dmDBEXMaster.sNomeUsuario
    + ', o sistema n�o est� configurado para utilizar este m�dulo!' + #13 + #13
    + 'Entre em contato com o suporte t�cnico para esclarecer' + #13
    + 'qualquer d�vida!'),'Aten��o!', mb_IconWarning +mb_Ok);

end;

procedure TfrmTelaPrincipal.ModuloNaoHabilitado;
begin

  Application.MessageBox(pchar(dmDBEXMaster.sNomeUsuario
    + ', m�dulo n�o dispon�vel!' + #13 + #13
    + 'Entre em contato com o suporte t�cnico para esclarecer' + #13
    + 'qualquer d�vida!'),'Aten��o!', mb_IconWarning +mb_Ok);

end;

procedure TfrmTelaPrincipal.stbPrincipalDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin

  with stbPrincipal.Canvas do
  begin
    FillRect(Rect);

    {

      define estilo da fonte

    }

    Font.Name := 'Arial';
    Font.Size := 9;

    //Desenha as imagens de acordo com o indice de cada panel
    if (dmDBEXMaster.dDataLicen�a - Date) <= 8 then
    begin

      if (Panel.Index = 6) or (Panel.Index = 7) then
        dmDBEXMaster.imgStatusBar.Draw(stbPrincipal.Canvas,Rect.Left+5,Rect.Top+1,Panel.Index + 1)
      else
        dmDBEXMaster.imgStatusBar.Draw(stbPrincipal.Canvas,Rect.Left+5,Rect.Top+1,Panel.Index);

    end
    else
    begin

      if Panel.Index = 7 then
        dmDBEXMaster.imgStatusBar.Draw(stbPrincipal.Canvas,Rect.Left+5,Rect.Top+1,Panel.Index + 1)
      else
        dmDBEXMaster.imgStatusBar.Draw(stbPrincipal.Canvas,Rect.Left+5,Rect.Top+1,Panel.Index);

    end;

    //Escreve o texto em cada panel
    if Panel.Index = 0 then
      TextOut(Rect.Left + 25, Rect.Top + 1,FormatDateTime('c', Now));

    if Panel.Index = 1 then
      TextOut(Rect.Left + 25, Rect.Top + 1,dmDBEXMaster.sNomeUsuario);

    if Panel.Index = 2 then
      TextOut(Rect.Left + 25, Rect.Top + 1,PREFIXO_VERSAO + RetornarVersao(Application.ExeName,1));

    if Panel.Index = 3 then
      TextOut(Rect.Left + 25, Rect.Top + 1,dmMProvider.cdsFilialRAZAOSOCIAL.AsString);

    if Panel.Index = 4 then
      TextOut(Rect.Left + 25, Rect.Top + 1,pubNomeComputador);

    if Panel.Index = 5 then
      TextOut(Rect.Left + 25, Rect.Top + 1,RetornarIP);

    if Panel.Index = 6 then
      TextOut(Rect.Left + 25, Rect.Top + 1,FormatDateTime('dd/mm/yyyy',dmDBEXMaster.dDataLicen�a));

    if Panel.Index = 7 then
      TextOut(Rect.Left + 25, Rect.Top + 1,'V.' + dmMProvider.cdsVersaoBancoVERSAO.Value);

  end;

end;

procedure TfrmTelaPrincipal.tmrCopiaXMLPdf_RepositorioTimer(Sender: TObject);
begin

  if not bCopiando then
    CopiarXMLPDF_Repositorio;

end;

procedure TfrmTelaPrincipal.tmrDataHoraTimer(Sender: TObject);
begin
  {

    formata a data da status bar

  }
  stbPrincipal.Panels[0].Text := FormatDateTime('c', Now);


end;

procedure TfrmTelaPrincipal.tmrInatividadeTimer(Sender: TObject);
begin

  if (Inatividade = 3600 ) and (UpperCase(dmDBEXMaster.sIP_Servidor) <> 'LOCALHOST') then
  begin

    Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_INATIVIDADE),
              'Aten��o!', MB_ICONWARNING + mb_Ok);
    application.Terminate;

  end;

end;

procedure TfrmTelaPrincipal.tmrUpdateTimer(Sender: TObject);
begin

  if not bEm_Atualizacao then
  begin

    dmDBEXMaster.fdqMasterPesquisa.Close;
    dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
    dmDBEXMaster.fdqMasterPesquisa.SQL.Add('SELECT * FROM CTRL_UPDATE');
    dmDBEXMaster.fdqMasterPesquisa.SQL.Add('WHERE NOME_COMPUTADOR = ' + QuotedStr(pubNomeComputador));
    dmDBEXMaster.fdqMasterPesquisa.Open;

    if dmDBEXMaster.fdqMasterPesquisa.IsEmpty then
    begin

      bEm_Atualizacao := True;

      pgbProgressoCopia.Position    := 0;

      Live_Update;

      bEm_Atualizacao               := False;
      pnlCopiaAtualizacao.Visible   := False;

      pgbProgressoCopia.Position    := 0;

      if bSolicitacao_fechar then
        Application.Terminate;

      Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ATUALIZACAO_DISP), 'Aten��o!', MB_ICONINFORMATION + mb_Ok);

    end;

  end;

end;

end.
