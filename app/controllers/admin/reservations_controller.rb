module Admin
  class ReservationsController < ApplicationController
    include Filterable
    before_action :set_reservation, only: [:confirm, :reject]

    def index
      page = params[:page] || 1
      per_page = params[:per_page] || 10
      status = params[:status]

      reservations = Reservation.includes(:user, :test_schedule).order(id: :desc)

      reservations = filter_by_status(reservations, status)
      reservations = reservations.page(page).per(per_page)

      
      json_response({
        reservations: ActiveModelSerializers::SerializableResource.new(reservations, each_serializer: ReservationSerializer, context: :admin),
        meta: {
          current_page: reservations.current_page,
          total_pages: reservations.total_pages,
          total_count: reservations.total_count,
          per_page: reservations.limit_value
        }
      }, :ok, Message.reservation_index)
    end

    def confirm
      check_reservation_status
      
      ActiveRecord::Base.transaction do
        @reservation.confirmed!
        @reservation.test_schedule.increment!(:number_of_participants, @reservation.participants)
      rescue ActiveRecord::RecordInvalid
        raise ExceptionHandler::InvalidRequest, Message.reservation_not_updated
      end

      json_response(@reservation, :ok, Message.reservation_confirmed)
    end

    def reject
      check_reservation_status
      @reservation.rejected!
      json_response(@reservation, :ok, Message.reservation_rejected)
    end

    private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def check_reservation_status
      unless @reservation.pending?
        raise ExceptionHandler::InvalidRequest, Message.not_pending_reservation
      end
    end
  end
end
