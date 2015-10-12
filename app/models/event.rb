class Event < ActiveRecord::Base

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  validates_presence_of :name, :friendly_id

  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/,
                      :message => "Errrrr"

  belongs_to :category
  has_many :attendees, :dependent => :destroy

  has_many :groupships
  has_many :groups, :through => :groupships

  has_many :taggings
  has_many :tags, :through => :taggings


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
    # "#{self.id}-#{self.name}"
    self.friendly_id
  end

  def tag_list
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(str)
    arr = str.split(",")

    self.tags = arr.map do |t|
      tag = Tag.find_by_name(t)
      unless tag
        tag = Tag.create!( :name => t )
      end
      tag
    end

  end

end
