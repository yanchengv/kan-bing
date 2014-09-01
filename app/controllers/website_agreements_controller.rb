class WebsiteAgreementsController < ApplicationController
  before_action :set_website_agreement, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user, except: [:show]
  layout 'mapp', :only => [:show]
  def show
    render 'doctors/show_agreement'
  end
  private
  def set_website_agreement
    @website_agreement = WebsiteAgreement.find(params[:id])
  end

  def website_agreement_params
    params.require(:website_agreement).permit(:id,:title,
                                              :doc_type,
                                              :content,
                                              :brief,
                                              :create_by_id,
                                              :create_by_name,
                                              :update_by_id,
                                              :update_by_name)
  end
end
