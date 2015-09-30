class Attendee < ActiveRecord::Base

  belongs_to :event, :counter_cache => true, # event.attendees_count
                     :touch => "last_registered_at" # event.updated_at
end
