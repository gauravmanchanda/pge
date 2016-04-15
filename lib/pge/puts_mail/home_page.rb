module Pge
  module PutsMail
    class HomePage
      include PageObject

      page_url 'https://putsmail.com/'

      link(:create_email, link_text: 'Create a New Test Email')
    end
  end
end