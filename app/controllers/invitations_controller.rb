class InvitationsController < ApplicationController
  before_action :logged_in_user, only: [:new,:create]
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = current_user.invitations.new(
                  event: Event.find(params[:invitation][:event]), 
                  invited_user: User.find_by(name: params[:invitation][:invited_user].downcase))

    if @invitation.save
      redirect_to @invitation
    else
      render :new
    end
  end

  def show
    @invitation = Invitation.find(params[:id])
  end
  
end