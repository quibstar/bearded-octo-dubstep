class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_review_link(url, user_email, user)
    
    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = "#{current_environment}/reviews/#{url}"
    mail(from: email_with_name, cc:@user.email, to: user_email, subject: 'Please review content.')
  end

  def send_banner_link(url, user_email, user)

    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = "#{current_environment}/banner/#{url}"
    mail(from: email_with_name, cc:@user.email, to: user_email, subject: 'Please review content.')
  end
end
