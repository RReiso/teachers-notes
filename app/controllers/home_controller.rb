class HomeController < ApplicationController
  def index
  end

  def search
    
if params[:search].blank?  
    redirect_to(root_path, alert: "Empty search field!") and return  
  else  

  end  

  end
 
end
