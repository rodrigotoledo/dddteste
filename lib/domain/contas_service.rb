module Domain
  class ContasService
    # Retornar contas a receber 
    def self.consultar_historico(quantidade_meses = 12)
      dt_inicial  = Time.now.months_ago(quantidade_meses).to_date.to_s
      dt_final    = Date.today.to_s
      
      historico_de_contas = Infrastructure::Conexao.requisicao(dt_inicial, dt_final)

      historico_de_contas
    end
  end
end