Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'tracker#index'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  get '/tracker' => 'tracker#index'
  get '/flights' => 'flights#index'
  get '/hotels' => 'hotels#index'
  get '/cars' => 'cars#index'

  get 'tracker/index'
  get 'flights/index'
  get 'hotels/index'
  get 'cars/index'
  

  post "/flights/get_mileage/:id" => "flights#get_mileage"  
  # without the => "tracker#get_mileage"  -> it will break -> cuz there is no exact route as "/tracker/get_mileage/:id" -> there is only "/tracker/get_mileage" 
  post '/hotels/get_hr/:id' => "hotels#get_hr"
  post '/cars/get_cr/:id' => "cars#get_cr"
  
  get '/flights/destroy/:id' => "flights#destroy"
  get '/hotels/destroy/:id' => "hotels#destroy"
  get '/cars/destroy/:id' => "cars#destroy"
  
  get '/flights/adding_ff_now'
  post '/flights/adding_ff_now'
  get 'hotels/add_hr'
  post '/hotels/add_hr'
  post '/cars/add_cr'
  end
