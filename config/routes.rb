Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/withdraw' => 'withdraws#withdraw_amount'
    end
  end
end
