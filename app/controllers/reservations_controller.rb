class ReservationsController < ApplicationController
  def index
    reservations = Reservations::UseCases::Find.new(params: params).call
    render :index, locals: { reservations: reservations }
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
    Reservations::UseCases::Update.new(reservation: reservation, status: params[:status]).call
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
