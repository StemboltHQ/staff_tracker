class EventPresenter < BasePresenter
  def display_name
    "#{@model.name} - #{@model.date}"
  end
end
