scheduler = Rufus::Scheduler.new

scheduler.every("20s") do
  User.all.each do |user|
    warning_tests = user.tests.warning_first
    if (warning_tests.count != 0)
      UserMailer.tests_warning(warning_tests, user).deliver_now
    end
  end
end