module Pge
  module Mailinator
    class EmailPage
      include PageObject

      page_url 'https://mailinator.com/inbox2.jsp?public_to=<%= params[:username] %>'

      div(:email_from_putsmail, text: /putsmail@putsmail/)
      div(:draft_permission_email, text: 'Would you like to receive email drafts?')

      ## Find link in email body, which is in an iframe
      in_iframe(id: 'publicshowmaildivcontent') do |frame|
        link(:enable_draft, link_text: 'Yes, I’m happy to accept email drafts', frame: frame)
      end

      button(:back_to_inbox, title: 'Go!')

      ## Get the email body, again in an iframe
      in_iframe(id: 'publicshowmaildivcontent') do |frame|
        element(:the_mail_body, :body, frame: frame)
      end

      ## Get div accessor dynamically from subject
      def the_test_email_received?(subject)
        self.class.div(:test_email_subject, text: subject.join)
        self.test_email_subject?
      end

      def open_test_email(subject)
        self.class.div(:test_email_subject, text: subject.join)
        self.test_email_subject_element.click
      end
    end
  end
end