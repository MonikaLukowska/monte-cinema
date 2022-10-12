require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  path '/api/v1/movies' do
    get('fetch movies screening today') do
      consumes 'application/json'
      produces 'application/json'
      tags 'movies'
      description 'lists all movies with screenings on current date'

      let!(:seances) { create_list(:seance, 2) }

      response(200, 'successful') do
        schema type: :object,
               required: %w[data],
               properities: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properities: {
                       id: {
                         type: :integer,
                         example: 1
                       },
                       title: {
                         type: :string,
                         example: 'It'
                       },
                       length: {
                         type: :integer,
                         example: 90
                       },
                       seances: {
                         type: :array,
                         items: {
                           type: :object,
                           properities: {
                             id: {
                               type: :integer,
                               example: 2
                             },
                             start_time: {
                               type: :string,
                               example: '2022-10-12T12:24:08.583+02:00'
                             }
                           }
                         }
                       }
                     }
                   }
                 }
               }

        run_test!

        it 'returns movies screening today' do
          body = JSON(response.body)
          expect(body['data'].count).to eq(seances.count)
        end
      end
    end
  end

  path '/api/v1/movies?date={date}' do
    get('fetch movies by date') do
      consumes 'application/json'
      produces 'application/json'
      tags 'movies'
      description 'lists all movies with screenings on given date'
      parameter name: :date, in: :path, type: :string

      let!(:seances) { create_list(:seance, 2, start_time: Date.tomorrow) }
      let(:date) { DateTime.tomorrow.strftime('%Y-%m-%d') }

      response(200, 'successful') do
        schema type: :object,
               required: %w[data],
               properities: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properities: {
                       id: {
                         type: :integer,
                         example: 1
                       },
                       title: {
                         type: :string,
                         example: 'It'
                       },
                       length: {
                         type: :integer,
                         example: 90
                       },
                       seances: {
                         type: :array,
                         items: {
                           type: :object,
                           properities: {
                             id: {
                               type: :integer,
                               example: 2
                             },
                             start_time: {
                               type: :string,
                               example: '2022-10-12T12:24:08.583+02:00'
                             }
                           }
                         }
                       }
                     }
                   }
                 }
               }

        run_test!
      end
    end
  end
end
