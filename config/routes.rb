Rails.application.routes.draw do
  post 'games', to: 'games#new'

  get  'games/:id', to: 'games#recover'

  put  'games/:id/reveal', to: 'games#reveal'

  put  'games/:id/flag', to: 'games#flag'

  put  'games/:id/unflag', to: 'games#unflag'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
