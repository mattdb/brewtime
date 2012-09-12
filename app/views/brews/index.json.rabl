collection @brews

attributes :id, :name, :brewed

child :steps do
  attributes :id, :name, :start, :min_length, :max_length, :actual_length
  attributes :complete?, :soonest_end, :latest_end, :actual_end
end