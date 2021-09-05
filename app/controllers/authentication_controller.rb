class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :refresh_token]
 
  JWT_EXPIRATION = 15*60*1000 # milliseconds

  def login
    command = AuthenticateUser.call(params[:email], params[:password])
 
    if command.success?
      # Set the refresh token to an http-only cookie
      # on client via a Set-Cookie header
      # TODO: Change to [app_name]_jwt in the future
      cookies[:recipes_refresh_token] = {
        value: command.result[:refresh_token],
        httponly: true,
      } 
      render json: { 
        jwt: command.result[:jwt],
        expiry: JWT_EXPIRATION,
        name: command.result[:name]
      }, status: :ok
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def refresh_token
    old_token = cookies[:recipes_refresh_token]
    user ||= User.find_by_refresh_token(old_token)
    if user.nil?
      render status: :unauthorized
    else
      user.regenerate_refresh_token
      cookies[:recipes_refresh_token] = {
        value: user.refresh_token,
        httponly: true,
      }
      jwt = JsonWebToken.encode(user_id: user.id)
      render json: { 
        jwt: jwt,
        expiry: JWT_EXPIRATION,
        name: user.name
      }, status: :ok
    end
  end
 end