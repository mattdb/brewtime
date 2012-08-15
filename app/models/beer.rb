class Beer
  include Mongoid::Document
  field :name, type: String
  field :brewed, type: DateTime
  
  embeds_many :steps
end
