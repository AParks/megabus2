class SessionsController < ApplicationController
  def new
  end

     # def create
     # auth_hash = request.env['omniauth.auth']
	 # #name = auth_hash["info"]["name"]
	 # #email = auth_hash["info"]["email"]
     # @user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
     # @user.save
	 # session[:user_id] = user.id
	# # redirect_to root_url, :notice => "Signed in!"
     # render :text => "Hi #{@user.name}! You've signed up."
    # end
 
 def create
  auth_hash = request.env['omniauth.auth']
  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  if @authorization
  	#redirect_to root_url, :notice => "Signed in!"
    render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
  else
    @user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
    @user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    @user.save
    render :text => "Hi #{@user.name}! You've signed up."
	#redirect_to root_url, :notice => "Signed in!"
  end
end
 
 # def create
  # auth_hash = request.env['omniauth.auth']
  # if session[:user_id]
    # # Means our user is signed in. Add the authorization to the user
    # User.find(session[:user_id]).add_provider(auth_hash)
    # render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
  # else
    # # Log him in or sign him up
    # auth = Authorization.find_or_create(auth_hash)
    # # Create the session
    # session[:user_id] = auth.user.id
    # render :text => "Welcome #{auth.user.name}!"
  # end
# end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Signed out!"
end

# def create
  # auth_hash = request.env['omniauth.auth']
  # @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  # if @authorization
    # render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
  # else
    # user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
    # user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    # user.save
    # render :text => "Hi #{user.name}! You've signed up."
  # end
# end

def destroy
  session[:user_id] = nil
  render :text => "You've logged out!"
end

  def failure
  render :text => "Sorry, but you didn't allow access to our app!"
end
end
