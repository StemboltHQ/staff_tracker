class EventSchedule
  def self.populate_upcoming_show_and_tell!
    upcoming_fridays = (Time.zone.today..Time.zone.today + 4.weeks)
                       .select(&:friday?)

    upcoming_fridays.each do |friday_date|
      Event.find_or_create_by(
        name: 'Show & Tell',
        date: friday_date,
        location: 'Lg boardroom'
      )
    end
  end
end
