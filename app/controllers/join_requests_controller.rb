class JoinRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_play_event, only: [:create]
    before_action :set_join_request, only: [:accept, :reject]
    before_action :ensure_host, only: [:accept, :reject]
    
    def create
      # Check if user is already a participant
      if @play_event.participants.include?(current_user)
        redirect_to play_event_path(@play_event), alert: "You are already a participant in this event."
        return
      end
      
      # Check if user already has a pending request
      if JoinRequest.exists?(user: current_user, play_event: @play_event, status: 'pending')
        redirect_to play_event_path(@play_event), alert: "You already have a pending request for this event."
        return
      end
      
      @join_request = JoinRequest.new(
        user: current_user,
        play_event: @play_event,
        status: 'pending',
        message: params[:message]
      )
      
      if @join_request.save
        redirect_to play_event_path(@play_event), notice: "Request sent! Waiting for host approval."
      else
        redirect_to play_event_path(@play_event), alert: "Error creating request: #{@join_request.errors.full_messages.join(', ')}"
      end
    end
    
    def accept
      @join_request.update(status: 'accepted')
      
      # Add user as participant
      @join_request.play_event.participants << @join_request.user unless 
        @join_request.play_event.participants.include?(@join_request.user)
      
      redirect_to play_events_path, notice: "Request accepted!"
    end
    
    def reject
      @join_request.update(status: 'rejected')
      redirect_to play_events_path, notice: "Request rejected."
    end

    def cancel
      @join_request = current_user.join_requests.find_by(play_event_id: @play_event.id, status: 'pending')
      
      if @join_request&.destroy
        redirect_to play_event_path(@play_event), notice: "Join request canceled successfully"
      else
        redirect_to play_event_path(@play_event), alert: "Could not find your pending join request"
      end
    end
    
    private
    
    def set_play_event
      @play_event = PlayEvent.find(params[:play_event_id])
    end
    
    def set_join_request
      @join_request = JoinRequest.find(params[:id])
    end
    
    def ensure_host
      unless current_user == @join_request.play_event.host
        redirect_to play_events_path, alert: "Only the host can approve or reject requests."
      end
    end
  end