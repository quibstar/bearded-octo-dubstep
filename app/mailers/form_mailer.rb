class FormMailer < ActionMailer::Base
  default from: "admin@cheetahcms.com"
  
  def form_submit(form, fields)
    @form = form
    @fields = fields
    mail(:to => form.recipient, :subject => form.title)
  end
end
