module ApplicationHelper
  def time(date)
    date.strftime('%H:%M')
  end

  def date(date)
    date.strftime('%H:%M - %e %B')
  end
end
