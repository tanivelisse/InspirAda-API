class UserController < ApplicationController

	# filter for app to understand json requests
	before do
	    if request.post? 
	      payload_body = request.body.read
	      @payload = JSON.parse(payload_body).symbolize_keys
	      pp @payload

	    end    

  	end

	# registration route
	post '/register' do
		user = User.find_by username: @payload[:username]

		# if user does not exist
		if !user
			user = User.new
			user.username = @payload[:username]
			user.password = @payload[:password]
			user.email = @payload[:email] 
			user.about = @payload[:about]
			user.save

			# session
			session[:logged_in] = true
			session[:username] = user.username
			session[:id] = user.id
			#find new user to return in response
			@new_user = User.find_by username: session[:username]

			#API response
			response = {
				success: true,
				code: 201,
				status: "good",
				message: "User #{user.username} successfully created",
				user: @new_user
			}

			response.to_json

		# else if user does exist
		else
			response = {
				success: false,
				code:200,
				status: "bad",
				message:"Sorry, username #{@payload[:username]} is already taken"
			}

			response.to_json
		end

	end

	# login 
	post '/login' do

		user = User.find_by username: @payload[:username]
		pass = @payload[:password]

		# password is now being checked using bcrypt
		if user && user.authenticate(pass)

			#session
			session[:logged_in] = true
			session[:username] = user.username
			session[:id] = user.id

			# response
			response = {
				success: true,
				code: 200,
				status: "good",
				message: "User #{user.username} successfully logged in.",
				username: "#{user.username}"
			}

			response.to_json

		#else id user does not exist 
		else
			#response
			response = {
				success: false,
				code: 200,
				status: "bad",
				message: "Sorry, username #{@payload[:username]} is already taken."
			} 

			response.to_json

		end

	end

	#logout
	get '/logout' do 
		username = session[:username] # grab username for message
		
		# session
		session.destroy

		# response
		response = {
			success: true,
			code: 200,
			status:"neutral",
			message: "User #{username} logged out."
		}
		response.to_json
	end

end
