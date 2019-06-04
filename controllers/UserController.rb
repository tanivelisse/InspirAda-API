class UserController < ApplicatonController

	# registration route
	post '/register' do
		user = User.find username: @payload[:username]

		# if user does not exist
		if !username
			user = User.new
			user.username = @payload[:username]
			user.password = @payload[:password]
			user.save

			# session
			session[:logged_in] = true
			session[:username] = user.username
			session[:id] = user.id

			#API response
			response = {
				success: true,
				code: 201,
				status: "good",
				message: "User #{user.username} successfully created",
				username: "#{user.username}"
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

	# login 
	post '/login' do

		user = User.find username: @payload[:username]
		pass = @payload[:password]

		# password is now being checked using bcrypt
		if user && user. authenticate(pass)

			#session
			session[:logged_in] = true
			session[:username] = user.username
			session[:id] = user.id

			# response
			response = {
				success: true,
				code: 200,
				status: "good",
				message: "User #{user.username} successfully logged in."
				username: "#{user.username}"
			}

			response.to_json


	end

end
