class ReservationsController < ApplicationController
  def new
    render :new, locals: { reservation: Reservation.new, seance: Seance.find(params[:seance_id]) }
  end

  def create
    reservation = CreateReservation.new(params[:email], params[:seance_id], params[:seats])
    if reservation.call
      redirect_to seances_path, notice: t('.notice')
    else
      redirect_back fallback_location: new_seance_reservation_path(seance),
                    alert: reservation.errors.join
    end
  end

  private

  def seance
    @seance = Seance.find(params[:seance_id])
  end
end
