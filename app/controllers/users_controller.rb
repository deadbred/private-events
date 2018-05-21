class UsersController < ApplicationController
  before_action :logged_in_user, only: [:pending_invitation, :dashboard]
  
  def new
    @user = User.new 
  end

  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email].downcase)

    if @user.save
      log_in(@user)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
  end

  def dashboard
  end

  def home
    unless current_user.nil?
      redirect_to dashboard_path
    else
      render :home
    end
  end

  def pending_invitations
    @invitations = current_user.invitations_received.all
  end

  def accept_invitation
    @invitation = Invitation.find(params[:id])
    current_user.events_as_attendee << @invitation.event
    current_user.save
    redirect_to pending_path
  end

end
