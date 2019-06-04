require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/UserController'

# models
require './models/UserModel'
require './models/PostModel'
require './models/CommentModel'

# routing

map ('/') {
  run ApplicationController
}

map ('/api/v1/users') do
	run UserController
end


