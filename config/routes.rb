Rails.application.routes.draw do
  scope 'api' do
    scope 'v1' do

      post 'games', to: 'games#new'

      get  'games/:id', to: 'games#recover'

      put  'games/:id/reveal', to: 'games#reveal'

      put  'games/:id/flag', to: 'games#flag'

      put  'games/:id/unflag', to: 'games#unflag'
    end
  end
end
