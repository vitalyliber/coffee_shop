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

  private

  def after_omniauth_failure_path_for(_)
    flash.clear
    flash[:error] = 'Ошибка авторизации: разрешите приложению доступ к общей информации вашего аккаунта Вконтакте'
    root_path
  end
end
