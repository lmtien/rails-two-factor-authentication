class Tfa < ActiveRecord::Base
  include BCrypt
  
  belongs_to :user

  def tfa_password
    @tfa_password ||= Password.new(tfa_password_hash)
  end

  def tfa_password=(new_tfa_password)
    @tfa_password = Password.create(new_tfa_password)
    self.tfa_password_hash = @tfa_password
  end
end
