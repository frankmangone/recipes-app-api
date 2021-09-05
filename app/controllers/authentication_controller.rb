class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]
 
  def login
    command = AuthenticateUser.call(params[:email], params[:password])
 
    if command.success?
      jwt = command.result

      # Set the cookie on client by using a Set-Cookie header
      # TODO: Change to [app_name]_jwt in the future
      cookies.signed[:recipes_jwt] = {
        value: jwt,
        httponly: true,
        expires: 30.minutes.from_now
      } 
      render json: { jwt: command.result }
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