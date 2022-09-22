class ReservationsController < ApplicationController
  def new
    render :new, locals: { reservation: Reservation.new, seance: Seance.find(params[:seance_id]) }
  end

  def create
    ticket_reservation = CreateReservation.new(params:)
    if ticket_reservation.call
      redirect_to seances_path, notice: t('.notice')
    else
      redirect_back fallback_location: new_seance_reservation_path(seance),
                    alert: ticket_reservation.errors.join
    end
  end

  private

  def seance
    @seance = Seance.find(params[:seance_id])
  end
end