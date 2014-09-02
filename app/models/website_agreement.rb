class WebsiteAgreement < ActiveRecord::Base
  include SessionsHelper
  before_create :set_pk_code
  attr_accessible :title,
                  :doc_type,
                  :content,
                  :brief,
                  :create_by_id,
                  :create_by_name,
                  :update_by_id,
                  :update_by_name

  def set_pk_code
    if self.id
      self.id = self.id.to_i
    else
      self.id = pk_id_rules
    end
  end
end
