require 'spec_helper'

describe Pge do
  include PageObject::PageFactory

  it 'has a version number' do
    expect(Pge::VERSION).not_to be nil
  end

  it 'sends and receives email' do
    visit(Pge::PutsMail::HomePage).create_email

    user_name = Faker::Internet.user_name
    email = "#{user_name}@mailinator.com"
    subject = Faker::Lorem.words
    body = Faker::Lorem.paragraph

    ## Fill up the email form
    visit(Pge::PutsMail::NewEmailPage) do |page|
      page.recipient = email
      page.add_recipient
      page.subject = subject
      ## setValue is CodeMirror's method to fill the Code area
      page.execute_script("window.editor.setValue('#{body}')")
      page.send_email
    end

    ## Visit the email inbox
    visit(Pge::Mailinator::EmailPage, using_params: {username: user_name}) do |page|
      ## Check if there is a permission mail to enable draft emails
      if page.draft_permission_email?
        page.draft_permission_email_element.click
        ## Enable Draft Emails
        page.wait_until do
          page.enable_draft?
        end
        page.enable_draft
      end

      ## Refresh page after link is clicked to go back to the inbox page
      page.refresh

      ## Open the test email received
      page.wait_until(60, "Email not Received") do
        page.the_test_email_received?(subject)
      end
    end

    on(Pge::Mailinator::EmailPage) do |page|
      page.test_email_subject_element.click
      expect(page.the_mail_body).to eq(body)
    end
  end
end
