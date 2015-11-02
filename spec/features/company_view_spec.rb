require 'rails_helper'

describe 'the company view', type: :feature do
  let(:company) { Company.create(name: 'Vail Resorts') }

  describe 'the phone numbers view' do
    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-5678")
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: contact, contact_type: 'Company'))
    end

    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end
  end

  describe 'the email addresses view' do
    before(:each) do
      company.email_addresses.create(address: "johnsmith@gmail.com")
      company.email_addresses.create(address: "janedoe@gmail.com")
      visit company_path(company)
    end

    it "has an add email address link" do
      expect(page).to have_selector('li', text: 'johnsmith@gmail.com')
    end

    it 'adds a new email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'johnsmith@gmail.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('johnsmith@gmail.com')
    end

    it 'has links to edit email addresses' do
      company.email_addresses.each do |address|
        expect(page).to have_link('edit', href: edit_email_address_path(address))
      end
    end

    it 'edits a email address' do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'jimmysmith@gmail.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('jimmysmith@gmail.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has links to edit email addresses' do
      company.email_addresses.each do |address|
        expect(page).to have_link('delete', href: email_address_path(address))
      end
    end

    it 'deletes a email address' do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_email)
    end
  end
end
