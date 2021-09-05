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
    if @decoded_auth_token.nil?
      errors.add(:token, 'Invalid or missing token')
      return nil
    end

    @user ||= User.find(decoded_auth_token[:user_id])

    if @user.nil?
      errors.add(:credentials, 'Invalid email or password')
      return nil
    end
    
    @user
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(@jwt)
  end
end