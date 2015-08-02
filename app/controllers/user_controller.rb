class UserController < ApplicationController
  def login
    if request.post?
      puts YAML::dump(params)
    end

    respond_to do |format|
      format.html
    end
  end
end
