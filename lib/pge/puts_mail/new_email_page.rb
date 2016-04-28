module Pge
  module PutsMail
    class NewEmailPage
      include PageObject

      page_url 'https://putsmail.com/tests/new'

      text_field(:recipient, id: 'recipient-value')
      button(:add_recipient, id: 'add-recipient')
      text_field(:subject, id: 'email_test_subject')
      link(:select_html_body, link_text: 'Plain Text')
      button(:send_email, text: 'Send Email')
    end
  end
end