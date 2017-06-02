class TfasController < ApplicationController
  def verify_2fa
    redirect_to login_url, alert: 'You must login first!' if !session[:user_id]
    
    @tfa = Tfa.new(user_id: session[:user_id]) unless !session[:user_id]
  end

  def verify_2fa_code
    @tfa = Tfa.find_by_user_id(tfa_params[:user_id])

    if (Time.current - @tfa.created_at) < 10
      flash.clear
      flash[:alert] = "Two Factor code attemps too soon!"
      render :verify_2fa
    elsif (Time.current - @tfa.created_at) > 120
        clear_session
        flash.clear
        flash[:alert] = "Two Factor code has been expired, please login again!"
        render :verify_message
        
    elsif @tfa.tfa_password == tfa_params[:tfa_code]
      clear_session
      flash.clear
      flash[:notice] = "Login successfully! Enjoy your time :)"
      render :verify_message
    else
      @tfa.attepmted += 1
      @tfa.save!
      
      if @tfa.attepmted > 2
        clear_session
        flash.clear
        flash[:alert] = "Account locked due to too many failed login attempts!"
        render :verify_message
      else
        flash.clear
        flash[:alert] = "The code is invalid. You've atempted #{@tfa.attepmted} #{"time".pluralize(@tfa.attepmted)}."
        render :verify_2fa
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def tfa_params
      params.require(:tfa).permit(:user_id, :tfa_code)
    end
    
    def clear_session
      # Clear everything for current session
      session[:user_id] = nil
      @tfa.destroy!
    end
end
