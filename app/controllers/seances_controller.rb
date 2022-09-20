class SeancesController < ApplicationController
  def index
    seances = Seance.includes(:movie).filtered_by_day(date).group_by(&:movie_title)
    # seances = Seance.includes(:movie).group_by(&:movie_title)

    render :index, locals: { seances: }
  end

  def show
    render :show, locals: { seance: }
  end

  def new
    render :new, locals: { seance: Seance.new }
  end

  def edit
    render :edit, locals: { seance: }
  end

  def create
    record = Seance.new(seance_params)
    if record.save
      redirect_to record, notice: t('.notice')
    else
      render :new, locals: { seance: record }
    end
  end

  def update
    if seance.update(seance_params)
      redirect_to seance, notice: t('.notice')
    else
      render :edit, locals: { seance: }
    end
  end

  def destroy
    seance.destroy
    redirect_to seances_path, notice: t('.notice')
  end

  private

  def seance
    @seance ||= Seance.find(params[:id])
  end

  def seance_params
    params.require(:seance).permit(:hall_id, :movie_id, :start_time, :movie_length, :price)
  end

  def date
    @date = params[:date].presence || Time.zone.today
  end
end
