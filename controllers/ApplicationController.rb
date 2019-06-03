class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()

	# add sessions here
	enable :sessions

	# set up our DB connection
	ActiveRecord::Base.establish_connection(
		:addapter => 'postgresql',
		:database => 'inspirada_in_tech'
	)
	
	# middleware
	use Rack::MethodOverride 
	set :method_override, true


	#pry test
	get '/test' do 
		"This is test"
		binding.pry
		"pry has finished"
	end

end