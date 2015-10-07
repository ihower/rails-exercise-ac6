class WelcomeController < ApplicationController

  def ajaxhtml
    sleep(3)
    render :layout => false
  end

  def ajaxjs
    respond_to do |format|
      format.js  # ajaxjs.js.erb
      format.json {
          render :json => { :title => "ABCDEFG",  :time => Time.now }
      }
    end
  end

end
