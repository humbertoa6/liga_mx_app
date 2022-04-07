Rails.application.routes.draw do
  root 'stadistics#welcome'

  namespace :stadistics do
    get 'livescores'
    get 'fixtures'
    get 'standings'
  end
end
