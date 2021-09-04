class AuthorizeApiRequest
  prepend SimpleCommand

  # def initialize(headers = {})
  #   @headers = headers
  # end

  def initialize(jwt = nil)
    @jwt = jwt
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(@jwt)
  end
end