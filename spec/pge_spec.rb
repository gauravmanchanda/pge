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

    # on(Pge::PutsMail::NewEmailPage)
    # fill out the form with the above email, subject and body
    # send email

    visit(Pge::Mailinator::HomePage) do |page|
      page.inbox = user_name
      page.go
    end

    #verify that there is an email present from putsmail.com
    #open that email and accept with the 'Yes....' link
    #verify that now there is an email that you sent
    #open the email

    # on(Pge::Mailinator::EmailPage) do |page|
    #   expect(page.email_body).to eq(paragraph)
    # end
  end
end
