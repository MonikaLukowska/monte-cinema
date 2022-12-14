class AvailabilityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    seances = Seance.includes(:movie).where(hall: record.hall).where.not(id: record.id)

    return unless !seances.empty? && record && value

    record_range = value..(value + record.movie_length.minutes + ADS.minutes)
    date_ranges = seances.map do |seance|
      seance.start_time..(seance.start_time + seance.movie_length.minutes + ADS.minutes)
    end

    date_ranges.each do |range|
      record.errors.add(attribute, 'not available') if range.overlaps? record_range
    end
  end
end
