class UsersController < ApplicationController
    
  # GET request made to /users/:id  
  def show
    @user = User.find( params[:id] )
  end
    
end