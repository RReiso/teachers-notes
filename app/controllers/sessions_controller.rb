class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user) #helper method in app-helpers-sessions_helper.rb (see applicaton_controller as well)
      flash[:success] = "Hello, #{user.name}!"
      redirect_to root_path
      # could be redirect_to user_path(user) or redirect_to user
    else
      #use flash.now, which is specifically designed for displaying flash messages on rendered pages. Unlike the contents of flash, the contents of flash.now disappear as soon as there is an additional request (render). Simple flash can be used with redirect to.The issue is that the contents of the flash persist for one request, but—unlike a redirect, —re-rendering a template with render doesn’t count as a request. The result is that the flash message persists one request longer than we want. For example, if we submit invalid login information and then click on the Home page, the flash gets displayed a second time. (But why simply not to use flash and redirect to login_path??) Render tells Rails which view or asset to show a user, without losing access to any variables defined in the controller action. Redirect is different. The redirect_to method tells your browser to send a request to another URL. Does it matter here??
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
    # render plain:params
  end

  def destroy
    log_out #(in sessions_helper.rb)
    redirect_to root_path
  end
end
