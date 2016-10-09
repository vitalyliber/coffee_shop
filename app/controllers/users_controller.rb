class UsersController < Devise::OmniauthCallbacksController
  def vkontakte
    ap auth = request.env['omniauth.auth']

    @user = User.find_by(provider: auth.provider, uid: auth.uid)

    if @user.blank?
      @user = User.create(
          provider: auth.provider,
          uid: auth.uid,
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          email: "#{auth.uid}@mail.com"
      )
    end

    sign_in(@user)

    redirect_to points_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def after_omniauth_failure_path_for(_)
    flash.clear
    flash[:error] = :something_went_wrong
    root_path
  end
end
