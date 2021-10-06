Rails.application.routes.draw do
	get '/', to: 'application#index'
	get '/create_client', to: 'client#index'
	get '/create_account', to: 'account#index'
	get '/operation', to: 'operation#index'
	get '/info', to: 'info#index'

	post '/refill', to: 'operation#refill'
	post '/remittance', to: 'operation#remittance'
	post '/create_account', to: 'account#create'
	post '/create_client', to: 'client#create'

	scope :info do
		post '/refill', to: 'info#refill'
		post '/sum', to: 'info#sum'
		post '/max_min', to: 'info#max_min'
	end

	get '/test', to: 'test#index'
end
