class Step
  include Mongoid::Document
  field :name, type: String
  field :start, type: DateTime
  field :min_length, type: Integer
  field :max_length, type: Integer
  field :actual_length, type: Integer
  
  validates_presence_of :name, :min_length, :max_length
  
  embedded_in :brew
  
  
  def complete?
    actual_length.present?
  end
  
  def complete!
    self.actual_length = (DateTime.current - start).to_i
    save!
    actual_length
  end
  
  def soonest_end
    return actual_end if start.present? && complete?
    return nil if start.nil? || min_length.nil?
    start + min_length.days
  end
  def latest_end
    return actual_end if start.present? && complete?
    return nil if start.nil? || max_length.nil?
    start + max_length.days
  end
  
  def actual_end
    return nil if start.nil? || actual_length.nil?
    start + actual_length.days
  end
end
