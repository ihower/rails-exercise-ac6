class WelcomeController < ApplicationController

  def ajaxhtml
    sleep(3)
    render :layout => false
  end

end
