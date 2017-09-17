Mail.defaults do
  retriever_method :pop3, :address    => "pop.yandex.ru",
                   :port       => 995,
                   :user_name  => ENV.fetch("MAIL_LOGIN"),
                   :password   => ENV.fetch("MAIL_PASS"),
                   :enable_ssl => true
end