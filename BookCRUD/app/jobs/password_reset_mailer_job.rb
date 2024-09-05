class PasswordResetMailerJob < ApplicationJob
  queue_as :mailers

  def perform(user, token)
        Rails.logger.info "Performing password reset job for #{user.email}"
    UserMailer.reset_password_instructions(user, token).deliver_now
  end
end
