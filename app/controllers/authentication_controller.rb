class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]
 
  def login
    command = AuthenticateUser.call(params[:email], params[:password])
 
    if command.success?
      # Set the refresh token to an http-only cookie
      # on client via a Set-Cookie header
      # TODO: Change to [app_name]_jwt in the future
      cookies.signed[:recipes_refresh_token] = {
        value: command.result[:refresh_token],
        httponly: true,
      } 
      render json: { jwt: command.result[:jwt], name: command.result[:name] }, status: :ok
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def verify_authenticated
    render status: :ok
  end

  def refresh_token
  end
 end