class EcgController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show
    p 1111
      render template:'health_records/ecg'
  end
end
