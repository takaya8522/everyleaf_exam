require 'rails_helper'

RSpec.describe 'ラベルモデル機能', type: :model do
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    @current_user = User.find_by(email: "adminadmino@piyopiyo.com")
  end
  
  describe 'バリデーションのテスト' do
    context 'ラベルの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        label = Label.create(name: "", user_id: @current_user.id)
        expect(label).not_to be_valid
      end
    end

    context 'ラベルの名前に値があった場合' do
      it 'バリデーションに成功する' do
        label = Label.create(name: "aaa", user_id: @current_user.id)
        expect(label).to be_valid
      end
    end
  end
end
