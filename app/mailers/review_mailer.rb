class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_review_link(url, user_email)
    @url = "http://localhost:3000/reviews/#{url}"
    mail(to: user_email, subject: 'Please review content.')
  end
end
