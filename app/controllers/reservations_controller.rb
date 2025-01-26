class ReservationsController < ApplicationController
  include Filterable
  before_action :set_reservation, only: [:update, :destroy]
  
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    status = params[:status]

    reservations = current_user.reservations.includes(:test_schedule).order(id: :desc)
    reservations = filter_by_status(reservations,status)
    reservations = reservations.page(page).per(per_page)

    json_response({
      reservations: ActiveModelSerializers::SerializableResource.new(reservations, each_serializer: ReservationSerializer),
      meta: {
        current_page: reservations.current_page,
        total_pages: reservations.total_pages,
        total_count: reservations.total_count,
        per_page: reservations.limit_value
      }
    }, :ok, Message.reservation_index)
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
    reservation = UpdateReservation.new(@reservation, update_params).call
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
    params.require(:reservation).permit(:participants,:test_schedule_id)
  end
end