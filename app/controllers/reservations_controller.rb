class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    reservations = policy_scope(Reservation.includes(:user, :tickets, seance: :movie).order('seances.start_time desc'))

    render :index, locals: { reservations: reservations }
  end

  def new
    authorize Reservation
    render :new, locals: { reservation: Reservation.new, seance: seance }
  end

  def create
    authorize Reservation
    new_reservation = Reservations::UseCases::Create.new(
      user: current_user,
      seance: params[:seance],
      seats: params[:seats]
    )

    if new_reservation.call
      redirect_to seances_path, notice: t('.notice')
    else
      redirect_back fallback_location: new_seance_reservation_path(seance),
                    alert: new_reservation.errors
    end
  end

  def show
    authorize reservation
    render :show, locals: { reservation: reservation }
  end

  def confirm
    authorize reservation
    Reservations::UseCases::Update.new(reservation: reservation, status: Reservation::CONFIRMED).call
    redirect_to reservations_path, notice: t('.notice')
  end

  def cancel
    authorize reservation
    Reservations::UseCases::Update.new(reservation: reservation, status: Reservation::CANCELLED).call
    notice = reservation.errors.any? ? reservation.errors[:status] : t('.notice')

    redirect_to reservations_path, notice: notice
  end

  private

  def seance
    @seance ||= Seance.find(params[:seance_id])
  end

  def reservation
    @reservation ||= Reservation.find(params[:id])
  end
end
