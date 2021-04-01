class SessionsController < ApplicationController
  def new; end

  def create; end

  def destroy
    redirect to: root_path
  end
end
