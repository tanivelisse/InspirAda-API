class PostController < ApplicationController

	#create post
	post '/new_post' do
		# add data to db
		new_post = Post.new
		new_post.photo_url = @payload[:photo_url]
		new_post.f_name = @payload[:f_name]
		new_post.l_name = @payload[:l_name]
		new_post.category = @payload[:category]
		new_post.title = @payload[:title]
		new_post.body = @payload[:body]

		# find user for user_id
		logged_in_user = User.find_by({:username => session[:username]})
		new_post.user_id = logged_in_user.id

		#save new_post
		new_post.save

		#response 
		response = {
			success: true,
			code: 201,
			status: "good",
			message:"Successfully created post ##{new_post.id}"
			post: new_post
		}

		response.to_json
	end

	#index for all items
	get '/' do 
		@posts = Post.all

		response = {
			success: true,
			code: 200,
			status:"good",
			message:"Found #{@posts.length} posts",
			posts: @posts
		}

		response.to_json

	end

end