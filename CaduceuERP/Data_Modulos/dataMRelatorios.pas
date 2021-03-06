unit dataMRelatorios;

interface

uses
  SysUtils, Classes, RpDefine, RpBase, RpSystem, RpCon, RpConDS, RpRave, DB,
  DBClient, RpRenderText, RpRenderRTF, RpRenderHTML, RpRender, RpRenderPDF,
  FMTBcd, SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.Provider, RpRenderCanvas, RpRenderPreview, Vcl.DdeMan,
  FireDAC.Phys.SQLiteVDataSet;


type
  TdmRelatorios = class(TDataModule)
    sqqProdutoPIS_COFINS: TSQLQuery;
    cdsVendaPisCofins: TClientDataSet;
    cdsVendaPisCofinsPRODUTO: TIntegerField;
    cdsVendaPisCofinsDESCRICAO: TStringField;
    cdsVendaPisCofinsUNIDADE: TStringField;
    cdsVendaPisCofinsQUANTIDADE_ENTRADA: TFloatField;
    cdsVendaPisCofinsVALOR_ENTRADA: TCurrencyField;
    cdsVendaPisCofinsQUANTIDADE_SAIDA: TFloatField;
    cdsVendaPisCofinsVALOR_SAIDA: TCurrencyField;
    cdsVendaPisCofinsLEI_PIS_COFINS: TIntegerField;
    cdsVendaPisCofinsDESCRICAO_LEI_PIS_COFINS: TStringField;
    dtsVendaPisCofins: TDataSource;
    fdqInventario: TFDQuery;
    sqqRegInventario: TSQLQuery;
    fdqRegInventarioP7: TFDQuery;
    fdqApoioEFDContr: TFDQuery;
    fdqPromocao: TFDQuery;
    fdqApoioInventario: TFDQuery;
    fdqVendaRankingGrupo: TFDQuery;
    fdqApoioEFDContrPRODUTO: TIntegerField;
    fdqApoioEFDContrDESCRICAO: TStringField;
    fdqApoioEFDContrUNIDADE: TStringField;
    fdqApoioEFDContrNCM: TStringField;
    fdqApoioEFDContrCST_PIS_S: TIntegerField;
    fdqApoioEFDContrCST_COFINS_S: TIntegerField;
    fdqApoioEFDContrCST_PIS_ENTRADA: TIntegerField;
    fdqApoioEFDContrCST_COFINS_ENTRADA: TIntegerField;
    fdqApoioEFDContrALIQ_PIS_S: TBCDField;
    fdqApoioEFDContrALIQ_COFINS_S: TBCDField;
    fdqApoioEFDContrALIQUOTA_PIS_ENTRADA: TFMTBCDField;
    fdqApoioEFDContrALIQUOTA_COFINS_ENTRADA: TFMTBCDField;
    fdqApoioEFDContrNATUREZA_RECEITA: TIntegerField;
    fdqApoioEFDContrCODIGO_CREDITO_PIS_COFINS: TIntegerField;
    fdqVendaProdutoCFOP: TFDQuery;
    fdqCompraProdCFOP: TFDQuery;
    dspRequisicaoPecaOS: TDataSetProvider;
    cdsRequisicaoPecaOS: TClientDataSet;
    cdsRequisicaoPecaOSCODIGO_PECA: TIntegerField;
    cdsRequisicaoPecaOSDESCRICAO: TStringField;
    cdsRequisicaoPecaOSQUANTIDADE: TBCDField;
    fdqMovCompraProd: TFDQuery;
    fdqMovVendaProd: TFDQuery;
    rvpGenesisAC: TRvProject;
    rvdOrdemServico: TRvDataSetConnection;
    rvdItensServicoOS: TRvDataSetConnection;
    rvdIrtensPecaOS: TRvDataSetConnection;
    rvdFilial: TRvDataSetConnection;
    rvdPerdas: TRvDataSetConnection;
    rvdItensPerdas: TRvDataSetConnection;
    rvdRControlePerda: TRvDataSetConnection;
    RvRenderPDF1: TRvRenderPDF;
    RvRenderRTF1: TRvRenderRTF;
    RvRenderText1: TRvRenderText;
    rvdTransferencia: TRvDataSetConnection;
    rvdGenesis: TRvDataSetConnection;
    rvdOrcamentoZeus: TRvDataSetConnection;
    rvdItemOrcamentoZeus: TRvDataSetConnection;
    rvdEndEntregaOrcaZeus: TRvDataSetConnection;
    rvdFinalizaOrcaZeus: TRvDataSetConnection;
    rvsGenesisAC: TRvSystem;
    rvdCaixaLoja: TRvDataSetConnection;
    rvdItemCaixaLoja: TRvDataSetConnection;
    rvdParcelasCRE: TRvDataSetConnection;
    rvdConfiguracoes: TRvDataSetConnection;
    rvdOrdemProducao: TRvDataSetConnection;
    rvdItemOrdemProducao: TRvDataSetConnection;
    rvdFretePedido: TRvDataSetConnection;
    rvdListagemPedVenda: TRvDataSetConnection;
    fdqListagemPedVenda: TFDQuery;
    dspListagemPedvenda: TDataSetProvider;
    cdsListagemPedVenda: TClientDataSet;
    cdsListagemPedVendaPEDIDO: TIntegerField;
    cdsListagemPedVendaSITUACAO: TSmallintField;
    cdsListagemPedVendaVENDEDOR: TIntegerField;
    cdsListagemPedVendaCLIENTE: TIntegerField;
    cdsListagemPedVendaVALOR_DO_PEDIDO: TBCDField;
    cdsListagemPedVendaRAZAOSOCIAL: TStringField;
    cdsListagemPedVendaNOME: TStringField;
    cdsListagemPedVendaTIPO: TSmallintField;
    cdsListagemPedVendaS_TIPO: TStringField;
    cdsListagemPedVendaS_SITUACAO: TStringField;
    cdsListagemPedVendaEMISSAO: TDateField;
    rvdLivroEntrada: TRvDataSetConnection;
    fdqRelLivroEntrada: TFDQuery;
    dspRelLivroEntrada: TDataSetProvider;
    cdsRelLivroEntrada: TClientDataSet;
    cdsRelLivroEntradaOP_DATA_ENTRADA: TDateField;
    cdsRelLivroEntradaOP_TIPO_ESP_DOCUMENTO: TStringField;
    cdsRelLivroEntradaOP_SERIE_SUB_SERIE: TStringField;
    cdsRelLivroEntradaOP_NUMERO_DOCUMENTO: TStringField;
    cdsRelLivroEntradaOP_DATA_DOCUMENTO: TDateField;
    cdsRelLivroEntradaOP_CNPJ_EMITENTE: TStringField;
    cdsRelLivroEntradaOP_UF_ORIGEM: TStringField;
    cdsRelLivroEntradaOP_VALOR_CONTABIL: TBCDField;
    cdsRelLivroEntradaOP_CODIGO_CONTABIL: TSmallintField;
    cdsRelLivroEntradaOP_CFOP: TStringField;
    cdsRelLivroEntradaOP_IDENT_ICMS_IPI: TSmallintField;
    cdsRelLivroEntradaOP_COD_VALORES_FISCAIS: TSmallintField;
    cdsRelLivroEntradaOP_BASE_CALCULO: TBCDField;
    cdsRelLivroEntradaOP_ALIQUOTA: TBCDField;
    cdsRelLivroEntradaOP_IMPOSTO_CREDITADO: TBCDField;
    cdsRelLivroEntradaOP_OBSERVACAO: TStringField;
    rvdRelTotalizaLivroEntrada: TRvDataSetConnection;
    fdqRelTotalizaLivroEntradaEST: TFDQuery;
    cdsRelTotalizaLivroEntradaEST: TClientDataSet;
    dspRelTotalizaLivroEntradaEST: TDataSetProvider;
    cdsRelTotalizaLivroEntradaESTOP_CFOP: TStringField;
    cdsRelTotalizaLivroEntradaESTOP_CFOP_DESCRICAO: TStringField;
    cdsRelTotalizaLivroEntradaESTOP_VALOR_CONTABIL: TBCDField;
    cdsRelTotalizaLivroEntradaESTOP_BASE_CALCULO_CFOP: TBCDField;
    cdsRelTotalizaLivroEntradaESTOP_IMPOSTO_CREDITADO_CFOP: TBCDField;
    cdsRelTotalizaLivroEntradaESTOP_ISENTAS: TBCDField;
    cdsRelTotalizaLivroEntradaESTOP_OUTRAS: TBCDField;
    fdqRelTotalizaLivroEntradaINTER: TFDQuery;
    dspRelTotalizaLivroEntradaINTER: TDataSetProvider;
    cdsRelTotalizaLivroEntradaINTER: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    BCDField3: TBCDField;
    BCDField4: TBCDField;
    BCDField5: TBCDField;
    rvdRelTotalizaLivroEntradaINTER: TRvDataSetConnection;
    fdmTotalAliqLivroEntrada: TFDMemTable;
    fdmTotalAliqLivroEntradaALIQUOTA: TStringField;
    fdmTotalAliqLivroEntradaVALOR: TCurrencyField;
    cdsRelTotalizaLivroEntradaESTOP_ALIQUOTA: TBCDField;
    rvdTotalAliqLivroEntrada: TRvDataSetConnection;
    fdmTotalOperInterLivroEntrada: TFDMemTable;
    fdmTotalOperInterLivroEntradaUF: TStringField;
    fdmTotalOperInterLivroEntradaBASE_CALCULO: TCurrencyField;
    fdmTotalOperInterLivroEntradaVALOR_CONTABIL: TCurrencyField;
    fdmTotalOperInterLivroEntradaISENTAS: TCurrencyField;
    fdmTotalOperInterLivroEntradaOUTRAS: TCurrencyField;
    fdmTotalOperInterLivroEntradaICMS_RETIDO: TCurrencyField;
    fdmTotalOperInterLivroEntradaBC_ICMS_RETIDO: TCurrencyField;
    cdsRelTotalizaLivroEntradaESTOP_UF: TStringField;
    rvdTotalOperInterLivroEntrada: TRvDataSetConnection;
    rvdLivroSaida: TRvDataSetConnection;
    rvdTotalizaLivroSaida: TRvDataSetConnection;
    fdqRelTotalizaLivroSaidaEST: TFDQuery;
    dspRelTotalizaLivroSaidaEST: TDataSetProvider;
    cdsRelTotalizaLivroSaidaEST: TClientDataSet;
    cdsRelTotalizaLivroSaidaESTOP_CFOP: TStringField;
    cdsRelTotalizaLivroSaidaESTOP_DESCRICAO_CFOP: TStringField;
    cdsRelTotalizaLivroSaidaESTOP_VALOR_CONTABIL: TBCDField;
    cdsRelTotalizaLivroSaidaESTOP_BASE_CALCULO: TBCDField;
    cdsRelTotalizaLivroSaidaESTOP_IMPOSTO_DEBITADO: TBCDField;
    cdsRelTotalizaLivroSaidaESTOP_ISENTAS_NT: TBCDField;
    cdsRelTotalizaLivroSaidaESTOP_OUTRAS: TBCDField;
    fdmTotalAliqLivroSaida: TFDMemTable;
    rvdTotalAliqLivroSaida: TRvDataSetConnection;
    fdmTotalAliqLivroSaidaVALOR: TCurrencyField;
    cdsRelTotalizaLivroEntradaINTEROP_ALIQUOTA: TBCDField;
    cdsRelTotalizaLivroEntradaINTEROP_UF: TStringField;
    cdsRelTotalizaLivroSaidaESTOP_ALIQUOTA: TBCDField;
    fdmTotalAliqLivroSaidaALIQUOTA: TStringField;
    fdqRelTotalizaLivroSaidaINTER: TFDQuery;
    cdsRelTotalizaLivroSaidaINTER: TClientDataSet;
    dspRelTotalizaLivroSaidaINTER: TDataSetProvider;
    rvdRelTotalizaLivroSaidaINTER: TRvDataSetConnection;
    cdsRelTotalizaLivroSaidaINTEROP_CFOP: TStringField;
    cdsRelTotalizaLivroSaidaINTEROP_DESCRICAO_CFOP: TStringField;
    cdsRelTotalizaLivroSaidaINTEROP_VALOR_CONTABIL: TBCDField;
    cdsRelTotalizaLivroSaidaINTEROP_BASE_CALCULO: TBCDField;
    cdsRelTotalizaLivroSaidaINTEROP_IMPOSTO_DEBITADO: TBCDField;
    cdsRelTotalizaLivroSaidaINTEROP_ISENTAS_NT: TBCDField;
    cdsRelTotalizaLivroSaidaINTEROP_OUTRAS: TBCDField;
    cdsRelTotalizaLivroSaidaINTEROP_ALIQUOTA: TBCDField;
    cdsRelTotalizaLivroSaidaINTEROP_UF: TStringField;
    rvdApuracaoEntrada: TRvDataSetConnection;
    rvdTotalizaValoresEST: TRvDataSetConnection;
    rvdTotalizaValoresINTER: TRvDataSetConnection;
    rvdApuracaoSaida: TRvDataSetConnection;
    rvdTotalizaValoresEST_S: TRvDataSetConnection;
    rvdTotalizaValoresINTER_S: TRvDataSetConnection;
    rvdDeslocamentoOS: TRvDataSetConnection;
    rvdCtrlNotas: TRvDataSetConnection;
    dspListNFEntrada: TDataSetProvider;
    cdsListNFEntrada: TClientDataSet;
    fdqListNFEntrada: TFDQuery;
    cdsListNFEntradaNOTAFISCAL: TStringField;
    cdsListNFEntradaENTRADA: TDateField;
    cdsListNFEntradaEMISSAO: TDateField;
    cdsListNFEntradaFORNECEDOR: TIntegerField;
    cdsListNFEntradaRAZAOSOCIAL: TStringField;
    cdsListNFEntradaVALORDANOTA: TBCDField;
    cdsListNFEntradaBASEICMS: TBCDField;
    cdsListNFEntradaVALORICMS: TBCDField;
    cdsListNFEntradaBASESUBSTITUICAO: TBCDField;
    cdsListNFEntradaVALORSUBSTITUICAO: TBCDField;
    cdsListNFEntradaSTATUS: TSmallintField;
    cdsListNFEntradaVALORDOSEGURO: TBCDField;
    cdsListNFEntradaFRETE_AGREGADO: TBCDField;
    cdsListNFEntradaOUTRASDESPESAS: TBCDField;
    cdsListNFEntradaVALORDOIPI: TBCDField;
    cdsListNFEntradaCH_FRETE: TBCDField;
    cdsListNFEntradaS_STATUS: TStringField;
    cdsListNFEntradaFINALIDADE_NF: TSmallintField;
    cdsListNFEntradaOBSERVACAO_FINALIDADE: TStringField;
    cdsListNFEntradaS_FINALIDADE: TStringField;
    fdqListNFsaida: TFDQuery;
    dspListNFsaida: TDataSetProvider;
    cdsListNFsaida: TClientDataSet;
    cdsListNFsaidaEMISSAO: TDateField;
    cdsListNFsaidaNFSAIDA: TIntegerField;
    cdsListNFsaidaDESTINATARIO_: TStringField;
    cdsListNFsaidaVALORDANOTA: TBCDField;
    cdsListNFsaidaSTATUS: TSmallintField;
    cdsListNFsaidaCANCELADA: TSmallintField;
    cdsListNFsaidaRAZAOSOCIAL: TStringField;
    cdsListNFsaidaS_STATUS: TStringField;
    dspTotCFOP_NFS: TDataSetProvider;
    cdsTotCFOP_NFS: TClientDataSet;
    dtsListNFSaida: TDataSource;
    cdsTotCFOP_NFSCFOP: TStringField;
    cdsTotCFOP_NFSST: TBCDField;
    rvdTotCFOP_NFS: TRvDataSetConnection;
    cdsTotCFOP_NFSNFSAIDA: TIntegerField;
    fdqTotCFOP_NFS: TFDQuery;
    dspTotGeralCFOP_NFS: TDataSetProvider;
    cdsTotGeralCFOP_NFS: TClientDataSet;
    fdqTotGeralCFOP_NFS: TFDQuery;
    cdsTotGeralCFOP_NFSCFOP: TStringField;
    cdsTotGeralCFOP_NFSST: TBCDField;
    rvdTotGeralCFOP_NFS: TRvDataSetConnection;
    procedure cdsListagemPedVendaCalcFields(DataSet: TDataSet);
    procedure fdmTotalOperInterLivroEntradaNewRecord(DataSet: TDataSet);
    procedure fdmTotalAliqLivroSaidaNewRecord(DataSet: TDataSet);
    procedure cdsListNFEntradaCalcFields(DataSet: TDataSet);
    procedure cdsListNFsaidaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PovoarDataSetMovPIS_COFINS;
  end;

var
  dmRelatorios: TdmRelatorios;

implementation

{$R *.dfm}

uses dataMProvider, dataDBEXMaster;

{ TdmRelatorios }

procedure TdmRelatorios.cdsListagemPedVendaCalcFields(DataSet: TDataSet);
begin

  case cdsListagemPedVendaTIPO.Value of
    0:cdsListagemPedVendaS_TIPO.Value := 'CART�O DE CR�DITO';
    1:cdsListagemPedVendaS_TIPO.Value := 'CART�O DE D�BITO';
    2:cdsListagemPedVendaS_TIPO.Value := 'CHEQUE';
    3:cdsListagemPedVendaS_TIPO.Value := 'CHEQUE-PAR';
    4:cdsListagemPedVendaS_TIPO.Value := 'CHEQUE-PR�';
    5:cdsListagemPedVendaS_TIPO.Value := 'CONTRA-VALE';
    6:cdsListagemPedVendaS_TIPO.Value := 'CONV�NIO';
    7:cdsListagemPedVendaS_TIPO.Value := 'DINHEIRO';
    8:cdsListagemPedVendaS_TIPO.Value := 'REC. DIVERSOS';
    9:cdsListagemPedVendaS_TIPO.Value := 'TICKET';
   10:cdsListagemPedVendaS_TIPO.Value := 'A PRAZO';
  end;

  case cdsListagemPedVendaSITUACAO.Value of
    0:cdsListagemPedVendaS_SITUACAo.Value := 'A CONFIRMAR';
    1:cdsListagemPedVendaS_SITUACAo.Value := 'CONFIRMADO';
    2:cdsListagemPedVendaS_SITUACAo.Value := 'FINALIZADO (CX)';
  end;

end;

procedure TdmRelatorios.cdsListNFEntradaCalcFields(DataSet: TDataSet);
begin

  case cdsListNFEntradaSTATUS.Value of
    0:cdsListNFEntradaS_STATUS.Value := 'A CONFIRMAR';
    1:cdsListNFEntradaS_STATUS.Value := 'CONFIRMADA';
  end;

  case cdsListNFEntradaFINALIDADE_NF.Value of
    0:cdsListNFEntradaS_FINALIDADE.Value := 'CONSUMO';
    1:cdsListNFEntradaS_FINALIDADE.Value := 'REVENDA';
    2:cdsListNFEntradaS_FINALIDADE.Value := 'OUTROS';
  else
    cdsListNFEntradaS_FINALIDADE.Value := 'SEM INFO';
  end;

end;

procedure TdmRelatorios.cdsListNFsaidaCalcFields(DataSet: TDataSet);
begin

  case cdsListNFsaidaSTATUS.Value  of
    0:cdsListNFsaidaS_STATUS.Value := 'A CONFIRMAR';
    1:cdsListNFsaidaS_STATUS.Value := 'CONFIRMADA';
    2:cdsListNFsaidaS_STATUS.Value := 'CANCELADA';
    3:cdsListNFsaidaS_STATUS.Value := 'DENEGADA';
  end;

end;

procedure TdmRelatorios.fdmTotalAliqLivroSaidaNewRecord(DataSet: TDataSet);
begin

  fdmTotalAliqLivroSaidaVALOR.Value := 0;

end;

procedure TdmRelatorios.fdmTotalOperInterLivroEntradaNewRecord(
  DataSet: TDataSet);
begin

  fdmTotalOperInterLivroEntradaBASE_CALCULO.Value   := 0;
  fdmTotalOperInterLivroEntradaVALOR_CONTABIL.Value := 0;
  fdmTotalOperInterLivroEntradaISENTAS.Value        := 0;
  fdmTotalOperInterLivroEntradaOUTRAS.Value         := 0;
  fdmTotalOperInterLivroEntradaICMS_RETIDO.Value    := 0;
  fdmTotalOperInterLivroEntradaBC_ICMS_RETIDO.Value := 0;

end;

procedure TdmRelatorios.PovoarDataSetMovPIS_COFINS;
begin

  cdsVendaPisCofins.Close;
  cdsVendaPisCofins.CreateDataSet;

  while not sqqProdutoPIS_COFINS.Eof do
  begin

    cdsVendaPisCofins.Append;
    cdsVendaPisCofinsPRODUTO.Value                      := sqqProdutoPIS_COFINS.FieldByName('OP_PRODUTO').AsInteger;
    cdsVendaPisCofinsDESCRICAO.Value                    := sqqProdutoPIS_COFINS.FieldByName('OP_DESCRICAO').AsString;
    cdsVendaPisCofinsUNIDADE.Value                      := sqqProdutoPIS_COFINS.FieldByName('OP_UNIDADE').AsString;
    cdsVendaPisCofinsQUANTIDADE_ENTRADA.AsFloat         := sqqProdutoPIS_COFINS.FieldByName('OP_QUANT_ENTRADA').AsFloat;
    cdsVendaPisCofinsVALOR_ENTRADA.AsFloat              := sqqProdutoPIS_COFINS.FieldByName('OP_VALOR_ENTRADA').AsFloat;
    cdsVendaPisCofinsQUANTIDADE_SAIDA.AsFloat           := sqqProdutoPIS_COFINS.FieldByName('OP_QUANT_SAIDA').AsFloat;
    cdsVendaPisCofinsVALOR_SAIDA.AsFloat                := sqqProdutoPIS_COFINS.FieldByName('OP_VALOR_SAIDA').AsFloat;
    cdsVendaPisCofinsLEI_PIS_COFINS.AsInteger           := sqqProdutoPIS_COFINS.FieldByName('OP_LEI_PIS_COFINS').AsInteger;
    cdsVendaPisCofinsDESCRICAO_LEI_PIS_COFINS.AsString  := sqqProdutoPIS_COFINS.FieldByName('OP_DESCRICAO_LEI_PIS_COFINS').AsString;
    cdsVendaPisCofins.Post;
    sqqProdutoPIS_COFINS.Next;

  end;

  sqqProdutoPIS_COFINS.Close;
  cdsVendaPisCofins.First;

end;

end.
