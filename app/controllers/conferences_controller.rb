class ConferencesController < ApplicationController

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true)

    if params[:event_id]
      @event = Event.find_by_friendly_id( params[:event_id] )
    else
      @event = Event.new
      @event.status = nil
      @event.friendly_id = SecureRandom.hex(10)
      @event.attendees.build
    end

    gon.tags = Tag.all.map{ |t| t.name }
  end

  def show
    @event = Event.find_by_friendly_id(params[:id])

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

      HardWorkerJob.perform_later(current_user)
      redirect_to conferences_path
    else
      @q = Event.ransack(params[:q])
      @events = @q.result(distinct: true)

      render "index" # use index.html.erb template
    end
  end

  def update
    @event = Event.find_by_friendly_id(params[:id])

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
    @event = Event.find_by_friendly_id(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js # destroy.js.erb
    end

  end

  private

  def event_params
    params.require(:event).permit(:name, :status, :description, :url, :category_id, :logo, :tag_list, :date, :friendly_id,
                    :attendees_attributes => [:id, :name, :_destroy],
                    :group_ids => [] )
  end

end
