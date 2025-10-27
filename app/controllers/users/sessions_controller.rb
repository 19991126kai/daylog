class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    guest = User.create_guest_with_samples!
    sign_in guest
    redirect_to categories_path, notice: "ゲストとしてログインしました", status: :see_other
  end

  def destroy
    if current_user&.guest?
      current_user.destroy
    end
    super
  end
end
