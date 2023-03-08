class HomeController < ApplicationController
  def index
    @my_pets = {dog: 1, cat: 2}
  end
end
