class ApiV1::EventsController < ApiController

  def index
    @events = Event.all
  end

  def create
    @event = Event.new( :name => params[:name],
                        :friendly_id => params[:friendly_id] )

    if @event.save
      render :json => { :message => "OK", :id => @event.id }
    else
      render :json => { :message => "Validate failed" }, :status => 400
    end
  end

end
