class ReviewMailer < ActionMailer::Base
  default from: "admin@adreview.teamddm.com"

  def send_review_link(url, user_email, user)
    
    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = "#{request.protocol + request.host}/reviews/#{url}"
    mail(from: email_with_name, cc:@user.email, to: user_email, subject: 'Please review content.')
  end

  def send_banner_link(url, user_email, user)

    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = "#{request.protocol + request.host}/banners/#{url}"
    mail(from: email_with_name, cc:@user.email, to: user_email, subject: 'Please review banner ad content.')
  end
end
