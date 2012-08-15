class Step
  include Mongoid::Document
  field :name, type: String
  field :start, type: DateTime
  field :min_length, type: Integer
  field :max_length, type: Integer
  field :actual_length, type: Integer
  
  embedded_in :beer
end
