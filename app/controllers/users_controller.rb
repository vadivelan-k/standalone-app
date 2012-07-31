class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @firms = current_user.firms.to_a
  end

end
