class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.tests_warning.subject
  #
  def tests_warning tests, user
    @greeting = "Hi #{user.username}"
    @tests = tests

    mail to: user.email, subject: "Ruby on Rails website warning"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.tests_deletion.subject
  #
  def tests_deletion
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
