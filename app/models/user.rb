class User < ApplicationRecord
  has_many :created_events, :foreign_key => "creator_id", :class_name => "Event"
  has_many :events_attendees, :foreign_key => "attendee_id", :class_name => "EventsAttendee"
  has_many :attended_events, :through => :events_attendees, source: "attended_event"
  # has_and_belongs_to_many :attended_events
end
