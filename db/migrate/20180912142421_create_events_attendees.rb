class CreateEventsAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :events_attendees do |t|
      t.references :attendee
      t.references :attended_event

      t.timestamps
    end
  end
end
