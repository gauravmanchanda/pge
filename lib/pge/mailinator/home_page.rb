module Pge
  module Mailinator
    class HomePage
      include PageObject

      page_url 'https://mailinator.com/'

      text_field(:inbox, id: 'inboxfield')
      button(:go, text: 'Go!')
    end
  end
end