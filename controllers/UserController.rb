class UserController < ApplicationController

#--------------------------------------------------------------#
# THIS CONTROLLER HAS ROUTES FOR USER AUTH AND USER PROFILE 
#--------------------------------------------------------------#

	# FILTER FOR JSON REQUESTS
	before do
	    if request.post? 
	      payload_body = request.body.read
	      @payload = JSON.parse(payload_body).symbolize_keys
	      pp @payload

	    end    

  	end

#------------------------------------------------------------#
#                 USER'S ROUTES
#------------------------------------------------------------#

	# REGISTRATION ROUTE

	post '/register' do
		user = User.find_by username: @payload[:username]
		user_email = User.find_by email: @payload[:email]
		# if user and email does not exist
		if !user && !user_email
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
		elsif user
			response = {
				success: false,
				code:200,
				message:"Sorry, username #{@payload[:username]} is already taken"
			}

			response.to_json

		elsif user_email
			response = {
				success: false,
				code:200,
				message:"Sorry, email #{@payload[:email]} already has an account"
			}

			response.to_json
		end

	end

	# LOGIN ROUTE

	post '/login' do

		user = User.find_by username: @payload[:username]
		pass = @payload[:password]

		# password is now being checked using bcrypt
		if user && user.authenticate(pass)

			#session
			session[:logged_in] = true
			session[:username] = user.username
			session[:id] = user.id

			@logged_in_user = User.find_by username: session[:username]
			@logged_in_user_posts = @logged_in_user.posts
			# response
			response = {
				success: true,
				code: 200,
				status: "good",
				message: "User #{user.username} successfully logged in.",
				user: @logged_in_user,
				user_posts: @logged_in_user_posts

			}

			response.to_json

		#else id user does not exist 
		else
			#response
			response = {
				success: false,
				code: 200,
				status: "bad",
				message: "Sorry, wrong username or password."
			} 

			response.to_json

		end

	end

	# LOGOUT

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

	# USER PROFILE ROUTE
	# TO BE DONE

end
