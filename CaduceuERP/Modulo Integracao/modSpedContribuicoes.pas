unit modSpedContribuicoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, DateUtils,
  ACBrEPCBlocos, Db;

procedure Gerar_SPED_Contribuicoes(sArquivoSPED_Contribuicoes: string);
function Retornar_versao_SPEDContribuicoes(pDataI, pDataF: TDateTime)  : ACBrEPCBlocos.TACBrVersaoLeiaute;
function ObterIndiceRegistro0140(pCOD_EST0140: string): integer;
function ObterIndiceRegistro0500(pDATA:TDateTime; pCONTA: string): integer;
function ObterIndiceRegistroC400(pCOD_C400: string): integer;
function ObterIndiceRegistroC405(pData:TDateTime;pCRO, pCRZ, pCOO_FIN, pIndC400:integer):integer;
function LocalizarRegistro0400(pCOD_EST0140: string): boolean;
function LocalizarRegistroC481(pCOD_ITEM, pCST, pSerieECF:string;pAliq:currency): boolean;
function LocalizarRegistro0500(pDATA:TDateTime; pCONTA: string): boolean;
procedure Gravar_Bloco_0;
procedure Gravar_Registro0150(pCodigo_Participante:string);
procedure Gravar_Registro0190(pUnidade:string;pMostraMSG:boolean);
procedure Gravar_Registro0200(pOpcao:smallint;pCodigoItem, pUnidade:string;pMostraMSG:boolean);
procedure Gravar_Registro0400(pCfop:string);
procedure Gravar_Registro0500(pOpcao:smallint);
procedure Gravar_Bloco_A;     // falta gerar informa��es
procedure Gravar_Bloco_C100;
procedure Gravar_Bloco_C400;
procedure Gravar_Bloco_D;     // falta gerar informa��es
procedure Gravar_Bloco_F;     // falta gerar informa��es
procedure Gravar_Bloco_I;     // falta gerar informa��es
procedure Gravar_Bloco_M400;
procedure Gravar_Bloco_M;
procedure Gravar_Bloco_P;     // falta gerar informa��es
procedure Gravar_Bloco_1;     // falta gerar informa��es
procedure ResetarTabelasTemporarias;
procedure AbrirTabelas;
function ValidarCST_PIS_COFINS_CREDITO_REC(pOpcap:smallint;pCST:string):boolean;
function ValidarCOD_CONT_m210(pCod_Cont:string):boolean;

var
  iHoraFinal: TDateTime;
  iCodigo0450, iMunicipioFilial, iTotalRegistros, iRegistroAtual:integer;
  sCod_Cont_M210:string;
  cVL_REC_BRT_M210, cVL_REC_BRT_M610, pAliq_Pis_M210, pAliq_Cofins_M610,
  cVL_BC_CONT_M210, cVL_BC_CONT_M610 : currency;

implementation

uses dataDBEXMaster, dataMProvider, uConstantes_Padrao, uFuncoes, modIntegracao,
  dataSintegraSped;

function LocalizarRegistro0400(pCOD_EST0140: string): boolean;
var
  indice140,IntFor0400: integer;
begin

  Result := false;

  indice140 := ObterIndiceRegistro0140(pCOD_EST0140);

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    for IntFor0400 := 0 to Registro0140.Items[indice140].Registro0400.Count - 1 do
    begin

      if Registro0140.Items[indice140].Registro0400.Items[IntFor0400].COD_NAT = pCOD_EST0140 then
      begin

        Result := True;
        Break;

      end;

    end;

  end;

end;

procedure Gerar_SPED_Contribuicoes(sArquivoSPED_Contribuicoes: string);
var
  i, iTotaRegistros,  iTotalReg0_10, iTotalReg0_1 : integer;
begin

  AbrirTabelas;
  ResetarTabelasTemporarias;

  frmIntegracao.pnlProgresso.Visible        := True;
  frmIntegracao.advMarquueProcesso.Animate  := frmIntegracao.pnlProgresso.Visible;

  frmIntegracao.memConteudoSPEDContribuicoes.Visible := False;
  frmIntegracao.memConteudoSPEDContribuicoes.Clear;

  sCod_Cont_M210 := FormatFloat('00',frmIntegracao.rgpTipoContrApurada.ItemIndex + 1);

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[0] then
  begin

    frmIntegracao.ACBrSPEDPisCofins1.DT_INI     := frmIntegracao.dtpSpedContribuicoesInicial.Date;
    frmIntegracao.ACBrSPEDPisCofins1.DT_FIN     := frmIntegracao.dtpSpedContribuicoesFinal.Date;

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco 0 - Abertura, identifica��o e refer�ncias';
    Application.ProcessMessages;

    Gravar_Bloco_0;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[1] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco A - Documentos Fiscais - Servi�os (n�o sujeitos ao icms)';

    Gravar_Bloco_A;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[2] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco C - Docs Fiscais I-Merc(ICMS/IPI)';
    Application.ProcessMessages;

    Gravar_Bloco_C100;

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco C - Equipamento ECF';
    Application.ProcessMessages;

    Gravar_Bloco_C400;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[3] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco D - Documentos Fiscais II - Servi�os (ICMS)';
    Application.ProcessMessages;

    Gravar_Bloco_D;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[4] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco F - Demais documentos e opera��es';
    Application.ProcessMessages;

    Gravar_Bloco_F;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[5] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco I - Demais documentos e opera��es';
    Application.ProcessMessages;

    Gravar_Bloco_I;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[6] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco M - Apura��o da contrib. e cr�d. PIS/PASEP e da COFINS';
    Application.ProcessMessages;

    Gravar_Bloco_M400;
    Gravar_Bloco_M;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[7] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco P - Demais documentos e opera��es';
    Application.ProcessMessages;

    Gravar_Bloco_P;

  end;

  if frmIntegracao.chkBlocosSpedContribuicoes.Checked[8] then
  begin

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco 1 - Complemento da escritura��o';
    Application.ProcessMessages;

    Gravar_Bloco_1;

  end;

  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_0;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_A(True);
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_C(True);
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_D;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_F;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_I;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_M;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_P;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_1;
  frmIntegracao.ACBrSPEDPisCofins1.WriteBloco_9;
  frmIntegracao.memConteudoSPEDContribuicoes.Visible := False;

  frmIntegracao.lblMsg.Caption              := '';
  frmIntegracao.lblC470.Caption             := '';
  frmIntegracao.pnlProgresso.Visible        := False;
  frmIntegracao.advMarquueProcesso.Animate  := frmIntegracao.pnlProgresso.Visible;

  iHoraFinal := Time;

  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Clear;
  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Add('');
  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Add(dmDBEXMaster.sNomeUsuario + ', o arquivo:');
  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Add(sArquivoSPED_Contribuicoes + ', foi criado com sucesso!');
  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Add('----------------------------| Estat�sticas |----------------------------');
  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Add('Tempo gasto---------------------> ' + TimeToStr(iHoraFinal - frmIntegracao.iHoraInicial));
  frmIntegracao.memConteudoSPEDContribuicoes.Lines.Add('------------------------------------------------------------------------');

  for i := 0 to frmIntegracao.memConteudoSPEDContribuicoes.Lines.Count - 1 do
    SendMessage(frmIntegracao.memConteudoSPEDContribuicoes.handle, EM_LINESCROLL, SB_LINEUP, -1);

  frmIntegracao.memConteudoSPEDContribuicoes.Visible := True;

  Application.ProcessMessages;

end;

procedure Gravar_Registro0150(pCodigo_Participante:string);
var
  i:integer;
begin

  dmSintegraSPED.fdqSelFornecedor.Close;
  dmSintegraSPED.fdqSelFornecedor.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
  dmSintegraSPED.fdqSelFornecedor.open;

  if not dmSintegraSPED.fdqSelFornecedor.IsEmpty then
  begin

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
    begin

      with Registro0140 do
      begin

        if not Items[ObterIndiceRegistro0140(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value)].Registro0150.LocalizaRegistro(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value) then
        begin

          with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
          begin

            with Registro0150New do
            begin

              COD_PART      := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
              NOME          := Trim(RetirarAcentuacaoString(dmSintegraSPED.fdqSelFornecedorRAZAOSOCIAL.Value));
              COD_PAIS      := IntToStr(dmSintegraSPED.fdqSelFornecedorPAIS.Value);

              if dmSintegraSPED.fdqSelFornecedorPAIS.Value <> dmMProvider.cdsFilialPAIS.Value then
              begin

                CNPJ        := '';
                CPF         := '';

              end
              else
              begin

                case dmSintegraSPED.fdqSelFornecedorTIPO.Value of
                  0:begin

                      CNPJ  := '';
                      CPF   := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;

                    end;
                  1:begin

                      CNPJ  := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                      CPF   := '';

                    end;

                end;

              end;

              if dmSintegraSPED.fdqSelFornecedorINSCRICAO.Value = 'ISENTO' then
                IE := ''
              else
                IE := dmSintegraSPED.fdqSelFornecedorINSCRICAO.Value;

              COD_MUN   := dmSintegraSPED.fdqSelFornecedorCODIGO_MUNICIPIO.Value;
              SUFRAMA   := Trim(dmSintegraSPED.fdqSelFornecedorINSCRICAO_SUFRAMA.Value);
              ENDERECO  := Trim(dmSintegraSPED.fdqSelFornecedorENDERECO.Value);

              if dmSintegraSPED.fdqSelFornecedorNUMERO.Value <= 0 then
                NUM := ''
              else
                NUM := InttoStr(dmSintegraSPED.fdqSelFornecedorNUMERO.Value);

              COMPL   := Trim(dmSintegraSPED.fdqSelFornecedorCOMPLEMENTO.Value);
              BAIRRO  := Trim(dmSintegraSPED.fdqSelFornecedorBAIRRO.Value);

            end;

          end;

        end;

      end;

    end;

  end
  else
  begin

    dmSintegraSPED.fdqSelFornecedor.Close;

    dmSintegraSPED.fdqSelClientes.Close;
    dmSintegraSPED.fdqSelClientes.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
    dmSintegraSPED.fdqSelClientes.Open;

    if not dmSintegraSPED.fdqSelClientes.Isempty then
    begin

      with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
      begin

        with Registro0140 do
        begin

          if not Items[ObterIndiceRegistro0140(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value)].Registro0150.LocalizaRegistro(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value) then
          begin

            with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
            begin

              with Registro0150New do
              begin

                COD_PART      := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                NOME          := Trim(RetirarAcentuacaoString(dmSintegraSPED.fdqSelClientesRAZAOSOCIAL.Value));
                COD_PAIS      := IntToStr(dmSintegraSPED.fdqSelClientesPAIS.Value);

                if dmSintegraSPED.fdqSelClientesPAIS.Value <> dmMProvider.cdsFilialPAIS.Value then
                begin

                  CNPJ        := '';
                  CPF         := '';

                end
                else
                begin

                  case dmSintegraSPED.fdqSelClientesTIPO.Value of
                    0:begin

                        CNPJ  := '';
                        CPF   := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;

                      end;
                    1:begin

                        CNPJ  := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                        CPF   := '';

                      end;

                  end;

                end;

                if dmSintegraSPED.fdqSelClientesINSCRICAO.Value = 'ISENTO' then
                  IE := ''
                else
                  IE := dmSintegraSPED.fdqSelClientesINSCRICAO.Value;

                COD_MUN   := dmSintegraSPED.fdqSelClientesCODIGO_MUNICIPIO.Value;
                SUFRAMA   := Trim(dmSintegraSPED.fdqSelClientesINSCRICAO_SUFRAMA.Value);
                ENDERECO  := Trim(dmSintegraSPED.fdqSelClientesENDERECOENTREGA.Value);

                if dmSintegraSPED.fdqSelClientesNUMEROENTREGA.Value <= 0 then
                  NUM := ''
                else
                  NUM := InttoStr(dmSintegraSPED.fdqSelClientesNUMEROENTREGA.Value);

                COMPL   := Trim(dmSintegraSPED.fdqSelClientesCOMPLEMENTO.Value);
                BAIRRO  := Trim(dmSintegraSPED.fdqSelClientesBAIRROENTREGA.Value);

              end;

            end;

          end;

        end;

      end;

    end;

  end;

  dmSintegraSPED.fdqSelClientes.Close;

end;

procedure Gravar_Registro0190(pUnidade:string;pMostraMSG:boolean);
begin

  dmMProvider.cdsUndMedida.Close;
  dmMProvider.cdsUndMedida.ProviderName := 'dspUndMedida';

  dmDBEXMaster.fdqUnidadeMedida.SQL.Clear;
  dmDBEXMaster.fdqUnidadeMedida.SQL.Add('select * from unidade_medida');
  dmDBEXMaster.fdqUnidadeMedida.SQL.Add('where unidade = ' + QuotedStr(pUnidade));

  dmMProvider.cdsUndMedida.Open;
  dmMProvider.cdsUndMedida.ProviderName := '';

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    with Registro0140 do
    begin

      if not Items[ObterIndiceRegistro0140(pUnidade)].Registro0190.LocalizaRegistro(pUnidade) then
      begin

        with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
        begin

          with Registro0190New do
          begin

            UNID    := pUnidade;
            DESCR   := Trim(dmMProvider.cdsUndMedidaDESCRICAO.Value);

          end;

        end;

      end;

    end;

  end;

end;

procedure Gravar_Registro0200(pOpcao:smallint;pCodigoItem, pUnidade:string;pMostraMSG:boolean);
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    dmMProvider.cdsBarras.FindKey([pCodigoItem]);

    with Registro0140 do
    begin

      Gravar_Registro0190(pUnidade, false{(pOpcao <> 1)});

      if not Items[ObterIndiceRegistro0140(IntToStr(StrToInt(pCodigoItem)))].Registro0200.LocalizaRegistro(IntToStr(StrToInt(pCodigoItem))) then
      begin

        with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
        begin


          with Registro0200New do
          begin

            case pOpcao of
              0:begin//C170

                  COD_ITEM    := IntToStr(StrToInt(pCodigoItem));
                  DESCR_ITEM  := Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_DESCRICAO_COMPLEMENTAR.Value);

                  if dmMProvider.cdsBarrasGERADO.Value = 0 then
                    COD_BARRA := dmMProvider.cdsBarrasBARRAS.Value
                  else
                    COD_BARRA   := '';

                  UNID_INV    := dmSintegraSPED.cdsSelRC170_SPEDOP_UNIDADE.Value;
                  TIPO_ITEM   := ACBrEPCBlocos.StrToTipoItem(InttoStr(dmSintegraSPED.cdsSelRC170_SPEDOP_TIPO_ITEM.Value));
                  COD_NCM     := dmSintegraSPED.cdsSelRC170_SPEDOP_NCM.Value;

                  if dmSintegraSPED.cdsSelRC170_SPEDOP_NCM.Value <> '' then
                    COD_GEN := Copy(dmSintegraSPED.cdsSelRC170_SPEDOP_NCM.Value,1,2);

                  ALIQ_ICMS   := dmSintegraSPED.cdsSelRC170_SPEDOP_ALIQUOTA_ICMS.Value;

                end;

              1:begin//C425/C481

                  COD_ITEM    := IntToStr(StrToInt(pCodigoItem));
                  DESCR_ITEM  := Trim(dmSintegraSPED.cdsSelRC470_SPEDCOP_DESCRICAO.Value);

                  if dmMProvider.cdsBarrasGERADO.Value = 0 then
                    COD_BARRA := dmMProvider.cdsBarrasBARRAS.Value
                  else
                    COD_BARRA   := '';

                  UNID_INV    := pUnidade;
                  TIPO_ITEM   := StrToTipoItem(IntToStr(dmSintegraSPED.cdsSelRC470_SPEDCOP_TIPO_ITEM.Value));
                  COD_NCM     := dmSintegraSPED.cdsSelRC470_SPEDCOP_NCM.Value;

                  if COD_NCM <> '' then
                    COD_GEN := Copy(COD_NCM,1,2);

                  ALIQ_ICMS   := dmSintegraSPED.cdsSelRC470_SPEDCOP_ALIQUOTA_ICMS.Value;

                end;
              2:begin//H

                  COD_ITEM    := IntToStr(StrToInt(pCodigoItem));
                  DESCR_ITEM  := Trim(dmSintegraSPED.cdsSelItemInventarioDESCRICAO.Value);

                  if dmMProvider.cdsBarrasGERADO.Value = 0 then
                    COD_BARRA := dmMProvider.cdsBarrasBARRAS.Value
                  else
                    COD_BARRA   := '';

                  UNID_INV    := pUnidade;
                  TIPO_ITEM   := StrToTipoItem(IntToStr(dmSintegraSPED.cdsSelItemInventarioTIPO_ITEM.Value));
                  COD_NCM     := dmSintegraSPED.cdsSelItemInventarioNCM.Value;

                  if COD_NCM <> '' then
                    COD_GEN := Copy(COD_NCM,1,2);

                  ALIQ_ICMS   := dmSintegraSPED.cdsSelItemInventarioALIQUOTA_ICMS.Value;

                end;
            end;


          end;

          //REGISTRO 0206: C�DIGO DE PRODUTO CONFORME TABELA PUBLICADA PELA ANP (COMBUST�VEIS)
         //        With Registro0206New do
         //        begin
         //          COD_COMB := '910101001';
         //        end;

        end;


      end;

    end;

  end;

end;

procedure Gravar_Registro0400(pCfop:string);
var
  intFor0400: integer;

begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    with Registro0140 do
    begin

      if  not LocalizarRegistro0400(pCfop) then
      begin

        with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
        begin

          dmMProvider.cdsCFOP_CFPS.FindKey([pCfop]);

          with Registro0400New do
          begin

            COD_NAT   := pCfop;
            DESCR_NAT := dmMProvider.cdsCFOP_CFPSDESCRICAO.Value;

          end;


        end;


      end;

    end;

  end;

end;

procedure Gravar_Bloco_0;
begin

  dmMProvider.cdsCidades.Close;
  dmMProvider.cdsCidades.ProviderName := 'dspCidades';

  dmDBEXMaster.fdqCidades.SQL.Clear;
  dmDBEXMaster.fdqCidades.SQL.Add('SELECT * FROM CIDADES');
  dmDBEXMaster.fdqCidades.SQL.Add('WHERE CIDADE = ' + IntToStr(dmMProvider.cdsFilialCIDADE.Value));

  dmMProvider.cdsCidades.Open;
  dmMProvider.cdsCidades.ProviderName     := '';

  if not frmIntegracao.chkGerarSPEDContribuicoesSM.Checked then
  begin

    with frmIntegracao.ACBrSPEDPisCofins1 do
    begin

      DT_INI := frmIntegracao.dtpSpedContribuicoesInicial.Date;
      DT_FIN := frmIntegracao.dtpSpedContribuicoesFinal.Date;

      IniciaGeracao;

    end;

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
    begin

      with Registro0000New do
      begin

        COD_VER            := Retornar_versao_SPEDContribuicoes(frmIntegracao.dtpSpedContribuicoesInicial.Date, frmIntegracao.dtpSpedContribuicoesFinal.Date);
        TIPO_ESCRIT        := TACBrTipoEscrituracao(frmIntegracao.rgpTipoEscrituracao.ItemIndex);
        IND_SIT_ESP        := TACBrIndicadorSituacaoEspecial(frmIntegracao.rgpIndicadorSitacao.ItemIndex);
        NUM_REC_ANTERIOR   := frmIntegracao.edtNumeroEscrituracaoAnterior.Text;
        NOME               := Trim(dmMProvider.cdsFilialRAZAOSOCIAL.Value);
        CNPJ               := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
        UF                 := dmMProvider.cdsFilialESTADO.Value;
        COD_MUN            := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

        iMunicipioFilial   := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

        SUFRAMA            := dmMProvider.cdsFilialINSCRICAO_SUFRAMA.Value;
        IND_NAT_PJ         := TACBrIndicadorNaturezaPJ(dmMProvider.cdsFilialNATUREZA_PESSOA_JURIDICA.Value);
        IND_ATIV           := TACBrIndicadorAtividade(dmMProvider.cdsFilialTIPO_EMPRESA.Value);

        with Registro0001New do
        begin

          IND_MOV := imComDados;

          dmMProvider.cdsCidades.Close;
          dmMProvider.cdsCidades.ProviderName := 'dspCidades';

          dmDBEXMaster.fdqCidades.SQL.Clear;
          dmDBEXMaster.fdqCidades.SQL.Add('SELECT * FROM CIDADES');
          dmDBEXMaster.fdqCidades.SQL.Add('WHERE CIDADE = ' + IntToStr(dmMProvider.cdsConfiguracoesCIDADE_CONTADOR.Value));

          dmMProvider.cdsCidades.Open;
          dmMProvider.cdsCidades.ProviderName := '';

          // FILHO - Dados do contador.
          with Registro0100New do
          begin

            NOME       := Trim(dmMProvider.cdsConfiguracoesNOME_CONTADOR.Value);
            CPF        := LimparCpnjInscricao(dmMProvider.cdsConfiguracoesCPF_CONTADOR.Value);
            CRC        := Trim(dmMProvider.cdsConfiguracoesCRC_CONTADOR.Value);
            CNPJ       := LimparCpnjInscricao(dmMProvider.cdsConfiguracoesCNPJ_CONTADOR.Value);
            CEP        := dmMProvider.cdsConfiguracoesCEP_CONTADOR.Value;
            ENDERECO   := Trim(dmMProvider.cdsConfiguracoesENDERECO_CONTADOR.Value);
            NUM        := dmMProvider.cdsConfiguracoesNUMERO_CONTADOR.Value;
            COMPL      := Trim(dmMProvider.cdsConfiguracoesCOMPLEMENTO_CONTADOR.Value);
            BAIRRO     := Trim(dmMProvider.cdsConfiguracoesBAIRRO_CONTADOR.Value);

            if Length(Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value))> 0 then
              FONE     := Trim(dmMProvider.cdsConfiguracoesDDD_CONTADOR.Value)+ Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value)
            else
              FONE     := '';

            if Length(Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value))> 0 then
              FAX      := Trim(dmMProvider.cdsConfiguracoesDDD_CONTADOR.Value)+ Trim(dmMProvider.cdsConfiguracoesFAX_CONTADOR.Value)
            else
              FAX      := '';

            EMAIL      := Trim(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.Value);

            COD_MUN    := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

            // FILHO - Regime de Apura��o
            with Registro0110New do
            begin

              COD_INC_TRIB    := StrToCodIncTrib(IntToStr(frmIntegracao.rgpRegimeApuracao.ItemIndex + 1));
              IND_APRO_CRED   := StrToIndAproCred(IntToStr(frmIntegracao.rgpMetodoApropriacaoCredito.ItemIndex + 1));
              COD_TIPO_CONT   := StrToCodTipoCont(IntToStr(frmIntegracao.rgpTipoContrApurada.ItemIndex + 1));
              IND_REG_CUM     := ACBrEPCBlocos.TACBrCodIndCritEscrit(frmIntegracao.rgpCriterioApuracao.ItemIndex);

            end;

            with Registro0140New do
            begin

              COD_EST     := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
              NOME        := Trim(dmMProvider.cdsFilialRAZAOSOCIAL.Value);
              CNPJ        := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
              UF          := dmMProvider.cdsFilialESTADO.Value;
              IE          := LimparCpnjInscricao(dmMProvider.cdsFilialINSCRICAO.Value);
              COD_MUN     := iMunicipioFilial;
              IM          := Trim(dmMProvider.cdsFilialINSCRICAO_MUNICIPAL.Value);
              SUFRAMA     := Trim(dmMProvider.cdsFilialINSCRICAO_SUFRAMA.Value);

            end;

          end;

        end;

      end;

    end;

  end
  else
  begin

    with frmIntegracao.ACBrSPEDPisCofins1 do
    begin

      DT_INI := frmIntegracao.dtpSpedContribuicoesInicial.Date;
      DT_FIN := frmIntegracao.dtpSpedContribuicoesFinal.Date;
      IniciaGeracao;

    end;

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
    begin

      // Dados da Empresa
      with Registro0000New do
      begin

        COD_VER            := Retornar_versao_SPEDContribuicoes(frmIntegracao.dtpSpedContribuicoesInicial.Date, frmIntegracao.dtpSpedContribuicoesFinal.Date);
        TIPO_ESCRIT        := TACBrTipoEscrituracao(frmIntegracao.rgpTipoEscrituracao.ItemIndex);
        IND_SIT_ESP        := TACBrIndicadorSituacaoEspecial(frmIntegracao.rgpIndicadorSitacao.ItemIndex);
        NUM_REC_ANTERIOR   := frmIntegracao.edtNumeroEscrituracaoAnterior.Text;
        NOME               := Trim(dmMProvider.cdsFilialRAZAOSOCIAL.Value);
        CNPJ               := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
        UF                 := dmMProvider.cdsFilialESTADO.Value;
        COD_MUN            := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

        iMunicipioFilial   := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

        SUFRAMA            := dmMProvider.cdsFilialINSCRICAO_SUFRAMA.Value;
        IND_NAT_PJ         := TACBrIndicadorNaturezaPJ(dmMProvider.cdsFilialNATUREZA_PESSOA_JURIDICA.Value);
        IND_ATIV           := TACBrIndicadorAtividade(dmMProvider.cdsFilialTIPO_EMPRESA.Value);

        with Registro0001New do
        begin

          IND_MOV := imComDados;

          dmMProvider.cdsCidades.Close;
          dmMProvider.cdsCidades.ProviderName := 'dspCidades';

          dmDBEXMaster.fdqCidades.SQL.Clear;
          dmDBEXMaster.fdqCidades.SQL.Add('SELECT * FROM CIDADES');
          dmDBEXMaster.fdqCidades.SQL.Add('WHERE CIDADE = ' + IntToStr(dmMProvider.cdsConfiguracoesCIDADE_CONTADOR.Value));

          dmMProvider.cdsCidades.Open;
          dmMProvider.cdsCidades.ProviderName := '';

          // FILHO - Dados do contador.
          with Registro0100New do
          begin

            NOME       := Trim(dmMProvider.cdsConfiguracoesNOME_CONTADOR.Value);
            CPF        := LimparCpnjInscricao(dmMProvider.cdsConfiguracoesCPF_CONTADOR.Value);
            CRC        := Trim(dmMProvider.cdsConfiguracoesCRC_CONTADOR.Value);
            CNPJ       := LimparCpnjInscricao(dmMProvider.cdsConfiguracoesCNPJ_CONTADOR.Value);
            CEP        := dmMProvider.cdsConfiguracoesCEP_CONTADOR.Value;
            ENDERECO   := Trim(dmMProvider.cdsConfiguracoesENDERECO_CONTADOR.Value);
            NUM        := dmMProvider.cdsConfiguracoesNUMERO_CONTADOR.Value;
            COMPL      := Trim(dmMProvider.cdsConfiguracoesCOMPLEMENTO_CONTADOR.Value);
            BAIRRO     := Trim(dmMProvider.cdsConfiguracoesBAIRRO_CONTADOR.Value);

            if Length(Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value))> 0 then
              FONE     := Trim(dmMProvider.cdsConfiguracoesDDD_CONTADOR.Value)+ Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value)
            else
              FONE     := '';

            if Length(Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value))> 0 then
              FAX      := Trim(dmMProvider.cdsConfiguracoesDDD_CONTADOR.Value)+ Trim(dmMProvider.cdsConfiguracoesFAX_CONTADOR.Value)
            else
              FAX      := '';

            EMAIL      := Trim(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.Value);

            COD_MUN    := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

            // FILHO - Regime de Apura��o
            with Registro0110New do
            begin

              COD_INC_TRIB    := StrToCodIncTrib(IntToStr(frmIntegracao.rgpRegimeApuracao.ItemIndex + 1));
              IND_APRO_CRED   := StrToIndAproCred(IntToStr(frmIntegracao.rgpMetodoApropriacaoCredito.ItemIndex + 1));
              COD_TIPO_CONT   := StrToCodTipoCont(IntToStr(frmIntegracao.rgpTipoContrApurada.ItemIndex + 1));
              IND_REG_CUM     := ACBrEPCBlocos.TACBrCodIndCritEscrit(frmIntegracao.rgpCriterioApuracao.ItemIndex);

            end;

            with Registro0140New do
            begin

              COD_EST     := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
              NOME        := Trim(dmMProvider.cdsFilialRAZAOSOCIAL.Value);
              CNPJ        := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
              UF          := dmMProvider.cdsFilialESTADO.Value;
              IE          := LimparCpnjInscricao(dmMProvider.cdsFilialINSCRICAO.Value);
              COD_MUN     := iMunicipioFilial;
              IM          := Trim(dmMProvider.cdsFilialINSCRICAO_MUNICIPAL.Value);
              SUFRAMA     := Trim(dmMProvider.cdsFilialINSCRICAO_SUFRAMA.Value);

            end;

          end;

        end;

      end;

    end;

  end;

end;

procedure Gravar_Bloco_A;
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_A do
  begin

    with RegistroA001New do
    begin

      IND_MOV := imSemDados;

    end;

  end;

end;

procedure Gravar_Bloco_C100;
var
  iNum_Item, iCodigoSituacao, iContaIten, iCodCredPisCofins, iCodNatReceitaPisCofins :integer;
  sCst, sCst_IPI, sCst_PIS, sCst_COFINS, sNF_ant, sNat_Rec : string;
  cAliquota, cP_Desconto, cTotalCreditos, cTotalDebitos,  cBase_Pis,
  cBase_Cofins, cValor_Pis, cValor_Cofins, cTValor_Pis,cTValor_Cofins, cVlr_PisC100, cVlr_Cofinsc100: currency;
begin

  cVL_REC_BRT_M210        := 0;
  cVL_REC_BRT_M610        := 0;
  iCodCredPisCofins       := 0;
  iCodNatReceitaPisCofins := 0;

  if frmIntegracao.chkGerarSPEDContribuicoesSM.Checked then
  begin

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_C do
    begin

      with RegistroC001New do
        IND_MOV := imSemDados;

    end;

  end
  else
  begin

    dmSintegraSPED.cdsSelRC100_SPED.Close;
    dmSintegraSPED.cdsSelRC100_SPED.ProviderName    := 'dspSelRC100_SPED';

    dmSintegraSPED.fdqSelRC100_SPED.Params[0].Value := frmIntegracao.dtpSpedContribuicoesInicial.Date;
    dmSintegraSPED.fdqSelRC100_SPED.Params[1].Value := frmIntegracao.dtpSpedContribuicoesFinal.Date;
    dmSintegraSPED.fdqSelRC100_SPED.Params[2].Value := 0;

    dmSintegraSPED.cdsSelRC100_SPED.Open;
    dmSintegraSPED.cdsSelRC100_SPED.ProviderName    := '';

    iTotalRegistros                                 := dmSintegraSPED.cdsSelRC100_SPED.RecordCount;
    iRegistroAtual                                  := 0;
    iCodigoSituacao                                 := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_SITUACAO.Value;

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_C do
    begin

      with RegistroC001New do
      begin

        IND_MOV := imComDados;

        with RegistroC010New do
        begin

          CNPJ            := LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value);
          IND_ESCRI       := StrToIndEscrituracao(IntToStr(frmIntegracao.rdgIndicadorApuracaoContr.ItemIndex + 1));

          while not dmSintegraSPED.cdsSelRC100_SPED.Eof do
          begin

            iCodigoSituacao  := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_SITUACAO.Value;

            Gravar_Registro0150(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value);

            inc(iRegistroAtual);

            frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco C - Documentos Fiscais I - Mercadorias (ICMS/IPI)' + '/NF-'
                                            + FormatFloat('000000', dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value)
                                            + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
            Application.ProcessMessages;

            cVlr_PisC100    := 0;
            cVlr_Cofinsc100 := 0;

            if dmMProvider.cdsFilialREGIME_TRIBUTARIO.Value = 2 then
            begin

              cTValor_Pis     := 0;
              cTValor_Cofins  := 0;

              with RegistroC100New do
              begin

                IND_OPER        := TACBrTipoOperacao(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_OPERACAO.Value));
                IND_EMIT        := TACBrEmitente(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_EMITENTE.Value));
                COD_MOD         := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
                COD_SIT         := StrToCodSit(IntToStr(iCodigoSituacao));
                SER             := dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value;
                NUM_DOC         := IntToStr(dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value);

                if (iCodigoSituacao <> 5)  then
                begin

                  COD_PART        := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                  CHV_NFE         := dmSintegraSPED.cdsSelRC100_SPEDOP_CHAVE_NFE.Value;
                  DT_DOC          := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_EMISSAO.Value;
                  DT_E_S          := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_ENTRADA_SAIDA.Value;
                  VL_DOC          := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_DOCUMENTO.Value;

                  // verifica se a nota tem parcelas
                  dmSintegraSPED.cdsSelRC140_SPED.Close;
                  dmSintegraSPED.cdsSelRC140_SPED.ProviderName    := 'dspSelRC140_SPED';

                  dmSintegraSPED.fdqSelRC140_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                  dmSintegraSPED.fdqSelRC140_SPED.Params[1].Value := IntToStr(dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value);

                  dmSintegraSPED.cdsSelRC140_SPED.Open;
                  dmSintegraSPED.cdsSelRC140_SPED.ProviderName    := '';

                  if dmSintegraSPED.cdsSelRC140_SPED.IsEmpty then
                    IND_PGTO := tpSemPagamento
                  else
                    IND_PGTO := tpPrazo;

                  VL_DESC       := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_DESCONTO.Value;
                  VL_ABAT_NT    := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_ABATIMENTO_NT.Value;
                  VL_MERC       := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_MERCADORIA.Value;

                  if StrtoInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_FRETE.Value) = 9 then
                    IND_FRT := StrToIndFrt('3')
                  else
                    IND_FRT := StrToIndFrt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_FRETE.Value);

                  VL_FRT        := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_FRETE.Value;
                  VL_SEG        := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_SEGURO.Value;
                  VL_OUT_DA     := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_OUTRAS_DESP.Value;
                  VL_BC_ICMS    := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_BASE_CALCULO.Value;
                  VL_ICMS       := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_ICMS.Value;
                  VL_BC_ICMS_ST := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_BASE_ICMS_ST.Value;
                  VL_ICMS_ST    := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_ICMS_ST.Value;
                  VL_IPI        := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_IPI.Value;
                  VL_PIS        := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_PIS.Value;
                  VL_PIS_ST     := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_PIS_ST.Value;
                  VL_COFINS     := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_COFINS.Value;
                  VL_COFINS_ST  := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_COFINS_ST.Value;

                  if (iCodigoSituacao = 8)  then
                  begin

                    with RegistroC110New do
                    begin

                      with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
                      begin

                        inc(iCodigo0450);

                        with Registro0450New do
                        begin

                          COD_INF :=  IntToStr(iCodigo0450);
                          TXT     := 'DOCUMENTO EMITIDO EM CONFORMIDADE COM CUPOM FISCAL';

                        end;

                      end;

                      COD_INF   := IntToStr(iCodigo0450);
                      TXT_COMPL := 'DOCUMENTO EMITIDO EM CONFORMIDADE COM CUPOM FISCAL';

                    end;

                  end;

                  dmSintegraSPED.cdsSelRC170_SPED.Close;
                  dmSintegraSPED.cdsSelRC170_SPED.ProviderName    := 'dspSelRC170_SPED';

                  dmSintegraSPED.fdqSelRC170_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_ENTRADA_SAIDA.Value;
                  dmSintegraSPED.fdqSelRC170_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value;
                  dmSintegraSPED.fdqSelRC170_SPED.Params[2].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
                  dmSintegraSPED.fdqSelRC170_SPED.Params[3].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value;
                  dmSintegraSPED.fdqSelRC170_SPED.Params[4].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                  dmSintegraSPED.fdqSelRC170_SPED.Params[5].Value := 0;

                  dmSintegraSPED.cdsSelRC170_SPED.Open;
                  dmSintegraSPED.cdsSelRC170_SPED.ProviderName    := '';

                  iNum_Item := 0;

                  while not dmSintegraSPED.cdsSelRC170_SPED.Eof do
                  begin

                    Application.ProcessMessages;

                    inc(iNum_Item);

                    with RegistroC170New do
                    begin

                      Gravar_Registro0200(0, Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_COD_ITEM.Value), dmSintegraSPED.cdsSelRC170_SPEDOP_UNIDADE.Value, False);
                      Gravar_Registro0400(dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value);
                      Gravar_Registro0500(0);

                      NUM_ITEM      := FormatFloat('000', iNum_Item);
                      COD_ITEM      := InttoStr(StrToInt(Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_COD_ITEM.Value)));
                      DESCR_COMPL   := Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_DESCRICAO_COMPLEMENTAR.Value);
                      QTD           := dmSintegraSPED.cdsSelRC170_SPEDOP_QUANTIDADE.Value;
                      UNID          := dmSintegraSPED.cdsSelRC170_SPEDOP_UNIDADE.Value;
                      VL_ITEM       := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;
                      VL_DESC       := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_DESCONTO.Value;
                      IND_MOV       := StrToIndMovFisica(dmSintegraSPED.cdsSelRC170_SPEDOP_IND_MOVIMENTACAO.Value);
                      CST_ICMS      := StrToCstIcms(FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_CST_ICMS.Value));
                      CFOP          := dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value;
                      COD_NAT       := dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value;
                      VL_BC_ICMS    := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_ICMS.Value;
                      ALIQ_ICMS     := dmSintegraSPED.cdsSelRC170_SPEDOP_ALIQUOTA_ICMS.Value;
                      VL_ICMS       := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ICMS.Value;
                      VL_BC_ICMS_ST := 0;
                      ALIQ_ST       := 0;
                      VL_ICMS_ST    := 0;
                      IND_APUR      := iaMensal;

                      if dmMProvider.cdsFilialCONTRIBUINTEDOIPI.Value = 1 then
                        CST_IPI := StrToCstIpi(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_IPI.Value);

                      COD_ENQ       := '';
                      VL_BC_IPI     := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_CALC_IPI.Value;
                      ALIQ_IPI      := dmSintegraSPED.cdsSelRC170_SPEDOP_ALIQUOTA_IPI.Value;
                      VL_IPI        := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_IPI.Value;
                      CST_PIS       := StrToCstPis(FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value)));

//                      QUANT_BC_PIS  := null;
//                      ALIQ_PIS_R    := null;//dmSintegraSPED.cdsSelRC170_SPEDOP_V_ALIQ_PIS.Value;
                      CST_COFINS    := StrToCstCofins(FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value)));

//                      QUANT_BC_COFINS   := null;
//                      ALIQ_COFINS_R     := null;//dmSintegraSPED.cdsSelRC170_SPEDOP_V_ALIQUOTA_COFINS.Value;

                      COD_CTA           := dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CONTA_ANALITICA.Value;

                      VL_BC_PIS         := 0;
                      ALIQ_PIS_PERC     := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_PIS.Value;

                      VL_PIS            := 0;
                      VL_BC_COFINS      := 0;
                      ALIQ_COFINS_PERC  := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_COFINS.Value;
                      VL_COFINS         := 0;

                      if dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CRED_PIS_COFINS_CFOP.Value > 0 then
                        iCodCredPisCofins := dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CRED_PIS_COFINS_CFOP.Value
                      else
                        iCodCredPisCofins := dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value;

                      if (dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value[1] = '1') or (dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value[1] = '2') or (dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value[1] = '3') then
                      begin //=== entrada aquisi��o

                        //if (Length(Trim(LimparCpnjInscricao(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value))) > 11) then
                        //begin

                          if  (dmSintegraSPED.cdsSelRC170_SPEDOP_GERA_CRED_PIS_COFINS.Value = 1) and ( iCodCredPisCofins > 0) then
                          begin

                            if ValidarCST_PIS_COFINS_CREDITO_REC(0,FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value))) then
                            begin

                              VL_BC_PIS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;
                              ALIQ_PIS_PERC     := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_PIS.Value;
                              VL_PIS            := Arredondar(VL_BC_PIS * (ALIQ_PIS_PERC / 100),2);
                              VL_BC_COFINS      := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;
                              ALIQ_COFINS_PERC  := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_COFINS.Value;
                              VL_COFINS         := Arredondar(VL_BC_COFINS * (ALIQ_COFINS_PERC / 100),2);

                              cVlr_PisC100      := cVlr_PisC100 + VL_PIS;
                              cVlr_Cofinsc100   := cVlr_Cofinsc100 + VL_COFINS;

                              RegistroC100.Items[RegistroC100.Count -1].VL_PIS    := RegistroC100.Items[RegistroC100.Count -1].VL_PIS    + VL_PIS;
                              RegistroC100.Items[RegistroC100.Count -1].VL_COFINS := RegistroC100.Items[RegistroC100.Count -1].VL_COFINS + VL_COFINS;

// 08/09/2017                 if not dmSintegraSPED.cdsRegistroM100_TEMP.Locate('COD_CRED', dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value, []) then
                              if not dmSintegraSPED.cdsRegistroM100_TEMP.Locate('COD_CRED', iCodCredPisCofins, []) then
                              begin

                                dmSintegraSPED.cdsRegistroM100_TEMP.Append;
// 08/09/2017                   dmSintegraSPED.cdsRegistroM100_TEMPCOD_CRED.Value := FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value);
                                dmSintegraSPED.cdsRegistroM100_TEMPCOD_CRED.Value := FormatFloat('000',iCodCredPisCofins);

                              end
                              else
                                dmSintegraSPED.cdsRegistroM100_TEMP.Edit;

                              dmSintegraSPED.cdsRegistroM100_TEMPIND_CRED_ORI.Value      := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPVL_BC_PIS.Value         := dmSintegraSPED.cdsRegistroM100_TEMPVL_BC_PIS.Value +  VL_BC_PIS;//dmSintegraSPED.cdsRegistroM100_TEMPVL_BC_PIS.Value + dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_PIS.Value;
                              dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS. Value         := ALIQ_PIS_PERC; //dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_PIS.Value;
                              dmSintegraSPED.cdsRegistroM100_TEMPQUANT_BC_PIS.Value      := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS_QUANT.Value    := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED.Value           := dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED.Value + VL_PIS; //Arredondar((dmSintegraSPED.cdsRegistroM100_TEMPVL_BC_PIS.Value * (dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_PIS.Value / 100)), 2);
                              dmSintegraSPED.cdsRegistroM100_TEMPVL_AJUS_ACRES.Value     := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPVL_AJUS_REDUC.Value     := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED_DIF.Value       := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED_DISP.Value      := dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED.Value;

                              if frmIntegracao.rgpIndicadorSitacao.ItemIndex > 0 then
                                dmSintegraSPED.cdsRegistroM100_TEMPIND_DESC_CRED.Value   := '1'
                              else
                                dmSintegraSPED.cdsRegistroM100_TEMPIND_DESC_CRED.Value   := IntToStr(frmIntegracao.rgpIndicadorSitacao.ItemIndex);

                              dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED_DESC.Value      := 0;
                              dmSintegraSPED.cdsRegistroM100_TEMPSLD_CRED.Value          := (dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED.Value - dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED_DESC.Value);
                              dmSintegraSPED.cdsRegistroM100_TEMP.Post;

// 08/09/2017                 if not dmSintegraSPED.cdsRegistroM105_TEMP.locate('COD_CRED;NAT_BC_CRED;ALIQ_PIS', VarArrayOf([dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value, dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_BC_CRED.Value, dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS.Value]), [loPartialKey, loCaseinsensitive]) then
                              if not dmSintegraSPED.cdsRegistroM105_TEMP.locate('COD_CRED;NAT_BC_CRED;ALIQ_PIS', VarArrayOf([iCodCredPisCofins, dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_BC_CRED.Value, dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS.Value]), [loPartialKey, loCaseinsensitive]) then
                              begin

                                dmSintegraSPED.cdsRegistroM105_TEMP.Append;
                                dmSintegraSPED.cdsRegistroM105_TEMPNAT_BC_CRED.Value := dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_BC_CRED.Value;

                              end
                              else
                                dmSintegraSPED.cdsRegistroM105_TEMP.Edit;

// 08/09/2017                 dmSintegraSPED.cdsRegistroM105_TEMPCOD_CRED.Value         := IntToStr(dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value);
                              dmSintegraSPED.cdsRegistroM105_TEMPCOD_CRED.Value         := IntToStr(iCodCredPisCofins);
                              dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value          := StrToInt(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value);
                              dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_TOT.Value    := dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_TOT.Value + VL_BC_PIS; //dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_PIS.Value;
                              dmSintegraSPED.cdsRegistroM105_TEMPALIQ_PIS.Value         := ALIQ_PIS_PERC;// //dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS.Value;

                              case frmIntegracao.rgpRegimeApuracao.ItemIndex of
                                //cumulativo e n�o cumulativo
                                2:dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_CUM.Value:= dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_TOT.Value;
                              else
                                dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_CUM.Value  := 0;
                              end;

                              dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_NC.Value     := (dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_TOT.Value - dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_CUM.Value);

                              if (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 50) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 51) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 52)
                                  or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 60) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 61) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 62) then

                                dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS.Value      := dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_NC.Value

                              else
                              if (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 53) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 51) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 54)
                                  or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 55) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 56) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 63)
                                  or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 64) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 65) or (dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value  = 66) then

                                dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS.Value      := dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_NC.Value;

                              dmSintegraSPED.cdsRegistroM105_TEMPQUANT_BC_PIS_TOT.Value := 0;
                              dmSintegraSPED.cdsRegistroM105_TEMPQUANT_BC_PIS.Value     := 0;
                              dmSintegraSPED.cdsRegistroM105_TEMPDESCRICAO_CRED.Value   := '';
                              dmSintegraSPED.cdsRegistroM105_TEMP.Post;

// 08/09/2017                 if not dmSintegraSPED.cdsRegistroM500_TEMP.Locate('COD_CRED', dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value, []) then
                              if not dmSintegraSPED.cdsRegistroM500_TEMP.Locate('COD_CRED', iCodCredPisCofins, []) then
                              begin

                                dmSintegraSPED.cdsRegistroM500_TEMP.Append;
// 08/09/2017                   dmSintegraSPED.cdsRegistroM500_TEMPCOD_CRED.Value := FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value);
                                dmSintegraSPED.cdsRegistroM500_TEMPCOD_CRED.Value := FormatFloat('000',iCodCredPisCofins);

                              end
                              else
                                dmSintegraSPED.cdsRegistroM500_TEMP.Edit;

                              dmSintegraSPED.cdsRegistroM500_TEMPIND_CRED_ORI.Value       := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPVL_BC_COFINS.Value       := dmSintegraSPED.cdsRegistroM500_TEMPVL_BC_COFINS.Value + VL_BC_COFINS;
                              dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS. Value       := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_COFINS.Value;
                              dmSintegraSPED.cdsRegistroM500_TEMPQUANT_BC_COFINS.Value    := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS_QUANT.Value  := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED.Value            := Arredondar((dmSintegraSPED.cdsRegistroM500_TEMPVL_BC_COFINS.Value * (dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_COFINS.Value / 100)), 2);
                              dmSintegraSPED.cdsRegistroM500_TEMPVL_AJUS_ACRES.Value      := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPVL_AJUS_REDUC.Value      := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED_DIFER.Value      := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED_DISP.Value       := dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED.Value;

                              if frmIntegracao.rgpIndicadorSitacao.ItemIndex > 0 then
                                dmSintegraSPED.cdsRegistroM500_TEMPIND_DESC_CRED.Value   := '1'
                              else
                                dmSintegraSPED.cdsRegistroM500_TEMPIND_DESC_CRED.Value   := IntToStr(frmIntegracao.rgpIndicadorSitacao.ItemIndex);

                              dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED_DISP.Value       := 0;
                              dmSintegraSPED.cdsRegistroM500_TEMPSLD_CRED.Value           := (dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED.Value - dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED_DISP.Value);
                              dmSintegraSPED.cdsRegistroM500_TEMP.Post;

// 08/09/2017                 if not dmSintegraSPED.cdsRegistroM505_TEMP.locate('COD_CRED;NAT_BC_CRED;ALIQ_COFINS', VarArrayOf([dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value, dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_BC_CRED.Value, dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS.Value]), [loPartialKey, loCaseinsensitive]) then
                              if not dmSintegraSPED.cdsRegistroM505_TEMP.locate('COD_CRED;NAT_BC_CRED;ALIQ_COFINS', VarArrayOf([iCodCredPisCofins, dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_BC_CRED.Value, dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS.Value]), [loPartialKey, loCaseinsensitive]) then
                              begin

                                dmSintegraSPED.cdsRegistroM505_TEMP.Append;
                                dmSintegraSPED.cdsRegistroM505_TEMPNAT_BC_CRED.Value := dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_BC_CRED.Value;

                              end
                              else
                                dmSintegraSPED.cdsRegistroM505_TEMP.Edit;

// 08/09/2017                 dmSintegraSPED.cdsRegistroM505_TEMPCOD_CRED.Value             := IntToStr(dmSintegraSPED.cdsSelRC170_SPEDOP_CODIGO_CRED_PIS_COFINS.Value);
                              dmSintegraSPED.cdsRegistroM505_TEMPCOD_CRED.Value             := IntToStr(iCodCredPisCofins);
                              dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value           := StrToInt(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value);
                              dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_TOT.Value     := dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_TOT.Value + VL_BC_COFINS;//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BC_COFINS.Value;
                              dmSintegraSPED.cdsRegistroM505_TEMPALIQ_COFINS.Value          := dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS.Value;

                              case frmIntegracao.rgpRegimeApuracao.ItemIndex of
                                //cumulativo e n�o cumulativo
                                2:dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_CUM.Value := dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_TOT.Value;
                              else
                                dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_CUM.Value   := 0;
                              end;

                              dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_NC.Value      := (dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_TOT.Value - dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_CUM.Value);

                              if (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 50) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 51) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 52)
                                  or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 60) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 61) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 62) then

                                dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_TOT.Value   := dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_NC.Value

                              else
                              if (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 53) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 51) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 54)
                                  or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 55) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 56) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 63)
                                  or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 64) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 65) or (dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value  = 66) then

                                dmSintegraSPED.cdsRegistroM505_TEMPVLBC_COFINS.Value        := dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_NC.Value;

                              dmSintegraSPED.cdsRegistroM505_TEMPQUANT_BC_COFINS_TOT.Value  := 0;
                              dmSintegraSPED.cdsRegistroM505_TEMPQUANT_BC_COFINS.Value      := 0;
                              dmSintegraSPED.cdsRegistroM505_TEMPDESCRICAO_CRED.Value       := '';
                              dmSintegraSPED.cdsRegistroM505_TEMP.Post;

                            end;

                          end

                          { inserido em 07/06/2017

                          else if ValidarCST_PIS_COFINS_CREDITO_REC(0,FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value))) then
                          begin

                            //quando
                            CST_PIS     := stpisOutrasOperacoesEntrada;
                            CST_COFINS  := stcofinsOutrasOperacoesEntrada;

                          end;}

                        {end;
                        else
                        begin

                          CST_PIS     := stpisOutrasOperacoesEntrada;
                          CST_COFINS  := stcofinsOutrasOperacoesEntrada;

                        end;
                        }
                      end
                      else
                      if (dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value[1] = '5') or (dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value[1] = '6') or (dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value[1] = '7') then
                      begin //=== Saidas

                        if dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS_CFOP.Value > 0 then
                          iCodNatReceitaPisCofins := dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS_CFOP.Value
                        else
                          iCodNatReceitaPisCofins := dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS.Value;

                        {Opera��o Tribut�vel por Substitui��o Tribut�ria}
                        if (dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value = '5') or  (dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value = '75') then
                        begin

                          VL_PIS_ST     := VL_PIS_ST + VL_PIS;
                          VL_COFINS_ST  := VL_COFINS_ST + VL_COFINS;

                        end;

                        if ValidarCST_PIS_COFINS_CREDITO_REC(1,FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value))) then
                        begin

                          if  (dmSintegraSPED.cdsSelRC170_SPEDOP_GERA_CRED_PIS_COFINS.Value = 1) and (iCodNatReceitaPisCofins > 0) then
                          begin
                                                 //em 29/05/2017
//                            VL_BC_PIS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_PIS.Value;
                                                 //em 31/05/2017
                            VL_BC_PIS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_PIS.Value;
                            ALIQ_PIS_PERC     := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_PIS.Value;
                                                // em 31/05/17
//                            VL_PIS            := Arredondar(VL_BC_PIS *  (ALIQ_PIS_PERC / 100),2);//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_PIS.Value;
                            VL_PIS            := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_PIS.Value;
                            VL_BC_COFINS      := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BC_COFINS.Value;
                            ALIQ_COFINS_PERC  := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_COFINS.Value;
                                                // em 31/05/17
//                            VL_COFINS         := Arredondar(VL_BC_COFINS * (ALIQ_COFINS_PERC / 100),2);//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_COFINS.Value;
                            VL_COFINS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_COFINS.Value;

                            cVlr_PisC100      := cVlr_PisC100 + VL_PIS;
                            cVlr_Cofinsc100   := cVlr_Cofinsc100 + VL_COFINS;

                            RegistroC100.Items[RegistroC100.Count -1].VL_PIS    := RegistroC100.Items[RegistroC100.Count -1].VL_PIS    + VL_PIS;
                            RegistroC100.Items[RegistroC100.Count -1].VL_COFINS := RegistroC100.Items[RegistroC100.Count -1].VL_COFINS + VL_COFINS;

                            if not dmSintegraSPED.cdsRegistroM400_TEMP.Locate('CST_PIS', dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value, []) then
                              dmSintegraSPED.cdsRegistroM400_TEMP.Append
                            else
                              dmSintegraSPED.cdsRegistroM400_TEMP.Edit;

                            dmSintegraSPED.cdsRegistroM400_TEMPCST_PIS.Value        := dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value;
                            dmSintegraSPED.cdsRegistroM400_TEMPVL_TOT_REC.Value     := dmSintegraSPED.cdsRegistroM400_TEMPVL_TOT_REC.Value + (VL_ITEM);
                            dmSintegraSPED.cdsRegistroM400_TEMPCOD_CTA.Value        := dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CONTA_ANALITICA.Value;
                            dmSintegraSPED.cdsRegistroM400_TEMP.Post;

// 08/09/2017               if not dmSintegraSPED.cdsRegistroM410_TEMP.Locate('CST_PIS; NAT_RECEITA', VarArrayOf([dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value, FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS.Value)]), []) then
                            if not dmSintegraSPED.cdsRegistroM410_TEMP.Locate('CST_PIS; NAT_RECEITA', VarArrayOf([dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value, FormatFloat('000', iCodNatReceitaPisCofins)]), []) then
                              dmSintegraSPED.cdsRegistroM410_TEMP.Append
                            else
                              dmSintegraSPED.cdsRegistroM410_TEMP.Edit;

// 08/09/2017               dmSintegraSPED.cdsRegistroM410_TEMPNAT_RECEITA.Value    := FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS.Value);
                            dmSintegraSPED.cdsRegistroM410_TEMPNAT_RECEITA.Value    := FormatFloat('000',iCodNatReceitaPisCofins);
                            dmSintegraSPED.cdsRegistroM410_TEMPCST_PIS.Value        := dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value;
                            dmSintegraSPED.cdsRegistroM410_TEMPVL_RECEITA.Value     := dmSintegraSPED.cdsRegistroM410_TEMPVL_RECEITA.Value + (VL_ITEM);
                            dmSintegraSPED.cdsRegistroM410_TEMPCOD_CTA.Value        := dmSintegraSPED.cdsRegistroM400_TEMPCOD_CTA.Value;
                            dmSintegraSPED.cdsRegistroM410_TEMP.Post;

                            if not dmSintegraSPED.cdsRegistroM800_TEMP.Locate('CST_COFINS', dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value, []) then
                              dmSintegraSPED.cdsRegistroM800_TEMP.Append
                            else
                              dmSintegraSPED.cdsRegistroM800_TEMP.Edit;

                            dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value     := dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value;
                            dmSintegraSPED.cdsRegistroM800_TEMPVL_TOT_REC.Value     := dmSintegraSPED.cdsRegistroM800_TEMPVL_TOT_REC.Value + (VL_ITEM);
                            dmSintegraSPED.cdsRegistroM800_TEMPCOD_CTA.Value        := dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CONTA_ANALITICA.Value;
                            dmSintegraSPED.cdsRegistroM800_TEMP.Post;

// 08/09/2017               if not dmSintegraSPED.cdsRegistroM810_TEMP.Locate('CST_COFINS; NAT_RECEITA', VarArrayOf([dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value, FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS.Value)]), []) then
                            if not dmSintegraSPED.cdsRegistroM810_TEMP.Locate('CST_COFINS; NAT_RECEITA', VarArrayOf([dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value, FormatFloat('000',iCodNatReceitaPisCofins)]), []) then
                              dmSintegraSPED.cdsRegistroM810_TEMP.Append
                            else
                              dmSintegraSPED.cdsRegistroM810_TEMP.Edit;

// 08/09/2017               dmSintegraSPED.cdsRegistroM810_TEMPNAT_RECEITA.Value    := FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_NAT_RECEITA_PIS_COFINS.Value);
                            dmSintegraSPED.cdsRegistroM810_TEMPNAT_RECEITA.Value    := FormatFloat('000',iCodNatReceitaPisCofins);
                            dmSintegraSPED.cdsRegistroM810_TEMPCST_COFINS.Value     := dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value;
                            dmSintegraSPED.cdsRegistroM810_TEMPVL_REC.Value         := dmSintegraSPED.cdsRegistroM810_TEMPVL_REC.Value + (VL_ITEM);
                            dmSintegraSPED.cdsRegistroM810_TEMPCOD_CTA.Value        := dmSintegraSPED.cdsRegistroM800_TEMPCOD_CTA.Value;
                            dmSintegraSPED.cdsRegistroM810_TEMP.Post;

                          end;

                        end;

                      end;

                      //valores registro m210
                      if ValidarCOD_CONT_m210(sCod_Cont_M210) then
                      begin

                        if (ValidarCST_PIS_COFINS_CREDITO_REC(2,FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value)))) and (ALIQ_PIS_PERC > 0) then
                        begin

                          pAliq_Pis_M210    := ALIQ_PIS_PERC;
                          //em 31/5/17
//                          VL_BC_PIS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;
                          VL_BC_PIS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_PIS.Value;

                          //inclu�do em 31/05/17

                          if not dmSintegraSPED.cdsRegistroM210_TEMP.Locate('COD_CONT', CodContToStr(ccNaoAcumAliqBasica),[]) then
                          begin

                            dmSintegraSPED.cdsRegistroM210_TEMP.Append;
                            dmSintegraSPED.cdsRegistroM210_TEMPCOD_CONT.Value := CodContToStr(ccNaoAcumAliqBasica);

                          end
                          else
                            dmSintegraSPED.cdsRegistroM210_TEMP.Edit;

                          //inclu�do em 29/05/17
                          dmSintegraSPED.cdsRegistroM210_TEMPALIQ_PIS.Value := pAliq_Pis_M210;

                          //if StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_OPERACAO.Value) = 1 then
                          //begin

                            if (COD_MOD <> '55') then
                            begin

                              cVL_REC_BRT_M210  := cVL_REC_BRT_M210 + VL_ITEM;
                              cVL_BC_CONT_M210  := cVL_BC_CONT_M210 + VL_BC_PIS;

                              //inclu�do em 29/05/17
                              dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value := dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value + VL_ITEM;;
                              dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value := dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value + VL_BC_PIS;

                            end
//                            else if (COD_MOD = '55') and (frmIntegracao.rgpCriterioApuracao.ItemIndex = 2) then
                            else if (COD_MOD = '55') and ((frmIntegracao.rdgIndicadorApuracaoContr.ItemIndex + 1) = 2) then
                            begin

                              cVL_REC_BRT_M210  := cVL_REC_BRT_M210 + VL_ITEM;
                              cVL_BC_CONT_M210  := cVL_BC_CONT_M210 + VL_BC_PIS;
                              //inclu�do em 29/05/17
                              dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value := dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value + VL_ITEM;;
                              dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value := dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value + VL_BC_PIS;

                            end;

                          //end;

                          //inclu�do em 29/05/17
                          dmSintegraSPED.cdsRegistroM210_TEMPVL_CONT_APUR.Value := Arredondar(dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value * (pAliq_Pis_M210 /100),2);
                          dmSintegraSPED.cdsRegistroM210_TEMP.Post;

                          // em 31/5/17
//                          VL_PIS            := Arredondar(VL_BC_PIS *  (ALIQ_PIS_PERC / 100),2);//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_PIS.Value;
                          VL_PIS            := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_PIS.Value;

                        end;
                        if (ValidarCST_PIS_COFINS_CREDITO_REC(2,FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value)))) and (ALIQ_COFINS_PERC > 0) then
                        begin

                          pAliq_Cofins_M610    := ALIQ_COFINS_PERC;
                          //inclu�do em 29/05/17
                          // em 31/5/17
//                          VL_BC_COFINS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;
                          VL_BC_COFINS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BC_COFINS.Value;

                          //inclu�do em 29/05/17
                          if not dmSintegraSPED.cdsRegistroM610_TEMP.Locate('COD_CONT',CodContToStr(ccNaoAcumAliqBasica),[]) then
                          begin

                            dmSintegraSPED.cdsRegistroM610_TEMP.Append;
                            dmSintegraSPED.cdsRegistroM610_TEMPCOD_CONT.Value := CodContToStr(ccNaoAcumAliqBasica);//FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value));

                          end
                          else
                            dmSintegraSPED.cdsRegistroM610_TEMP.Edit;

                          //inclu�do em 29/05/17
                          dmSintegraSPED.cdsRegistroM610_TEMPALIQ_COFINS.Value := pAliq_Cofins_M610;

                          if StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_OPERACAO.Value) = 1 then
                          begin

                            if (COD_MOD <> '55') then
                            begin

                              cVL_REC_BRT_M610  := cVL_REC_BRT_M610 + VL_ITEM;
                              cVL_BC_CONT_M610  := cVL_BC_CONT_M610 + VL_BC_COFINS;

                              //inclu�do em 29/05/17
                              dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value := dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value + VL_ITEM;;
                              dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value := dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value + VL_BC_COFINS;

                            end
                            else if (COD_MOD = '55') and (frmIntegracao.rgpCriterioApuracao.ItemIndex = 2) then
                            begin

                              cVL_REC_BRT_M610  := cVL_REC_BRT_M610 + VL_ITEM;
                              cVL_BC_CONT_M610  := cVL_BC_CONT_M610 + VL_BC_COFINS;

                              //inclu�do em 29/05/17
                              dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value := dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value + VL_ITEM;;
                              dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value := dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value + VL_BC_COFINS;

                            end;

                          end;

                          //inclu�do em 29/05/17
                          dmSintegraSPED.cdsRegistroM610_TEMPVL_CONT_APUR.Value := Arredondar(dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value * (pAliq_Cofins_M610 /100),2);
                          dmSintegraSPED.cdsRegistroM610_TEMP.Post;

                          // em 31/5/17
//                          VL_COFINS         := Arredondar(VL_BC_COFINS * (ALIQ_COFINS_PERC / 100),2);//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_COFINS.Value;
                          VL_COFINS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_COFINS.Value;

                        end;

                      end;

                    end;

                    dmSintegraSPED.cdsSelRC170_SPED.Next;

                  end;

                  VL_PIS        := VL_PIS + cVlr_PisC100;
                  VL_COFINS     := VL_COFINS + cVlr_Cofinsc100;

                end;

              end;

            end;

            dmSintegraSPED.cdsSelRC100_SPED.Next;

          end;

        end;


      end;

    end;

  end;

end;

procedure Gravar_Bloco_C400;
var
  iNum_Item, iC490, iT_C470, iA_C470 :integer;
  sCst: string;
  cAliquota, cP_Desconto, cTotalCreditos, cTotalDebitos: currency;
  bC490:boolean;
begin


  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_C do
  begin

    with RegistroC001 do
    begin

      dmMProvider.cdsConfigECF.Close;
      dmMProvider.cdsConfigECF.ProviderName := 'dspConfigECF';

      dmDBEXMaster.fdqConfigECF.SQL.Clear;
      dmDBEXMaster.fdqConfigECF.SQL.Add('SELECT * FROM CONFIG_CAIXAS');
      dmDBEXMaster.fdqConfigECF.SQL.Add('ORDER BY NUMERO_CAIXA');

      dmMProvider.cdsConfigECF.Open;
      dmMProvider.cdsConfigECF.ProviderName := '';

      iTotalRegistros                              := dmMProvider.cdsConfigECF.RecordCount;
      iRegistroAtual                               := 0;

      while not dmMProvider.cdsConfigECF.Eof do
      begin

        inc(iRegistroAtual);

        dmSintegraSPED.cdsSelRC405_SPED.Close;
        dmSintegraSPED.cdsSelRC405_SPED.ProviderName := 'dspSelRC405_Sped';

        dmSintegraSPED.fdqSelRC405_SPED.Params[0].Value := frmIntegracao.dtpSpedContribuicoesInicial.Date;
        dmSintegraSPED.fdqSelRC405_SPED.Params[1].Value := frmIntegracao.dtpSpedContribuicoesFinal.Date;
        dmSintegraSPED.fdqSelRC405_SPED.Params[2].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;

        dmSintegraSPED.cdsSelRC405_SPED.Open;
        dmSintegraSPED.cdsSelRC405_SPED.ProviderName := '';

        if not dmSintegraSPED.cdsSelRC405_SPED.IsEmpty then
        begin

          with RegistroC400New do
          begin

            COD_MOD   := dmMProvider.cdsConfigECFCODIGO_MODELO_DOCUMENTO.Value;
            ECF_MOD   := dmMProvider.cdsConfigECFMODELO_ECF.Value;
            ECF_FAB   := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;
            ECF_CX    := dmMProvider.cdsConfigECFNUMERO_CAIXA.Value;

            while not dmSintegraSPED.cdsSelRC405_SPED.eof do
            begin

              frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco C - Redu��es Z ECF-'
                                              + dmSintegraSPED.cdsSelRC405_SPEDOP_SERIE_ECF.Value
                                              + ' * ' + FormatDateTime('dd/mm/yyyy', dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value)
                                              + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
              Application.ProcessMessages;

              with RegistroC405New do
              begin

                DT_DOC      := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                CRO         := dmSintegraSPED.cdsSelRC405_SPEDOP_CRO.Value;
                CRZ         := dmSintegraSPED.cdsSelRC405_SPEDOP_CRZ.Value;
                NUM_COO_FIN := dmSintegraSPED.cdsSelRC405_SPEDOP_NUM_COO_FINAL.Value;
                GT_FIN      := dmSintegraSPED.cdsSelRC405_SPEDOP_GT_FINAL.Value;
                VL_BRT      := dmSintegraSPED.cdsSelRC405_SPEDOP_VALOR_VENDA_BRUTA.Value;
                Application.ProcessMessages;

                dmSintegraSPED.cdsRegistroC481_TEMP.Close;
                dmSintegraSPED.cdsRegistroC481_TEMP.CreateDataSet;

                if dmSintegraSPED.cdsSelRC405_SPEDOP_VALOR_VENDA_BRUTA.Value > 0 then
                begin

                  dmSintegraSPED.cdsSelRC470_SPEDC.Close;
                  dmSintegraSPED.cdsSelRC470_SPEDC.ProviderName    := 'dspSelRC470_SPEDC';

                  dmSintegraSPED.fdqSelRC470_SPEDC.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                  dmSintegraSPED.fdqSelRC470_SPEDC.Params[1].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;

                  dmSintegraSPED.cdsSelRC470_SPEDC.Open;
                  dmSintegraSPED.cdsSelRC470_SPEDC.ProviderName    := '';

                  iT_C470 := dmSintegraSPED.cdsSelRC470_SPEDC.RecordCount;
                  iA_C470 := 0;

                  while not dmSintegraSPED.cdsSelRC470_SPEDC.Eof do
                  begin

                    inc(iA_C470);

                    frmIntegracao.lblC470.Caption :=  IntToStr(iA_C470) + '/'+ IntToStr(iT_C470)+ '  ';
                    Application.ProcessMessages;

                    Gravar_Registro0200(1, Trim(dmSintegraSPED.cdsSelRC470_SPEDCOP_CODIGO_ITEM.Value), dmSintegraSPED.cdsSelRC470_SPEDCOP_UNIDADE.Value, False);
                    Gravar_Registro0500(1);

                    with RegistroC481 do
                    begin

                      if not dmSintegraSPED.cdsRegistroC481_TEMP.Locate('COD_ITEM;CST_PIS;ALIQ_PIS',VarArrayOf([StrToInt(dmSintegraSPED.cdsSelRC470_SPEDcOP_CODIGO_ITEM.Value), FormatFloat('00',dmSintegraSPED.cdsSelRC470_SPEDCOP_CST_PIS.Value), dmSintegraSPED.cdsSelRC470_SPEDCOP_ALIQUOTA_PIS.Value]), [loPartialKey, loCaseinsensitive]) then
                      begin

                        dmSintegraSPED.cdsRegistroC481_TEMP.Append;
                        dmSintegraSPED.cdsRegistroC481_TEMPCOD_ITEM.Value := IntToStr(StrToInt(dmSintegraSPED.cdsSelRC470_SPEDCOP_CODIGO_ITEM.Value));
                        dmSintegraSPED.cdsRegistroC481_TEMPCST_PIS.Value  := FormatFloat('00',dmSintegraSPED.cdsSelRC470_SPEDCOP_CST_PIS.Value);
                        dmSintegraSPED.cdsRegistroC481_TEMPALIQ_PIS.Value := dmSintegraSPED.cdsSelRC470_SPEDCOP_ALIQUOTA_PIS.Value;
                        dmSintegraSPED.cdsRegistroC481_TEMP.Post;
                        new;

                        with RegistroC481.Items[RegistroC481.Count - 1] do
                        begin

                          CST_PIS         := StrToCstPis(dmSintegraSPED.cdsRegistroC481_TEMPCST_PIS.Value);
                          VL_ITEM         := dmSintegraSPED.cdsSelRC470_SPEDCOP_VALOR_ITEM.Value;
  //                        QUANT_BC_PIS    := 0;
  //                        ALIQ_PIS_QUANT  := 0;
                          VL_BC_PIS       := dmSintegraSPED.cdsSelRC470_SPEDCOP_VALOR_ITEM.Value;
                          ALIQ_PIS        := dmSintegraSPED.cdsRegistroC481_TEMPALIQ_PIS.Value;
                          VL_PIS          := Arredondar(VL_BC_PIS * (ALIQ_PIS / 100),2);//dmSintegraSPED.cdsSelRC470_SPEDCOP_VALOR_PIS.Value;
                          COD_ITEM        := InttoStr(StrToInt(dmSintegraSPED.cdsRegistroC481_TEMPCOD_ITEM.Value));
                          COD_CTA         := dmSintegraSPED.cdsSelRC470_SPEDCOP_COD_CTA.Value;

                          //valores registro n210
                          if ValidarCOD_CONT_m210(sCod_Cont_M210) then
                          begin

                            if (ValidarCST_PIS_COFINS_CREDITO_REC(2,dmSintegraSPED.cdsRegistroC481_TEMPCST_PIS.Value)) and (ALIQ_PIS > 0 ) then
                            begin


                              if ((frmIntegracao.rdgIndicadorApuracaoContr.ItemIndex + 1) = 2) then
//                              if frmIntegracao.rgpCriterioApuracao.ItemIndex = 2 then
                              begin

                                //inclu�do em 31/05/17

                                if not dmSintegraSPED.cdsRegistroM210_TEMP.Locate('COD_CONT',CodContToStr(ccNaoAcumAliqBasica),[]) then                                begin
//                                if not dmSintegraSPED.cdsRegistroM210_TEMP.Locate('COD_CONT',FormatFloat('00', StrToFloat(dmSintegraSPED.cdsRegistroC481_TEMPCST_PIS.Value)),[]) then                                begin

                                  dmSintegraSPED.cdsRegistroM210_TEMP.Append;
                                  dmSintegraSPED.cdsRegistroM210_TEMPCOD_CONT.Value := CodContToStr(ccNaoAcumAliqBasica);//FormatFloat('00', StrToFloat(dmSintegraSPED.cdsRegistroC481_TEMPCST_PIS.Value));

                                end
                                else
                                  dmSintegraSPED.cdsRegistroM210_TEMP.Edit;

                                //inclu�do em 30/05/17
                                dmSintegraSPED.cdsRegistroM210_TEMPALIQ_PIS.Value := ALIQ_PIS;

                                cVL_REC_BRT_M210  := cVL_REC_BRT_M210   + VL_ITEM;
                                cVL_BC_CONT_M210  := cVL_BC_CONT_M210   + VL_ITEM;

                                //inclu�do em 30/05/17
                                dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value := dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value + VL_ITEM;;
                                dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value := dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value + VL_BC_PIS;

                                //inclu�do em 30/05/17
                                dmSintegraSPED.cdsRegistroM210_TEMPVL_CONT_APUR.Value := Arredondar(dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value * (ALIQ_PIS /100),2);
                                dmSintegraSPED.cdsRegistroM210_TEMP.Post;

                                VL_PIS            := Arredondar(VL_BC_PIS *  (ALIQ_PIS / 100),2);//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_PIS.Value;

                              end;

                            end;

                          end;

                        end;

                      end;

                    end;

                    with RegistroC485 do
                    begin

                      if not dmSintegraSPED.cdsRegistroC481_TEMP.Locate('COD_ITEM;CST_COFINS;ALIQ_COFINS',VarArrayOf([StrToInt(dmSintegraSPED.cdsSelRC470_SPEDCOP_CODIGO_ITEM.Value), FormatFloat('00',dmSintegraSPED.cdsSelRC470_SPEDCOP_CST_COFINS.Value), dmSintegraSPED.cdsSelRC470_SPEDCOP_ALIQUOTA_COFINS.Value]), [loPartialKey, loCaseinsensitive]) then
                      begin

                        dmSintegraSPED.cdsRegistroC481_TEMP.Append;
                        dmSintegraSPED.cdsRegistroC481_TEMPCOD_ITEM.Value     := IntToStr(StrToInt(dmSintegraSPED.cdsSelRC470_SPEDCOP_CODIGO_ITEM.Value));
                        dmSintegraSPED.cdsRegistroC481_TEMPCST_COFINS.Value   := FormatFloat('00',dmSintegraSPED.cdsSelRC470_SPEDCOP_CST_COFINS.Value);
                        dmSintegraSPED.cdsRegistroC481_TEMPALIQ_COFINS.Value  := dmSintegraSPED.cdsSelRC470_SPEDCOP_ALIQUOTA_COFINS.Value;
                        dmSintegraSPED.cdsRegistroC481_TEMP.Post;
                        new;

                        with RegistroC485.Items[RegistroC485.Count - 1] do
                        begin

                          CST_COFINS        := StrToCstCofins(dmSintegraSPED.cdsRegistroC481_TEMPCST_COFINS.Value);
                          VL_ITEM           := dmSintegraSPED.cdsSelRC470_SPEDCOP_VALOR_ITEM.Value;
  //                        QUANT_BC_COFINS   := 0;
  //                        ALIQ_COFINS_QUANT := 0;
                          VL_BC_COFINS      := dmSintegraSPED.cdsSelRC470_SPEDCOP_VALOR_ITEM.Value;
                          ALIQ_COFINS       := dmSintegraSPED.cdsRegistroC481_TEMPALIQ_COFINS.Value;
                          VL_COFINS         := Arredondar(VL_BC_COFINS * (ALIQ_COFINS / 100),2); //dmSintegraSPED.cdsSelRC470_SPEDCOP_VALOR_COFINS.Value;
                          COD_ITEM          := InttoStr(StrToInt(dmSintegraSPED.cdsRegistroC481_TEMPCOD_ITEM.Value));
                          COD_CTA           := dmSintegraSPED.cdsSelRC470_SPEDCOP_COD_CTA.Value;

                          if ValidarCOD_CONT_m210(sCod_Cont_M210) then
                          begin

                            if (ValidarCST_PIS_COFINS_CREDITO_REC(2,dmSintegraSPED.cdsRegistroC481_TEMPCST_COFINS.Value)) and (ALIQ_COFINS > 0 ) then
                            begin

                              if ((frmIntegracao.rdgIndicadorApuracaoContr.ItemIndex + 1) = 2) then
//                              if frmIntegracao.rgpCriterioApuracao.ItemIndex = 2 then
                              begin

                                //inclu�do em 29/05/17
                                if not dmSintegraSPED.cdsRegistroM610_TEMP.Locate('COD_CONT',CodContToStr(ccNaoAcumAliqBasica),[]) then
                                begin

                                  dmSintegraSPED.cdsRegistroM610_TEMP.Append;
                                  dmSintegraSPED.cdsRegistroM610_TEMPCOD_CONT.Value := CodContToStr(ccNaoAcumAliqBasica);//FormatFloat('00', StrToFloat(dmSintegraSPED.cdsRegistroC481_TEMPCST_COFINS.Value));

                                end
                                else
                                  dmSintegraSPED.cdsRegistroM610_TEMP.Edit;

                                //inclu�do em 30/05/17
                                dmSintegraSPED.cdsRegistroM610_TEMPALIQ_COFINS.Value := ALIQ_COFINS;

                                cVL_REC_BRT_M610  := cVL_REC_BRT_M610 + VL_ITEM;
                                cVL_BC_CONT_M610  := cVL_BC_CONT_M610 + VL_ITEM;

                                //inclu�do em 30/05/17
                                dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value := dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value + VL_ITEM;;
                                dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value := dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value + VL_BC_COFINS;

                                //inclu�do em 30/05/17
                                dmSintegraSPED.cdsRegistroM610_TEMPVL_CONT_APUR.Value := Arredondar(dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value * (pAliq_Cofins_M610 /100),2);
                                dmSintegraSPED.cdsRegistroM610_TEMP.Post;

                                VL_COFINS         := Arredondar(VL_BC_COFINS * (ALIQ_COFINS / 100),2);//dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_COFINS.Value;

                              end;

                            end;

                          end;

                        end;

                      end;


                    end;

                    dmSintegraSPED.cdsSelRC470_SPEDC.Next;

                  end;

                end;


              end;

              dmSintegraSPED.cdsSelRC405_SPED.Next;

            end;

          end;

        end;

        dmMProvider.cdsConfigECF.Next;

      end;

    end;

  end;


end;

procedure Gravar_Bloco_D;
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_D do
  begin

    with RegistroD001New do
    begin

      IND_MOV := imSemDados;
      {
        //Estabelecimento
        with RegistroD010New do
        begin

        CNPJ := '11111111111180';

        for INotas := 1 to NNotas do
        begin

        with RegistroD100New do
        begin

        IND_OPER := 0;
        IND_EMIT := 0;
        COD_PART := '';
        COD_MOD :=  '';

        end;

        end;

        //D200 - Resumo da Escritura��o Di�ria � Presta��o de Servi�os de Transportes
        // (C�digos 07, 08, 8B, 09, 10, 11, 26, 27 e 57).
        with RegistroD200New do
        begin

        //|D200|08|00|||11574|11854|6352|000011574|000011854|6352|25072011|6807,57|0,00|
        COD_MOD := '08';
        COD_SIT := sdfRegular;
        SER := '';
        SUB := '';
        NUM_DOC_INI := 11574;
        NUM_DOC_FIN := 11854;
        CFOP := 6352;
        DT_REF := DT_INI;// StrToDate('15/04/2011');
        VL_DOC := 6807.57;
        VL_DESC := 0;
        end;

        end;
      }
    end;

  end;

end;

procedure Gravar_Bloco_F;
begin


  // Alimenta o componente com informa��es para gerar todos os registros do
  // Bloco F.
  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_F do
  begin

    with RegistroF001New do
    begin

      IND_MOV := imSemDados;
      {
        //F010 - Identifica��o do Estabelecimento
        with RegistroF010New do
        begin

        CNPJ := '11111111111180';

        //F100 - Demais Documentos e Opera��es Geradoras de Contribui��o e Cr�ditos
        with RegistroF100New do
        begin

        IND_OPER      := indRepCustosDespesasEncargos;
        COD_PART      := '001';
        COD_ITEM      := '000'; //Codigo do Item no registro 0200
        DT_OPER       := Date();
        VL_OPER       := 0;
        CST_PIS       := stpisOutrasOperacoesSaida;
        VL_BC_PIS     := 0;
        ALIQ_PIS      := 1.2375;
        VL_PIS        := 0;
        CST_COFINS    := stcofinsOutrasOperacoesSaida;
        VL_BC_COFINS  := 0;
        ALIQ_COFINS   := 0;
        VL_COFINS     := 0;
        NAT_BC_CRED   := bccAqBensRevenda;
        IND_ORIG_CRED := opcMercadoInterno;
        COD_CTA       := '';
        COD_CCUS      := '123';
        DESC_DOC_OPER := '';

        end;

        end;
      }
    end;

  end;

end;

procedure Gravar_Bloco_I;
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_I do
  begin

    with RegistroI001New do
    begin

      IND_MOV := imSemDados;

    end;

  end;

end;

procedure Gravar_Bloco_M;
var
  i:integer;

begin

  if frmIntegracao.chkGerarSPEDContribuicoesSM.Checked then
  begin

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_M do
    begin

      with RegistroM001New do
      begin

        IND_MOV := imComDados;

      end;

      with RegistroM200New do
      begin

        VL_TOT_CRED_DESC      := 0;
        VL_TOT_CRED_DESC_ANT  := 0;
        VL_RET_NC             := 0;
        VL_OUT_DED_NC         := 0;
        VL_TOT_CONT_CUM_PER   := 0;
        VL_RET_CUM            := 0;
        VL_OUT_DED_CUM        := 0;
        VL_CONT_CUM_REC       := 0;

        VL_TOT_CONT_NC_PER    := 0;
        VL_TOT_CONT_NC_DEV    := 0;
        VL_CONT_NC_REC        := 0;
        VL_TOT_CONT_REC       := 0;

      end;

      with RegistroM600New do
      begin

        VL_TOT_CRED_DESC      := 0;
        VL_TOT_CRED_DESC_ANT  := 0;
        VL_RET_NC             := 0;
        VL_OUT_DED_NC         := 0;
        VL_TOT_CONT_CUM_PER   := 0;
        VL_RET_CUM            := 0;
        VL_OUT_DED_CUM        := 0;
        VL_CONT_CUM_REC       := 0;

        VL_TOT_CONT_NC_PER    := 0;
        VL_TOT_CONT_NC_DEV    := 0;
        VL_CONT_NC_REC        := 0;
        VL_TOT_CONT_REC       := 0;
      end;

    end;

  end
  else
  begin

    dmSintegraSPED.cdsRegistroM100_TEMP.First;

    iTotalRegistros := dmSintegraSPED.cdsRegistroM100_TEMP.RecordCount;
    iRegistroAtual  := 0;


    dmSintegraSPED.cdsRegistroM105_TEMP.IndexFieldNames := 'NAT_BC_CRED';
    dmSintegraSPED.cdsRegistroM505_TEMP.IndexFieldNames := 'NAT_BC_CRED';

    with frmIntegracao.ACBrSPEDPisCofins1.Bloco_M do
    begin

      with RegistroM001New do
      begin

        IND_MOV := imComDados;

        while not dmSintegraSPED.cdsRegistroM100_TEMP.Eof do
        begin

          inc(iRegistroAtual);

          frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco M - Apura��o da contrib. e cr�d. PIS/PASEP e da COFINS'
                                          + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
          Application.ProcessMessages;

          with RegistroM100New do
          begin

            COD_CRED        := dmSintegraSPED.cdsRegistroM100_TEMPCOD_CRED.Value;
            IND_CRED_ORI    := TACBrIndCredOri(dmSintegraSPED.cdsRegistroM100_TEMPIND_CRED_ORI.Value);
            VL_BC_PIS       := VL_BC_PIS      + dmSintegraSPED.cdsRegistroM100_TEMPVL_BC_PIS.Value;
            ALIQ_PIS        := dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS.Value;
            QUANT_BC_PIS    := null;
            ALIQ_PIS_QUANT  := null;//dmSintegraSPED.cdsRegistroM100_TEMPALIQ_PIS_QUANT.Value;
            VL_CRED         := Arredondar(VL_CRED        + (VL_BC_PIS * (ALIQ_PIS / 100)) , 2);
            VL_AJUS_ACRES   := VL_AJUS_ACRES  + dmSintegraSPED.cdsRegistroM100_TEMPVL_AJUS_ACRES.Value;
            VL_AJUS_REDUC   := VL_AJUS_REDUC  + dmSintegraSPED.cdsRegistroM100_TEMPVL_AJUS_REDUC.Value;
            VL_CRED_DIF     := VL_CRED_DIF    + dmSintegraSPED.cdsRegistroM100_TEMPVL_CRED_DIF.Value;
            VL_CRED_DISP    := VL_CRED_DISP   + VL_CRED;
            IND_DESC_CRED   := TACBrIndDescCred(StrToInt(dmSintegraSPED.cdsRegistroM100_TEMPIND_DESC_CRED.Value));
            VL_CRED_DESC    := VL_CRED_DISP;
            SLD_CRED        := SLD_CRED       + (VL_CRED_DISP - VL_CRED_DESC);

            dmSintegraSPED.cdsRegistroM105_TEMP.Filtered  := False;
            dmSintegraSPED.cdsRegistroM105_TEMP.Filter    := 'COD_CRED = ' + QuotedStr(dmSintegraSPED.cdsRegistroM100_TEMPCOD_CRED.Value);
            dmSintegraSPED.cdsRegistroM105_TEMP.Filtered  := True;
            dmSintegraSPED.cdsRegistroM105_TEMP.First;

            while not dmSintegraSPED.cdsRegistroM105_TEMP.Eof do
            begin

              with RegistroM105New do
              begin

                NAT_BC_CRED       := TACBrBaseCalculoCredito(StrToInt(dmSintegraSPED.cdsRegistroM105_TEMPNAT_BC_CRED.Value));
                CST_PIS           := StrToCstPis(FormatFloat('00',dmSintegraSPED.cdsRegistroM105_TEMPCST_PIS.Value));
                VL_BC_PIS_TOT     := VL_BC_PIS_TOT + dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_TOT.Value;
                VL_BC_PIS_CUM     := VL_BC_PIS_CUM + dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_CUM.Value;
                VL_BC_PIS_NC      := VL_BC_PIS_NC  + dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS_NC.Value;
                VL_BC_PIS         := VL_BC_PIS     + dmSintegraSPED.cdsRegistroM105_TEMPVL_BC_PIS.Value;
                QUANT_BC_PIS_TOT  := null;//dmSintegraSPED.cdsRegistroM105_TEMPQUANT_BC_PIS_TOT.Value;
                QUANT_BC_PIS      := null;//dmSintegraSPED.cdsRegistroM105_TEMPQUANT_BC_PIS.Value;
                DESC_CRED         := dmSintegraSPED.cdsRegistroM105_TEMPDESCRICAO_CRED.Value;

              end;

              dmSintegraSPED.cdsRegistroM105_TEMP.Next;

            end;

          end;

          dmSintegraSPED.cdsRegistroM100_TEMP.Next;

        end;

        with RegistroM200New do
        begin

          dmSintegraSPED.cdsRegistroM210_TEMP.First;
          //inclu�do em 29/05/2017
          while not dmSintegraSPED.cdsRegistroM210_TEMP.Eof do
          begin

            with RegistroM210New do
            begin

              COD_CONT            := StrToCodCont(dmSintegraSPED.cdsRegistroM210_TEMPCOD_CONT.Value);
              VL_REC_BRT          := dmSintegraSPED.cdsRegistroM210_TEMPVL_REC_BRT.Value;
              VL_BC_CONT          := dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value;
              ALIQ_PIS            := dmSintegraSPED.cdsRegistroM210_TEMPALIQ_PIS.Value;
              VL_CONT_APUR        := dmSintegraSPED.cdsRegistroM210_TEMPVL_CONT_APUR.Value;
//              VL_CONT_APUR        := Arredondar(dmSintegraSPED.cdsRegistroM210_TEMPVL_BC_CONT.Value * (dmSintegraSPED.cdsRegistroM210_TEMPALIQ_PIS.Value / 100) , 2);
              VL_AJUS_ACRES       := 0;
              VL_AJUS_REDUC       := 0;
              VL_CONT_DIFER       := 0;
              VL_CONT_DIFER_ANT   := 0;
              VL_CONT_PER         := ((VL_CONT_APUR + VL_AJUS_ACRES) - VL_AJUS_REDUC) - (VL_CONT_DIFER + VL_CONT_DIFER_ANT) ;

              if VL_CONT_PER < 0 then
                VL_CONT_PER := VL_CONT_PER * ( -1 );

            end;

            VL_TOT_CONT_NC_PER    := RegistroM210.Items[0].VL_CONT_PER;

            if not dmSintegraSPED.cdsRegistroM100_TEMP.IsEmpty  then
              VL_TOT_CRED_DESC      := RegistroM100.Items[0].VL_CRED_DESC
            else
              VL_TOT_CRED_DESC      := 0;

            VL_TOT_CRED_DESC_ANT  := 0;
            VL_TOT_CONT_NC_DEV    := VL_TOT_CONT_NC_PER - (VL_TOT_CRED_DESC +VL_TOT_CRED_DESC_ANT ); //   (RegistroM210.Items[0].VL_CONT_PER - RegistroM100.Items[0].VL_CRED_DESC);

            if VL_TOT_CONT_NC_DEV < 0 then
              VL_TOT_CONT_NC_DEV := VL_TOT_CONT_NC_DEV * (-1);

            VL_RET_NC             := 0;
            VL_OUT_DED_NC         := 0;
            VL_TOT_CONT_CUM_PER   := 0;
            VL_RET_CUM            := 0;
            VL_OUT_DED_CUM        := 0;
            VL_CONT_CUM_REC       := 0;
            VL_CONT_NC_REC        := VL_TOT_CONT_NC_DEV - (VL_RET_NC + VL_OUT_DED_NC);

            if VL_CONT_NC_REC < 0 then
              VL_CONT_NC_REC := VL_CONT_NC_REC * (-1);

            VL_TOT_CONT_REC       := VL_TOT_CONT_REC + (VL_CONT_NC_REC + VL_CONT_CUM_REC);

            if VL_TOT_CONT_REC < 0 then
              VL_TOT_CONT_REC := VL_TOT_CONT_REC * (-1);

            with RegistroM205New do
            begin

              case frmIntegracao.rgpRegimeApuracao.ItemIndex of
                0:begin //n�o cumulativa

                    NUM_CAMPO := '12';
                    COD_REC   := '810902';

                  end;
                1:begin// exclusiva cumulativa

                    NUM_CAMPO := '08';
                    COD_REC   := '691201';

                  end;
              end;

              VL_DEBITO := VL_DEBITO + (VL_CONT_NC_REC + VL_CONT_CUM_REC);

              if VL_DEBITO < 0  then
                VL_DEBITO := VL_DEBITO * (-1);


            end;

            dmSintegraSPED.cdsRegistroM210_TEMP.Next;

          end;

        end;

        dmSintegraSPED.cdsRegistrom400_TEMP.First;

        while not dmSintegraSPED.cdsRegistrom400_TEMP.Eof do
        begin

          // M500 - Cr�dito de PIS/PASEP Relativo ao Per�odo
          with RegistroM400New do
          begin

            CST_PIS       := StrToCstPis(dmSintegraSPED.cdsRegistroM400_TEMPCST_PIS.Value);
            VL_TOT_REC    := dmSintegraSPED.cdsRegistroM400_TEMPVL_TOT_REC.Value;

            dmSintegraSPED.cdsRegistroM410_TEMP.Filtered  := False;
            dmSintegraSPED.cdsRegistroM410_TEMP.Filter    := 'CST_PIS = ' + dmSintegraSPED.cdsRegistroM400_TEMPCST_PIS.Value;
            dmSintegraSPED.cdsRegistroM410_TEMP.Filtered  := True;
            dmSintegraSPED.cdsRegistroM410_TEMP.First;

            while not dmSintegraSPED.cdsRegistroM410_TEMP.Eof do
            begin

              with RegistroM410New do
              begin

                CST_PIS   := StrToCstPis(dmSintegraSPED.cdsRegistroM410_TEMPCST_PIS.Value);
                NAT_REC   := dmSintegraSPED.cdsRegistroM410_TEMPNAT_RECEITA.Value;
                VL_REC    := dmSintegraSPED.cdsRegistroM410_TEMPVL_RECEITA.Value;

              end;

              dmSintegraSPED.cdsRegistroM410_TEMP.Next;

            end;

            dmSintegraSPED.cdsRegistroM400_TEMP.Next;

          end;

        end;

        dmSintegraSPED.cdsRegistroM500_TEMP.First;

        while not dmSintegraSPED.cdsRegistroM500_TEMP.Eof do
        begin

          // M500 - Cr�dito de PIS/PASEP Relativo ao Per�odo
          with RegistroM500New do
          begin

            COD_CRED            := dmSintegraSPED.cdsRegistroM500_TEMPCOD_CRED.Value;
            IND_CRED_ORI        := TACBrIndCredOri(dmSintegraSPED.cdsRegistroM500_TEMPIND_CRED_ORI.Value);
            VL_BC_COFINS        := VL_BC_COFINS      + dmSintegraSPED.cdsRegistroM500_TEMPVL_BC_COFINS.Value;
            ALIQ_COFINS         := dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS.Value;
//            QUANT_BC_COFINS     := 0;
//            ALIQ_COFINS_QUANT   := dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS_QUANT.Value;
            VL_CRED             := Arredondar(VL_CRED        + (VL_BC_COFINS * (ALIQ_COFINS / 100)) , 2);
            VL_AJUS_ACRES       := VL_AJUS_ACRES  + dmSintegraSPED.cdsRegistroM500_TEMPVL_AJUS_ACRES.Value;
            VL_AJUS_REDUC       := VL_AJUS_REDUC  + dmSintegraSPED.cdsRegistroM500_TEMPVL_AJUS_REDUC.Value;
            VL_CRED_DIFER       := VL_CRED_DIFER  + dmSintegraSPED.cdsRegistroM500_TEMPVL_CRED_DIFER.Value;
            VL_CRED_DISP        := VL_CRED_DISP   + VL_CRED;
            IND_DESC_CRED       := TACBrIndDescCred(StrToInt(dmSintegraSPED.cdsRegistroM500_TEMPIND_DESC_CRED.Value));
            VL_CRED_DESC        := VL_CRED_DISP;
            SLD_CRED            := SLD_CRED       + (VL_CRED_DISP - VL_CRED_DESC);


            dmSintegraSPED.cdsRegistroM505_TEMP.Filtered  := False;
            dmSintegraSPED.cdsRegistroM505_TEMP.Filter    := 'COD_CRED = ' + QuotedStr(dmSintegraSPED.cdsRegistroM500_TEMPCOD_CRED.Value);
            dmSintegraSPED.cdsRegistroM505_TEMP.Filtered  := True;
            dmSintegraSPED.cdsRegistroM505_TEMP.First;

            while not dmSintegraSPED.cdsRegistroM505_TEMP.Eof do
            begin

              with RegistroM505New do
              begin

                NAT_BC_CRED         := TACBrBaseCalculoCredito(StrToInt(dmSintegraSPED.cdsRegistroM505_TEMPNAT_BC_CRED.Value));
                CST_COFINS          := StrToCstCofins(FormatFloat('00', dmSintegraSPED.cdsRegistroM505_TEMPCST_COFINS.Value));
                VL_BC_COFINS_TOT    := VL_BC_COFINS_TOT + dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_TOT.Value;
                VL_BC_COFINS_CUM    := VL_BC_COFINS_CUM + dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_CUM.Value;
                VL_BC_COFINS_NC     := VL_BC_COFINS_NC  + dmSintegraSPED.cdsRegistroM505_TEMPVL_BC_COFINS_NC.Value;
                VL_BC_COFINS        := VL_BC_COFINS_NC;
                QUANT_BC_COFINS_TOT := null;//dmSintegraSPED.cdsRegistroM505_TEMPQUANT_BC_COFINS_TOT.Value;
                QUANT_BC_COFINS     := null;//dmSintegraSPED.cdsRegistroM505_TEMPQUANT_BC_COFINS.Value;
                DESC_CRED           := dmSintegraSPED.cdsRegistroM505_TEMPDESCRICAO_CRED.Value;

              end;

              dmSintegraSPED.cdsRegistroM505_TEMP.Next;

            end;

            dmSintegraSPED.cdsRegistroM500_TEMP.Next;

          end;

        end;

        with RegistroM600New do
        begin

          dmSintegraSPED.cdsRegistroM610_TEMP.First;

          while not dmSintegraSPED.cdsRegistroM610_TEMP.Eof do
          begin

            with RegistroM610New do
            begin

              COD_CONT          := StrToCodCont(dmSintegraSPED.cdsRegistroM610_TEMPCOD_CONT.Value);;
              VL_REC_BRT        := dmSintegraSPED.cdsRegistroM610_TEMPVL_REC_BRT.Value;// cVL_REC_BRT_M610;
              VL_BC_CONT        := dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value;// cVL_BC_CONT_M610;
              ALIQ_COFINS       := dmSintegraSPED.cdsRegistroM610_TEMPALIQ_COFINS.Value;// dmSintegraSPED.cdsRegistroM500_TEMPALIQ_COFINS.Value;//pAliq_Cofins_M610;
              VL_CONT_APUR      := dmSintegraSPED.cdsRegistroM610_TEMPVL_CONT_APUR.Value;
//              VL_CONT_APUR      := Arredondar(dmSintegraSPED.cdsRegistroM610_TEMPVL_BC_CONT.Value * (ALIQ_COFINS / 100) , 2);
              VL_AJUS_ACRES     := 0;
              VL_AJUS_REDUC     := 0;
              VL_CONT_DIFER     := 0;
              VL_CONT_DIFER_ANT := 0;
              VL_CONT_PER       := ((VL_CONT_APUR + VL_AJUS_ACRES) - VL_AJUS_REDUC) - (VL_CONT_DIFER + VL_CONT_DIFER_ANT) ;

              if VL_CONT_PER < 0 then
                VL_CONT_PER := VL_CONT_PER * (-1);


            end;

            VL_TOT_CONT_NC_PER    := RegistroM610.Items[0].VL_CONT_PER;

            if not dmSintegraSPED.cdsRegistroM500_TEMP.IsEmpty  then
              VL_TOT_CRED_DESC      := RegistroM500.Items[0].VL_CRED_DESC
            else
              VL_TOT_CRED_DESC      := 0;

            VL_TOT_CRED_DESC_ANT  := 0;
            VL_TOT_CONT_NC_DEV    := VL_TOT_CONT_NC_PER - (VL_TOT_CRED_DESC +VL_TOT_CRED_DESC_ANT ); //   (RegistroM210.Items[0].VL_CONT_PER - RegistroM100.Items[0].VL_CRED_DESC);

            if VL_TOT_CONT_NC_DEV < 0 then
              VL_TOT_CONT_NC_DEV := VL_TOT_CONT_NC_DEV * (-1);

            VL_RET_NC             := 0;
            VL_OUT_DED_NC         := 0;
            VL_TOT_CONT_CUM_PER   := 0;
            VL_RET_CUM            := 0;
            VL_OUT_DED_CUM        := 0;
            VL_CONT_CUM_REC       := 0;
            VL_CONT_NC_REC        := VL_TOT_CONT_NC_DEV - (VL_RET_NC + VL_OUT_DED_NC);

            if VL_CONT_NC_REC < 0 then
              VL_CONT_NC_REC := VL_CONT_NC_REC * (-1);

            VL_TOT_CONT_REC       := VL_TOT_CONT_REC + (VL_CONT_NC_REC + VL_CONT_CUM_REC);

            if VL_TOT_CONT_REC < 0 then
              VL_TOT_CONT_REC := VL_TOT_CONT_REC * (-1);

            with RegistroM605New do
            begin

              case frmIntegracao.rgpRegimeApuracao.ItemIndex of
                0:begin //n�o cumulativa

                    NUM_CAMPO := '12';
                    COD_REC   := '585601';

                  end;
                1:begin// exclusiva cumulativa

                    NUM_CAMPO := '08';
                    COD_REC   := '585608';

                  end;
              end;

              VL_DEBITO := VL_DEBITO + (VL_CONT_NC_REC + VL_CONT_CUM_REC);

              if VL_DEBITO < 0 then
                VL_DEBITO := VL_DEBITO * (-1);

            end;

            dmSintegraSPED.cdsRegistroM610_TEMP.Next;

          end;

        end;

        dmSintegraSPED.cdsRegistroM800_TEMP.First;

        while not dmSintegraSPED.cdsRegistroM800_TEMP.Eof do
        begin

          with RegistroM800New do
          begin

            CST_COFINS      := StrToCstCofins(dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value);
            VL_TOT_REC      := dmSintegraSPED.cdsRegistroM800_TEMPVL_TOT_REC.Value;

            dmSintegraSPED.cdsRegistroM810_TEMP.Filtered  := False;
            dmSintegraSPED.cdsRegistroM810_TEMP.Filter    := 'CST_COFINS = ' + dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value;
            dmSintegraSPED.cdsRegistroM810_TEMP.Filtered  := True;
            dmSintegraSPED.cdsRegistroM810_TEMP.First;

            while not dmSintegraSPED.cdsRegistroM810_TEMP.Eof do
            begin

              with RegistroM810New do
              begin

                CST_COFINS    := StrToCstCofins(dmSintegraSPED.cdsRegistroM810_TEMPCST_COFINS.Value);
                NAT_REC       := dmSintegraSPED.cdsRegistroM810_TEMPNAT_RECEITA.Value;
                VL_REC        := dmSintegraSPED.cdsRegistroM810_TEMPVL_REC.Value;

              end;

              dmSintegraSPED.cdsRegistroM810_TEMP.Next;

            end;

          end;

          dmSintegraSPED.cdsRegistroM800_TEMP.Next;

        end;

      end;

    end;

  end;

end;

procedure Gravar_Bloco_P;
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_P do
  begin

    with RegistroP001New do
    begin

      IND_MOV := imSemDados;

    end;

  end;

end;

procedure Gravar_Bloco_1;
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_1 do
  begin

    with Registro1001New do
    begin

      IND_MOV := imSemDados;

    end;

  end;

end;


function ObterIndiceRegistro0140(pCOD_EST0140: string): integer;
var
  intFor140,IntFor150: integer;
begin

  Result := 0;

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    for intFor140 := 0 to Registro0140.Count - 1 do
    begin

      if Registro0140.Items[intFor140].COD_EST = pCOD_EST0140 then
      begin

        Result := intFor140;
        Break;

      end;

    end;

  end;

end;
function Retornar_versao_SPEDContribuicoes(pDataI, pDataF: TDateTime)  : ACBrEPCBlocos.TACBrVersaoLeiaute;
begin

  if (pDataF < StrToDate('01/03/12')) then
      Result := ACBrEPCBlocos.vlVersao101
  else if (pDataI >= StrToDate('01/03/12')) and (pDataF < StrToDate('01/07/12')) then
    Result := ACBrEPCBlocos.vlVersao200
  else
    Result := ACBrEPCBlocos.vlVersao201;

end;

procedure ResetarTabelasTemporarias;
begin

  dmSintegraSPED.cdsRegistroM100_TEMP.Close;
  dmSintegraSPED.cdsRegistroM105_TEMP.Close;
  dmSintegraSPED.cdsRegistroM200_TEMP.Close;
  dmSintegraSPED.cdsRegistroM205_TEMP.Close;
  dmSintegraSPED.cdsRegistroM210_TEMP.Close;
  dmSintegraSPED.cdsRegistroM500_TEMP.Close;
  dmSintegraSPED.cdsRegistroM505_TEMP.Close;
  dmSintegraSPED.cdsRegistroM400_TEMP.Close;
  dmSintegraSPED.cdsRegistroM410_TEMP.Close;
  dmSintegraSPED.cdsRegistroM610_TEMP.Close;
  dmSintegraSPED.cdsRegistroM800_TEMP.Close;
  dmSintegraSPED.cdsRegistroM810_TEMP.Close;
  dmSintegraSPED.cdsRegistroM200_TEMP.Close;
  dmSintegraSPED.cdsRegistroM205_TEMP.Close;
  dmSintegraSPED.cdsRegistroM210_TEMP.Close;

  dmSintegraSPED.cdsRegistroM400_TEMP.IndexFieldNames := 'CST_PIS';
  dmSintegraSPED.cdsRegistroM800_TEMP.IndexFieldNames := 'CST_COFINS';

  dmSintegraSPED.cdsRegistroM100_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM105_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM200_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM205_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM210_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM500_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM505_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM400_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM410_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM610_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM800_TEMP.CreateDataSet;
  dmSintegraSPED.cdsRegistroM810_TEMP.CreateDataSet;


  cVL_REC_BRT_M210  := 0;
  cVL_REC_BRT_M610  := 0;
  pAliq_Pis_M210    := 0;
  pAliq_Cofins_M610 := 0;
  cVL_BC_CONT_M210  := 0;
  cVL_BC_CONT_M610  := 0;


end;

function ValidarCST_PIS_COFINS_CREDITO_REC(pOpcap:smallint;pCST:string):boolean;
const
  CST_CRED:  array[0..13] of String = ('50', '51', '52', '53', '54', '55', '56',
                                     '60', '61', '62', '63', '64', '65', '66');
  CST_REC:   array[0..5] of String = ('04', '05', '06', '07', '08', '09');
  CST_M210:  array[0..4] of String = ('01', '02', '03', '05', '49');
var
  i:integer;
  bLocalizou: Boolean;

begin

  bLocalizou  := False;
  i           := 0;

  case pOpcap of
    0:begin // credito

        while (not (bLocalizou)) and (i <= 13) do
        begin

          bLocalizou := CST_CRED[i] = pCST;
          inc(i);

        end;

      end;
    1:begin // receita

        while (not (bLocalizou)) and (i <= 5) do
        begin

          bLocalizou := CST_REC[i] = pCST;
          inc(i);

        end;

      end;
    2:begin // cst m210

        while (not (bLocalizou)) and (i <= 5) do
        begin

          bLocalizou := CST_M210[i] = pCST;
          inc(i);

        end;

      end;

  end;

  Result := bLocalizou;

end;

function ValidarCOD_CONT_m210(pCod_Cont:string):boolean;
const
  COD_CONT_M210:  array[0..6] of String = ('01', '02', '31', '32', '51', '52', '53');

var
  i:integer;
  bLocalizou: Boolean;

begin

  bLocalizou  := False;
  i           := 0;

  while (not (bLocalizou)) and (i <= 6) do
  begin

    bLocalizou := COD_CONT_M210[i] = pCod_Cont;
    inc(i);

  end;

  Result := bLocalizou;

end;

procedure AbrirTabelas;
begin

  dmMProvider.cdsBarras.Close;
  dmMProvider.cdsBarras.ProviderName    := 'dspBarras';
  dmMProvider.cdsBarras.IndexFieldNames := 'PRODUTO';

  dmDBEXMaster.fdqBarras.SQL.Clear;
  dmDBEXMaster.fdqBarras.SQL.Add('select * from barras');
  dmDBEXMaster.fdqBarras.SQL.Add('order by produto');

  dmMProvider.cdsBarras.Open;
  dmMProvider.cdsBarras.ProviderName := '';

  dmMProvider.cdsCFOP_CFPS.Close;
  dmMProvider.cdsCFOP_CFPS.ProviderName     := 'dspCFOP_CFPS';
  dmMProvider.cdsCFOP_CFPS.IndexFieldNames  := 'CFOP';

  dmDBEXMaster.fdqCFOP_CFPS.SQL.Clear;
  dmDBEXMaster.fdqCFOP_CFPS.SQL.Add('select * from cfop');

  dmMProvider.cdsCFOP_CFPS.Open;
  dmMProvider.cdsCFOP_CFPS.ProviderName := '';

  dmMProvider.cdsSped_R0500.Close;
  dmMProvider.cdsSped_R0500.ProviderName    := 'dspSped_R0500';
  dmMProvider.cdsSped_R0500.IndexFieldNames := 'COD_CTA';

  dmDBEXMaster.fdqSped_R0500.SQL.Clear;
  dmDBEXMaster.fdqSped_R0500.SQL.Add('select * from SPED_R0500');

  dmMProvider.cdsSped_R0500.Open;
  dmMProvider.cdsSped_R0500.ProviderName := '';

end;

procedure Gravar_Bloco_M400;
begin

  dmSintegraSPED.cdsSelM400_800_SPEDC.Close;
  dmSintegraSPED.cdsSelM400_800_SPEDC.ProviderName := 'dspSelM400_800_SPEDC';

  dmSintegraSPED.fdqSelM400_800_SPEDC.Params[0].Value  := frmIntegracao.dtpSpedContribuicoesInicial.Date;
  dmSintegraSPED.fdqSelM400_800_SPEDC.Params[1].Value  := frmIntegracao.dtpSpedContribuicoesFinal.Date;

  dmSintegraSPED.cdsSelM400_800_SPEDC.Open;
  dmSintegraSPED.cdsSelM400_800_SPEDC.ProviderName := '';

  iTotalRegistros              := dmSintegraSPED.cdsSelM400_800_SPEDC.RecordCount;
  iRegistroAtual               := 0;
  frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco M - Detalhamentos das receitas isentas PIS/COFINS';

  while not dmSintegraSPED.cdsSelM400_800_SPEDC.eof do
  begin

    inc(iRegistroAtual);

    frmIntegracao.lblC470.Caption := '  Item ' + IntToStr(iRegistroAtual)+ '/' + IntToStr(iTotalRegistros) + '  ';
    Application.ProcessMessages;

    if ValidarCST_PIS_COFINS_CREDITO_REC(1,FormatFloat('00',dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_PIS.Value)) then
    begin

      if not dmSintegraSPED.cdsRegistroM400_TEMP.Locate('CST_PIS', FormatFloat('00', dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_PIS.Value) , []) then
        dmSintegraSPED.cdsRegistroM400_TEMP.Append
      else
        dmSintegraSPED.cdsRegistroM400_TEMP.Edit;

      dmSintegraSPED.cdsRegistroM400_TEMPCST_PIS.Value        := FormatFloat('00', dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_PIS.Value);
      dmSintegraSPED.cdsRegistroM400_TEMPVL_TOT_REC.Value     := dmSintegraSPED.cdsRegistroM400_TEMPVL_TOT_REC.Value + dmSintegraSPED.cdsSelM400_800_SPEDCOP_VALOR_ITEM.Value;
      dmSintegraSPED.cdsRegistroM400_TEMP.Post;

      if not dmSintegraSPED.cdsRegistroM410_TEMP.Locate('CST_PIS; NAT_RECEITA', VarArrayOf([dmSintegraSPED.cdsRegistroM400_TEMPCST_PIS.Value, FormatFloat('000',dmSintegraSPED.cdsSelM400_800_SPEDCOP_NAT_REC.Value)]), []) then
        dmSintegraSPED.cdsRegistroM410_TEMP.Append
      else
        dmSintegraSPED.cdsRegistroM410_TEMP.Edit;

      dmSintegraSPED.cdsRegistroM410_TEMPNAT_RECEITA.Value    := FormatFloat('000',dmSintegraSPED.cdsSelM400_800_SPEDCOP_NAT_REC.Value);
      dmSintegraSPED.cdsRegistroM410_TEMPCST_PIS.Value        := FormatFloat('00',dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_PIS.Value);
      dmSintegraSPED.cdsRegistroM410_TEMPVL_RECEITA.Value     := dmSintegraSPED.cdsRegistroM410_TEMPVL_RECEITA.Value + (dmSintegraSPED.cdsSelM400_800_SPEDCOP_VALOR_ITEM.Value);
      dmSintegraSPED.cdsRegistroM410_TEMP.Post;

    end;


    if ValidarCST_PIS_COFINS_CREDITO_REC(1,FormatFloat('00',dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_COFINS.Value)) then
    begin

      if not dmSintegraSPED.cdsRegistroM800_TEMP.Locate('CST_COFINS', FormatFloat('00',dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_COFINS.Value), []) then
        dmSintegraSPED.cdsRegistroM800_TEMP.Append
      else
        dmSintegraSPED.cdsRegistroM800_TEMP.Edit;

      dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value     := FormatFloat('00',dmSintegraSPED.cdsSelM400_800_SPEDCOP_CST_COFINS.Value);
      dmSintegraSPED.cdsRegistroM800_TEMPVL_TOT_REC.Value     := dmSintegraSPED.cdsRegistroM800_TEMPVL_TOT_REC.Value + (dmSintegraSPED.cdsSelM400_800_SPEDCOP_VALOR_ITEM.Value);
      dmSintegraSPED.cdsRegistroM800_TEMP.Post;

      if not dmSintegraSPED.cdsRegistroM810_TEMP.Locate('CST_COFINS; NAT_RECEITA', VarArrayOf([dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value, FormatFloat('000',dmSintegraSPED.cdsSelM400_800_SPEDCOP_NAT_REC.Value)]), []) then
        dmSintegraSPED.cdsRegistroM810_TEMP.Append
      else
        dmSintegraSPED.cdsRegistroM810_TEMP.Edit;

      dmSintegraSPED.cdsRegistroM810_TEMPNAT_RECEITA.Value    := FormatFloat('000',dmSintegraSPED.cdsSelM400_800_SPEDCOP_NAT_REC.Value);
      dmSintegraSPED.cdsRegistroM810_TEMPCST_COFINS.Value     := dmSintegraSPED.cdsRegistroM800_TEMPCST_COFINS.Value;
      dmSintegraSPED.cdsRegistroM810_TEMPVL_REC.Value         := dmSintegraSPED.cdsRegistroM810_TEMPVL_REC.Value + (dmSintegraSPED.cdsSelM400_800_SPEDCOP_VALOR_ITEM.Value);
      dmSintegraSPED.cdsRegistroM810_TEMP.Post;

    end;

    dmSintegraSPED.cdsSelM400_800_SPEDC.Next;

  end;


end;

function LocalizarRegistroC481(pCOD_ITEM, pCST, pSerieECF:string;pAliq:currency): boolean;
var
 indiceC400,  indiceC481,indiceC405, pCRO, pCRZ: integer;
 dData:TDateTime;
begin

{  Result := false;

  indiceC400 := ObterIndiceRegistroC400(pSerieECF);

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_C.RegistroC001.RegistroC010.Items[0],RegistroC400.Items[indiceC400] do
  begin

    for i RegistroC405.Items[indiceC400]

    indiceC405 := ObterIndiceRegistroC405(pSerieECF);





    end;


    for IntFor0400 := 0 to Registro0140.Items[indice140].Registro0400.Count - 1 do
    begin

      if Registro0140.Items[indice140].Registro0400.Items[IntFor0400].COD_NAT = pCOD_EST0140 then
      begin

        Result := True;
        Break;

      end;

    end;

  end;
}
end;

function ObterIndiceRegistroC400(pCOD_C400: string): integer;
var
  intForC400: integer;
begin

  Result := 0;

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_C.RegistroC001.RegistroC010.Items[0] do
  begin

    for intForC400 := 0 to RegistroC400.Count - 1 do
    begin

      if RegistroC400.Items[intForC400].ECF_FAB = pCOD_C400 then
      begin

        Result := intForC400;
        Break;

      end;

    end;

  end;

end;

function ObterIndiceRegistroC405(pData:TDateTime;pCRO, pCRZ, pCOO_FIN, pIndC400:integer):integer;
var
  intForC405: integer;
begin

{  Result := 0;

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_C.RegistroC001.RegistroC010.Items[0] do
  begin

    with RegistroC400.Items[pIndC400] to
    begin

      for intForC405 := 0 to RegistroC400.Items[pIndC400].RegistroC405.Count - 1 do
      begin

        with RegistroC400.Items[pIndC400].RegistroC405.Items[intForC405] do
        begin

          if (DT_DOC = pData) and (CRO = pCRO) and (CRZ = pCRZ) then
            Result := intForC405;

          Break;

        end;

      end;

    end;

  end;
}
end;
function LocalizarRegistro0500(pDATA:TDateTime; pCONTA: string): boolean;
var
  indice0500,IntFor0500: integer;
begin

  Result      := false;

  indice0500  := ObterIndiceRegistro0500(pDATA, pCONTA);

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    for IntFor0500 := 0 to Registro0500.Count - 1 do
    begin

      if (Registro0500.Items[indice0500].DT_ALT = pDATA) and (Registro0500.Items[indice0500].COD_CTA = pCONTA) then
      begin

        Result := True;
        Break;

      end;

    end;

  end;

end;
function ObterIndiceRegistro0500(pDATA:TDateTime; pCONTA: string): integer;
var
  intFor500: integer;
begin

  Result := 0;

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    for intFor500 := 0 to Registro0500.Count - 1 do
    begin

      if (Registro0500.Items[intFor500].DT_ALT = pDATA) and (Registro0500.Items[intFor500].COD_CTA = pCONTA) then
      begin

        Result := intFor500;
        Break;

      end;

    end;

  end;

end;
procedure Gravar_Registro0500(pOpcao:smallint);
begin

  with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0.Registro0001 do
  begin

    if Length(Trim(dmMProvider.cdsSped_R0500COD_CTA.Value)) > 0 then
    begin

      with Registro0500 do
      begin

        if pOpcao = 0 then
          dmMProvider.cdsSped_R0500.FindKey([Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CONTA_ANALITICA.Value)])
        else
          dmMProvider.cdsSped_R0500.FindKey([Trim(dmSintegraSPED.cdsSelRC470_SPEDCOP_COD_CTA.Value)]);

        if not LocalizarRegistro0500(dmMProvider.cdsSped_R0500DATA_CADASTRO.Value,Trim(dmMProvider.cdsSped_R0500COD_CTA.Value)) then
        begin

          with frmIntegracao.ACBrSPEDPisCofins1.Bloco_0 do
          begin

            with Registro0500New do
            begin

              DT_ALT      := dmMProvider.cdsSped_R0500DATA_CADASTRO.Value;
              COD_NAT_CC  := StrToNaturezaConta(FormatFloat('00',StrToIntDef(dmMProvider.cdsSped_R0500COD_NAT_CC.Value,1)));
              IND_CTA     := StrToIndCTA(dmMProvider.cdsSped_R0500IND_CTA.Value);
              NIVEL       := IntToStr(dmMProvider.cdsSped_R0500NIVEL.Value);
              COD_CTA     := Trim(dmMProvider.cdsSped_R0500COD_CTA.Value);
              NOME_CTA    := Trim(dmMProvider.cdsSped_R0500NOME_CTA.Value);
              COD_CTA_REF := Trim(dmMProvider.cdsSped_R0500COD_CTA_REFER.Value);
              CNPJ_EST    := dmMProvider.cdsSped_R0500CNPJ_EST.Value;

            end;


          end;


        end;

      end;

    end;

  end;

end;
end.