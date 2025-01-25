class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:update, :destroy]
  
  def index
    reservations = current_user.reservations.includes(:test_schedule)
    json_response(reservations, :ok, Message.reservation_index)
  end

  def create
    reservation = CreateReservation.new(
      current_user,
      create_params[:test_schedule_id],
      create_params[:participants]
    ).call
    json_response(reservation, :created, Message.reservation_created)
  end

  def update
    reservation = UpdateReservation.new(@reservation, update_params[:participants]).call
    json_response(@reservation, :ok, Message.reservation_updated)
  end

  def destroy
    CancelReservation.new(@reservation).call
    head :no_content
  end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    raise(ExceptionHandler::NotFound, Message.not_found('Reservation'))
  end

  def create_params
    params.require(:reservation).permit(:test_schedule_id, :participants)
  end

  def update_params
    params.require(:reservation).permit(:participants)
  end
end