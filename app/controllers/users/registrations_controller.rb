class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
      .merge(role: "normal_user")
  end
end
