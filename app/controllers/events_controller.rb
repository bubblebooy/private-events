class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :leave, :join]
  before_action :authorize, only: [:new, :create]

  def index
    @events = Event.all
  end

  def show
    @users = @event.attendees
  end


  def new
    @event = Event.new
  end

  def edit
  end

  def create
    # @event = Event.new(event_params)
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to current_user
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  def join
    @event.attendees << current_user
    redirect_back(fallback_location: root_path)
  end

  def leave
    @event.attendees.delete(current_user)
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def authorize
      redirect_to(root_url) if current_user.nil?
    end

    def event_params
      params.require(:event).permit(:title, :description, :date, :start_time, :end_time)
    end

end
