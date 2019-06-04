class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# add sessions here // may need to change it 
	enable :sessions

	# set up our DB connection // will need to come back to this
	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'inspirada_in_tech'
	)
	
	# middleware 
	use Rack::MethodOverride 
	set :method_override, true

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