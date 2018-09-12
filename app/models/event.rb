class Event < ApplicationRecord
  belongs_to :creator, :class_name => "User"
  has_many :events_attendees, :foreign_key => "attended_event_id", :class_name => "EventsAttendee"
  has_many :attendees, :through => :events_attendees, source: "attendee"
  scope :upcoming, lambda { where("#{:date} >= ?" , Date.current) }
  scope :past, lambda { where("#{:date} < ?" , Date.current) }
  # has_and_belongs_to_many :attendees,
  default_scope -> { order(:date ) }
  validates :title, presence: true, length: { maximum: 25 }
  validates :date, presence: true
  validate :new_event_date_cannot_be_in_the_past
  validate :start_time_has_to_be_before_end_time

  def new_event_date_cannot_be_in_the_past
    if date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

  def start_time_has_to_be_before_end_time
    if start_time > end_time
      errors.add(:end_time, :start_time, message: "must be after start time")
    end
  end
end
