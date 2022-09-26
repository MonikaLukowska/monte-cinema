class ReservationsController < ApplicationController
  def index
    render :index, locals: { reservations: Reservations::UseCases::FindReservations.new(params: params).call }
  end

  def new
    render :new, locals: { reservation: Reservation.new, seance: seance }
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

  def show
    render :show, locals: { reservation: reservation }
  end

  def update
    Reservations::UseCases::UpdateReservation.new(reservation, params[:status]).call
    redirect_to seance_reservations_path(seance)
  end

  private

  def seance
    @seance = Seance.find(params[:seance_id])
  end

  def reservation
    @reservation ||= Reservation.find(params[:id])
  end
end
