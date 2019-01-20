class Api::V1::AuthController < ApplicationController
skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username])
    #User#authenticate comes from BCrypt
    if @user && @user.authenticate(user_login_params[:password_digest])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def show
    if current_user
      render json: {user: current_user}
    else
      render json: {error: "Please log in"}, status: 422
    end
  end

  private

  def user_login_params
    params.permit(:username, :password_digest)
  end
end
