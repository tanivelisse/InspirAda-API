require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/PostController'
require './controllers/CommentController'

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

map ('/api/v1/posts') do
	run PostController
end

map ('/api/v1/comments') {
  run CommentController
}


