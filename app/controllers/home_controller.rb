class HomeController < ApplicationController
  def index
    @produtos = Produto.all
  end
end
