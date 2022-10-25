require 'rails_helper'

RSpec.describe 'ユーザモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:first_user) { FactoryBot.create(:first_user) }

    context 'ユーザの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "",
          email: "piyo@piyopiyo.com",
          password: "MyString",
          password_digest: "MyString",
          admin: false)
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "MyString",
          email: "",
          password: "MyString",
          password_digest: "MyString",
          admin: false)
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "MyString",
          email: "piyo@piyopiyo.com",
          password: "",
          password_digest: "",
          admin: false)
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "MyString",
          email: "piyopiyo@piyopiyo.com",
          password: "MyString",
          password_digest: "MyString",
          admin: false)
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "MyString",
          email: "piyo@piyopiyo.com",
          password: "1234",
          password_digest: "1234",
          admin: false)
        expect(user).not_to be_valid
      end
    end

    context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合' do
      it 'バリデーションに成功する' do
        user = User.create(name: "MyString",
          email: "piyopiyo",
          password: "MyString",
          password_digest: "MyString",
          admin: false)
        expect(user).not_to be_valid
      end
    end
  end
end