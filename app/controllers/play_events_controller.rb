class PlayEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # Require login except index and show
  before_action :set_play_event, only: [:show, :edit, :update, :destroy, :join]

  def index
    @play_events = PlayEvent.all
  end

  def show
  end

  def new
    @play_event = PlayEvent.new
  end

  def create
    @play_event = PlayEvent.new(play_event_params)
    @play_event.host = current_user
    if @play_event.save
      redirect_to @play_event, notice: 'Event created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @play_event.update(play_event_params)
      redirect_to @play_event, notice: 'Event updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @play_event.destroy
    redirect_to play_events_url, notice: 'Event deleted successfully.'
  end

  def join
    EventParticipant.create(play_event: @play_event, user: current_user)
    redirect_to @play_event, notice: 'You have joined the event.'
  end

  private

  def set_play_event
    @play_event = PlayEvent.find(params[:id])
  end

  def play_event_params
    params.require(:play_event).permit(:sport_id, :sport_type, :event_location, :event_category, :event_instructions, :event_date, :event_start_time, :event_end_time, :event_capacity)
  end
end