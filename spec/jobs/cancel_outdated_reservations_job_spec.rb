# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CancelOutdatedReservationsJob, type: :job do
  describe '#perform_later' do
    it 'enqueues job' do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later }.to have_enqueued_job
    end
  end

  describe '#perform_now' do
    let(:reservation) { create(:reservation) }

    before { reservation }

    it 'cancels outdated reservation' do
      expect { described_class.perform_now }.to change { reservation.reload.status }.from('created').to('cancelled')
    end
  end
end