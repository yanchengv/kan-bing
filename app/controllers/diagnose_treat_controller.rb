class DiagnoseTreatController < ApplicationController
  skip_before_filter :verify_authenticity_token
        def create
            diagnose_treat_param={};
            diagnose_treat_param[:name]=params[:name]
            diagnose_treat_param[:doctor_id]=params[:doctor_id]
            diagnose_treat_param[:patient_id]=params[:patient_id]
            diagnose_treat_param[:create_time]=params[:create_time]
            diagnose_treat_param[:doctor_name]=params[:doctor_name]

            @diagnose_treat=DiagnoseTreat.new(diagnose_treat_param)
            @diagnose_treat.save

          render partial: 'patients/diagnose_treat'
        end
end
