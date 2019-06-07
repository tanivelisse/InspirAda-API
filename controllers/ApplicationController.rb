class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# add sessions here // may need to change it 
	# enable :sessions

	use Rack::Session::Cookie,  :key => 'rack.session',
                              	:path => '/',
                              	:secret => "as;dlfkja;sdlfkja;sldkfja;lskdjfa;lsdkjf"

	# CORS
  	register Sinatra::CrossOrigin

  	configure do
    	enable :cross_origin
  	end

  	set :allow_origin, :any
  	set :allow_methods, [:get, :post, :put, :options, :patch, :delete, :head]
  	set :allow_credentials, true

	# # set up our DB connection // will need to come back to this
	# ActiveRecord::Base.establish_connection(
	# 	:adapter => 'postgresql',
	# 	:database => 'inspirada_in_tech'
	# )
	
	# config
	require './config/environements'
	
	# middleware 
	use Rack::MethodOverride 
	set :method_override, true

	#options requests for CORS
	options '*' do
    	response.headers["Allow"] = "HEAD,GET,PUT,PATCH,POST,DELETE,OPTIONS"
    	response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    	200
  	end

  	# ApplicationController
	get '/' do 
		"ApplicationController running"
	end

	#pry test
	get '/test' do 
		"This is test"
		binding.pry
		"pry has finished"
	end

	# 404 route
	get '*' do
    	"404 You are lost"
  end

end