class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_review_link(url, user_email, user)
    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = "http://adreview.teamddm.com/reviews/#{url}"
    mail(from: email_with_name, cc:@user.email, to: user_email, subject: 'Please review content.')
  end
end
