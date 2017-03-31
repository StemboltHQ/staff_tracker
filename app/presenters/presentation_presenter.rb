class PresentationPresenter < BasePresenter
  def associable_events
    events = Event.upcoming.to_a
    events.prepend(event) if event
    events
  end
end
