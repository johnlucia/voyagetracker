class Position < ApplicationRecord
  belongs_to :boat

  def how_long_ago
    time_difference = Time.now - created_at
    diff = { minutes: (time_difference / 1.minute).round,
             hours: (time_difference / 1.hour).round,
             days: (time_difference / 1.day).round }

    return "#{diff[:days]} days" if diff[:days] > 3
    return "#{diff[:hours]} hours" if diff[:hours] >= 2
    return "#{diff[:minutes]} minutes"
  end
end
