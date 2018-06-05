unit modDanfe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, ACBrMail,
  ACBrBase, ACBrDFe, ACBrNFe, pcnConversao, pcnConversaoNFE, AcbrUtil, System.Math, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, ACBrNFeNotasFiscais, ACBrDFeSSL, blcksock;

type
  TDBGrid = class(Vcl.DBGrids.TDBGrid)
  protected
    procedure DrawCellBackground(const ARect: TRect; AColor: TColor;
      AState: TGridDrawState; ACol, ARow: Integer); override;
  end;
  TfrmModDanfe = class(TForm)
    ACBrMail1: TACBrMail;
    imgSair: TImage;
    grpMensagem: TGroupBox;
    lblMsg: TLabel;
    imgErro: TImage;
    OpenDialog1: TOpenDialog;
    ActionList1: TActionList;
    actSelecionarNotas: TAction;
    actStatusServico: TAction;
    actGerarPDF: TAction;
    actImprimirDANFE: TAction;
    actConsultarNFE: TAction;
    actEnviarNFEEmail: TAction;
    actConsultarLote: TAction;
    actConsultarCadastroContribuinte: TAction;
    actInutilizacaoNumero: TAction;
    actCCe: TAction;
    actAdcionarProtXml: TAction;
    actCancelarNFE: TAction;
    grpEnvioNFE: TGroupBox;
    imgStatusWS: TImage;
    imgSelecionaNFEnvio: TImage;
    imgTRansmitirNF: TImage;
    imgImrimir: TImage;
    imgGerarPdfNfe: TImage;
    imgNfeEmail: TImage;
    imgConsultarNFE: TImage;
    imgConsultarCadastro: TImage;
    imgConsultaReciboLote: TImage;
    imgCCe: TImage;
    imgCancelarNFe: TImage;
    imgInutilizarNumeracao: TImage;
    imgPreVisualizarNfe: TImage;
    imgAdicionarProtocoloNFE: TImage;
    grpDataVencimentoCertificado: TGroupBox;
    lblDataVencimentoCertificado: TLabel;
    grpStatusWS: TGroupBox;
    memStatusWSNfe: TMemo;
    grdSelecionaNotas: TDBGrid;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    imgImprimirEventos: TImage;
    imgLog: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure grdSelecionaNotasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actSelecionarNotasExecute(Sender: TObject);
    procedure actStatusServicoExecute(Sender: TObject);
    procedure imgTRansmitirNFClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure imgPreVisualizarNfeClick(Sender: TObject);
    procedure actGerarPDFExecute(Sender: TObject);
    procedure actImprimirDANFEExecute(Sender: TObject);
    procedure actConsultarNFEExecute(Sender: TObject);
    procedure actEnviarNFEEmailExecute(Sender: TObject);
    procedure actConsultarLoteExecute(Sender: TObject);
    procedure actConsultarCadastroContribuinteExecute(Sender: TObject);
    procedure actInutilizacaoNumeroExecute(Sender: TObject);
    procedure actCCeExecute(Sender: TObject);
    procedure actAdcionarProtXmlExecute(Sender: TObject);
    procedure actCancelarNFEExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgImprimirEventosClick(Sender: TObject);
    procedure imgLogClick(Sender: TObject);
    procedure imgStatusWSClick(Sender: TObject);
  private
    { Private declarations }
    Para, sPasta_Imagem_Log: String;
    CC: TStringList;
    cEmailContabilidade: Tstrings;
    bOk: boolean;
    procedure CarregarConfiguracoesACBR;
    function ChecarValidadeCertificado:boolean;
    procedure ChecarStatusWS;
    procedure GerarEnviarNfe(pOpcao:smallint);
    procedure AbrirTabela_Item_Nf(pNota: Integer; pModelo: string);
    procedure AbrirTabela_Cfop(pNota: Integer; pModelo: string);
    procedure AbrirTabela_Cliente(pCnpj: string);
    procedure AbrirTabelaParcelasNFS(pNota: Integer; pModelo: string);
    procedure AbrirTabelaDocRefNFS(pNota: Integer; pModelo: string);
    procedure AbrirTabelaTransportadora;
    procedure AbrirTabela_Barras(pProduto: Integer);
    function GravarEstornarRegistro50(pOpcao:smallint):boolean;
    function GravarEstornarRegistro54(pOpcao:smallint):boolean;
    function GravarEstornarLivroSaida(pOpcao: smallint):boolean;
    function ValidarNfe:boolean;
    procedure LoadXML(RetWS: String);
public
    { Public declarations }
  end;

var
  frmModDanfe: TfrmModDanfe;

implementation

{$R *.dfm}

uses dataDBEXMaster, dataMProvider, dataMRelatorios, dataMSource, dataMSProcedure, datamZeus, uConstantes_Padrao, uFuncoes, uConstantes_RetornoNFE, modInutilizaNumeracao, modConsultaCadastroContribuinte, modCCe, modAvisoCCe, modCancelarNota,
  modImprimirEventos, uFuncoes_BD;

procedure TfrmModDanfe.AbrirTabelaDocRefNFS(pNota: Integer; pModelo: string);
begin

  //NF, NFe e CT-e
  dmMProvider.cdsDocumentoRef_NFS.Close;
  dmMProvider.cdsDocumentoRef_NFS.ProviderName := 'dspDocumentoRef_NFS';

  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Clear;
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('select * from DOCUMENTO_REFER_NFSAIDA');
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('where nf_saida = ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and modelo_nf_saida = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and serie_nf_saida = ' + QuotedStr(Trim(dmMProvider.cdsNFSaidaSERIE.Value)));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and cnpj_nf_saida = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and tipo_documento < 3');

  dmMProvider.cdsDocumentoRef_NFS.Open;
  dmMProvider.cdsDocumentoRef_NFS.ProviderName := '';

  dmMProvider.cdsCupomFiscalRefNFS.Close;
  dmMProvider.cdsCupomFiscalRefNFS.ProviderName := 'dspCupomFiscalRefNFS';

  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Clear;
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('select * from DOCUMENTO_REFER_NFSAIDA');
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('where nf_saida = '      + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and modelo_nf_saida = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and serie_nf_saida = '  + QuotedStr(Trim(dmMProvider.cdsNFSaidaSERIE.Value)));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and cnpj_nf_saida = '   + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value));
  dmDBEXMaster.fdqDocumentoRef_NFS.SQL.Add('and tipo_documento = 4');

  dmMProvider.cdsCupomFiscalRefNFS.Open;
  dmMProvider.cdsCupomFiscalRefNFS.ProviderName := '';

end;

procedure TfrmModDanfe.AbrirTabelaParcelasNFS(pNota: Integer; pModelo: string);
begin

  try

    dmMProvider.cdsParcelasNFS.Close;
    dmMProvider.cdsParcelasNFS.ProviderName := 'dspParcelasNFS';

    dmDBEXMaster.fdqParcelasNFS.SQL.Clear;
    dmDBEXMaster.fdqParcelasNFS.SQL.Add('SELECT * FROM PARCELASNFSAIDA');
    dmDBEXMaster.fdqParcelasNFS.SQL.Add('WHERE NFSAIDA = ' + IntToStr(pNota));
    dmDBEXMaster.fdqParcelasNFS.SQL.Add('AND MODELO = ' + QuotedStr(pModelo));
    dmDBEXMaster.fdqParcelasNFS.SQL.Add('ORDER BY PARCELASNFSAIDA');

    dmMProvider.cdsParcelasNFS.Open;
    dmMProvider.cdsParcelasNFS.ProviderName := '';

  except
    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.AbrirTabelaTransportadora;
begin

  try

    dmMProvider.cdsTransportadoraNFS.Close;
    dmMProvider.cdsTransportadoraNFS.ProviderName := 'dspTransportadoraNFS';

    dmDBEXMaster.fdqTransportadoraNFS.SQL.Clear;
    dmDBEXMaster.fdqTransportadoraNFS.SQL.Add('select * from TRANSPORTADOR_NFSAIDA');
    dmDBEXMaster.fdqTransportadoraNFS.SQL.Add('where nf_saida = ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value));
    dmDBEXMaster.fdqTransportadoraNFS.SQL.Add('and modelo = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value));
    dmDBEXMaster.fdqTransportadoraNFS.SQL.Add('and filial = ' + IntToStr(dmDBEXMaster.iIdFilial));

    dmMProvider.cdsTransportadoraNFS.Open;
    dmMProvider.cdsTransportadoraNFS.ProviderName := '';

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.AbrirTabela_Barras(pProduto: Integer);
begin

  try

    dmMProvider.cdsBarras.Close;
    dmMProvider.cdsBarras.ProviderName := 'dspBarras';

    dmDBEXMaster.fdqBarras.SQL.Clear;
    dmDBEXMaster.fdqBarras.SQL.Add('SELECT * FROM BARRAS');
    dmDBEXMaster.fdqBarras.SQL.Add('WHERE PRODUTO = ' + InttoStr(pProduto));

    dmMProvider.cdsBarras.Open;
    dmMProvider.cdsBarras.ProviderName := '';

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.AbrirTabela_Cfop(pNota: Integer; pModelo: string);
begin

  try

    dmMProvider.cdsCFOP_NFSaida.Close;
    dmMProvider.cdsCFOP_NFSaida.ProviderName := 'dspCFOP_NFSaida';

    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Clear;
    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Add('SELECT CFOP_NFSAIDA.*, CFOP.DESCRICAO FROM CFOP_NFSAIDA');
    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Add('JOIN CFOP CFOP');
    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Add('ON(CFOP_NFSAIDA.CFOP = CFOP.CFOP)');
    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Add('WHERE CFOP_NFSAIDA.NFSAIDA = ' + IntToStr(pNota));
    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Add('AND MODELO = ' + QuotedStr(pModelo));
    dmDBEXMaster.fdqCFOP_NFSaida.SQL.Add('ORDER by CFOP_NFSAIDA.CFOP_NFSAIDA');

    dmMProvider.cdsCFOP_NFSaida.Open;
    dmMProvider.cdsCFOP_NFSaida.ProviderName := 'dspCFOP_NFSaida';

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.AbrirTabela_Cliente(pCnpj: string);
begin

  try

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
    dmDBEXMaster.fdqClientes.SQL.Add('WHERE CLIENTES.CNPJ = ' + QuotedStr(pCnpj));

    dmMProvider.cdsClientes.Open;
    dmMProvider.cdsClientes.ProviderName := '';

  except
    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.AbrirTabela_Item_Nf(pNota: Integer; pModelo: string);
begin

  try

    dmMProvider.cdsItemNFSaida.Close;
    dmMProvider.cdsItemNFSaida.ProviderName := 'dspItemNFSaida';

    dmDBEXMaster.fdqItemNFSaida.SQL.Clear;
    dmDBEXMaster.fdqItemNFSaida.SQL.Add('SELECT ITEMNFSAIDA.*, PRODUTO.DESCRICAO, PRODUTO.UNIDADE,');
    dmDBEXMaster.fdqItemNFSaida.SQL.Add('PRODUTO.COMPLEMENTO FROM ITEMNFSAIDA');
    dmDBEXMaster.fdqItemNFSaida.SQL.Add('JOIN PRODUTO PRODUTO');
    dmDBEXMaster.fdqItemNFSaida.SQL.Add('ON(PRODUTO.PRODUTO = ITEMNFSAIDA.PRODUTO)');
    dmDBEXMaster.fdqItemNFSaida.SQL.Add('WHERE ITEMNFSAIDA.NFSAIDA = ' + InttoStr(pNota));
    dmDBEXMaster.fdqItemNFSaida.SQL.Add(' AND ITEMNFSAIDA.MODELO = ' + QuotedStr(pModelo));
    dmDBEXMaster.fdqItemNFSaida.SQL.Add('ORDER BY  ITEMNFSAIDA.ITEMNFSAIDA');

    dmMProvider.cdsItemNFSaida.Open;
    dmMProvider.cdsItemNFSaida.ProviderName := '';

  except
    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actAdcionarProtXmlExecute(Sender: TObject);
var
  sNomeArq, sChave : String;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    if not dmMProvider.cdsNFSaida.IsEmpty then
    begin

      if not dmDBEXMaster.fdcMaster.InTransaction then
        dmDBEXMaster.fdtMaster.StartTransaction;

      LimparMSG_ERRO(lblMsg, imgErro);

      OpenDialog1.Title       := 'Selecione a NFE';
      OpenDialog1.DefaultExt  := '*-nfe.XML';
      OpenDialog1.Filter      := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
      OpenDialog1.InitialDir  := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

      if OpenDialog1.Execute then
      begin

        ACBrNFe1.NotasFiscais.Clear;
        ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

        CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
        Man_Tab_LOG_SYS(Application.Title,'O usu�rio usou op��o para adicionar protocolo a nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

        ACBrNFe1.Consultar;

        RetornarRejeicao(dmDBEXMaster.sNomeUsuario,ACBrNFe1.WebServices.Consulta.XMotivo, ACBrNFe1.WebServices.Consulta.cStat);

        sNomeArq := OpenDialog1.FileName;

        if pos(UpperCase('-nfe.xml'),UpperCase(sNomeArq)) > 0 then
           sNomeArq := StringReplace(sNomeArq,'-nfe.xml','-procNfe.xml',[rfIgnoreCase]);

        ACBrNFe1.NotasFiscais.Items[0].GravarXML(ExtractFileName(sNomeArq));
        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', arquivo gravado em: ' + sNomeArq;
        Application.ProcessMessages;

        if ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID <> '' then
        begin

          dmMSProcedure.fdspMaster.StoredProcName   := 'EXECUTA_SQL';
          dmMSProcedure.fdspMaster.Prepare;
          dmMSProcedure.fdspMaster.Params[0].Value  := 'UPDATE NFSAIDA SET NUMERO_DANFE = '
                                                              + QuotedStr(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)
                                                              + ' WHERE NFSAIDA = '     + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                              + ' AND MODELO = '        + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                              + ' AND SERIE = 1'
                                                              + ' AND DESTINATARIO_ = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);

          dmMSProcedure.fdspMaster.ExecProc;


          dmMSProcedure.fdspMaster.Params[0].Value  := 'UPDATE NFSAIDA SET PROTOCOLO_DANFE = '
                                                                  + QuotedStr(ACBrNFe1.WebServices.Consulta.Protocolo)
                                                                  + ' WHERE NFSAIDA = '     + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                                  + ' AND MODELO = '        + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                                  + ' AND SERIE = 1'
                                                                  + ' AND DESTINATARIO_ = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
          dmMSProcedure.fdspMaster.ExecProc;

          if dmDBEXMaster.fdtMaster.Active then
            dmDBEXMaster.fdtMaster.Commit;

          actSelecionarNotasExecute(self);

          ACBrNFe1.NotasFiscais.Imprimir;


        end;

      end;

    end
    else
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_N_EXISTE_NFE_ADCI_PROT;
      Application.ProcessMessages;

    end;

  except

    on E:exception do
    begin

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  ', ' + IntToStr(ACBrNFe1.WebServices.Consulta.cStat) + ' - ' + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actCancelarNFEExecute(Sender: TObject);
var
  vAux, idLote: String;
  tsEvento:TStringList;

begin

  try

    if not dmDBEXMaster.fdcMaster.InTransaction then
      dmDBEXMaster.fdtMaster.StartTransaction;

    idLote    := '1';
    tsEvento  := TStringList.Create;

    LimparMSG_ERRO(lblMsg, imgErro);

    OpenDialog1.Title         := 'Selecione a NFE';
    OpenDialog1.DefaultExt    := '*-nfe.XML';
    OpenDialog1.FilterIndex   := 1;
    OpenDialog1.Filter        := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir    := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
      tsEvento.Add(OpenDialog1.FileName);

      frmCancelamentoNFe := TfrmCancelamentoNFe.Create(self);
      frmCancelamentoNFe.lblInfoNF.Caption := 'Cancelamento NF�: ' + InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF);

      if frmCancelamentoNFe.ShowModal = mrOk then
      begin

        vAux := frmCancelamentoNFe.memJustificativa.Text;

        ACBrNFe1.EventoNFe.Evento.Clear;
        ACBrNFe1.EventoNFe.idLote := StrToInt(idLote);

        with ACBrNFe1.EventoNFe.Evento.Add do
        begin

         infEvento.dhEvento         := NOW;
         infEvento.tpEvento         := teCancelamento;
         infEvento.chNFe            := Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44);
         infEvento.CNPJ             := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
         infEvento.cOrgao           := 32;
         infEvento.detEvento.nProt  := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
         infEvento.detEvento.xJust  := vAux;

        end;

        CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
        Man_Tab_LOG_SYS(Application.Title,'O usu�rio selecionou a op��o para cancelar a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

        ACBrNFe1.EnviarEvento(StrToInt(idLote));

        ACBrNFe1.Consultar;

        lblMsg.Caption := RetornarRejeicao(dmDBEXMaster.sNomeUsuario,ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo, ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat);

        if ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt <> '' then
        begin

          CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
          Man_Tab_LOG_SYS(Application.Title,'O usu�rio cancelou a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

          dmMProvider.cdsNFSaida.Close;
          dmMProvider.cdsNFSaida.ProviderName := 'dspNFSaida';
          dmDBEXMaster.fdqNFSaida.SQL.Clear;
          dmDBEXMaster.fdqNFSaida.SQL.Add('SELECT NFSAIDA.*, CLIENTES.RAZAOSOCIAL FROM NFSAIDA');
          dmDBEXMaster.fdqNFSaida.SQL.Add('JOIN CLIENTES CLIENTES');
          dmDBEXMaster.fdqNFSaida.SQL.Add('ON(CLIENTES.CLIENTE = NFSAIDA.DESTINATARIO)');
          dmDBEXMaster.fdqNFSaida.SQL.Add('WHERE NFSAIDA.NFSAIDA = ' + InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF));
          dmDBEXMaster.fdqNFSaida.SQL.Add('AND NFSAIDA.MODELO = ' + QuotedStr('55'));

          dmMProvider.cdsNFSaida.Open;
          dmMProvider.cdsNFSaida.ProviderName := '';

          AbrirTabela_Cliente(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ESTORNANDO_SALDO_PRODUTO;
          Application.ProcessMessages;

          dmMSProcedure.fdspAtualizarSaldoProduto.Params[0].Value := 0;
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[1].Value := 0; //local movimento

          case dmMProvider.cdsNFSaidaENTRADA_SAIDA.Value of
            0:dmMSProcedure.fdspAtualizarSaldoProduto.Params[2].Value := 1; //operacao
            1:dmMSProcedure.fdspAtualizarSaldoProduto.Params[2].Value := 0; //operacao
          end;

          dmMSProcedure.fdspAtualizarSaldoProduto.Params[3].Value   := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[4].Value   := null; //barras
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[5].Value   := 0; //quantidade
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[6].Value   := 0; //produto
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[7].Value   := dmDBEXMaster.iIdFilial;
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[8].Value   := dmMProvider.cdsNFSaidaMODELO.Value;
          dmMSProcedure.fdspAtualizarSaldoProduto.Params[9].Value   := dmMProvider.cdsNFSaidaEMISSAO.Value;
          dmMSProcedure.fdspAtualizarSaldoProduto.ExecProc;

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ESTORNANDO_MOVIMENTO;
          Application.ProcessMessages;

          dmMSProcedure.fdspMovimento.Params[0].Value     := 2;                                           //op��o incluir estorno de movimento
{

          criar tratamento de estono na tabela de movimento

          dmMSProcedure.fdspMovimento.Params[0].Value     := 3;                                           //op��o incluir estorno de movimento

}
          dmMSProcedure.fdspMovimento.Params[1].Value     := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;; //controle
          dmMSProcedure.fdspMovimento.Params[2].Value     := 1;                                           //pela nf saida
          dmMSProcedure.fdspMovimento.Params[3].Value     := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis;
          dmMSProcedure.fdspMovimento.Params[4].Value     := Time;
          dmMSProcedure.fdspMovimento.Params[5].Value     := dmDBEXMaster.iIdFilial;
          dmMSProcedure.fdspMovimento.Params[6].Value     := 'EST'+FormatFloat('000000', ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF);
          dmMSProcedure.fdspMovimento.Params[7].Value     := Ord(tdNFS);
          dmMSProcedure.fdspMovimento.Params[8].Value     := -1;                                          //ecf
          dmMSProcedure.fdspMovimento.Params[9].Value     := -1;                                          //terminal
          dmMSProcedure.fdspMovimento.Params[10].Value    := null;                                        //cliente
          dmMSProcedure.fdspMovimento.Params[11].Value    := null;                                        //forma de pagamento
          dmMSProcedure.fdspMovimento.Params[12].Value    := null;                                        //pedido de venda
          dmMSProcedure.fdspMovimento.Params[13].Value    := 0;                                           //quantidade
          dmMSProcedure.fdspMovimento.Params[14].Value    := 0;                                           //valor unitario
          dmMSProcedure.fdspMovimento.Params[15].Value    := 0;                                           //cod barras
          dmMSProcedure.fdspMovimento.Params[16].Value    := 0;                                           //subtotal
          dmMSProcedure.fdspMovimento.Params[17].Value    := -1;                                          //fornecedor
          dmMSProcedure.fdspMovimento.Params[18].Value    := 0;                                           //desconto item
          dmMSProcedure.fdspMovimento.Params[19].Value    := 0;                                           //acrescimo item
          dmMSProcedure.fdspMovimento.ExecProc;

          GravarEstornarRegistro50(2); //exclui
          GravarEstornarRegistro54(2); //exclui
          GravarEstornarLivroSaida(1); //inclui

          dmMSProcedure.fdspMaster.StoredProcName := 'EXECUTA_SQL';
          dmMSProcedure.fdspMaster.Prepare;
          // marca a nota como cancelada
          dmMSProcedure.fdspMaster.Params[0].Value   := 'UPDATE NFSAIDA SET STATUS  = 2 '
                                                          + ' WHERE NFSAIDA = '     + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                          + ' AND MODELO = '        + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                          + ' AND SERIE = '         + QuotedStr(dmMProvider.cdsNFSaidaSERIE.Value)
                                                          + ' AND DESTINATARIO = '  + IntToStr(dmMProvider.cdsNFSaidaDESTINATARIO.Value);

          dmMSProcedure.fdspMaster.ExecProc;

          dmMSProcedure.fdspMaster.Params[0].Value   := 'UPDATE EFD_PIS_COFINS_RC100 SET COD_SITUACAO = 1'  + ' WHERE CHV_NFE = ' + QuotedStr(Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44));
          dmMSProcedure.fdspMaster.ExecProc;

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_GERANDO_REG50_SINTEGRA;
          Application.ProcessMessages;

          GravarEstornarRegistro50(3); //inclui

          ACBrNFe1.EventoNFe.GerarXML;
          ACBrNFe1.ImprimirEvento;

          ACBrNFe1.Consultar;

          ACBrNFe1.DANFE.NFeCancelada   := (ACBrNFe1.WebServices.Consulta.cStat = 101);
          ACBrNFe1.NotasFiscais.Imprimir;

          actSelecionarNotasExecute(self);

          if Length(Trim(dmMProvider.cdsClientesEMAIL.AsString)) > 0 then
          begin

            if ValidarEmail(dmMProvider.cdsClientesEMAIL.AsString) then
            begin

              CC := TStringList.Create;

              CC.Add('Esta mensagem refere-se ao cancelamento da Nota Fiscal Eletr�nica de venda N�: ' +
                  InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF)+ ' emitida pela empresa:');

              CC.Add('Raz�o Social: ' + dmMProvider.cdsFilialRAZAOSOCIAL.Value);
              CC.Add('E-mail: '       + dmMProvider.cdsFilialEMAIL.Value);
              CC.Add('CNPJ: '         + FormatarCNPJCPF(dmMProvider.cdsFilialCNPJ.Value));
              CC.Add('Insc.Est.: '    + FormatarCNPJCPF(dmMProvider.cdsFilialINSCRICAO.Value));
              CC.Add(' ');
              CC.Add(' ');

              CC.Add('Para visualiz�-la acesse o link a seguir:');
              CC.Add('https://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
              CC.Add('chave de acesso:  ' + Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, Length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)));

              CC.Add(' ');
              CC.Add(' ');
              CC.Add('* Este e-mail foi enviado automaticamente pelo Sistema de Gest�o GenesisAC-2010 ');
              CC.Add('  Favor n�o responder. Em caso de d�vidas, entre em contato com: ' + dmMProvider.cdsFilialEMAIL.Value);
              CC.Add(' ');
              CC.Add(' ');
              CC.Add('________________________________________________________________');
              CC.Add(' ');
              CC.Add(' ');
              CC.Add('*     Esta mensagem, incluindo seus anexos, � confidencial e seu conte�do � restrito ao destinat�rio da mensagem.');
              CC.Add('Caso voc� a tenha recebido por engano, queira, por favor, retorn�-la ao destinat�rio e apag�-la de seus arquivos.');
              CC.Add('� expressamente proibido o uso n�o autorizado, replica��o ou dissemina��o da mesma.');
              CC.Add('As opini�es contidas nesta mensagem e seus anexos n�o necessariamente refletem a opini�o do emissor. Grato pela colabora��o.');

              Para := dmMProvider.cdsClientesEMAIL.Value;

              lblMsg.Caption := 'Aguarde...enviando e-mail para: ' +  dmMProvider.cdsClientesEMAIL.Value;
              Application.ProcessMessages;

              ACBrNFe1.EnviarEmailEvento(Para,
                                         'Cancelamento Nf-e ' + ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                         CC,
                                         cEmailContabilidade,
                                         tsEvento);

              CC.Free;

              dmMProvider.cdsNFSaida.Close;

            end
            else
            begin

              lblMsg.Caption := 'Email inv�lido: ' +  dmMProvider.cdsClientesEMAIL.Value;
              Application.ProcessMessages;

            end;


          end
          else
          begin

            lblMsg.Caption := 'Email n�o configurado para o cliente: ' +  dmMProvider.cdsClientesRAZAOSOCIAL.Value;
            Application.ProcessMessages;

          end;

        end;

      end;

    end;

    dmDBEXMaster.fdtMaster.Commit;

    FreeAndNil(tsEvento);
  except
    on E:exception do
    begin

      dmDBEXMaster.fdtMaster.Rollback;
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  ', ' + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;


end;

procedure TfrmModDanfe.actCCeExecute(Sender: TObject);
var
  sRetorno:string;
  iEventoLote:integer;
  tsEvento:TStringList;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    tsEvento := TStringList.Create;

    frmAvisoUsoCCe := TfrmAvisoUsoCCe.Create(self);

    if frmAvisoUsoCCe.ShowModal = mrOk then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE;
      Application.ProcessMessages;

      OpenDialog1.Title       := 'Selecione a NFE para Carta de Corre��o - CCe';
      OpenDialog1.DefaultExt  := '*-nfe.XML';
      OpenDialog1.FilterIndex := 1;
      OpenDialog1.Filter      := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
      OpenDialog1.InitialDir  := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

      LimparMSG_ERRO(lblMsg, imgErro);

      if OpenDialog1.Execute then
      begin

        ACBrNFe1.NotasFiscais.Clear;
        ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
        tsEvento.Add(OpenDialog1.FileName);

        if ValidarNfe then
        begin

          frmCCe                        := TfrmCCe.Create(self);
          frmCCe.lblNumneroNfe.Caption  := IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF);
          frmCCe.lblEmissaoNfe.Caption  := FormatDateTime('dd/mm/yyyy',ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi);
          frmCCe.lblChaveNfe.Caption    := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;

          iEventoLote                   := StrToInt(FormatDateTime('yymmddhhmm', now));

          if frmCCe.ShowModal = mrOk then
          begin

            dmDBEXMaster.fdqMasterPesquisa.Close;
            dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
            dmDBEXMaster.fdqMasterPesquisa.SQL.Add('SELECT COUNT(*) AS NUM FROM CCE WHERE NOTA_FISCAL = ' + QuotedStr(IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF)));
            dmDBEXMaster.fdqMasterPesquisa.Open;

            ACBrNFe1.EventoNFe.Evento.Clear;
            ACBrNFe1.EventoNFe.idLote := iEventoLote;

            with ACBrNFe1.EventoNFe.Evento.Add do
            begin

              infEvento.chNFe                 := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
              infEvento.tpAmb                 := StrToTpAmb(bOk, InttoStr(dmMProvider.cdsConfiguracoesAMBIENTE_NFE.Value));
              infEvento.cOrgao                := StrToInt(copy(infEvento.chNFe,1,2));
              infEvento.CNPJ                  := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
              infEvento.dhEvento              := now;
              infEvento.tpEvento              := teCCe;
              infEvento.nSeqEvento            := dmDBEXMaster.fdqMasterPesquisa.FieldByName('NUM').AsInteger+1;
              infEvento.versaoEvento          := VERSAO_CCE;
              infEvento.detEvento.descEvento  := 'Carta de Correcao';
              infEvento.detEvento.xCorrecao   := frmCCe.memTextoCorrecao.Text;
              infEvento.detEvento.xCondUso    := ''; //Informar vazio, o componente vai colocar o texto correto

            end;

            if ACBrNFe1.EnviarEvento(iEventoLote) then
            begin

              ACBrNFe1.EventoNFe.GerarXML;

              with ACBrNFe1.WebServices.EnvEvento do
              begin

                if (EventoRetorno.retEvento.Items[0].RetInfEvento.cStat in [135, 136]) then
                begin

                  dmMSProcedure.fdspCCe.Params[0].Value := IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF);
                  dmMSProcedure.fdspCCe.Params[1].Value := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi;
                  dmMSProcedure.fdspCCe.Params[2].Value := Date;
                  dmMSProcedure.fdspCCe.Params[3].Value := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
                  dmMSProcedure.fdspCCe.Params[4].Value := InttoStr(ACBrNFe1.CartaCorrecao.CCe.idLote);
                  dmMSProcedure.fdspCCe.Params[5].Value := copy(ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe,1,2);
                  dmMSProcedure.fdspCCe.Params[6].Value := '110110';
                  dmMSProcedure.fdspCCe.Params[7].Value := VERSAO_CCE;
                  dmMSProcedure.fdspCCe.Params[8].Value := Copy(sRetorno,(pos('nProt>',sRetorno)+6),15);
                  dmMSProcedure.fdspCCe.Params[9].Value := frmCCe.memTextoCorrecao.Text;

                  dmMSProcedure.fdspCCe.ExecProc;

                  CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
                  Man_Tab_LOG_SYS(Application.Title,'O usu�rio criou a carta de corre��o para a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF),frmCCe.memTextoCorrecao.Text,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);


                  if ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF <> '99999999000191' then
                  begin

                    AbrirTabela_Cliente(ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF);
                    Para := Trim(dmMProvider.cdsClientesEMAIL.AsString);

                  end
                  else
                    Para := 'lindomarsampaio@outlook.com.br';

                  lblMsg.Caption := 'Aguarde...enviando e-mail para: ' +  Para;
                  Application.ProcessMessages;

                  CC := TStringList.Create;

                  CC.Add('Esta mensagem refere-se � Carta de Corre��o referente a Nota Fiscal Eletr�nica N�: ' +
                      InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF) + ' emitida pela empresa:');

                  CC.Add('Raz�o Social: ' + dmMProvider.cdsFilialRAZAOSOCIAL.Value);
                  CC.Add('E-mail: '       + dmMProvider.cdsFilialEMAIL.Value);
                  CC.Add('CNPJ: '         + FormatarCNPJCPF(dmMProvider.cdsFilialCNPJ.Value));
                  CC.Add('Insc.Est.: '    + FormatarCNPJCPF(dmMProvider.cdsFilialINSCRICAO.Value));
                  CC.Add(' ');
                  CC.Add(' ');

                  CC.Add('Para visualiz�-la acesse o link a seguir:');
                  CC.Add('https://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
                  CC.Add('chave de acesso:  ' + Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, Length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)));

                  CC.Add(' ');
                  CC.Add(' ');
                  CC.Add('* Este e-mail foi enviado automaticamente pelo Sistema ' + ID_SISTEMA);
                  CC.Add('  Favor n�o responder. Em caso de d�vidas, entre em contato com: ' + dmMProvider.cdsFilialEMAIL.Value);
                  CC.Add(' ');
                  CC.Add(' ');
                  CC.Add( '________________________________________________________________');
                  CC.Add(' ');
                  CC.Add(' ');
                  CC.Add('*     Esta mensagem, incluindo seus anexos, � confidencial e seu conte�do � restrito ao destinat�rio da mensagem.');
                  CC.Add('Caso voc� a tenha recebido por engano, queira, por favor, retorn�-la ao destinat�rio e apag�-la de seus arquivos.');
                  CC.Add('� expressamente proibido o uso n�o autorizado, replica��o ou dissemina��o da mesma.');
                  CC.Add('As opini�es contidas nesta mensagem e seus anexos n�o necessariamente refletem a opini�o do emissor. Grato pela colabora��o.');

                  ACBrNFe1.EnviarEmailEvento(Para,
                                             'Carta de Correcao referente a Nf-e ' + ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                             CC,
                                             cEmailContabilidade,
                                             tsEvento);


                  CC.Free;

                  lblMsg.Caption := 'email enviado com sucesso!';
                  Application.ProcessMessages;

                end
                else
                begin

//                  lblMsg.Caption := 'Carta de corre��o rejeitada. Motivo: ' + RetornarRejeicao EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
                  lblMsg.Caption := RetornarRejeicao(dmDBEXMaster.sNomeUsuario, EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo, EventoRetorno.retEvento.Items[0].RetInfEvento.cStat);
                  Application.ProcessMessages;

                end;

              end;


            end;

            FreeAndNil(frmCCe);

          end;

        end
        else
        begin

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_NFE_CANC_ENV_CONTIG;
          Application.ProcessMessages;

        end;

      end;

    end;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

    FreeAndNil(frmAvisoUsoCCe);

  except

    on E:exception do
    begin

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Commit;

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  ', ' + IntToStr(ACBrNFe1.WebServices.EnvEvento.cStat) + ' - ' + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actConsultarCadastroContribuinteExecute(Sender: TObject);
var
  sUF, sDocumento: String;
begin

  try

    frmConsultaCadastroContribuinte := TfrmConsultaCadastroContribuinte.Create(self);
    if frmConsultaCadastroContribuinte.ShowModal = mrOk then
    begin

      sUF         := Trim(frmConsultaCadastroContribuinte.cboUF.Text);
      sDocumento  := Trim(frmConsultaCadastroContribuinte.edtDocumento.Text);

      ACBrNFe1.WebServices.ConsultaCadastro.UF := sUF;

      if Length(sDocumento) > 11 then
        ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := sDocumento
      else
        ACBrNFe1.WebServices.ConsultaCadastro.CPF := sDocumento;

      ACBrNFe1.WebServices.ConsultaCadastro.Executar;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio usou op��o para concultar o cadastro do cnpj/cpj: ' +  FormatarCNPJCPF(sDocumento),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      lblMsg.Caption := RetornarRejeicao(dmDBEXMaster.sNomeUsuario, ACBrNFe1.WebServices.ConsultaCadastro.xMotivo, ACBrNFe1.WebServices.ConsultaCadastro.cStat);
      Application.ProcessMessages;

    end;

    FreeAndNil(frmConsultaCadastroContribuinte);

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actConsultarLoteExecute(Sender: TObject);
var
  aux: String;
begin

  try

    if (InputQuery('Consultar Recibo Lote', 'N�mero do Recibo', aux)) then
    begin

      LimparMSG_ERRO(lblMsg, imgErro);

      ACBrNFe1.WebServices.Recibo.Recibo := aux; ;
      ACBrNFe1.WebServices.Recibo.Executar;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio usou op��o para de consulta lote: ' + aux,'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      lblMsg.Caption := RetornarRejeicao(dmDBEXMaster.sNomeUsuario, ACBrNFe1.WebServices.Recibo.xMotivo, ACBrNFe1.WebServices.Recibo.cStat);
      Application.ProcessMessages;

    end;

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actConsultarNFEExecute(Sender: TObject);
begin

  try

    OpenDialog1.InitialDir  := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

    if not dmDBEXMaster.fdcMaster.InTransaction then
      dmDBEXMaster.fdtMaster.StartTransaction;

    OpenDialog1.Title       := 'Selecione a NFE';
    OpenDialog1.DefaultExt  := '*-nfe.XML';
    OpenDialog1.FilterIndex := 1;
    OpenDialog1.Filter      := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio selecionou a op��o para conultar a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      ACBrNFe1.Consultar;

      LimparMSG_ERRO(lblMsg, imgErro);

      lblMsg.Caption := RetornarRejeicao(dmDBEXMaster.sNomeUsuario, ACBrNFe1.WebServices.Consulta.XMotivo, ACBrNFe1.WebServices.Consulta.cStat);
      Application.ProcessMessages;

      case ACBrNFe1.WebServices.Consulta.cStat of
        110,301,302:begin

                      dmMProvider.cdsNFSaida.Close;
                      dmMProvider.cdsNFSaida.ProviderName := 'dspNFSaida';

                      dmDBEXMaster.fdqNFSaida.SQL.Clear;
                      dmDBEXMaster.fdqNFSaida.SQL.Add('SELECT NFSAIDA.*, CLIENTES.RAZAOSOCIAL FROM NFSAIDA');
                      dmDBEXMaster.fdqNFSaida.SQL.Add('JOIN CLIENTES CLIENTES');
                      dmDBEXMaster.fdqNFSaida.SQL.Add('ON(CLIENTES.CLIENTE = NFSAIDA.DESTINATARIO)');
                      dmDBEXMaster.fdqNFSaida.SQL.Add('WHERE NFSAIDA.NFSAIDA = ' + InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF));
                      dmDBEXMaster.fdqNFSaida.SQL.Add('AND NFSAIDA.MODELO = ' + QuotedStr('55'));

                      dmMProvider.cdsNFSaida.Open;
                      dmMProvider.cdsNFSaida.ProviderName := '';

                      dmMSProcedure.fdspMaster.StoredProcName   := 'EXECUTA_SQL';
                      dmMSProcedure.fdspMaster.Prepare;
                      dmMSProcedure.fdspMaster.Params[0].Value  := 'UPDATE NFSAIDA SET NUMERO_DANFE = '
                                                                    + QuotedStr('Nfe'+ACBrNFe1.WebServices.Consulta.NFeChave)
                                                                    + ', PROTOCOLO_DANFE = ' + QuotedStr(ACBrNFe1.WebServices.Consulta.Protocolo)
                                                                    + ', STATUS  = 3'
                                                                    + ' WHERE NFSAIDA = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                                    + ' AND MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                                    + ' AND SERIE = ' + Trim(dmMProvider.cdsNFSaidaSERIE.AsString)
                                                                    + ' AND DESTINATARIO_ = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
                      dmMSProcedure.fdspMaster.ExecProc;

                      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_DENEGANDO_NFE;
                      Application.ProcessMessages;

                      GravarEstornarRegistro50(2); //exclui

                      GravarEstornarLivroSaida(1);

                      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ATUALIZANDO_STATUS + 'Nota fiscal';
                      Application.ProcessMessages;

                      dmMSProcedure.fdspMaster.StoredProcName := 'EXECUTA_SQL';
                      dmMSProcedure.fdspMaster.Prepare;

                      dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE EFD_PIS_COFINS_RC100 SET CHV_NFE = '
                                                                          + QuotedStr(ACBrNFe1.WebServices.Consulta.NFeChave)
                                                                          + ' WHERE NUM_DOCUMENTO = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                                          + ' AND COD_MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                                          + ' AND SERIE = 1'
                                                                          + ' AND COD_PARTICIPANTE = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);

                      dmMSProcedure.fdspMaster.ExecProc;

                      dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE EFD_PIS_COFINS_RC100 SET COD_SITUACAO = 4'
                                                                          + ' WHERE CHV_NFE = ' + QuotedStr(ACBrNFe1.WebServices.Consulta.NFeChave);
                      dmMSProcedure.fdspMaster.ExecProc;

                      GravarEstornarRegistro50(4);

                      actSelecionarNotasExecute(self);

                  end;

          end;

    end;

    dmDBEXMaster.fdtMaster.Commit;

  except

    on E:exception do
    begin

      dmDBEXMaster.fdtMaster.Rollback;
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;


end;

procedure TfrmModDanfe.actEnviarNFEEmailExecute(Sender: TObject);
begin

  try

    LimparMSG_ERRO(lblMsg, imgErro);

    OpenDialog1.Title       := 'Selecione a NFE';
    OpenDialog1.DefaultExt  := '*-nfe.XML';
    OpenDialog1.FilterIndex := 1;
    OpenDialog1.Filter      := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir  := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

      dmMProvider.cdsNFSaida.Close;
      dmMProvider.cdsNFSaida.ProviderName := 'dspNFSaida';

      dmDBEXMaster.fdqNFSaida.SQL.Clear;
      dmDBEXMaster.fdqNFSaida.SQL.Add('SELECT NFSAIDA.*, CLIENTES.RAZAOSOCIAL FROM NFSAIDA');
      dmDBEXMaster.fdqNFSaida.SQL.Add('JOIN CLIENTES CLIENTES');
      dmDBEXMaster.fdqNFSaida.SQL.Add('ON(CLIENTES.CLIENTE = NFSAIDA.DESTINATARIO)');
      dmDBEXMaster.fdqNFSaida.SQL.Add('WHERE NFSAIDA = ' + InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF));
      dmDBEXMaster.fdqNFSaida.SQL.Add('AND MODELO = ' + QuotedStr('55'));

      dmMProvider.cdsNFSaida.Open;
      dmMProvider.cdsNFSaida.ProviderName := '';

      AbrirTabela_Cliente(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);

      cEmailContabilidade := TStringList.Create;
      cEmailContabilidade.Add(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.AsString);

      if Length(Trim(dmMProvider.cdsClientesEMAIL.AsString)) > 0 then
      begin

        if ValidarEmail(dmMProvider.cdsClientesEMAIL.AsString) then
        begin

          CC := TStringList.Create;

          CC.Add('Esta mensagem refere-se � Nota Fiscal Eletr�nica de venda N�: ' +
              InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF)+ ' emitida pela empresa:');

          CC.Add('Raz�o Social: ' + dmMProvider.cdsFilialRAZAOSOCIAL.Value);
          CC.Add('E-mail: '       + dmMProvider.cdsFilialEMAIL.Value);
          CC.Add('CNPJ: '         + FormatarCNPJCPF(dmMProvider.cdsFilialCNPJ.Value));
          CC.Add('Insc.Est.: '    + FormatarCNPJCPF(dmMProvider.cdsFilialINSCRICAO.Value));
          CC.Add(' ');
          CC.Add(' ');

          CC.Add('Para visualiz�-la acesse o link a seguir:');
          CC.Add('https://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
          CC.Add('chave de acesso:  ' + Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, Length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)));

          CC.Add(' ');
          CC.Add(' ');
          CC.Add('* Este e-mail foi enviado automaticamente pelo Sistema ' + ID_SISTEMA);
          CC.Add('  Favor n�o responder. Em caso de d�vidas, entre em contato com: ' + dmMProvider.cdsFilialEMAIL.Value);
          CC.Add(' ');
          CC.Add(' ');
          CC.Add('________________________________________________________________');
          CC.Add(' ');
          CC.Add(' ');
          CC.Add('*     Esta mensagem, incluindo seus anexos, � confidencial e seu conte�do � restrito ao destinat�rio da mensagem.');
          CC.Add('Caso voc� a tenha recebido por engano, queira, por favor, retorn�-la ao destinat�rio e apag�-la de seus arquivos.');
          CC.Add('� expressamente proibido o uso n�o autorizado, replica��o ou dissemina��o da mesma.');
          CC.Add('As opini�es contidas nesta mensagem e seus anexos n�o necessariamente refletem a opini�o do emissor. Grato pela colabora��o.');

          Para := dmMProvider.cdsClientesEMAIL.AsString;

          if dmMProvider.cdsConfiguracoesENVIAR_XML_CONTABILIDADE.Value = 1 then
            lblMsg.Caption := 'Aguarde...enviando e-mail para: ' +  dmMProvider.cdsClientesEMAIL.AsString + #13
                              + ' com c�pia para: ' + cEmailContabilidade[0]
          else
            lblMsg.Caption := 'Aguarde...enviando e-mail para: ' +  dmMProvider.cdsClientesEMAIL.AsString;

          Application.ProcessMessages;

            if (dmMProvider.cdsConfiguracoesENVIAR_XML_CONTABILIDADE.Value = 1) and (Length(Trim(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.AsString)) > 0) then
              ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( Para,
                                                          'Nf-e ' + ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                                          CC,
                                                          True,                // Enviar PDF junto
                                                          cEmailContabilidade, // Lista com emails que ser�o enviado c�pias - TStrings
                                                          nil)                 // Lista de anexos - TStrings
            else
              ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( Para,
                                                          'Nf-e ' + ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                                          CC,
                                                          True,   // Enviar PDF junto
                                                          nil ,   // Lista com emails que ser�o enviado c�pias - TStrings
                                                          nil);    // Lista de anexos - TStrings



          CC.Free;

          CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
          Man_Tab_LOG_SYS(Application.Title,'O usu�rio enviou a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF) + ' por email','',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

          dmMProvider.cdsNFSaida.Close;

          LimparMSG_ERRO(lblMsg, imgErro);

        end
        else
        begin

          lblMsg.Caption := 'Email inv�lido: ' +  dmMProvider.cdsClientesEMAIL.AsString;
          Application.ProcessMessages;

        end;

      end
      else
      begin

        lblMsg.Caption := 'Email n�o configurado para o cliente: ' +  dmMProvider.cdsClientesRAZAOSOCIAL.AsString;
        Application.ProcessMessages;

      end;

      FreeAndNil(cEmailContabilidade);

    end;

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actGerarPDFExecute(Sender: TObject);
begin

  try

    OpenDialog1.Title       := 'Selecione a NFE';
    OpenDialog1.DefaultExt  := '*-nfe.XML';
    OpenDialog1.FilterIndex := 1;
    OpenDialog1.Filter      := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir  := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio gerou o pdf para a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      ACBrNFe1.NotasFiscais.ImprimirPDF;

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', arquivo gerado em: ' + ACBrNFe1.DANFE.PathPDF;

    end;

  except
    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actImprimirDANFEExecute(Sender: TObject);
begin

  try

    OpenDialog1.Title       := 'Selecione a NFE';
    OpenDialog1.DefaultExt  := '*-nfe.XML';
    OpenDialog1.FilterIndex := 1;
    OpenDialog1.Filter      := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir  := ACBrNFe1.Configuracoes.Arquivos.PathNFe;

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio selecionou a op��o para imprimir a nota: ' + IntToStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
      begin

        ACBrNFe1.Consultar;
        ACBrNFe1.DANFE.ProtocoloNFe   := ACBrNFe1.WebServices.Consulta.Protocolo + ' ' + DateTimeToStr(ACBrNFe1.WebServices.Consulta.DhRecbto);

      end
      else
        ACBrNFe1.Consultar;

      ACBrNFe1.DANFE.NFeCancelada   := (ACBrNFe1.WebServices.Consulta.cStat = 101);
      ACBrNFe1.NotasFiscais.Imprimir;

    end;

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actInutilizacaoNumeroExecute(Sender: TObject);
var
  sJustificativa, sAno, sModelo, sSerie, sNumeroInicial, sNumeroFinal, sArquivo:string;
  i, iNumeroInicial, iNumeroFinal:integer;
begin

  try

    if not dmDBEXMaster.fdcMaster.InTransaction then
      dmDBEXMaster.fdtMaster.StartTransaction;

    frmInutilizacaoNumeracao := TfrmInutilizacaoNumeracao.Create(self);

    if frmInutilizacaoNumeracao.ShowModal = mrOk then
    begin

      sSerie          := Trim(dmMProvider.cdsConfiguracoesSERIE.AsString);
      sModelo         := Trim(dmMProvider.cdsConfiguracoesMODELO.AsString);
      sJustificativa  := RetirarAcentuacao(frmInutilizacaoNumeracao.memJustificativa);
      sAno            := Trim(frmInutilizacaoNumeracao.cboAno.Text);
      sNumeroInicial  := Trim(frmInutilizacaoNumeracao.edtNumeroInicial.Text);
      sNumeroFinal    := Trim(frmInutilizacaoNumeracao.edtNumeroFinal.Text);

      iNumeroInicial  := StrToInt(sNumeroInicial);
      iNumeroFinal    := StrToInt(sNumeroFinal);

      ACBrNFe1.WebServices.Inutiliza(dmMProvider.cdsFilialCNPJ.AsString, sJustificativa, StrToInt(sAno), StrToInt(sModelo), StrToInt(sSerie), StrToInt(sNumeroInicial), StrToInt(sNumeroFinal));
      lblMsg.Caption  := RetornarRejeicao(dmDBEXMaster.sNomeUsuario, ACBrNFe1.WebServices.Inutilizacao.xMotivo, ACBrNFe1.WebServices.Inutilizacao.cStat);

      if (dmMProvider.cdsParametros_NFECRIAR_PASTAS_MENSALMENTE.Value = 1) then
        sArquivo := ACBrNFe1.Configuracoes.Arquivos.PathInu + FormatDateTime('yyyymm',Date) + '\'
      else
        sArquivo := ACBrNFe1.Configuracoes.Arquivos.PathInu;

      sArquivo        :=  sArquivo + '32'
                                   + Copy(sAno,3,2)
                                   + dmMProvider.cdsFilialCNPJ.Value
                                   + '55'
                                   + FormatFloat('000',StrToInt(dmMProvider.cdsConfiguracoesSERIE.Value))
                                   + FormatFloat('000000000',iNumeroInicial)
                                   + FormatFloat('000000000',iNumeroFinal)
                                   + '-procInutNFe.xml';

      ACBrNFe1.InutNFe.LerXML(sArquivo);

      ACBrNFe1.ImprimirInutilizacao;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio usou op��o para inutilizar a numera��o de nota entre: ' + FormatFloat('000000000',iNumeroInicial) + ' e ' + FormatFloat('000000000',iNumeroFinal),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      if ACBrNFe1.WebServices.Inutilizacao.cStat = 102 then
      begin

        for i := iNumeroInicial to iNumeroFinal do
        begin

          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[0].Value  := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[1].Value  := 1; //sa�da
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[2].Value  := 0; //emissao propria
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[3].Value  := dmMProvider.cdsFilialCNPJ.Value;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[4].Value  := 5;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[5].Value  := sModelo;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[6].Value  := IntToStr(i);
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[7].Value  := sSerie;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[8].Value  := '';
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[9].Value  := Date;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[10].Value := Date;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[11].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[12].Value := 9; //ind pagamento
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[13].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[14].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[15].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[16].Value := 9; //ind frete
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[17].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[18].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[19].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[20].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[21].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[22].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[23].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[24].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[25].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[26].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[17].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[18].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.Params[29].Value := 0;
          dmMSProcedure.fdspMan_Tab_RC100_SPED.ExecProc;

          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[0].Value  := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[1].Value  := dmMProvider.cdsFilialCNPJ.Value;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[2].Value  := dmMProvider.cdsFilialINSCRICAO.Value;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[3].Value  := Date;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[4].Value  := dmMProvider.cdsFilialESTADOENTREGA.Value;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[5].Value  := sModelo;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[6].Value  := sSerie;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[7].Value  := IntToStr(i);
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[8].Value  := '0000';
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[9].Value  := 'P';
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[10].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[11].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[12].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[13].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[14].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[15].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[16].Value := '4';
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[17].Value := 0;
          dmMSProcedure.fdspMan_Tab_R50_Sint.Params[18].Value := Date;

          dmMSProcedure.fdspMan_Tab_R50_Sint.ExecProc;

        end;

      end;

    end;

    FreeAndNil(frmInutilizacaoNumeracao);
    if dmDBEXMaster.fdcMaster.InTransaction then
      dmDBEXMaster.fdtMaster.Commit;

  except

    on E:exception do
    begin

      if dmDBEXMaster.fdcMaster.InTransaction then
        dmDBEXMaster.fdtMaster.Rollback;

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  ', ' + IntToStr(ACBrNFe1.WebServices.Inutilizacao.cStat) + ' - ' + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actSelecionarNotasExecute(Sender: TObject);
begin

  try

    if FileExists(dmMProvider.cdsParametros_NFELOGO_MARCA.Value) then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE;
      Application.ProcessMessages;

      dmDBEXMaster.fdcMaster.Close;
      dmDBEXMaster.fdcMaster.Open;

      dmMProvider.cdsNFSaida.Close;
      dmMProvider.cdsNFSaida.ProviderName := 'dspNFSaida';

      dmDBEXMaster.fdqNFSaida.SQL.Clear;
      dmDBEXMaster.fdqNFSaida.SQL.Add('SELECT NFSAIDA.*, CLIENTES.RAZAOSOCIAL FROM NFSAIDA');
      dmDBEXMaster.fdqNFSaida.SQL.Add('JOIN CLIENTES CLIENTES');
      dmDBEXMaster.fdqNFSaida.SQL.Add('ON(CLIENTES.CLIENTE = NFSAIDA.DESTINATARIO)');
      dmDBEXMaster.fdqNFSaida.SQL.Add('WHERE NFSAIDA.PROTOCOLO_DANFE IS NULL AND NFSAIDA.NUMERO_DANFE IS NULL ');
      dmDBEXMaster.fdqNFSaida.SQL.Add('AND NFSAIDA.STATUS = 1');
      dmDBEXMaster.fdqNFSaida.SQL.Add('AND NFSAIDA.MODELO = ' + QuotedStr(dmMProvider.cdsConfiguracoesMODELO.Value));
      dmDBEXMaster.fdqNFSaida.SQL.Add('ORDER BY NFSAIDA.EMISSAO, NFSAIDA.NFSAIDA');

      dmMProvider.cdsNFSaida.Open;
      dmMProvider.cdsNFSaida.ProviderName := '';

      grdSelecionaNotas.SetFocus;

      LimparMSG_ERRO(lblMsg, imgErro);

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,'O usu�rio acionou a op��o para selecionar notas para envio','',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

    end
    else
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  ', n�o foi poss�vel localizar a logomarca. Verifique as configura��es';
      imgErro.Visible := True;
      Application.ProcessMessages;

    end;

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.actStatusServicoExecute(Sender: TObject);
begin

  try

    if grpEnvioNFE.Enabled then
    begin

      LimparMSG_ERRO(lblMsg, imgErro);

      lblmsg.Caption   := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'verificando status do servi�o';
      Application.ProcessMessages;

      ChecarStatusWS;

    end
    else
    begin

      lblmsg.Caption                            := dmDBEXMaster.sNomeUsuario + ', ' + 'seu certificado venceu em: ' + FormatDateTime('dd/mm/yyyy',ACBrNFe1.SSL.CertDataVenc);
      imgErro.Visible                           := True;
      Application.ProcessMessages;

    end;

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.CarregarConfiguracoesACBR;
var
  Ok : Boolean;
begin

  ACBrNFe1.Configuracoes.Certificados.ArquivoPFX    := dmMProvider.cdsParametros_NFECAMINHO_CERTIFICADO.Value;
  ACBrNFe1.Configuracoes.Certificados.Senha         := dmMProvider.cdsParametros_NFESENHA_CERTIFICADO.Value;
  ACBrNFe1.Configuracoes.Certificados.NumeroSerie   := dmMProvider.cdsConfig_iniSERIE_CERTIFICADO_DIGITAL.Text;

  ACBrNFe1.SSL.NumeroSerie            := dmMProvider.cdsConfig_iniSERIE_CERTIFICADO_DIGITAL.Text;
  ACBrNFe1.DANFE.Logo                               := dmMProvider.cdsParametros_NFELOGO_MARCA.Value;
  ACBrNFe1.DANFE.PathPDF                            := dmMProvider.cdsConfiguracoesPATH_SALVAR_PDF.Value;

  with ACBrNFe1.Configuracoes.Geral do
  begin

    SSLLib                := TSSLLib(dmMProvider.cdsParametros_NFESSL_LIB.Value);
    SSLCryptLib           := TSSLCryptLib(dmMProvider.cdsParametros_NFECRYPT_LIB.Value);
    SSLHttpLib            := TSSLHttpLib(dmMProvider.cdsParametros_NFEHTTP_LIB.Value);
    SSLXmlSignLib         := TSSLXmlSignLib(dmMProvider.cdsParametros_NFEXMLSIGN_LIB.Value);
    ExibirErroSchema      := (dmMProvider.cdsParametros_NFEEXIBIR_ERRO_SCHEMA.Value = 1);
    FormatoAlerta         := dmMProvider.cdsParametros_NFEFORMATO_ALERTA.Value;
//    FormaEmissao     := TpcnTipoEmissao(); //ver possibilidade de criar configuracao
    ModeloDF              := TpcnModeloDF(0); //nfe
    VersaoDF              := TpcnVersaoDF(dmMProvider.cdsParametros_NFEVERSAO_NFE.Value);
    IdCSC                 := '';
    CSC                   := '';
    Salvar                := (dmMProvider.cdsParametros_NFESALVAR_ARQUIVOS_ENVIO_RESPOSTA.Value = 1);
    AtualizarXMLCancelado := (dmMProvider.cdsParametros_NFEATUALIZAR_XML.Value = 1);
    ExibirErroSchema      := (dmMProvider.cdsParametros_NFEEXIBIR_ERRO_SCHEMA.Value = 1);
    RetirarAcentos        := (dmMProvider.cdsParametros_NFERETIRAR_ACENTOS_XML_ENVIADO.Value = 1);
    RetirarEspacos        := true;

  end;

  with ACBrNFe1.Configuracoes.WebServices do
  begin

    UF                        := dmMProvider.cdsConfiguracoesWS_NFE.Value;
    Ambiente                  := StrToTpAmb(Ok,IntToStr(dmMProvider.cdsConfiguracoesAMBIENTE_NFE.Value));
    Visualizar                := (dmMProvider.cdsConfiguracoesVISUALIZAR_MSG_NFE.Value = 1);
    Salvar                    := (dmMProvider.cdsParametros_NFESALVAR_ENVELOP_SOAP.Value = 1);
    AjustaAguardaConsultaRet  := (dmMProvider.cdsParametros_NFEAJUSTAR_MSG_AGUARDE.Value = 1);

    if NaoEstaVazio(IntToStr(dmMProvider.cdsParametros_NFETEMPO_AGUARDAR_ENVIO.AsInteger)) then
      AguardarConsultaRet := ifThen(dmMProvider.cdsParametros_NFETEMPO_AGUARDAR_ENVIO.AsInteger < 1000, dmMProvider.cdsParametros_NFETEMPO_AGUARDAR_ENVIO.AsInteger * 1000, dmMProvider.cdsParametros_NFETEMPO_AGUARDAR_ENVIO.AsInteger);

    if NaoEstaVazio(IntToStr(dmMProvider.cdsParametros_NFETENTATIVAS_ENVIO.AsInteger)) then
      Tentativas          := dmMProvider.cdsParametros_NFETENTATIVAS_ENVIO.AsInteger;

    if NaoEstaVazio(IntToStr(dmMProvider.cdsParametros_NFEINTERVALO_TENTATIVAS.AsInteger)) then
      IntervaloTentativas := ifThen(dmMProvider.cdsParametros_NFEINTERVALO_TENTATIVAS.AsInteger < 1000,dmMProvider.cdsParametros_NFEINTERVALO_TENTATIVAS.AsInteger * 1000, dmMProvider.cdsParametros_NFEINTERVALO_TENTATIVAS.AsInteger);

    ProxyHost := '';
    ProxyPort := '';
    ProxyUser := '';
    ProxyPass := '';

  end;

  with ACBrNFe1.Configuracoes.Arquivos do
  begin

    Salvar             := (dmMProvider.cdsParametros_NFESALVAR_ARQS_EM_PASTAS_SEPARADAS.Value = 1);
    SepararPorMes      := (dmMProvider.cdsParametros_NFECRIAR_PASTAS_MENSALMENTE.Value = 1);
    AdicionarLiteral   := (dmMProvider.cdsParametros_NFEADICIONAR_LITERAL_NOME_PASTAS.Value = 1);
    EmissaoPathNFe     := (dmMProvider.cdsParametros_NFESALVAR_NFE_PELA_EMISSAO.Value = 1);
    SalvarEvento       := (dmMProvider.cdsParametros_NFESALVAR_ARQUIVOS_EVENTOS.Value = 1);
    SepararPorCNPJ     := (dmMProvider.cdsParametros_NFESEPARAR_ARQ_POR_CNPJ_CERTIF.Value = 1);
    SepararPorModelo   := (dmMProvider.cdsParametros_NFESEPARAR_ARQ_POR_MODELO_DOC.Value = 1);
    PathSalvar         := dmMProvider.cdsParametros_NFEPASTA_LOGS.AsString;
    PathSchemas        := dmMProvider.cdsParametros_NFEPASTA_SCHEMAS.AsString;
    PathNFe            := dmMProvider.cdsParametros_NFEPASTA_ARQS_NFE.AsString;
    PathInu            := dmMProvider.cdsParametros_NFEPASTA_ARQS_INUTILIZACAO.AsString;
    PathEvento         := dmMProvider.cdsParametros_NFEPASTA_ARQS_EVENTO.AsString;

  end;

  with ACBrMail1 do
  begin

    Host                := dmMProvider.cdsConfiguracoesSERVIDOR_SMTP.AsString;
    Port                := dmMProvider.cdsConfiguracoesPORTA_SMTP.AsString;
    Username            := dmMProvider.cdsConfiguracoesUSUARIO_SMTP.AsString;
    Password            := dmMProvider.cdsConfiguracoesSENHA_USUARIO_SMTP.AsString;
    From                := dmMProvider.cdsConfiguracoesUSUARIO_SMTP.AsString;
    SetSSL              := (dmMProvider.cdsConfiguracoesUSAR_SSL_SMTP.Value = 1);   // SSL - Conexão Segura
    SetTLS              := (dmMProvider.cdsConfiguracoesAUTENTICA_SMTP.Value = 1);  // Auto TLS
    ReadingConfirmation := True;                                                    //Pede confirma��o de leitura do email
    UseThread           := True;                                                    //Aguarda Envio do Email(não usa thread)
    FromName            := dmMProvider.cdsFilialRAZAOSOCIAL.Value;

  end;

  ACBrNFe1.SSL.SSLType := TSSLType(dmMProvider.cdsParametros_NFESSL_TYPE.Value);
  ACBrNFe1.SSL.DescarregarCertificado;

end;

procedure TfrmModDanfe.ChecarStatusWS;
var
 sAmbiente:string;
begin

  try

    ACBrNFe1.WebServices.StatusServico.Executar;

    memStatusWSNfe.Clear;

    if TpAmbToStr(ACBrNFe1.WebServices.StatusServico.tpAmb) = '1' then
      sAmbiente := 'Produ��o'
    else
      sAmbiente := 'Homologa��o';

    memStatusWSNfe.Clear;
    memStatusWSNfe.Lines.Add('');
    memStatusWSNfe.Lines.Add('Ambiente:     ' + sAmbiente);
    memStatusWSNfe.Lines.Add('Vers�o Aplic: ' + ACBrNFe1.WebServices.StatusServico.verAplic);
    memStatusWSNfe.Lines.Add('Status:       ' + IntToStr(ACBrNFe1.WebServices.StatusServico.cStat));
    memStatusWSNfe.Lines.Add('Motivo:       ' + ACBrNFe1.WebServices.StatusServico.xMotivo);
    memStatusWSNfe.Lines.Add('UF:           ' + IntToStr(ACBrNFe1.WebServices.StatusServico.cUF));
    memStatusWSNfe.Lines.Add('Dt Recebto.:  ' + DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRecbto));
    memStatusWSNfe.Lines.Add('Observa��o:   ' + ACBrNFe1.WebServices.StatusServico.xObs);

    LimparMSG_ERRO(lblMsg, imgErro);

  except
    on E:exception do
    begin

      memStatusWSNfe.Clear;
      memStatusWSNfe.Lines.Add('');
      memStatusWSNfe.Lines.Add(E.Message);

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');

      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);


    end;

  end;

end;

function TfrmModDanfe.ChecarValidadeCertificado: boolean;
begin

  grpEnvioNFE.Enabled := False;

  try

    Result                                := Date <= ACBrNFe1.SSL.CertDataVenc;
    grpEnvioNFE.Enabled                   := Result;
    lblDataVencimentoCertificado.Caption  := FormatDateTime('dd/mm/yyyy',ACBrNFe1.SSL.CertDataVenc);

  except
    on E:exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.FormCreate(Sender: TObject);
var
  i:integer;
begin

  DesabilitarBotaoFecharForm(self.Handle);

  Caption                   := ' ' + Application.Title + ' - ' + PREFIXO_VERSAO + RetornarVersao(ParamStr(0),1);

  dmDBEXMaster.sNomeUsuario := ParamStr(1);
  dmDBEXMaster.sSenha       := paramstr(2);
  dmDBEXMaster.iIdUsuario   := StrToInt(ParamStr(3));
  dmDBEXMaster.iIdFilial    := StrToInt(ParamStr(4));

  dmMProvider.cdsFilial.Close;
  dmMProvider.cdsFilial.ProviderName := 'dspFilial';

  dmMProvider.cdsFilial.Open;
  dmMProvider.cdsFilial.ProviderName := '';

  CarregarConfiguracoesACBR;

  if not ChecarValidadeCertificado then
  begin

    lblmsg.Caption                            := dmDBEXMaster.sNomeUsuario + ', ' + 'seu certificado venceu em: ' + FormatDateTime('dd/mm/yyyy',ACBrNFe1.SSL.CertDataVenc);
    imgErro.Visible                           := True;
    lblDataVencimentoCertificado.Font.Color   := clRed;
    lblDataVencimentoCertificado.Font.Style   := [fsBold, fsStrikeout];
    Application.ProcessMessages;

  end
  else
  begin

    LimparMSG_ERRO(lblMsg, imgErro);
    lblDataVencimentoCertificado.Font.Style   := [fsBold];
    lblDataVencimentoCertificado.Font.Color   := clGreen;

  end;

  for i := 0 to grdSelecionaNotas.Columns.Count - 1 do
    grdSelecionaNotas.Columns[i].Title.Color := COR_TITULO_GRADE;

  sPasta_Imagem_Log := ApplicationPath + 'Log\' + dmDBEXMaster.sNomeUsuario + '\' +  FormatDateTime('yyyy', Date)
                        + '\' + MesExtenso(Date) + '\' + FormatDateTime('dd', Date) +'\';

  ForceDirectories(sPasta_Imagem_Log);

end;

procedure TfrmModDanfe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = vk_f11 then
  begin

    OpenDialog1.Title := 'Selecione a NFE';
    OpenDialog1.DefaultExt := '*.XML';
    OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    end;

    OpenDialog1.Title := 'Selecione o Evento';
    OpenDialog1.DefaultExt := '*.XML';
    OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
    OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;

    if OpenDialog1.Execute then
    begin

      ACBrNFe1.EventoNFe.Evento.Clear;
      ACBrNFe1.EventoNFe.LerXML(OpenDialog1.FileName) ;
      ACBrNFe1.ImprimirEvento;

    end;

  end;
end;

procedure TfrmModDanfe.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if (UpperCase(key) = 'S') and (lblMsg.Tag = ord(EnviarNFE)) then
  begin

    CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
    Man_Tab_LOG_SYS(Application.Title,'O usu�rio confirmou o envio da nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

    Key         := #0;
    lblMsg.Tag  := 0;
    GerarEnviarNfe(ord(EnviarNFE));

  end
  else   if (UpperCase(key) = 'N')  then
  begin

    key         := #0;
    lblMsg.Tag  := 0;
    LimparMSG_ERRO(lblMsg, imgErro);
    grdSelecionaNotas.Enabled := True;

    CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
    Man_Tab_LOG_SYS(Application.Title,'O usu�rio cancelou o envio da nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

  end;

end;

procedure TfrmModDanfe.GerarEnviarNfe(pOpcao: smallint);
var
  ok, bDevolucao, bNContribuinte: boolean;
  pPerc_Desc_Rat, pFrete, v_Frete, cPercentualTribFederal,cTributosFederais,
  vlBCUFDest, percFCPUFDest,  percICMSUFDest, percICMSInter, percICMSInterPart,
  vlFCPUFDest, vlICMSUFDest, vlICMSUFRemet:currency;
  sArquivo, sAno_Mes, sPastaOrigemXML,sPastaOrigemPDF, sPastaDestinoXML, sPastaDestinoPDF, sMSG_Val_Regras :string;

begin

  bNContribuinte := False;

  try

    if not dmDBEXMaster.fdcMaster.InTransaction then
      dmDBEXMaster.fdtMaster.StartTransaction;

    lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE;
    Application.ProcessMessages;

    cEmailContabilidade := TStringList.Create;

    ACBrNFe1.NotasFiscais.Clear;

    AbrirTabela_Item_Nf(dmMProvider.cdsNFSaidaNFSAIDA.Value, dmMProvider.cdsNFSaidaMODELO.AsString);
    AbrirTabela_Cfop(dmMProvider.cdsNFSaidaNFSAIDA.Value, dmMProvider.cdsNFSaidaMODELO.AsString);
    AbrirTabela_Cliente(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
    AbrirTabelaParcelasNFS(dmMProvider.cdsNFSaidaNFSAIDA.Value, dmMProvider.cdsNFSaidaMODELO.AsString);
    AbrirTabelaDocRefNFS(dmMProvider.cdsNFSaidaNFSAIDA.Value, dmMProvider.cdsNFSaidaMODELO.AsString);

    with ACBrNFe1.NotasFiscais.Add.NFe do
    begin

      //verifica se a vers�o da nfe � 3.10 ou inferior
      if dmMProvider.cdsParametros_NFEVERSAO_NFE.Value <= 2 then
      begin

        while not dmMProvider.cdsParcelasNFS.Eof do
        begin

          with Cobr.Dup.Add do
          begin

            nDup  := dmMProvider.cdsParcelasNFSDOCUMENTO.Value;
            dVenc := dmMProvider.cdsParcelasNFSVENCIMENTO.Value;
            vDup  := dmMProvider.cdsParcelasNFSVALOR.AsCurrency;

          end;

          dmMProvider.cdsParcelasNFS.Next;

        end;

      end;

      infNFe.ID     := InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value);

      if dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 1 then
        Ide.natOp     := 'NFe - Complementar'
      else if (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 2) and (dmMProvider.cdsNFSaidaCANCELAMENTO_ESTEMPORANEO.Value = 1) then
        Ide.natOp     := '999 - Estorno de NF-e n�o cancelada no prazo legal'
      else
        Ide.natOp     := Format('%-60.60s', [dmMProvider.cdsCFOP_NFSaidaDESCRICAO_CFOP.Value]);

      Ide.nNF       := StrToInt(infNFe.ID);
      Ide.cNF       := StrToInt(infNFe.ID);
      Ide.Modelo    := StrToInt(dmMProvider.cdsNFSaidaMODELO.AsString);
      Ide.serie     := StrToIntDef(Trim(dmMProvider.cdsNFSaidaSERIE.AsString),1);
      Ide.dEmi      := dmMProvider.cdsNFSaidaEMISSAO.Value;
      Ide.dSaiEnt   := now;

      sAno_Mes    := FormatDateTime('yyyymm',Date{Ide.dEmi});

      bDevolucao  := (dmmProvider.cdsCFOP_CFPSNATUREZA_CFOP.Value = 1);

      ide.finNFe  := StrToFinNFe(ok, FormatFloat('0', dmMProvider.cdsNFSaidaFINALIDADE_NF.Value + 1));

      if dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1 then
        ide.indFinal        := cfConsumidorFinaL
      else
        ide.indFinal        := cfNao;

      while not dmMProvider.cdsDocumentoRef_NFS.Eof do
      begin

        with ide.NFref.Add do
        begin

          if dmMProvider.cdsDocumentoRef_NFSMODELO_DOC_REF.Value = '55' then
            refNFe := dmMProvider.cdsDocumentoRef_NFSCHAVE_DOCUMENTO_REF.Value
          else if dmMProvider.cdsDocumentoRef_NFSMODELO_DOC_REF.Value = '04' then
          begin

            RefNFP.cUF          := dmMProvider.cdsDocumentoRef_NFSUF_DOCUMENTO_REF.Value;
            RefNFP.AAMM         := dmMProvider.cdsDocumentoRef_NFSANO_MES_EMISSAO.Value;
            RefNFP.CNPJCPF      := dmMProvider.cdsDocumentoRef_NFSCNPJ_FORNECEDOR_REF.Value;
            RefNFP.IE           := dmMProvider.cdsClientesINSCRICAO.AsString;
            RefNFP.modelo       := dmMProvider.cdsDocumentoRef_NFSMODELO_DOC_REF.Value;

            if dmMProvider.cdsDocumentoRef_NFSSERIE_DOC_REF.Value > 0 then
              RefNFP.serie      := dmMProvider.cdsDocumentoRef_NFSSERIE_DOC_REF.Value
            else
              RefNFP.serie      := 0;

            RefNFP.nNF          := StrToInt(dmMProvider.cdsDocumentoRef_NFSDOCUMENTO_REF.Value);

          end
          else
          begin

            RefNF.cUF          := dmMProvider.cdsDocumentoRef_NFSUF_DOCUMENTO_REF.Value;
            RefNF.AAMM         := dmMProvider.cdsDocumentoRef_NFSANO_MES_EMISSAO.Value;
            RefNF.CNPJ         := dmMProvider.cdsDocumentoRef_NFSCNPJ_FORNECEDOR_REF.Value;
            RefNF.modelo       := StrToInt(dmMProvider.cdsDocumentoRef_NFSMODELO_DOC_REF.Value);

            if dmMProvider.cdsDocumentoRef_NFSSERIE_DOC_REF.Value > 0 then
              RefNF.serie      := dmMProvider.cdsDocumentoRef_NFSSERIE_DOC_REF.Value
            else
              RefNF.serie      := 0;

            RefNF.nNF          := StrToInt(dmMProvider.cdsDocumentoRef_NFSDOCUMENTO_REF.Value);

          end;


        end;

        dmMProvider.cdsDocumentoRef_NFS.Next;

      end;

      //cupom fiscal
      while not dmMProvider.cdsCupomFiscalRefNFS.Eof do
      begin

        with ide.NFref.Add do
        begin

          with RefECF do
          begin

            modelo  := ECFModRef2D;
            nECF    := FormatFloat('000',dmMProvider.cdsCupomFiscalRefNFSSERIE_DOC_REF.Value);
            nCOO    := Trim(dmMProvider.cdsCupomFiscalRefNFSDOCUMENTO_REF.Value);

          end;

        end;

        dmMProvider.cdsCupomFiscalRefNFS.Next;

      end;

      case dmMProvider.cdsConfiguracoesAMBIENTE_NFE.Value of
        1:Ide.tpAmb := taProducao;
        2:Ide.tpAmb := taHomologacao;
      end;

      case dmMProvider.cdsNFSaidaENTRADA_SAIDA.Value of
        0:Ide.tpNF  := tnSaida;
        1:Ide.tpNF  := tnEntrada;
      end;

      if dmMProvider.cdsParcelasNFS.IsEmpty then
        Ide.indPag  := ipOutras
      else
        Ide.indPag  := ipPrazo;


      if dmMProvider.cdsParametros_NFEVERSAO_NFE.Value > 2 then
      begin

        with pag.Add do
        begin

          if not dmMProvider.cdsParcelasNFS.IsEmpty then
          begin

            tPag := StrToFormaPagamento(ok,'14'); //credito da loja

            while not dmMProvider.cdsParcelasNFS.Eof do
            begin

              with Cobr.Dup.Add do
              begin

                nDup  := dmMProvider.cdsParcelasNFSDOCUMENTO.Value;
                dVenc := dmMProvider.cdsParcelasNFSVENCIMENTO.Value;
                vDup  := dmMProvider.cdsParcelasNFSVALOR.AsCurrency;

              end;

              dmMProvider.cdsParcelasNFS.Next;

            end;

          end
          else
            tPag := StrToFormaPagamento(ok,'01');//dinheiro

          vPag := dmMProvider.cdsNFSaidaVALORDANOTA.Value;

        end;

      end;

      Ide.verProc             := PREFIXO_VERSAO + RetornarVersao(Application.ExeName, 1);
      Ide.cUF                 := dmMProvider.cdsFilialCODIGO_ESTADO_IBGE.Value;
      Ide.cMunFG              := dmMProvider.cdsFilialCODIGO_MUNICIPIO.Value;

      Emit.CNPJCPF            := dmMProvider.cdsFilialCNPJ.Value;
      Emit.IE                 := dmMProvider.cdsFilialINSCRICAO.Value;
      Emit.xNome              := dmMProvider.cdsFilialRAZAOSOCIAL.Value;
      Emit.xFant              := dmMProvider.cdsFilialFANTASIA.Value;

      if Length(Trim(dmMProvider.cdsFilialTELEFONE1.Value)) > 0 then
        Emit.EnderEmit.fone   := dmMProvider.cdsFilialDDD.Value + ' ' + dmMProvider.cdsFilialTELEFONE1.Value;

      Emit.EnderEmit.CEP      := StrToInt(dmMProvider.cdsFilialCEP.Value);
      Emit.EnderEmit.xLgr     := dmMProvider.cdsFilialENDERECO.Value;
      Emit.EnderEmit.nro      := InttoStr(dmMProvider.cdsFilialNUMERO.Value);
      Emit.EnderEmit.xCpl     := dmMProvider.cdsFilialCOMPLEMENTO.AsString;
      Emit.EnderEmit.xBairro  := dmMProvider.cdsFilialBAIRRO.Value;
      Emit.EnderEmit.cMun     := dmMProvider.cdsFilialCODIGO_MUNICIPIO.Value;
      Emit.EnderEmit.xMun     := dmMProvider.cdsFilialNOMECIDADE.Value;
      Emit.EnderEmit.UF       := dmMProvider.cdsFilialESTADO.Value;
      Emit.EnderEmit.cPais    := 1058;
      Emit.EnderEmit.xPais    := 'BRASIL';
      Emit.CRT                := StrToCRT(ok, InttoStr(dmMProvider.cdsFilialCRT.AsInteger));

      if dmMProvider.cdsConfiguracoesHABILITA_CONTAB_DOWNLOAD_XML.Value = 1 then
      begin

        with autXML.Add do
          CNPJCPF := dmMProvider.cdsConfiguracoesCNPJ_CONTADOR.Value;

      end;

      Dest.EnderDest.CEP      := StrToIntDef(dmMProvider.cdsClientesCEPENTREGA.AsString, 0);
      Dest.EnderDest.xLgr     := dmMProvider.cdsClientesENDERECOENTREGA.AsString;

      if dmMProvider.cdsClientesNUMEROENTREGA.AsInteger > 0 then
        Dest.EnderDest.nro    := InttoStr(dmMProvider.cdsClientesNUMEROENTREGA.Value)
      else
        Dest.EnderDest.nro    := 'S/N';

      Dest.EnderDest.xCpl     := dmMProvider.cdsClientesCOMPLEMENTO.AsString;
      Dest.EnderDest.xBairro  := dmMProvider.cdsClientesBAIRROENTREGA.AsString;
      Dest.EnderDest.cMun     := dmMProvider.cdsClientesCODIGO_MUNICIPIO.AsInteger;
      Dest.EnderDest.xMun     := dmMProvider.cdsClientesNOME_CIDADE_ENTREGA.AsString;
      Dest.EnderDest.UF       := dmMProvider.cdsClientesESTADOENTREGA.AsString;

      dmMProvider.cdsEstados.Close;
      dmMProvider.cdsEstados.ProviderName := 'dspEstados';

      dmDBEXMaster.fdqEstados.SQL.Clear;
      dmDBEXMaster.fdqEstados.SQL.Add('SELECT * FROM ESTADOS');
      dmDBEXMaster.fdqEstados.SQL.Add('WHERE SIGLA = ' + QuotedStr(Dest.EnderDest.UF));

      dmMProvider.cdsEstados.Open;
      dmMProvider.cdsEstados.ProviderName := '';

      if Length(Trim(dmMProvider.cdsClientesTELEFONE1.AsString)) > 0 then
        Dest.EnderDest.fone   := dmMProvider.cdsClientesDDD.AsString + ' ' + dmMProvider.cdsClientesTELEFONE1.AsString;

      case dmMProvider.cdsConfiguracoesAMBIENTE_NFE.Value of
        1:begin

            if Dest.EnderDest.xPais <> 'EXTERIOR' then
            begin

              Dest.CNPJCPF        := dmMProvider.cdsClientesCNPJ.Value;
              Dest.indIEDest      := StrToindIEDest(ok,IntToStr(dmMProvider.cdsNFSaidaINDICADOR_IE_DESTINATARIO.Value));// inContribuinte;

              if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (Dest.EnderDest.UF <> dmMProvider.cdsFilialESTADO.Value)then
                Dest.IE             := ''
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF = ve310 ) then
                Dest.IE             := ''
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF <> ve310 ) then
                Dest.IE             := ''
              else
                Dest.IE             := dmMProvider.cdsClientesINSCRICAO.AsString;

{              if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (Dest.EnderDest.UF <> dmMProvider.cdsFilialESTADO.Value)then
              begin

                Dest.IE             := '';
                Dest.indIEDest      := inNaoContribuinte;

              end
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF = ve310 ) then
              begin

                Dest.IE             := '';
                Dest.indIEDest      := inIsento;

              end
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF <> ve310 ) then
              begin

                Dest.IE             := '';
                Dest.indIEDest      := inIsento;

              end
              else
                Dest.IE             := dmMProvider.cdsClientesINSCRICAO.AsString;
              }

              Dest.xNome          := dmMProvider.cdsClientesRAZAOSOCIAL.AsString;

{              if Length(Trim(dmMProvider.cdsClientesCNPJ.Value)) <= 11 then
                Dest.indIEDest      := inNaoContribuinte;
}
            end;

          end;
        2:begin

            if Dest.EnderDest.xPais <> 'EXTERIOR' then
            begin

              Dest.CNPJCPF        := dmMProvider.cdsClientesCNPJ.Value;
              Dest.indIEDest      := StrToindIEDest(ok,IntToStr(dmMProvider.cdsNFSaidaINDICADOR_IE_DESTINATARIO.Value));// inContribuinte;

              if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (Dest.EnderDest.UF <> dmMProvider.cdsFilialESTADO.Value)then
                Dest.IE             := ''
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF = ve310 ) then
                Dest.IE             := ''
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF <> ve310 ) then
                Dest.IE             := ''
              else
                Dest.IE             := dmMProvider.cdsClientesINSCRICAO.AsString;

{              Dest.CNPJCPF        := dmMProvider.cdsClientesCNPJ.Value;
              Dest.indIEDest      := inContribuinte;

              if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (Dest.EnderDest.UF <> dmMProvider.cdsFilialESTADO.Value)then
              begin

                Dest.IE             := '';
                Dest.indIEDest      := inNaoContribuinte;

              end
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF = ve310 ) then
              if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF = ve310 ) then
              begin

                Dest.IE             := '';
                Dest.indIEDest      := inIsento;

              end
              else if (UpperCase(dmMProvider.cdsClientesINSCRICAO.AsString) = 'ISENTO') and (ACBrNFe1.Configuracoes.Geral.VersaoDF <> ve310 ) then
              begin

                Dest.IE             := '';
                Dest.indIEDest      := inIsento;

              end
              else
                Dest.IE             := dmMProvider.cdsClientesINSCRICAO.AsString;
}
{              if Length(Trim(dmMProvider.cdsClientesCNPJ.Value)) <= 11 then
                Dest.indIEDest      := inNaoContribuinte;
}
              Dest.xNome          := 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO � SEM VALOR FISCAL';

            end;

          end;
      end;

      bNContribuinte := (Dest.indIEDest = inNaoContribuinte);

      case dmMProvider.cdsNFSaidaDESTINO_OPERACAO.Value of
        1:begin //interna

            Dest.EnderDest.xPais  := 'BRASIL';
            ide.idDest            := doInterna

          end;
        2:begin //interestadual

            Dest.EnderDest.xPais  := 'BRASIL';
            ide.idDest            := doInterestadual;

          end;
        3:begin //exterior

            Dest.CNPJCPF          := '00000000000000';
            Dest.EnderDest.UF     := 'EX';
            Dest.EnderDest.xPais  := 'EXTERIOR';
            ide.idDest            := doExterior;
            Dest.indIEDest        := inNaoContribuinte;
            Dest.idEstrangeiro    := '';
            Retirada.CNPJCPF      := '';
            Retirada.xLgr         := '';
            Retirada.nro          := '';
            Retirada.xCpl         := '';
            Retirada.xBairro      := '';
            Retirada.cMun         := 9999999;
            Retirada.xMun         := '';
            Retirada.UF           := '';
            if Length(Trim(dmMProvider.cdsNFSaidaLOCAL_EMBARQUE.Value)) > 0 then
              exporta.UFembarq    := dmMProvider.cdsFilialESTADO.AsString;

            exporta.xLocEmbarq    := dmMProvider.cdsNFSaidaLOCAL_EMBARQUE.Value;

            if Length(Trim(dmMProvider.cdsNFSaidaLOCAL_EMBARQUE.Value)) > 0 then
              exporta.UFSaidaPais := dmMProvider.cdsFilialESTADO.AsString;

            exporta.xLocExporta   := dmMProvider.cdsNFSaidaLOCAL_EMBARQUE.Value;
            exporta.xLocDespacho  := dmMProvider.cdsNFSaidaLOCAL_DESPACHO.Value;

          end;

      end;

      Dest.EnderDest.cPais := dmMProvider.cdsClientesPAIS.AsInteger;

      AbrirTabelaTransportadora;

      if not dmMProvider.cdsTransportadoraNFS.IsEmpty then
      begin

        case dmMProvider.cdsNFSaidaTIPOFRETE.Value of
          0: Transp.modFrete := mfContaEmitente;
          1: Transp.modFrete := mfContaDestinatario;
          2: Transp.modFrete := mfContaTerceiros;
          9: Transp.modFrete := mfSemFrete;
        end;

        Transp.Transporta.CNPJCPF := dmMProvider.cdsTransportadoraNFSCNPJ.AsString;
        Transp.Transporta.xNome   := dmMProvider.cdsTransportadoraNFSRSOCIAL.AsString;
        Transp.Transporta.IE      := dmMProvider.cdsTransportadoraNFSINSCRICAO_EST.AsString;
        Transp.Transporta.xEnder  := dmMProvider.cdsTransportadoraNFSENDERECO.AsString;
        Transp.Transporta.xMun    := dmMProvider.cdsTransportadoraNFSNOME_CIDADE_TRANSP.AsString;
        Transp.Transporta.UF      := dmMProvider.cdsTransportadoraNFSESTADO.AsString;
        Transp.veicTransp.placa   := dmMProvider.cdsTransportadoraNFSPLACA.AsString;
        Transp.veicTransp.UF      := dmMProvider.cdsTransportadoraNFSUF.AsString;

      end
      else
      begin

        case dmMProvider.cdsNFSaidaTIPOFRETE.Value of
          0: Transp.modFrete := mfContaEmitente;
          1: Transp.modFrete := mfContaDestinatario;
          2: Transp.modFrete := mfContaTerceiros;
          9: Transp.modFrete := mfSemFrete;
        end;

      end;

      with Transp.Vol.Add do
      begin

        qVol  := dmMProvider.cdsNFSaidaQUANTIDADEVOLUME.AsInteger;
        esp   := dmMProvider.cdsNFSaidaESPECIEVOLUME.AsString;
        marca := dmMProvider.cdsNFSaidaMARCAVOLUME.AsString;
        pesoL := dmMProvider.cdsNFSaidaPESOLIQUIDO.AsCurrency;
        pesoB := dmMProvider.cdsNFSaidaPESOBRUTO.AsCurrency;

      end;

      dmMProvider.cdsItemNFSaida.First;

      if dmMProvider.cdsNFSaidaDESCONTO_ST.AsCurrency > 0 then
        pPerc_Desc_Rat := ((dmMProvider.cdsNFSaidaDESCONTO_ST.AsCurrency / dmMProvider.cdsNFSaidaVALORDOSPRODUTOS.AsCurrency) * 100);

      while not dmMProvider.cdsItemNFSaida.Eof do
      begin

        with Det.Add do
        begin

          Prod.nItem  := dmMProvider.cdsItemNFSaida.RecNo;
          Prod.NCM    := dmMProvider.cdsItemNFSaidaCF_IPI.Value;
          Prod.CFOP   := dmMProvider.cdsItemNFSaidaCFOP.Value;

          if (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 0) or (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 3) then
            Prod.IndTot :=  StrToindTot(ok, '1')
          else
            prod.IndTot := itNaoSomaTotalNFe;

          if dmMProvider.cdsBarrasGERADO.Value = 0 then
          begin

            while not dmMProvider.cdsBarras.Eof do
            begin

              if ValidaEAN(dmMProvider.cdsBarrasBARRAS.Value) then
              begin

                Prod.cEAN     := dmMProvider.cdsItemNFSaidaEAN.Value;
                prod.cEANTrib := dmMProvider.cdsItemNFSaidaEAN_TRIBUTAVEL.Value;

              end
              else
                dmMProvider.cdsBarras.Next;

            end;

          end
          else
          begin

            Prod.cEAN     := '';
            prod.cEANTrib := '';

          end;

          Prod.cProd      := InttoStr(dmMProvider.cdsItemNFSaidaPRODUTO.Value);
          Prod.xProd      := dmMProvider.cdsItemNFSaidaDESCRICAO_PRODUTO.Value;
          Prod.qCom       := dmMProvider.cdsItemNFSaidaQUANTIDADE.AsCurrency;
          Prod.uCom       := dmMProvider.cdsItemNFSaidaUNIDADE.Value;

          if Length(Trim(dmMProvider.cdsItemNFSaidaCEST.AsString)) > 0 then
            Prod.CEST       := dmMProvider.cdsItemNFSaidaCEST.AsString
          else
            Prod.CEST       := '0000000';

          if dmMProvider.cdsNFSaidaVALORDOFRETE.AsCurrency > 0 then
          begin

            pFrete      := (dmMProvider.cdsNFSaidaVALORDOFRETE.AsCurrency / dmMProvider.cdsNFSaidaVALORDOSPRODUTOS.AsCurrency) * 100;
            v_Frete     := dmMProvider.cdsItemNFSaidaSUB_TOTAL.AsCurrency *( pFrete / 100);
            Prod.vFrete := v_Frete;

          end
          else
            Prod.vFrete     := 0;

          Prod.vSeg       := 0;

          dmDBEXMaster.fdqMasterPesquisa.Close;
          dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
          dmDBEXMaster.fdqMasterPesquisa.SQL.Add('select codigo_anp from produto');
          dmDBEXMaster.fdqMasterPesquisa.SQL.Add('where produto = ' + IntToStr(dmMProvider.cdsItemNFSaidaPRODUTO.Value));
          dmDBEXMaster.fdqMasterPesquisa.SQL.Add('and codigo_anp is not null');
          dmDBEXMaster.fdqMasterPesquisa.SQL.Add(' and ativo = 1 and visibilidade = 1');
          dmDBEXMaster.fdqMasterPesquisa.Open;

          if not dmDBEXMaster.fdqMasterPesquisa.IsEmpty then
          begin

            if Length(Trim(dmDBEXMaster.fdqMasterPesquisa.FieldByName('CODIGO_ANP').AsString)) > 0 then
            begin

              with prod.comb do
              begin

                cProdANP  := StrToInt(Trim(dmDBEXMaster.fdqMasterPesquisa.FieldByName('CODIGO_ANP').AsString));
                UFcons    := dmMProvider.cdsNFSaidaUF_DEST.AsString;

              end;

            end;

          end;

          Prod.vDesc      := dmMProvider.cdsItemNFSaidaVALOR_DESCONTO.AsCurrency;
          Prod.vUnCom     := dmMProvider.cdsItemNFSaidaVALORUNITARIO.AsFloat;
          Prod.vProd      := dmMProvider.cdsItemNFSaidaSUB_TOTAL.AsCurrency;
          Prod.qTrib      := dmMProvider.cdsItemNFSaidaQUANTIDADE.AsCurrency;
          Prod.uTrib      := dmMProvider.cdsItemNFSaidaUNIDADE.Value;
          Prod.vUnTrib    := dmMProvider.cdsItemNFSaidaVALORUNITARIO.AsFloat;

          if (dmMProvider.cdsFilialCRT.AsInteger = 1) and (dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency > 0) then
            PROD.vOutro     := dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency
          else if dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency > 0 then
            PROD.vOutro     := dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency;

          if dmMProvider.cdsItemNFSaidaORIGEM_MERCADORIA.Value <> 0 then
          begin

            cTributosFederais     := dmMProvider.cdsItemNFSaidaVALOR_CARGA_IMP_FEDERAL.AsCurrency;
            cPercentualTribFederal:= dmMProvider.cdsItemNFSaidaCARGA_IMP_FEDERAL.AsCurrency;

          end
          else
          begin

            cTributosFederais     := dmMProvider.cdsItemNFSaidaVALOR_CARGA_NAC_FEDERAL.AsCurrency;
            cPercentualTribFederal:= dmMProvider.cdsItemNFSaidaCARGA_NAC_FEDERAL.AsCurrency;

          end;

          Prod.xPed     := dmMProvider.cdsItemNFSaidaPEDIDO_DE_COMPRA.Value;

          if dmMProvider.cdsItemNFSaidaNUMERO_ITEM_EDIDO_COMPRA.Value > 0 then
            Prod.nItemPed := IntToStr(dmMProvider.cdsItemNFSaidaNUMERO_ITEM_EDIDO_COMPRA.Value);

          {

          Preciso calcular o imposto nas remessas para industrializa��o, amostras gr�tis, mat�ria prima entre outras?

          N�o, o c�lculo e demonstra��o do valor do imposto deve ser feito somente para vendas a consumidor final.
          Considera-se tamb�m venda a consumidor final a venda de mercadorias para uso e consumo e ativo imobilizado.


          Fonte: IBPT - Manual da IBPT

          }

          if dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1 then
            infAdProd := 'Trib. aprox. Fed R$ ' + FormatFloat('##0.00', cTributosFederais)+'('+FormatFloat('#0.00',cPercentualTribFederal)+'%)'
                          + ' Est R$ ' + FormatFloat('##0.00', dmMProvider.cdsItemNFSaidaVALOR_CARGA_ESTADUAL.AsCurrency)+'('+FormatFloat('#0.00',dmMProvider.cdsItemNFSaidaCARGA_ESTADUAL.AsCurrency)+'%)'
                          + ' Mun R$ ' + FormatFloat('##0.00', dmMProvider.cdsItemNFSaidaVALOR_CARGA_MUNICIPAL.AsCurrency)+'('+FormatFloat('#0.00',dmMProvider.cdsItemNFSaidaCARGA_MUNICIPAL.AsCurrency)+'%)'
                          + ' FONTE ' + dmMProvider.cdsItemNFSaidaFONTE_CARGA_TRIBUTARIA.AsString + ' ' + dmMProvider.cdsItemNFSaidaASSINATURA_IBPT.AsString;


          with Imposto do
          begin

            with ICMS do
            begin

              if dmMProvider.cdsClientesPAIS.Value = dmMProvider.cdsFilialPAIS.Value then
              begin

                if dmMProvider.cdsFilialCRT.AsInteger <> 1 then
                begin

                  ICMS.CST        := StrToCSTICMS(ok, Copy(FormatFloat('000', dmMProvider.cdsItemNFSaidaCST.Value),2,2));
                  ICMS.modBC      := dbiValorOperacao;
                  ICMS.orig       := StrToOrig(ok,IntToStr(dmMProvider.cdsItemNFSaidaORIGEM_MERCADORIA.AsInteger));
                  ICMS.pICMS      := dmMProvider.cdsItemNFSaidaICMS.AsCurrency;
                  ICMS.vBC        := dmMProvider.cdsItemNFSaidaBASE_ICMS.AsCurrency;
                  ICMS.vICMS      := dmMProvider.cdsItemNFSaidaVALOR_ICMS.AsCurrency;
                  ICMS.modBCST    := dbisMargemValorAgregado;
                  ICMS.pMVAST     := dmMProvider.cdsEstadosMVA.AsCurrency;
                  ICMS.vBCST      := dmMProvider.cdsItemNFSaidaBASE_SUBSTITUICAO.AsCurrency;
                  ICMS.vBCSTRet   := dmMProvider.cdsItemNFSaidaBASE_SUBSTITUICAO.AsCurrency;
                  ICMS.vICMSST    := dmMProvider.cdsItemNFSaidaVALOR_SUBSTITUICAO.AsCurrency;
                  ICMS.vICMSSTRet := dmMProvider.cdsItemNFSaidaVALOR_SUBSTITUICAO.AsCurrency;

                end
                else
                begin

                  ICMS.CSOSN      := StrToCSOSNIcms(ok, FormatFloat('000', dmMProvider.cdsItemNFSaidaCST.Value));
                  ICMS.modBC      := dbiValorOperacao;
                  ICMS.orig       := StrToOrig(ok,IntToStr(dmMProvider.cdsItemNFSaidaORIGEM_MERCADORIA.AsInteger));
                  ICMS.pICMS      := dmMProvider.cdsItemNFSaidaICMS.AsCurrency;
                  ICMS.vBC        := dmMProvider.cdsItemNFSaidaBASE_ICMS.AsCurrency;
                  ICMS.vICMS      := dmMProvider.cdsItemNFSaidaVALOR_ICMS.AsCurrency;
                  ICMS.modBCST    := dbisMargemValorAgregado;
                  ICMS.pMVAST     := dmMProvider.cdsEstadosMVA.AsCurrency;
                  ICMS.vBCST      := dmMProvider.cdsItemNFSaidaBASE_SUBSTITUICAO.AsCurrency;
                  ICMS.vBCSTRet   := dmMProvider.cdsItemNFSaidaBASE_SUBSTITUICAO.AsCurrency;
                  ICMS.vICMSST    := dmMProvider.cdsItemNFSaidaVALOR_SUBSTITUICAO.AsCurrency;
                  ICMS.vICMSSTRet := dmMProvider.cdsItemNFSaidaVALOR_SUBSTITUICAO. AsCurrency;

                end;

              end
              else
              begin

                CST   := cst41;
                modBC := dbiValorOperacao;
                orig  := StrToOrig(ok,IntToStr(dmMProvider.cdsItemNFSaidaORIGEM_MERCADORIA.AsInteger));
                pICMS := dmMProvider.cdsItemNFSaidaICMS.AsCurrency;
                vICMS := dmMProvider.cdsItemNFSaidaVALOR_ICMS.AsCurrency;
                vBC   := dmMProvider.cdsItemNFSaidaBASE_ICMS.AsCurrency;

              end;


            end;

            with ICMSUFDest do
            begin

              if (dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1) and (dmMProvider.cdsNFSaidaDESTINO_OPERACAO.Value = 2) then
              begin

                vBCUFDest         := dmMProvider.cdsItemNFSaidaBASE_ICMS.Value;
                pFCPUFDest        := dmMProvider.cdsItemNFSaidaPERC_FCP.Value;
                pICMSUFDest       := dmMProvider.cdsItemNFSaidaALIQUOTA_ICMS_INTERNA_DESTINO.Value;
                pICMSInter        := dmMProvider.cdsItemNFSaidaALIQUOTA_ICMS_INTERESTADUAL.Value;
                pICMSInterPart    := dmMProvider.cdsItemNFSaidaPERC_ICMS_PARTILHA_DESTINO.Value;
                vFCPUFDest        := dmMProvider.cdsItemNFSaidaVALOR_FCP_DESTINO.Value;
                vICMSUFDest       := dmMProvider.cdsItemNFSaidaVALOR_ICMS_PARTILHA_DESTINO.Value;
                vICMSUFRemet      := dmMProvider.cdsItemNFSaidaVALOR_ICMS_PARTILHA_ORIGEM.Value;

                if bNContribuinte then
                begin

                  vlBCUFDest        := vlBCUFDest + vBCUFDest;
                  percFCPUFDest     := pFCPUFDest;
                  percICMSUFDest    := pICMSUFDest;
                  percICMSInter     := pICMSInter;
                  percICMSInterPart := pICMSInterPart;
                  vlFCPUFDest       := vlFCPUFDest + vFCPUFDest;
                  vlICMSUFDest      := vlICMSUFDest + vICMSUFDest;
                  vlICMSUFRemet     := vlICMSUFRemet + vICMSUFRemet;

                end
                else
                begin

                  vBCUFDest       := 0;
                  pFCPUFDest      := 0;
                  pICMSUFDest     := 0;
                  pICMSInter      := 0;
                  pICMSInterPart  := 0;
                  vFCPUFDest      := 0;
                  vICMSUFDest     := 0;
                  vICMSUFRemet    := 0;

                end;

              end
              else
              begin

                vBCUFDest       := 0;
                pFCPUFDest      := 0;
                pICMSUFDest     := 0;
                pICMSInter      := 0;
                pICMSInterPart  := 0;
                vFCPUFDest      := 0;
                vICMSUFDest     := 0;
                vICMSUFRemet    := 0;

              end;

            end;

            if (dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1) and not (bDevolucao) and (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 0) or (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 2) then
//            if (dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1) and (not bDevolucao) then
              vTotTrib := dmMProvider.cdsItemNFSaidaVALOR_CARGA_NAC_FEDERAL.AsCurrency +
                          dmMProvider.cdsItemNFSaidaVALOR_CARGA_IMP_FEDERAL.AsCurrency +
                          dmMProvider.cdsItemNFSaidaVALOR_CARGA_ESTADUAL.AsCurrency +
                          dmMProvider.cdsItemNFSaidaVALOR_CARGA_MUNICIPAL.AsCurrency;

            if dmMProvider.cdsItemNFSaidaIPI.AsCurrency > 0 then
            begin

              with IPI do
              begin

  // 05/03/2016             CST       := ipi50;
                CST       := StrToCSTIPI(ok, dmMProvider.cdsItemNFSaidaCST_IPI.AsString);
  // 05/03/2016             clEnq     := '999';
                clEnq     := dmMProvider.cdsItemNFSaidaCOD_ENQUADRAMENTO.AsString;
                CNPJProd  := '';
                cSelo     := '';
                qSelo     := 0;
                cEnq      := '';
                IPI.vBC   := dmMProvider.cdsItemNFSaidaSUB_TOTAL.AsCurrency;
                IPI.vUnid := 0;//dmMProvider.cdsItem_NFSaidaVALORUNITARIO.AsCurrency;
                IPI.qUnid := 0;//dmMProvider.cdsItem_NFSaidaQUANTIDADE.AsCurrency;
                IPI.pIPI  := dmMProvider.cdsItemNFSaidaIPI.AsCurrency;
                IPI.vIPI  := SimpleRoundTo(dmMProvider.cdsItemNFSaidaSUB_TOTAL.AsCurrency *(dmMProvider.cdsItemNFSaidaIPI.AsCurrency / 100),-2);
                pIpi      := dmMProvider.cdsItemNFSaidaIPI.AsCurrency;

              end;

            end;

            with PIS do
            begin

              CST       := StrToCSTPIS(ok, FormatFloat('00',dmMProvider.cdsItemNFSaidaCST_PIS.Value));
              vBC       := dmMProvider.cdsItemNFSaidaBASE_PIS.AsCurrency;
              pPIS      := dmMProvider.cdsItemNFSaidaP_ALIQUOTA_PIS.AsCurrency;
              vPIS      := dmMProvider.cdsItemNFSaidaVALOR_PIS.AsCurrency;
              qBCProd   := 0;//dmMProvider.cdsItem_NFSaidaBASE_PIS.AsCurrency;
              vAliqProd := 0;//dmMProvider.cdsItem_NFSaidaVALOR_PIS.AsCurrency;

            end;

            with COFINS do
            begin

              CST       := StrToCSTCOFINS(ok, FormatFloat('00',dmMProvider.cdsItemNFSaidaCST_COFINS.Value));
              vBC       := dmMProvider.cdsItemNFSaidaVALOR_BC_COFINS.AsCurrency;
              pCOFINS   := dmMProvider.cdsItemNFSaidaP_ALIQUOTA_COFINS.AsCurrency;
              vCOFINS   := dmMProvider.cdsItemNFSaidaVALOR_COFINS.AsCurrency;
              qBCProd   := 0;//dmMProvider.cdsItem_NFSaidaVALOR_BC_COFINS.AsCurrency;
              vAliqProd := 0;//dmMProvider.cdsItem_NFSaidaVALOR_COFINS.AsCurrency;

            end;

          end;

        end;

        dmMProvider.cdsItemNFSaida.Next;

      end;

      if (dmMProvider.cdsItemNFSaida.IsEmpty) and (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 1) then
      begin

        with det.Add do
        begin

          Prod.nItem    := 1;
          Prod.CFOP     := dmMProvider.cdsCfop_NFSaida.FieldByName('CFOP').Value;
          Prod.IndTot   := itNaoSomaTotalNFe;
          Prod.cEAN     := '';
          prod.cEANTrib := '';
          Prod.cProd    := 'CFOP'+Prod.CFOP;

          if (dmMProvider.cdsNFSaidaVALORSUBSTITUICAO.AsCurrency > 0) and (dmMProvider.cdsNFSaidaVALORDOIPI.AsCurrency > 0) then
            Prod.xProd    :='COMPLEMENTO DE ICMS-ST/IPI'
          else if dmMProvider.cdsNFSaidaVALORSUBSTITUICAO.AsCurrency > 0 then
            Prod.xProd    :='COMPLEMENTO DE ICMS-ST'
          else if dmMProvider.cdsNFSaidaVALORICMS.AsCurrency > 0 then
            Prod.xProd    :='COMPLEMENTO DE ICMS'
          else if dmMProvider.cdsNFSaidaVALORDOIPI.AsCurrency > 0 then
            Prod.xProd    :='COMPLEMENTO DE IPI'
          else if (dmMProvider.cdsFilialCRT.AsInteger = 1) and  (dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency > 0 )then
          begin

            Prod.xProd    :='COMPLEMENTO DE IPI';
            PROD.vOutro   := dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency;

          end;

          Prod.IndTot   := itNaoSomaTotalNFe;
          Prod.uCom     := 'R$';
          Prod.uTrib    := 'R$';
          Prod.qCom     := 0;
          Prod.qTrib    := 0;
          Prod.vUnCom   := 0;
          Prod.vUnTrib  := 0;
          Prod.vProd    := 0;
          Prod.NCM      := '10011900';

          with Imposto do
          begin

            with ICMSUFDest do
            begin

              vBCUFDest       := 0;
              pFCPUFDest      := 0;
              pICMSUFDest     := 0;
              pICMSInter      := 0;
              pICMSInterPart  := 0;
              vFCPUFDest      := 0;
              vICMSUFDest     := 0;
              vICMSUFRemet    := 0;

            end;

            with ICMS do
            begin

              if dmMProvider.cdsClientesPAIS.Value = dmMProvider.cdsFilialPAIS.Value then
              begin

                if dmMProvider.cdsFilialCRT.AsInteger <> 1 then
                begin

                  if dmMProvider.cdsNFSaidaVALORSUBSTITUICAO.AsCurrency > 0 then
                    ICMS.CST      := StrToCSTICMS(ok, FormatFloat('00', 70))
                  else
                    ICMS.CST      := StrToCSTICMS(ok, FormatFloat('00', 0));

                  ICMS.modBC      := dbiValorOperacao;
                  ICMS.orig       := oeNacional;

                  if dmMProvider.cdsNFSaidaVALORICMS.AsCurrency > 0 then
                    ICMS.pICMS    := TruncVal((dmMProvider.cdsNFSaidaVALORICMS.AsCurrency / (dmMProvider.cdsNFSaidaBASECALCULOICMS.AsCurrency/100)),2)
                  else
                    ICMS.pICMS    := 0;

                  ICMS.vBC        := dmMProvider.cdsNFSaidaBASECALCULOICMS.AsCurrency;
                  ICMS.vICMS      := dmMProvider.cdsNFSaidaVALORICMS.AsCurrency;
                  ICMS.modBCST    := dbisPrecoTabelado;
                  ICMS.pMVAST     := dmMProvider.cdsEstadosMVA.AsCurrency;
                  ICMS.vBCST      := dmMProvider.cdsNFSaidaBASESUBSTITUICAO.AsCurrency;
                  ICMS.vBCSTRet   := dmMProvider.cdsNFSaidaBASESUBSTITUICAO.AsCurrency;
                  ICMS.vICMSST    := dmMProvider.cdsNFSaidaVALORSUBSTITUICAO.AsCurrency;
                  ICMS.vICMSSTRet := dmMProvider.cdsNFSaidaVALORSUBSTITUICAO.AsCurrency;

                end
                else if dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 1  then
                begin

                  ICMS.CSOSN      := StrToCSOSNIcms(ok, FormatFloat('000', 900));
                  ICMS.modBC      := dbiValorOperacao;
                  ICMS.orig       := oeNacional;

                  if dmMProvider.cdsNFSaidaVALORICMS.AsCurrency > 0 then
                    ICMS.pICMS    := TruncVal((dmMProvider.cdsNFSaidaVALORICMS.AsCurrency / (dmMProvider.cdsNFSaidaBASECALCULOICMS.AsCurrency/100)),2)
                  else
                    ICMS.pICMS    := 0;

                  ICMS.vBC        := dmMProvider.cdsNFSaidaBASECALCULOICMS.AsCurrency;
                  ICMS.vICMS      := dmMProvider.cdsNFSaidaVALORICMS.AsCurrency;
                  ICMS.modBCST    := dbisMargemValorAgregado;
                  ICMS.pMVAST     := 0;
                  ICMS.vBCST      := 0;
                  ICMS.vBCSTRet   := 0;
                  ICMS.vICMSST    := 0;
                  ICMS.vICMSSTRet := 0;

                end
                else
                begin

                  ICMS.CSOSN      := StrToCSOSNIcms(ok, FormatFloat('000', 900));
                  ICMS.modBC      := dbiValorOperacao;
                  ICMS.orig       := oeNacional;
                  ICMS.pICMS      := 0;
                  ICMS.vBC        := 0;
                  ICMS.vICMS      := 0;
                  ICMS.modBCST    := dbisMargemValorAgregado;
                  ICMS.pMVAST     := 0;
                  ICMS.vBCST      := 0;
                  ICMS.vBCSTRet   := 0;
                  ICMS.vICMSST    := 0;
                  ICMS.vICMSSTRet := 0;

                end;


              end
              else
              begin

              end;

            end;

            if dmMProvider.cdsNFSaidaVALORDOIPI.AsCurrency > 0 then
            begin

              with IPI do
              begin

  //              CST       := ipi00;
                CST       := StrToCSTIPI(ok, dmMProvider.cdsItemNFSaidaCST_IPI.AsString);
  //              clEnq     := '999';
                clEnq     := dmMProvider.cdsItemNFSaidaCOD_ENQUADRAMENTO.AsString;

                CNPJProd  := '';
                cSelo     := '';
                qSelo     := 0;
                cEnq      := '';
                IPI.vBC   := 0;
                IPI.vUnid := 0;
                IPI.qUnid := 0;
                IPI.pIPI  := 0;
                IPI.vIPI  := dmMProvider.cdsNFSaidaVALORDOIPI.AsCurrency;

              end;

            end;

          end;

        end;

      end;

      if (dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1) and not (bDevolucao) and (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 0) or (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value = 2) then
        Total.ICMSTot.vTotTrib := dmMProvider.cdsNFSaidaVALOR_CARGA_NAC_FEDERAL.AsCurrency +
                                  dmMProvider.cdsNFSaidaVALOR_CARGA_IMP_FEDERAL.AsCurrency +
                                  dmMProvider.cdsNFSaidaVALOR_CARGA_ESTADUAL.AsCurrency +
                                  dmMProvider.cdsNFSaidaVALOR_CARGA_MUNICIPAL.AsCurrency;

      Total.ICMSTot.vBC           := dmMProvider.cdsNFSaidaBASECALCULOICMS.AsCurrency;
      Total.ICMSTot.vICMS         := dmMProvider.cdsNFSaidaVALORICMS.AsCurrency;
      Total.ICMSTot.vNF           := dmMProvider.cdsNFSaidaVALORDANOTA.AsCurrency;
      Total.ICMSTot.vProd         := dmMProvider.cdsNFSaidaVALORDOSPRODUTOS.AsCurrency;
      Total.ICMSTot.vFrete        := dmMProvider.cdsNFSaidaVALORDOFRETE.AsCurrency;
      Total.ICMSTot.vBCST         := dmMProvider.cdsNFSaidaBASESUBSTITUICAO.AsCurrency;
      Total.ICMSTot.vCOFINS       := dmMProvider.cdsNFSaidaVALOR_COFINS.AsCurrency;
      Total.ICMSTot.vPIS          := dmMProvider.cdsNFSaidaVALOR_PIS.AsCurrency;
      Total.ICMSTot.vST           := dmMProvider.cdsNFSaidaVALORSUBSTITUICAO.AsCurrency;
      Total.ICMSTot.vSeg          := dmMProvider.cdsNFSaidaVALORDOSEGURO.AsCurrency;
      Total.ICMSTot.vDesc         := dmMProvider.cdsNFSaidaDESCONTO_ST.AsCurrency;
      Total.ICMSTot.vIPI          := dmMProvider.cdsNFSaidaVALORDOIPI.AsCurrency;
      Total.ICMSTot.vOutro        := dmMProvider.cdsNFSaidaOUTRASDESPESAS.AsCurrency;
      InfAdic.infCpl              := Trim(dmMProvider.cdsNFSaidaOBSERVACAO.AsString);
      InfAdic.infAdFisco          := Trim(dmMProvider.cdsNFSaidaINFO_FISCO.AsString);

      Total.ICMSTot.vFCPUFDest    := 0;
      Total.ICMSTot.vICMSUFDest   := 0;
      Total.ICMSTot.vICMSUFRemet  := 0;

      if bNContribuinte then
      begin

        Total.ICMSTot.vFCPUFDest    := vlFCPUFDest;
        Total.ICMSTot.vICMSUFDest   := vlICMSUFDest;
        Total.ICMSTot.vICMSUFRemet  := vlICMSUFRemet;

        if vlICMSUFDest > 0 then
        begin

          InfAdic.infAdFisco          := dmMProvider.cdsNFSaidaINFO_FISCO.AsString
                                         + ' Valores totais do ICMS Interestadual: DIFAL da UF destino R$' + FormatFloat('#,##0.00',vlICMSUFDest)
                                         + ' DIFAL da UF Origem R$ ' + FormatFloat('#,##0.00',vlICMSUFRemet)

        end;

        if vlFCPUFDest > 0 then
          InfAdic.infAdFisco          := InfAdic.infAdFisco + ' FCP R$ ' + FormatFloat('#,##0.00',vlFCPUFDest);

      end;

      cTributosFederais           := dmMProvider.cdsNFSaidaVALOR_CARGA_NAC_FEDERAL.AsCurrency + dmMProvider.cdsNFSaidaVALOR_CARGA_IMP_FEDERAL.AsCurrency;

      if (dmMProvider.cdsNFSaidaCONSUMIDOR_FINAL.Value = 1) and not (bDevolucao) and (dmMProvider.cdsNFSaidaFINALIDADE_NF.Value <> 2) then

        InfAdic.infCpl := InfAdic.infCpl
                          + ' Trib. aprox. Fed R$ ' + FormatFloat('##0.00', cTributosFederais) + '(' + FormatFloat('#0.00',((cTributosFederais / dmMProvider.cdsNFSaidaVALORDANOTA.AsCurrency)*100)) + '%)'
                          + ' Est R$ ' + FormatFloat('##0.00', dmMProvider.cdsNFSaidaVALOR_CARGA_ESTADUAL.AsCurrency)+'('+FormatFloat('#0.00',((dmMProvider.cdsNFSaidaVALOR_CARGA_ESTADUAL.AsCurrency / dmMProvider.cdsNFSaidaVALORDANOTA.AsCurrency) * 100 ))+'%)'
                          + ' Mun R$ ' + FormatFloat('##0.00', dmMProvider.cdsNFSaidaVALOR_CARGA_MUNICIPAL.AsCurrency)+'('+FormatFloat('#0.00',((dmMProvider.cdsNFSaidaVALOR_CARGA_MUNICIPAL.AsCurrency / dmMProvider.cdsNFSaidaVALORDANOTA.AsCurrency) * 100 ))+'%)'
                          + ' FONTE ' + dmMProvider.cdsItemNFSaidaFONTE_CARGA_TRIBUTARIA.AsString + ' ' + dmMProvider.cdsItemNFSaidaASSINATURA_IBPT.AsString;

    end;

    LimparMSG_ERRO(lblMsg, imgErro);

    if pOpcao = ord(PreviewNFE) then
    begin

      ACBrNFe1.NotasFiscais.Assinar;
      ACBrNFe1.NotasFiscais.Items[0].GravarXML();

      sArquivo := SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-NFe.xml';

      ACBrNFe1.NotasFiscais.Clear;

      if (dmMProvider.cdsParametros_NFECRIAR_PASTAS_MENSALMENTE.Value = 1) then
        ACBrNFe1.NotasFiscais.LoadFromFile(ACBrNFe1.Configuracoes.Arquivos.PathNFe + FormatDateTime('yyyymm',dmMProvider.cdsNFSaidaEMISSAO.Value) + '\' + sArquivo)
      else
        ACBrNFe1.NotasFiscais.LoadFromFile(ACBrNFe1.Configuracoes.Arquivos.PathNFe + sArquivo);

      ACBrNFe1.NotasFiscais.Imprimir;

      Man_Tab_LOG_SYS(Application.Title,'O usu�rio acionou a op��o visualizar a nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

    end
    else
    begin

      Man_Tab_LOG_SYS(Application.Title,'O usu�rio acionou a op��o enviar a nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Index),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

      ACBrNFe1.Enviar(0);
      ACBrNFe1.NotasFiscais.Imprimir;
//      ACBrNFe1.NotasFiscais.ImprimirPDF;
//      ACBrNFe1.NotasFiscais.; //27/03/2017

      lblMsg.Caption  := RetornarRejeicao(dmDBEXMaster.sNomeUsuario,ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].xMotivo, ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat);

      if ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID <> '' then
      begin

        dmMSProcedure.fdspMaster.StoredProcName             := 'EXECUTA_SQL';
        dmMSProcedure.fdspMaster.Prepare;
        dmMSProcedure.fdspMaster.ParamByName('I_SQL').Text  := 'UPDATE NFSAIDA SET NUMERO_DANFE = '
                                                              + QuotedStr(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)
                                                              + ' WHERE NFSAIDA = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                              + ' AND MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                              + ' AND SERIE = ' + QuotedStr(Trim(dmMProvider.cdsNFSaidaSERIE.Value))
                                                              + ' AND DESTINATARIO_ = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
        dmMSProcedure.fdspMaster.ExecProc;

        dmMSProcedure.fdspMaster.ParamByName('I_SQL').Text  := 'UPDATE NFSAIDA SET PROTOCOLO_DANFE = '
                                                              + QuotedStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt)
                                                              + ' WHERE NFSAIDA = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                              + ' AND MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                              + ' AND SERIE = ' + QuotedStr(Trim(dmMProvider.cdsNFSaidaSERIE.Value))
                                                              + ' AND DESTINATARIO_ = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
        dmMSProcedure.fdspMaster.ExecProc;

        dmMSProcedure.fdspMaster.ParamByName('I_SQL').Text  := 'UPDATE EFD_PIS_COFINS_RC100 SET CHV_NFE = '
                                                              + QuotedStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe)
                                                              + ' WHERE NUM_DOCUMENTO = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                              + ' AND COD_MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                              + ' AND SERIE = ' + QuotedStr(Trim(dmMProvider.cdsNFSaidaSERIE.Value))
                                                              + ' AND COD_PARTICIPANTE = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);

        dmMSProcedure.fdspMaster.ExecProc;

        dmMSProcedure.fdspGravarFCP_Estados.Params[0].Value := dmMProvider.cdsNFSaidaNFSAIDA.Value;
        dmMSProcedure.fdspGravarFCP_Estados.Params[1].Value := dmMProvider.cdsNFSaidaMODELO.Value;
        dmMSProcedure.fdspGravarFCP_Estados.Params[2].Value := dmMProvider.cdsNFSaidaUF_DEST.Value;
        dmMSProcedure.fdspGravarFCP_Estados.ExecProc;
{
        dmMSProcedure.fdspGravarRegistroC101SPED.Params[0].Value := dmMProvider.cdsNFSaidaEMISSAO.Value;
        dmMSProcedure.fdspGravarRegistroC101SPED.Params[1].Value := dmMProvider.cdsNFSaidaNFSAIDA.Value;
        dmMSProcedure.fdspGravarRegistroC101SPED.Params[2].Value := dmMProvider.cdsNFSaidaMODELO.Value;
        dmMSProcedure.fdspGravarRegistroC101SPED.Params[3].Value := dmMProvider.cdsNFSaidaSERIE.Value;
        dmMSProcedure.fdspGravarRegistroC101SPED.Params[4].Value := dmDBEXMaster.iIdFilial;
        dmMSProcedure.fdspGravarRegistroC101SPED.ExecProc;
}
        if Length(Trim(dmMProvider.cdsClientesEMAIL.AsString)) > 0 then
        begin

          if (ValidarEmail(dmMProvider.cdsClientesEMAIL.AsString)) and (Length(Trim((dmMProvider.cdsConfiguracoesSERVIDOR_SMTP.AsString))) > 0) then
          begin

            if dmMProvider.cdsConfiguracoesENVIAR_XML_CONTABILIDADE.Value = 1 then
              lblMsg.Caption := 'Aguarde...enviando e-mail para: ' +  dmMProvider.cdsClientesEMAIL.AsString
                                + ' com c�pia para: ' + dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.AsString
            else
              lblMsg.Caption := 'Aguarde...enviando e-mail para: ' +  dmMProvider.cdsClientesEMAIL.AsString;

            Application.ProcessMessages;

            CC := TStringList.Create;

            CC.Add('Esta mensagem refere-se � Nota Fiscal Eletr�nica N�: ' + InttoStr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF) + ' emitida pela empresa:');

            CC.Add('Raz�o Social: '     + dmMProvider.cdsFilialRAZAOSOCIAL.Value);
            CC.Add('E-mail: '           + dmMProvider.cdsFilialEMAIL.Value);
            CC.Add('CNPJ: '             + FormatarCNPJCPF(dmMProvider.cdsFilialCNPJ.Value));
            CC.Add('Insc.Est.: '        + FormatarCNPJCPF(dmMProvider.cdsFilialINSCRICAO.Value));
            CC.Add(' ');
            CC.Add(' ');
            CC.Add('Para visualiz�-la acesse o link a seguir:');
            CC.Add('https://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
            CC.Add('chave de acesso:  ' + Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, Length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)));
            CC.Add(' ');
            CC.Add(' ');
            CC.Add('* Este e-mail foi enviado automaticamente pelo Sistema de Gest�o GenesisAC-XE');
            CC.Add('  Favor n�o responder. Em caso de d�vidas, entre em contato com: ' + dmMProvider.cdsFilialEMAIL.Value);
            CC.Add(' ');
            CC.Add(' ');
            CC.Add('________________________________________________________________');
            CC.Add(' ');
            CC.Add(' ');
            CC.Add('*     Esta mensagem, incluindo seus anexos, � confidencial e seu conte�do � restrito ao destinat�rio da mensagem.');
            CC.Add('Caso voc� a tenha recebido por engano, queira, por favor, retorn�-la ao destinat�rio e apag�-la de seus arquivos.');
            CC.Add('� expressamente proibido o uso n�o autorizado, replica��o ou dissemina��o da mesma.');
            CC.Add('As opini�es contidas nesta mensagem e seus anexos n�o necessariamente refletem a opini�o do emissor. Grato pela colabora��o.');

            Para := dmMProvider.cdsClientesEMAIL.AsString;

            cEmailContabilidade.Add(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.AsString);

            if (dmMProvider.cdsConfiguracoesENVIAR_XML_CONTABILIDADE.Value = 1) and (Length(Trim(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.AsString)) > 0) then
              ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( Para,
                                                          'Nf-e ' + ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                                          CC,
                                                          True,                // Enviar PDF junto
                                                          cEmailContabilidade, // Lista com emails que serão enviado cópias - TStrings
                                                          nil)                 // Lista de anexos - TStrings
            else
              ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( Para,
                                                          'Nf-e ' + ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                                          CC,
                                                          True,   // Enviar PDF junto
                                                          nil ,   // Lista com emails que serão enviado cópias - TStrings
                                                          nil);    // Lista de anexos - TStrings

            CC.Free;

            lblMsg.Caption := 'email enviado com sucesso!';
            Application.ProcessMessages;

          end
          else
          begin

            lblMsg.Caption := 'Email inv�lido: ' +  dmMProvider.cdsClientesEMAIL.AsString;
            Application.ProcessMessages;

          end;


        end
        else
          lblMsg.Caption := MSG_EMAIL_NAO_CADASTRADO + dmMProvider.cdsClientesRAZAOSOCIAL.AsString;

        Application.ProcessMessages;

      end;

      if Length(Trim(dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString)) > 0 then
      begin

        sPastaOrigemXML   := ACBrNFe1.Configuracoes.Arquivos.PathNFe;
        sPastaOrigemPDF   := ACBrNFe1.DANFE.PathPDF;

        sPastaDestinoXML  := dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString;
        sPastaDestinoPDF  := dmMProvider.cdsParametros_NFEREPOSITORIO_PDF.AsString;

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_COPIANDO_XML_REPOSITORIO + dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString;
        Application.ProcessMessages;

        if ForceDirectories(sPastaDestinoXML + sAno_Mes) then
        begin

          if FileExists(sPastaOrigemXML + FormatDateTime('yyyymm', Date{dmMProvider.cdsNFSaidaEMISSAO.Value})+'\'+ SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-NFe.xml' ) then
          begin

  //          if not CopiaArquivo(ACBrNFe1.Configuracoes.Arquivos.PathNFe + '\' + FormatDateTime('yyyymm',dmMProvider.cdsNFSaidaEMISSAO.Value)+'\'+ SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-NFe.xml', dmMProvider.cdsParametros_NFEREPOSITORIO_XML.AsString + SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-NFe.xml', dmDBEXMaster.iTipo_Acesso) then
            if not CopyFile(PWideChar( sPastaOrigemXML + FormatDateTime('yyyymm', Date{dmMProvider.cdsNFSaidaEMISSAO.Value})+'\'+ SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-NFe.xml') ,
                     PWideChar( sPastaDestinoXML + sAno_Mes + '\' + SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-NFe.xml'),True) then
            begin

              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ERRO_COPIANDO_ARQ_REPOS + sPastaDestinoXML;
              Application.ProcessMessages;
              sleep(3000);

            end;

          end;

        end
        else
        begin

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ERRO_CRIAR_PASTA + sPastaDestinoXML;
          Application.ProcessMessages;
          sleep(3000);

        end;

        if ForceDirectories(sPastaDestinoPDF + sAno_Mes)then
        begin

          if FileExists(sPastaOrigemPDF + SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) + '-nfe.pdf' ) then
          begin

            lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_COPIANDO_PDF_REPOSITORIO + sPastaDestinoPDF;
            Application.ProcessMessages;

            if not CopyFile(PWideChar(sPastaOrigemPDF + SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-nfe.pdf') ,
                     PWideChar(sPastaDestinoPDF  + sAno_Mes + '\' + SomenteNumeros(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID) +'-nfe.pdf'),False) then
            begin

              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ERRO_COPIANDO_ARQ_REPOS + sPastaDestinoPDF;
              Application.ProcessMessages;
              sleep(3000);

            end;

          end;

        end
        else
        begin

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ERRO_CRIAR_PASTA + sPastaDestinoPDF;
          Application.ProcessMessages;
          sleep(3000);

        end;

      end;

      ACBrNFe1.NotasFiscais.Clear;

      FreeAndNil(cEmailContabilidade);

      LimparMSG_ERRO(lblMsg, imgErro);

      grdSelecionaNotas.Enabled := True;

      actSelecionarNotasExecute(self);
      AbrirTabela_Cliente(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
      actSelecionarNotasExecute(self);

    end;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

  except

    on E:exception do
    begin

      grdSelecionaNotas.Enabled := True;

      if ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Count > 0 then
      begin

        if not dmDBEXMaster.fdcMaster.InTransaction then
          dmDBEXMaster.fdtMaster.StartTransaction;

        lblMsg.Caption  := RetornarRejeicao(dmDBEXMaster.sNomeUsuario,ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].xMotivo, ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat);
        Application.ProcessMessages;

        case ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat of
          110:begin //denegar a nota

                lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_DENEGANDO_NFE;
                Application.ProcessMessages;

                dmMSProcedure.fdspMaster.StoredProcName   := 'EXECUTA_SQL';
                dmMSProcedure.fdspMaster.Prepare;
                dmMSProcedure.fdspMaster.Params[0].Value  := 'UPDATE NFSAIDA SET NUMERO_DANFE = '
                                                              + QuotedStr('Nfe'+ACBrNFe1.WebServices.Consulta.NFeChave)
                                                              + ', PROTOCOLO_DANFE = ' + QuotedStr(ACBrNFe1.WebServices.Consulta.Protocolo)
                                                              + ', STATUS  = 3'
                                                              + ' WHERE NFSAIDA = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                              + ' AND MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                              + ' AND SERIE = ' + Trim(dmMProvider.cdsNFSaidaSERIE.AsString)
                                                              + ' AND DESTINATARIO_ = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);
                dmMSProcedure.fdspMaster.ExecProc;

                lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_DENEGANDO_NFE;
                Application.ProcessMessages;

                GravarEstornarRegistro50(2);

                GravarEstornarLivroSaida(1);

                lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ATUALIZANDO_STATUS + 'Nota fiscal';
                Application.ProcessMessages;

                dmMSProcedure.fdspMaster.StoredProcName := 'EXECUTA_SQL';
                dmMSProcedure.fdspMaster.Prepare;

                dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE EFD_PIS_COFINS_RC100 SET CHV_NFE = '
                                                                    + QuotedStr(ACBrNFe1.WebServices.Consulta.NFeChave)
                                                                    + ' WHERE NUM_DOCUMENTO = ' + InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value)
                                                                    + ' AND COD_MODELO = ' + QuotedStr(dmMProvider.cdsNFSaidaMODELO.Value)
                                                                    + ' AND SERIE = 1'
                                                                    + ' AND COD_PARTICIPANTE = ' + QuotedStr(dmMProvider.cdsNFSaidaDESTINATARIO_.Value);

                dmMSProcedure.fdspMaster.ExecProc;

                dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE EFD_PIS_COFINS_RC100 SET COD_SITUACAO = 4'
                                                                    + ' WHERE CHV_NFE = ' + QuotedStr(ACBrNFe1.WebServices.Consulta.NFeChave);
                dmMSProcedure.fdspMaster.ExecProc;

                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[0].Value  := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[1].Value  := dmMProvider.cdsFilialCNPJ.Value;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[2].Value  := dmMProvider.cdsFilialINSCRICAO.Value;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[3].Value  := dmMProvider.cdsNFSaidaEMISSAO.Value;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[4].Value  := dmMProvider.cdsFilialESTADOENTREGA.Value;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[5].Value  := dmMProvider.cdsConfiguracoesMODELO.Value;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[6].Value  := dmMProvider.cdsConfiguracoesSERIE.Value;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[7].Value  := InttoStr(dmMProvider.cdsNFSaidaNFSAIDA.Value);
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[8].Value  := '';
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[9].Value  := 'P';
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[10].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[11].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[12].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[13].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[14].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[15].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[16].Value := '2';
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[17].Value := 0;
                dmMSProcedure.fdspMan_Tab_R50_Sint.Params[18].Value := dmMProvider.cdsNFSaidaEMISSAO.Value;

                dmMSProcedure.fdspMan_Tab_R50_Sint.ExecProc;

                actSelecionarNotasExecute(self);

              end;

        end;

        if dmDBEXMaster.fdcMaster.InTransaction then
          dmDBEXMaster.fdtMaster.Commit;

      end
      else

//        lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + ', ' + Copy(Tratar_Erro_Conexao(E),1,-1) + ' ' + Trim(Copy(Tratar_Erro_Conexao(E),Pos(#13,e.Message)+2, Length(e.Message)));
        lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + ', ' + Tratar_Erro_Conexao(E);
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

function TfrmModDanfe.GravarEstornarLivroSaida(pOpcao: smallint): boolean;
begin
  try
    {

    criar msg de estorno livro de sa�da
    if pOpcao = 1 then //estorna
      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ESTORNANDO_RC100_SPED
    else
      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_GERANDO_REGC100_SPED;
    Application.ProcessMessages;

    }

    dmMProvider.cdsSelItemNFS_LS.Close;
    dmMProvider.cdsSelItemNFS_LS.ProviderName := 'dspSelItemNFS_LS';

    dmDBEXMaster.fdqSelecionaItensNFSaida_LS.Params[0].Value := dmMProvider.cdsNFSaidaNFSAIDA.Value;

    dmMProvider.cdsSelItemNFS_LS.Open;
    dmMProvider.cdsSelItemNFS_LS.ProviderName := '';

    while not dmMProvider.cdsSelItemNFS_LS.Eof do
    begin

      dmMSProcedure.fdspLivroSaida.Params[0].Value      := pOpcao;
      dmMSProcedure.fdspLivroSaida.Params[1].Value      := -1;      // numero livro
      dmMSProcedure.fdspLivroSaida.Params[2].Value      := dmDBEXMaster.iIdFilial;
      dmMSProcedure.fdspLivroSaida.Params[3].Value      := FormatDateTime('mmyyyy', dmMProvider.cdsNFSaidaEMISSAO.Value);

      if dmMProvider.cdsConfiguracoesMODELO.Value = '01' then
        dmMSProcedure.fdspLivroSaida.Params[4].Value    := 'NF'
      else if dmMProvider.cdsConfiguracoesMODELO.Value = '55' then
        dmMSProcedure.fdspLivroSaida.Params[4].Value    := 'NFE';

      dmMSProcedure.fdspLivroSaida.Params[5].Value      := dmMProvider.cdsNFSaidaSERIE.Value;
      dmMSProcedure.fdspLivroSaida.Params[6].Value      := IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value);
      dmMSProcedure.fdspLivroSaida.Params[7].Value      := dmMProvider.cdsNFSaidaEMISSAO.Value;
      dmMSProcedure.fdspLivroSaida.Params[8].Value      := dmMProvider.cdsNFSaidaUF_DEST.Value;
      dmMSProcedure.fdspLivroSaida.Params[9].Value      := dmMProvider.cdsSelItemNFS_LSOP_SUB_TOTAL.Value;
      dmMSProcedure.fdspLivroSaida.Params[10].Value     := 1;
      dmMSProcedure.fdspLivroSaida.Params[11].Value     := dmMProvider.cdsSelItemNFS_LSOP_CFOP.Value;
      dmMSProcedure.fdspLivroSaida.Params[12].Value     := dmMProvider.cdsSelItemNFS_LSOP_BASE_ICMS.Value;
      dmMSProcedure.fdspLivroSaida.Params[13].Value     := dmMProvider.cdsSelItemNFS_LSOP_ALIQUOTA.Value;

      if (dmMProvider.cdsSelItemNFS_LSOP_CFOP.Value = '5202') or (dmMProvider.cdsSelItemNFS_LSOP_CFOP.Value = '6202') then
      begin

        dmMSProcedure.fdspLivroSaida.Params[14].Value   := 0;   // imposto debitado
        dmMSProcedure.fdspLivroSaida.Params[16].Value   := dmMProvider.cdsSelItemNFS_LSOP_SUB_TOTAL.Value;

      end
      else
      begin

        dmMSProcedure.fdspLivroSaida.Params[14].Value   := dmMProvider.cdsSelItemNFS_LSOP_VALOR_ICMS.Value;
        dmMSProcedure.fdspLivroSaida.Params[16].Value   := 0;   // outras

      end;

      dmMSProcedure.fdspLivroSaida.Params[15].Value     := dmMProvider.cdsSelItemNFS_LSOP_ISENTAS_NT.Value;
      dmMSProcedure.fdspLivroSaida.Params[17].Value     := 0;   // totalizador geral ECF
      dmMSProcedure.fdspLivroSaida.Params[18].Value     := 0;   // CRZ
      dmMSProcedure.fdspLivroSaida.Params[19].Value     := 0;   // identifica��o ICMS ou IPI
      dmMSProcedure.fdspLivroSaida.Params[20].Value     := 0;   // observa��o

      dmMSProcedure.fdspLivroSaida.ExecProc;

      dmMProvider.cdsSelItemNFS_LS.Next;

      Result := True;

    end;

  except
  on E: exception do
    begin

      Result          := False;
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;


end;

function TfrmModDanfe.GravarEstornarRegistro50(pOpcao: smallint): boolean;
begin
  try

    if pOpcao = 2 then //estorna reg50 sintegra
      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_ESTORNANDO_REG50_SINTEGRA
    else
      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_GERANDO_REG50_SINTEGRA;

    Application.ProcessMessages;

    if (pOpcao = 3) or (pOpcao = 4) then //cancelar nota
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[0].Value    := 1
    else
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[0].Value    := pOpcao;

    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[1].Value    := dmMProvider.cdsNFSaidaNFSAIDA.Value;

    if dmMProvider.cdsNFSaidaPAIS_DESTINATARIO.Value <>  dmMProvider.cdsFilialPAIS.Value then
    begin

      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[2].Value := '00000000000000'; //cnpj
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[3].Value := 'ISENTO';         //inscri��o estadual

    end
    else
    begin

      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[2].Value := dmMProvider.cdsNFSaidaDESTINATARIO_.Value;
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[3].Value := dmMProvider.cdsNFSaidaIE_DESTINATARIO.Value;

    end;

    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[4].Value    := dmMProvider.cdsNFSaidaEMISSAO.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[5].Value    := dmMProvider.cdsNFSaidaUF_DEST.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[6].Value    := dmMProvider.cdsNFSaidaMODELO.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[7].Value    := dmMProvider.cdsNFSaidaSERIE.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[8].AsString := IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value);
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[9].AsString := '';    //cfop
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[10].Value   := 'P';   //emitente  P-pr�prio
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[11].Value   := dmMProvider.cdsNFSaidaVALORDANOTA.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[12].Value   := dmMProvider.cdsNFSaidaBASECALCULOICMS.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[13].Value   := dmMProvider.cdsNFSaidaVALORICMS.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[14].Value   := 0;     //isentas n�o tributadas
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[15].Value   := 0;     //outras despesas
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[16].Value   := 0;     //aliquota icms
    if pOpcao = 3 then
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[17].Value := 'S'   //situacao da nota
    else if pOpcao = 4 then
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[17].Value := '2'   //situacao da nota
    else
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[17].Value := 'N';   //situacao da nota
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[18].Value   := 0;     //tipo nota
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[19].Value   := dmMProvider.cdsNFSaidaEMISSAO.Value;
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[20].Value   := 0;     //nf entrada
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[21].Value   := 0;     //somar icmsr no total
    dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[22].Value   := -1;    //cst

    if dmMProvider.cdsNFSaidaDESCONTO_ST.Value > 0 then
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[23].Value := (dmMProvider.cdsNFSaidaDESCONTO_ST.Value / dmMProvider.cdsNFSaidaVALORDOSPRODUTOS.Value) * 100
    else
      dmMSProcedure.fdspGravarRegistro50_Sintegra.Params[23].Value := 0;

    dmMSProcedure.fdspGravarRegistro50_Sintegra.ExecProc;

    Result := True;

  except
  on E: exception do
    begin

      Result          := False;
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

function TfrmModDanfe.GravarEstornarRegistro54(pOpcao: smallint): boolean;
begin

  try

    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[0].Value       := pOpcao;
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[1].Value       := dmMProvider.cdsNFSaidaNFSAIDA.Value;
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[2].Value       := dmMProvider.cdsNFSaidaEMISSAO.Value;

    if dmMProvider.cdsNFSaidaPAIS_DESTINATARIO.Value <>  dmMProvider.cdsFilialPAIS.Value then
      dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[3].Value := '00000000000000' //cnpj
    else
      dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[3].Value := dmMProvider.cdsNFSaidaDESTINATARIO_.Value;

    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[4].Value       := dmMProvider.cdsNFSaidaMODELO.Value;
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[5].Value       := dmMProvider.cdsNFSaidaSERIE.Value;
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[6].Value       := IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value);
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[7].Value       := 0;  //tipo nota
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[8].Value       := dmMProvider.cdsNFSaidaUF_DEST.Value;
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[9].Value       := dmMProvider.cdsNFSaidaEMISSAO.Value;
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[10].Value      := 0;  //nf entrada
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[11].Value      := 0;  //frete
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[12].Value      := 0;  //seguro
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[13].Value      := 0;  //outras despesas
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[14].Value      := 0;  //valor do frete
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[15].Value      := 0;  //valor do seguro
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[16].Value      := 0;  //valor de outras despesas
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[17].Value      := ''; //cfop
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[18].Value      := 0;  //somar ipi bc icms
    dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[19].Value      := 0;  //somar icmsr total nf

    if dmMProvider.cdsNFSaidaDESCONTO_ST.Value > 0 then
      dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[23].Value := (dmMProvider.cdsNFSaidaDESCONTO_ST.Value / dmMProvider.cdsNFSaidaVALORDOSPRODUTOS.Value) * 100
    else
      dmMSProcedure.fdspGravarRegistro54_Sintegra.Params[23].Value := 0;

    dmMSProcedure.fdspGravarRegistro54_Sintegra.ExecProc;

    Result := True;

  except
  on E: exception do
    begin

      Result          := False;
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.grdSelecionaNotasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not dmMProvider.cdsNFSaida.IsEmpty then
  begin

    if not odd(dmMProvider.cdsNFSaida.RecNo) then
    begin

      grdSelecionaNotas.Canvas.Font.Color   := clBlack;
      grdSelecionaNotas.Canvas.Brush.Color  := COR_ZEBRA_GRADE;

    end
    else
    begin

      grdSelecionaNotas.Canvas.Font.Color   := clBlack;
      grdSelecionaNotas.Canvas.Brush.Color  := clWhite;

    end;

    grdSelecionaNotas.Canvas.FillRect(Rect);
    grdSelecionaNotas.DefaultDrawDataCell(Rect, Column.Field, State);

  end;

end;

procedure TfrmModDanfe.imgImprimirEventosClick(Sender: TObject);
begin

  try

    frmImprimirEventos := TfrmImprimirEventos.Create(self);
    frmImprimirEventos.ShowModal;

    CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
    Man_Tab_LOG_SYS(Application.Title,'O usu�rio usou op��o para adicionar protocolo a nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

    FreeAndNil(frmImprimirEventos);

  except
  on E: exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.Message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.imgLogClick(Sender: TObject);
var
  sLinha:string;
begin
  {

    verifica se o arquivo existe
    futuramente ser� utilizado bpl

  }

  if FileExists(ExtractFilePath(Application.ExeName)+'LogSys.exe') then
  begin

    {

      valida permiss�o do usu�rio

    }

    sLinha := ExtractFilePath(Application.ExeName)
      + 'LogSys.exe '
      + dmDBEXMaster.sNomeUsuario + ' '
      + dmDBEXMaster.sSenha + ' '
      + IntToStr(dmDBEXMaster.iIdUsuario) + ' '
      + IntToStr(dmDBEXMaster.iIdFilial);

      sLinha := sLinha + ' ' + dmDBEXMaster.sNomeUsuario + ' ' + RetiraBrancos(Application.Title);

    {
      cria um processo para chamaar a tela
      de manuten��o de estados
    }

    CriarProcessoSimples(sLinha);

  end;


end;

procedure TfrmModDanfe.imgPreVisualizarNfeClick(Sender: TObject);
begin

  try

    CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');

    LimparMSG_ERRO(lblMsg, imgErro);

    if not dmMProvider.cdsNFSaida.IsEmpty then
    begin

      lblMsg.Tag := ord(PreviewNFE);
      GerarEnviarNfe(ord(PreviewNFE));

    end
    else
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_NECESSARIO_SELECIONAR_NF;
      Application.ProcessMessages;

    end;

  except

    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.imgSairClick(Sender: TObject);
begin

  CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
  Man_Tab_LOG_SYS(Application.Title,'O usu�rio encerrou o m�dulo de ' + Application.Title,'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

  Close;

end;

procedure TfrmModDanfe.imgStatusWSClick(Sender: TObject);
begin
  try

    CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
    Man_Tab_LOG_SYS(Application.Title,'O usu�rio acionou a op��o verificar status do servi�o (WS)','',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

    actStatusServicoExecute(self);

  except
  on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.imgTRansmitirNFClick(Sender: TObject);
begin

  try

    ACBrNFe1.DANFE.NFeCancelada   := False;

    LimparMSG_ERRO(lblMsg, imgErro);

    if not dmMProvider.cdsNFSaida.IsEmpty then
    begin

      grdSelecionaNotas.Enabled := False;

      lblMsg.Tag      := ord(EnviarNFE);
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_ENVIAR_NFE;
      Application.ProcessMessages;

    end
    else
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_NECESSARIO_SELECIONAR_NF;
      Application.ProcessMessages;

    end;

    CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
    Man_Tab_LOG_SYS(Application.Title,'O usu�rio acionou a op��o para enviar a nota: ' + IntToStr(dmMProvider.cdsNFSaidaNFSAIDA.Value),'',sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',3);

  except
    on E:exception do
    begin

      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      imgErro.Visible := True;
      Application.ProcessMessages;

      CapturaTelaJpg(sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg');
      Man_Tab_LOG_SYS(Application.Title,Tratar_Erro_Conexao(E),E.message,sPasta_Imagem_Log + NomeArquivo_sem_extensao(Application.ExeName) + '.jpg',4);

    end;

  end;

end;

procedure TfrmModDanfe.LoadXML(RetWS: String);
begin
  ACBrUtil.WriteToTXT( PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml',
                        ACBrUtil.ConverteXMLtoUTF8( RetWS ), False, False);
end;

function TfrmModDanfe.ValidarNfe: boolean;
begin

  Result := (ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe <> '')
            and (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis <> teContingencia)
            and (ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.cStat <> 101);

end;

{ TDBGrid }

procedure TDBGrid.DrawCellBackground(const ARect: TRect; AColor: TColor; AState: TGridDrawState; ACol, ARow: Integer);
begin
  inherited;

  if ACol < 0 then
    inherited DrawCellBackground(ARect, AColor, AState, ACol, ARow)
  else
    inherited DrawCellBackground(ARect, Columns[ACol].Title.Color, AState,
      ACol, ARow)

end;

end.