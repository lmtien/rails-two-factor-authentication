class UsersController < ApplicationController
  def login
    @user = User.new
  end
  
  def authenticate
    @user = User.find_by_email(user_params[:email]).try(:authenticate, user_params[:password])
    if @user
      # Generate random code
      code = Random.new.rand(100000..999999)
      
      # Create 2FA Code
      tfas = Tfa.new(user_id: @user.id)
      tfas.tfa_password = code
      tfas.attepmted = 0
      tfas.save!
      
      # Send the code to email
      TfaMailer.tfa_confirmation(@user.email, code).deliver_now
      
      # Set cookie
      session[:user_id] = @user.id
      
      redirect_to verify_url, notice: 'An email with verification code has been sent to your email address. Please check your email and enter the code.'
    else
      @user = User.new(user_params)
      
      # Clear cookie
      session[:user_id] = nil
      
      flash.clear
      flash[:alert] = 'Email or password invalid.'
      render :login
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to :login, notice: 'Your account was successfully created.'
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
