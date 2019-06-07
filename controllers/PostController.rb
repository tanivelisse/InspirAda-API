class PostController < ApplicationController
#--------------------------------------------------------------#
# THIS CONTROLLER HAS ROUTES FOR BOTH POSTS AND POST'S COMMENTS #
#--------------------------------------------------------------#

	# FILTER FOR JSON REQUESTS

	before do
	    if request.post? || request.put?
	      payload_body = request.body.read
	      @payload = JSON.parse(payload_body).symbolize_keys
	      pp @payload 
	    end
	end

#------------------------------------------------------------#
#                 POSTS' ROUTES
#------------------------------------------------------------#

	#CREATE POST

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
		logged_in_user = User.find_by ({:username => session[:username]})
		new_post.user_id = logged_in_user.id

		#save new_post
		new_post.save

		#response 
		response = {
			success: true,
			code: 201,
			status: "good",
			message:"Successfully created post ##{new_post.id}",
			post: new_post
		}

		response.to_json
	end

	#POSTS' INDEX 

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

	# UPDATE POST

	put '/edit/:id' do
		# confirm user so he/she/they can edit 
		user = User.find_by ({:username => session[:username]})
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
				message:"Post does not belong to user"
			}

			response.to_json

		end

	end

	#DELETE POST

	delete '/:id' do
		# find post by id
		post = Post.find params[:id]
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



#------------------------------------------------------------#
#                 POST'S COMMENTS ROUTES
#------------------------------------------------------------#
   
    # COMMENTS CREATE ROUTE
 		# add conditional statement to 
 		#...return message if user is not
 		# ...logged in. 

    post '/comments/new_comment/:post_id' do 
    	new_comment = Comment.new
    	new_comment.body = @payload[:body]

    	# find post for post_id
    	post_where_comment_is_added = Post.find params[:post_id]
    	new_comment.post_id = post_where_comment_is_added.id
    	
    	# find user for user_id
		logged_in_user = User.find_by ({:username => session[:username]})
		new_comment.user_id = logged_in_user.id

		# save
		new_comment.save

		#response 
		response = {
			success: true,
			code: 201,
			status: "good",
			message:"Successfully created comment ##{new_comment.id}",
			comment: new_comment
		}

		response.to_json


    end

    # COMMENTS' INDEX ROUTE

    get '/comments/:post_id' do
    	post = Post.find params[:post_id]
    	post_comments = post.comments

    	# response
    	response = {
			success: true,
			code: 200,
			status:"good",
			message:"Found #{post_comments.length} posts",
			comments: post_comments
		}

		response.to_json
    end
   
    # DELETE COMMENT

    delete '/comments/:comment_id' do 
    	comment = Comment.find params[:comment_id]
    	comment.destroy

    	#response
		response = {
      		success: true,
      		status: "good",
      		message: "Successfully deleted comment ##{comment.id}"
    	}

    	response.to_json
    end


end