require 'open-uri'
module Domain
  class Sugestao
    attr_accessor :fornecedor, :valor

    def self.criar(quantidade_meses = 12)
      historico = Domain::ContasService.consultar_historico(quantidade_meses.to_i.abs*-1)
      previsao  = Domain::ContasService.consultar_historico(quantidade_meses.to_i.abs)
      historico_ac = {}
      previsao_ac = {}
      historico.each do |conta|
        historico_ac[conta.fornecedor] = conta.valor + (historico_ac[conta.fornecedor] || 0)
      end
    
      previsao.each do |conta|
        previsao_ac[conta.fornecedor] = conta.valor + (previsao_ac[conta.fornecedor] || 0)
      end
      
      historico_ac.each do |chave,valor|

        if valor > (previsao_ac[chave] || 0)
          sugestao = Sugestao.new
          sugestao.fornecedor = chave
          sugestao.valor      = valor
          return sugestao
        end
      end
      []
    end
  end
end