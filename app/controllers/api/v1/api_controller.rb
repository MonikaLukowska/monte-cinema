module Api
  module V1
    class ApiController < ActionController::API
      def render_not_found
        render json: { error: 'Record not found', code: 404, status: 'error' }, status: :not_found
      end
    end
  end
end
