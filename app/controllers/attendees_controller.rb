class AttendeesController < ApplicationController

  before_action :find_event

  def index
    @attendees = @event.attendees
  end

  def create
    @attendee = @event.attendees.build( attendee_params )
    if @attendee.save
      redirect_to conference_attendees_path(@event)
    else
      render "index"
    end
  end

  protected

  def attendee_params
    params.require(:attendee).permit(:name)
  end

  def find_event
    @event = Event.find_by_friendly_id( params[:conference_id] )
  end
end
