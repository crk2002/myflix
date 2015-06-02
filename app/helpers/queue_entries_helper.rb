module QueueEntriesHelper
  def create_select(qe)
    rating = qe.rating
    options = {}
    options[" "] = nil if !rating
    (1..5).each { |n| options[pluralize(n,"star")] = n }
    select_tag "queue_entries[][rating]", options_for_select(options, rating)
  end
end