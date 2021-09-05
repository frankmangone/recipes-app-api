class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(jwt = nil)
    @jwt = jwt
  end

  def call
    user
  end

  private

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(@jwt)
  end
end