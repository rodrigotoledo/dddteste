require File.dirname(__FILE__) + '/../spec_helper'

describe Domain::Sugestao do
  
  it "deve retornar as contas a receber de acordo com 1 mes de analise" do
    
    lista_esperada = [
      Domain::ContaAReceber.new(:data => Date.today),
      Domain::ContaAReceber.new(:data => Date.today-3.days),
      Domain::ContaAReceber.new(:data => Date.today-60.days)
    ]

    Infrastructure::Conexao.stubs(:requisicao).returns(lista_esperada)
    
    Domain::ContasService.consultar_historico(1).should have(3).elements
  end
  
  
  it "deve criar uma sugestao para um mes de analise" do
    lista_historico = []
    
    conta = Domain::ContaAReceber.new
    conta.data = Date.today - 7.days
    conta.fornecedor = 1
    conta.valor = 1000
    lista_historico << conta
    conta = Domain::ContaAReceber.new
    conta.data = Date.today - 3.days
    conta.fornecedor = 1
    conta.valor = 1000
    lista_historico << conta
    conta = Domain::ContaAReceber.new
    conta.data = Date.today - 14.days
    conta.fornecedor = 2
    conta.valor = 1000
    lista_historico << conta
    
    conta = Domain::ContaAReceber.new
    conta.data = Date.today + 12.days
    conta.fornecedor = 2
    conta.valor = 1000
    lista_previsao = [conta]
    Domain::ContasService.stubs(:consultar_historico).with(1).returns(lista_previsao)
    Domain::ContasService.stubs(:consultar_historico).with(-1).returns(lista_historico)
    sugestao = Domain::Sugestao.criar(1)
    sugestao.fornecedor.should eq 1
    sugestao.valor.should eq 2000
  end
  
end