Rails.application.routes.draw do
  post :pivotal_tracker, to: 'pivotal_tracker#create'
end
