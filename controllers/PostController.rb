class PostController < ApplicationController
	# filter for app to understand json requests
	before do
    if request.post? || request.put?
      payload_body = request.body.read
      @payload = JSON.parse(payload_body).symbolize_keys
      pp @payload 
    end

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
		logged_in_user = User.find_by {:username => session[:username]}
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

	# update
	put 'edit/:id' do
		# confirm user so he/she/they can edit 
		user = User.find_by {:username => session[:username]}
		#find post to edit 
		post = Post.find params[:id]

		#if post belongs to user
		if user.id == post.user_id
			#then edit post
			post.photo_url = @payload[:photo_url]
			post.f_name = @payload[:f_name]
			post.l_name = @payload[:l_name]
			post.category = @payload[:category]
			post.title = @payload[:title]
			post.body = @payload[:body]

			# save changes
			post.save

			response = {
				success: true,
				code: 200,
				status:"good",
				message:"Post #{post.title} updated",
				post: post

			}

			response.to_json
		else
			#if post does not belong to user 
			response = {
				success: false,
				code: 201,
				status:"bad",
				message:"Post #{post.id} does not belong to user"
			}

			response.to_json

		end

	end

	#delete
	delete '/:id' do
		# find post by id
		post = Post.find :id params[:id]
		#delete found post
		post.destroy
		#response
		response = {
      		success: true,
      		status: "good",
      		message: "Successfully deleted post ##{post.id}"
    	}

    	response.to_json
    end



end