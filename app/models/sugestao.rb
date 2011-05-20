class Sugestao
  
  module Criar
    def self.sugestoes_por_pessoas
      historico             = historico_contas_a_receber
      historico_por_pessoas = historico.group_by{|t| t.pessoa_id}
    end
    
    # Retornar o historico de ultimas contas a receber dos ultimos 3 meses + quantidade do mes atual
    def self.historico_contas_a_receber(quantidade_meses = 12)
      historico_de_contas = Sugestao.request 'ObterContasReceber',
        :dt1 => Time.now.months_ago(quantidade_meses).to_date.to_s, 
        :dt2 => Date.today.to_s
      
      historico_de_contas
      # .collect do |dados|
      #         ContaAReceber.new(:pessoa_id => dados[:pessoa_id],
      #           :receita => dados[:receita], :data => dados[:data_da_receita])
      #       end
    end
  
    # Envia sugestoes para o modulo de analise e recebe a resposta de cada uma
    def self.verificar_disponibilidade
      historico_contas_a_receber
    end
  end
  
  
  # private
  def self.request(method,params = nil)
    Sugestao.conexao.request method, params
  end
  
  
  def self.conexao
    @cliente ||= Savon::Client.new do
      wsdl.document = "http://192.168.0.107:8080/ContaServiceService/ContaService?wsdl"
    end
    @cliente
  end
end

# 1 - Buscar historico de contas a receber
# 2 - Montar a sugestao de receitas
# 3 - Enviar sugestoes a Analise
# 4 - Atualizar as sugestoes passadas





# ObterContasReceber(dt1,dt2)
# => pessoa_id
# => 


# VerificarViabilidade : receitas
# => Enviar varias ContasAReceber
  # => 