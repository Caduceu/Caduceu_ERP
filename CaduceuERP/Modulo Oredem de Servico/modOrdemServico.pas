{ TODO 1 -olindomar -cimplementa��es : implementar inclus�o de deslocamento }
unit modOrdemServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdActns, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage, DateUtils, JvExStdCtrls,
  JvEdit, JvValidateEdit, db, JvExComCtrls, JvDateTimePicker, JvDBDateTimePicker,
  JvExMask, JvToolEdit, JvDBControls, JvCombobox, JvDBCombobox;

type
  TDBGrid = class(Vcl.DBGrids.TDBGrid)
  protected
    procedure DrawCellBackground(const ARect: TRect; AColor: TColor;
      AState: TGridDrawState; ACol, ARow: Integer); override;
  end;
  TfrmOrdemServico = class(TForm)
    imgNovo: TImage;
    lblF2: TLabel;
    imgDesfazer: TImage;
    imgSalvar: TImage;
    imgExcluir: TImage;
    imgEditar: TImage;
    lblF3: TLabel;
    lblF4: TLabel;
    lblF5: TLabel;
    lblF6: TLabel;
    grpPesquisa: TGroupBox;
    pgcOrdemSevico: TPageControl;
    tbsTabela: TTabSheet;
    grdTabela: TDBGrid;
    tdsCadastro: TTabSheet;
    grpCadastro: TGroupBox;
    ActionList1: TActionList;
    actEditar: TAction;
    actDesfazer: TAction;
    WindowClose1: TWindowClose;
    actMinimizar: TAction;
    actIncluir: TAction;
    actSalvar: TAction;
    actExcluir: TAction;
    actPesquisa: TAction;
    grpMensagem: TGroupBox;
    lblMsg: TLabel;
    imgSair: TImage;
    grpPesquisaEntrada: TGroupBox;
    cboPesquisaEntrada: TComboBox;
    dtpDe_Entrada: TDateTimePicker;
    dtpA_Entrada: TDateTimePicker;
    lblDe_Entrada: TLabel;
    lblA_Entrada: TLabel;
    grpPesquisaTermino: TGroupBox;
    lblDe_Termino: TLabel;
    lblA_Termino: TLabel;
    cboPesquisaTermino: TComboBox;
    dtpDe_Termino: TDateTimePicker;
    dtpA_Termino: TDateTimePicker;
    grpPesquisaSaida: TGroupBox;
    lblDe_Saida: TLabel;
    lblA_Saida: TLabel;
    cboPesquisaSaida: TComboBox;
    dtpDe_Saida: TDateTimePicker;
    dtpA_Saida: TDateTimePicker;
    grpPesquisaGarantia: TGroupBox;
    lblDe_Garantia: TLabel;
    lblA_Garantia: TLabel;
    cboPesquisaGarantia: TComboBox;
    dtpDe_Garantia: TDateTimePicker;
    dtpA_Garantia: TDateTimePicker;
    grpPesquisaAbandonadas: TGroupBox;
    lblDe_Abandono: TLabel;
    lblA_Abandono: TLabel;
    dtpDe_Abandono: TDateTimePicker;
    dtpA_Abandono: TDateTimePicker;
    chkOsAbandonadas: TCheckBox;
    grpPesquisaFaixasOS: TGroupBox;
    lblOS_Inicial: TLabel;
    lblOS_Final: TLabel;
    edtOs_Inicial: TJvValidateEdit;
    edtOs_Final: TJvValidateEdit;
    grpFiltraCliente: TGroupBox;
    grpFiltraEquipamento: TGroupBox;
    grpPesquisaSituacao: TGroupBox;
    grpPesquisaOSTerceiros: TGroupBox;
    edtOSTerceiros: TJvValidateEdit;
    grpFiltraPrioridade: TGroupBox;
    cboPesquisaPrioridade: TComboBox;
    grpFiltraResponsavel: TGroupBox;
    cboFiltrarResponsavel: TDBLookupComboBox;
    grpPesquisaGarantidor: TGroupBox;
    btnPesquisarCliente: TButton;
    btnPesquisarEquipamento: TButton;
    cboFiltrarGarantidor: TDBLookupComboBox;
    cboFiltrarSituacao: TDBLookupComboBox;
    imgFiltroPesquisa: TImage;
    imgLimpaFiltroGarantidor: TImage;
    imgLimparFiltroSituacao: TImage;
    imgLimparFiltroResponsavel: TImage;
    imgGerarRelatorioConsulta: TImage;
    grpInformacoesCliente: TGroupBox;
    lblRazaoSocial: TLabel;
    lblEnereco: TLabel;
    lblCNPJ_Cliente: TLabel;
    lblNumero: TLabel;
    lblCEP_Cliente: TLabel;
    lblIECliente: TLabel;
    edtRSocial: TDBText;
    edtEndereco: TDBText;
    edtCNPJ: TDBText;
    edtIECliente: TDBText;
    edtNumero_Cliente: TDBText;
    edtCEP_Cliente: TDBText;
    lblBairro_Cliente: TLabel;
    lblCidade_Cliente: TLabel;
    lblDDDTelefone: TLabel;
    lblEmail: TLabel;
    edtBairro: TDBText;
    edtCidade_Cliente: TDBText;
    edtDDD_Cliente: TDBText;
    edtTelefone_Cliente: TDBText;
    edtEmail_Cliente: TDBText;
    pgcItensOS: TPageControl;
    grpInformacoesValores: TGroupBox;
    lblValorAdiantamento: TLabel;
    edtAdiantamento: TDBEdit;
    lblValorMaoObra: TLabel;
    edtValorServicos: TDBEdit;
    lblValorPecas: TLabel;
    edtValorPecas: TDBEdit;
    lblOutrosValores: TLabel;
    edtOutrosValores: TDBEdit;
    lblValorTotal: TLabel;
    edtValorTotal: TDBEdit;
    grpInformacoesGerais: TGroupBox;
    lblDataEntrada: TLabel;
    lbldataTermino: TLabel;
    lblDatasaida: TLabel;
    edtDataEntrada: TJvDBDateTimePicker;
    edtDataTermino: TJvDBDateEdit;
    edtDataSaida: TJvDBDateEdit;
    grpSituacaoOS: TGroupBox;
    cboSituacaoOS: TDBLookupComboBox;
    grpGarantia: TGroupBox;
    edtDataGarantia: TJvDBDateEdit;
    tbsEquipamento: TTabSheet;
    tbsServicos: TTabSheet;
    tbsPecas: TTabSheet;
    tbsObservacao: TTabSheet;
    grpPrioridade: TGroupBox;
    grpTecnicoResponsavel: TGroupBox;
    cbpTecnicoResponsavel: TDBLookupComboBox;
    grpTBSEquipamentos: TGroupBox;
    grpEquipamento: TGroupBox;
    grpKm: TGroupBox;
    grpAcessorios: TGroupBox;
    grpObservacoes: TGroupBox;
    grpModelo: TGroupBox;
    grpNumero: TGroupBox;
    grpServicoAExecutar: TGroupBox;
    grpOutrosItens: TGroupBox;
    grpTBSServico: TGroupBox;
    grdServicos: TDBGrid;
    memObservacoesInt: TDBMemo;
    lblObservacoesInternas: TLabel;
    memObservacoes: TDBMemo;
    memDefeito: TDBMemo;
    grpLaudo: TGroupBox;
    grdPecas: TDBGrid;
    imgServicoPadrao: TImage;
    imgServicoAvulso: TImage;
    grpTotalHoras: TGroupBox;
    edtTotalHoras: TDBEdit;
    grpTotalServico: TGroupBox;
    edtTotalServico: TDBEdit;
    imgDeslocamentos: TImage;
    imgIncluirPecaRevenda: TImage;
    imgIncluirPecaConsumo: TImage;
    imgIncluirKitMontado: TImage;
    imgRequisicao: TImage;
    edtEquipamento: TDBEdit;
    edtModelo: TDBEdit;
    edtNumero: TDBEdit;
    edtOutrosItens: TDBEdit;
    edtKM: TDBEdit;
    memAcessorios: TDBMemo;
    dtpHora_Entrada: TJvDBDateTimePicker;
    cboPrioridade: TJvDBComboBox;
    memLaudo: TDBMemo;
    imgPreencherLaudo: TImage;
    lblNumeroOS: TLabel;
    edtOrdemDeServico: TDBText;
    actIncluirServicoPadrao: TAction;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    JvDBDateTimePicker2: TJvDBDateTimePicker;
    actExcluirItemServicoOS: TAction;
    actPesquisaOrdemServico: TAction;
    actIncluirServicoAvulso: TAction;
    actIncluirPecaPadrao: TAction;
    actExcluirItemPecaOS: TAction;
    actIncluirpecaAvulsa: TAction;
    actRequisicaoPecaOS: TAction;
    imgOr�amento: TImage;
    actOrcamentoOS: TAction;
    imgEncerrarOS: TImage;
    actImprimirOS: TAction;
    actEncerramentoOS: TAction;
    actLaudoOS: TAction;
    imgHistoricoOS: TImage;
    actIncluirKit: TAction;
    imgTrocarCliente: TImage;
    actAlterarClienteOS: TAction;
    imgCS: TImage;
    actDeslocamentoOS: TAction;
    lblDeslocamento: TLabel;
    edtDeslocamento: TDBEdit;
    lblQtdHistoricoOS: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdTabelaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure WindowClose1Execute(Sender: TObject);
    procedure dtpDe_EntradaExit(Sender: TObject);
    procedure dtpDe_TerminoExit(Sender: TObject);
    procedure dtpDe_SaidaExit(Sender: TObject);
    procedure dtpDe_GarantiaExit(Sender: TObject);
    procedure dtpDe_AbandonoCloseUp(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnPesquisarEquipamentoClick(Sender: TObject);
    procedure AbrirTabelas;
    procedure imgLimparFiltroSituacaoClick(Sender: TObject);
    procedure imgLimpaFiltroGarantidorClick(Sender: TObject);
    procedure imgLimparFiltroResponsavelClick(Sender: TObject);
    procedure grdTabelaDblClick(Sender: TObject);
    procedure cboPesquisaEntradaKeyPress(Sender: TObject; var Key: Char);
    procedure dtpDe_EntradaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtOs_InicialEnter(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    function AbrirTabelaOrdemServico(pOpcao: smallint; pConteudo: string): boolean;
    function Montar_SQL_Pesquisa_OrdemServico(pOpcao: smallint):string;
    procedure edtAdiantamentoKeyPress(Sender: TObject; var Key: Char);
    procedure grdServicosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdPecasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtDataEntradaEnter(Sender: TObject);
    procedure edtAdiantamentoExit(Sender: TObject);
    procedure actIncluirServicoPadraoExecute(Sender: TObject);
    procedure grdServicosDblClick(Sender: TObject);
    procedure grdServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actExcluirItemServicoOSExecute(Sender: TObject);
    procedure actPesquisaOrdemServicoExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure imgHistoricoOSClick(Sender: TObject);
    procedure actIncluirServicoAvulsoExecute(Sender: TObject);
    procedure actIncluirPecaPadraoExecute(Sender: TObject);
    procedure grdPecasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actExcluirItemPecaOSExecute(Sender: TObject);
    procedure grdPecasDblClick(Sender: TObject);
    procedure actIncluirpecaAvulsaExecute(Sender: TObject);
    procedure actRequisicaoPecaOSExecute(Sender: TObject);
    procedure actOrcamentoOSExecute(Sender: TObject);
    procedure actDesfazerExecute(Sender: TObject);
    procedure actImprimirOSExecute(Sender: TObject);
    procedure actEncerramentoOSExecute(Sender: TObject);
    procedure actLaudoOSExecute(Sender: TObject);
    procedure actIncluirKitExecute(Sender: TObject);
    procedure actAlterarClienteOSExecute(Sender: TObject);
    procedure imgCSClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actDeslocamentoOSExecute(Sender: TObject);
    procedure cboPesquisaEntradaCloseUp(Sender: TObject);
  private
    { Private declarations }
    procedure LimparMSG_ERRO;
    procedure HabilitaDesabilitaControles(pOpcao:boolean);
    procedure Relacionar_Servico_OS(pOrdem_servico:integer);
    procedure Relacionar_Cliente_OS(pCliente:integer);
    procedure Relacionar_Historico_OS(pOrdem_Servico:integer);
    procedure Relacionar_Pecas_OS(pOrdem_servico:integer);
    procedure RelacionarItemProducao(pProducao:integer);
    function RetornarNomeCidade(pCidade:integer):string;
    function Man_Tab_OrdemServico(pOpcao:smallint):boolean;
    function Man_Tab_Historico(pOpcao:smallint; pHistorico:string): boolean;
    function Man_Tab_ItenOS_Servicos(pOpcao: smallint; pItem_Os:Integer):boolean;
    procedure CalcularTotaisOS;
    procedure Resetar_Pesquisa;
    procedure AtualizarSaldoProduto(pOperacao:smallint);
    function PesquisarItensOSPecas(pProduto:integer):boolean;
    procedure ClienteAvulso;
    procedure ClienteCadastrado;
    procedure EquipamentoAvulso;
    procedure EquipamentoCadastrado;
  public
    { Public declarations }
    function Man_Tab_ItenOS_Pecas(pOpcao: smallint; pItem_Os:Integer):boolean;
    function Retornar_Qtd_Historico_OS(pOrdemServico:integer): string;
  end;

var
  frmOrdemServico: TfrmOrdemServico;

implementation

{$R *.dfm}

uses uConstantes_Padrao, uFuncoes, dataDBEXMaster, dataMProvider,
  dataMRelatorios, dataMSProcedure, dataMSource, modPesqCliente,
  modPesqEquipamento, modItemServicoPadrao, modHistorico, modItemServicoAvulso,
  modItemPecasPadrao, modAlterarItenPecaOS, modItemPecasAvulsas,
  modFormaPagtoOS, modEncerramentoOs, modPesquisarKit, modIncluirKit,
  modComunicacaoServico, modClienteAvulso, modEquipamentoAvulso,
  modDeslocamentoOS;

function TfrmOrdemServico.AbrirTabelaOrdemServico(pOpcao: smallint; pConteudo: string): boolean;
var
  sWhere:string;
begin

  dmMProvider.cdsOrdemServico.Close;
  dmMProvider.cdsOrdemServico.ProviderName := 'dspOrdemServico';
  dmDBEXMaster.fdqOrdemServico.SQL.Clear;
  dmDBEXMaster.fdqOrdemServico.SQL.Add('SELECT * from ORDEM_DE_SERVICO');

  sWhere := Montar_SQL_Pesquisa_OrdemServico(pOpcao);

  dmDBEXMaster.fdqOrdemServico.SQL.Add(sWhere);
  dmDBEXMaster.fdqOrdemServico.SQL.Add('ORDER BY ORDEM_DE_SERVICO DESC');

  try

    dmMProvider.cdsOrdemServico.Open;
// 07/06/2016
//    Relacionar_Cliente_OS(dmMProvider.cdsClientesCLIENTE.Value);

    dmMProvider.cdsOrdemServico.ProviderName := '';

    if (dmMProvider.cdsOrdemServico.IsEmpty) and  (pConteudo <> '-1')then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
      TocarSomAlerta(ord(SystemHand));

    end
    else if pConteudo = '-1' then
    begin

      dmMProvider.cdsSituacoes_OS.Close;
      dmMProvider.cdsSituacoes_OS.ProviderName := 'dspSituacoes_OS';

      dmDBEXMaster.fdqSituacoesOS.SQL.Clear;
      dmDBEXMaster.fdqSituacoesOS.SQL.Add('select * from situacoes_os');

      if pOpcao = 0 then
        dmDBEXMaster.fdqSituacoesOS.SQL.Add('where abertura_os = 1');

      dmDBEXMaster.fdqSituacoesOS.SQL.Add('order by descricao');

      dmMProvider.cdsSituacoes_OS.Open;
      dmMProvider.cdsSituacoes_OS.ProviderName := '';

    end;

    Result := not dmMProvider.cdsOrdemServico.IsEmpty;

   except
    on E: exception do
      Tratar_Erro_Conexao(E);

  end;


end;

procedure TfrmOrdemServico.AbrirTabelas;
begin

  dmMProvider.cdsFSituacaoPesq_OS.Close;
  dmMProvider.cdsFSituacaoPesq_OS.ProviderName := 'dspFSituacaoPesq_OS';

  dmDBEXMaster.fdqSituacoesOS.SQL.Clear;
  dmDBEXMaster.fdqSituacoesOS.SQL.Add('select * from situacoes_os');
  dmDBEXMaster.fdqSituacoesOS.SQL.Add('order by descricao');

  dmMProvider.cdsFSituacaoPesq_OS.Open;
  dmMProvider.cdsFSituacaoPesq_OS.ProviderName := '';

  dmMProvider.cdsFGarantidor_OS.Close;
  dmMProvider.cdsFGarantidor_OS.ProviderName := 'dspFGarantidor_OS';

  dmDBEXMaster.fdqClientes.SQL.Clear;
  dmDBEXMaster.fdqClientes.SQL.Add('select * from clientes');
  dmDBEXMaster.fdqClientes.SQL.Add('where garantidor_os = 1');
  dmDBEXMaster.fdqClientes.SQL.Add('order by razaosocial');

  dmMProvider.cdsFGarantidor_OS.Open;
  dmMProvider.cdsFGarantidor_OS.ProviderName := '';

  dmMProvider.cdsFuncionarios.Close;
  dmMProvider.cdsFuncionarios.ProviderName := 'dspFuncionarios';

  dmDBEXMaster.fdqFuncionarios.SQL.Clear;
  dmDBEXMaster.fdqFuncionarios.SQL.Add('select * from funcionario');
  dmDBEXMaster.fdqFuncionarios.SQL.Add('order by nome');

  dmMProvider.cdsFuncionarios.Open;
  dmMProvider.cdsFuncionarios.ProviderName := '';

  dmMProvider.cdsFilial.Close;
  dmMProvider.cdsFilial.ProviderName := 'dspFilial';

  dmDBEXMaster.fdqFilial.SQL.Clear;
  dmDBEXMaster.fdqFilial.SQL.Add('SELECT FILIAL.*, CIDADES.NOME NOMECIDADE, ESTADOS.NOME NOMEESTADO,');
  dmDBEXMaster.fdqFilial.SQL.Add('CIDADES.CODIGO_MUNICIPIO, ESTADOS.CODIGO_ESTADO_IBGE');
  dmDBEXMaster.fdqFilial.SQL.Add('FROM FILIAL FILIAL');
  dmDBEXMaster.fdqFilial.SQL.Add('JOIN CIDADES CIDADES');
  dmDBEXMaster.fdqFilial.SQL.Add('ON(CIDADES.CIDADE = FILIAL.CIDADE)');
  dmDBEXMaster.fdqFilial.SQL.Add('JOIN ESTADOS ESTADOS');
  dmDBEXMaster.fdqFilial.SQL.Add('ON(ESTADOS.SIGLA = FILIAL.ESTADO)');
  dmDBEXMaster.fdqFilial.SQL.Add('where filial.filial= ' + IntToStr(dmDBEXMaster.iIdFilial));

  dmMProvider.cdsFilial.Open;
  dmMProvider.cdsFilial.ProviderName := '';

  dmMProvider.cdsUsuarios.Close;
  dmMProvider.cdsUsuarios.ProviderName  := 'dspUsuarios';

  dmDBEXMaster.fdqUsuarios.SQL.Clear;
  dmDBEXMaster.fdqUsuarios.SQL.Add('select * from usuarios');
  dmDBEXMaster.fdqUsuarios.SQL.Add('where login = ' + QuotedStr(dmDBEXMaster.sNomeUsuario));

  dmMProvider.cdsUsuarios.Open;
  dmMProvider.cdsUsuarios.ProviderName  := '';


end;

procedure TfrmOrdemServico.actAlterarClienteOSExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    frmPesquisaCliente      := TfrmPesquisaCliente.Create(self);
    frmPesquisaCliente.Tag  := ord(PermiteClienteAvulso);

    if frmPesquisaCliente.ShowModal = mrOk then
    begin

      //trata cliente avulso
      if frmPesquisaCliente.chkCliente_Avuso.Checked then
      begin

        frmModClienteAvulso := TfrmModClienteAvulso.Create(self);
        if frmModClienteAvulso.ShowModal <> mrOk then
           exit;

      end;

      if frmPesquisaCliente.chkCliente_Avuso.Checked then
        ClienteAvulso
      else
        ClienteCadastrado;

//        dmMProvider.cdsOrdemServicoCLIENTE.Value := dmMProvider.cdsClientesCLIENTE.Value;

      if Man_Tab_OrdemServico(0) then
      begin

        dmMProvider.cdsOrdemServico.Post;
        HabilitaDesabilitaControles(false);

      end;

    end;

    FreeAndNil(frmPesquisaCliente);

  end;

end;

procedure TfrmOrdemServico.actDesfazerExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
    dmMProvider.cdsOrdemServico.Cancel;

  if dmMProvider.cdsItens_OS_servico.State in [dsEdit, dsInsert] then
    dmMProvider.cdsItens_OS_servico.Cancel;

  if dmMProvider.cdsItens_OS_Pecas.State in [dsEdit, dsInsert] then
    dmMProvider.cdsItens_OS_Pecas.Cancel;

  pgcOrdemSevico.Pages[1].TabVisible  := false;
  pgcOrdemSevico.ActivePageIndex      := 0;
  pgcItensOS.ActivePageIndex          := 0;

  HabilitaDesabilitaControles(false);

end;

procedure TfrmOrdemServico.actDeslocamentoOSExecute(Sender: TObject);
begin

  if not dmMProvider.cdsOrdemServico.IsEmpty then
  begin

    if InserindoEditando(dmMProvider.cdsOrdemServico) then
    begin

      frmDeslocamentoOS := TfrmDeslocamentoOS.Create(self);
      frmDeslocamentoOS.ShowModal;

      FreeAndNil(frmDeslocamentoOS);

      dmMProvider.cdsDeslocamentoOS.First;
      if not InserindoEditando(dmMProvider.cdsOrdemServico) then
        dmMProvider.cdsOrdemServico.Edit;

      dmMProvider.cdsOrdemServicoVALOR_DESLOCAMENTO.Value := 0;

      while not dmMProvider.cdsDeslocamentoOS.Eof do
      begin

        dmMProvider.cdsOrdemServicoVALOR_DESLOCAMENTO.Value := dmMProvider.cdsOrdemServicoVALOR_DESLOCAMENTO.Value + (dmMProvider.cdsDeslocamentoOSVALOR_ALIMENTACAO.Value + dmMProvider.cdsDeslocamentoOSVALOR_HOSPEDAGEM.Value);
        dmMProvider.cdsDeslocamentoOS.Next;

      end;

    end;

  end;

end;

procedure TfrmOrdemServico.actEditarExecute(Sender: TObject);
begin

  LimparMSG_ERRO;

  if dmMProvider.cdsOrdemServico.Active then
  begin

    if not (dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert]) and (dmMProvider.cdsOrdemServicoDATA_TERMINO.Value <= 0) then
    begin

      pgcOrdemSevico.Pages[1].TabVisible  := true;
      pgcOrdemSevico.ActivePageIndex      := 1;

      AtualizarSaldoProduto(0);

      HabilitaDesabilitaControles(True);
      dmMProvider.cdsOrdemServico.Edit;
      edtDataEntrada.SetFocus;

    end
    else if dmMProvider.cdsOrdemServicoDATA_TERMINO.Value >  0 then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_OS_ENCERRADA;
      Application.ProcessMessages;

    end;

  end;


end;

procedure TfrmOrdemServico.actEncerramentoOSExecute(Sender: TObject);
begin

  LimparMSG_ERRO;

  if dmMProvider.cdsOrdemServico.Active then
  begin

    if not dmMProvider.cdsOrdemServico.IsEmpty then
    begin

      if dmMProvider.cdsOrdemServicoDATA_TERMINO.Value <= 0 then
      begin

        frmEncerramentoOS      := TfrmEncerramentoOS.Create(self);
        if frmEncerramentoOS.ShowModal = mrOk then
        begin

          if Man_Tab_OrdemServico(0) then
          begin

            AtualizarSaldoProduto(1);

            FreeAndNil(frmEncerramentoOS);

            dmMProvider.cdsSituacoesOS_ENC.Close;
            dmMProvider.cdsSituacoesOS_ENC.ProviderName := 'dspSituacoesOS_ENC';

            dmDBEXMaster.fdqSituacoesOS.SQL.Clear;
            dmDBEXMaster.fdqSituacoesOS.SQL.Add('select * from situacoes_os');
            dmDBEXMaster.fdqSituacoesOS.SQL.Add('where fechamento_os = 1');
            dmDBEXMaster.fdqSituacoesOS.SQL.Add('order by descricao');

            dmMProvider.cdsSituacoesOS_ENC.Open;
            dmMProvider.cdsSituacoesOS_ENC.ProviderName := '';

          end;

        end;

      end
      else
      begin

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_OS_ENCERRADA;
        Application.ProcessMessages;

      end;

    end;

  end;

end;

procedure TfrmOrdemServico.actExcluirItemPecaOSExecute(Sender: TObject);
begin

  LimparMSG_ERRO;

  Man_Tab_ItenOS_Pecas(1, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value);

  dmMProvider.cdsItens_OS_Pecas.Delete;
  //Relacionar_Pecas_OS(dmMProvider.cdsItens_OS_servicoORDEM_SERVICO.Value);

  CalcularTotaisOS;

end;

procedure TfrmOrdemServico.actExcluirItemServicoOSExecute(Sender: TObject);
begin

  LimparMSG_ERRO;
  Man_Tab_ItenOS_Servicos(1, dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value);
  dmMProvider.cdsItens_OS_servico.Delete;

//  Relacionar_Servico_OS(dmMProvider.cdsItens_OS_servicoORDEM_SERVICO.Value);

end;

procedure TfrmOrdemServico.actImprimirOSExecute(Sender: TObject);
begin

  if not dmMProvider.cdsOrdemServico.IsEmpty then
  begin

    if FileExists(ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav') then
    begin

      dmRelatorios.rvsGenesisAC.SystemPreview.ZoomFactor  := 126.4;
      dmRelatorios.rvdGenesis.DataSet                     := dmRelatorios.cdsRequisicaoPecaOS;

      dmRelatorios.rvpGenesisAC.ProjectFile := ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav';
      dmRelatorios.rvpGenesisAC.SelectReport('rptOrdemServico',true);
      dmRelatorios.rvpGenesisAC.SetParam('pNOME_LOJA',dmMProvider.cdsFilialRAZAOSOCIAL.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pLOGO_MARCA',ExtractFilePath(Application.ExeName) + 'Logomarca\LogoMarca.bmp');
      dmRelatorios.rvpGenesisAC.SetParam('pEndereco',Trim(dmMProvider.cdsFilialENDERECO.Value) + ','
                                         + IntToStr(dmMProvider.cdsFilialNUMERO.Value) + ','
                                         + FormatarCEP(Trim(dmMProvider.cdsFilialCEP.Value)));
      dmRelatorios.rvpGenesisAC.SetParam('pBairroCidade',Trim(dmMProvider.cdsFilialBAIRRO.Value) + ','
                                         + Trim(dmMProvider.cdsFilialNOMECIDADE.Value)+ '-'
                                         + Trim(dmMProvider.cdsFilialESTADO.Value));
      dmRelatorios.rvpGenesisAC.SetParam('pTelefones','(' + Trim(dmMProvider.cdsFilialDDD.Value) + ') '
                                         + Trim(dmMProvider.cdsFilialTELEFONE1.Value));
      dmRelatorios.rvpGenesisAC.SetParam('pWeb',Trim(dmMProvider.cdsFilialEMAIL.Value) + ' / '
                                         + Trim(dmMProvider.cdsFilialHTTP.Value));
      dmRelatorios.rvpGenesisAC.Execute;
      dmRelatorios.rvpGenesisAC.Close;

  end
  else
    Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ARQ_NEXISTE + #13
                + ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav'), 'Aten��o!',mb_IconWarning + mb_Ok);

  end;

end;

procedure TfrmOrdemServico.actIncluirExecute(Sender: TObject);
begin

  LimparMSG_ERRO;

  if not (dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert]) then
  begin

    frmPesquisaCliente      := TfrmPesquisaCliente.Create(self);
    frmPesquisaCliente.Tag  := ord(PermiteClienteAvulso);

    if frmPesquisaCliente.ShowModal = mrOk then
    begin

      //trata cliente avulso
      if frmPesquisaCliente.chkCliente_Avuso.Checked then
      begin

        frmModClienteAvulso := TfrmModClienteAvulso.Create(self);
        if frmModClienteAvulso.ShowModal <> mrOk then
           exit;

      end
      else
        Relacionar_Cliente_OS(dmMProvider.cdsPesqClientesCLIENTE.Value);

      frmPesquisaEquipamento          := TfrmPesquisaEquipamento.Create(self);
      frmPesquisaEquipamento.iCliente := dmMProvider.cdsPesqClientesCLIENTE.Value;

      if frmPesquisaEquipamento.ShowModal = mrOk then
      begin

        if frmPesquisaEquipamento.chkUsarEquipamentoAvulso.Checked then
        begin

          frmModEquipamentoAvulso := TfrmModEquipamentoAvulso.Create(self);
          if frmModEquipamentoAvulso.ShowModal <> mrOk then
            exit
          else
          begin

            AbrirTabelaOrdemServico(0,'-1');

            dmMProvider.cdsOrdemServico.Append;

            if frmPesquisaCliente.chkCliente_Avuso.Checked then
              ClienteAvulso
            else
              ClienteCadastrado;

            EquipamentoAvulso;

          end;

          FreeAndNil(frmModClienteAvulso);
          FreeAndNil(frmModEquipamentoAvulso);

        end
        else
        begin

          AbrirTabelaOrdemServico(0,'-1');

          dmMProvider.cdsOrdemServico.Append;

          if frmPesquisaCliente.chkCliente_Avuso.Checked then
            ClienteAvulso
          else
            ClienteCadastrado;

          EquipamentoCadastrado;

        end;

        Man_Tab_OrdemServico(0);

        Relacionar_Servico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
        Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);

        pgcOrdemSevico.Pages[1].TabVisible                    := true;
        pgcOrdemSevico.ActivePageIndex                        := 1;
        edtDataEntrada.Time                                   := time;
        HabilitaDesabilitaControles(True);

        edtDataEntrada.SetFocus;

      end;

      FreeAndNil(frmPesquisaEquipamento);

    end;

    FreeAndNil(frmPesquisaCliente);

  end;

end;

procedure TfrmOrdemServico.actIncluirKitExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    frmPesquisaKit      := TfrmPesquisaKit.Create(self);
    frmPesquisaKit.Tag  := 0;

    if frmPesquisaKit.ShowModal = mrOk then
    begin

      dmMProvider.cdsOrdemServicoAPARELHO.Value := dmMProvider.cdsProducaoDESCRICAO_PRODUTO.Value;

      RelacionarItemProducao(dmMProvider.cdsProducaoPRODUCAO.Value);
      frmIncluirKitMontado := TfrmIncluirKitMontado.Create(self);

      if frmIncluirKitMontado.ShowModal = mrOk then
      begin

        if Man_Tab_OrdemServico(0) then
        begin

          {incluir pe�a revenda}
          if PesquisarItensOSPecas(dmMProvider.cdsProducaoPRODUTO.Value) then
          begin

            if not dmMProvider.cdsItens_OS_Pecas.Active then
              dmMProvider.cdsItens_OS_Pecas.Open;

            dmMProvider.cdsItens_OS_Pecas.Append;
            dmMProvider.cdsItens_OS_PecasCODIGO_PECA.Value    := dmMProvider.cdsProducaoPRODUTO.Value;
            dmMProvider.cdsItens_OS_PecasDESCRICAO.Value      := dmMProvider.cdsProducaoDESCRICAO_PRODUTO.Value;
            dmMProvider.cdsItens_OS_PecasVALOR_UNITARIO.Value := dmMProvider.cdsProducaoVALOR_TOTAL.Value;
            dmMProvider.cdsItens_OS_PecasFUNCIONARIO.Value    := dmMProvider.cdsFuncionariosFUNCIONARIO.Value;
            dmMProvider.cdsItens_OS_PecasQUANTIDADE.Value     := dmMProvider.cdsProducaoRENDIMENTO.Value;
            dmMProvider.cdsItens_OS_PecasTIPO.Value           := 4; //produto acabado
            dmMProvider.cdsItens_OS_PecasDIA.AsDateTime       := Date;
            dmMProvider.cdsItens_OS_PecasVALOR_TOTAL.Value    := (dmMProvider.cdsItens_OS_PecasQUANTIDADE.Value * dmMProvider.cdsItens_OS_PecasVALOR_UNITARIO.Value);
            dmMProvider.cdsItens_OS_Pecas.Post;

          end
          else
          begin

            lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_VALIDAR_ITEM_OS_PECA;
            exit;

          end;

          dtpHora_Entrada.Date := edtDataEntrada.Date;

          if Man_Tab_ItenOS_Pecas(0, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value) then
          begin

            Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
            CalcularTotaisOS;

            dmMProvider.cdsItemProducao.First;

            while not dmMProvider.cdsItemProducao.Eof do
            begin

              {incluir insumos}

              if PesquisarItensOSPecas(dmMProvider.cdsItemProducaoPRODUTO.Value) then
              begin

                if not dmMProvider.cdsItens_OS_Pecas.Active then
                  dmMProvider.cdsItens_OS_Pecas.Open;

                dmMProvider.cdsItens_OS_Pecas.Append;
                dmMProvider.cdsItens_OS_PecasCODIGO_PECA.Value    := dmMProvider.cdsItemProducaoPRODUTO.Value;
                dmMProvider.cdsItens_OS_PecasDESCRICAO.Value      := dmMProvider.cdsItemProducaoDESCRICAO_PRODUTO.Value;
                dmMProvider.cdsItens_OS_PecasVALOR_UNITARIO.Value := 0;//dmMProvider.cdsItemProducaoCUSTO_LIQUIDO.Value;
                dmMProvider.cdsItens_OS_PecasFUNCIONARIO.Value    := dmMProvider.cdsFuncionariosFUNCIONARIO.Value;
                dmMProvider.cdsItens_OS_PecasQUANTIDADE.Value     := dmMProvider.cdsItemProducaoQUANTIDADE.Value;
                dmMProvider.cdsItens_OS_PecasTIPO.Value           := 0; //insumo
                dmMProvider.cdsItens_OS_PecasDIA.AsDateTime       := Date;
                dmMProvider.cdsItens_OS_PecasVALOR_TOTAL.Value    := 0;//(dmMProvider.cdsItens_OS_PecasQUANTIDADE.Value * dmMProvider.cdsItens_OS_PecasVALOR_UNITARIO.Value);
                dmMProvider.cdsItens_OS_Pecas.Post;

                Man_Tab_ItenOS_Pecas(0, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value);

              end;

              dmMProvider.cdsItemProducao.next;

            end;

            Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
            CalcularTotaisOS;

          end
          else
          begin

            if dmDBEXMaster.fdtMaster.Active then
              dmDBEXMaster.fdtMaster.Rollback;

          end;


        end
        else
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

        end;


      end;

      FreeAndNil(frmIncluirKitMontado);
      dmMProvider.cdsItens_OS_Pecas.First;

    end;

    FreeAndNil(frmPesquisaKit);

  end;

end;

procedure TfrmOrdemServico.actIncluirpecaAvulsaExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    frmItemPecaPadrao           := TfrmItemPecaPadrao.Create(self);
    frmItemPecaPadrao.Tag       := 0;

    if frmItemPecaPadrao.ShowModal = mrOk then
    begin

      //checa se � pe�a avulsa para consumo
      if frmItemPecaPadrao.rdgTipoPeca.ItemIndex = 3 then
      begin

        frmIncluirPecaAvulsa := TfrmIncluirPecaAvulsa.Create(self);
        if frmIncluirPecaAvulsa.ShowModal <> mrOk then
          exit

      end;

      dtpHora_Entrada.Date := edtDataEntrada.Date;

      if Man_Tab_OrdemServico(0) then
      begin

        if Man_Tab_ItenOS_Pecas(0, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value) then
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdcMaster.Commit;

          Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
          CalcularTotaisOS;
          dmDBEXMaster.fdcMaster.Close;

        end
        else
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

        end;

      end
      else
      begin

        if dmDBEXMaster.fdtMaster.Active then
          dmDBEXMaster.fdtMaster.Rollback;

      end;

      FreeAndNil(frmItemPecaPadrao);

    end;

  end;
{
  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    frmIncluirPecaAvulsa      := TfrmIncluirPecaAvulsa.Create(self);
    frmIncluirPecaAvulsa.Tag  := 0;

    if frmIncluirPecaAvulsa.ShowModal = mrOk then
    begin

      if Man_Tab_OrdemServico(0) then
      begin

        if Man_Tab_ItenOS_Pecas(0, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value) then
        begin

          dmDBEXMaster.fdtMaster.Commit;
          Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
          CalcularTotaisOS;
          dmDBEXMaster.fdcMaster.Close;

        end
        else
          dmDBEXMaster.fdtMaster.Rollback;

      end
      else
        dmDBEXMaster.fdtMaster.Rollback;

      FreeAndNil(frmIncluirPecaAvulsa);

    end;

  end;
}
end;

procedure TfrmOrdemServico.actIncluirPecaPadraoExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    if Length(Trim(dmMProvider.cdsOrdemServicoAPARELHO.Value)) <= 0 then
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_CONSISTE_EQUIP_LANC;
      Application.ProcessMessages;

    end
    else
    begin

      frmItemPecaPadrao           := TfrmItemPecaPadrao.Create(self);
      frmItemPecaPadrao.Tag       := 0;

      if frmItemPecaPadrao.ShowModal = mrOk then
      begin

        dtpHora_Entrada.Date := edtDataEntrada.Date;

        dmMProvider.cdsItens_OS_PecasDESCRICAO.Value := dmMProvider.cdsPesqProdutosDESCRICAO.Value;

        if Man_Tab_OrdemServico(0) then
        begin

          if Man_Tab_ItenOS_Pecas(0, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value) then
          begin

            if dmDBEXMaster.fdtMaster.Active then
              dmDBEXMaster.fdcMaster.Commit;

            Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);

            CalcularTotaisOS;

            dmDBEXMaster.fdcMaster.Close;

          end
          else
          begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

          end;

        end
        else
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

        end;

        FreeAndNil(frmItemPecaPadrao);

      end;

    end;

  end;

end;

procedure TfrmOrdemServico.actIncluirServicoAvulsoExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    frmItemServicoAvulso      := TfrmItemServicoAvulso.Create(self);
    frmItemServicoAvulso.Tag  := 0;

    if frmItemServicoAvulso.ShowModal = mrOk then
    begin

      dtpHora_Entrada.Date := edtDataEntrada.Date;

      if Man_Tab_OrdemServico(0) then
      begin

        dmMProvider.cdsItens_OS_servicoTIPO.Value := 1;

        if Man_Tab_ItenOS_Servicos(0, dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value) then
        begin

          dmMProvider.cdsItens_OS_servico.Post;

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdcMaster.Commit;

          dmDBEXMaster.fdcMaster.Close;

        end
        else
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

        end;

      end
      else
      begin

        if dmDBEXMaster.fdtMaster.Active then
          dmDBEXMaster.fdtMaster.Rollback;

      end;

      FreeAndNil(frmItemServicoAvulso);

    end
    else
    begin

      if dmMProvider.cdsItens_OS_servico.State in [dsEdit, dsInsert] then
        dmMProvider.cdsItens_OS_servico.Cancel;

    end;

  end;

end;

procedure TfrmOrdemServico.actIncluirServicoPadraoExecute(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsOrdemServico) then
  begin

    frmItemServicoPadrao      := TfrmItemServicoPadrao.Create(self);
    frmItemServicoPadrao.Tag  := 0;

    if frmItemServicoPadrao.ShowModal = mrOk then
    begin

      dtpHora_Entrada.Date := edtDataEntrada.Date;

      dmMProvider.cdsItens_OS_servicoDESCRICAO.Value := dmMProvider.cdsServicosDESCRICAO_1.Value + ' ' + dmMProvider.cdsServicosDESCRICAO_2.Value;

      if Man_Tab_OrdemServico(0) then
      begin

        if Man_Tab_ItenOS_Servicos(0, dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value) then
        begin

          dmMProvider.cdsItens_OS_servico.Post;
          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdcMaster.Commit;

          dmDBEXMaster.fdcMaster.Close;

        end
        else
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

        end;

      end
      else
      begin

        if dmDBEXMaster.fdtMaster.Active then
          dmDBEXMaster.fdtMaster.Rollback;

      end;

      FreeAndNil(frmItemServicoPadrao);

    end;

  end;

end;

procedure TfrmOrdemServico.actLaudoOSExecute(Sender: TObject);
begin

  if not dmMProvider.cdsOrdemServico.IsEmpty then
  begin

    ActiveControl := nil;

    if FileExists(ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav') then
    begin

      dmRelatorios.rvsGenesisAC.SystemPreview.ZoomFactor  := 126.4;
      dmRelatorios.rvdGenesis.DataSet                     := dmMProvider.cdsOrdemServico;

      dmRelatorios.rvpGenesisAC.ProjectFile := ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav';
      dmRelatorios.rvpGenesisAC.SelectReport('rptLaudoOS',False);
      dmRelatorios.rvpGenesisAC.SetParam('pNOME_LOJA',dmMProvider.cdsFilialRAZAOSOCIAL.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pLOGO_MARCA',ExtractFilePath(Application.ExeName) + 'Logomarca\LogoMarca.bmp');
      dmRelatorios.rvpGenesisAC.SetParam('pEndereco',dmMProvider.cdsFilialENDERECO.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pNumero',IntToStr(dmMProvider.cdsFilialNUMERO.Value));
      dmRelatorios.rvpGenesisAC.SetParam('pCEP',FormatarCEP(dmMProvider.cdsFilialCEP.Value));
      dmRelatorios.rvpGenesisAC.SetParam('pBairro',dmMProvider.cdsFilialBAIRRO.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pCidade',dmMProvider.cdsFilialNOMECIDADE.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pEstado',dmMProvider.cdsFilialESTADO.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pDDD',dmMProvider.cdsFilialDDD.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pTelefones',dmMProvider.cdsFilialTELEFONE1.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pEmail',dmMProvider.cdsFilialEMAIL.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pWeb',dmMProvider.cdsFilialHTTP.Value);
      dmRelatorios.rvpGenesisAC.Execute;
      dmRelatorios.rvpGenesisAC.Close;

  end
  else
    Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ARQ_NEXISTE + #13
                + ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav'), 'Aten��o!',mb_IconWarning + mb_Ok);

  end
  else
  begin

    lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_CONSISTE_RE_OS_EQUIP;
    TocarSomAlerta(ord(SystemHand));

  end;

end;

procedure TfrmOrdemServico.actOrcamentoOSExecute(Sender: TObject);
begin

  if not dmMProvider.cdsOrdemServico.IsEmpty then
  begin

    if dmMProvider.cdsOrdemServicoDATA_TERMINO.Value <= 0 then
    begin

      frmFormasPagtoOS      := TfrmFormasPagtoOS.Create(self);
      frmFormasPagtoOS.Tag  := 0;

      frmFormasPagtoOS.ShowModal;

    end;

    if FileExists(ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav') then
    begin

      dmRelatorios.rvsGenesisAC.SystemPreview.ZoomFactor  := 126.4;
      dmRelatorios.rvdGenesis.DataSet                     := dmRelatorios.cdsRequisicaoPecaOS;

      dmRelatorios.rvpGenesisAC.ProjectFile := ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav';
      dmRelatorios.rvpGenesisAC.SelectReport('rptOrcamentoOS',true);
      dmRelatorios.rvpGenesisAC.SetParam('pNOME_LOJA',dmMProvider.cdsFilialRAZAOSOCIAL.Value);
      dmRelatorios.rvpGenesisAC.SetParam('pLOGO_MARCA',ExtractFilePath(Application.ExeName) + 'Logomarca\LogoMarca.bmp');
      dmRelatorios.rvpGenesisAC.SetParam('pEndereco',Trim(dmMProvider.cdsFilialENDERECO.Value) + ','
                                         + IntToStr(dmMProvider.cdsFilialNUMERO.Value) + ','
                                         + FormatarCEP(Trim(dmMProvider.cdsFilialCEP.Value)));
      dmRelatorios.rvpGenesisAC.SetParam('pBairroCidade',Trim(dmMProvider.cdsFilialBAIRRO.Value) + ','
                                         + Trim(dmMProvider.cdsFilialNOMECIDADE.Value)+ '-'
                                         + Trim(dmMProvider.cdsFilialESTADO.Value));
      dmRelatorios.rvpGenesisAC.SetParam('pTelefones','(' + Trim(dmMProvider.cdsFilialDDD.Value) + ') '
                                         + Trim(dmMProvider.cdsFilialTELEFONE1.Value));
      dmRelatorios.rvpGenesisAC.SetParam('pWeb',Trim(dmMProvider.cdsFilialEMAIL.Value) + ' / '
                                         + Trim(dmMProvider.cdsFilialHTTP.Value));
      dmRelatorios.rvpGenesisAC.Execute;
      dmRelatorios.rvpGenesisAC.Close;

      FreeAndNil(frmFormasPagtoOS);

  end
  else
    Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ARQ_NEXISTE + #13
                + ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav'), 'Aten��o!',mb_IconWarning + mb_Ok);

  end;

end;

procedure TfrmOrdemServico.actPesquisaOrdemServicoExecute(Sender: TObject);
var
  i:integer;
begin

  LimparMSG_ERRO;

  if not (dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert]) then
  begin

    for I := 0 to 1 do
    begin

      if AbrirTabelaOrdemServico(1,'-1') then
      begin

        if dmMProvider.cdsOrdemServicoCLIENTE.Value > 0 then
          Relacionar_Cliente_OS(dmMProvider.cdsOrdemServicoCLIENTE.Value);

        Relacionar_Servico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
        Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);

      end;

    end;

    pgcOrdemSevico.ActivePageIndex  := 0;
    pgcItensOS.ActivePageIndex      := 0;
    grdTabela.SetFocus;

  end;

  Resetar_Pesquisa;

end;

procedure TfrmOrdemServico.actRequisicaoPecaOSExecute(Sender: TObject);
begin

  if FileExists(ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav') then
  begin


    dmRelatorios.rvsGenesisAC.SystemPreview.ZoomFactor  := 126.4;
    dmRelatorios.rvdGenesis.DataSet                     := dmRelatorios.cdsRequisicaoPecaOS;

    dmRelatorios.cdsRequisicaoPecaOS.Close;
    dmRelatorios.cdsRequisicaoPecaOS.ProviderName := 'dspRequisicaoPecaOS';

    dmDBEXMaster.fdqItens_OS_Pecas.SQL.Clear;
    dmDBEXMaster.fdqItens_OS_Pecas.SQL.Add('select * from itens_os_pecas');
    dmDBEXMaster.fdqItens_OS_Pecas.SQL.Add('where ordem_servico = ' + IntToStr(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value));

    dmRelatorios.cdsRequisicaoPecaOS.Open;
    dmRelatorios.cdsRequisicaoPecaOS.ProviderName := '';

    dmRelatorios.rvpGenesisAC.ProjectFile := ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav';
    dmRelatorios.rvpGenesisAC.SelectReport('rptRequiscaoPecaOS',true);
    dmRelatorios.rvpGenesisAC.SetParam('pNOME_LOJA',dmMProvider.cdsFilialRAZAOSOCIAL.Value);
    dmRelatorios.rvpGenesisAC.SetParam('pLOGO_MARCA',ExtractFilePath(Application.ExeName) + 'Logomarca\LogoMarca.bmp');
    dmRelatorios.rvpGenesisAC.Execute;
    dmRelatorios.rvpGenesisAC.Close;

  end
  else
    Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ARQ_NEXISTE + #13
                + ExtractFilePath(Application.ExeName)+'Rav\Relatorios_OS.rav'), 'Aten��o!',mb_IconWarning + mb_Ok);

end;

procedure TfrmOrdemServico.actSalvarExecute(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    CalcularTotaisOS;

    ActiveControl := nil;

    if Man_Tab_OrdemServico(0) then
    begin

      dmMProvider.cdsOrdemServico.Post;

      HabilitaDesabilitaControles(false);

      dmDBEXMaster.bNovoEquip := False;;

      AtualizarSaldoProduto(0);

    end;

    pgcOrdemSevico.Pages[1].TabVisible  := false;
    pgcOrdemSevico.ActivePageIndex      := 0;
    pgcItensOS.ActivePageIndex          := 0;

  end;

end;

procedure TfrmOrdemServico.AtualizarSaldoProduto(pOperacao:smallint);
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    dmMSProcedure.fdspAtualizarSaldoProduto.Params[0].Value := 6;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[1].Value := 0;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[2].Value := pOperacao;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[3].Value := dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[4].Value := '';
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[5].Value := 0;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[6].Value := 0;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[7].Value := dmDBEXMaster.iIdFilial;
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[8].Value := '';
    dmMSProcedure.fdspAtualizarSaldoProduto.Params[9].Value := Date;
    dmMSProcedure.fdspAtualizarSaldoProduto.ExecProc;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

  except
    on E: exception do
    begin

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

      Tratar_Erro_Conexao(E);

    end;

  end;

end;

procedure TfrmOrdemServico.btnPesquisarClienteClick(Sender: TObject);
begin

  if btnPesquisarCliente.Tag = 0 then
  begin

    frmPesquisaCliente := TfrmPesquisaCliente.Create(self);
    if frmPesquisaCliente.ShowModal = mrok then
    begin

      if frmPesquisaCliente.chkCliente_Avuso.Checked then
      begin

        frmModClienteAvulso := TfrmModClienteAvulso.Create(self);
        if frmModClienteAvulso.ShowModal = mrOk then
        begin

          btnPesquisarCliente.Tag := 2;
          btnPesquisarCliente.Caption := frmModClienteAvulso.edtNome.Text;

        end;

        FreeAndNil(frmModClienteAvulso);

      end
      else
      begin

        btnPesquisarCliente.Tag := 1;
        btnPesquisarCliente.Caption := dmMProvider.cdsPesqClientesRAZAOSOCIAL.Value;

      end;

    end;

    FreeAndNil(frmPesquisaCliente);

  end
  else  if btnPesquisarCliente.Tag = 1 then
  begin

    btnPesquisarCliente.Caption := 'Pesquisar por Cliente';
    btnPesquisarCliente.Tag     := 0;

  end;

end;

procedure TfrmOrdemServico.btnPesquisarEquipamentoClick(Sender: TObject);
begin

  if btnPesquisarEquipamento.Tag = 0 then
  begin

    frmPesquisaEquipamento := TfrmPesquisaEquipamento.Create(self);
    if frmPesquisaEquipamento.ShowModal = mrok then
    begin

      btnPesquisarEquipamento.Tag := 1;
      btnPesquisarEquipamento.Caption := dmMProvider.cdsEquipamentosMODELO.Value;

    end;

    FreeAndNil(frmPesquisaEquipamento);

  end
  else  if btnPesquisarEquipamento.Tag = 1 then
  begin

    btnPesquisarEquipamento.Caption := 'Pesquisar equipamento';
    btnPesquisarEquipamento.Tag     := 0;

  end;

end;

procedure TfrmOrdemServico.CalcularTotaisOS;
begin

  dmDBEXMaster.fdqMasterPesquisa.Close;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('select * from RETORNAR_TOTAIS_SERVICO_OS(:ip_ordem_servico)');
  dmDBEXMaster.fdqMasterPesquisa.ParamByName('IP_ORDEM_SERVICO').Value := dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value;
  dmDBEXMaster.fdqMasterPesquisa.Open;

  if not dmDBEXMaster.fdqMasterPesquisa.IsEmpty then
  begin

    if not (dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert]) then
      dmMProvider.cdsOrdemServico.Edit;

    dmMProvider.cdsOrdemServicoTOTAL_HORAS.Value        := dmDBEXMaster.fdqMasterPesquisa.FieldByName('OP_TOTAL_HORAS').Value;
    dmMProvider.cdsOrdemServicoVALOR_MAO_DE_OBRA.Value  := dmDBEXMaster.fdqMasterPesquisa.FieldByName('OP_VALOR_TOTAL').Value;
    dmMProvider.cdsOrdemServicoVALOR_PECAS.Value        := dmDBEXMaster.fdqMasterPesquisa.FieldByName('OP_TOTAL_PECAS').Value;
    dmMProvider.cdsOrdemServicoVALOR_TOTAL_OS.Value     := (dmMProvider.cdsOrdemServicoVALOR_MAO_DE_OBRA.Value
                                                            + dmMProvider.cdsOrdemServicoVALOR_PECAS.Value
                                                            + dmMProvider.cdsOrdemServicoVALOR_DESLOCAMENTO.Value
                                                            + dmMProvider.cdsOrdemServicoVALOR_OUTROS.Value)
                                                            - dmMProvider.cdsOrdemServicoVALOR_SINAL.Value;

  end;

  dmDBEXMaster.fdqMasterPesquisa.Close;

end;

procedure TfrmOrdemServico.cboPesquisaEntradaCloseUp(Sender: TObject);
begin

  lblA_Entrada.Visible  := cboPesquisaEntrada.ItemIndex = 1;
  dtpA_Entrada.Visible  := lblA_Entrada.Visible;

end;

procedure TfrmOrdemServico.cboPesquisaEntradaKeyPress(Sender: TObject;
  var Key: Char);
begin

  if Key = #13 then
  begin

    Key := #0;
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 1);

  end

end;

procedure TfrmOrdemServico.ClienteAvulso;
begin

  dmMProvider.cdsOrdemServicoCLIENTE.Value                  := 0;
  dmMProvider.cdsOrdemServicoNOME_CLIENTE.Value             := frmModClienteAvulso.edtNome.Text;
  dmMProvider.cdsOrdemServicoCNPJ_CPF.Value                 := frmModClienteAvulso.edtCNPJ_CPF.Text;
  dmMProvider.cdsOrdemServicoIE_RG.Value                    := frmModClienteAvulso.edtIE_RG.Text;
  dmMProvider.cdsOrdemServicoENDERECO_CLIENTE.Value         := frmModClienteAvulso.edtEndereco.Text;
  dmMProvider.cdsOrdemServicoNUMERO_END_CLIENTE.Value       := frmModClienteAvulso.edtNumero.Text;
  dmMProvider.cdsOrdemServicoCEP_CLIENTE.Value              := frmModClienteAvulso.edtCEP.Text;
  dmMProvider.cdsOrdemServicoUF_CLIENTE.Value               := frmModClienteAvulso.edtUF.Text;
  dmMProvider.cdsOrdemServicoBAIRRO_CLIENTE.Value           := frmModClienteAvulso.edtBairro.Text;
  dmMProvider.cdsOrdemServicoCIDADE_CLIENTE.Value           := frmModClienteAvulso.edtCidade.Text;
  dmMProvider.cdsOrdemServicoCONTATO_CLIENTE.Value          := frmModClienteAvulso.edtContato.Text;
  dmMProvider.cdsOrdemServicoDDD_CLIENTE.Value              := frmModClienteAvulso.edtDDD.Text;
  dmMProvider.cdsOrdemServicoTELEFONE_CLIENTE.Value         := frmModClienteAvulso.edtTelefone.Text;
  dmMProvider.cdsOrdemServicoEMAIL_CLIENTE.Value            := frmModClienteAvulso.edtEmail.Text;

end;

procedure TfrmOrdemServico.ClienteCadastrado;
begin

  dmMProvider.cdsOrdemServicoCLIENTE.Value                  := dmMProvider.cdsPesqClientesCLIENTE.Value;
  dmMProvider.cdsOrdemServicoNOME_CLIENTE.Value             := dmMProvider.cdsPesqClientesRAZAOSOCIAL.Value;
  dmMProvider.cdsOrdemServicoCNPJ_CPF.Value                 := dmMProvider.cdsPesqClientesCNPJ.Value;
  dmMProvider.cdsOrdemServicoIE_RG.Value                    := dmMProvider.cdsPesqClientesINSCRICAO.Value;
  dmMProvider.cdsOrdemServicoENDERECO_CLIENTE.Value         := dmMProvider.cdsPesqClientesENDERECO.Value;

  if dmMProvider.cdsPesqClientesNUMERO.Value > 0 then
    dmMProvider.cdsOrdemServicoNUMERO_END_CLIENTE.Value     := IntToStr(dmMProvider.cdsPesqClientesNUMERO.Value)
  else
    dmMProvider.cdsOrdemServicoNUMERO_END_CLIENTE.Value     := 'S/N';

  dmMProvider.cdsOrdemServicoCEP_CLIENTE.Value              := dmMProvider.cdsPesqClientesCEP.Value;
  dmMProvider.cdsOrdemServicoUF_CLIENTE.Value               := dmMProvider.cdsPesqClientesESTADO.Value;
  dmMProvider.cdsOrdemServicoBAIRRO_CLIENTE.Value           := dmMProvider.cdsPesqClientesBAIRRO.Value;

  dmMProvider.cdsOrdemServicoCIDADE_CLIENTE.Value           := RetornarNomeCidade(dmMProvider.cdsPesqClientesCIDADE.Value);
  dmMProvider.cdsOrdemServicoCONTATO_CLIENTE.Value          := dmMProvider.cdsPesqClientesCONTATO.Value;

  dmMProvider.cdsOrdemServicoDDD_CLIENTE.Value              := dmMProvider.cdsPesqClientesDDD.Value;
  dmMProvider.cdsOrdemServicoTELEFONE_CLIENTE.Value         := dmMProvider.cdsPesqClientesTELEFONE1.Value;
  dmMProvider.cdsOrdemServicoEMAIL_CLIENTE.Value            := dmMProvider.cdsPesqClientesEMAIL.Value;

end;

procedure TfrmOrdemServico.dtpDe_AbandonoCloseUp(Sender: TObject);
begin

  dtpA_Abandono.Date    := EndOfTheMonth(dtpDe_Abandono.Date);

end;

procedure TfrmOrdemServico.dtpDe_EntradaExit(Sender: TObject);
begin

  dtpA_Entrada.Date    := EndOfTheMonth(dtpDe_Entrada.Date);

end;

procedure TfrmOrdemServico.dtpDe_EntradaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  iDirecao: Integer;
begin

  // habilita movimenta��o dos campos com as setas acima/abaixo
  iDirecao := -1;

  case Key of

    VK_DOWN:
      iDirecao := 0; { Pr�ximo }
    VK_UP:
      iDirecao := 1; { Anterior }

  end;

  if iDirecao <> -1 then
  begin

    Perform(WM_NEXTDLGCTL, iDirecao, 0);
    Key := 0;

  end;

end;

procedure TfrmOrdemServico.dtpDe_GarantiaExit(Sender: TObject);
begin

  dtpA_Garantia.Date    := EndOfTheMonth(dtpDe_Garantia.Date);

end;

procedure TfrmOrdemServico.dtpDe_SaidaExit(Sender: TObject);
begin

  dtpA_Saida.Date    := EndOfTheMonth(dtpDe_Saida.Date);

end;

procedure TfrmOrdemServico.dtpDe_TerminoExit(Sender: TObject);
begin

  dtpA_Termino.Date    := EndOfTheMonth(dtpDe_Termino.Date);

end;

procedure TfrmOrdemServico.edtAdiantamentoExit(Sender: TObject);
begin

   MudarCorEdit(Sender);

   if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
   begin

    dmMProvider.cdsOrdemServicoVALOR_TOTAL_OS.Value := (dmMProvider.cdsOrdemServicoVALOR_MAO_DE_OBRA.Value
                                                        + dmMProvider.cdsOrdemServicoVALOR_PECAS.Value
                                                        + dmMProvider.cdsOrdemServicoVALOR_OUTROS.Value)
                                                        - dmMProvider.cdsOrdemServicoVALOR_SINAL.Value;

   end;

end;

procedure TfrmOrdemServico.edtAdiantamentoKeyPress(Sender: TObject;
  var Key: Char);
begin

  if Key = FormatSettings.DecimalSeparator then
    Key := ',';

  if Key = #13 then
  begin

    Key := #0;
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 1);

  end;

end;

procedure TfrmOrdemServico.edtDataEntradaEnter(Sender: TObject);
begin

   MudarCorEdit(Sender);

end;

procedure TfrmOrdemServico.edtOs_InicialEnter(Sender: TObject);
begin

  MudarCorEdit(Sender);

end;

procedure TfrmOrdemServico.EquipamentoAvulso;
begin

  dmMProvider.cdsOrdemServicoCODIGO_EQUIPAMENTO.Value       := 0;
  dmMProvider.cdsOrdemServicoAPARELHO.Value                 := frmModEquipamentoAvulso.edtAparelho.Text;
  dmMProvider.cdsOrdemServicoMODELO.Value                   := frmModEquipamentoAvulso.edtModelo.Text;
  dmMProvider.cdsOrdemServicoMARCA.Value                    := frmModEquipamentoAvulso.edtNumero.Text;
  dmMProvider.cdsOrdemServicoNUMERO_SERIE.Value             := frmModEquipamentoAvulso.edtOutrosItens.Text;
  dmMProvider.cdsOrdemServicoETIQ_PATRIMONIO.Value          := frmModEquipamentoAvulso.edtKM.Text;

end;

procedure TfrmOrdemServico.EquipamentoCadastrado;
begin

  dmMProvider.cdsOrdemServicoCODIGO_EQUIPAMENTO.Value       := dmMProvider.cdsEquipamentosCODIGO_EQUIPAMENTO.Value;
  dmMProvider.cdsOrdemServicoAPARELHO.Value                 := dmMProvider.cdsEquipamentosMODELO.Value;
  dmMProvider.cdsOrdemServicoMODELO.Value                   := dmMProvider.cdsEquipamentosMARCA.Value;
  dmMProvider.cdsOrdemServicoMARCA.Value                    := dmMProvider.cdsEquipamentosOPERADORA.Value;
  dmMProvider.cdsOrdemServicoNUMERO_SERIE.Value             := dmMProvider.cdsEquipamentosNUMERO_SERIE.Value;
  dmMProvider.cdsOrdemServicoETIQ_PATRIMONIO.Value          := dmMProvider.cdsEquipamentosETIQ_PATRIMONIO.Value;

end;

procedure TfrmOrdemServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if InserindoEditando(dmMProvider.cdsOrdemServico) then
    AtualizarSaldoProduto(0);

end;

procedure TfrmOrdemServico.FormCreate(Sender: TObject);
var
  i:integer;
begin

  DesabilitarBotaoFecharForm(self.Handle);

  Color                               := COR_PADRAO_TELAS;
  Caption                             := ' ' + Application.Title + ' - ' + RetornarVersao(ParamStr(0),1) + 'xe';

  dmDBEXMaster.sNomeUsuario           := ParamStr(1);
  dmDBEXMaster.sSenha                 := paramstr(2);
  dmDBEXMaster.iIdUsuario             := StrToInt(ParamStr(3));
  dmDBEXMaster.iIdFilial              := StrToInt(ParamStr(4));

  pgcOrdemSevico.Pages[1].TabVisible  := false;
  pgcOrdemSevico.ActivePageIndex  := 0;
  pgcItensOS.ActivePageIndex      := 0;

  for i := 0 to grdTabela.Columns.Count - 1 do
    grdTabela.Columns[i].Title.Color := COR_TITULO_GRADE;

  for i := 0 to grdServicos.Columns.Count - 1 do
    grdServicos.Columns[i].Title.Color := COR_TITULO_GRADE;

  for i := 0 to grdPecas.Columns.Count - 1 do
    grdPecas.Columns[i].Title.Color := COR_TITULO_GRADE;

  dtpDe_Entrada.Date  := StartOfTheMonth(Date);
  dtpA_Entrada.Date   := EndOfTheMonth(Date);
  dtpDe_Termino.Date  := dtpDe_Entrada.Date;
  dtpA_Termino.Date   := dtpA_Entrada.Date;
  dtpDe_Saida.Date    := dtpDe_Entrada.Date;
  dtpDe_Saida.Date    := dtpA_Entrada.Date;
  dtpDe_Abandono.Date := dtpDe_Entrada.Date;
  dtpA_Abandono.Date  := EndOfTheMonth(dtpDe_Abandono.Date);

  AbrirTabelas;

  imgTrocarCliente.Visible  := (dmMProvider.cdsUsuariosSUPER_USUARIO.Value = 1) or (dmDBEXMaster.sNomeUsuario = 'SYSDBA');
//  imgCS.Visible             := Length(Trim(dmMProvider.cdsConfiguracoesMODELO_COMUNICACAO_SERVICO.Value)) > 0;

end;

procedure TfrmOrdemServico.FormKeyPress(Sender: TObject; var Key: Char);
begin

  try

    if (UpperCase(Key) = 'S') and (lblMsg.Tag = ord(ExcluirItemServicoOS))
    then
    begin

      Key         := #0;
      lblMsg.Tag  := ord(nulo);
      actExcluirItemServicoOSExecute(self);

    end
    else if (UpperCase(Key) = 'S') and (lblMsg.Tag = ord(ExcluirItemPecaOS))
    then
    begin

      Key         := #0;
      lblMsg.Tag  := ord(nulo);
      actExcluirItemPecaOSExecute(self);

    end
    else if (UpperCase(Key) = 'N') AND (lblMsg.Tag <> ord(nulo)) then
    begin

      Key         := #0;
      lblMsg.Tag  := ord(nulo);
      LimparMSG_ERRO;

    end;
  except
    on E: exception do
      Tratar_Erro_Conexao(E);

  end;


end;

{ TDBGrid }

procedure TDBGrid.DrawCellBackground(const ARect: TRect; AColor: TColor;
  AState: TGridDrawState; ACol, ARow: Integer);
begin
  inherited;

  if ACol < 0 then
    inherited DrawCellBackground(ARect, AColor, AState, ACol, ARow)
  else
    inherited DrawCellBackground(ARect, Columns[ACol].Title.Color, AState,
      ACol, ARow)

end;

procedure TfrmOrdemServico.grdPecasDblClick(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    if not dmMProvider.cdsItens_OS_Pecas.IsEmpty then
    begin


      frmAlterarItemPeca      := TfrmAlterarItemPeca.Create(self);
      frmAlterarItemPeca.Tag  := 1;

      if frmAlterarItemPeca.ShowModal = mrOk then
      begin

        if Man_Tab_ItenOS_Pecas(0, dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value) then
        begin

          if dmMProvider.cdsItens_OS_Pecas.State in [dsEdit, dsInsert] then
          begin

            dmMProvider.cdsItens_OS_Pecas.Post;
            Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
            CalcularTotaisOS;

            if dmDBEXMaster.fdtMaster.Active then
              dmDBEXMaster.fdcMaster.Commit;

            dmDBEXMaster.fdcMaster.Close;

          end;

        end
        else
        begin

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Rollback;

        end;

      end
      else
      begin

        if dmMProvider.cdsItens_OS_Pecas.State in [dsEdit, dsInsert] then
          dmMProvider.cdsItens_OS_Pecas.Cancel;

      end;

      FreeAndNil(frmAlterarItemPeca);

    end;

  end;

end;

procedure TfrmOrdemServico.grdPecasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not dmMProvider.cdsItens_OS_Pecas.IsEmpty then
  begin

    if not odd(dmMProvider.cdsItens_OS_Pecas.RecNo) then
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := COR_ZEBRA_GRADE;

    end
    else
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := clWhite;

    end;

    grdTabela.Canvas.FillRect(Rect);
    grdTabela.DefaultDrawDataCell(Rect, Column.Field, State);

  end;

end;

procedure TfrmOrdemServico.grdPecasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case Key of

    VK_DELETE:
      begin

        LimparMSG_ERRO;

        if dmMProvider.cdsOrdemServico.Active then
        begin

          if dmMProvider.cdsOrdemServicoDATA_TERMINO.Value <= 0 then
          begin

            if not dmMProvider.cdsItens_OS_Pecas.IsEmpty then
            begin

              lblMsg.Tag := ord(ExcluirItemPecaOS);
              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_EXCLUSAO;

            end;

          end
          else
            lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_STATUS_NAO_PERMITE;

        end;

      end;

  end;

end;

procedure TfrmOrdemServico.grdServicosDblClick(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
  begin

    case dmMProvider.cdsItens_OS_servicoTIPO.Value of
      0:begin

          frmItemServicoPadrao      := TfrmItemServicoPadrao.Create(self);
          frmItemServicoPadrao.Tag  := 1;

          if frmItemServicoPadrao.ShowModal = mrOk then
          begin

            if Man_Tab_ItenOS_Servicos(0, dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value) then
            begin

              if dmMProvider.cdsItens_OS_servico.State in [dsEdit, dsInsert] then
              begin

                dmMProvider.cdsItens_OS_servico.Post;

                if dmDBEXMaster.fdtMaster.Active then
                  dmDBEXMaster.fdcMaster.Commit;
                dmDBEXMaster.fdcMaster.Close;

              end;

            end
            else
            begin

              if dmDBEXMaster.fdtMaster.Active then
                dmDBEXMaster.fdtMaster.Rollback;

            end;

          end
          else
          begin

            if dmMProvider.cdsItens_OS_servico.State in [dsEdit, dsInsert] then
              dmMProvider.cdsItens_OS_servico.Cancel;

          end;

          FreeAndNil(frmItemServicoPadrao);

        end;
      1:begin

          if dmMProvider.cdsOrdemServico.State in [dsEdit, dsInsert] then
          begin

            frmItemServicoAvulso      := TfrmItemServicoAvulso.Create(self);
            frmItemServicoAvulso.Tag  := 1;

            if frmItemServicoAvulso.ShowModal = mrOk then
            begin

              dtpHora_Entrada.Date := edtDataEntrada.Date;

              if Man_Tab_OrdemServico(0) then
              begin

                dmMProvider.cdsItens_OS_servicoTIPO.Value := 1;

                if Man_Tab_ItenOS_Servicos(0, dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value) then
                begin

                  dmMProvider.cdsItens_OS_servico.Post;

                  if dmDBEXMaster.fdtMaster.Active then
                    dmDBEXMaster.fdcMaster.Commit;

                  dmDBEXMaster.fdcMaster.Close;

                end
                else
                begin

                  if dmDBEXMaster.fdtMaster.Active then
                    dmDBEXMaster.fdtMaster.Rollback;

                end;

              end
              else
              begin

                if dmDBEXMaster.fdtMaster.Active then
                  dmDBEXMaster.fdtMaster.Rollback;

              end;

              FreeAndNil(frmItemServicoAvulso);

            end
            else
              begin

                if dmMProvider.cdsItens_OS_servico.State in [dsEdit, dsInsert] then
                  dmMProvider.cdsItens_OS_servico.Cancel;

              end;

          end;

        end;

    end;

  end;

end;

procedure TfrmOrdemServico.grdServicosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not dmMProvider.cdsItens_OS_servico.IsEmpty then
  begin

    if not odd(dmMProvider.cdsItens_OS_servico.RecNo) then
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := COR_ZEBRA_GRADE;

    end
    else
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := clWhite;

    end;

    grdTabela.Canvas.FillRect(Rect);
    grdTabela.DefaultDrawDataCell(Rect, Column.Field, State);

  end;

end;

procedure TfrmOrdemServico.grdServicosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case Key of

    VK_DELETE:
      begin

        LimparMSG_ERRO;

        if dmMProvider.cdsOrdemServico.Active then
        begin

          if dmMProvider.cdsOrdemServicoDATA_TERMINO.Value <= 0 then
          begin

            if not dmMProvider.cdsItens_OS_servico.IsEmpty then
            begin

              lblMsg.Tag := ord(ExcluirItemServicoOS);
              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_EXCLUSAO;

            end;

          end
          else
            lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_STATUS_NAO_PERMITE;

        end;

      end;

  end;

end;

procedure TfrmOrdemServico.grdTabelaDblClick(Sender: TObject);
begin

  if not dmMProvider.cdsOrdemServico.IsEmpty then
  begin

    pgcOrdemSevico.Pages[1].TabVisible  := True;
    pgcOrdemSevico.ActivePageIndex      := 1;
    lblQtdHistoricoOS.Caption           := Retornar_Qtd_Historico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
    Relacionar_Servico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
    Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
    Application.ProcessMessages;

  end;

end;

procedure TfrmOrdemServico.grdTabelaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
begin

  if not dmMProvider.cdsOrdemServico.IsEmpty then
  begin

    if not odd(dmMProvider.cdsOrdemServico.RecNo) then
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := COR_ZEBRA_GRADE;

    end
    else
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := clWhite;

    end;

    grdTabela.Canvas.FillRect(Rect);
    grdTabela.DefaultDrawDataCell(Rect, Column.Field, State);

  end;

end;

procedure TfrmOrdemServico.HabilitaDesabilitaControles(pOpcao: boolean);
begin

  grpTBSEquipamentos.Enabled    := pOpcao;
  grpInformacoesGerais.Enabled  := grpTBSEquipamentos.Enabled;
  grpInformacoesValores.Enabled := grpTBSEquipamentos.Enabled;
  grpTecnicoResponsavel.Enabled := grpTBSEquipamentos.Enabled;
  grpGarantia.Enabled           := grpTBSEquipamentos.Enabled;
  grpPrioridade.Enabled         := grpTBSEquipamentos.Enabled;
  grpTBSServico.Enabled         := grpTBSEquipamentos.Enabled;
  grpLaudo.Enabled              := grpTBSEquipamentos.Enabled;

  grpEquipamento.Enabled        := dmDBEXMaster.bNovoEquip;
  grpModelo.Enabled             := grpEquipamento.Enabled;
  grpNumero.Enabled             := grpEquipamento.Enabled;
  grpOutrosItens.Enabled        := grpEquipamento.Enabled;
  grpKm.Enabled                 := grpEquipamento.Enabled;

end;

procedure TfrmOrdemServico.imgCSClick(Sender: TObject);
begin

  frmComunicacaoServico := TfrmComunicacaoServico.Create(self);

  if frmComunicacaoServico.ShowModal = mrOk then
  begin

    if FileExists(ExtractFilePath(Application.ExeName) + 'Rav\' + dmMProvider.cdsConfiguracoesMODELO_COMUNICACAO_SERVICO.Value)  then
    begin

      edtOs_Inicial.Text  := IntToStr(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
      edtOs_Final.Text    := IntToStr(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);

      if AbrirTabelaOrdemServico(1,'-1') then
      begin

        Relacionar_Cliente_OS(dmMProvider.cdsOrdemServicoCLIENTE.Value);
        Relacionar_Servico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
        Relacionar_Pecas_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);

      end;

      edtOs_Inicial.Clear;
      edtOs_Final.Clear;

      dmRelatorios.rvsGenesisAC.SystemPreview.ZoomFactor  := 160;
      dmRelatorios.rvdGenesis.DataSet                     := dmMProvider.cdsOrdemServico;

      dmRelatorios.rvpGenesisAC.ProjectFile := ExtractFilePath(Application.ExeName) + 'Rav\' + dmMProvider.cdsConfiguracoesMODELO_COMUNICACAO_SERVICO.Value;
      dmRelatorios.rvpGenesisAC.SelectReport('rptCS',true);
      dmRelatorios.rvpGenesisAC.SetParam('pLOGO_MARCA',ExtractFilePath(Application.ExeName) + 'Logomarca\LogoMarca.bmp');
      dmRelatorios.rvpGenesisAC.SetParam('pModelo_PRODFOR',Copy(dmMProvider.cdsConfiguracoesMODELO_COMUNICACAO_SERVICO.Value,1,(pos('.',dmMProvider.cdsConfiguracoesMODELO_COMUNICACAO_SERVICO.Value)-1)));
      dmRelatorios.rvpGenesisAC.SetParam('pNome_Cliente',frmComunicacaoServico.edtCliente.Text);
      dmRelatorios.rvpGenesisAC.SetParam('pPrazo',frmComunicacaoServico.edtPrazo.Text);
      dmRelatorios.rvpGenesisAC.SetParam('pPrazoEstimado',frmComunicacaoServico.edtPrazoEstimado.Text);
      dmRelatorios.rvpGenesisAC.SetParam('pExecutante', frmComunicacaoServico.edtExecutante.Text);
      dmRelatorios.rvpGenesisAC.Execute;
      dmRelatorios.rvpGenesisAC.Close;

    end
    else
      Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ARQ_NEXISTE + #13
                  + ExtractFilePath(Application.ExeName) + 'Rav\' + dmMProvider.cdsConfiguracoesMODELO_COMUNICACAO_SERVICO.Value), 'Aten��o!',mb_IconWarning + mb_Ok);

  end;

  FreeAndNil(frmComunicacaoServico);

end;

procedure TfrmOrdemServico.imgHistoricoOSClick(Sender: TObject);
begin

  if dmMProvider.cdsOrdemServico.Active then
  begin

    frmHistorico      := TfrmHistorico.Create(self);
    Relacionar_Historico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);
    frmHistorico.ShowModal;
    FreeAndNil(frmHistorico);

  end;

end;

procedure TfrmOrdemServico.imgLimpaFiltroGarantidorClick(Sender: TObject);
begin

  cboFiltrarGarantidor.KeyValue := -1;

end;

procedure TfrmOrdemServico.imgLimparFiltroResponsavelClick(Sender: TObject);
begin

  cboFiltrarResponsavel.KeyValue := -1;

end;

procedure TfrmOrdemServico.imgLimparFiltroSituacaoClick(Sender: TObject);
begin

  cboFiltrarSituacao.KeyValue := -1;

end;

function TfrmOrdemServico.Man_Tab_Historico(pOpcao: smallint; pHistorico:string): boolean;
begin

  try

    dmDBEXMaster.fdcMaster.StartTransaction;

    dmMSProcedure.fdspHistorico_OS.Params[0].Value        := pOpcao;
    dmMSProcedure.fdspHistorico_OS.Params[1].Value        := -1;
    dmMSProcedure.fdspHistorico_OS.Params[2].Value        := dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value;
    dmMSProcedure.fdspHistorico_OS.Params[3].Value        := pHistorico;
    dmMSProcedure.fdspHistorico_OS.Params[4].Value        := dmDBEXMaster.sNomeUsuario;
    dmMSProcedure.fdspHistorico_OS.Params[5].Value        := Date;
    dmMSProcedure.fdspHistorico_OS.Params[6].Value        := Time;
    dmMSProcedure.fdspHistorico_OS.Params[7].Value        := 1;
    dmMSProcedure.fdspHistorico_OS.Params[8].Value        := '';

    dmMSProcedure.fdspHistorico_OS.ExecProc;

    Relacionar_Historico_OS(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value);

    dmDBEXMaster.fdcMaster.Commit;

    LimparMSG_ERRO;

    frmHistorico.tag      := 0;
    Result                := true;

  except
    on E: exception do
    begin

      Tratar_Erro_Conexao(E);

      dmDBEXMaster.fdcMaster.Rollback;

      Result := False;

    end;

  end;

end;

function TfrmOrdemServico.Man_Tab_ItenOS_Pecas(pOpcao: smallint; pItem_Os: Integer): boolean;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    dmMSProcedure.fdspItensOSPecas.Params[0].Value     := pOpcao;
    dmMSProcedure.fdspItensOSPecas.Params[1].Value     := dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value;
    dmMSProcedure.fdspItensOSPecas.Params[2].Value     := dmMProvider.cdsItens_OS_PecasORDEM_SERVICO.Value;
    dmMSProcedure.fdspItensOSPecas.Params[3].Value     := dmMProvider.cdsItens_OS_PecasCODIGO_PECA.Value;
    dmMSProcedure.fdspItensOSPecas.Params[4].Value     := dmMProvider.cdsItens_OS_PecasDESCRICAO.Value;
    dmMSProcedure.fdspItensOSPecas.Params[5].Value     := dmMProvider.cdsItens_OS_PecasVALOR_UNITARIO.Value;
    dmMSProcedure.fdspItensOSPecas.Params[6].Value     := dmMProvider.cdsItens_OS_PecasFUNCIONARIO.Value;
    dmMSProcedure.fdspItensOSPecas.Params[7].Value     := dmMProvider.cdsItens_OS_PecasQUANTIDADE.Value;
    dmMSProcedure.fdspItensOSPecas.Params[8].Value     := dmMProvider.cdsItens_OS_PecasDIA.AsDateTime;
    dmMSProcedure.fdspItensOSPecas.Params[9].Value     := dmMProvider.cdsItens_OS_PecasX_PED.Value;
    dmMSProcedure.fdspItensOSPecas.Params[10].Value    := dmMProvider.cdsItens_OS_PecasN_ITEM_PED.Value;
    dmMSProcedure.fdspItensOSPecas.Params[11].Value    := dmMProvider.cdsItens_OS_PecasNUMERO_SERIE.Value;
    dmMSProcedure.fdspItensOSPecas.Params[12].Value    := dmMProvider.cdsItens_OS_PecasCODIGO_BAIXA.Value;
    dmMSProcedure.fdspItensOSPecas.Params[13].Value    := dmMProvider.cdsItens_OS_PecasTIPO.Value;
    dmMSProcedure.fdspItensOSPecas.Params[14].Value    := dmMProvider.cdsItens_OS_PecasUSUARIO.Value;
    dmMSProcedure.fdspItensOSPecas.ExecProc;

    if dmMSProcedure.fdspItensOSPecas.Params[15].Value > 0 then
    begin

      if not (dmMProvider.cdsItens_OS_Pecas.State in [dsEdit, dsInsert]) then
        dmMProvider.cdsItens_OS_Pecas.Edit;

      dmMProvider.cdsItens_OS_PecasITENS_OS_PECAS.Value := dmMSProcedure.fdspItensOSPecas.Params[15].Value;
//      dmMProvider.cdsItens_OS_Pecas.Post;

    end;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

    Result := true;

  except
    on E: exception do
    begin

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

      Tratar_Erro_Conexao(E);
      Result := False;

    end;

  end;

end;

function TfrmOrdemServico.Man_Tab_ItenOS_Servicos(pOpcao: smallint; pItem_Os:Integer):boolean;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    dmMSProcedure.fdspItensOSServicos.Params[0].Value     := pOpcao;
    dmMSProcedure.fdspItensOSServicos.Params[1].Value     := dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value;
    dmMSProcedure.fdspItensOSServicos.Params[2].Value     := dmMProvider.cdsItens_OS_servicoORDEM_SERVICO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[3].Value     := dmMProvider.cdsItens_OS_servicoDESCRICAO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[4].Value     := dmMProvider.cdsItens_OS_servicoVALOR_CUSTO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[5].Value     := dmMProvider.cdsItens_OS_servicoDATA_INICIO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[6].Value     := dmMProvider.cdsItens_OS_servicoHORA_INICIO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[7].Value     := dmMProvider.cdsItens_OS_servicoDATA_FIM.Value;
    dmMSProcedure.fdspItensOSServicos.Params[8].Value     := dmMProvider.cdsItens_OS_servicoHORA_FIM.Value;
    dmMSProcedure.fdspItensOSServicos.Params[9].Value     := dmMProvider.cdsItens_OS_servicoFUNCIONARIO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[10].Value    := dmMProvider.cdsItens_OS_servicoTIPO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[11].Value    := dmMProvider.cdsItens_OS_servicoCODIGO_SERVICO.Value;
    dmMSProcedure.fdspItensOSServicos.Params[12].Value    := dmMProvider.cdsItens_OS_servicoQUANTIDADE.Value;
    dmMSProcedure.fdspItensOSServicos.Params[13].Value    := dmMProvider.cdsItens_OS_servicoCUSTO_TOTAL.Value;
    dmMSProcedure.fdspItensOSServicos.Params[14].Value    := dmMProvider.cdsItens_OS_servicoX_PED.Value;
    dmMSProcedure.fdspItensOSServicos.Params[15].Value    := dmMProvider.cdsItens_OS_servicoN_ITEM_PED.Value;
    dmMSProcedure.fdspItensOSServicos.Params[16].Value    := dmMProvider.cdsItens_OS_servicoTIPO_COBRANCA.Value;
    dmMSProcedure.fdspItensOSServicos.Params[17].Value    := dmMProvider.cdsItens_OS_servicoUSUARIO.Value;
    dmMSProcedure.fdspItensOSServicos.ExecProc;

    if dmMSProcedure.fdspItensOSServicos.Params[18].Value > 0 then
      dmMProvider.cdsItens_OS_servicoITENS_OS_SERVICOS.Value := dmMSProcedure.fdspItensOSServicos.Params[18].Value;

    CalcularTotaisOS;

    Result := true;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

  except
    on E: exception do
    begin

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

      Tratar_Erro_Conexao(E);
      Result := False;

    end;
  end;

end;

function TfrmOrdemServico.Man_Tab_OrdemServico(pOpcao:smallint):boolean;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    if dmDBEXMaster.bNovoEquip then
    begin

      dmMSProcedure.fdspEquipamentos.Params[0].Value    := 0;
      dmMSProcedure.fdspEquipamentos.Params[1].Value    := dmMProvider.cdsOrdemServicoCLIENTE.Value;
      dmMSProcedure.fdspEquipamentos.Params[2].Value    := -1;
      dmMSProcedure.fdspEquipamentos.Params[3].Value    := dmMProvider.cdsOrdemServicoAPARELHO.Value;
      dmMSProcedure.fdspEquipamentos.Params[4].Value    := dmMProvider.cdsOrdemServicoMODELO.Value;
      dmMSProcedure.fdspEquipamentos.Params[5].Value    := dmMProvider.cdsOrdemServicoMARCA.Value;
      dmMSProcedure.fdspEquipamentos.Params[6].Value    := dmMProvider.cdsOrdemServicoNUMERO_SERIE.Value;
      dmMSProcedure.fdspEquipamentos.Params[7].Value    := dmMProvider.cdsOrdemServicoETIQ_PATRIMONIO.Value;
      dmMSProcedure.fdspEquipamentos.Params[8].Value    := dmMProvider.cdsOrdemServicoOBSERVACAO_APARELHO.Value;
      dmMSProcedure.fdspEquipamentos.Params[9].Value    := null;
      dmMSProcedure.fdspEquipamentos.Params[10].Value   := null;
      dmMSProcedure.fdspEquipamentos.Params[11].Value   := null;
      dmMSProcedure.fdspEquipamentos.Params[12].Value   := null;
      dmMSProcedure.fdspEquipamentos.Params[13].Value   := Date;
      dmMSProcedure.fdspEquipamentos.Params[14].Value   := Time;
      dmMSProcedure.fdspEquipamentos.Params[15].Value   := dmDBEXMaster.iIdUsuario;
      dmMSProcedure.fdspEquipamentos.Params[16].Value   := pubNomeComputador;
      dmMSProcedure.fdspEquipamentos.Params[17].Value   := '';//RetornarIP;
      dmMSProcedure.fdspEquipamentos.ExecProc;

      if dmMSProcedure.fdspEquipamentos.Params[19].Value > 0 then
      begin

        dmMProvider.cdsOrdemServicoCODIGO_EQUIPAMENTO.Value := dmMSProcedure.fdspEquipamentos.Params[19].Value;
        Man_Tab_Historico(0,'ABRIU OS COM SITUA��O: ABRIR');

      end;

    end;

    dmMSProcedure.fdspOrdemServico.Params[0].Value        := pOpcao;
    dmMSProcedure.fdspOrdemServico.Params[1].Value        := dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value;
    dmMSProcedure.fdspOrdemServico.Params[2].Value        := dmMProvider.cdsOrdemServicoCODIGO_SITUACAO.Value;

    if dmMProvider.cdsOrdemServicoCLIENTE.Value > 0 then
      dmMSProcedure.fdspOrdemServico.Params[3].Value      := dmMProvider.cdsOrdemServicoCLIENTE.Value
    else //cliente avulso
      dmMSProcedure.fdspOrdemServico.Params[3].Value      := null;

    dmMSProcedure.fdspOrdemServico.Params[4].Value        := dmMProvider.cdsOrdemServicoDATA_ENTRADA.Value;
    dmMSProcedure.fdspOrdemServico.Params[5].Value        := dmMProvider.cdsOrdemServicoHORA_ENTRADA.Value;

    if dmMProvider.cdsOrdemServicoDATA_TERMINO.Value > 0 then
    begin

      dmMSProcedure.fdspOrdemServico.Params[6].Value      := dmMProvider.cdsOrdemServicoDATA_TERMINO.Value;
      dmMSProcedure.fdspOrdemServico.Params[7].Value      := dmMProvider.cdsOrdemServicoHORA_TERMINO.Value;

    end
    else
    begin

      dmMSProcedure.fdspOrdemServico.Params[6].Value      := null;
      dmMSProcedure.fdspOrdemServico.Params[7].Value      := null;

    end;


    if dmMProvider.cdsOrdemServicoDATA_SAIDA.Value > 0 then
    begin

      dmMSProcedure.fdspOrdemServico.Params[8].Value      := dmMProvider.cdsOrdemServicoDATA_SAIDA.Value;
      dmMSProcedure.fdspOrdemServico.Params[9].Value      := dmMProvider.cdsOrdemServicoHORA_SAIDA.Value;

    end
    else
    begin

      dmMSProcedure.fdspOrdemServico.Params[8].Value      := null;
      dmMSProcedure.fdspOrdemServico.Params[9].Value      := null;

    end;

    dmMSProcedure.fdspOrdemServico.Params[10].Value       := null;
    dmMSProcedure.fdspOrdemServico.Params[11].Value       := null;
    dmMSProcedure.fdspOrdemServico.Params[12].Value       := dmMProvider.cdsOrdemServicoVALOR_MAO_DE_OBRA.Value;
    dmMSProcedure.fdspOrdemServico.Params[13].Value       := dmMProvider.cdsOrdemServicoVALOR_PECAS.Value;
    dmMSProcedure.fdspOrdemServico.Params[14].Value       := dmMProvider.cdsOrdemServicoVALOR_DESLOCAMENTO.Value;
    dmMSProcedure.fdspOrdemServico.Params[15].Value       := dmMProvider.cdsOrdemServicoVALOR_TERCEIRO.Value;
    dmMSProcedure.fdspOrdemServico.Params[16].Value       := dmMProvider.cdsOrdemServicoVALOR_OUTROS.Value;

    if dmMProvider.cdsOrdemServicoCODIGO_EQUIPAMENTO.Value > 0 then
      dmMSProcedure.fdspOrdemServico.Params[17].Value     := dmMProvider.cdsOrdemServicoCODIGO_EQUIPAMENTO.Value
    else//equipamento avulso
      dmMSProcedure.fdspOrdemServico.Params[17].Value     := null;

    dmMSProcedure.fdspOrdemServico.Params[18].Value       := dmMProvider.cdsOrdemServicoAPARELHO.Value;
    dmMSProcedure.fdspOrdemServico.Params[19].Value       := dmMProvider.cdsOrdemServicoMARCA.Value;
    dmMSProcedure.fdspOrdemServico.Params[20].Value       := dmMProvider.cdsOrdemServicoMODELO.Value;
    dmMSProcedure.fdspOrdemServico.Params[21].Value       := dmMProvider.cdsOrdemServicoNUMERO_SERIE.Value;
    dmMSProcedure.fdspOrdemServico.Params[22].Value       := dmMProvider.cdsOrdemServicoETIQ_PATRIMONIO.Value;
    dmMSProcedure.fdspOrdemServico.Params[23].Value       := dmMProvider.cdsOrdemServicoACESSORIO.Value;
    dmMSProcedure.fdspOrdemServico.Params[24].Value       := dmMProvider.cdsOrdemServicoDEFEITO.Value;
    dmMSProcedure.fdspOrdemServico.Params[25].Value       := dmMProvider.cdsOrdemServicoOBS_SERVICO.Value;
    dmMSProcedure.fdspOrdemServico.Params[26].Value       := dmMProvider.cdsOrdemServicoLAUDO.Value;
    dmMSProcedure.fdspOrdemServico.Params[27].Value       := dmMProvider.cdsOrdemServicoOBSERVACAO_APARELHO.Value;
    dmMSProcedure.fdspOrdemServico.Params[28].Value       := dmMProvider.cdsOrdemServicoKILOMETRO.Value;
    dmMSProcedure.fdspOrdemServico.Params[29].Value       := dmMProvider.cdsOrdemServicoNUMERO_NF_PEDIDO.Value;
    dmMSProcedure.fdspOrdemServico.Params[30].Value       := dmMProvider.cdsOrdemServicoEM_USO.Value;
    dmMSProcedure.fdspOrdemServico.Params[31].Value       := dmMProvider.cdsOrdemServicoNUMERO_NF.Value;
    dmMSProcedure.fdspOrdemServico.Params[32].Value       := dmMProvider.cdsOrdemServicoOS_REABERTA.Value;
    dmMSProcedure.fdspOrdemServico.Params[33].Value       := dmMProvider.cdsOrdemServicoOS_OUTROS.Value;
    dmMSProcedure.fdspOrdemServico.Params[34].Value       := dmMProvider.cdsOrdemServicoOS_OUTROS_EMIT.Value;
    dmMSProcedure.fdspOrdemServico.Params[35].Value       := dmMProvider.cdsOrdemServicoVALOR_SINAL.Value;
    dmMSProcedure.fdspOrdemServico.Params[36].Value       := dmMProvider.cdsOrdemServicoPRIORIDADE.Value;
    dmMSProcedure.fdspOrdemServico.Params[37].Value       := dmMProvider.cdsOrdemServicoNF_REMESSA.Value;
    dmMSProcedure.fdspOrdemServico.Params[38].Value       := dmMProvider.cdsOrdemServicoVALOR_NF.Value;
    dmMSProcedure.fdspOrdemServico.Params[39].Value       := dmMProvider.cdsOrdemServicoNF_EMITENTE.Value;

    if dmMProvider.cdsOrdemServicoGARANTIDOR.Value > 0 then
      dmMSProcedure.fdspOrdemServico.Params[40].Value     := dmMProvider.cdsOrdemServicoGARANTIDOR.Value
    else
      dmMSProcedure.fdspOrdemServico.Params[40].Value     := null;

    dmMSProcedure.fdspOrdemServico.Params[41].Value       := dmMProvider.cdsOrdemServicoNUMER_SERIE_GARANTIDOR.Value;
    dmMSProcedure.fdspOrdemServico.Params[42].Value       := dmMProvider.cdsOrdemServicoVALOR_FRETE.Value;
    dmMSProcedure.fdspOrdemServico.Params[43].Value       := dmMProvider.cdsOrdemServicoVALOR_SEGURO.Value;
    dmMSProcedure.fdspOrdemServico.Params[44].Value       := dmMProvider.cdsOrdemServicoUSUARIO_MICRO.Value;
    dmMSProcedure.fdspOrdemServico.Params[45].Value       := dmMProvider.cdsOrdemServicoORCA_FORMAS.Value;
    dmMSProcedure.fdspOrdemServico.Params[46].Value       := null;
    dmMSProcedure.fdspOrdemServico.Params[47].Value       := null;
    dmMSProcedure.fdspOrdemServico.Params[48].Value       := dmMProvider.cdsOrdemServicoFUNCIONARIO.Value;
    dmMSProcedure.fdspOrdemServico.Params[49].Value       := dmMProvider.cdsOrdemServicoOS_FABRICANTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[50].Value       := dmMProvider.cdsOrdemServicoNFC_NUMERO.Value;
    dmMSProcedure.fdspOrdemServico.Params[51].Value       := dmMProvider.cdsOrdemServicoDATA_PREVISTO.Value;
    dmMSProcedure.fdspOrdemServico.Params[52].Value       := dmMProvider.cdsOrdemServicoHORA_PREVISTO.Value;
    dmMSProcedure.fdspOrdemServico.Params[53].Value       := dmMProvider.cdsOrdemServicoVALOR_TOTAL_OS.Value;
    dmMSProcedure.fdspOrdemServico.Params[54].Value       := dmMProvider.cdsOrdemServicoTOTAL_HORAS.Value;
    dmMSProcedure.fdspOrdemServico.Params[55].Value       := dmMProvider.cdsOrdemServicoCODIGO_PRODUCAO.Value;
    dmMSProcedure.fdspOrdemServico.Params[56].Value       := dmMProvider.cdsOrdemServicoNOME_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[57].Value       := dmMProvider.cdsOrdemServicoCNPJ_CPF.Value;
    dmMSProcedure.fdspOrdemServico.Params[58].Value       := dmMProvider.cdsOrdemServicoIE_RG.Value;
    dmMSProcedure.fdspOrdemServico.Params[59].Value       := dmMProvider.cdsOrdemServicoENDERECO_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[60].Value       := dmMProvider.cdsOrdemServicoNUMERO_END_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[61].Value       := dmMProvider.cdsOrdemServicoCEP_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[62].Value       := dmMProvider.cdsOrdemServicoBAIRRO_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[63].Value       := dmMProvider.cdsOrdemServicoCIDADE_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[64].Value       := dmMProvider.cdsOrdemServicoDDD_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[65].Value       := dmMProvider.cdsOrdemServicoTELEFONE_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[66].Value       := dmMProvider.cdsOrdemServicoEMAIL_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[67].Value       := dmMProvider.cdsOrdemServicoUF_CLIENTE.Value;
    dmMSProcedure.fdspOrdemServico.Params[68].Value       := dmMProvider.cdsOrdemServicoCONTATO_CLIENTE.Value;

    dmMSProcedure.fdspOrdemServico.ExecProc;

    if dmMSProcedure.fdspOrdemServico.Params[69].Value  > 0 then
    begin

      if InserindoEditando(dmMProvider.cdsOrdemServico) then
        dmMProvider.cdsOrdemServico.Edit;

      dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value   := dmMSProcedure.fdspOrdemServico.Params[69].Value;

    end;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

    Result := true;
  except
    on E: exception do
    begin

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

      Tratar_Erro_Conexao(E);
      Result := False;

    end;
  end;

end;

procedure TfrmOrdemServico.LimparMSG_ERRO;
begin

  lblMsg.Caption := '';
  Application.ProcessMessages;

end;

function TfrmOrdemServico.Montar_SQL_Pesquisa_OrdemServico(pOpcao: smallint):string;
var
  sWhere:string;
begin

  if pOpcao = 0 then
    Result := 'WHERE ORDEM_DE_SERVICO = -1'
  else
  begin

    if cboPesquisaPrioridade.ItemIndex < 4 then
      sWhere := 'WHERE PRIORIDADE = ' + IntToStr(cboPesquisaPrioridade.ItemIndex)
    else
      sWhere := 'WHERE PRIORIDADE < 100';

    if (edtOs_Inicial.Value > 0) and (edtOs_Final.Value > 0) then
      sWhere := sWhere + ' AND ORDEM_DE_SERVICO >= ' + IntToStr(edtOs_Inicial.Value)
                 + ' AND ORDEM_DE_SERVICO <= ' + IntToStr(edtOs_Final.Value);

    if btnPesquisarCliente.Tag = 1 then
      sWhere := sWhere + ' AND CLIENTE = ' + IntToStr(dmMProvider.cdsPesqClientesCLIENTE.Value)
    else if btnPesquisarCliente.Tag = 2 then
      sWhere := sWhere + ' AND NOME_CLIENTE = ' + QuotedStr(btnPesquisarCliente.Caption);

    if btnPesquisarEquipamento.Tag = 1 then
      sWhere := sWhere + ' AND CODIGO_EQUIPAMENTO = ' + IntToStr(dmMProvider.cdsEquipamentosCODIGO_EQUIPAMENTO.Value);

    if cboFiltrarResponsavel.KeyValue > 0 then
      sWhere := sWhere + ' AND FUNCIONARIO = ' + IntToStr(cboFiltrarResponsavel.KeyValue);

    if cboFiltrarSituacao.KeyValue > 0 then
      sWhere := sWhere + ' AND CODIGO_SITUACAO = ' + IntToStr(cboFiltrarSituacao.KeyValue);

    if cboFiltrarGarantidor.KeyValue > 0 then
      sWhere := sWhere + ' AND GARANTIDOR = ' + IntToStr(cboFiltrarGarantidor.KeyValue);

    if edtOSTerceiros.Value > 0 then
      sWhere := sWhere + ' AND GARANTIDOR = ' + IntToStr(cboFiltrarGarantidor.KeyValue);

    if cboPesquisaEntrada.ItemIndex = 1 then
      sWhere := sWhere + ' AND DATA_ENTRADA BETWEEN ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpDe_Entrada.Date))
                       + ' AND ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpA_Entrada.Date));

    if cboPesquisaTermino.ItemIndex = 1 then
      sWhere := sWhere + ' AND DATA_TERMINO BETWEEN ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpDe_Termino.Date))
                       + ' AND ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpA_Termino.Date));

    if cboPesquisaSaida.ItemIndex = 1 then
      sWhere := sWhere + ' AND DATA_SAIDA BETWEEN ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpDe_Saida.Date))
                       + ' AND ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpA_Saida.Date));

    if cboPesquisaGarantia.ItemIndex = 1 then
      sWhere := sWhere + ' AND DATA_GARANTIA BETWEEN ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpDe_Garantia.Date))
                       + ' AND ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpA_Garantia.Date));

    if chkOsAbandonadas.Checked then
      sWhere := sWhere + ' AND ALERTA_ABANDONO BETWEEN ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpDe_Abandono.Date))
                       + ' AND ' + QuotedStr(FormatDateTime('mm/dd/yy', dtpA_Abandono.Date))
                       + ' AND DATA_TERMINO IS NULL';
    Result := sWhere;

  end;

end;

function TfrmOrdemServico.RetornarNomeCidade(pCidade: integer): string;
begin

  dmMProvider.cdsCidades.Close;
  dmMProvider.cdsCidades.ProviderName := 'dspCidades';

  dmDBEXMaster.fdqCidades.SQL.Clear;
  dmDBEXMaster.fdqCidades.SQL.Add('select * from cidades');
  dmDBEXMaster.fdqCidades.SQL.Add('where cidade = ' + IntToStr(pCidade));

  dmMProvider.cdsCidades.Open;
  dmMProvider.cdsCidades.ProviderName := '';

  Result := dmMProvider.cdsCidadesNOME.Value;

end;

function TfrmOrdemServico.Retornar_Qtd_Historico_OS(pOrdemServico:integer): string;
begin

  dmDBEXMaster.fdqMasterPesquisa.Close;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('select count(*) as qtd_reg from historico_ordem_servico');
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('where ordem_servico = ' + IntToStr(pOrdemServico));
  dmDBEXMaster.fdqMasterPesquisa.Open;

  if dmDBEXMaster.fdqMasterPesquisa.FieldByName('QTD_REG').Value > 0 then
    Result := IntToStr(dmDBEXMaster.fdqMasterPesquisa.FieldByName('QTD_REG').Value)
  else
    Result := '';

end;

function TfrmOrdemServico.PesquisarItensOSPecas(pProduto:integer):boolean;
var
  sWhere:string;
begin

  LimparMSG_ERRO;

  try

    dmDBEXMaster.fdqMasterPesquisa.Close;
    dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
    dmDBEXMaster.fdqMasterPesquisa.SQL.Add('SELECT * FROM ITENS_OS_PECAS');
    dmDBEXMaster.fdqMasterPesquisa.SQL.Add('WHERE CODIGO_PECA = ' + IntToStr(pProduto));
    dmDBEXMaster.fdqMasterPesquisa.SQL.Add('AND ORDEM_SERVICO = ' + IntToStr(dmMProvider.cdsOrdemServicoORDEM_DE_SERVICO.Value));
    dmDBEXMaster.fdqMasterPesquisa.Open;

    Result := dmDBEXMaster.fdqMasterPesquisa.IsEmpty;

    dmDBEXMaster.fdqMasterPesquisa.Close;

   except
    on E: exception do
      lblMsg.Caption := dmDBEXMaster.sNomeUsuario+ ', ' + Tratar_Erro_Conexao(E);

  end;

end;

procedure TfrmOrdemServico.RelacionarItemProducao(pProducao: integer);
begin

  dmMProvider.cdsItemProducao.Close;
  dmMProvider.cdsItemProducao.ProviderName := 'dspItemProducao';

  dmDBEXMaster.fdqItemProducao.SQL.Clear;
  dmDBEXMaster.fdqItemProducao.SQL.Add('select *  from itemproducao');
  dmDBEXMaster.fdqItemProducao.SQL.Add('where producao = ' + IntToStr(pProducao));
  dmDBEXMaster.fdqItemProducao.SQL.Add('order by itemproducao');

  dmMProvider.cdsItemProducao.Open;
  dmMProvider.cdsItemProducao.ProviderName := '';

end;

procedure TfrmOrdemServico.Relacionar_Cliente_OS(pCliente: integer);
begin

  dmMProvider.cdsClientes.Close;
  dmMProvider.cdsClientes.ProviderName := 'dspClientes';

  dmDBEXMaster.fdqClientes.SQL.Clear;
  dmDBEXMaster.fdqClientes.SQL.Add('SELECT CLIENTES.*, CIDADES.NOME NOMECIDADE, ESTADOS.NOME NOMEESTADO,');
  dmDBEXMaster.fdqClientes.SQL.Add('CIDADES.CODIGO_MUNICIPIO, ESTADOS.CODIGO_ESTADO_IBGE');
  dmDBEXMaster.fdqClientes.SQL.Add('FROM CLIENTES');
  dmDBEXMaster.fdqClientes.SQL.Add('JOIN CIDADES CIDADES');
  dmDBEXMaster.fdqClientes.SQL.Add('ON(CIDADES.CIDADE = CLIENTES.CIDADEENTREGA)');
  dmDBEXMaster.fdqClientes.SQL.Add('JOIN ESTADOS ESTADOS');
  dmDBEXMaster.fdqClientes.SQL.Add('ON(ESTADOS.SIGLA = CLIENTES.ESTADOENTREGA)');
  dmDBEXMaster.fdqClientes.SQL.Add('where clientes.cliente = ' + IntToStr(pCliente));

  dmMProvider.cdsClientes.Open;
  dmMProvider.cdsClientes.ProviderName := '';

end;

procedure TfrmOrdemServico.Relacionar_Historico_OS(pOrdem_Servico: integer);
begin

  dmMProvider.cdsHistorico_OS.Close;
  dmMProvider.cdsHistorico_OS.ProviderName := 'dspHistorico_OS';

  dmDBEXMaster.fdqHistorico_OS.SQL.Clear;
  dmDBEXMaster.fdqHistorico_OS.SQL.Add('select * from HISTORICO_ORDEM_SERVICO');
  dmDBEXMaster.fdqHistorico_OS.SQL.Add('where ordem_servico = ' + IntToStr(pOrdem_servico));
  dmDBEXMaster.fdqHistorico_OS.SQL.Add('order by historico_ordem');

  dmMProvider.cdsHistorico_OS.Open;
  dmMProvider.cdsHistorico_OS.ProviderName := '';

end;

procedure TfrmOrdemServico.Relacionar_Pecas_OS(pOrdem_servico: integer);
begin

  dmMProvider.cdsItens_OS_Pecas.Close;
  dmMProvider.cdsItens_OS_Pecas.ProviderName := 'dspItem_OS_Pecas';

  dmDBEXMaster.fdqItens_OS_Pecas.SQL.Clear;
  dmDBEXMaster.fdqItens_OS_Pecas.SQL.Add('select * from itens_os_pecas');
  dmDBEXMaster.fdqItens_OS_Pecas.SQL.Add('where ordem_servico = ' + IntToStr(pOrdem_servico));
  dmDBEXMaster.fdqItens_OS_Pecas.SQL.Add('order by itens_os_pecas');

  dmMProvider.cdsItens_OS_Pecas.Open;
  dmMProvider.cdsItens_OS_Pecas.ProviderName := '';

end;

procedure TfrmOrdemServico.Relacionar_Servico_OS(pOrdem_servico: integer);
begin

  dmMProvider.cdsItens_OS_servico.Close;
  dmMProvider.cdsItens_OS_servico.ProviderName := 'dspItem_OS_Servico';

  dmDBEXMaster.fdqItens_OS_Servicos.SQL.Clear;
  dmDBEXMaster.fdqItens_OS_Servicos.SQL.Add('select * from itens_os_servicos');
  dmDBEXMaster.fdqItens_OS_Servicos.SQL.Add('where ordem_servico = ' + IntToStr(pOrdem_servico));
  dmDBEXMaster.fdqItens_OS_Servicos.SQL.Add('order by itens_os_servicos');

  dmMProvider.cdsItens_OS_servico.Open;
  dmMProvider.cdsItens_OS_servico.ProviderName := '';

end;

procedure TfrmOrdemServico.Resetar_Pesquisa;
begin

  cboPesquisaEntrada.ItemIndex            := 0;
  cboPesquisaEntradaCloseUp(self);
  cboPesquisaTermino.ItemIndex            := 0;
  cboPesquisaSaida.ItemIndex              := 0;
  cboPesquisaGarantia.ItemIndex           := 0;
  cboPesquisaPrioridade.ItemIndex         := 1;
  cboFiltrarResponsavel.KeyValue          := -1;
  cboFiltrarGarantidor.KeyValue           := -1;
  cboFiltrarSituacao.KeyValue             := -1;
  chkOsAbandonadas.Checked                := false;
  edtOs_Inicial.Value                     := 0;
  edtOs_Final.Value                       := 0;
  edtOSTerceiros.Value                    := 0;

end;

procedure TfrmOrdemServico.WindowClose1Execute(Sender: TObject);
begin

  Close;

end;

end.



