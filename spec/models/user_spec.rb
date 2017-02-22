require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = User.new(name: "Example User", email: "user@example.com", servings: 5,
                     password: "foobar", password_confirmation: "foobar")
  end

  it "should be a valid user" do
    expect(@user).to be_valid
  end

  it "should have a name present" do
    @user.name = " "
    expect(@user).not_to be_valid
  end

  it "should have an email present" do
    @user.email = " "
    expect(@user).not_to be_valid
  end

  it "should have a servings number present" do
    @user.servings = " "
    expect(@user).not_to be_valid
  end

  it "should have an integer as value" do 
    @user.servings = "a"
    expect(@user).not_to be_valid
  end

  it "should not have a name longer than 50 characters" do
    @user.name = "a" * 51
    expect(@user).not_to be_valid
  end

  it "should not have an email address longer than 255 characters" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).not_to be_valid
  end

  it "should accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "expected #{@user.email} to be valid!"
    end
  end

  it "should reject invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid, "expected #{@user.email} to be valid!"
    end
  end

  it "should have a unique email address" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).not_to be_valid
  end

  it "should save the email address as lower-case" do
    mixed_case_email = "FoO@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(@user.email).to eq(mixed_case_email.downcase), @user.reload.email
  end

  it "should have a nonempty password" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).not_to be_valid
  end

  it "should have a password longer than 5 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).not_to be_valid
  end

end
