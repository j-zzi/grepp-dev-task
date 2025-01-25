module Admin
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:update, :destroy]
  end
end
  