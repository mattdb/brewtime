class Brew
  include Mongoid::Document
  field :name, type: String
  field :brewed, type: Date
  
  validates_presence_of :name, :brewed
  validates_date :brewed
  
  embeds_many :steps
  accepts_nested_attributes_for :steps
end
