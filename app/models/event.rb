class Event < ActiveRecord::Base

  validates_presence_of :name

  has_many :attendees, :dependent => :destroy

  def to_param
    "#{self.id}-#{self.name}"
  end

end
