class Tfa < ActiveRecord::Base
  include BCrypt
  
  belongs_to :user
  attr_accessor :tfa_code
  
  before_create :delete_old_code

  def tfa_password
    @tfa_password ||= Password.new(tfa_password_hash)
  end

  def tfa_password=(new_tfa_password)
    @tfa_password = Password.create(new_tfa_password)
    self.tfa_password_hash = @tfa_password
  end
  
  private
    def delete_old_code
      Tfa.where(user_id: self.user_id).destroy_all
    end
end
