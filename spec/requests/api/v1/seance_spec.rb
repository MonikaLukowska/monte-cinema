require 'swagger_helper'

RSpec.describe 'api/v1/seances', type: :request do
  path '/api/v1/seances/{id}' do
    get('Fetch seance') do
      consumes 'application/json'
      produces 'application/json'
      tags 'seances'
      description 'find seance'
      parameter name: :id, in: :path, type: :string

      let(:id) { create(:seance).id }

      response(200, 'successful') do
        schema type: :object,
               required: %w[data],
               properities: {
                 data: {
                   type: :object,
                   properities: {
                     id: {
                       type: :integer,
                       example: 1
                     },
                     start_time: {
                       type: :string,
                       example: '2022-10-12T12:24:08.583+02:00'
                     },
                     price: {
                       type: :integer,
                       example: 15
                     },
                     length: {
                       type: :integer,
                       example: 60
                     },
                     movie_title: {
                       type: :string,
                       example: 'It'
                     }
                   }
                 }
               }

        run_test!

        it 'returns a seance' do
          body = JSON(response.body)
          expect(body['data']['id']).to eq(id)
        end
      end

      response(404, 'Product not found') do
        schema type: :object,
               properties: {
                 error: {
                   type: :string,
                   example: 'Record not found'
                 },
                 code: {
                   type: :integer,
                   example: 404
                 },
                 status: {
                   type: :string,
                   example: 'error'
                 }
               },
               required: %w[error code status]

        let(:id) { 'wrong_id' }

        run_test!

        it 'returns error' do
          expect(JSON.parse!(response.body)['error']).to eq('Record not found')
        end
      end
    end
  end
end
