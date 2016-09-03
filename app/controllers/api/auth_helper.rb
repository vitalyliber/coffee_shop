module API
  module AuthHelper

    def warden
      env['warden']
    end

    def authenticated?
      if warden.authenticated?
        return true
      end
    end

    def current_user
      warden.user
    end

    def authenticate! 
      error!("401 Unauthorized", 401) unless authenticated?
    end

  end
end
