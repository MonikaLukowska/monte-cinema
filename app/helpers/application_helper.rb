module ApplicationHelper
  def format_time(date)
    date.strftime('%H:%M')
  end

  def format_date(date)
    date.strftime('%d/%m')
  end
end
