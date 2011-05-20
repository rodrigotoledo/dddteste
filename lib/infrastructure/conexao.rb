module Infrastructure
  class Conexao
    def self.requisicao(dt1,dt2)
      doc = open("http://192.168.0.107:8080/Contas/resources/contas?dataInicial=#{dt1}&dataFinal=#{dt2}"){ |f| Hpricot(f) }
    end
  end
end