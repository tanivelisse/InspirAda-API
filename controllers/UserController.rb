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

end
