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
    end

    if params[:event_id]
      @event = Event.find( params[:event_id] )
    else
      @event = Event.new
    end

  end

  def show
    @event = Event.find(params[:id])
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
    params.require(:event).permit(:name, :description, :url, :category_id, :group_ids => [] )
  end

end
