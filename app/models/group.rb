class Group < ActiveRecord::Base

  has_many :groupships
  has_many :events, :through => :groupships
  
end
