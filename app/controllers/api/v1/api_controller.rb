module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def render_ok(data, options)
        render json: { data: ActiveModelSerializers::SerializableResource.new(data, options) }, status: :ok
      end

      private

      def render_not_found
        render json: { error: 'Record not found', code: 404, status: 'error' }, status: :not_found
      end
    end
  end
end
