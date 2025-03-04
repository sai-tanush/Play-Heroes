class PlayEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # Require login except index and show
  before_action :set_play_event, only: [:show, :edit, :update, :destroy, :join, :leave]
  
  def index
    # Current datetime for comparison
    now = Time.current
    
    # Get only events that haven't started yet (comparing full datetime)
    @play_events = PlayEvent.where('event_start_time > ?', now).order(event_start_time: :asc)

     # Filters
     if params[:date].present?
      date = Date.parse(params[:date])
      @play_events = @play_events.where('DATE(event_start_time) = ?', date)
    end

    if params[:sport_name].present?
      @play_events = @play_events.joins(:sport).where('LOWER(sports.name) LIKE ?', "%#{params[:sport_name].downcase}%")
    end

    if params[:location].present?
      @play_events = @play_events.where('LOWER(event_location) LIKE ?', "%#{params[:location].downcase}%")
    end   

    
    if user_signed_in?
      # Same filtering for joined events
      @joined_events = current_user.joined_events.where('event_start_time > ?', now).order(event_start_time: :asc)
      @user_pending_requests = current_user.join_requests.where(status: 'pending')
      @pending_host_requests = JoinRequest.joins(:play_event).where(play_events: { host_id: current_user.id }, status: 'pending')
    end
  end
  
  def show
    @participants = @play_event.participants
    @is_host = user_signed_in? && current_user == @play_event.host
    @is_participant = user_signed_in? && @play_event.participants.include?(current_user)
    @has_pending_request = user_signed_in? && JoinRequest.exists?(user: current_user, play_event: @play_event, status: 'pending')
  end
  
  def new
    @play_event = PlayEvent.new
  end
  
  def create
    @play_event = PlayEvent.new(play_event_params)
    @play_event.host = current_user
    
    if @play_event.save
      flash[:success] = 'Event created successfully.'
      redirect_to @play_event
    else
      flash[:error] = 'Failed to create event.'
      render :new
    end
  end
  
  def edit
    # Check if current user is the host
    unless @play_event.host == current_user
      redirect_to play_events_path, alert: 'You can only edit events you are hosting.'
    end
  end
  
  def update
    if @play_event.update(play_event_params)
      redirect_to @play_event, notice: 'Event updated successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    # Check if current user is the host
    if @play_event.host == current_user
      @play_event.destroy
      redirect_to play_events_url, notice: 'Event deleted successfully.'
    else
      redirect_to play_events_path, alert: 'You can only delete events you are hosting.'
    end
  end
  
  # The join method will now be used only by hosts to manually add participants
  # or for direct joining if you decide to keep that functionality for some events
  def join
    # Check if user is already a participant
    if @play_event.participants.include?(current_user)
      redirect_to play_events_path, notice: 'You are already joined to this event.'
    # Check if event is full
    elsif @play_event.event_capacity.present? && @play_event.participants.count >= @play_event.event_capacity
      redirect_to play_events_path, alert: 'This event is already full.'
    else
      EventParticipant.create(play_event: @play_event, user: current_user)
      redirect_to play_events_path, notice: 'You have joined the event.'
    end
  end
  
  def leave
    # Find the participant record and destroy it
    participant = EventParticipant.find_by(play_event: @play_event, user: current_user)
    
    if participant
      participant.destroy
      redirect_to play_events_path, notice: 'You have left the event.'
    else
      redirect_to play_events_path, alert: 'You are not a participant in this event.'
    end
  end
  
  private
  
  def set_play_event
    @play_event = PlayEvent.find(params[:id])
  end
  
  def play_event_params
    params.require(:play_event).permit(:sport_id, :sport_type, :event_location, :event_category,
                                     :event_instructions, :event_start_time, :event_end_time,
                                     :event_capacity)
  end
end