class Brew
  include Mongoid::Document
  field :name, type: String
  field :brewed, type: Date
  
  validates_presence_of :name, :brewed
  validates_date :brewed
  
  embeds_many :steps
  accepts_nested_attributes_for :steps
  
  def current_step
    # consider refactor to use db queries-- in this case probably little difference though
    steps.detect {|s| !s.complete?}
  end
end
