require 'test_helper'
require 'mocha'

class SugestaoTest < ActiveSupport::TestCase
  
  def setup
    
  end
  

 def test_retornar_historico_de_contas_a_receber
   lista_esperada = []
   
   conta      = ContaAReceber.new
   conta.data = Date.today
   lista_esperada << conta
   
   conta      = ContaAReceber.new
   conta.data = Date.today-7.days
   lista_esperada << conta
   
   conta      = ContaAReceber.new
   conta.data = Date.today-60.days
   lista_esperada << conta
     
   Sugestao.expects(:request).with(:anything).returns(lista_esperada)
   
   Sugestao::Criar.historico_contas_a_receber(1)
   
   # assert true
 end
end