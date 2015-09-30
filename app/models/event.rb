class Event < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :category
  has_many :attendees, :dependent => :destroy

  has_many :groupships
  has_many :groups, :through => :groupships


  delegate :name, :to => :category,
                  :prefix => true,
                  :allow_nil => true
  # def category_name
  #   if category
  #     category.name
  #   else
  #     nil
  #   end
  # end

  def to_param
    "#{self.id}-#{self.name}"
  end

end
