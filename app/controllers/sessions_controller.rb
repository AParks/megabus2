class SessionsController < ApplicationController


  def new
  end

  def index
  @authorizations = current_user.authorizations if current_user
end
 
 def create
	Trip.all.each { |x| x.destroy}

  auth_hash = request.env['omniauth.auth']
  @authorizations = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  if @authorizations
  	flash[:notice] = "Already signed in."

  	redirect_to root_url, :notice => "Already Signed in!"

    #render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
  else if current_user
   current_user.authorizations.create(:provider => auth_hash['provider'], :uid => auth_hash['uid'])       
    #render :text => "Hi #{@user.name}! You've signed up."
	flash[:notice] = "Authentication successful."

	redirect_to root_url, :notice => "Signed in!"
	else
	user = User.new
    user.authorizations.build(:provider => auth_hash ['provider'], :uid => auth_hash['uid'])
    user.save!
    flash[:notice] = "Signed in successfully."
	session[:user_id] = user.id
	redirect_to root_url, :notice => "Signed in!"

#    sign_in_and_redirect(:user, user)
	end
  end
end
 


def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Signed out!"
end



  def failure
  render :text => "Sorry, but you didn't allow access to our app!"
end
end
