class EcgController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show
      render partial:'health_records/ecg'
  end
end
