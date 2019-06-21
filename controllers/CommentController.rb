#--------------------------------------------------------------#
#        THIS CONTROLLER HAS ROUTES FOR POSTS  
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
#                 POST'S COMMENTS ROUTES
#------------------------------------------------------------#
   
    # COMMENTS CREATE ROUTE
 		# add conditional statement to 
 		#...return message if user is not
 		# ...logged in. 

    post '/new_comment/:post_id' do 
    	new_comment = Comment.new
    	new_comment.body = @payload[:body]

    	# find post for post_id
    	post_where_comment_is_added = Post.find params[:post_id]
    	new_comment.post_id = post_where_comment_is_added.id
    	
    	# find user for user_id
		logged_in_user = User.find_by ({:username => session[:username]})
		new_comment.user_id = logged_in_user.id
		new_comment.user_username = logged_in_user.username

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

    get '/:post_id' do
    	post = Post.find params[:post_id]
    	post_comments = post.comments
  
    	# response
    	response = {
			success: true,
			code: 200,
			status:"good",
			message:"Found #{post_comments.length} posts",
			comments: post_comments,
		}

		response.to_json
    end
   
    # DELETE COMMENT

    delete '/:comment_id' do 
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