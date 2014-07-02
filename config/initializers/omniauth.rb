Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weixin, Settings.weixin.app_id, Settings.weixin.app_secret
end
