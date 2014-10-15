class Time
  def to_json(*a)
    "{\"$date\": \"#{iso8601(1)}\"}"
  end

  def as_json(options = {})
    { "$date" => iso8601(1) }
  end
end
