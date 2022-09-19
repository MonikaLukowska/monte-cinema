module SeanceHelper
  def create_date_links
    content_tag(:ul, class: 'd-flex mb-3 justify-content-center') do
      7.times do |num|
        concat(link_to((Time.zone.today + num.days).strftime('%d/%m'),
                       seances_path(date: Time.zone.today + num.days), class: 'mx-2'))
      end
    end
  end
end
