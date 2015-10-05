class ConferencesController < ApplicationController

  def index
    if params[:keyword]
      @events = Event.where( ["name LIKE ?", "%#{params[:keyword]}%"] )
    else
      @events = Event.all
    end

    if params[:sort] == "id_desc"
      @events = @events.order("id desc")
    elsif params[:sort] == "id_asc"
      @events = @events.order("id asc")
    elsif params[:sort] == "attendees_count"
      @events = @events.order("attendees_count desc")
    elsif params[:sort] == "last_registered_at"
      @events = @events.order("last_registered_at desc")
    end

    if params[:event_id]
      @event = Event.find( params[:event_id] )
    else
      @event = Event.new
    end

  end

  def show
    @event = Event.find(params[:id])

    if cookies["visit-event-#{@event.id}"]
    else
      cookies["visit-event-#{@event.id}"] = "ya!"
      @event.views_count += 1
      @event.save!
    end

  end

  def create
    @event = Event.new( event_params )
    if @event.save
      redirect_to conferences_path
    else
      @events = Event.all
      render "index" # use index.html.erb template
    end
  end

  def update
    @event = Event.find(params[:id])

    if params[:destroy_logo] == "1"
      @event.logo = nil
    end

    if @event.update(event_params)
      redirect_to conferences_path
    else
      @events = Event.all
      render "index"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to :back
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :url, :category_id, :logo, :tag_list, :group_ids => [] )
  end

end
