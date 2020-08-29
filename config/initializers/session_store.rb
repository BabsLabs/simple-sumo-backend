if Rails.env === 'production' 
  Rails.application.config.session_store(:cookie_store, key: '_simple-sumo-backend', domain: 'https://babslabs-simple-sumo-backend.herokuapp.com')
else
  Rails.application.config.session_store :cookie_store, key: '_simple-sumo-backend'
end