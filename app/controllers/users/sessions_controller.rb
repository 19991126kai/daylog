class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.create!(
      email: "guest_#{Time.now.to_i}#{rand(1000)}@example.com",
      password: SecureRandom.urlsafe_base64,
      guest: true
    )
    sign_in user
    redirect_to timer_path, notice: "ゲストとしてログインしました"
  end

  def destroy
    if current_user&.guest?
      current_user.destroy
    end
    super
  end
end
