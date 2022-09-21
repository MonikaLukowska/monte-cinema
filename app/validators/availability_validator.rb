class AvailabilityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    seances = Seance.includes(:movie).where(hall: record.hall).where.not(id: record.id)
    date_ranges = seances.map do |seance|
      seance.start_time..(seance.start_time + seance.movie_length.minutes + ADS.minutes)
    end
    date_ranges.each do |range|
      record.errors.add(attribute, 'not available') if range.cover? value
    end
  end
end
