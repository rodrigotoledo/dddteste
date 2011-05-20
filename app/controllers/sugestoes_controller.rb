class SugestoesController < ApplicationController
  def sugerir
    render :xml => Domain::Sugestao.criar(params[:quantidade_meses].to_i)
  end
end